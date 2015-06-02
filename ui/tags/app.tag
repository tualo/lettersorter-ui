<app>
  <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-collapse-1">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#"><i class="fa fa-envelope-o fa-lg"></i></a>
      </div>

      <div class="collapse navbar-collapse" id="bs-collapse-1">

        <ul class="nav navbar-nav">
          <li><a href="#" data-link="settings" onclick={ showClicked }>Settings</a></li>
          <li><a href="#" onclick={ inspect }>Inspect</a></li>
          <li><a href="#" onclick={ exit }>Exit</a></li>
        </ul>

      </div>
    </div>
  </nav>

  <br/>
  <br/>
  <br/>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-4">
        <ul class="list-group">
          <li each={ services }
              class="list-group-item list-group-item-{ running ? 'success' : 'danger' }"
              data-process="{command}"
              ondblclick={ parent.processClicked }
              onclick={ parent.showClicked }
          >
            <span class="badge">{ running ? 'ready' : 'closed' }</span>
            <i class="fa fa-{icon} fa-lg"></i>
            {title}
          </li>

        </ul>
      </div>
      <div class="col-md-8">

        <div class="panel panel-{ running ? 'success' : 'danger' }" each={ services } id="{command}">
          <div class="panel-heading">
            <h3 class="panel-title">{title}</h3>
          </div>
          <div class="panel-body">
            <p each={ messages }>
              {message}
              - {datetime}
            </p>
          </div>
        </div>

        <div class="panel panel-default" id="settings">
          <div class="panel-heading">
            <h3 class="panel-title">Settings</h3>
          </div>
          <div class="panel-body">
            <form>
              <div class="form-group">
                <label for="url">Url</label>
                <input type="url" class="form-control" id="url" placeholder="URL" value={url}>
              </div>
              <div class="form-group">
                <label for="client">Client</label>
                <input type="text" class="form-control" id="client" placeholder="Client" value={client}>
              </div>
              <div class="form-group">
                <label for="login">Login</label>
                <input type="text" class="form-control" id="login" placeholder="Login" value={login}>
              </div>
              <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" placeholder="Password" value={password}>
              </div>


              <div class="form-group">
                <label for="prefix">Prefix</label>
                <input type="text" class="form-control" id="prefix" placeholder="Prefix" value={prefix}>
              </div>

              <div class="form-group">
                <label for="broadcast">Broadcast</label>
                <input type="text" class="form-control" id="broadcast" placeholder="Broadcast" value={broadcast}>
              </div>


              <div class="form-group">
                <label for="height">Height</label>
                <input type="number" class="form-control" id="height" placeholder="Height" value={height}>
              </div>
              <div class="form-group">
                <label for="exposure">Exposure</label>
                <input type="number" class="form-control" id="exposure" placeholder="Exposure" value={exposure}>
              </div>
              <div class="form-group">
                <label for="mtu">MTU</label>
                <input type="number" class="form-control" id="mtu" placeholder="MTU" value={mtu}>
              </div>


              <button type="button" class="btn btn-default" onclick={saveSettings}>Save</button>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>

    this.current = "";


    showClicked(e){
      console.log(e);

      if (this.current!==""){
        $('#'+this.current).hide();
      }

      if (e.target.dataset.process){
        this.current = e.target.dataset.process;
        $('#'+this.current).show();
      }
      if (e.target.dataset.link){
        this.current = e.target.dataset.link;
        $('#'+this.current).show();
      }
    }

    getDB(){
      var db = openDatabase('lettersorter-ui', '1.0', 'lettersorter-ui', 2 * 1024 * 1024);
      db.transaction(function (tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS settings (id varchar(255) primary key, val varchar(255))');

        tx.executeSql('INSERT INTO settings (id, val) VALUES ("url", "https://localhost/macc/index.php")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("client", "macc")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("login", "sorter")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("password", "***")');


        tx.executeSql('INSERT INTO settings (id, val) VALUES ("prefix", "/imagedata/")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("height", "128")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("exposure", "500")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("broadcast", "127.0.0.255")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("mtu", "3000")');


      });
      return db;
    }

    saveSettings(e){
      console.log(e);
      var me=this;db = this.getDB();
      db.transaction(function (tx) {
        tx.executeSql('DELETE FROM settings');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("url", "https://localhost/macc/index.php")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("client", "macc")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("login", "sorter")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("password", "***")');


        tx.executeSql('INSERT INTO settings (id, val) VALUES ("prefix", "/imagedata/")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("height", "128")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("exposure", "500")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("broadcast", "127.0.0.255")');
        tx.executeSql('INSERT INTO settings (id, val) VALUES ("mtu", "3000")');


        tx.executeSql('UPDATE settings SET val=? WHERE id="url"',[$('#url').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="client"',[$('#client').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="login"',[$('#login').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="password"',[$('#password').val()]);

        tx.executeSql('UPDATE settings SET val=? WHERE id="prefix"',[$('#prefix').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="mtu"',[$('#mtu').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="height"',[$('#height').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="exposure"',[$('#exposure').val()]);
        tx.executeSql('UPDATE settings SET val=? WHERE id="broadcast"',[$('#broadcast').val()]);

        me.updateSettings();
      });
    }

    getSetting(name,cb){
      var db = this.getDB();
      db.transaction(function (tx) {
        tx.executeSql('SELECT * FROM settings where id = ?', [name], function (tx, results) {
          var len = results.rows.length;
          if (len===1){
            cb(null,results.rows.item(0).val);
          }else{
            cb('no result');
          }
        });
      });
    }
    global.getSetting = this.getSetting;

    var spawn = require('child_process').spawn;
    var path = require('path');

    this.url = '';
    this.client = '';
    this.login = '';
    this.password = '';

    this.broadcast = '127.0.0.1';
    this.exposure = '500';
    this.height = '128';
    this.mtu = '3000';
    this.prefix = '/OK/';

    updateSettings(){
      var me = this;
      me.getSetting('url',function(err,val){
        me.url = val;
        me.getSetting('client',function(err,val){
          me.client = val;
          me.getSetting('login',function(err,val){
            me.login = val;
            me.getSetting('password',function(err,val){
              me.password = val;


              me.services[0].arguments = [
                '--master',
                '--erp_url',
                me.url,
                '--erp_client',
                me.client,
                '--erp_login',
                me.login,
                '--erp_password',
                me.password
              ];

              me.getSetting('prefix',function(err,prefix){
                me.prefix=prefix;
                console.log(err,prefix);
                me.getSetting('height',function(err,height){
                  me.height=height;
                  me.getSetting('exposure',function(err,exposure){
                    me.exposure=exposure;
                    me.getSetting('broadcast',function(err,broadcast){
                      me.broadcast=broadcast;
                      me.getSetting('mtu',function(err,mtu){

                        me.services[1].arguments = [
                          '--mtu',mtu,
                          '--height',height,
                          '--imageing',
                          '--exposure',exposure,
                          '--broadcast',broadcast,
                          '--prefix',prefix
                        ];

                        me.services[2].arguments = [
                          "--path", prefix,
                          "--goodread",prefix+"good/",
                          "--badread",prefix+"bad/",
                          "--unclearread",prefix+"unclear/"
                        ];

                        riot.update();
                      })
                    })
                  })
                })
              })


            });
          });
        });

      });
    }

    this.services = [
      {
        icon: 'code-fork',
        title: 'Master-Service',
        running: false,
        messages: [],
        command: 'sorter',
        arguments: []
      },
      {
        icon: 'camera-retro',
        title: 'Kamera-Service',
        running: false,
        messages: [],
        command: 'gigecamera',
        arguments: []
      },
      {
        icon: 'barcode',
        title: 'OCR-Service',
        running: false,
        messages: [],
        command: 'ocrservice',
        arguments: []
      }
    ]


    inspect(e){
      require('nw.gui').Window.get().showDevTools();
    }

    exit(e){
      var gui = require('nw.gui');
      console.log(gui.App.argv);
      gui.App.quit();
      //gui.App.manifest.name
      //process.exit();
    }

    processByName(name){
      var me = this;
      for(var i=0;i<me.services.length;i++){
        if (me.services[i].command===name){
          return me.services[i];
          break;
        }
      }
      return null;
    }

    processClicked(e){
      var me = this,index;
      if (e.target.dataset.process){
        for(var i=0;i<me.services.length;i++){
          if (me.services[i].command===e.target.dataset.process){
            index=i;
            me.startService(index);
            break;
          }
        }
      }
    }


    delayedStart(e){
      var me = this;



      for(var i=0;i<me.services.length;i++){
        me.startService(i);
      }
      riot.update();
    }

    startService(index){
      var me = this;
      var name = me.services[index].command;
      if ((me.services[index]) && (me.services[index].running===false)){

        var proc = spawn(name, me.services[index].arguments );
        proc.on('error',function(error){
          console.log(name,error);
          me.services[index].running=false;
          riot.update();
        });
        proc.stdout.on('data', function (data) {
          console.log(name,'data',data.toString());
          var m = me.processByName(name).messages;
          m.reverse();
          m.push({
            datetime: new Date(),
            message: data.toString()
          });
          m.reverse();
          if (m.length>20){
            m=m.slice(0,20);
          }
          me.processByName(name).messages = m;
          riot.update();
        });
        proc.stderr.on('data', function (data) {
          console.log(name,'error',data.toString());


        });
        proc.on('message',function(message){
          console.log(name,'message',message);
        });
        proc.on('exit',function(){
          console.log(name,'exit',arguments);
          me.services[index].running=false;
          riot.update();
        });

        me.services[index].process = proc;
        me.services[index].running = true;

      }
    }
    var me=this;
    setTimeout(function(){
      $('#settings').hide();
      for(var i=0;i<me.services.length;i++){
        console.log(me.services[i].command,'hide');
        $('#'+me.services[i].command).hide();
      }
    },500);

    this.updateSettings();
    setTimeout(this.delayedStart,1000);

  </script>
</app>

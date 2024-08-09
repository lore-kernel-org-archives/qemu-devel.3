Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16C3C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 06:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scJ4w-0004Iq-Uf; Fri, 09 Aug 2024 02:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scJ4u-0004Gl-0i
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:26:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1scJ4r-0005P4-5Z
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 02:26:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 05D0A615C4;
 Fri,  9 Aug 2024 06:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43071C32782;
 Fri,  9 Aug 2024 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723184774;
 bh=r44vZJSWAK7TBXA7rJhj67/0NCf3mLf0LL0VYzZoYYU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=taoMr7mHUWcNZRehXcclF+8KzDooeolrpF7q4WZHLyIOTexR5mqD37vkO91mYMCUH
 XV2zR/ktUEWxpzwSEUHmhpzf9ZkQ6EWlUeeK/eh+XvXaVeGiBh5D3/korAAkbeONHk
 YKHG4rs8Fme5EulrE0wgH2xScyqwT+zOEIz7a2lFgbZDaTFQKRHrQHblBj9X6NV0F5
 1SScEGrsOQ5nC2O7ZJrfQK6uuZy8AIvJ6pMOusbWDn07XGG7ZbCEPqDqAL0WXALlpa
 7P+CbUdzCy9iwEL7xerMRvdFlPENNiD1XJTGIWUI5e7YlpzInp0YR11EO6ic988A9E
 Q8vKmiKbynNNw==
Date: Fri, 9 Aug 2024 08:26:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240809082609.1864eabe@foz.lan>
In-Reply-To: <20240809004137.01f97da2@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
 <CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
 <20240809004137.01f97da2@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Fri, 9 Aug 2024 00:41:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> > You should be able to use e.g.
> > 
> > legacy.py's QEMUMonitorProtocol class for synchronous connections, e.g.
> > 
> > from qemu.qmp.legacy import QEMUMonitorProtocol
> > 
> > qmp = QEMUMonitorProtocol((host, port))
> > qmp.connect(negotiate=True)  
> 
> That sounds interesting! I give it a try.

I applied the enclosed patch at the end of my patch series, but
somehow it is not working. For whatever reason, connect() is
raising a StateError apparently due to Runstate.CONNECTING.

I tried both as declaring (see enclosed patch):

	class qmp(QEMUMonitorProtocol)

and using:

-        super().__init__(self.host, self.port)
+        self.qmp_monitor = QEMUMonitorProtocol(self.host, self.port)

On both cases, it keeps waiting forever for a connection.

Regards,
Mauro

---

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index e9e9388bcb8b..62ca267cdc87 100644
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -9,9 +9,23 @@
 import socket
 import sys
 
+from os import path
+
+try:
+    qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
+    sys.path.append(path.join(qemu_dir, 'python'))
+
+    from qemu.qmp.legacy import QEMUMonitorProtocol
+    from qemu.qmp.protocol import StateError
+
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.")
+    print("Try export PYTHONPATH=top-qemu-dir/python or run from top-qemu-dir")
+    sys.exit(1)
+
 from base64 import b64encode
 
-class qmp:
+class qmp(QEMUMonitorProtocol):
     """
     Opens a connection and send/receive QMP commands.
     """
@@ -21,22 +35,20 @@ def send_cmd(self, command, may_open=False,return_error=True):
 
         if may_open:
             self._connect()
-        elif not self.socket:
-            return None
+        elif not self.connected:
+            return False
 
         if isinstance(command, dict):
             data = json.dumps(command).encode("utf-8")
         else:
             data = command.encode("utf-8")
 
-        self.socket.sendall(data)
-        data = self.socket.recv(1024)
         try:
-            obj = json.loads(data.decode("utf-8"))
-        except json.JSONDecodeError as e:
-            print(f"Invalid QMP answer: {e}")
-            self._close()
-            return None
+            obj = self.cmd_obj(command)
+        except Exception as e:
+            print("Failed to inject error: {e}.")
+
+        print(obj)
 
         if "return" in obj:
             if isinstance(obj.get("return"), dict):
@@ -46,86 +58,47 @@ def send_cmd(self, command, may_open=False,return_error=True):
             else:
                 return obj["return"]
 
-        elif isinstance(obj.get("error"), dict):
-            error = obj["error"]
-            if return_error:
-                print(f'{error["class"]}: {error["desc"]}')
-        else:
-            print(json.dumps(obj))
-
         return None
 
     def _close(self):
         """Shutdown and close the socket, if opened"""
-        if not self.socket:
+        if not self.connected:
             return
 
-        self.socket.shutdown(socket.SHUT_WR)
-        while 1:
-            data = self.socket.recv(1024)
-            if data == b"":
-                break
-            try:
-                obj = json.loads(data.decode("utf-8"))
-            except json.JSONDecodeError as e:
-                print(f"Invalid QMP answer: {e}")
-                self.socket.close()
-                self.socket = None
-                return
-
-            if isinstance(obj.get("return"), dict):
-                print(json.dumps(obj["return"]))
-            if isinstance(obj.get("error"), dict):
-                error = obj["error"]
-                print(f'{error["class"]}: {error["desc"]}')
-            else:
-                print(json.dumps(obj))
-
-        self.socket.close()
-        self.socket = None
+        self.close()
+        self.connected = False
 
     def _connect(self):
         """Connect to a QMP TCP/IP port, if not connected yet"""
 
-        if self.socket:
+        if self.connected:
             return True
 
-        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
-        try:
-            self.socket.connect((self.host, self.port))
-        except ConnectionRefusedError:
-            sys.exit(f"Can't connect to QMP host {self.host}:{self.port}")
-
-        data = self.socket.recv(1024)
-        try:
-            obj = json.loads(data.decode("utf-8"))
-        except json.JSONDecodeError as e:
-            print(f"Invalid QMP answer: {e}")
-            self._close()
-            return False
-
-        if "QMP" not in obj:
-            print(f"Invalid QMP answer: {data.decode('utf-8')}")
-            self._close()
-            return False
+        is_connecting = True
+        while is_connecting:
+            try:
+                ret = self.connect(negotiate=True)
+                self.accept()
+                is_connecting = False
+            except ConnectionError:
+                sys.exit(f"Can't connect to QMP host {self.host}:{self.port}")
+                return False
+            except StateError as e:
+                print(f"StateError: {e}")
 
-        result = self.send_cmd('{ "execute": "qmp_capabilities" }')
-        if not result:
-            self._close()
-            return False
+        self.connected = True
 
         return True
 
     def __init__(self, host, port, debug=False):
         """Initialize variables used by the QMP send logic"""
 
-        self.socket = None
+        self.connected = False
         self.host = host
         self.port = port
         self.debug = debug
 
-    def __del__(self):
-        self._close()
+        super().__init__(self.host, self.port)
 
     #
     # Socket QMP send command
@@ -168,8 +141,12 @@ def send_cper(self, guid, data):
 
         self._connect()
 
-        if self.send_cmd(command):
-            print("Error injected.")
+        try:
+            self.cmd_obj(command)
+        except Exception as e:
+            print("Failed to inject error: {e}.")
+
+        print("Error injected.")
 
     def search_qom(self, path, prop, regex):
         """
@@ -180,8 +157,9 @@ def search_qom(self, path, prop, regex):
             ...
         """
 
-        found = []
+        self._connect()
 
+        found = []
         i = 0
         while 1:
             dev = f"{path}[{i}]"
@@ -192,7 +170,11 @@ def search_qom(self, path, prop, regex):
                     'property': prop
                 }
             }
-            ret = self.send_cmd(cmd, may_open=True, return_error=False)
+            try:
+                ret = self.cmd_obj(cmd)
+            except Exception as e:
+                print("Failed to inject error: {e}.")
+
             if not ret:
                 break
 



Thanks,
Mauro


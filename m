Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07186C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuARy-0007zf-Fb; Sun, 22 Feb 2026 09:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARh-0007y8-1e
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARe-0006ez-MS
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGKrtZ65eeoh5VAdeDsU+0l7R0P7GOEKpcj1zRC00bg=;
 b=g27jauuV7gMUxtg/O6/m7eRwV6FauRxBEHdDjqjGatFURBVOy1kK8IdyNlgvdxQlU+bZeG
 5+IHeFoJpVcvxbJPtW/uha6293UxZ2f/KzsMkxWRm2FWu12lTeL/mbcP3fYQ31+4FdkuQQ
 T6m4MUz14tGfXf4HoAMLlCo0drKSnYE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-n01onvEXMvynTfdmg8QR0A-1; Sun, 22 Feb 2026 09:28:24 -0500
X-MC-Unique: n01onvEXMvynTfdmg8QR0A-1
X-Mimecast-MFC-AGG-ID: n01onvEXMvynTfdmg8QR0A_1771770503
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4376761037bso2954019f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770502; x=1772375302; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eGKrtZ65eeoh5VAdeDsU+0l7R0P7GOEKpcj1zRC00bg=;
 b=WsoDUwcVxUHLeeAYTxfW/UhV32NiAvSnanRyAQnzBreaXMPacZzAWQYSsSiagLkNKk
 vBn3/wQiKvJ0DjSxqTv9wD9yBFMaTo3FHM0KjkyrCYkKj1c/MEiq7r1hlFgmuYq622Ng
 Q6IqXPkGOzp4CmzniWLBBp4/7k3/bJnBdKVvAvID0Cs+Me3ZqbBfuT6j245ztYSJBBZU
 HBxy8hwEAHwO/WlTlrn8uCPTGcaSDzYicpFwAcA7+47M53z86TDyzWtDQoryKO4cMq7J
 61l+214joh+avJ/61ndAEczTrtD8df6aEG/4ZdJ7up8uTJXTGnq4Cp7PvMj7A+hnG7XR
 pJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770502; x=1772375302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGKrtZ65eeoh5VAdeDsU+0l7R0P7GOEKpcj1zRC00bg=;
 b=s5eWaJvRJV08XFLAyztggEn32tcqWdgQdByuJc8APdgHooYOv2uHk4LCdaI8LZyPt9
 Y9MAWyUn+wo7VYFzaGcrScoaRpGIChI8rSk6DmSZvVenNb6swRSgNmEHaNbgH5+Zrk36
 0aNy08U8MJznvAUBrneRQFzbd+On4RH9KbxRMcFcmFWHOs8/zeYqEVc9T+2X+S3JxXa1
 8ChG+LPubyz6Vi5ISk1lzZZWeFOy6d4dU1NpbUesMug2Uc6Dq0CajfDQrR+AySsO1wNq
 2XPLkEvUCULe8FrkGJFyCAXyN+gBIbfFCar9Pb20iUjqr7SgAcDYsYejZNqi9lwZcWpD
 c/XQ==
X-Gm-Message-State: AOJu0YykjW7lVsXLUin49VZMh3A+4S+TDUsTpogMb6Sx09E/KBHw3iho
 Rp7jxEOGYpq2zsXOJGIUgp8nvbiT7Q58G5vcuTuLJ5V72bOcvFZeyX+LLWfD2GVJqWmJ5VVSAx3
 9cS8YHr5xScSsn3pjTt8ZalUh72YnhTAykUvpj+qRTP9KLVlvCOjCueLSyuOsfWI2XoiTfhYNmH
 uQDYr8N5vSoEWAMmEFRDCEoyxqCo74kZRLwg==
X-Gm-Gg: AZuq6aLUjJZV/5NrGerQ5IKqkidm96AYR1LLLviM4Z47fF/4+EON+ve5RKHpvDue7S0
 V6RwSJj4E7C38E4XRdYnhTg35bvx0rmXrsKVmeWpZyyGiz+1eUu/8QKVVamojFoYZCrM2zZiZWY
 HNU9roMhzEZV1O6LMs48wEt+ibvsarkoHV3pAZBOG+Ds5FTPc1R5PfgHcebnHWFf/yMOuE5t30h
 UEdWJqPQE8OPSJhr5eC2+s7oGb3w/vGuhqoNUgJPk+Sbu0/tJ3sXxzODzQ0HF7EEdrAbpXwdY2u
 CD/QY3tuqqEj/DsGigISk/wSbpfZxKXqONyTeyLfWMdWIzLsfcSp8FLPjmTR296MYj3V4YH2acZ
 I820cUGa2WtyQpSggnhj2aWh0WSJ3UNaOGrZUsXqmVhenbg==
X-Received: by 2002:a05:6000:2385:b0:436:8f7e:a486 with SMTP id
 ffacd0b85a97d-4396fda980fmr9804251f8f.11.1771770502315; 
 Sun, 22 Feb 2026 06:28:22 -0800 (PST)
X-Received: by 2002:a05:6000:2385:b0:436:8f7e:a486 with SMTP id
 ffacd0b85a97d-4396fda980fmr9804201f8f.11.1771770501599; 
 Sun, 22 Feb 2026 06:28:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9ff5sm13445374f8f.4.2026.02.22.06.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:21 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 02/33] tests/functional/x86_64: Add vhost-user-bridge test
Message-ID: <051364b36b2c68058f7e6d2204ef2a877b0bb221.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yodel Eldar <yodel.eldar@yodel.dev>

Introduce a functional test of vhost-user-bridge and enter it into
MAINTAINERS under the vhost section.

The test runs vhost-user-bridge as a subprocess, then launches a guest
with four backends: a unix domain socket for vhost-user, a UDP socket, a
user-mode net, and a hubport to hub the UDP and user backends; only the
vhost-user backend is exposed, the rest are deviceless. This
configuration mimics the testing setup described in the initial commit
of vhost-user-bridge in 3595e2eb0a23.

The test creates a scratch file containing a hardcoded UUID on the host
and exposes it to the the guest via the tftp parameter of the user
netdev. After the guest invokes tftp to request the file, the test
verifies the transfer by hashsum.

Similarly, the test creates a file with another hardcoded UUID in the
guest. A call to check_http_download() serves the file to the host via
http, whereupon a check of the file hashsum occurs on the host.

Lastly, add the test to the thorough tests suite in meson.build.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260129133049.119829-3-yodel.eldar@yodel.dev>
---
 MAINTAINERS                                   |   1 +
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vhost_user_bridge.py          | 147 ++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c481e212..8df82f313e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2406,6 +2406,7 @@ F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
 F: net/vhost*
+F: tests/functional/x86_64/test_vhost_user_bridge.py
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index f78eec5e6c..beab4f304b 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -34,6 +34,7 @@ tests_x86_64_system_thorough = [
   'reverse_debug',
   'tuxrun',
   'vfio_user_client',
+  'vhost_user_bridge',
   'virtio_balloon',
   'virtio_gpu',
 ]
diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
new file mode 100755
index 0000000000..c36c625420
--- /dev/null
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -0,0 +1,147 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Software Freedom Conservancy, Inc.
+#
+# Author: Yodel Eldar <yodel.eldar@yodel.dev>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Test vhost-user-bridge (vubr) functionality:
+
+    1) Run vhost-user-bridge on the host.
+    2) Launch a guest VM:
+        a) Instantiate a unix domain socket to the vubr-created path
+        b) Instantiate a vhost-user backend on top of that socket
+        c) Map a virtio-net-pci device to the vhost-user backend
+        d) Instantiate a UDP socket backend
+        e) Instantiate a user-mode net backend
+            i) Forward an ephemeral port to port 8080 in-guest with hostfwd=
+            ii) Expose a generated scratch file to the guest with tftp=
+        f) Hub the UDP and user-mode backends.
+    3) Invoke tftp in the guest to download exported scratch file from the host.
+    4) Serve a file to the host via http server in the guest.
+"""
+
+import os
+import shutil
+import subprocess
+from qemu_test import Asset, LinuxKernelTest, which
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import is_readable_executable_file
+from qemu_test import wait_for_console_pattern
+from qemu_test.ports import Ports
+
+class VhostUserBridge(LinuxKernelTest):
+
+    ASSET_KERNEL_INITRAMFS = Asset(
+        "https://github.com/yodel/vhost-user-bridge-test/raw/refs/heads/main/bzImage",
+        "8860d7aa59434f483542cdf25b42eacae0d4d4aa7ec923af9589d1ad4703d42b")
+
+    HOST_UUID = "ba4c2e39-627f-487d-ae3b-93cc5d783eb8"
+    HOST_UUID_HSUM = \
+        "d2932e34bf6c17b33e7325140b691e27c191d9ac4dfa550f68c09506facb09b9"
+
+    GUEST_UUID = "143d2b21-fdf0-4c5e-a9ef-f35ebbac8945"
+    GUEST_UUID_HSUM = \
+        "14b64203f5cf2afe520f8be0fdfe630aafc1e85d1301f55a0d1681e68881f3a2"
+
+    def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
+        self.require_accelerator("kvm")
+        self.require_netdev("vhost-user")
+        self.require_netdev("socket")
+        self.require_netdev("hubport")
+        self.require_netdev("user")
+        self.require_device("virtio-net-pci")
+        self.set_machine("q35")
+        self.vm.add_args(
+            "-cpu",      "host",
+            "-accel",    "kvm",
+            "-append",   "printk.time=0 console=ttyS0",
+            "-smp",      "2",
+            "-m",        "128M",
+            "-object",   "memory-backend-memfd,id=mem0,"
+                         "size=128M,share=on,prealloc=on",
+            "-numa",     "node,memdev=mem0",
+            "-chardev", f"socket,id=char0,path={ud_socket_path}",
+            "-netdev",   "vhost-user,id=vhost0,chardev=char0,vhostforce=on",
+            "-device",   "virtio-net-pci,netdev=vhost0",
+            "-netdev",  f"socket,id=udp0,udp=localhost:{lport},"
+                        f"localaddr=localhost:{rport}",
+            "-netdev",   "hubport,id=hub0,hubid=0,netdev=udp0",
+            "-netdev",  f"user,id=user0,tftp={tftpdir},"
+                        f"hostfwd=tcp:127.0.0.1:{hostfwd_port}-:8080",
+            "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
+        )
+
+    def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
+        vubr_args = []
+
+        if (stdbuf_path := which("stdbuf")) is None:
+            self.log.info("Could not find stdbuf: vhost-user-bridge "
+                          "log lines may appear out of order")
+        else:
+            vubr_args += [stdbuf_path, "-o0", "-e0"]
+
+        vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
+                      "-l", f"127.0.0.1:{lport}", "-r", f"127.0.0.1:{rport}"]
+
+        return vubr_args
+
+    def test_vhost_user_bridge(self):
+        prompt = "~ # "
+        host_uuid_filename = "vubr-test-uuid.txt"
+        guest_uuid_path = "/tmp/uuid.txt"
+        kernel_path = self.ASSET_KERNEL_INITRAMFS.fetch()
+
+        vubr_path = self.build_file("contrib", "vhost-user-bridge",
+                                    "vhost-user-bridge")
+        if not is_readable_executable_file(vubr_path):
+            self.skipTest("Could not find a readable and executable "
+                          "vhost-user-bridge")
+
+        vubr_log_path = self.log_file("vhost-user-bridge.log")
+        self.log.info("For the vhost-user-bridge application log,"
+                     f" see: {vubr_log_path}")
+
+        sock_dir = self.socket_dir()
+        ud_socket_path = os.path.join(sock_dir.name, "vubr-test.sock")
+
+        tftpdir = self.scratch_file("tftp")
+        shutil.rmtree(tftpdir, ignore_errors=True)
+        os.mkdir(tftpdir)
+        host_uuid_path = self.scratch_file("tftp", host_uuid_filename)
+        with open(host_uuid_path, "w", encoding="utf-8") as host_uuid_file:
+            host_uuid_file.write(self.HOST_UUID)
+
+        with Ports() as ports:
+            # pylint: disable=unbalanced-tuple-unpacking
+            lport, rport, hostfwd_port = ports.find_free_ports(3)
+
+            self.configure_vm(ud_socket_path, lport, rport, hostfwd_port,
+                              tftpdir)
+
+            vubr_args = self.assemble_vubr_args(vubr_path, ud_socket_path,
+                                                lport, rport)
+
+            with open(vubr_log_path, "w", encoding="utf-8") as vubr_log, \
+                 subprocess.Popen(vubr_args, stdin=subprocess.DEVNULL,
+                                  stdout=vubr_log,
+                                  stderr=subprocess.STDOUT) as vubr_proc:
+                self.launch_kernel(kernel_path, wait_for=prompt)
+
+                exec_command_and_wait_for_pattern(self,
+                    f"tftp -g -r {host_uuid_filename} 10.0.2.2 ; "
+                    f"sha256sum {host_uuid_filename}", self.HOST_UUID_HSUM)
+                wait_for_console_pattern(self, prompt)
+
+                exec_command_and_wait_for_pattern(self,
+                    f"echo -n '{self.GUEST_UUID}' > {guest_uuid_path}", prompt)
+                self.check_http_download(guest_uuid_path, self.GUEST_UUID_HSUM)
+                wait_for_console_pattern(self, prompt)
+
+                self.vm.shutdown()
+                vubr_proc.terminate()
+                vubr_proc.wait()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
MST



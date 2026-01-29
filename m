Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADE5D61011
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlS8F-0007tu-6A; Thu, 29 Jan 2026 08:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vlS7S-0007bN-C0
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:31:44 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vlS7P-0002KG-85
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:31:33 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6407dfe53d2a0b3d7f8ac5f53fdcedf683ffe6e3a11d22dd7b1943316ba8d53a with SMTP id
 697b6125834a10b0f0b46579; Thu, 29 Jan 2026 13:31:17 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1769693477;
 bh=kgquQpF2g+PzRJvMQiQu1Tdx631FtZ+L4+iJOqwiLJg=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
 From:Reply-to:Subject:Date:Message-id:To:Cc:Mime-version:
 Content-type:Content-transfer-encoding:In-reply-to:References;
 b=nmTnGHD1rtHaOIiiKPsJ7FBdRoM/itkb0aVUEUpSifRrRWp7sAxyN5utCvp0FjLMh
 ASalMlHuyvx7WQ5pvpWUyLAAfB53SfW1gvVTdp/z4yyHwn0E+d0B3wbnmRVqe7khBr
 pjZtdsIDjbVYlhDKqP+mr9jtnW6SRmwZM5dcneGeKb9n/a7h7Y2kyB55kfPo0L2pEt
 G/5H+iVp8QAnlk365iw5XIXg6o9dm/I93W4tihDPHR4LxzAUT86hG2Hi0CepTxfmqh
 rt6L+R8nNV1B1mG2lO78ECG7oKT3xEbvZuKzLdTgGL8KV0N6Sxmp71g5SN23ybXyrd
 /TANtDLFoDZ9Q==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v4 1/3] tests/vhost-user-bridge: Move to
 contrib/vhost-user-bridge/
Date: Thu, 29 Jan 2026 07:30:47 -0600
Message-ID: <20260129133049.119829-2-yodel.eldar@yodel.dev>
In-Reply-To: <20260129133049.119829-1-yodel.eldar@yodel.dev>
References: <20260129133049.119829-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After the introduction of vhost-user-bridge and libvhost-user, we
formed the convention of placing vhost-user daemons in eponymous subdirs
of contrib/. Follow this convention.

Create a contrib/vhost-user-bridge/ directory and move vhost-user-bridge
into it. Extract its build target definition from tests/meson.build into
the new directory, and include its subdir in the root-level meson.build.

Add a section about it in the "vhost-user daemons in contrib" document.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/meson.build         |  4 ++
 .../vhost-user-bridge}/vhost-user-bridge.c    |  0
 .../devices/virtio/vhost-user-contrib.rst     | 39 +++++++++++++++++++
 meson.build                                   |  1 +
 tests/meson.build                             |  6 ---
 5 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/meson.build
 rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (100%)

diff --git a/contrib/vhost-user-bridge/meson.build b/contrib/vhost-user-bridge/meson.build
new file mode 100644
index 0000000000..aa58c1df20
--- /dev/null
+++ b/contrib/vhost-user-bridge/meson.build
@@ -0,0 +1,4 @@
+if have_tools and have_vhost_user and host_os == 'linux'
+  executable('vhost-user-bridge', files('vhost-user-bridge.c'),
+             dependencies: [qemuutil, vhost_user], install: false)
+endif
diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
similarity index 100%
rename from tests/vhost-user-bridge.c
rename to contrib/vhost-user-bridge/vhost-user-bridge.c
diff --git a/docs/system/devices/virtio/vhost-user-contrib.rst b/docs/system/devices/virtio/vhost-user-contrib.rst
index 48d04d2ade..660d29a700 100644
--- a/docs/system/devices/virtio/vhost-user-contrib.rst
+++ b/docs/system/devices/virtio/vhost-user-contrib.rst
@@ -85,3 +85,42 @@ vhost-user-scsi - SCSI controller
 
 The vhost-user-scsi daemon can proxy iSCSI devices onto a virtualized
 SCSI controller.
+
+.. _vhost_user_bridge:
+
+vhost-user-bridge - Network bridge
+==================================
+
+The vhost-user-bridge daemon serves as a development tool for testing real
+internet traffic by providing a networking backend, i.e. server, for the
+vhost-user protocol.
+
+Example
+-------
+For a single QEMU instance that both runs the user-mode net stack (slirp) and
+serves as a vhost-user protocol frontend, i.e. client, simultaneously:
+
+First, start vhost-user-bridge:
+
+::
+
+  $ vhost-user-bridge -u /tmp/vubr.sock \
+                      -l 127.0.0.1:4444 \
+                      -r 127.0.0.1:5555
+
+Then, invoke QEMU:
+
+::
+
+  $ qemu-system-x86_64 \
+        -m 4G \
+        -object memory-backend-memfd,id=mem0,size=4G,share=on,prealloc=on \
+        -numa node,memdev=mem0 \
+        -chardev socket,id=char0,path=/tmp/vubr.sock \
+        -netdev vhost-user,id=vhost0,chardev=char0,vhostforce=on \
+        -device virtio-net-pci,netdev=vhost0 \
+        -netdev socket,id=udp0,udp=localhost:4444,localaddr=localhost:5555 \
+        -netdev user,id=user0 \
+        -netdev hubport,id=hub0,hubid=0,netdev=udp0 \
+        -netdev hubport,id=hub1,hubid=0,netdev=user0 \
+        ...
diff --git a/meson.build b/meson.build
index cc0dfed066..bca61aae65 100644
--- a/meson.build
+++ b/meson.build
@@ -4494,6 +4494,7 @@ if have_tools
 
   if have_vhost_user
     subdir('contrib/vhost-user-blk')
+    subdir('contrib/vhost-user-bridge')
     subdir('contrib/vhost-user-gpu')
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
diff --git a/tests/meson.build b/tests/meson.build
index cbe7916241..87861b2857 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -70,12 +70,6 @@ test_deps = {
   'test-qht-par': qht_bench,
 }
 
-if have_tools and have_vhost_user and host_os == 'linux'
-  executable('vhost-user-bridge',
-             sources: files('vhost-user-bridge.c'),
-             dependencies: [qemuutil, vhost_user])
-endif
-
 subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
-- 
2.52.0



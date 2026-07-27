Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F3C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOfe-0001cL-88; Mon, 27 Jul 2026 12:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woOf6-0001XK-GV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:58:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woOf4-0006ed-RJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:58:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso19698275e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785171520; x=1785776320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D0oNf+HlrNiDb2XUQ8Yx+LPXLSbqI3lxt5Zg1i+vczc=;
 b=orqufW+UiEAs3XWD0+1kghmtCUt2BUgLGjuG5D7GRfqtt5o+tTaqbiw7fhqGwD6m33
 bzXvjTpczVw5gxg7pxGWDANR8aim+H3SQCXk4KDg+zoO2IdPdBFUxeeXZfbKeJsfz5+/
 QvDaRIdPD+1FFO+r1bC13X5jwWrLdyOUimBkt2tKdP2y6wZ2XwDXGVXj0jM/0uijr/fm
 SFBgB1wTP+xVRdqbn43jHCOpwuUs/O3NolMER1N0ml1K2dmo7SeICdOE8O8Y1y6p2SWC
 hqO2LSs5TVhZQ/P75QFmRCCJiKOAbDDaVmoPOTYXC+HA8g/p2+4CBKtn/dAvy2ZxmFLi
 EbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785171520; x=1785776320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D0oNf+HlrNiDb2XUQ8Yx+LPXLSbqI3lxt5Zg1i+vczc=;
 b=MuCqY0H5RYAXhkbpvzivaPjhoHvJKuiaQc+XbT+RMrPWi3VwpNi5eQwm0AIP6Su/EC
 MrSyf0A9l0ILfefc54GggcevuQwCNDlJiMTZKsnOzQJE3bFK95qqL+6sSs51Lw7Wgt56
 GbzjdFQkRycezePNZ4DhsSvVpDJFDjYNrDV++nen0U4ee2/aHsLP/vMiSDmh4g64vLr7
 oTj7bVOfcNvfCnyumgkEUlVfUY3kwcMVF9x/ESRcrz/uPJHDV5pOHbLuYy+lgqYa4j6J
 X9VVpOLbjfWkWjkH/ZofRHeKKjFKbrdhuMHxBBLlBoiDshTsk//OY9xcM8z6CWXHyDrJ
 kIlg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1uBHiR4JAiU5rD5lYOxZygd6iImK+NzRHO6SAxK7+sVUKpjY7YdXnhjEWdhnBeHZ5yWWbX48GhfxV@nongnu.org
X-Gm-Message-State: AOJu0Yy1ldhYL39f+8KZKBqWwbycBd68EVYWyAvDW8gN0SZdNbAhuLQv
 UgHK42cG3SsWo6q+0+JEbMyD+oRGtFkHikN4lNYHcqoy6Y8kEe1DttTK
X-Gm-Gg: AR+sD13v06CuawwWdMES3iaoLAq6bEKHiu7r3akHV0X4R0Kt+6FbsrMcdne4L9AubPF
 WjVn1a/vLfZGlotbK9vA9EgJddJvt1yLTVG5Qxz2jGRI2T1sV9c0hHLTFjhr6WD6DFvI4injRPM
 rKNPsUlJNMmLKFu33394D8UM2hyoyX7HUwwCvWvcIn7oaJBCUIMdXHALVBklsuQXUaZiZuZTX6x
 PPO/yG66te6oTmb/uVVhiD1UwBCQTr6IR4Njug5VIZWxvKrku4WjhUv/7+z0FWekk32Rrsyxnrm
 eAmgvxPPDaI/hYMmtQmR1X/GPttJK7qcd5LuUI2lX+8XUwI+bE4h3DxXaO9cvNVeTwdbpLO+/wG
 duYgO8Fr6l9GEcqJM8q54EZJs+xF4wcsxjvSDfRln3d1PRkP+Jbmm+QneVkWfatmM42Hx33UG6r
 N9YRDVHmB6TwpDeddWL0EkwpzP5TXE3IgbKnTr1DzbnV51veFZgErFpd/6wmQzQ13cD1dQcHAxF
 a95xgfawg7H7Z8Za5/6TQEfocTXOQXMzbYNIwwiJ5Tepj3FFdT7wo+B7JhHvw==
X-Received: by 2002:a05:600c:3113:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-496b57013f0mr116191045e9.17.1785171520018; 
 Mon, 27 Jul 2026 09:58:40 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd77a9sm47826602f8f.14.2026.07.27.09.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:58:39 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 1/2] qapi/block-core: gate protocol block drivers behind their
 CONFIG symbols
Date: Mon, 27 Jul 2026 16:58:32 +0000
Message-ID: <20260727165833.107915-1-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

BlockdevDriver enumerates every block driver and is exposed through
query-qmp-schema so that management tools can discover which drivers a
QEMU binary supports.  Some members are already gated with 'if'
conditionals (replication, the CONFIG_BLKIO virtio-blk drivers, the
host-device drivers) so that they only appear when actually compiled in.

The protocol drivers backed by an external library were not gated: ftp,
ftps, http and https (curl), iscsi (libiscsi), nfs (libnfs), rbd (librbd)
and ssh (libssh).  When QEMU is built without the corresponding library
the driver is not registered -- it is absent from "-drive format=help"
and attempts to use it fail with "Unknown driver" -- yet
query-qmp-schema still advertises it, so management layers are told a
driver is available when it is not.

Gate these enum members, and their branches in the BlockdevOptions and
BlockdevCreateOptions unions, with the CONFIG_* symbols that already
control whether the drivers are built (CONFIG_CURL, CONFIG_LIBISCSI,
CONFIG_LIBNFS, CONFIG_RBD, CONFIG_LIBSSH).  query-qmp-schema now reflects
the protocol drivers actually present in the binary.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 qapi/block-core.json | 52 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f87b07850..1087c2cbd4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3339,18 +3339,25 @@
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
             'cloop', 'compress', 'copy-before-write', 'copy-on-read', 'dmg',
-            'file', 'snapshot-access', 'ftp', 'ftps',
+            'file', 'snapshot-access',
+            { 'name': 'ftp', 'if': 'CONFIG_CURL' },
+            { 'name': 'ftps', 'if': 'CONFIG_CURL' },
             {'name': 'host_cdrom', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
             {'name': 'host_device', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
-            'http', 'https',
+            { 'name': 'http', 'if': 'CONFIG_CURL' },
+            { 'name': 'https', 'if': 'CONFIG_CURL' },
             { 'name': 'io_uring', 'if': 'CONFIG_BLKIO' },
-            'iscsi',
-            'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme',
+            { 'name': 'iscsi', 'if': 'CONFIG_LIBISCSI' },
+            'luks', 'nbd',
+            { 'name': 'nfs', 'if': 'CONFIG_LIBNFS' },
+            'null-aio', 'null-co', 'nvme',
             { 'name': 'nvme-io_uring', 'if': 'CONFIG_BLKIO' },
             'parallels', 'preallocate', 'qcow', 'qcow2', 'qed', 'quorum',
-            'raw', 'rbd',
+            'raw',
+            { 'name': 'rbd', 'if': 'CONFIG_RBD' },
             { 'name': 'replication', 'if': 'CONFIG_REPLICATION' },
-            'ssh', 'throttle', 'vdi', 'vhdx',
+            { 'name': 'ssh', 'if': 'CONFIG_LIBSSH' },
+            'throttle', 'vdi', 'vhdx',
             { 'name': 'virtio-blk-vfio-pci', 'if': 'CONFIG_BLKIO' },
             { 'name': 'virtio-blk-vhost-user', 'if': 'CONFIG_BLKIO' },
             { 'name': 'virtio-blk-vhost-vdpa', 'if': 'CONFIG_BLKIO' },
@@ -4843,20 +4850,26 @@
       'copy-on-read':'BlockdevOptionsCor',
       'dmg':        'BlockdevOptionsGenericFormat',
       'file':       'BlockdevOptionsFile',
-      'ftp':        'BlockdevOptionsCurlFtp',
-      'ftps':       'BlockdevOptionsCurlFtps',
+      'ftp':        { 'type': 'BlockdevOptionsCurlFtp',
+                      'if': 'CONFIG_CURL' },
+      'ftps':       { 'type': 'BlockdevOptionsCurlFtps',
+                      'if': 'CONFIG_CURL' },
       'host_cdrom':  { 'type': 'BlockdevOptionsFile',
                        'if': 'HAVE_HOST_BLOCK_DEVICE' },
       'host_device': { 'type': 'BlockdevOptionsFile',
                        'if': 'HAVE_HOST_BLOCK_DEVICE' },
-      'http':       'BlockdevOptionsCurlHttp',
-      'https':      'BlockdevOptionsCurlHttps',
+      'http':       { 'type': 'BlockdevOptionsCurlHttp',
+                      'if': 'CONFIG_CURL' },
+      'https':      { 'type': 'BlockdevOptionsCurlHttps',
+                      'if': 'CONFIG_CURL' },
       'io_uring':   { 'type': 'BlockdevOptionsIoUring',
                       'if': 'CONFIG_BLKIO' },
-      'iscsi':      'BlockdevOptionsIscsi',
+      'iscsi':      { 'type': 'BlockdevOptionsIscsi',
+                      'if': 'CONFIG_LIBISCSI' },
       'luks':       'BlockdevOptionsLUKS',
       'nbd':        'BlockdevOptionsNbd',
-      'nfs':        'BlockdevOptionsNfs',
+      'nfs':        { 'type': 'BlockdevOptionsNfs',
+                      'if': 'CONFIG_LIBNFS' },
       'null-aio':   'BlockdevOptionsNull',
       'null-co':    'BlockdevOptionsNull',
       'nvme':       'BlockdevOptionsNVMe',
@@ -4869,11 +4882,13 @@
       'qed':        'BlockdevOptionsGenericCOWFormat',
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
-      'rbd':        'BlockdevOptionsRbd',
+      'rbd':        { 'type': 'BlockdevOptionsRbd',
+                      'if': 'CONFIG_RBD' },
       'replication': { 'type': 'BlockdevOptionsReplication',
                        'if': 'CONFIG_REPLICATION' },
       'snapshot-access': 'BlockdevOptionsGenericFormat',
-      'ssh':        'BlockdevOptionsSsh',
+      'ssh':        { 'type': 'BlockdevOptionsSsh',
+                      'if': 'CONFIG_LIBSSH' },
       'throttle':   'BlockdevOptionsThrottle',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
@@ -5543,13 +5558,16 @@
   'data': {
       'file':           'BlockdevCreateOptionsFile',
       'luks':           'BlockdevCreateOptionsLUKS',
-      'nfs':            'BlockdevCreateOptionsNfs',
+      'nfs':            { 'type': 'BlockdevCreateOptionsNfs',
+                          'if': 'CONFIG_LIBNFS' },
       'parallels':      'BlockdevCreateOptionsParallels',
       'qcow':           'BlockdevCreateOptionsQcow',
       'qcow2':          'BlockdevCreateOptionsQcow2',
       'qed':            'BlockdevCreateOptionsQed',
-      'rbd':            'BlockdevCreateOptionsRbd',
-      'ssh':            'BlockdevCreateOptionsSsh',
+      'rbd':            { 'type': 'BlockdevCreateOptionsRbd',
+                          'if': 'CONFIG_RBD' },
+      'ssh':            { 'type': 'BlockdevCreateOptionsSsh',
+                          'if': 'CONFIG_LIBSSH' },
       'vdi':            'BlockdevCreateOptionsVdi',
       'vhdx':           'BlockdevCreateOptionsVhdx',
       'vmdk':           'BlockdevCreateOptionsVmdk',
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85868C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOfg-0001cz-CN; Mon, 27 Jul 2026 12:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woOfJ-0001ZE-G1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:59:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1woOfH-0006fy-Hn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:58:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso2394282f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785171534; x=1785776334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f7dVSBKfoZtY9jNg9f7zVuYlWjUlqac6RDPPVJ22gYg=;
 b=pNjkWMd4NTFwlPOMCRdn4XB/qXVKMYa5UrvM6DJoQ7KkRDRpnY9N/odAlcPxHWXRwC
 ikV1yjorZt+9bk4HOHU74nQlUC98aRYW04ilHe5zFP/6Ch5HyMFTA4Cwd0idL5YLB3ic
 vgZVI8Pv+18twczP95zI8ZJ6ts9bJdixo8JZpLpf2at3JEeowZG7sdQ0nWjDg3FySr5s
 kFeqnKNVWAf6OYOE15cbR5UKFeZA9/72vnKUlObbQceX/QINSIQQrWqaw+bnhSApVv89
 3hpWvZvlt7fz9BBoTk/hEhQMkqrEPdIv1GQCoPxBnJjOrPVQq2ypORVGxFe9UGHGUwRr
 Neug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785171534; x=1785776334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f7dVSBKfoZtY9jNg9f7zVuYlWjUlqac6RDPPVJ22gYg=;
 b=P0Lv4OzoSowjAVn/dur9x12Jba7kLUM6zb+ncfU3BDhMC1f7LaRwdft8llu84xiR7c
 P5hEsMh9/2cqlkyg+NNAdkEXjr7CtG8y7HIt8VqmKOqUPrgwPDwRzsI7f3tNAdQYlG0D
 +CQVCbP0J5PVdRZU6y9e/4Z4ibGPPdVYEL0b3b0woR6gPAvn9Lm94Tt0w3wdUTrl0nPH
 bqcVoaMDYb6oxtWv55cRCYsAC+4gA5+S8k3BRjA76MkV43YpqwAjwD+PHgsFDawcMtdQ
 Y2YPKyRGwiWGXeJ++GwLAl48IoOgFP7pj28ukx3r+clJjlIr35hhWguMUutOj8W0Cm7V
 IcBA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/hy/Z9pG9uP/Rb2F0/Q3hh8JZpSwxdxspXjby8Jh8uvHpRU4k3OiiSPpr3ntI75BNt2Kwx5/k78vc@nongnu.org
X-Gm-Message-State: AOJu0YxTzyIO2QD8I4/Q/ZqKKDHVaerVrQAjAVNbGJ9KAzWhr7u9r2JS
 wy1TKnV6CxxoTQQ2+UNyDLBsXOOIZcMuwK0hC4DEK6aBSq/svWrCMl4B
X-Gm-Gg: AR+sD118hwiPk4PfNyiBtvmTIAFxDoetKGARJH5j0UkxHTVE/n9p1bcvO6RYb/6BgtZ
 plzdJFoV/BmJ3KMRMu7S1ZDu+8non43poGRRg+CL7vCBAjQCwUA/biXotpOQkHGPIeDwwZEkdHf
 rVjAO9g1AfXo7dYRf+2vdsW726kaRSprsA12pNbpncdjctVtjgk3K5KeCiGHE5UAb/GUu6vTnj9
 NB4ai6vXyMRvgmhF65y+u1MUU/oPS9K8e6jaHbDZMTXaWn1A1rhYaBWO/l4wXLf6VYpVbeUT91h
 loadOB7zhPetzMlPGmcXHIQMj4B3vnCt+SsOTp5Va4+70jASdIWb6p3K0mrd0MFAtm7ds4P1Q2e
 DY8QBtPQ9ftw+oxLBqPN5PRj8XCyT39gE/0NU4AYmp0JThT8BzIBsZGqqBHQnCAY/XrcB8zTM5i
 mvYxSjSiOdZVaQeC7KD92s8uHGR/cMDJpE9eyklxFuTVkj72Z0zyJRLsvrx6FePVcoarf1UD8l4
 /A7tbbRhyWtiwzxjifhCdpkiaqFgwhoKvn43crjxQsPA43qz58=
X-Received: by 2002:a05:6000:2903:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-47f9fc8f5ebmr12958785f8f.17.1785171533746; 
 Mon, 27 Jul 2026 09:58:53 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd77a9sm47826602f8f.14.2026.07.27.09.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:58:53 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 2/2] block: gate optional format block drivers in the QAPI
 schema
Date: Mon, 27 Jul 2026 16:58:33 +0000
Message-ID: <20260727165833.107915-2-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260727165833.107915-1-rohit.kuma1313@gmail.com>
References: <20260727165833.107915-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The optional format drivers can be disabled at configure time
(--disable-dmg, --disable-bochs, --disable-cloop, --disable-vvfat,
--disable-qed, --disable-parallels, --disable-vdi, --disable-vmdk,
--disable-vpc, --disable-qcow1), but their BlockdevDriver enum members
were advertised unconditionally by query-qmp-schema even when the driver
was compiled out, mirroring the protocol-driver problem fixed in the
previous patch.

Unlike the protocol drivers these had no CONFIG_* symbol to gate on:
block/meson.build only compiles the driver source conditionally via
get_option('x').allowed().  Export a config-host symbol for each optional
format driver (CONFIG_QCOW1, CONFIG_VDI, CONFIG_VMDK, CONFIG_VPC,
CONFIG_CLOOP, CONFIG_BOCHS, CONFIG_VVFAT, CONFIG_DMG, CONFIG_QED,
CONFIG_PARALLELS) and use it to gate the matching BlockdevDriver enum
members and the BlockdevOptions / BlockdevCreateOptions union branches.

The always-built drivers (qcow2, raw, luks, nbd, vhdx, ...) remain
ungated.  query-qmp-schema now lists only the format drivers actually
compiled in, matching "-drive format=help".

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 meson.build          | 10 +++++++
 qapi/block-core.json | 71 ++++++++++++++++++++++++++++++--------------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/meson.build b/meson.build
index 49a5baf5b5..de164f9bc6 100644
--- a/meson.build
+++ b/meson.build
@@ -2581,6 +2581,16 @@ config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
 config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
+config_host_data.set('CONFIG_QCOW1', get_option('qcow1').allowed())
+config_host_data.set('CONFIG_VDI', get_option('vdi').allowed())
+config_host_data.set('CONFIG_VMDK', get_option('vmdk').allowed())
+config_host_data.set('CONFIG_VPC', get_option('vpc').allowed())
+config_host_data.set('CONFIG_CLOOP', get_option('cloop').allowed())
+config_host_data.set('CONFIG_BOCHS', get_option('bochs').allowed())
+config_host_data.set('CONFIG_VVFAT', get_option('vvfat').allowed())
+config_host_data.set('CONFIG_DMG', get_option('dmg').allowed())
+config_host_data.set('CONFIG_QED', get_option('qed').allowed())
+config_host_data.set('CONFIG_PARALLELS', get_option('parallels').allowed())
 config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
 config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1087c2cbd4..34ef1c70e1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3337,8 +3337,11 @@
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
-            'cloop', 'compress', 'copy-before-write', 'copy-on-read', 'dmg',
+  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify',
+            { 'name': 'bochs', 'if': 'CONFIG_BOCHS' },
+            { 'name': 'cloop', 'if': 'CONFIG_CLOOP' },
+            'compress', 'copy-before-write', 'copy-on-read',
+            { 'name': 'dmg', 'if': 'CONFIG_DMG' },
             'file', 'snapshot-access',
             { 'name': 'ftp', 'if': 'CONFIG_CURL' },
             { 'name': 'ftps', 'if': 'CONFIG_CURL' },
@@ -3352,16 +3355,24 @@
             { 'name': 'nfs', 'if': 'CONFIG_LIBNFS' },
             'null-aio', 'null-co', 'nvme',
             { 'name': 'nvme-io_uring', 'if': 'CONFIG_BLKIO' },
-            'parallels', 'preallocate', 'qcow', 'qcow2', 'qed', 'quorum',
-            'raw',
+            { 'name': 'parallels', 'if': 'CONFIG_PARALLELS' },
+            'preallocate',
+            { 'name': 'qcow', 'if': 'CONFIG_QCOW1' },
+            'qcow2',
+            { 'name': 'qed', 'if': 'CONFIG_QED' },
+            'quorum', 'raw',
             { 'name': 'rbd', 'if': 'CONFIG_RBD' },
             { 'name': 'replication', 'if': 'CONFIG_REPLICATION' },
             { 'name': 'ssh', 'if': 'CONFIG_LIBSSH' },
-            'throttle', 'vdi', 'vhdx',
+            'throttle',
+            { 'name': 'vdi', 'if': 'CONFIG_VDI' },
+            'vhdx',
             { 'name': 'virtio-blk-vfio-pci', 'if': 'CONFIG_BLKIO' },
             { 'name': 'virtio-blk-vhost-user', 'if': 'CONFIG_BLKIO' },
             { 'name': 'virtio-blk-vhost-vdpa', 'if': 'CONFIG_BLKIO' },
-            'vmdk', 'vpc', 'vvfat' ] }
+            { 'name': 'vmdk', 'if': 'CONFIG_VMDK' },
+            { 'name': 'vpc', 'if': 'CONFIG_VPC' },
+            { 'name': 'vvfat', 'if': 'CONFIG_VVFAT' } ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -4843,12 +4854,15 @@
       'blklogwrites':'BlockdevOptionsBlklogwrites',
       'blkverify':  'BlockdevOptionsBlkverify',
       'blkreplay':  'BlockdevOptionsBlkreplay',
-      'bochs':      'BlockdevOptionsGenericFormat',
-      'cloop':      'BlockdevOptionsGenericFormat',
+      'bochs':      { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_BOCHS' },
+      'cloop':      { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_CLOOP' },
       'compress':   'BlockdevOptionsGenericFormat',
       'copy-before-write':'BlockdevOptionsCbw',
       'copy-on-read':'BlockdevOptionsCor',
-      'dmg':        'BlockdevOptionsGenericFormat',
+      'dmg':        { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_DMG' },
       'file':       'BlockdevOptionsFile',
       'ftp':        { 'type': 'BlockdevOptionsCurlFtp',
                       'if': 'CONFIG_CURL' },
@@ -4875,11 +4889,14 @@
       'nvme':       'BlockdevOptionsNVMe',
       'nvme-io_uring': { 'type': 'BlockdevOptionsNvmeIoUring',
                          'if': 'CONFIG_BLKIO' },
-      'parallels':  'BlockdevOptionsGenericFormat',
+      'parallels':  { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_PARALLELS' },
       'preallocate':'BlockdevOptionsPreallocate',
       'qcow2':      'BlockdevOptionsQcow2',
-      'qcow':       'BlockdevOptionsQcow',
-      'qed':        'BlockdevOptionsGenericCOWFormat',
+      'qcow':       { 'type': 'BlockdevOptionsQcow',
+                      'if': 'CONFIG_QCOW1' },
+      'qed':        { 'type': 'BlockdevOptionsGenericCOWFormat',
+                      'if': 'CONFIG_QED' },
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
       'rbd':        { 'type': 'BlockdevOptionsRbd',
@@ -4890,7 +4907,8 @@
       'ssh':        { 'type': 'BlockdevOptionsSsh',
                       'if': 'CONFIG_LIBSSH' },
       'throttle':   'BlockdevOptionsThrottle',
-      'vdi':        'BlockdevOptionsGenericFormat',
+      'vdi':        { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_VDI' },
       'vhdx':       'BlockdevOptionsGenericFormat',
       'virtio-blk-vfio-pci':
                     { 'type': 'BlockdevOptionsVirtioBlkVfioPci',
@@ -4901,9 +4919,12 @@
       'virtio-blk-vhost-vdpa':
                     { 'type': 'BlockdevOptionsVirtioBlkVhostVdpa',
                       'if': 'CONFIG_BLKIO' },
-      'vmdk':       'BlockdevOptionsGenericCOWFormat',
-      'vpc':        'BlockdevOptionsGenericFormat',
-      'vvfat':      'BlockdevOptionsVVFAT'
+      'vmdk':       { 'type': 'BlockdevOptionsGenericCOWFormat',
+                      'if': 'CONFIG_VMDK' },
+      'vpc':        { 'type': 'BlockdevOptionsGenericFormat',
+                      'if': 'CONFIG_VPC' },
+      'vvfat':      { 'type': 'BlockdevOptionsVVFAT',
+                      'if': 'CONFIG_VVFAT' }
   } }
 
 ##
@@ -5560,18 +5581,24 @@
       'luks':           'BlockdevCreateOptionsLUKS',
       'nfs':            { 'type': 'BlockdevCreateOptionsNfs',
                           'if': 'CONFIG_LIBNFS' },
-      'parallels':      'BlockdevCreateOptionsParallels',
-      'qcow':           'BlockdevCreateOptionsQcow',
+      'parallels':      { 'type': 'BlockdevCreateOptionsParallels',
+                          'if': 'CONFIG_PARALLELS' },
+      'qcow':           { 'type': 'BlockdevCreateOptionsQcow',
+                          'if': 'CONFIG_QCOW1' },
       'qcow2':          'BlockdevCreateOptionsQcow2',
-      'qed':            'BlockdevCreateOptionsQed',
+      'qed':            { 'type': 'BlockdevCreateOptionsQed',
+                          'if': 'CONFIG_QED' },
       'rbd':            { 'type': 'BlockdevCreateOptionsRbd',
                           'if': 'CONFIG_RBD' },
       'ssh':            { 'type': 'BlockdevCreateOptionsSsh',
                           'if': 'CONFIG_LIBSSH' },
-      'vdi':            'BlockdevCreateOptionsVdi',
+      'vdi':            { 'type': 'BlockdevCreateOptionsVdi',
+                          'if': 'CONFIG_VDI' },
       'vhdx':           'BlockdevCreateOptionsVhdx',
-      'vmdk':           'BlockdevCreateOptionsVmdk',
-      'vpc':            'BlockdevCreateOptionsVpc'
+      'vmdk':           { 'type': 'BlockdevCreateOptionsVmdk',
+                          'if': 'CONFIG_VMDK' },
+      'vpc':            { 'type': 'BlockdevCreateOptionsVpc',
+                          'if': 'CONFIG_VPC' }
   } }
 
 ##
-- 
2.50.1



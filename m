Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709BAC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wild2-0002zQ-Ew; Sun, 12 Jul 2026 00:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wild0-0002sf-Ut; Sun, 12 Jul 2026 00:17:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcy-0006RV-Tt; Sun, 12 Jul 2026 00:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=GGpXA3OlClduB2ARaBqwEAkziFOHlToCRRZqUnM93KI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Eo0KXY1GJFBD5KFb4oXhO/VV8eOJR2J4x5gqpzhfTVbfdsKZHjDM4qTv4PSDQSlt2
 vqAkIAXG5VcokZEo6dbAWnXXZgQppy/Pb4NyuiWq9tf57suWcJMo3zo3YwyKZnZ8J8
 0bxHoP0ZiibY+pDQuowQ8xb6ZekY/XjJm6il51NWw/xslN0wfbsFS+3YmV5GnEDI3j
 dWVeF/zh1OlmmBMUdC0ofxhz4RyWQLi9cdfo+GFHwaoo4C+IiCg0z34qgUCuGdPOh2
 lpSRVoViUKhZ+drY3NYszDcob7opogFtz8lWgxofhCvGOae7yMMaGD6j0uWicRbntm
 Ffpn26pnA09xQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 024661C0BEA;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 348813EB94A;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3822B133D7; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 15/75] qemu-options: document 9pfs max_xattr option
Date: Sun, 12 Jul 2026 07:14:33 +0300
Message-ID: <20260712041539.108341-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add documentation for the new "max_xattr" command line option
of 9pfs server, introduced by the previous commit.

Link: https://lore.kernel.org/qemu-devel/b5a1a6ba299a49183d0032d9e4cd5e009d4aae47.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 44cb540d2d079ce2c785b130e163ab42b9e1a109)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index 396eea7ef20..a2b9d15ba24 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1801,19 +1801,19 @@ ERST
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     "-fsdev local,id=id,path=path,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    " [,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode]\n"
+    " [,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,max_xattr=max]\n"
     " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
     " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
     " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
     " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
     " [[,throttling.iops-size=is]]\n"
-    "-fsdev synth,id=id\n",
+    "-fsdev synth,id=id[,max_xattr=max]\n",
     QEMU_ARCH_ALL)
 
 SRST
-``-fsdev local,id=id,path=path,security_model=security_model [,writeout=writeout][,readonly=on][,fmode=fmode][,dmode=dmode] [,throttling.option=value[,throttling.option=value[,...]]]``
+``-fsdev local,id=id,path=path,security_model=security_model [,writeout=writeout][,readonly=on][,fmode=fmode][,dmode=dmode][,max_xattr=max] [,throttling.option=value[,throttling.option=value[,...]]]``
   \ 
-``-fsdev synth,id=id[,readonly=on]``
+``-fsdev synth,id=id[,readonly=on][,max_xattr=max]``
     Define a new file system device. Valid options are:
 
     ``local``
@@ -1887,6 +1887,12 @@ SRST
         Let every is bytes of a request count as a new request for iops
         throttling purposes.
 
+    ``max_xattr=max``
+        Specifies the maximum number of concurrent xattr FIDs allowed for
+        this export. The default is 1024. Set to 0 for allowing an infinite
+        number of xattr FIDs. This limit prevents host memory exhaustion
+        attacks by capping the number of simultaneous xattr FIDs.
+
     -fsdev option is used along with -device driver "virtio-9p-...".
 
 ``-device virtio-9p-type,fsdev=id,mount_tag=mount_tag``
@@ -1906,14 +1912,14 @@ ERST
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
-    "        [,id=id][,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn]\n"
-    "-virtfs synth,mount_tag=tag[,id=id][,readonly=on]\n",
+    "        [,id=id][,writeout=immediate][,readonly=on][,fmode=fmode][,dmode=dmode][,multidevs=remap|forbid|warn][,max_xattr=max]\n"
+    "-virtfs synth,mount_tag=tag[,id=id][,readonly=on][,max_xattr=max]\n",
     QEMU_ARCH_ALL)
 
 SRST
-``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly=on] [,fmode=fmode][,dmode=dmode][,multidevs=multidevs]``
+``-virtfs local,path=path,mount_tag=mount_tag ,security_model=security_model[,writeout=writeout][,readonly=on] [,fmode=fmode][,dmode=dmode][,multidevs=multidevs][,max_xattr=max]``
   \ 
-``-virtfs synth,mount_tag=mount_tag``
+``-virtfs synth,mount_tag=mount_tag[,max_xattr=max]``
     Define a new virtual filesystem device and expose it to the guest using
     a virtio-9p-device (a.k.a. 9pfs), which essentially means that a certain
     directory on host is made directly accessible by guest as a pass-through
@@ -1979,6 +1985,12 @@ SRST
         Specifies the tag name to be used by the guest to mount this
         export point.
 
+    ``max_xattr=max``
+        Specifies the maximum number of concurrent xattr FIDs allowed for
+        this export. The default is 1024. Set to 0 for allowing an infinite
+        number of xattr FIDs. This limit prevents host memory exhaustion
+        attacks by capping the number of simultaneous xattr FIDs.
+
     ``multidevs=remap|forbid|warn``
         Specifies how to deal with multiple devices being shared with
         the same 9p export in order to avoid file ID collisions on guest.
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BDCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxP9-0002gM-15; Tue, 09 Jun 2026 10:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2c100487252994d6d03baa499ef25e5e1bdaf2cb@kylie.crudebyte.com>)
 id 1wWxP6-0002cK-7w; Tue, 09 Jun 2026 10:26:08 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2c100487252994d6d03baa499ef25e5e1bdaf2cb@kylie.crudebyte.com>)
 id 1wWxP4-0001NW-7u; Tue, 09 Jun 2026 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ufiiCn3cvKp4ufTQLLv5qoeOBCcGqz3IzSs540NafIM=; b=Fi/Yz
 okwBnuH5CibgeMvJpWAddLv/lN+TjjtTGfCbCYBTEq0i5blPTLDr4r68qvu3Zlli4LP28XQ7LM2eG
 vSirXOiq/Jlj3Up9UE3NrY+imIHyRdkvAwGW+yEVxqyMCpQxNlM/t2Dj58Iw8SlBVJDG6XkBcc+wM
 Xe9O6VualWktn0jgvUsOb+/D2zGj8J7t4oKl397bUoFHx+TNJgy10evmmZA8WqRwwOrBfloXH5wwB
 1M+scg3GShwO0tU+/XXU5TbYPWf2H1LjVlU0whljcNOOys4yP9+wEaUh531W6YmndAN05BmLmbVRr
 4/8LEebx0TukxkqTaO8rc1w17ISrUv5z8KiXHyljjMKCw9qCSyy/S1kAyHbHWwUdrC0qXqfcdr5Aw
 Jr6bYO1DrszcIiUqMouUV7IR2ys7FcA9Xw5h9r8DbebzKBso2J0uJPxV+qZZ2ZUXIth8ph8IZCcR5
 3lUlK34Jm5BJ8FeDHagYpMYVXdgXRySJFcWzoeKeihL28qI+L33BytxiWv3ZcWw1H47oXD5XvxpKW
 jU66E/7Z9MDtL/1YE3E+oITU66YYJ2xLxoT+4SWY0xmZd9VCsE4lYaFGRXaZn88MD//7KlOBthpWh
 DfvE6IkQ+rCrEG3eRCyoY1CVdGGIz8Ly9B9NH5ZoEFtH2z/RtgrujdKVqgyESQ=;
Message-ID: <2c100487252994d6d03baa499ef25e5e1bdaf2cb.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 03/12] qemu-options: document 9pfs max_xattr option
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2c100487252994d6d03baa499ef25e5e1bdaf2cb@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add documentation for the new "max_xattr" command line option
of 9pfs server, introduced by the previous commit.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 qemu-options.hx | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..456d44af39 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1914,19 +1914,19 @@ ERST
 
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
@@ -2000,6 +2000,12 @@ SRST
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
@@ -2019,14 +2025,14 @@ ERST
 
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
@@ -2092,6 +2098,12 @@ SRST
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



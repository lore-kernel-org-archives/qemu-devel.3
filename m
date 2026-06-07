Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F4CD8C89
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmi-0000WL-Js; Sun, 07 Jun 2026 13:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c237ae8650eba19720d3c2640b202d5d025e49da@kylie.crudebyte.com>)
 id 1wWHmh-0000VN-2a; Sun, 07 Jun 2026 13:59:43 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c237ae8650eba19720d3c2640b202d5d025e49da@kylie.crudebyte.com>)
 id 1wWHmf-0004PO-Ga; Sun, 07 Jun 2026 13:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=R6AULfhhw5rxqMUI9RRsQGWJDEv+yKByNHZ+XkDIDgU=; b=WU7Ha
 VUKem6LIbx+p6T5kCMsYbvHR+Q7TqsqJDo3wad922UU8BZLhECnt/TVanM5whj59Wfqg/vAiGfAHj
 cwwCMYLaFWasaeD7IvJqzAoTFpqA0ejuCs/Zy/dEqJWUe+Cb5IYv8OxX9mFcjGFMV4myYOjn3P/hg
 u5vJrKZFTZ/CVJq5ksDfAByQEQbGI3i8jKx2oBScMK3hAafTXB1pDdrCarUYEDJA3KCquCLaBy51t
 LPKvxezlNC2WYHGc0C0pr+j8PKiltrKA8Ms5IP8vNnm+gy/n5vo5V4X/1WXkMTLep2AePqcp0E+gT
 j7zC81PaZH3S4ZM/H6z9NRiCO31d9Y2omBOq8LP8G8jG08RLkWl1hcgNAKAhjrTRkRt4ka6W1H5lJ
 YQ5Fr20Kek/ys1zQfYzWcsRjXvUEGvNrVLbaOseYy7BTK3Nh+H7iUSjb+RF1fUClxVl6BulmrS/yi
 Y6Hh0ieRZxUYKuAguClYDbg8FJ0e7DXpHSu9eVn4NcWfB5qAgE43rtZRp1xDwypHhS36qb8u5u9f/
 55VLYw/ooRUMnYhotich90dLayuj3hW3g/xrJNj2iwIfNRDhILUGEt6qRWxZ3C+ONKB/ci5h2UoK4
 EaH0RQEZy4WS8a5V84qru8FtT8FB/jyfFSF9tgOsRVHx6dG3Gayd35wIw0ChKk=;
Message-ID: <c237ae8650eba19720d3c2640b202d5d025e49da.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 03/12] qemu-options: document 9pfs max_xattr option
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c237ae8650eba19720d3c2640b202d5d025e49da@kylie.crudebyte.com;
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
index 96ae41f787..558d084742 100644
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
+        Sets the maximum number of concurrent xattr FIDs allowed for
+        this export. The default is 1024. Set to 0 for allowing an infinite
+        number of xattr FIDs. This limit prevents host memory exhaustion
+        attacks by capping the number of current xattr FIDs.
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
@@ -2109,6 +2115,12 @@ SRST
         on host would otherwise cause a file ID collision and hence
         potential severe misbehaviours on guest.
 
+        ``max_xattr`` : sets the maximum number of concurrent xattr FIDs
+        allowed for this export. The default is 1024. Set to 0 for
+        allowing an infinite number of xattr FIDs. This limit prevents
+        host memory exhaustion attacks by capping the number of current
+        xattr FIDs.
+
         ``warn`` : virtfs 9p expects only one device to be shared with
         the same export. If however more than one device is shared and
         accessed via the same 9p export then only a warning message is
-- 
2.47.3



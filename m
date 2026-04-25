Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26E9FF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGk6I-00075F-DU; Sat, 25 Apr 2026 16:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGk6G-00074i-C2
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 16:59:40 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGk6E-0006SV-S3
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 16:59:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BDC660055;
 Sat, 25 Apr 2026 20:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0212C2BCB0;
 Sat, 25 Apr 2026 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777150776;
 bh=Q/iXGdIHYdJNB8woaida8AHWG6igtbbz4i/W4/TIG+0=;
 h=From:To:Cc:Subject:Date:From;
 b=etqrZiRR2iRDOTlzTXfdQWu1A6PPFkj0XJe49zkVIGf3LD4O5lxgzanKI7/BXz7tx
 1CEk+XntnCZvdnPUrxT3qB35gFcTAQ4N+O81wRPdqtxBNrfPM6X1PFMtDYo4qNRdd0
 Ll5wYZ9Vaz1rtPg4f+eNJ+kh87Fpdu+D81TRfgI3TcqWVG0fe45OHY7G/RVkvtQenz
 PiEIbbnMxVpO9JPdDfkq1d0EbbHjK8tHq6vrzDv6bxqmmAtQVixaxKd8dd7xdIKmjd
 wJl9uxUfz3AIw7uQVkjXktewybcSVmjdAA9VO2Sxd9EOo27fW2ej/v+2Y7Fd0TI7Oh
 IsU5+DU/UGTTg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Add missing CDROM ioctls
Date: Sat, 25 Apr 2026 22:59:32 +0200
Message-ID: <20260425205932.176330-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Add the missing CDROM ioctls and bring them in same order as
documentation.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/ioctls.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 5b7d00e92f..aa485ee6e5 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -416,19 +416,18 @@
 #endif
 
   IOCTL(CDROMPAUSE, 0, TYPE_NULL)
-  IOCTL(CDROMSTART, 0, TYPE_NULL)
-  IOCTL(CDROMSTOP, 0, TYPE_NULL)
   IOCTL(CDROMRESUME, 0, TYPE_NULL)
-  IOCTL(CDROMEJECT, 0, TYPE_NULL)
-  IOCTL(CDROMEJECT_SW, 0, TYPE_INT)
-  IOCTL(CDROMCLOSETRAY, 0, TYPE_NULL)
-  IOCTL(CDROMRESET, 0, TYPE_NULL)
   IOCTL(CDROMPLAYMSF, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMPLAYTRKIND, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMREADTOCHDR, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(CDROMREADTOCENTRY, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(CDROMSTOP, 0, TYPE_NULL)
+  IOCTL(CDROMSTART, 0, TYPE_NULL)
+  IOCTL(CDROMEJECT, 0, TYPE_NULL)
   IOCTL(CDROMVOLCTRL, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMSUBCHNL, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(CDROMEJECT_SW, IOC_W, TYPE_INT)
+  IOCTL(CDROMRESET, 0, TYPE_NULL)
   /* XXX: incorrect (need specific handling) */
   IOCTL(CDROMREADAUDIO, IOC_W, MK_PTR(MK_STRUCT(STRUCT_cdrom_read_audio)))
   IOCTL(CDROMREADCOOKED, IOC_RW, MK_PTR(TYPE_INT))
@@ -438,16 +437,22 @@
   IOCTL(CDROMREADALL, IOC_RW, MK_PTR(TYPE_INT))
   IOCTL(CDROMMULTISESSION, IOC_RW, MK_PTR(TYPE_INT))
   IOCTL(CDROM_GET_UPC, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(CDROM_LAST_WRITTEN, IOC_R, MK_PTR(TYPE_LONG))
   IOCTL(CDROMVOLREAD, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(CDROMSEEK, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(CDROMPLAYBLK, IOC_W, MK_PTR(TYPE_INT))
-  IOCTL(CDROM_MEDIA_CHANGED, 0, TYPE_NULL)
-  IOCTL(CDROM_SET_OPTIONS, 0, TYPE_INT)
-  IOCTL(CDROM_CLEAR_OPTIONS, 0, TYPE_INT)
-  IOCTL(CDROM_SELECT_SPEED, 0, TYPE_INT)
-  IOCTL(CDROM_SELECT_DISC, 0, TYPE_INT)
-  IOCTL(CDROM_DRIVE_STATUS, 0, TYPE_NULL)
+  IOCTL(CDROMCLOSETRAY, 0, TYPE_NULL)
+  IOCTL(CDROM_SET_OPTIONS, IOC_W, TYPE_INT)
+  IOCTL(CDROM_CLEAR_OPTIONS, IOC_W, TYPE_INT)
+  IOCTL(CDROM_SELECT_SPEED, IOC_W, TYPE_INT)
+  IOCTL(CDROM_SELECT_DISC, IOC_W, TYPE_INT)
+  IOCTL(CDROM_MEDIA_CHANGED, IOC_W, TYPE_INT)
+  IOCTL(CDROM_DRIVE_STATUS, IOC_W, TYPE_INT)
   IOCTL(CDROM_DISC_STATUS, 0, TYPE_NULL)
+  IOCTL(CDROM_CHANGER_NSLOTS, 0, TYPE_NULL)
+  IOCTL(CDROM_LOCKDOOR, IOC_W, TYPE_INT)
+  IOCTL(CDROM_DEBUG, IOC_W, TYPE_INT)
+  IOCTL(CDROM_GET_CAPABILITY, 0, TYPE_NULL)
   IOCTL(CDROMAUDIOBUFSIZ, 0, TYPE_INT)
 
 #if 0
-- 
2.53.0



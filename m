Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2695CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuRL-0005jM-38; Tue, 12 May 2026 17:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuR5-0005Cq-Nv; Tue, 12 May 2026 17:14:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuR3-0005kw-Av; Tue, 12 May 2026 17:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619305; bh=3SPDU/MzEED/in/FPcMMdlRMZaMC11Nee7F0BCRqMtM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I4GV9AxF7suLI02Z3KEUm2XwLDzfqf0RxrNDzZ2XAdn3Bd/yH09xhPX+1RL47RWA4
 067yTId3Gf5a/gFnBX+iVqtSD1/vaVu6L6gilsd0NHfIXJ+5vGtvZ9xkbNtZR25IWk
 YIIaz8h5czqDqrbpHlukvBSCi0mRLkcIgv27n58SQYQ9zTIyLNu/4Z1Nxg3mbT3Wh1
 uGNHx0WgOPtHFEhVaSpnQg4jfA2rPDq8YzS4XjnTpZO7jcqIkFJhh47zrnyUoQZzYo
 Gs0sCKgvX9EWCD9kyLjyTx5LiHf+Nz9+TGMS4pUI7LTjuycNdJSXq7D86G0zAGkRFN
 qG8dlaVtrL1nw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8BD041AA394;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 999C33ABD03;
 Tue, 12 May 2026 23:55:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 086/117] linux-user: Define SO_TIMESTAMP*_NEW and
 SO_RCVTIMEIO_NEW
Date: Tue, 12 May 2026 23:54:28 +0300
Message-ID: <20260512205503.361097-86-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Define the entries which always use the 64-bit timestamps.

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 8b60ed835478a787dd60e0f7308a65f6d35b0268)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index d54dc98c09..0201ab9374 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -75,6 +75,13 @@
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
 #define TARGET_SO_NOFCS     43
 
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index b3b4a8e44c..33e6c3a572 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -58,4 +58,12 @@
 
 #define TARGET_SO_PROTOCOL             38
 #define TARGET_SO_DOMAIN               39
+
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 23f69a3293..2304dbbf79 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -67,6 +67,13 @@
 
 #define TARGET_SO_CNX_ADVICE           0x402E
 
+#define TARGET_SO_TIMESTAMP_NEW        0x4038
+#define TARGET_SO_TIMESTAMPNS_NEW      0x4039
+#define TARGET_SO_TIMESTAMPING_NEW     0x403A
+
+#define TARGET_SO_RCVTIMEO_NEW         0x4040
+#define TARGET_SO_SNDTIMEO_NEW         0x4041
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 562cad88e2..1f479d54aa 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -71,6 +71,13 @@
 #define TARGET_SO_RCVBUFFORCE          33
 #define TARGET_SO_PASSSEC              34
 
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 /** sock_type - Socket types
  *
  * Please notice that for binary compat reasons MIPS has to
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 0a822e3e1f..42ecfdc8f9 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -61,6 +61,13 @@
 #define TARGET_SO_TIMESTAMPING         0x0023
 #define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
 
+#define TARGET_SO_TIMESTAMP_NEW        0x0046
+#define TARGET_SO_TIMESTAMPNS_NEW      0x0042
+#define TARGET_SO_TIMESTAMPING_NEW     0x0043
+
+#define TARGET_SO_RCVTIMEO_NEW         0x0044
+#define TARGET_SO_SNDTIMEO_NEW         0x0045
+
 #define TARGET_SO_RXQ_OVFL             0x0024
 
 #define TARGET_SO_WIFI_STATUS          0x0025
-- 
2.47.3



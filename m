Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12863EE644A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dS-0000rT-HA; Wed, 31 Dec 2025 16:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dL-0000pX-3S
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:32 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dJ-0003i3-2t
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:30 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 11480EC0201;
 Wed, 31 Dec 2025 16:21:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 31 Dec 2025 16:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767216088; x=
 1767302488; bh=DVEcA6/vb4PpKi3BScNtdzOM0zTGfMYeT/9Yf5tvYMA=; b=K
 U5UexAeZYspw30e65UuKaiAIIrPYPtzsupMNxYyH9bifejQjxK9Byypphbd+Ls2P
 7TMoot8qtC8DAzstbfUGBkd5mfDYSc60qJgsA9/Rt0aubMmmkDbJ7EzQfCe84ZGv
 myROLzOSRv4I63Loiyq+AT5pOStdjEmxV79ym3TA39Qao5Q1g0ZyjYKy8WZ4Xe14
 gvkImqlJBz/BKOGrSSVLzPVLfCqOcMYmD5ju6Hb/4kfgOt70wKP+p3qWiEX/FPGz
 7TdNIATl5TPANGycpGUyR6RRK4m/7fC+CKdOnjs3S0CbsgaJXMhWThLPwy5HzkeP
 MgHbOq07cynWvBx34vzyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767216088; x=1767302488; bh=D
 VEcA6/vb4PpKi3BScNtdzOM0zTGfMYeT/9Yf5tvYMA=; b=iGRjUnju+Zf2i9b9n
 Kt/sClJsdAvDwVOfwC2wS9XY+gXwxx5Frey/f59LQYAuSW21fE8ala4rBJ+ABizj
 bVYJL2qrRy09o4WcZR2FsBBa9NkH+pzbecB6SEOUwMpwWg3dP1BFGj5lFxhsRvGU
 r/IVVMEp8wwcR8Oizr772btGU9j6P25MTvo3aAPDyBT/47xOOGLwGD1lYb3P8lbI
 yZFbrF6bKHiTc+ZkWU3eVxlMbYuSkTrd189TimKlt5L7hGbyCjEZOIQQmUAXyvKO
 Z14/YwZUfsSLHIQ+pgmfKthe/zE14/4+J+9ctu8F+PcX69qppwuY3pY9GPwId5CM
 2acYw==
X-ME-Sender: <xms:15NVaeCR25AdD5D19eE9jlN-SSr4hPQ0dVgM-DGNBHjUNeHPAq6g_Q>
 <xme:15NVaf9T3l49RwTGp8BjecU1bfAwJAAGH9RfOoaa82qYG9p5_sxxk7wBXBY3P7TDP
 8wsPCivJzF1_EhFf9WLmyjvDIAF0lCL8Bd0F1FzQpXn1EDlemem4A>
X-ME-Received: <xmr:15NVae_lsun6m3d3TRnOzNHOkhQl3gZa3QnuWwMt5u--00EjdLkyTTCo9gs9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptg
 hhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:2JNVaWck314ttHEralDkY5ZBcGEJp7Q7aDSVGqUKctIgHjFXdLm7og>
 <xmx:2JNVaXGFDCsakZ0H0yTs2ooEagXCHIr33DyP4GK_Oe4yjUa2Kzh1Rg>
 <xmx:2JNVaUfY9aA-IY6SPDTs-77byZfvj_ci4JJcmdFf-o9aIRMw4uFSMA>
 <xmx:2JNVaRHqQ8rh0YtUvlk3SotmhiREHpLgnc9Npps9kngiclD5zZIZVg>
 <xmx:2JNVaULr5z0xP9voEJEG8W5Pxsw0ywdzB53tG__-6V2Vq5XWRAlv8u0J>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 4ced2b79;
 Wed, 31 Dec 2025 21:21:25 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 4/7] ati-vga: Implement PM4_MICRO_CNTL register
Date: Wed, 31 Dec 2025 16:21:04 -0500
Message-ID: <20251231212107.1020964-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231212107.1020964-1-chad@jablonski.xyz>
References: <20251231212107.1020964-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.150; envelope-from=chad@jablonski.xyz;
 helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The PM4_MICRO_CNTL register has a single flag that is used by drivers to
enable processing of CCE commands from the CCE FIFO. Reverse engineering
uncovered additional debug fields, many of which have an unclear purpose.
They have been omitted for now but could be added if needed.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 7 +++++++
 hw/display/ati_cce.h  | 2 ++
 hw/display/ati_regs.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index f8e1fe2861..a9fe0cd0d2 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -565,6 +565,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
               (s->cce.no_update << 27) |
               (s->cce.buffer_size_l2qw & 0x7ffffff);
         break;
+    case PM4_MICRO_CNTL:
+        val = s->cce.freerun ? PM4_MICRO_FREERUN : 0;
+        break;
     default:
         break;
     }
@@ -1110,6 +1113,10 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.buffer_mode = (data >> 28) & 0xf;
         break;
     }
+    case PM4_MICRO_CNTL: {
+        s->cce.freerun = data & PM4_MICRO_FREERUN;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index 25a2430c60..a6a9aa87c4 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -21,6 +21,8 @@ typedef struct ATIPM4MicrocodeState {
 
 typedef struct ATICCEState {
     ATIPM4MicrocodeState microcode;
+    /* MicroCntl */
+    bool freerun;
     /* BufferCntl */
     uint32_t buffer_size_l2qw;
     bool no_update;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 94b7ed0d37..190b99184c 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -401,6 +401,9 @@
 #define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
 #define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
 
+/* PM4_MICRO_CNTL bit constants */
+#define PM4_MICRO_FREERUN                       0x40000000
+
 /* DP_DATATYPE bit constants */
 #define DST_8BPP                                0x00000002
 #define DST_15BPP                               0x00000003
-- 
2.51.2



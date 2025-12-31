Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1336EE644A
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dN-0000pW-PK; Wed, 31 Dec 2025 16:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dJ-0000oT-Pl
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:29 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dI-0003hz-2v
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:29 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A63A31400046;
 Wed, 31 Dec 2025 16:21:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 31 Dec 2025 16:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767216087; x=
 1767302487; bh=UJM3F3BQuLVendrDWJtrPOsf6gS3z8el+Rf/CxbEnE8=; b=C
 EbglSYWQvBG1Va33ktSfnfLKndwTu0P5lFmNtFAG9+Ye8UPaMzfMP/4OSBi2Ycr1
 u9R8rGbkoozaUOJcoP0LnzZcd8kxKVagvruqxsfJua7L3ZRQjY7Nx/rRe/fKW4f8
 fqemBeY/BjseB7y8sqzvsDlnqHcrCG6Ei+wEcd6vIkVaqQuB+bHC4k7fPl2nAE0c
 UnPcYMcejnNFNG3PnFzfBKUtOQoGyhVzMn3Z9oDWleWC3MfZrXlXOpK/5Pi/GxeB
 IHvWmwePS+McioLBXLtCaCHGRqyGjZYJofhdx7Cb7aMUsRwBvyrUZeiKyx2l9+jP
 E76vpvkJYNWofrpM4SsFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767216087; x=1767302487; bh=U
 JM3F3BQuLVendrDWJtrPOsf6gS3z8el+Rf/CxbEnE8=; b=uDfROu74H9fmSV4B8
 Bs13oApRUGh4ylyH8uoeBsKbn2pCBaqwAeZBY5hqXLZOFquktSHY5dBtiSZOCVAL
 GlZTjoswLkD+mfgBEcvKbX/RIW3jefhq34TyoujzHTyz5KsynHFfIvXy+U4OcUcU
 LnvvZH3001FTfWdqFAzGSLlOeuflZnP4UXovvisGOLHIrcW60LZydIkOg8jXFuaE
 Ki2qiv/BqoG5GnsynYK9ICVKK50SLzfgxMxD+q9B8NdqLXj/jD57AEF1/UcFlPWr
 Rx90u45WP7kr2DjljYsZGeHu+KMysv799Zqbd4kkFQKA9zPt4Rbf5KH87O+Tijby
 8tJXw==
X-ME-Sender: <xms:15NVaaNY3QcsGtRGTSagmtQuxK4rWyKTgL_zzgKWPpKpC7tPo6PgSw>
 <xme:15NVaQYn9_j15dA3AszKyMnpcyFwzsY1Mm6CPLYn-GpWx7b8EILtpdbrhIK2Ku5Ja
 DgjvxCpBLMeEInzhW4_uR0mB4mM21oMop2i2mP6UmRFYRXWob7w-hKR>
X-ME-Received: <xmr:15NVaeoJUXDuA_c5UVS3O2xamcpLUtzRkqtgEpq7TnQUUiU2SqslaLEdYgNW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhn
 segvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:15NVaUb465m4GfZzvvjncIsfWzaKfhXVcafWS9M2fKRIsCAO7BGcYg>
 <xmx:15NVaWQVcYk1NUFkU94TKDPKVVfTf6PP65INTB1Wx2-R2YbjmNP4rg>
 <xmx:15NVab50H5m2LWrpbHv_hYjTf-AYw-70r0ntGCCSNXeCEUSwzJflGA>
 <xmx:15NVabxyQkYjz5Kos-sy1RbT0zqV29FgN1_zdUhBVfi0aYTN82oGKg>
 <xmx:15NVaZFRunqdZYm2jexAdSCzry1Oy5mpneiawx6VBbx_-cOX2XK8h2Ct>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:27 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id aa83430f;
 Wed, 31 Dec 2025 21:21:25 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 3/7] ati-vga: Implement PM4_BUFFER_CNTL register
Date: Wed, 31 Dec 2025 16:21:03 -0500
Message-ID: <20251231212107.1020964-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231212107.1020964-1-chad@jablonski.xyz>
References: <20251231212107.1020964-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a8-smtp.messagingengine.com
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

The PM4_BUFFER_CNTL register is used to set up the CCE FIFO. These are
straightforward reads and writes. Future CCE patches make use of this
state.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 11 +++++++++++
 hw/display/ati_cce.h  |  4 ++++
 hw/display/ati_regs.h | 12 ++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index bac0ceaa79..f8e1fe2861 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -560,6 +560,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
          */
         s->cce.microcode.raddr = s->cce.microcode.addr;
         break;
+    case PM4_BUFFER_CNTL:
+        val = ((s->cce.buffer_mode & 0xf) << 28) |
+              (s->cce.no_update << 27) |
+              (s->cce.buffer_size_l2qw & 0x7ffffff);
+        break;
     default:
         break;
     }
@@ -1099,6 +1104,12 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.microcode.addr += 1;
         break;
     }
+    case PM4_BUFFER_CNTL: {
+        s->cce.buffer_size_l2qw = data & 0x7ffffff;
+        s->cce.no_update = (data >> 27) & 1;
+        s->cce.buffer_mode = (data >> 28) & 0xf;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index f2ef1345de..25a2430c60 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -21,6 +21,10 @@ typedef struct ATIPM4MicrocodeState {
 
 typedef struct ATICCEState {
     ATIPM4MicrocodeState microcode;
+    /* BufferCntl */
+    uint32_t buffer_size_l2qw;
+    bool no_update;
+    uint8_t buffer_mode;
 } ATICCEState;
 
 #endif /* ATI_CCE_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 8f3335817f..94b7ed0d37 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -387,7 +387,19 @@
 #define PC_BUSY                                 0x80000000
 
 #define BUS_MASTER_DIS                          0x00000040
+
+
+/* PM4_BUFFER_CNTL buffer mode bit constants */
 #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
+#define PM4_BUFFER_CNTL_192PIO                  0x00000001
+#define PM4_BUFFER_CNTL_192BM                   0x00000002
+#define PM4_BUFFER_CNTL_128PIO_64INDBM          0x00000003
+#define PM4_BUFFER_CNTL_128BM_64INDBM           0x00000004
+#define PM4_BUFFER_CNTL_64PIO_128INDBM          0x00000005
+#define PM4_BUFFER_CNTL_64BM_128INDBM           0x00000006
+#define PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM    0x00000007
+#define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
+#define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
 
 /* DP_DATATYPE bit constants */
 #define DST_8BPP                                0x00000002
-- 
2.51.2



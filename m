Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E5EE57C5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 21:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb3dR-0000rL-K7; Wed, 31 Dec 2025 16:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dK-0000or-02
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:30 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb3dI-0003hi-1C
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 16:21:29 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A812F140004B;
 Wed, 31 Dec 2025 16:21:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 16:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767216085; x=
 1767302485; bh=6hqbZpbBF/BQ05RXAOo3PKo8SSusZSrKFNQcMWc2oeY=; b=M
 DFeID48JNiV94+uTPZxrSTpEd6b2Sq+PiwhGs9/JU2wmNOL13v6w7LJo7Txn9Rhu
 cZLlrXBIsiro6PEg/NgnmvvMvNcFPjG19kXQPvFpmess5Fe5WTPMyqEMLhBjzTUx
 4VKzrgg03T4Jgjew+5xak1Vd6i726YRrmrvCQSHsfPdTAzbX3ILyIu+W11S1jWI0
 yCB/aYubZZgtsN3YtAdlHaXPVdynX+jx5I0dA2RMVNs01zy1c/TT/WwxRXEgI6nH
 aeieVvSGHwpP4mY5e4q4FMvjzqQlHS/8WGFiSBdJZM4gwbEADHGKXglL4x5SlKLK
 L5t3xshDXZAc9/wHz6YiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767216085; x=1767302485; bh=6
 hqbZpbBF/BQ05RXAOo3PKo8SSusZSrKFNQcMWc2oeY=; b=XmVTGtU45gEl796AY
 l7PfkzFLtwLCuqAewkLmPSY6j8ZK5wII0vtTKsdMiu2LynnI2EN7MgN12/OBOlHA
 zqE91l6qZ5qbsDzeK0cSV36SAfyuigbdKyR95ihG22HhwdyykZY7b4B6hpkw0AqI
 4HGycjLcfYQ7C66ApRRo1b+pSO+M04picFeibXJe1/6U7Xpy5bpOkJgU2cqz4DII
 6BbQDqH3VtHgd3C6iVhR50xwJkW2sbKYNaQUu6yFwu5KlYnuLNrfLwEZxvXCpiuu
 0vAsCgINBX/a6NIDQtD4qRAVN9qGcwSUiuJlAQD00C85n96o8uvWpyJlhWPb3iXh
 iPIFg==
X-ME-Sender: <xms:1ZNVaWJpf3Ca5ztSvIIXPxL6WGrAxKUQusuguRBKcxa5SoLPlvEFAg>
 <xme:1ZNVaVniFzNqvtOq5kwBN4RIMIPlFfG1R1-rAtEZVBer9ozDqYEEqZkCcAsx6PEPk
 TOi8SdNdc4IoP3CCPR02__Jp6hHNW2vRwBtLi5or8lnI5X0uwcPNtw>
X-ME-Received: <xmr:1ZNVaUFeEUOmLymxceEv6kKhptDz1QemMRRJvTdwChIaD5oPr5sb553uc4Jl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeeliecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsg
 grlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:1ZNVaVELylPBE4AYfZ30JhNjAALc19-qSrpz0lpG1Ti4B7xRpaokGw>
 <xmx:1ZNVaRMTP0qxT6GSLkwSEkVABzmzV0YVoYn-RRpeEdXDCkbQL890BQ>
 <xmx:1ZNVaUGyE2K4lyEKhSSw0wQvF962-GMjnAioxG5FiYt9cLeiPvkq0w>
 <xmx:1ZNVaYNVSJS0FePGOR17qaqUUa7oDBv-HiaTB7RNnslrLgDfdBV2zQ>
 <xmx:1ZNVacyjqEKZVJsBqEfLAqSZrTLLPcqcDpBL1tDPpaZtpwIOh6OZK4Oe>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 16:21:25 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9e5a9f7a;
 Wed, 31 Dec 2025 21:21:25 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 1/7] ati-vga: Extract ati_reg_write() from ati_mm_write()
Date: Wed, 31 Dec 2025 16:21:01 -0500
Message-ID: <20251231212107.1020964-2-chad@jablonski.xyz>
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

Move register write logic into its own function. This is in preparation
for CCE engine support for register writes. MMIO writes will have their
own distinct policy that doesn't apply to writes made by the CCE engine.

Note: Because of the recursion in the MM_DATA handler the calls to
ati_mm_write needed to be changed to ati_reg_write. This means that
tracing output changes slightly for MM_DATA writes. Otherwise, this
is purely a refactor and does not change behavior.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c     | 25 ++++++++++++++++---------
 hw/display/ati_int.h |  2 ++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 049da69175..f9be5b302c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -562,14 +562,9 @@ static void ati_host_data_reset(ATIHostDataState *hd)
     hd->col = 0;
 }
 
-static void ati_mm_write(void *opaque, hwaddr addr,
-                           uint64_t data, unsigned int size)
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size)
 {
-    ATIVGAState *s = opaque;
-
-    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
-        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
-    }
     switch (addr) {
     case MM_INDEX:
         s->regs.mm_index = data & ~3;
@@ -582,10 +577,10 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                 stn_le_p(s->vga.vram_ptr + idx, size, data);
             }
         } else if (s->regs.mm_index > MM_DATA + 3) {
-            ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
+            ati_reg_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
-                "ati_mm_write: mm_index too small: %u\n", s->regs.mm_index);
+                "ati_reg_write: mm_index too small: %u\n", s->regs.mm_index);
         }
         break;
     case BIOS_0_SCRATCH ... BUS_CNTL - 1:
@@ -1062,6 +1057,18 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     }
 }
 
+
+static void ati_mm_write(void *opaque, hwaddr addr,
+                         uint64_t data, unsigned int size)
+{
+    ATIVGAState *s = opaque;
+
+    if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
+        trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
+    }
+    ati_reg_write(s, addr, data, size);
+}
+
 static const MemoryRegionOps ati_mm_ops = {
     .read = ati_mm_read,
     .write = ati_mm_write,
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index f38f6a43d7..3ee891c888 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -129,5 +129,7 @@ const char *ati_reg_name(int num);
 
 void ati_2d_blt(ATIVGAState *s);
 void ati_flush_host_data(ATIVGAState *s);
+void ati_reg_write(ATIVGAState *s, hwaddr addr,
+                   uint64_t data, unsigned int size);
 
 #endif /* ATI_INT_H */
-- 
2.51.2



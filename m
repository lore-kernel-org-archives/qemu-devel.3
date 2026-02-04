Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51670E9D40D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vng1Y-0007Hv-Ft; Wed, 04 Feb 2026 11:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1L-000745-Ls
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:28 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vng1K-0004Y7-3l
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:46:27 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 09A5A1D00175;
 Wed,  4 Feb 2026 11:46:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 11:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770223574; x=
 1770309974; bh=WHB7HXBOW3/SU+k+R5lQR6UvT5Yz3Ua6vmh5gkfmy7A=; b=U
 evrr9rSRS/kYdz82nlILkA3auvNQf+Rdm02Zin7F1CK6ntamRELCBEn7CV3Lsbew
 eB3Ibo0KIys3S1TFhSoStKQ4RMxYUtPgbas/+ag1QZPytRW1PTKideCLFsO21yiw
 2xR+LJHOF+rdNvyLG7OvrjhhDIzo5Pw52ECx/eassXOeLufzKlFKTbuzFnwW/RP2
 kZmwd0kK0Pi3yz2/L8+6OQN0j2GM7/ExReDrX9OYRSOh7NN9LpyM0c+95KARcG16
 kLsO8EGagYBJUrTEqI43ixoNR2cdHjdtL9PseYxKRpjttKT8QpfJCG3089nhnh6p
 ahAzRPAbeMh3vtfrTY+gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770223574; x=1770309974; bh=W
 HB7HXBOW3/SU+k+R5lQR6UvT5Yz3Ua6vmh5gkfmy7A=; b=GfJYdGSR8vJ213fIq
 2YSFonkwNydIipkgHpqLn+Ni+sBByW7qpjWMRJKOTEWdWyO1qdcen/RBOJvAyiea
 2VcvXqcsVBach+knO+dVjYkNzcQVWonIPV6E26/A+lUEGs5u9A1utB74k3u+AfsS
 YMg7rF0Jv3/LODN3fQva2rUTZfmxOSKD79F43eUSnrBEuOchThYBy+kjIV15rru0
 O/OxNnjIh8vsNbqOMxSviNDyZntUcOAjQJtRnR+dmhkv1EQJp+nqJxE+iMgHxWoM
 1cekVT6ouBNz36qZzxehoyhfu9hiCvDSUgWBqPHjbdiDVx8CBdwowXffYVHoxZcX
 S8zmw==
X-ME-Sender: <xms:1neDaQTThW0L9oDyTWYp7wzv8vlIXT-f9E68PFP7-VCJ6Ezl2C-E4A>
 <xme:1neDaVNoEo8SP7z5lAPzN9ZSShupTg_EP7x34ZaC91E9x7EE93D1lqZh2LZPTxtPJ
 wyQy1nRXnE89FyAt95QM_a7iijQYjddh4mHOW95DPGT4FqE0wOEjQ>
X-ME-Received: <xmr:1neDabMFk8-09CIBzUh73SGQNHTJfxxDSff2Rnr8rseWW2ZZpXm3m2KaDMF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthho
 nhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:1neDadvChtyvdRVCb1j7O5YOJg6AYoyZSFg3s3zLwACLPaIxuziFHQ>
 <xmx:1neDadU0t-7Ia4gDBTj-JHpha4GaurNYTNnqeTt4hr8YY14XylS4bQ>
 <xmx:1neDadtdZrKSBHsTlVeW7njKFGRC3Srb5Ue3R5TZzl17DVRp0CD-Ig>
 <xmx:1neDaRXCn8svP1JZKCx4M7hF2ZJ4-b2il2xFtp-c93Bl_K0_yoFzvg>
 <xmx:1neDafZmFTB2PH7FK92f37ztb_TaRjj2gnNQ_9M56SCcNXu9Dv-4ER_u>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:46:14 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8c0ca560;
 Wed, 4 Feb 2026 16:46:08 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v8 15/18] ati-vga: Move source bounds validation to ati_2d_blt
Date: Wed,  4 Feb 2026 11:46:03 -0500
Message-ID: <20260204164606.3425246-16-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204164606.3425246-1-chad@jablonski.xyz>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=chad@jablonski.xyz;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

A call to ati_2d_blt implies that the source will be vram. Checking
bounds is useful in that case. Other sources (HOST_DATA) will not make
sense to check against vram bounds.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8a820bc91f..463da001d9 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -153,13 +153,6 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             return;
         }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
-        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
-            || ctx->src_bits >= ctx->vram_end
-            || ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height)
-             * ctx->src_stride >= ctx->vram_end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
-        }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 ctx->src_bits, ctx->dst_bits, src_stride_words,
@@ -267,6 +260,12 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
+    if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
+        || ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x
+         + (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
     ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0



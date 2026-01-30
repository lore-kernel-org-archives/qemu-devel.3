Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6BCE6BF1A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 14:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlppq-0004xa-7L; Fri, 30 Jan 2026 09:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppo-0004wk-BP
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:56 -0500
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vlppW-000394-78
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 09:50:41 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9D0AE7A0136;
 Fri, 30 Jan 2026 09:50:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1769784626; x=
 1769871026; bh=jFkm6fmhGUS6Iee0jwQIzG56FRBVEb+3L9zvD+WRoXo=; b=X
 mJTT4+0J/nG32CHzWy7RITQaUtf6O55X0trZoGWciaoSQAmWqkJvcKIHOhNOtb/Y
 mO/T8OyVSWebAvK5FKH0Wv9lpfwewUPax0ITBNxr5pvh/IaHi3G3PaUsIz4LJZfl
 pW/1ST+fzWFEBm8Nri39TEahXrGFieIbaSyVhmnQnPzjYMx4vUgOD3+yLkPAZ5ad
 o+sDUIlJ6TnihtSXKmb0gDozj1Uc2Q17WpKmvx8ct5NnKjYFLKuDuMp0Iv8xWwuK
 wXyEIYP23XqfuOUBSJIMprzzlCURRUSoBW64awSx788I0ZkFIuEjRnkcz/qsuyGz
 ypjD4Tf/ohoo5TVvUHxEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769784626; x=1769871026; bh=j
 Fkm6fmhGUS6Iee0jwQIzG56FRBVEb+3L9zvD+WRoXo=; b=BcMDDqkCRYIK2W2af
 u/wpnbEcMZS5YQxe2qa88m9sAYQfnzDkP8oGz3wmesMoa8mHZWRtX4N00xqs0Khe
 H8N4ODvuvHU4FEeS9o6uFpw34fDn945qvsIo1rUze+LnN+Of6Spc5s/ges8NN0es
 e01uNvfvZjKhbrvYoeNohft70iWOL7pckhEcedqcyiaCSPTkPl6t4Lhg+Rk8+8jA
 3w0KkoXE3zhWByjaCmsy6BNXs+AWAgxlciMJXunWHmXFDQLzAfsCZn/h7teoytmM
 Vv8/j+P596oFltlkm0zLbyFfBUW/WhiAjjtW41Nl4zhZp1lMYoY5lAmN0ykiCLZY
 8rfkA==
X-ME-Sender: <xms:MsV8abUpFRKheNiOD2SHHFDc-vozbjm1tRX86vvGBcaEf1S0HaB4Qg>
 <xme:MsV8abBXKdFTft0zPYnnXb_NjRLSFcW25A90RIeUQpWArsQDc2nebiEEHvXhWIC8g
 7LHEU29IeFT8YsF6juhuuld1XlzrkUmTv6lEA4nsZnyyAbmrvRexjI>
X-ME-Received: <xmr:MsV8aUx-IN46VoFVpbXKNfisn0pPJ7Bmj3d2WiO5d5gGEAZIndmeMdYrW0Hb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
 ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhgrugculfgrsghlohhnshhk
 ihcuoegthhgrugesjhgrsghlohhnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhepgf
 eiteejhfelheefieetjefgleejfffhueffvdduieejgfeuueeuvddvkeejhfelnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrggusehjrg
 gslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheptghhrggusehj
 rggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:MsV8aQCSKAS6fb95xw6rThzcTwbQk6cqGhK-i6HsW-idZKMDpQmHYA>
 <xmx:MsV8aZal0zr1VcywG4y1xbjnCgKA9uAF1obmcIp8HhnsgfDwxj_mew>
 <xmx:MsV8aQjGu_eNAp__gWkn6JzJ_-modQZJU2hNZBi2x14yRl-rg9lhTw>
 <xmx:MsV8aT6LERwRmBtlKDNRIfi3P8ROK9jETOobLpi_8U8R9ubOIMF3Ww>
 <xmx:MsV8aetB1y-JYUee2eefQYM6vyTgVbJqvtJG2suSPjGmHxRnQp3vyLSv>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 09:50:26 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ee27a70d;
 Fri, 30 Jan 2026 14:50:19 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v6 17/20] ati-vga: Move source bounds validation to ati_2d_blt
Date: Fri, 30 Jan 2026 09:50:02 -0500
Message-ID: <20260130145005.731129-18-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130145005.731129-1-chad@jablonski.xyz>
References: <20260130145005.731129-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
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
 hw/display/ati_2d.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 89a9d006af..3ff874c3ed 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -155,14 +155,6 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
             return;
         }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
-        if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
-            || ctx->src_bits >= ctx->vram_end
-            || ctx->src_bits + ctx->src.x
-             + (ctx->src.y + ctx->dst.height)
-             * ctx->src_stride >= ctx->vram_end) {
-            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
-        }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 ctx->src_bits, ctx->dst_bits,
@@ -277,6 +269,14 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
+    if (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff
+        || ctx.src_bits >= ctx.vram_end
+        || ctx.src_bits + ctx.src.x
+         + (ctx.src.y + ctx.dst.height)
+         * ctx.src_stride >= ctx.vram_end) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
     ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0



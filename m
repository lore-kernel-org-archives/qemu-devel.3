Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097F6E7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 20:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn0rC-00012m-Es; Mon, 02 Feb 2026 15:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q5-0007Ky-H9
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:07 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vn0q2-0001p3-W6
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 15:48:04 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id A62AB1D0012B;
 Mon,  2 Feb 2026 15:48:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 15:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1770065280; x=
 1770151680; bh=gx3Da9YMvZQEvf4t7Zwfk28zoTGZPSETN0NVxxGKBm8=; b=n
 vppRLbXlPfOA6NTn3IqjMAAwIanI4tTifJNHzxj6E3q3jfPqNsP5mIZycXX7YRW8
 G1qDgKT6c5JSxBQknbI36jaszRUKIBYuUg1j4HyIbED3It2TvNUaEJCbjQeQJ+Wa
 xwVwxLJXdAJSuSZCSsENbiEMBL4Km6uldm8o7P+FdAqqNnpfVx9WXhcLmnsHOef+
 y7wVrKh32ngxWgIa6LpBz5zJ12np3JsHriu4BlSWmMVGBWXKLTuARvVdjwtOE82s
 TcZPPpZeGFyQMABy69odlRmNCtQCN12R2i/PVE6RvTT6Mn69eZmc4LjMEzkKl8QM
 qkCDSxYIHwbf0Y4JHY3Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770065280; x=1770151680; bh=g
 x3Da9YMvZQEvf4t7Zwfk28zoTGZPSETN0NVxxGKBm8=; b=MnykO9WIYlA7KxnTm
 pb7dSBGXFzfgPet2Rdyb6dj749oekkHn6vuPiJetFYoWnPRd0zqZWAsVkPyOrp7f
 N8CjNdy35SHM4mY8cmU8OubC7BNOsa/0bgV6UdHtebLntqnrbZtmknOFuNddL2My
 gscvgv8FCR5Lk2JL6CoKUja0DAtDDChuZmOsB+jbUwT1KAvB2YahLbgbKyFoLM3o
 ginb/x1DJpsaY/3ha7t9BNo97kQPVj0rncjxWHgwIICkdeLNQXoG9UScuU1m9Qpv
 gaF2MvQABgMbnAIpGAAvFQJBWdxclFlUMOZXROmgRCxG9J0+kf3Y+pF4OJQuufW3
 bHSXQ==
X-ME-Sender: <xms:gA2BafMs3_nxt2e35JKG4UYG0CBFWRzt3eVWoa0m5DNYIM4pul5pFw>
 <xme:gA2BaRZtPsJ7oVAnN4Y2DlBymSFLT4nLv_G1fOrZbPRJ5ev5wafJpeeEmfPIzm9ly
 8cdgzzcqSkyDNzO0ZdOzTSD2MXtU8ACwGOOqWmytmH4hrMic6L3HoY>
X-ME-Received: <xmr:gA2Babo-XKPdlCHmb0gGAtJO8VhN-FXQc5kVM6K1GhtjV7pQspHlYeFhsNQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gA2BadZU5HaprGakK2nQp82NvaQdOcJqb63jROKNPQFUVgklYisL3Q>
 <xmx:gA2BabTeGfe9efXNcrWZ0x7rHzm833E1nCej4x_gllKF0XAekSyYDQ>
 <xmx:gA2Bac4Lm-ReQgeA2SFrdG3A8BixCsCafgXmBnGHBNxDGekZSSTotw>
 <xmx:gA2BaYwkWpbUg26vN3a6z55eRiX-G5eTlPLXfmVh9w_9yd2VX-cJ1Q>
 <xmx:gA2BaSHvG-SffMkcttnLHT5sMMlqnUl5CAlnNCGGo1SQxDCG8R6dDdCX>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 15:48:00 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8f18439c;
 Mon, 2 Feb 2026 20:47:53 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v7 16/19] ati-vga: Move source bounds validation to ati_2d_blt
Date: Mon,  2 Feb 2026 15:47:34 -0500
Message-ID: <20260202204738.3080092-17-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202204738.3080092-1-chad@jablonski.xyz>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=chad@jablonski.xyz;
 helo=fout-b4-smtp.messagingengine.com
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
index e1e48ac81f..4b16265733 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -152,14 +152,6 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
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
@@ -275,6 +267,14 @@ void ati_2d_blt(ATIVGAState *s)
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



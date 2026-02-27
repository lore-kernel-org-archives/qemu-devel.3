Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DCA1039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4eX-0003Oj-Iw; Fri, 27 Feb 2026 15:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4eC-0002c8-MF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:16 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vw4eB-0007Qj-5A
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:41:16 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8CAE6140018E;
 Fri, 27 Feb 2026 15:41:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 15:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1772224861; x=
 1772311261; bh=RDbi4ttHSzdqquBLMjV4+kyLt9CNxdkTZv/NdVntPT4=; b=L
 XjUivcWSfsexWCdRmcyuO+dyA6A8u3mOOCTBgs22sZ8OSzx3DH5SBReiuCPB6gfG
 YSyRBOLY9Q9/5gSMuHF0QSZNNApycr4NDBSna14i5WViIZvVu8yy+2yslnC1GjoJ
 ecxDPxsfaG9gVH9VrXpKN37rAcw/HJCfc6NNFDqYI9M/1g74s3jYMRtgIA6t/9nL
 2IpPnDU/c4LVUPSjM9GkpccCplTSiYiM4PvvAqLb1wNycmUgPrQLISSufMP2l4hy
 EJthGXhMHHOxt9mIjg3QzjVlJI6roUqzxRaxlKW2IqrQLC35rDKWK7hTNJX4mSE0
 2FwOcruhcqeKrU5L5kyIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1772224861; x=1772311261; bh=R
 Dbi4ttHSzdqquBLMjV4+kyLt9CNxdkTZv/NdVntPT4=; b=rzofRfbYtTebl8L2V
 FBwjsReIk3dmyAPPd6HRzpYtk/wlPTGr09NYUbVAkePn+PDyhpq+ywMn25NlSG88
 PqMQqieoDWtlTZp1WuGMOJJ/FC68wvtMKig3SNXCJJS1QY2juJ91+x36skG9KPjW
 XQTdy/XloX+HKzVjGnpMikLwl9elJtopNzJJKGhPXSnyG760YrIC2VNMZBCRIZ1z
 LHpF1MMuX3fgSEHq5PiiP5+YBaOVjPfgukqp+4FREzOBkNxeaz78dfSjCGENMvXQ
 Pyu7beNCfYCz69FIsbMIHDBu3cpwN8zaDWoAUVUA+SFN/a86XPUjGjqiYoqYjH18
 LJSSw==
X-ME-Sender: <xms:XQGiadvmGJwTRp2bJzL5IxdXxU1Sw0D43128gfoKV3_CDFqoLrF-BA>
 <xme:XQGiadXzE63CbIfhMp2Aad3DsPtr91gmpFKeWyCiXxOtwC3aZaOXTCggGRTR2faMJ
 XRNXbyIPIuXxaGbT0M2OXNKxX1nInQcKMX02jPnN_YweSn-_LzwqCQ>
X-ME-Received: <xmr:XQGiaZHC_r-sKttxVp9hTfRb5JYs1LYu0y_fbXA0UDSIwZEC552RYz7WKNWb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrg
 htrdgtohhmpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghp
 thhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:XQGiaf1HlEOGAltomeWHD5isO7jh22QaDe51bM2H4sa7CVrej8usWw>
 <xmx:XQGiabOxIfd7gctVxR8NV8Blg4H6pxYUz8Rzj1gNUIP6ykN5fkQ8xw>
 <xmx:XQGiae7U_40bUQCMFu-Jy0yZ9aqMGGBhw7Rpa5YsGOcZcHE0IF-hZA>
 <xmx:XQGiaV3F3FS6biUZiw_WuuLb3xHnrDLXKCe8Mf6FwNCHRKP-hwUOBA>
 <xmx:XQGiabwMhcXhmhLBLtEToLmcT9RPY-bUz3c1HCk7DGJMOKoVEMoihjSQ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 15:41:01 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7f897a38;
 Fri, 27 Feb 2026 20:40:55 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v9 15/18] ati-vga: Move source bounds validation to ati_2d_blt
Date: Fri, 27 Feb 2026 15:39:41 -0500
Message-ID: <20260227203944.746471-16-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227203944.746471-1-chad@jablonski.xyz>
References: <20260227203944.746471-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

---

Changes from v8:

The source bound validation was being performed in all cases, even for
blits that weren't using the source. It now limits the validation to the
ROP3_SRCCOPY case.
---
 hw/display/ati_2d.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 440c1d159a..dbc8791824 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -138,9 +138,9 @@ static void ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
         return;
     }
     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
-    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
-        || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
-         + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
+    if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
+        ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x +
+        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
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
@@ -268,6 +261,12 @@ void ati_2d_blt(ATIVGAState *s)
 {
     ATI2DCtx ctx;
     setup_2d_blt_ctx(s, &ctx);
+    if (ctx.rop3 == ROP3_SRCCOPY && (ctx.src.x > 0x3fff || ctx.src.y > 0x3fff ||
+        ctx.src_bits >= ctx.vram_end || ctx.src_bits + ctx.src.x +
+        (ctx.src.y + ctx.dst.height) * ctx.src_stride >= ctx.vram_end)) {
+        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
+        return;
+    }
     ati_2d_do_blt(&ctx, s->use_pixman);
     ati_set_dirty(&s->vga, &ctx);
 }
-- 
2.52.0



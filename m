Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665FEB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7e1-0006Rr-Bv; Mon, 02 Mar 2026 13:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dp-0006Ld-32
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:13 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vx7dm-0006YR-5W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:05:12 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 605B9EC0621;
 Mon,  2 Mar 2026 13:05:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 13:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772474706; x=
 1772561106; bh=ktkc8VwNaUaHcHkWDm7sBHtmuJOSKxdPdjPi2PDv748=; b=B
 XnrOc/tlVn7o6eBVdp8ydGwr7q8XBIIpQOEORca2gUaxFtir4FywSz+FOkzjtg0K
 y7NawIe/IJejTpkMGyXnDXxm/J3aMfUU7qezLHb0EZnjhIlqqX3ls2SLWwCpHnKg
 Jb2TYT4Bu50GyU50Lsdym7E1N4vFZgv059e9zhZoMQ4vZaeDTjK/eWwqFWhz6f00
 n0wlHK5bc3biYI6gR4ktVYFlGnrIHTpSRMsEkKRQQTgvKgoOtGK7csMUS8CEpb/S
 wjY1A9M11dLvVTC49m0kWYwW+g1DgYICYzbLQUpsGmcpnse3XyVdLi+ClgJaGcc6
 lbTPJQsgP/j8YCVSDwJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772474706; x=1772561106; bh=k
 tkc8VwNaUaHcHkWDm7sBHtmuJOSKxdPdjPi2PDv748=; b=s/25CsfXWwPiFqgX2
 Roob4JW5WPqvkrEgoOovrmsJC77Ijo+W4rqLB/Wci5lirDwl5woYRjDChl8wpIE5
 JX/bzcenltx+xV4QSIR/A0QSTGpxrWkJ0NeXk5FGBsa121sNLcU72Jsx6XWC8vTY
 SBoNQfhOHQYQyPhI3amqfZ/EZPUj6pG6aBTg8jxFORtrcMNcWs/PfKtozNQcFjuQ
 yUDzNtj2m89T/KYacCCg2dCkMXi1ZpJTnzWQpYzTwS16D2FW2cs/ujt4/uGXiWFU
 286szbTNu+uws7cAe9aiH1AU6J9ScgSZHoQeDgYXUTFN31lSo0ul2zuHRAemQ9x0
 ESOcA==
X-ME-Sender: <xms:UtGlaR24qfLIH3CfasgIT-9CJ16HHr1TS-hBLIdDnSaKqjmE3K5geg>
 <xme:UtGlae9YlsnQFRvKDrx6JPJuJ3eEXeJbq9QWCNMaRE-LAh4EEkU-pS3mbXm_51I6V
 XWFdwJ0oSvvt_vO2ZA_O3bYuYBNZaVzSiImaBRekgIJsJH_9g9El88>
X-ME-Received: <xmr:UtGlaaMqUcqSYyuHL1ro5k2cuVoq_5evqI8OGlTWA3WGuBGkqayHyQekyyYq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrugesjh
 grsghlohhnshhkihdrgiihiidprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhu
X-ME-Proxy: <xmx:UtGlaafDwj4j8Gpfhnrkl4AoM_RxEqEWDBhCZrn2ODpxpRpfto_E_g>
 <xmx:UtGlaRUVvxkNa-EfLgrBiJRr2tAuOGOju0QIdwdOCfbzv6n2wwXWXg>
 <xmx:UtGlaagxpUymb0nIgAdskX0r-Ly-M2fXK-h5DBtVQ7aLnPCJaswPgg>
 <xmx:UtGlaY9cDNqS0ZssnwJjIGg3Rk7e8lpked-ilTlPd2JXXl9pnmGRbw>
 <xmx:UtGlafYwJaAm_uLbKHPBmSDSYi0biTUDRI01tlK_Zaz-PQvhJZKNkOf5>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:05:05 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ad6f8d09;
 Mon, 2 Mar 2026 18:04:57 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v10 13/17] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Mon,  2 Mar 2026 13:04:43 -0500
Message-ID: <20260302180447.1078098-14-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302180447.1078098-1-chad@jablonski.xyz>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=chad@jablonski.xyz;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

ati_2d_blt remains the public interface to the blitter but the bulk of
the implementation is moved down into ati_2d_do_blt which is passed an
ATI2DCtx.

ati_2d_do_blt returns a bool that is true when the blit succeeded, which
means that a screen region will need to be set dirty. Otherwise false is
returned.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati_2d.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index f1536e5425..df8975d9d7 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -123,27 +123,24 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
             (ctx->top_to_bottom ? 'v' : '^'));
 }
 
-void ati_2d_blt(ATIVGAState *s)
+static bool ati_2d_do_blt(ATIVGAState *s, ATI2DCtx *ctx)
 {
     bool use_pixman_fill = s->use_pixman & BIT(0);
     bool use_pixman_blt = s->use_pixman & BIT(1);
-    ATI2DCtx ctx_;
-    ATI2DCtx *ctx = &ctx_;
-    setup_2d_blt_ctx(s, ctx);
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
-        return;
+        return false;
     }
     if (!ctx->dst_stride) {
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
-        return;
+        return false;
     }
     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff
         || ctx->dst_bits >= ctx->vram_end || ctx->dst_bits + ctx->dst.x
          + (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= ctx->vram_end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-        return;
+        return false;
     }
     switch (ctx->rop3) {
     case ROP3_SRCCOPY:
@@ -151,7 +148,7 @@ void ati_2d_blt(ATIVGAState *s)
         bool fallback = false;
         if (!ctx->src_stride) {
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
-            return;
+            return false;
         }
         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
         if (ctx->src.x > 0x3fff || ctx->src.y > 0x3fff
@@ -159,7 +156,7 @@ void ati_2d_blt(ATIVGAState *s)
             || ctx->src_bits + ctx->src.x + (ctx->src.y + ctx->dst.height)
              * ctx->src_stride >= ctx->vram_end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
-            return;
+            return false;
         }
 
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
@@ -262,8 +259,17 @@ void ati_2d_blt(ATIVGAState *s)
     default:
         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
                       ctx->rop3 >> 16);
-        return;
+        return false;
     }
 
-    ati_set_dirty(&s->vga, ctx);
+    return true;
+}
+
+void ati_2d_blt(ATIVGAState *s)
+{
+    ATI2DCtx ctx;
+    setup_2d_blt_ctx(s, &ctx);
+    if (ati_2d_do_blt(s, &ctx)) {
+        ati_set_dirty(&s->vga, &ctx);
+    }
 }
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED6EB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFne-0008AF-3w; Mon, 02 Mar 2026 21:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnT-0007pL-Mb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:43 -0500
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxFnR-0002r6-4e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 21:47:43 -0500
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 714611400215;
 Mon,  2 Mar 2026 21:47:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 21:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1772506060; x=
 1772592460; bh=hsOoV5SEFnjT+HmyKMFdg4LlrnghzAeccgr1Y6x1SZk=; b=H
 mPcbyTlsv0kIep+MW4YNTMv9xWSbGw2zoFNHhIUAhS0XfM75ROdjln2o5TWLyigJ
 QUyvuQecTISatAbTG3Jy8N8Wi9NqNgfHwAgSnS3+Hx1+oS3QK7xDixHmctayz1SY
 0WMUXe31x0GmFMM1PqAya7bI6gyuAdiZavPeWtbmjqnqkH2JgwHnMoV3ASXeH5tD
 K/0Qtza75T1f9d0BgnOy/fkgFAjP4PfVqPOpMWgHNIhVhcFj+U0VONhEqedJIJvg
 DaCR+pqVbMlUkb7+61a4dm7LmHBZwUmGxO+gV0/4RJlGNnvD24/daVNXGKSfrZ8b
 c5fE0ca8Wrva+OuVeMiYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1772506060; x=1772592460; bh=h
 sOoV5SEFnjT+HmyKMFdg4LlrnghzAeccgr1Y6x1SZk=; b=CxHQvNOPcQ/sbYmVq
 U8LeTdTlhiEsklczw5qebv9T5VFKnXgaVh023Blm/2zqWmLky8Z3oqhUkszkPMsd
 bxWfR5YE7pVIYPnJ0v3WhAjtQ1VTzqB/C98wuby0zUColwcE5rawqLLzO10HSr0r
 EnaQWj/VK8KhyvSNrbGHUg61P0j7OZzEvBTssPSsMdaE+QLCRh7IlFAb1eQiI9t0
 p/GwWjUWfkUuI3/KYscgH1bcWvTl8mrx+B5X5Qqqgo9R+AeZCNxcuocZZuIg+eyX
 bEFGNt5ecgEWQR7Mfj3GL/Kk4M9DAcWsqttZ6/4o/1u4HiuqzCEcLMaozSbxakYA
 yoMNg==
X-ME-Sender: <xms:zEumaY9Mr8Tu_Hgk4adUmn45sx4m_Ox-GIdX5obXM5TureW0B6o3dg>
 <xme:zEumaXn5bO5aE-Ek8pJK-tZKebHuc5xX9eujGkuzYPpbPy4VfNnbAWzgrRAJsesor
 25lnP0hcaniq7tplQ8Sh-pVBeHyAYDjsrvc2jMgPgAj8fqdQPRhp_0>
X-ME-Received: <xmr:zEumaWWBJ_l991SvWVc2rbIbonJ2cxlNgDOOg_wXsYTfJ0Zikrvx3mT3WZFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpeevhhgrugculfgrsghlohhnshhkihcuoegthhgrugesjhgrsghlohhnsh
 hkihdrgiihiieqnecuggftrfgrthhtvghrnhepgfeiteejhfelheefieetjefgleejfffh
 ueffvdduieejgfeuueeuvddvkeejhfelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggp
 rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtg
 hpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrtggr
 nhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:zEumaUEA0Phpfogq2J6R7fA2-c_bYzMZ6IU2XbPpJRTa3etx1_ETdA>
 <xmx:zEumaac-zJ9TgiaqxtqQ43LxfInnjr_ZInFbZ1ALTFLeA1MBSpdPdQ>
 <xmx:zEumadIQMSIUJq5QXCwkHIMFfecIT4PZtfdx90KJDGeYqh_BJJeicA>
 <xmx:zEumaXEd0pcz6KxOAUQaovO9Ikc2LBX66v72aLjIFtx7sQ7-aGdHyw>
 <xmx:zEumaaBLoTbrL8SD2cM6-BDhNfFvBkwZ1j2HX2ihCaAipryvaN0_B-cS>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 21:47:39 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id cde559c1;
 Tue, 3 Mar 2026 02:47:34 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v11 13/17] ati-vga: Split ati_2d_do_blt from ati_2d_blt
Date: Mon,  2 Mar 2026 21:47:26 -0500
Message-ID: <20260303024730.1489136-14-chad@jablonski.xyz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
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



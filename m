Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WOTpTgr4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUxw-0006Um-Ij; Thu, 29 Oct 2026 14:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMUxp-0006U7-Nk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:35:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tristmd@gmail.com>) id 1xMUxm-0000br-Mr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:35:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so20895905e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793298895; x=1793903695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=INKTEl25KXEWsfko0PR9TpXq2XvLVGJ9lTjKoiSeLf8=;
 b=WOTpTgr40hsflznT39Y3NdjUU2Ftmu3BXvtKsmDEkvRyChQGqWbdoX5TCnvHCW0r/O
 evjSm+vjuRrw6QO4qoFTi+J2VN8ukdaOrtmJqQob/9pyg6pCos0fHiM4MTvHA4HuZO7N
 fnNSfWLpHjU1DI5TS8Pw2vzdWhtuqcpIT6elrXhp/zZi1o8HbL+SgPxzJKKbpwSeNmCS
 ICB+PZWSmwI8cCTDfOQSe/GxHGho+Nar1xhmJbnPfyGGmRmvZhvPZ8orlQZOoLtrIY1a
 FEvbiJvgGEiA1kwoLi6tUag9jM7jbcqrp9yGCsl8ys+GkFconsoFDncJ8IlUVI+C7W+D
 YSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793298895; x=1793903695;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=INKTEl25KXEWsfko0PR9TpXq2XvLVGJ9lTjKoiSeLf8=;
 b=RLn2e7HSOQWdSEoYx6czowVowds3X9hR8IzZ42YM5hzLTpJy9wAsdZ8+PPN7+g4861
 Ggv2txGbMtpNxJ7Fg7eOQhZ0hbbM/0CTkrOAS9ooIrZ2pO8WNM8RQO5Gi1Bvd73PYDtH
 TfiJfif5jgEV5Etpl3XV30SZbRcKFURqeAmkOzYnP+I8j7ymqrom3devh9nrrOoW+5Oz
 M5RmweWT3h6XKFPjecNiM55oz1cNK3KVTOd/KhFMmrj2PNqe527JdhhZusftng4ToefB
 zs948UGtR6Nhi0WMgF07DB1QzH1uOZNKyePdMZL7Fr4V9R8Fzh1q7og6Et+9/BNaeQnK
 ADKg==
X-Gm-Message-State: AFq9FYLDg+ONDtswz/9R299PSkTOLMPh1SLV6xRFlQXiJHy+CFC8cJz3
 +iEvauvyNp78PTzgTRzS1ApWFjuS6N5PPeHvtIbP3EG5m5svxLtpsqhUv14Z
X-Gm-Gg: AYBFou0oV8eB20xl/LgDiA70cmHbABKWXPF5E6nw58wB7AsIa/jOzQSslRukkbJyjk2
 4axbLX1yliUUTk0CGEdgA38zLiXpl6XpuHuufZNQQMkwPUTjS//CRHWmu35nYlqkMamZuVqEZOm
 wWK9AMLa/Y4pGq/G+3cY9OAj/f9bzP4h2uGVANQrLXjhgG7mozPrYyx+3X04lncqdMQLVIVEEi1
 UQhsG4b7OOtwgO+rWENTFOpWUV+fe1s/KggfxP9o5mPAr8aLSHd3CO4lD2xkHNUZRRS6N3vkD1d
 7qmE+jaKxzAcByyyiEmSW4mUFBjAPCew0WAItSkRIWjrgD8Q31Dx4O+rDyKdL5CqlrtLcl449Nd
 rlzYKX0wIbyw8amFDHFWk5HP3Ku8RPrzonbaPMjOuL1Tm86hOsH6mrCVCbGbdZgz/HKXKVFvheG
 fLlgZHUJ3IkKayhHtHqdQT/xZGVBHh4I57t+OUiG88Wjy7TlzjQVaiWwUPf4ihBUcg5e6BjS3OK
 9mySJ0TyWIgtWd79pIOjpIMgjPWO+mGueEZBnj5LuQgHsL5ns+T2e7/ViaPAQ13vmjRJRd6s7di
 ToFsJsd52FbVtuhSrF4=
X-Received: by 2002:a05:600c:3b02:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4a967202e72mr143948355e9.13.1793298895478; 
 Thu, 29 Oct 2026 11:34:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eb99bb0sm104772f8f.50.2026.10.29.11.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:34:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-stable@nongnu.org, balaton@eik.bme.hu,
 pbonzini@redhat.com, kraxel@redhat.com, tristan@talencesecurity.com
Subject: [PATCH v2] hw/display/ati: fix integer overflow in Rage128 2D blit
 bounds check
Date: Thu, 29 Oct 2026 18:34:52 +0000
Message-ID: <20261029183452.1551287-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=tristmd@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tristan Madani <tristan@talencesecurity.com>

The VRAM bounds check in ati_2d_do_blt() computes
(dst.y + dst.height) * dst_stride using signed 32-bit arithmetic.
On Rage128, setup_2d_blt_ctx() multiplies dst_stride by bpp (up to
32), producing strides up to 524,256 bytes/row.  With large
dst.y + dst.height values, the signed int multiplication overflows
to a negative value, causing the bounds check to evaluate false
when it should reject the operation.

The subsequent blit loop uses unsigned arithmetic for the same index
computation, producing large positive offsets that write past the
VRAM allocation into host process memory.

The same overflow affects the source bounds check in the SRCCOPY
path, where (vis_src.y + vis_dst.height) * src_stride can also
overflow when the guest sets large pitch values.

Fix both by pre-computing the end offsets as uint64_t, which
prevents the signed overflow while keeping the existing bounds
check logic.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4646
Cc: qemu-stable@nongnu.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2:
  - Actually use src_end for the source bounds check in the SRCCOPY path;
    v1 declared it but never used it (Marc-André Lureau)
  - Sent standalone; v1 was part of an 8-patch display series
 hw/display/ati_2d.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 7a4a115..cfa4947 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -157,6 +157,7 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
     QemuRect vis_src, vis_dst;
     unsigned int x, y, i, j, bypp = ctx->bpp / 8;
     const uint8_t *vram_end = ctx->vga->vram_ptr + ctx->vga->vram_size;
+    uint64_t dst_end;
 
     if (!ctx->bpp) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
@@ -166,9 +167,11 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
         return false;
     }
+    dst_end = (uint64_t)ctx->dst.x * bypp +
+              (uint64_t)(ctx->dst.y + ctx->dst.height) * ctx->dst_stride;
     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
-        ctx->dst_bits >= vram_end - bypp || ctx->dst_bits + ctx->dst.x * bypp +
-        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= vram_end - bypp) {
+        ctx->dst_bits >= vram_end - bypp ||
+        ctx->dst_bits + dst_end >= vram_end - bypp) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return false;
     }
@@ -203,11 +206,12 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
             return false;
         }
+        uint64_t src_end = (uint64_t)vis_src.x * bypp +
+            (uint64_t)(vis_src.y + vis_dst.height) * ctx->src_stride;
         if (!ctx->host_data_active &&
             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
             ctx->src_bits >= vram_end - bypp ||
-            ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
-            ctx->src_stride >= vram_end - bypp)) {
+            ctx->src_bits + src_end >= vram_end - bypp)) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return false;
         }
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3BEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHll-0002DG-T0; Wed, 28 Feb 2024 06:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHlj-0002Cx-RE
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHlh-0008Ud-NJ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EIxQVyU6go+0CROhf2rdWnGTMgB9SOkWFl2adckGTt8=;
 b=R/i1WC1aCrhoBDQjlw709ip5kyzQm2F2bM4akzNeuw5iawmKhwhpSULIX8Er6k0M1tQ2Bm
 n+dhFlWPoN4REvQZBhz776BxAIFpOb60RL4ZGe/mFDdqsgj3uw++LHm4M5o7J4exHa5llF
 EUuWG0NX1L08GuXUDrEQgxang7LwFF4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-qS86PA65NAehtZJ37SrO5Q-1; Wed, 28 Feb 2024 06:06:30 -0500
X-MC-Unique: qS86PA65NAehtZJ37SrO5Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a43381a778aso234065266b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118389; x=1709723189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIxQVyU6go+0CROhf2rdWnGTMgB9SOkWFl2adckGTt8=;
 b=Z7PnijuG5yvhY1WqxMzbI9mwIwAwViPH6dQJ7beeYmlQ92rixsdn81kxqEqqnskVhl
 1hT86zaep8JC/Ho7WJ5X47bd2iMy/36lrboBsh/YkS55Tvl+XpohcQpkGXrFNksbfE7s
 W/X4s3XDqlFkFSjAsONqSBF8Ktp67XBOfTXbLy2uIdz1gC0Nl1duzJcPNnx/0ylHyFfH
 M8eDevkuQ+uDl4UdPT9b8krgdCkm/9F/W466GyJxYhgerod9H5iztfOHTuvBpmBSGhGA
 nY7qk6wOVEWIqpxVZO1LOzWMFVwjjOGEUs0pepLLtADZnIQt8wSxM9ig/DT4g5DwAnGr
 xatw==
X-Gm-Message-State: AOJu0YzFgIE5fQMcNwO5TyK1OCoFzHhnZ/uznrn4heuerf9VpKLZddB2
 Jz4bNThBMI3a+r+/XjGLLoKm/vcGpTnEiLf3G0GGPba3e5SAGis0TvJLpi/axBpU8UDdjnUdLLx
 w7tGnf691TEiXa9QSZdhz0zB0cpPDN5af8XKedxb1vW2IuYtHgOf6ct/63r2klqp5//VmnR6o+W
 Vc73lerUzRaAlgFF6hqUKUVZW9KJsgGB3iUqjg
X-Received: by 2002:a17:906:ad5:b0:a44:da2:11b6 with SMTP id
 z21-20020a1709060ad500b00a440da211b6mr601622ejf.67.1709118388920; 
 Wed, 28 Feb 2024 03:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpBWxXpzP8EEJCHrLUIRTgRRnQlyjxGy8yr6eghDCHdIjd8Cxj7liIrqkv2tuu0mYXKoQIVQ==
X-Received: by 2002:a17:906:ad5:b0:a44:da2:11b6 with SMTP id
 z21-20020a1709060ad500b00a440da211b6mr601608ejf.67.1709118388451; 
 Wed, 28 Feb 2024 03:06:28 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ti6-20020a170907c20600b00a43c3e5e008sm1281286ejc.205.2024.02.28.03.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:06:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/optimize: lower some ANDs to two shifts
Date: Wed, 28 Feb 2024 12:06:26 +0100
Message-ID: <20240228110626.287178-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 60 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3995bc047db..8ea1f287788 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1281,6 +1281,43 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
     return fold_addsub2(ctx, op, true);
 }
 
+static bool fold_and_to_shifts(OptContext *ctx, uint64_t c, TCGOp *op)
+{
+    TCGOpcode shl_opc = tcg->type == TCG_TYPE_I32 ? INDEX_op_shl_i32 : INDEX_op_shl_i64;
+    TCGOpcode shr_opc = tcg->type == TCG_TYPE_I32 ? INDEX_op_shr_i32 : INDEX_op_shr_i64;
+
+    TCGOpcode first, second;
+    int count;
+    TCGOp *op2;
+
+    unsigned_c = tcg->type == TCG_TYPE_I32 ? (uint32_t) c : c;
+    if (is_power_of_2(-c) &&
+         !tcg_op_imm_match(op->opc, c)) {
+        /* AND with 11...11000, shift right then left.  */
+        count = ctz64(c);
+        first = shr_opc;
+    } else if (is_power_of_2(c + 1) &&
+               !tcg_op_imm_match(INDEX_op_and_i64, c)) {
+        /* AND with 00...00111, shift left then right.  */
+        int bits = tcg->type == TCG_TYPE_I32 ? 32 : 64;
+        count = bits - cto64(c);
+        first = shl_opc;
+    } else {
+        return false;
+    }
+
+
+    op->opc = first;
+    op->args[2] = arg_new_constant(ctx, count);
+
+    second = shl_opc ^ shr_opc ^ first;
+    op2 = tcg_op_insert_after(ctx->tcg, op, second, 3);
+    op2->args[0] = op->args[0];
+    op2->args[1] = op->args[0];
+    op2->args[2] = arg_new_constant(ctx, count);
+    return true;
+}
+
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
     uint64_t z1, z2;
@@ -1294,6 +1331,18 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
     z1 = arg_info(op->args[1])->z_mask;
     z2 = arg_info(op->args[2])->z_mask;
+
+    /*
+     * Known-zeros does not imply known-ones.  Therefore unless
+     * arg2 is constant, we can't infer affected bits from it.
+     */
+    if (arg_is_const(op->args[2])) {
+        if (fold_and_to_shifts(ctx, z2, op)) {
+            return true;
+        }
+        ctx->a_mask = z1 & ~z2;
+    }
+
     ctx->z_mask = z1 & z2;
 
     /*
@@ -1303,14 +1352,6 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     ctx->s_mask = arg_info(op->args[1])->s_mask
                 & arg_info(op->args[2])->s_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer affected bits from it.
-     */
-    if (arg_is_const(op->args[2])) {
-        ctx->a_mask = z1 & ~z2;
-    }
-
     return fold_masks(ctx, op);
 }
 
@@ -1333,6 +1374,9 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
      */
     if (arg_is_const(op->args[2])) {
         uint64_t z2 = ~arg_info(op->args[2])->z_mask;
+        if (fold_and_to_shifts(ctx, z2, op)) {
+            return true;
+        }
         ctx->a_mask = z1 & ~z2;
         z1 &= z2;
     }
-- 
2.43.2



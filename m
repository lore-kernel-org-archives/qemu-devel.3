Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECEC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lwP-0001nG-Uw; Tue, 15 Apr 2025 15:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luh-00005L-4i
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luc-00080k-5x
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:41 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso2929b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745135; x=1745349935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XjUWPsCzB/zg9tkkwv/C9EVZ3N+WAko5Xk2ZrYZeQo=;
 b=IMQi/eRPDmWTvOJW3lzrHTq1KYjyX7HSvo4OBY9RP7U8CvWOCsIZH87J4OWrJOLdWj
 /bUJ4KVXKdM8MAr4Ycj8AyVhDmElVL/wbF22vIJPQL1LrrP/ngsUCm4xu2XTiSNe7q4F
 0hJIWmiriHDTIlv4e12QNJUxslj+Z6TR3jxFS1Am4hzccaAr2UY5ALxMo8N+NZpljOVJ
 D6pwCN/dbaO/BCCMJ3t4eUeU9MMlMA0Q3uOpplZHV+fStG+bSWKMrSKbErY7sxY4kzdm
 ulJGbteRt1hwuHAzLaxKMbxQQj73YP0e/ZwzEE47+YbjWCz8KTqgJU+dBXba2imqS0P4
 Zagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745135; x=1745349935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XjUWPsCzB/zg9tkkwv/C9EVZ3N+WAko5Xk2ZrYZeQo=;
 b=K3sLgLnMMuyNYO0znaTsf9QS8YRXEdmHpy+gRhtcZUYqCREJqFODl+p++zFj6m1fbH
 mkzjfBFDGo4t/95fYNbKcYuy85Dv4K1RyxH14aVOp9o3ICxapptf38xd9OcBvVYSrJ1j
 WUxs9LOuT5zcMsz1XkECYbdPSugdqT1C0FFwrkyEhRNVXc4NR8Mv7Y2OPY0VIRMGG/mi
 5U85ixz1QyUfNkMiilKZSHjww2rDwbuvsfV/t0Jd4LKnlDBBzsJC1wWvtwJrSkeku42H
 XWDrvsObm6WvndV3KSZTiz41H5MTkkDJgIujG//HAqQrvJWIvg/mai9Qe5MGw4iJMb5z
 Ettg==
X-Gm-Message-State: AOJu0YzNwCo6zucJHl7FkfkZ7Nfj2zJa6PkVe4tG3KVR/FjN9JI+8d/5
 K2kIE9DJbLmO/glTeeaJLrCZ4JvICqN6J0QH/w2l9b/npF34cBHG+xTJyoBiJeaa+AUGoc1lscn
 z
X-Gm-Gg: ASbGnct7teLw3ttx0VShjFVZbm+0vIuIuHfo7XnMyjGOUW4rT6dm5PxjD6APFtG1XXF
 z18z1Vau5LTn5Ehr9X1+bO2ZdpQ5fgMqZoeZLXTc+kksUQNFO0JnLW32kJgr6xeAvkJaY0P1Ra+
 0g3Zi4PgO+NYoAr2HHPvRCZr8Del9VH0O548cANXE8m5oZhRFbHRuZukaYDdCwomed7wqp+DtuR
 KLAS3DaW0dhFdPX+W8f8ZNo7cOc3tM+0sHf4ZHnVTJYGn7/8amv12H7yDWeVDz57Ki8UDWmTcSi
 GlH7p5hUY0KJKEKySzKALUtpqrYOa4Sur4ubMH0rIk2JRVPGPwEdOKgsnoSrIy0TqcWnqqdYIuY
 =
X-Google-Smtp-Source: AGHT+IGgDXxSl991oNdHv37gl1UW8GNrTq51RPIth6kh/D2zAHfFUc24DZKoodwdyASW4zT6ESSGIQ==
X-Received: by 2002:aa7:8a4a:0:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-73c0c9f7177mr6283043b3a.10.1744745134923; 
 Tue, 15 Apr 2025 12:25:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 020/163] tcg/optimize: Fold eqv with immediate to xor
Date: Tue, 15 Apr 2025 12:22:51 -0700
Message-ID: <20250415192515.232910-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a4dc88ae71..a49d51f0d7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1795,6 +1795,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, -1) ||
@@ -1802,8 +1803,28 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold eqv r,x,i to xor r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_xor;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_xor_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_xor(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0



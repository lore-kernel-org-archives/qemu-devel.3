Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979E606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=px5UOeX4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWU-0006kN-Ul; Sun, 25 Oct 2026 03:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWM-0006OH-AN
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWK-0003kU-GT
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:58 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so319777f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912795; x=1793517595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKC7pYdYHtePO4avsoUUNrSnDHeNvfk9C4w0w/sFrsg=;
 b=px5UOeX4+wDVxyvL0BRrVSzfDyAYEOaQPvEJ+ACn4juc3zZhYRYUe74q+15JIM+mY8
 8EZKswYalA6E48u/9V0TXVWbkyj3butV4QNVhZyqRQAsUf3NOjyjTQ5hYYAFQLtBXMFb
 Kgqtlv5fG7Bjt865tTJPuiDtzkSvhHjNuJ7OLkmbQS0Y7eHNbdniybxTxKXOZ4EJphEc
 KvfZ28Kt8yWcPyy7qlod8fOxStiaqEaBTspzPlTJZeZIdffly4nGw0Q4f3MjMv1x5sKY
 cfB0yVIjyokaXgJ9+YBZLWXRiG0ukAlR07ZktnELAGi9q1Y+eZ/eL796Ot8WEkikub9c
 aIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912795; x=1793517595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bKC7pYdYHtePO4avsoUUNrSnDHeNvfk9C4w0w/sFrsg=;
 b=00AXdVU8yOMpipE9/qVjMo5Ag8Fa/wiA4PtnkA+fWTbo3e49MquhGjZzkUkn47Ug4i
 JgnOlwB2hHZtJbExuu3nO9fC+SU6GvUbJHnWhEltKgGwvZb/UsmZ6zNXoLjzlUnQFdqW
 EC9BCpEDmUaWkQKZE4J8FZ1o16egm4fZEjWU+AzGQLb9irpnJfYEikkZjEw8/Yxwa2TV
 Xy7SgQhEcaGNNVrgbJhUmJDyCliep03b/TIqXL4VoLJSKbXvGC/dtiOgM9QhKXYSfH8D
 /fVAmDgLlvD6dTi5xEM8oIBCGK8VGdkdPD8h2OpOdyD3KxkqJ1FkWkUEhPGYhAkavkMu
 inZg==
X-Gm-Message-State: AFq9FYLCtdYxfqZC4LFU7rwwGMMbzpbYRn9U7a2siJo2APTiR3jEVrf7
 jfgjwAdItZciPJ2E8z6wXJ/kjpl1IMzgcymgAsyZ3zhlHZFhC9agghiiY+KIlS0PUMDd0HvIGby
 qOKZv2zE=
X-Gm-Gg: AYBFou3KUT/0ofDuQYjJiWaAF6LxUaPuFd7LuudemXid/szHIwG28CPQ+4Gt1dYNW/y
 FVFQ2vGVvqTKDWkIxj224g/U5yzIeWRgWNRz0l2Zh1HUXUy+5qtVHS5lN2VE99a6Hnq99xH7UZD
 om2cncH5SR5ExUE4xqR7uFDdbYOze73YSOZRLtcs6qPJjrv5fsUvvaFeciQymgAxWHBS3RgWuw1
 UGL5TojCUjsQ/uQ8Dc3r5xpz0oLOPuNZeYvcA3GrKZqRKU8ebPxq8OypAko79hFMxOG32HRf80a
 h6hX6xaaEBunQI8Mr7e8z/abv+HZlzCnZVuPv7HuOGePeJpNDe5TFJ1dsm7GjV8c7Ce4O0s354o
 fGhNL4JXl5VUZYI3eSw0N4S+ZX7k+1qDlt0rysXuPSM5eksbRXDjXDejf39HCkM5myijgodooKu
 ZMNy7bUO/k4nZOZQhUNSGsJth4LY2xJ6lb7FDDpOAfYow7G1fYjPRmnk4esVxuEGzIzsNERecyt
 q6Z8or+g4WjGS5F6UpE5/hkgP3NZzfNvhzBL05O2pCGpSL5zl7FfuD7kw==
X-Received: by 2002:a5d:5d86:0:b0:48d:f996:1814 with SMTP id
 ffacd0b85a97d-48e3eb9c7fdmr5500970f8f.57.1792912794993; 
 Sun, 25 Oct 2026 00:19:54 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 033/100] tcg: Generic expansion of tcg_gen_rem_*
Date: Sun, 25 Oct 2026 08:18:08 +0100
Message-ID: <20261025071915.1123867-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 60 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b0c5a1f5cf..eb090984e9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 778854286c..50d725b72c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8854006022..e194c33eb7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -484,6 +484,26 @@ void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            tcg_gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            tcg_gen_mul(type, tmp, tmp, src2);
+            tcg_gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            tcg_gen_sari(type, tmp, src1, tcg_type_bits(type) - 1);
+            tcg_gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -623,26 +643,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1537,26 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0



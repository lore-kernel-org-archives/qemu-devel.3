Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1662606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kPLfW1vd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsag-0001ba-TA; Sun, 25 Oct 2026 03:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZe-0006V0-8k
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZc-00046b-G2
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so619295e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912998; x=1793517798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oiOjhHT1/K5/Gi+WNk6NeCRgKwKPT17fUrFl9Zl2Nec=;
 b=kPLfW1vd5YXan7KUdbrdwk0SBtx/L5tZPuzxAPvOBRlC3duq/cL9JGwHebCY3c+TYl
 Ex9QqnkfpZMG52Ks2LMibr5xNYufK9tFv3EMUJq1zojDHAm6SowzFQs/sGOw6KvH6+zy
 RtfzkmI3nKWasqnoah9L5Po9ZLpHIx9CdiajXELWojFk/ZyWgLHD9l+cta4dDBRYW1br
 N8tWC3Wm7WaVRCtqXtyTYM/Z+SpVVaH9g2ana7FL0KVF8wU8p5VrGapcIJpDzZPZpSyU
 FAw3D4F0z2yN9lwyPR/yDxhEb/oQCwu5fQt0j141hJrE5Vd+XzT/0nTRT8Yle+oJjELG
 w14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912998; x=1793517798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oiOjhHT1/K5/Gi+WNk6NeCRgKwKPT17fUrFl9Zl2Nec=;
 b=L37aEAqJzbTwYsahJ36vDTUsMAZwl+FUGV8wUYSpxgopVTy1EJjU4oNUXqUTqRgaXZ
 MD28TYbdZdYL6T5iQHYmjxbaZbs4rpMP1++wV5h7xFgJgDUI561Kx/euqTGXBH5ibKT2
 AXA2J5Ux75p8JlMiCPtkJ6air0DiKm3dl5HVdkh5x9EWEC6OHUIgbm6H44uXLfYnSjJz
 +jriQen15RVcE3CrdpsG0qBLXrOUQqiJaK6oVtN3vPJa2l3RcsVN5dyVVFoNWL2dJMuk
 55ewQzzvDkE+Efo8xvRNnHYB9KN04DBj7wZn+OlUzJ/dH9temBLlf9jYPWBlS75iqiQE
 iAPg==
X-Gm-Message-State: AFq9FYJ61FNrPI1aKHyowi3peqENRiwktd+mlCKIgK0keWHF+IB4qooM
 YdfwMOdHVxd79j7nStq/NtsIPlViN6IAHyySaT61xERggPeLTNyigojzU2etJ+YExfV7cizVmK2
 x/4GV/JQ=
X-Gm-Gg: AYBFou0MQWJ3j9zFH+/RBCZEFsSJuwnnEgCL0vXdwILwnZWQvFXsnfCsSTE7EAFzWYK
 1Yo9wj20Z22/o5kxwGUGglzYTNbRU2u+1c5+riTs42y2vkHmPP9DbCkW5pioLW2DoAodzLrlQre
 b0W3w4npgflEnY9Mf85kVZVXvUfWt3T0+TtLFMXjlzbX57+K6Wzj8CheiIm3uxOKt5Rbbo6dqK6
 CPyxtsEhLL5IEJwYN+giEAeTf760qCsMLcARzVxKpaT6ZS5jShGRHBEQgacA/1136tqr+BcCSDl
 qO5KfPnHRtKr/Y9Za7u6ylDelxbDv2Aro+FpY+nsA1XWRL0z4+Nf4ACGqeAcPg7IrLTrZdKxQ4o
 YEJyzOK0UPyZAMUufvNlA+FC1sVVJGVxFCuxOqJC7kWPujszH2Dy9r5qG0B063gEh9DIOYSyn3j
 s6u7VljQYvuQcSsvUSXJ0HUeqQ3FXK9pHUvLHe+D1c64Bx5U7dzegXfCH1csJbkcmKHEt2hKtdi
 /10BjTGgPnK879GIle9D0Hmw70to3PIyB2joNyADPNbOd7Dtdm5wpcgS90=
X-Received: by 2002:a05:600c:a08:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a35aeab300mr67577665e9.15.1792912998065; 
 Sun, 25 Oct 2026 00:23:18 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 057/100] tcg: Generic expansion of tcg_gen_rotl_*
Date: Sun, 25 Oct 2026 08:18:32 +0100
Message-ID: <20261025071915.1123867-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b1448f8c08..e653c12a18 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ef0ac5aece..f832e286ab 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 97673524d1..97acd9ebc8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -744,6 +744,26 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_neg(type, tmp, src2);
+        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_shl(type, t0, src1, src2);
+        tcg_gen_neg(type, t1, src2);
+        tcg_gen_shr(type, t1, src1, t1);
+        tcg_gen_or(type, dst, t0, t1);
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -845,27 +865,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shr_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1676,27 +1675,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shr_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0



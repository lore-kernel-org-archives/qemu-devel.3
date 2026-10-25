Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C899606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oS7zB7uA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWM-0006MI-50; Sun, 25 Oct 2026 03:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWH-0006Hi-17
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWF-0003jV-1S
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so1268425f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912789; x=1793517589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oVX1y5lsO7B6+WQCAbKlOrC2H0uEBBJS3UyAdyIfdnA=;
 b=oS7zB7uAL07tbY+oWcWEDSffyD3MCj/sfNxa8cYxqQW165u2icwuHkdBDRm8ELpbm4
 52yIV1sclrjCBQL++uRK+wuMKXGPjELYFftQgAYmY49EebXrpZHy4qrb9wejRDW4/xf4
 5ATZE4tKZaqXUDTHZeNT7TXxZ135ku6O2rg/fGRecs4OE9fTBQdGkul32wYiik9WeIYV
 i2IzZ3gIOC/ecy3LFw036xAndNnJMzki39yfkxgpXDS6hg2U0ZqTcbIcVMRaJXAIiRSD
 DWIeGu7voJiMrtjU8v7CMYTr3qv6Db8xhb8cA/kYnP/IGa0w2r3kEZQpe/d7fTxAKhVC
 E2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912789; x=1793517589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oVX1y5lsO7B6+WQCAbKlOrC2H0uEBBJS3UyAdyIfdnA=;
 b=DlHAk70u/8GBcIu4eg+L4e0v1B6FXwG6AikEk4IgYX3/S8aB79791w0cktNRNUAx9L
 UQVMnl48FfRYmfQ7RQkRl/mhcFndHgoNlTuJF2UH2FiHXVzizMNdh5aBFZVCgd9/6VCZ
 sbEPZM+/RszYNxWMqBdXXFvRjo6s3tgnpX0P5xIWtUDeewSgn65UhvKrDG6opyTuRJgU
 d3MIVvyzfo1WnkKlWpCbK1V9MirTFPLdLGusic9Kgel4DgYPGhJKol29t2s5ztzds3Bh
 BwpijhVRhmd4uXEIx3rge4gXKXls+w4DCXZkXvh22yUzf2vcRi0lUWhbqd+dmT8ZW4HZ
 fr9A==
X-Gm-Message-State: AFq9FYI/K6hqaM67owDZHFbRUDa7Y/NH5n8PS00OjaZ7zErmoQal1MPl
 seGmb+iJesZ1SpQ5stQeJ2stLEkmurSNlMmHsqT15K7f2vCucMuVt7AekckZF3nNAKJj9Lgr7m9
 Tk7uKx/c=
X-Gm-Gg: AYBFou00LnZlS7OVTDoBbZVcTgIteK5pit2s8QIKCq2pxGGm7MZWwPxeUIP7OxtLwIe
 mGj24sM8sDQx0YmmlLkLOoTAXp6JngFBXLdT27JR9yTBA1j8skV802cnYsGxSKCFpl1h932fvqV
 UiR1N7ts7BleG35l2WazOCB6yz7JyiKYP1FfQl1QcOr3Ohol1i/h8aGknoM6/jo988kTgzYHSje
 9oNmYSw2aLKvUN2+IzwuQyqBHeuNCL7ZQFarLJ4PmBSe7LW5cgVndLPf4EuoVbmFOlK8oFDa+Bx
 YmLTKct+WYNqUmx8Js1z+s9CSyDkmvL8tv0SnNdW8yyb/c1FK/Y/E4cfe5Vli1FUES1ml7O4IBI
 3+mQ/vLUdlE9s79p9Iq0Pv7ovAExle2BjCKv5u+B4i88APSSbgwxadZ/qoerXbqeB6rZ3B/tGnN
 r0KXAk3JRWqd02gCCjX/oS0ZvpLXNkFCskVcr2bvzFYt6ICafk28Chsy/0F7pGJhut6PsDX9AFM
 7j/lEwkpGLlYr2daEyFNQqUyivhfaXZci5Pw9w2m38ZbHDKwSNKGWUpYg==
X-Received: by 2002:a05:6000:4011:b0:48e:37e:470f with SMTP id
 ffacd0b85a97d-48e3ebb84bcmr7465627f8f.51.1792912789463; 
 Sun, 25 Oct 2026 00:19:49 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 028/100] tcg: Generic expansion of tcg_gen_xori_*
Date: Sun, 25 Oct 2026 08:18:03 +0100
Message-ID: <20261025071915.1123867-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
 tcg/tcg-op.c                 | 34 +++++++++-------------------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dc5c7f7cb2..dd4e7f6686 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -209,7 +208,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f7a7dc69c9..b38969478a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,3 +22,4 @@ DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
+DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 668c946c03..cc34e0f31f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -518,22 +518,20 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
 }
 
-/* 32 bit ops */
-
-void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
+void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 {
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
-        /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (src2 == -1 && tcg_op_supported(INDEX_op_not, type, 0)) {
+        /* Do not recurse with gen_not.  */
+        tcg_gen_op_tt(INDEX_op_not, type, dst, src1);
     } else {
-        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
+        tcg_gen_xor(type, dst, src1, tcg_constant_internal(type, src2));
     }
 }
 
+/* 32 bit ops */
+
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I32, 0)) {
@@ -1486,20 +1484,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (arg2 == -1 &&
-               tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-        /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0



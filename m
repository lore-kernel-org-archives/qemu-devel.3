Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EADEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mDN-0004fP-7Y; Tue, 15 Apr 2025 15:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001IL-8L
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5g-0004Wq-DQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so4845348b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745771; x=1745350571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqmYFS+mKTMDWnN+D+k8G+NOtETf6n0r4FRDF3yV52U=;
 b=ptbN7FZBopPch6CGipHj60UetlvuknYPy85xaEtMyyNPNHnwPHqK5CMZs04R3QkcUv
 JWzX+6n0DvOwQoMUN1n9gPJCRheYYvN/b2Lyig68KFSp1eQVHhCRGu8X4J9uBnJjyscO
 4lfOxIerRoy6bAuO7eqC62RIdOrwXOmHu1mzqUrGtAm9DUGkZYzzY5lQDNT/y3m7ZG+0
 wf/K7qpjAG6GNZ28BLZXJrFXgV9a3q5hMCU3xnAixm5mqQT52C4eM2L8PN6c072ioDdT
 t88N9B6oSF1FdyNEkdRC+8wz+CLjx0g9qNXFkb9zvoDVbErLHiV0nY1UpPYfwRdMOJzM
 0q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745771; x=1745350571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqmYFS+mKTMDWnN+D+k8G+NOtETf6n0r4FRDF3yV52U=;
 b=jAoUTDjAOq7xGB+XPGSu7cSY0dXHE1jYeGpzfhLPsUyfSVagWku1A4Sv3yt49b9vaz
 QBZZKoAOeXkozlrwVbPppJSK+EiO+sdUFrKoLLIE06GDuOb77KSQ3xvU3qEeQo7kb2HQ
 UHXVstTGdO3JNpHL9bYjqDIsPg4fW8dS7UjQO0mWeCKIDJvvwlMexY+aeOzKVVKuzIdj
 S2AxY7no/P/RROKNt/f5/Fs990nJiQhdtNyzF8TKbWADO61TzFO4lXe0/dpVJ3oz0sc5
 m5CuaBTLqKwXwVUR+62v0ZScGJ4XKXEBJK2hx2aSBEbEiOwu3KX4bhCWsn8GGvToDdwQ
 Sk2g==
X-Gm-Message-State: AOJu0YzzLHTiXN+ajOKgrV0vR1Cg2b7d8XrEPJ6ytUVW3vsElPM6KVB9
 TbK0tTUkQDJfhaqMwqhyfKmJSyyuy9/oRcGva1LDl3O3pCvMF9QsXDJ/wlcIsDfip7bVpgAD5ey
 X
X-Gm-Gg: ASbGncuDzd1EED9IFs/lonB3xkActJ/Rd3QUrM35nWbn5e6JlOjDN8grw4MjNKU6xLM
 6QksOwIPmRuUoXY5dzlnnDjWVNLoWn+VPE4ArUwKDXw3enHXpU5rJM9eil0rip7HKC38RipiERA
 lptmjWYtais2QTdTPaM4UqS6hNiLFAw+KmCl6uUrl/gqV6RTkY96YGt2prWGAYLX/DY/P1UrV0j
 lWubPOzoot6uAsTEJlMR17vNbljlqblr2bDawrJnGm1IrhB/eIjyBZDvs0srYEg49PQl33M12NC
 vTpYmyh1XJ2xmLzw3DxWgALiskW4XNKkA1C+C9bQtkuGUuZiOAL0754w/O0OFoTUqz1AtFg+wAZ
 rgmtPN9/0cQ==
X-Google-Smtp-Source: AGHT+IFOV278q5D7j0YzWosD2XZa5Jtgzci9Q6T6rsTPIcvMhvjjYgycpUmJ1FBsXAXq8jK1gN5OOA==
X-Received: by 2002:a05:6a00:2d8e:b0:736:fff2:9ac with SMTP id
 d2e1a72fcca58-73c1fb265f9mr776143b3a.23.1744745771313; 
 Tue, 15 Apr 2025 12:36:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 138/163] tcg/ppc: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:49 -0700
Message-ID: <20250415192515.232910-139-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

We have replaced this with support for add/sub carry.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  2 --
 tcg/ppc/tcg-target-has.h     | 11 +++----
 tcg/ppc/tcg-target.c.inc     | 60 ------------------------------------
 3 files changed, 4 insertions(+), 69 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 9ea26c40ae..da7a383bff 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -41,5 +41,3 @@ C_O1_I4(r, r, r, rU, rC)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rI, rZM, r, r)
-C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 8d832ce99c..4dda668706 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,16 +18,13 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
+
+#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#else
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0b151db0e4..91df9610ec 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3663,8 +3663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out32(s, MTSPR | RS(args[0]) | CTR);
@@ -3760,57 +3758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_add2_i64:
-#else
-    case INDEX_op_add2_i32:
-#endif
-        /* Note that the CA bit is defined based on the word size of the
-           environment.  So in 64-bit mode it's always carry-out of bit 63.
-           The fallback code using deposit works just as well for 32-bit.  */
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[3] || (!const_args[5] && a0 == args[5])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[4]) {
-            tcg_out32(s, ADDIC | TAI(a0, args[2], args[4]));
-        } else {
-            tcg_out32(s, ADDC | TAB(a0, args[2], args[4]));
-        }
-        if (const_args[5]) {
-            tcg_out32(s, (args[5] ? ADDME : ADDZE) | RT(a1) | RA(args[3]));
-        } else {
-            tcg_out32(s, ADDE | TAB(a1, args[3], args[5]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_sub2_i64:
-#else
-    case INDEX_op_sub2_i32:
-#endif
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[5] || (!const_args[3] && a0 == args[3])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[2]) {
-            tcg_out32(s, SUBFIC | TAI(a0, args[4], args[2]));
-        } else {
-            tcg_out32(s, SUBFC | TAB(a0, args[4], args[2]));
-        }
-        if (const_args[3]) {
-            tcg_out32(s, (args[3] ? SUBFME : SUBFZE) | RT(a1) | RA(args[5]));
-        } else {
-            tcg_out32(s, SUBFE | TAB(a1, args[5], args[3]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -4456,13 +4403,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i64:
-    case INDEX_op_add2_i32:
-        return C_O2_I4(r, r, r, r, rI, rZM);
-    case INDEX_op_sub2_i64:
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rI, rZM, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
-- 
2.43.0



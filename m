Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D038606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=auUZq2Kp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8i-0003fm-0J; Wed, 21 Oct 2026 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8K-00039y-2C
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8H-0001XP-Sk
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so631557f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592252; x=1793197052; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mvNwVPvSUeu1GjZvQoEBCp2RIdEEVnFuEvgkOoTJ9Mc=;
 b=auUZq2KpDptmZw9pjTtV+KHHJtStl9Pj/8dPtFoxIVuvqI5sJSBGmWwDjakMKzxfdI
 6Crncrp4XpyVEMPCxsIcrPWPoDHwS2SVUfzf49z42xeRxV19wgN5Z/FicTP30uoh8/11
 k7uLb3E/o3NwNN4BMiZL4ijzYxaLEhVj1PHetUtge6Eq6UTc2O9YYgS1XoCuSXXTa/7D
 CA//jalGo+7B+29fjPy24sHPN+IDyimn0pcYSp55d8ABQ4AJFltc4jWjBmVMWZ1BCwrw
 FfP5go3I3bIQA5ISwAxaX9q9v9FIaeUfjtTDCY2g3P20vncyoKDjFkDWwJd0Y8O09E+O
 DaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592252; x=1793197052;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvNwVPvSUeu1GjZvQoEBCp2RIdEEVnFuEvgkOoTJ9Mc=;
 b=ArbMUs1qa024az9R7ZmRpioRbVA5DaLIHyScRaCTyJJgQ5qI0NBBOPpzUm27A5My1E
 X0Wlg4uqBnFnndIAGjUdxglBcX+CG08j9oLUQAGjpayXpeusjFS7W0sl9bxw/K/TlclZ
 lgpiY9wZDP1wysdtMPlPncnq2rKy7VD3CWX8jV3daLVgKV7OnGpD0OSmHXvjPJc/LSDW
 3pBkFDCpXXWWutY/euhK9+jJARUvRA100f+BQTkKHloM4DcAyurySv/VIb9nANx2ApYZ
 kLPmtL2y+Urdp/N9NquMQqLexwwKR2o9usvdDsJgch4lmd3FVuLjqUwsHJ5XfV1E1U3a
 CgMQ==
X-Gm-Message-State: AFq9FYLxAoRrUfl+cd97XCA2JQK1o9fmrCXVgIGioRhP23HA6GaZGPTp
 RqDS4LBJV/O4P28nb9tiq0vLmUuarf9bovSp8UxQEh2hFpiG9uwOkIpx8ALs2rnQFwC0KY0I9Yt
 dD9tN4Rs=
X-Gm-Gg: AYBFou0CfsUMDFiDN9mwzo4pF3uBeiBVWxTTCJgle1FUU9D9G2wsvluso9xCGVKBW7q
 k6T28U9Gs1PqGN1G/HfXaS5ZvjXe9U4yc1IiIlZaDaroeSVwho/MfB/3mYOa6e8gf6IifUvjPhD
 t6L4vaWa0F5bu3U8Vo/e1FS+gzHRQnimCw/UapCCYDqV1I8TxSHwJTDXPyycU8MQ6DuCLplPeOk
 2V77gNs6DaN5ZixPtRWZP9IwN2Lmuk5ZZ2HM7LbUzptdXw2qPnXMSOdvo8JXeD7lpAtUf3rijQ1
 JUb1P30X6GniqOr6zsd0CBQygGmdWGe/AkyNUwohcTOZqJhJCRl+LAUNKUT9vXRGSRoWRfOvRcE
 eO0zlpyLNe16QICwFeXi7Pq84QPYKeKpyiI6lSYrddOCXhBjwMKd4Z5bcb8uOizSLD+bteAkocS
 8YYChTO/LAouwX+7+CLd7oVoTQs3hM7Q31hj7t3bKY+75aLlJoEuGFbkMJX+I7CTxyZUGyhNru9
 3ABPpHKIBGo2Ie7SQ6S0U4NtSVZ6Em/DhSWndoDhWV2o73sLHUA9z/pv17lFKx0NzFp8IMI1QeI
 qUxZKmWaVALsGE5KhlbaJ0HJhpc=
X-Received: by 2002:a05:600c:6296:b0:4a1:f03f:f1f8 with SMTP id
 5b1f17b1804b1-4a1fd8cd9ddmr45022555e9.3.1792592252257; 
 Wed, 21 Oct 2026 07:17:32 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 017/100] tcg: Generic expansion of tcg_gen_or_*
Date: Wed, 21 Oct 2026 16:15:29 +0200
Message-ID: <20261021141652.363109-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 54ed9c9f6e..9cb9089a90 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -316,7 +315,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d6b45004a2..8dd3929060 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
+DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4e7ff03b34..b330d0fdb5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -404,6 +404,11 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -455,11 +460,6 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0213606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H/g7tLFC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX8G-000389-46; Wed, 21 Oct 2026 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8A-00036F-28
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX88-0001W8-AU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so709514f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592242; x=1793197042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wrQeyL+uvDP2996aO6Bojl4etOusaL8QawrWtfmheKQ=;
 b=H/g7tLFChEr8kghfdosmH8pScmxY4Gx5oy1lly6WnRGxscsrqVootscsthiR16OoHs
 Zus/O80W8chs+uRym5w5BmUs5kgzpm/89yK7ksb12nYDsyC7Vzur8mDS3aO1+SLSRGSu
 MmfFByGVnP2uie6d5s9K+oj7T/lS7R954rfegiwDtNxmH4HF6PGYzSrdJP5fPxmpt5RI
 yuBp1DJ8+EMOBv59y19Z/XepEw9QBG6K4O+DS8aDJndOI28/Rt6iKDumTAMY5M7u9R7A
 3n3C7EE2MQbcaIEtMT4SI//n6JfjPqjEPPn2qtieLyeVNXJ7L/EbFUkgeC/dzNDENa6t
 ixWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592242; x=1793197042;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wrQeyL+uvDP2996aO6Bojl4etOusaL8QawrWtfmheKQ=;
 b=EzGmeNbA7zIT/ibPp1+LwK4GO2FFjvDPNY8hdRAratmRkAPwBZJylzMThteB/xhYlv
 LFyyaPqFHEIpBtxSL/OMAOHDJzpqC3RSSnFA44NRBlK98YOr4Aqzq954j/8QMOXIUZGv
 d9nP0oo5TwO8p1SdGi2KI32McXAH6F4Ya5gK1SNGi8ofZMKG+n+gohAfnnP4HlI7VczK
 Hw07eK5CfEkl2jHLnH1oaJEXgzpKhb9k+GuxnZ3n0G62k77prJdoR3M8QdTgtFKH6FGe
 JQb3TK462f07bNvsuwha77zW1w/W1oTrDHphv37gLWefHYtTLpopOlkSDJjqW1KQIshk
 5vdQ==
X-Gm-Message-State: AFq9FYJdh5FK0m681xtJDxUWIkPWD18OjsWM0LQvmY27fIbHpOskAzrG
 lhcV2PKHJ/CZAb52KC+aVMEuVEAlux2jbcKvRd13WXVoyRjT1jWabp8wQRfSgnvr/i4lqbF68b8
 Am1c5JgE=
X-Gm-Gg: AYBFou2RRoMxOhm1QtG+MZsZQgymxlcmgtzC1FUyy6WUJxztN7ESoGiYhjs9gTMHK9p
 bQBTD8bomYzZ4QRTslgdIRTdHV9pDnXpZimDMDttdwpu9zjvxQyuXXEw609rA+Y1AvsLoiblWJV
 4Sqk+s9WrC7Swk5NoxKLbsjNrwws1Jdn2j6MYuwjq5cbjEq2FNB0Q0MiifxMP21EyhJj4M2o8IP
 rr8p1J0yp8EtZ8BDUIl6atjNbd8+BG7S1N64Ul3RDNN9Q9CKrEOQPMXUzPOaEPemz4CDPte5xpO
 sSc+iAPfk4YAx7NwFnZHQUKEgqVtz5QNqj6C8obQ9mzF663z/rLz1ZDyhfJNWcIQ6Ev5vaCk85v
 IdZFA5b8y7LMreO97+2N7DAVICgfT0yFKk7lUF73LICBDv2p0/UW3/B19dIC8Dxz/IDe8Ttu5Hp
 9uu5ZpVwMVWArDVc1tB2q3ce9Nsa91JKTFDKoabB6nvhi+VdG2j1Jhvv66uXDVWyX66kM0IxXAZ
 yjW9j6DJVvk1I+t+T7/HrQnwefAbI7D4YDkelrPkhgcuXgW7mX4+ykMBHTHZylMvGBAm+DPqfTL
 RHWdxfYakQWIgIU0Qe4xJwiJxok=
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1fdd245bcmr45926775e9.9.1792592242505; 
 Wed, 21 Oct 2026 07:17:22 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 012/100] tcg: Generic expansion of tcg_gen_sub_*
Date: Wed, 21 Oct 2026 16:15:24 +0200
Message-ID: <20261021141652.363109-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 61eced5ad1..e2e8c66d01 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,8 +314,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index faa83a09b2..51d5ec6e06 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9544688daf..563c3bb038 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,13 +394,13 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
-/* 32 bit ops */
-
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
+    tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0



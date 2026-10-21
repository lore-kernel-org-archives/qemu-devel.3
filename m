Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB98606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PGngnR69
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIF-0007y6-RR; Wed, 21 Oct 2026 10:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGl-0006dq-Fh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGi-0002ZZ-Fq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso558736f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592775; x=1793197575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GgkIK4IX2IEdKD972HtTyCkxWUlDX9e1tomD4Uh0IDA=;
 b=PGngnR69gEMW7xkNXmnstfXZWktxb5rmENee6fF7LyOXjgM2QnEPYPMqBmeBh4+xeL
 PHAUuZd1Ly58+MgqwX8cVmLehX9AqX896UQecsZAwNP85iDKpaLDfy/qZIilm/xJBnRu
 o4mDzdKb0sWPgoVSZgW2UpZgkChbmwtYMtpCDeKtnwBwMyp55QJHnzAihJvc4QsFluPS
 EVqilJhi/I+eX25u3U09+6tfkgT5tMDReKSfk4+0gziCpoPahGXkuJ+GCRuiEi9hVdAH
 go44YaFnYDr8F4g+ChvfuWI3iRce3XT12ioPa8lRZJ72Pg0QCZc7GseHzykZvLXRwSme
 Fvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592775; x=1793197575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GgkIK4IX2IEdKD972HtTyCkxWUlDX9e1tomD4Uh0IDA=;
 b=C7beyh0G2jYZ8pM0UAYlb5Vk3TVbT+5W7QAV97+k/trZX4n3m8f+g6oWMKnsRa20gh
 8967sR3cBZFlqNMnOvwYYUuO4t7krSleaZ3z9+nfXnjiUaeFTSr5Gz1ar1PElKrR6XJ0
 n0ujCAh7m2tTRBmlPkYD/lXgKqA96BmJbX9Yn+qLn9IE/zOAxdmatDxtvqTf4s9PBCM+
 G/6auv+7whJpIY40KcukmzPK1Ng3n55fZFdrCNxthuj/f//XVrdk02eYzyKncFUm3HP9
 bFV91a4G7QBGdbbSAstoKMZr9hWCOBgU784pNG7GXTXVx/8nKg9S5SyeXYKaS/tW5zTN
 UnzA==
X-Gm-Message-State: AFq9FYJcJDUwSZtHdBRfy/KlllNHL7+6yEdFfkOFCe/j3vcr52Xnf3yF
 HuC4Uv0YYITcIhXlAOgMeNgw9kB98j2WNLvPLyMtyy0CfsEr1ZW6+pFmUiZFz+APbA0ax5G+b8n
 pGKApG8k=
X-Gm-Gg: AYBFou1Spb4MboRjqvFUYojnOXulW4CpBBh0ek/vf5C2m8HLSDGNYLTo8KtmfbQLnVU
 lW+jxCcTLgz+ilsKAmBCf/d3VhPfKGMXJ8A2ipmgd00Ln7b5pA8e3jJHto0Ol7IB6hkJFYwBCAW
 8Wm2xmHdJ3aPdJfAeGZXVbht52MUBjjvQHNFQERbRFgWEmJXu5m5xyvCxKDOMMAy4QE9HIlH5yS
 MEqgOfBqSjdf26TL5z4mwL1AqFH/N8e/vgOcu9B8CGtmJvsmiGUoSVgupymvgo4I5AVsmgHfjKV
 tyVkLXZfg0v98cblbcqMFtQxD1y8N8kaBa6xr8027uzA0c4wGo6OQk0CD/v28zVEkya925dZRpu
 x5A+aH1Et0TGm73uq9yJ+worJ6JMUm8o2Mb4nFXXcU6Gk/m0sN74GAbxezKzjlqFnkLOo3wmetd
 z7UkK9l+W1FMSnEsg1WeXyfjxkZXZ341iTDlgon6AJza4ARzo/KXdyVzR1aq9mbRC7NVRXZqKg2
 7/RpBlQhLH/FnzXKKo47LLBkFOyEhpBdKA3cI7D3xRD4yNojaDBKNZ5J+JjbcFGN5FWAJAWtpK5
 rLT4rwM/w6uv+ECu/Qn6TGbkbWE=
X-Received: by 2002:a5d:6f0c:0:b0:48c:7d67:8ee5 with SMTP id
 ffacd0b85a97d-48e26502d63mr4468332f8f.43.1792592774976; 
 Wed, 21 Oct 2026 07:26:14 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 094/100] tcg: Generic expansion of tcg_gen_st16_*
Date: Wed, 21 Oct 2026 16:16:46 +0200
Message-ID: <20261021141652.363109-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 23 ++++++-----------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd66b0d7de..1fe791d5f5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -158,7 +156,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 90bcf9e5ab..f9dab50a91 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -72,6 +72,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st16, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cc70c03b1f..0162817d5d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -143,13 +143,6 @@ static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
     tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                    TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
-                tcgv_ptr_arg(base), offset);
-}
-
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
@@ -1261,6 +1254,12 @@ void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
 }
 
+void tcg_gen_st16(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st16, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1412,11 +1411,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
-}
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1429,11 +1423,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-}
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
-- 
2.53.0



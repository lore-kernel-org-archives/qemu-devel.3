Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FA606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Us7kLU+e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXG9-0005KB-Ph; Wed, 21 Oct 2026 10:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001eD-Hd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002Au-L6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so700168f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592565; x=1793197365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sfoFRx0Has01VyddjdwZ6VgCCrieEGI0Z6a59b97dLY=;
 b=Us7kLU+eUMEvEmdRgDlXKoxCgaycs9kqFhBIWQ6LOVNWaGRrnDyMOYenLG3l8qSUki
 2unVfIvzqKcpKNsY1ZTFQJ4U/oOiI9IhYTZhuPc+Zwd1zlrX2frkZw7r/Zwa3GRc/Sno
 qxKRUAM3oRVPo86EiWwiQ0A9ASqhEc4RfICrutakxEjeJvSC2ECBp2jwzhiY+hncEHpM
 t6TBCY0K70w/56XaqrQBgduC9syq0bzFOVIcqPcrdTpXKXQFTWRzWAfK3UDNqawjHFMy
 RiWaMiCcP0JvQMbR6bQjmRLls53nnlIvZjF+1cyvCzNoeV7NDBEsPZLW3M+NKsni3RtK
 LFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592565; x=1793197365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sfoFRx0Has01VyddjdwZ6VgCCrieEGI0Z6a59b97dLY=;
 b=mE2ldYmUPI9uaxB9D65qSw2WaBiBMITJSKRX4g1AYUqVAevf44P4iABORd/t/xj49v
 EiCuw3TYnebPxntgrk1Vz4T5p15mdUPvdk6d7h5ksd8GJ0AQg614xs0lCsWnqdd7T/iG
 xEXwnYWgHUvVhlUy6xrK7zFVXz9ZKWU8vlAgqhF0B9H+pL0H6D+mUZPoclKbBoCSbHXm
 djZ9ur3XkXaZ9arDXV2BwWHkGb4YJoYFFnyV3a+Yrgvjsfcm7Wbdn2vhxjMPEEhQmPNY
 S9ZlBnPF7EFWLxjTtqahaFvbn6VvVCBHGvu5V6aXR0JpshU7faiLveS3vOerDHQz7ovb
 q+Cg==
X-Gm-Message-State: AFq9FYKPtS2FtZcrGYQMY3nCTDQiP0M3+gMvNCq06neTEV9oDOXYYpQE
 fkk4UKN321CFebSNuhrN3H8pT//LMoxG+yn08QsOiCnvG8RSXVvjhK5hY1a86NLbl8/EdfWDI4N
 bb4lfOFI=
X-Gm-Gg: AYBFou3H/YkWPhArzaAMjBxhhi0SzH12ySRi0AejEokfG3G0F6zZDHbuJlnHbH0QDqm
 jBu67Ut/yXfZBqSR4/dLqlM/F/dg8yliqmEpEx+bc4+vpEI1nFrXTwVnDzWZWUDNJbq0tZfLUdx
 bvjtwmuWIBcurxvjKxsfLpWR8c+c/mW8BUGWa2pe8L9lU+5WuCyGl2ihvHr3N2bI8qKWkzz/I4k
 h5U+wKMWRWCU7NDqLQ/a77KmzQlt6ejct7nTe61BFF+N+ImYul8+SyPQ16ZU3lOy5wmA8VCdo+C
 iyuiYsL1FbKTq2JUK0gR1aY1SQWIRv9KHObrEegeApHSZCTtIiNHsTFOhUBlo3hvRnXhv2b8yA4
 LIpGZBFN3Dla7/yzxeT3c/UK42aNvc5jK0IRUs5BPvJjTD5lzmYt12f6gR7tMjBlt48cBrcVwlr
 tQMQ16xKfskrvymu/k27gcf7dlHDx+LGULQ0wp7eSIV/QUF6h+NxB3xLxjygXVEpwqk20wxb3W+
 S9qf7u9UvcLIonqa33HSeqUyWC9MIzrQt0SZBnHGyVQvOSzJykIu6zoF2wxvEHK0i+1IvuNMTQr
 kFDidMtLCrPLadkyJm6RjlB6o+QQ8arM3Jl7ZZQxRslVqFwQ
X-Received: by 2002:a05:6000:2c06:b0:48e:127a:c914 with SMTP id
 ffacd0b85a97d-48e1e7a7ebfmr11578681f8f.5.1792592564457; 
 Wed, 21 Oct 2026 07:22:44 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 065/100] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Wed, 21 Oct 2026 16:16:17 +0200
Message-ID: <20261021141652.363109-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 85af0d4b6c..f2e69a21e1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -187,7 +186,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 88e87ebc2f..a5b2bdcb43 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF2(ext8s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1d154fc12d..3c1e1fa958 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -599,6 +599,11 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1164,11 +1169,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1470,11 +1470,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0



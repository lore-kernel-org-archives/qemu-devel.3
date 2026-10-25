Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA0606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aPL3ImEU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaf-0001WF-S8; Sun, 25 Oct 2026 03:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-0006f8-P3
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZl-00048S-2Z
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so16050715e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913007; x=1793517807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQIRQ04ZXb5CwWPlLYF+JHdSDXtfiQB+LiviAz3OE0k=;
 b=aPL3ImEUdzj5xxdXF4+yw/St5bW2UEVaOKCN4irp5GcpxqlxY9ivfGWMUJjmOMo4tr
 nUlxYHdKZItKx8Ngt83Nq/aRvhVBwCCHBphoJ4k5JOiE1e1W8VIBlUH+sMiumksoQHba
 CRYb8gU/pEE01n/MD++BVnGZXK2VDLyEuf/83iPwCjmKkSQnsMCcJVqVn+TtOtiJFXsf
 BxDs2oA0sQo+Jr95GmwBIW9KfVtFjjb/h9e8vSdCEYkw8HGRqyfcW6iaJ7mOAPdNJ4TT
 d4KickxL+K7ByG9m/P/ef9Z2bAod24qPc8jMS0FahHcHelckEdhpHwoPj/2Rz9t/PSIv
 6BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913007; x=1793517807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQIRQ04ZXb5CwWPlLYF+JHdSDXtfiQB+LiviAz3OE0k=;
 b=SpPPMQ5BZNmnWNZxaGOUqcqH08UwQq200pJMy5wlDXsOJoybjdO9wgO6A6kqN4xIDa
 3L8ppRetLGq40dZol8cl50R4tEL1TC1JA2uSujOxz0ifoP7JaX2R8JPYYXTExLD9tOO4
 8EQE6eNDUXknFuGPHtkL3vprZeRbXuP+oPoYPai7IbROWwcNfHweqE043JZ9AJAoYwIu
 uM1RNyO2y8nThNrv8y2riFmik/VuHQItSONO6dahETpob7UGOdLKeHAcezVZZ20sbcYO
 MgHZkBZY9HzZJK2jI/9u6/7VgxG09qJZMYkSPMw53yMPDN68G/l1twTEJIOjJC04VQgP
 wCGA==
X-Gm-Message-State: AFq9FYLWZbkyHDc/MJpsCH585PHddMU6vkqG4Lw5IWFdKpohdCxRIjvv
 VptV9xXmE3TZNwpyR5b8IzcEQY213GEzWyMKzLAWcy4K+3LrBiRF+2QDiYRFHHM9tis35LyAvP+
 W6cIhrlY=
X-Gm-Gg: AYBFou0h0DojZCLEYUwsgl+ti/I9bj8C61jpS8mU2Xp9QP1x4nxZ8WnfR03SPCPpIzc
 3DPmEUjqchlbZhHE8A4X4Xcng0CuNAmorkqMJrts9U8knCdPM4N6W5ZvTO9uTrjAcqkPQuKre3B
 oeY2lQTs6JfELn/3YktfGsKrLPiDWJrOS7atsNGoBNS47+W25hlK0TZBmouNQekrY3mld7Hq/lF
 FMI/PA9lrMn7IFFbFiAlB8U4EzwJGtmABTcVKpsUOLmFr9rSNqfvNbCGAES5//yIWnLqwvvfpxH
 CDxLSN6NIwg2nBZFzBzPw6224D8anyNY4pAaiolCR55sNyZJNS5sxweXeEuFCny2r+E8KGLSrjU
 QUTRB8t2Da3G6y6TtGYTPA27WtehbvEp+ycH46l42KddlKJTYuOO06THuyfFqhGG5UM8QKXnm6d
 QCvAJ2XOc0F9YqLCi8h5ktf5oeDFa8Xmu9jwHHA2Os9U/a+Mrnhmja7cmJO+0Pde+7YrCyKtx08
 FHldcNZ/vGKYYoMWbUYVefO0/E63nAtHjTvgePZsnn73TBo0i9fut19rUXqyiHHdXe9cknOL2dU
 Dv3H2A==
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a35ac99b77mr53496435e9.9.1792913007601; 
 Sun, 25 Oct 2026 00:23:27 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 067/100] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Sun, 25 Oct 2026 08:18:42 +0100
Message-ID: <20261025071915.1123867-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 798785bc7b..cbeae67794 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -185,7 +184,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1cdcf3aeec..4c1fc9633c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
+DEF2(ext16s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 120dbe11dd..55bd8ccf8f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -609,6 +609,11 @@ void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_extract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1174,11 +1179,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1470,11 +1470,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD38C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5E-0001WX-43; Sat, 12 Sep 2026 06:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L56-0000h2-3t
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:36 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L54-0008RV-Bg
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso2075159a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209333; x=1789814133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zc4+IXTuCi0YCziCJv8xnw0ywKGucD+a7A26Xp2UU4g=;
 b=H1C98Hkqh1fyqjGvlAPRH9iFIxFi53fROk8sm4zMCfXwZuvTocM2FbYvZBvIbiDPAU
 gj2IqRJ7QqKoUT8z7Fz3ggBswxZ3oP7Dx0TQ5H0l4h1A7Qz4FtLRfdWOA0GJn7kjlVas
 i7yz/UqnPj2HCbnLm/r/jgDdi3ptH4VLUIRfeoaFggLgYLjRioUMQbtscjeMIpUr4ZFp
 9t4S27F9ix7GKQlf9OKmO1EKFCzGkp4Okw266hGanMjZRlOHhn2l2H5HLWfOim1/lSk0
 ugFsl6Cc10RLIktAZq2ifeO2fEorqRa8ShfMlj846AwbANXlP6MFHNYt5uut2xfOUfwC
 6ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209333; x=1789814133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zc4+IXTuCi0YCziCJv8xnw0ywKGucD+a7A26Xp2UU4g=;
 b=CgWW1l6Us4uY2Zlbqo1vtTsEbFV1D+KBG6ip1/6TLaruJ3vIwRkJSVjvqDBXHmOPgD
 7Tm951skXKi+y9YFAAdqRWXqyTtX/oMSsjz2dCyq5vaFYqsYU+xFze6wmeR0/hoxWfpw
 yP2Elf2KrgU5KjrPXJFY94Bn3HyV8c1y7skK5UFZow0IfrzGd+1tEXtcqvUaA3OD+9/M
 mGSsi5kWga2a6jD0NDOiOpA5wufJZQ0mVGlzOBUUUnhZvb4P3y3TSuaPS4dcx3M/YzMI
 1ny4oVNmZ4Hhw4eENt5JigHLwT+GBytWsrg5YpFX4YS9P2LeskXd3OzBIxg4pYK+BSfZ
 Nn7w==
X-Gm-Message-State: AFuF++no/gWUvYOR1pe4YPeTOYDgY1lIK6/6it5iJCit0cWoH1EzmGH5
 9RslnVvyf5bISm0idcym2TD41ZlJ/U87uhUdNiLoeHpX4M5CTQdA+O40iXQi30Aexm4TW9XEASa
 Xv7BuY8E=
X-Gm-Gg: AYBFou2ESSfpx/z9Jc/FwYi79OhHSrDFT07b1HXrjdXVi7O5coZSCG7B8mOVSMBsz7j
 CzDHDke7z+BaP7YOHEWxc/s71tQWnqdYoSpqQDJ+Sr8UQJrNMVmW8sbf1v9d1bPjlQwm+n2NKQM
 SX87TGwGXJFCfO8Q/XzcGlYnTi5q7Tc2ny7wEZKz9+erhyfdqYy5uVpm8qeVgYxdMuSmgIx1YZD
 VZpzmIufD4sI3bUhzk8lmx4408yuTou9t1UT64W3N3PbK4FwzeR7RisYfrNbyx4RQo+XJpdLTrO
 k+wfx0ztFG8O4r08YFVZ0JswfNwGv9cwZFEYmILCstm3wFIrpcu21DGkQAuzXdLziZYGENs3SkD
 Py+SSLt4kF0J1KNvXm1YeRZnhGkJHj+Dxk7VZITIamALSPryR8rZTx2QujLcyqui1ddVz4JfMEF
 BdSATbZ5IgImn3Kuf4E25M6coscamP6OgBy9cVqB8lo7/3Y2312QJqVHaqiMpYaDSCtgPcCLZzn
 gW9QNh6
X-Received: by 2002:a05:6a21:ae09:b0:3da:f2e4:4ac7 with SMTP id
 adf61e73a8af0-3daf2e464c8mr6251618637.26.1789209332871; 
 Sat, 12 Sep 2026 03:35:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/82] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Sat, 12 Sep 2026 00:31:10 -1000
Message-ID: <20260912103126.598030-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a7edac63f69..5dae5ce3b2a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -162,7 +162,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -204,7 +203,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 3a8b1307b10..e4b338f5e64 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -15,6 +15,7 @@ DEF_RR(ctpop)
 DEF_RR(ext8s)
 DEF_RR(ext8u)
 DEF_RR(ext16s)
+DEF_RR(ext16u)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RR(not)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3ef2220e424..f0ab8e643d8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -663,6 +663,11 @@ static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 16);
 }
 
+static void gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1329,11 +1334,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1625,11 +1625,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0



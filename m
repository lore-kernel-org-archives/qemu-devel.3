Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1D7C88E65
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBF-0003Wh-Io; Sat, 12 Sep 2026 22:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBB-0003Kc-Sa
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:53 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB9-0001xY-Sj
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:53 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2083026a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267370; x=1789872170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M/WJW3maXrqd0UUfk79/gPAJ0bTHG3rbSwwMVzZ2edA=;
 b=hx9aWaRJ7JvUtfohZFovBY6qfFtHKddkDHakGf6BP5PjNnYCXQBVEpVKk18yEbCskI
 Sm9X2I83/RLqin2kymEtTIKapcup3PnpU5BJ88xG169aseZzbULVD+wDoJVn8FVyNjte
 sMSpwOOUlVBaJH/pJ1CFZHgFl+hZd21v5Z+DORlDprlUSzLdoW1oRMGsgVLtGQpM+Dhl
 v32tyn9MJBkI44SBFrMYjxYSc7dmFvu3t95hIEObRnqZAkZtZHiaG8J/Rd0TOwcQeab+
 cAuPRx6A3mRPQgVx0acSZ0GbONcnfvdTt4kJmvQrWZ7E2eWRGEy4TbYd2UqQ4vtcjVzV
 Qhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267370; x=1789872170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M/WJW3maXrqd0UUfk79/gPAJ0bTHG3rbSwwMVzZ2edA=;
 b=LwK2MMpdvq+XgO3MOiQKZ4gNYotQERjJElS6CpEPd4bl0WBWdCxxaPR8aRgngEBi/D
 hcYqZLLMjOtmOLRAgF7ONMsDAITSFAHo7nJNzMKWV3srIbqPYpZAQQWreEw1q183+/vb
 wUoSFjAJx9WyyM/Hi0wzPTETyS2zpWKjNsIi/QVLfoB2Q6PMSgyrLsqfr2B3sClRW6HC
 5D4jtY+ZMsgh4bAbOgNaVhIGZRclbslCQP4bjwCuExWxXl5yR36F1OxnViAaLsCM+rSh
 RqGiBsCjk2+aIwpKbT5wZlysr2ioEzLst+Z3H4E2OGmVfb7QdIMJBjuNfelR0LAN8ueQ
 FBcA==
X-Gm-Message-State: AFuF++l9ZQ67VbXG8QIqc1AkdQUWc77GLpCa93cBvmJrWGKWlsGSFiV7
 eF/fFVzWrmSka9jsrIS6NDX8P3EsmikOJ51X9jAn8QTfWV1mZqWWG/LYqRSdN0EVZVNaghFt6Bb
 g8HCUREI=
X-Gm-Gg: AYBFou1Hypd9WS3IUOynaY+/Ylh304GMGVhVocsvGgmeMqxeRNqGXPoWt4ty8kAYV+5
 Kajkw7A+EJP2hweiXKWP+IDPE7Ob2dayQe+W9pNEGf9Em8MjhIS0nzpxa30bLtkb+zA1Nv5538D
 t3Q8PE5+zun/bvtSRewe6vgSZVITYBO/gbsrSAU/inf5bQTXr+VrUUGSO6N0DI9zpt/vl0NreRs
 q6Jx3DqqauyGMZAsdPgDkkuZ82Btc15gDRFqJj+ojt9q7XWmb4HYs9IB4PVF2ymD3k3VNhgV1Oe
 Ow9XsBC4+OCB1mQ/0dne6EUOyTk8DqWqm/n3uSS3QQZMv4YxE+Tg6leANrIBmhBg9t4bwBjg5Fs
 THpnDKR98Uc4a1KuVsL0AkQzfC0tovUIJvBeUsHYzoabSiOaAQYxUQ9kLZY0qsfqRXyrlIFk9D1
 2LBpGJ5JWXstHKaRt9FJkZTrq8aXZybPH//7gEUzshAbPWTM+C0LhiSO7Mt6w7Qr5/AX/KdI1UR
 wNSWUA=
X-Received: by 2002:a17:90b:2641:b0:398:9bd1:3215 with SMTP id
 98e67ed59e1d1-39d9c352a63mr19726502a91.22.1789267370314; 
 Sat, 12 Sep 2026 19:42:50 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 64/86] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Sat, 12 Sep 2026 16:38:15 -1000
Message-ID: <20260913023837.741866-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 94eb510a1a9..011d3aa522c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -188,7 +187,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index afb8bac515b..80807eac2b4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
+DEF2(ext8u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b7a8cf108b8..57e5ab9abb4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -699,6 +699,11 @@ static void gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 8);
 }
 
+static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 8);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1294,11 +1299,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1600,11 +1600,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 16);
-- 
2.53.0



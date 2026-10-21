Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E54606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YSKEdmZc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGb-0006Hw-SA; Wed, 21 Oct 2026 10:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001e9-FD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002B1-J9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so589289f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592565; x=1793197365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pTgC9a2EfxOgcOQFTEeBqg30CLCT3O3XZ36T7vMnaNA=;
 b=YSKEdmZcgmXPJmDl0TVzn10ozvNmIyzwDoul0hCVlnHsqizUbF6C8vq3Eiapp8wD53
 Kev3c9XOQijkpyZOZnGQgwleesdQk84GgSm1o0yLSDdf274OD/SGWQXgh0m5aI0ek3rl
 H6xX+YpvlVGNLrOPAKTDg/ke3IK1MFalHrYIxw9yFas7wRj5ftkeWzF2Rz9hHrBZpDdV
 YoUy1c4bFz1YrEEpw4KQQzUeHxPPc2CEoDTkzHlHd+l+rvmSQq+FEB30UHXZeGT+Ezf7
 URP3OXipn4+zD/lrRCdXNbhxrFdIfDJejC0+qmw5/4mLhdwuKz+h1fZ4Ma7ze+GPlfp9
 6ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592565; x=1793197365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pTgC9a2EfxOgcOQFTEeBqg30CLCT3O3XZ36T7vMnaNA=;
 b=SYs4GsQCUh5lRtGLNYp/YMEr4ExtqLSyzHmLqO+OFniSzv+Ds0gD88+TH2cDDhZGaa
 NhtRJ3rHLmsJE16akd2kbmm8VVWOCMhyCpPdqFWcWd+LQ4ojYFo4Wo3if+q1TDaLvJ+H
 ck9d2iEyEGkMlaD9QC733CHuMkolp8D4d02UiKOPH0hYterKM14gXHOFINf9HCQPR1hq
 64UWgm9s2Ck5jf9WWUQ145igMdn8ylZyRs/GVfOd9VUuDw0oY4GHrKEdXzFn+eSrKlda
 fiegLTPbjphYHKahkTvI+hFrpKL9LZf+3xR5FtQdZiTDDLKnJP66UZBduHgpjA7cBqos
 paRA==
X-Gm-Message-State: AFq9FYLTTPSwhX0SB2VvXu51rDXV9hXz8YuSSHf/2MoHw0ZwurDYDcH2
 0FpaQlhitUVVLIXR3uVbrSo3GVoKj8SPaFLid6FQ5NoGDGO+N2EiX6qcxYbcmjTmhIeJ/OWt0qJ
 ro25321Y=
X-Gm-Gg: AYBFou2zusXx0UHsQWVxBLB0lNb9tIiQH9Dl7sWbEnRIoT5tZjvveWbDuFA+MMKfzyr
 SJXAoMgt0KeRpsRwmjQF7IXjkHrvSG1CHbrT6DyC7GyQ73V2uqcmea5lP+LQGAim2joaxHLoJhR
 ZddHMC9132h3R7s16cofzcLick6JcWgvwFWQxHkw7HqcRzfP1yl+t2aIUTQU0k8s7IBq+j2RAFe
 31YrQedvT1wm2K6wCrgGeSoHnbkJuOR9QjEdyW5Psr+wlYe4BQjA+Wk61uZHhMA7kDSJH1Z3OfW
 kb2l6aYjRcHjl47SXN6WrYwbn+PveoQuaFfrW1qwMJLTc4yl3Rvz8I6q4qTJPxWM3tt/KTWyXZ3
 1W1RlcX/pc0q50sKXUNakH+BKVPe06Z89xuKFj5zJ6QLzMrViMTM9YqxvpgdNHsQx9odV5iQ668
 k5aSGEoAINg1KFuwMcQbeWmDbH4SXzgzXHVFnTfUTJaMPCPaUo36ppQviPtCI1VNpl5RkORrH5p
 FH395O6AMMc8ShIZkukGlA64qVjMRNdudA/ATKXhHot9UyRQ72a1uopkmynMjx9WwrQF/6U+mTn
 nQkMoZR4gOss3I1EAog83YRVCtE=
X-Received: by 2002:a05:6000:186c:b0:48c:4d32:ccf8 with SMTP id
 ffacd0b85a97d-48e26493ac1mr5045046f8f.16.1792592565357; 
 Wed, 21 Oct 2026 07:22:45 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 066/100] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Wed, 21 Oct 2026 16:16:18 +0200
Message-ID: <20261021141652.363109-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
index f2e69a21e1..798785bc7b 100644
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
index a5b2bdcb43..1cdcf3aeec 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
+DEF2(ext8u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3c1e1fa958..120dbe11dd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -604,6 +604,11 @@ void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1174,11 +1179,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1480,11 +1480,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
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



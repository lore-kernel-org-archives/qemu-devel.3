Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBB606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V+L+j4eD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aL-0006XB-4b; Wed, 28 Oct 2026 12:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aJ-0006WD-9Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:07 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aH-0007YV-3U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:07 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-847ac7ccd85so783853a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205184; x=1793809984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAMNDbHUNDI+apCmKSgDC28TQZ7cIrC7r+UwC/sNOys=;
 b=V+L+j4eD7HRFj59L8Ym9dtTcfyvRI4kzK91oGMzqT7/UGlmFBa7ZFWL49pfeRUH63P
 1Y+XffqHQdiwXSe+kGjdvXMSkbF2BP69y7eH9pTqmrGqAgX/DgMmS8GbIRu63+A+S5VR
 Kgv+ribuHeCuJiIsTzBlXXr8Dm8JWyaci+CRLkcHqnchrhLB7gJ4cBuarjYtP45bczrh
 bSgLnxCCV+g+FVfyCdngyzTYnI3hnovfOyNsDP0Oxh+EGRuSc3Sp2/JnK+qaWagCOehY
 T17fgJWMNSujH1aBVUA3nnD2z8wIjfwbB7BDStLVTYLgTLk8fy1p5D8TcVCXk2NPGOia
 zWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205184; x=1793809984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iAMNDbHUNDI+apCmKSgDC28TQZ7cIrC7r+UwC/sNOys=;
 b=bCXQ9u8xF7ODfdwhZTD1fybI5wzomB/qpAGFeYNQLxF58ZU3e1mV/UaeGou+7mGBp7
 5WFxJ3oFq3HgsU7hNBUrIUnCJP+9poTGlYcpgpT7x6Wl/umAFdCdscqI1m560eE/os+J
 tDqzAIiX9KqU/YTbVe0pIRPWE6ws0hUCfAXxvQv3tp3SZwi/Ta5+cHGv/UeguHkRglZQ
 +QOvN2JFzgwe8stm/7uX8sM3KzF2EphweQx+bQKXOecPrguZU9Z4McOlMc56/KvF1zpg
 CsP6Os+9I1VGEjDyAFCaauX0YRSqCuto7QLBwhAOnCiZ4UwH1smc27RY71Zno8ita875
 8gdQ==
X-Gm-Message-State: AFq9FYJaiXWGhJGW3t+sX+X69kf5ty2VkrwPWWUuHD9JXMhgaq54Eqvg
 b/Sjs1GsswHfuHkXAQ/HCIDLOB7aN0tby+VvwGHSiwRJZgMvn42K82fg6D4eJtYLxKYRgqeiC+S
 O5Rs9
X-Gm-Gg: AYBFou08WosIBd7PD7rr86qME+QbzMe8UAUnMsqU7tEAu3Yp0bMZLc57h10Z5gt5Frn
 2NGBzucEf1E57OCbMAyFTJ4BNklOePYigWC2rZJWvqchjuCKKwg+AkoKnnOVQGepd1920S4nYG4
 Q19q5KKjH4+Pwy28hg531UCgdUfUsYM41td+tUh0v9X6w6rL3H6pq0X+JNAwoEFcEHtXj05hzB7
 t8Yp/g8B90hPjlR3kHh0oXmM/UfAfpsr6/1cbMjYmiCeAwGBzsmu/hMJzv9zeMqWmVeWBqBNXeo
 jpYqMUCtwMKPtxiKhguPeFpkXChpppGm9JL0vxAJ/QaK0q7dSTnli7uainxwT6hY2DZrLzRlBqq
 GxvahrYItWJuz44YBItGFtuQn5YPQxv7hUeg7w7f/0tunm1U9mAt351BgdplurZA2fYgBE+aXTt
 ExskYtDPK25m9lmhU6SmEtlEHNHChk69kujUz6D53fds/k59ZtWcts0Ir73HY+SiWG9bQnjNVXz
 9t2KlwRztE7iboko4V7TcX2jEyUIVeed9PvhLEOys/ZDKqifpbfbSsyFCnYOdAe5uBMZqEw1Xh3
 nQECeQRjy4XVzlgnr35b4ycSsZUt5ZBABNf5JHfXVo9AHl4OmlpqI5U=
X-Received: by 2002:a05:6830:3115:b0:80c:d34f:5f65 with SMTP id
 46e09a7af769-85abdc07c52mr2930375a34.30.1793205183840; 
 Wed, 28 Oct 2026 09:33:03 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:33:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 13/16] tcg/loongarch64: Implement INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:42 -0500
Message-ID: <20261028163245.1031673-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
 tcg/loongarch64/tcg-target-has.h |  4 ++--
 tcg/loongarch64/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 31e6ea9632..53b7ca4057 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,7 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) >= 1 && (sh) <= 4)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 17784d8bbe..377cd9ec08 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,8 +2098,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sladd_w(s, a0, a2, a1, sh - 1);
+    } else {
+        tcg_out_opc_sladd_d(s, a0, a2, a1, sh - 1);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0



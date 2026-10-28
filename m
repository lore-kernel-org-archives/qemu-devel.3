Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E3606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j1qDdC+C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aH-0006VX-1K; Wed, 28 Oct 2026 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aF-0006Um-9o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:03 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aD-0007Xo-Hq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:02 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso898871a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205180; x=1793809980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/s6kyHIPPO7wmb797pBUvtqZP0z9Faww+WNYejTokjM=;
 b=j1qDdC+CUjLR/OWbvbsapVUYDh+gDlPWluEDdNAlci62bOnRIwz8XJj7m6wFDZkR9i
 /AJnLzQtndatOHT96tOGgcqYjulXZHRW2Z35uxUCaNoQQ4Y9meF+2tlAyi9ggtGiMwbV
 jcm+MW2FyI9eu+g5BpflR6SBbaxo9+O8tEtWqqnXEPg+/3H8o762fsMTX/1x9hTjzV7I
 alMQHyhWOA5h6B/+ZDxXGRe9pKrJ8rYZntU2Fz05vNN9qOnZa6q6DXRm8ueVdfZ7KMdS
 w1nzUVIwKXEhW/RXHLI4thlSm95SwG1/ENXuPRQTRgNsNZymwkrC84FwR+wGwe30ECeB
 syZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205180; x=1793809980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/s6kyHIPPO7wmb797pBUvtqZP0z9Faww+WNYejTokjM=;
 b=1Yd/ptrqkGzCdL3hAv5lCLzvz0KKqVTMATNj0oScFajBdmcqceqrOsffRv+DEdTmVh
 7F8cJFQ+j96a+NESFXKSX+xBEP6XVqF2NKV6UhGCB80Ewqf3Q1prYTcn9o/EBQv0A/44
 jcsVW2MPaMhdY5Kbmyyu4pPOltG/F5ehSFMyZdNv2wH0DmGM0anKm4KvMy3cbEC6GvU1
 POkrk/kOxGtNPFqcdUvNYhQm6JyIBKxTeeIh8MmOnp4MRdfC3Ij10cT0D2uV9gt7cTDY
 yp3VZaBf0PI/a9APq3gt8RBX+Y+fdQIXumUIEIT91+oIhRnBdGvCjbgIRyr2jWwz++yD
 0X3w==
X-Gm-Message-State: AFq9FYK5HrnHS97H6ZcpikMnA+iCF5vmgXgIsDwsNItRm2b2mRfRApfN
 HKf0yVGsYUOYhMKuXELDTD9Q2JVhrYnuksLklioHJBlCDp8VGaHhChyItD2abCWLDKDAWwHvSx2
 r06rp
X-Gm-Gg: AYBFou3MRdS473EJA5H4gYySLgpOPFOilSak5lhqVkQFVTLPtevdJ6imBGLHz/M9djU
 FJpBDeJo+a3IZrpRb2mz5XlrFJknI5g7SJUDZAQf4fygLuFevAn+wiK1ROTgDvpQ3BzlXzDfkt9
 KYuzIYm9NV0ObtP3FoZuOl2wAB5Ts6B3tGIibiAo1Q+Vw88OmEBzQgo08vIo3vrKIGjy9XUUMWR
 tyRYKBQy/An9jgbegBgseQKugQTNYrvcwRGjOFNtKMHeOO6xD7kiif2ompFvYWTk5MAk8Qq9Zhy
 TXKNFVrn5/L9M5PBJEoylOivDN9S6XS/KOz0iRHi6GSFG1GQVd0Q8x5CkUaHgsXh54SuTDJqSO5
 NAk7II2z5ueNdpiicTYnoj+Ydk9/n4jFJWAKSpHh47DWyo3rl5pT6IB0WDfR9OQRWycyCOhgPa1
 1+PCNBIZdrTT3RGza+O6gyzXfEyteS680VnZqJ5y+fYI1CgJCUcyr9DB5sEI3PyTN+lO//L/B8f
 f99L20PXXLDecMIPg4Fj0tJBW+ZpBE9eyszrCfl7LwsZbuKWGbFKMcCptruD3IKyOYJeQ6fyZJh
 LthRngMIEG7mxuNT4gZMEhVxwGziIMqG9Uqm6ux8ekEFSajgVX3QWuU=
X-Received: by 2002:a05:6830:410b:b0:812:3ec6:58a2 with SMTP id
 46e09a7af769-85abd516b69mr2648691a34.12.1793205179967; 
 Wed, 28 Oct 2026 09:32:59 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 11/16] tcg/x86_64: Implement INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:40 -0500
Message-ID: <20261028163245.1031673-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 tcg/x86_64/tcg-target-con-set.h |  1 +
 tcg/x86_64/tcg-target-has.h     |  4 ++--
 tcg/x86_64/tcg-target.h         |  2 ++
 tcg/x86_64/tcg-target.c.inc     | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 7df9bf4917..2529539f89 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -47,6 +47,7 @@ C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, rO, re)
+C_O1_I2(r, rz, r)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index 6ffae51f92..f1d3d256ee 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,7 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == (int32_t)(imm))
 
 #endif
diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7109722f24..3444bcdca0 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -80,4 +80,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_NONE
+
 #endif
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index d85e95a32b..3fca0693e2 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3361,8 +3361,17 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, sh, imm);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    /* Allow "lea imm(, a2, sh), a0" via TCG_REG_ZERO constraint */
+    .base.static_constraint = C_O1_I2(r, rz, r),
+    .out = tgen_lea,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0



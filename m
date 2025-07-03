Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AF7C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkK-0002dI-1p; Thu, 03 Jul 2025 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkG-0002be-Ay; Thu, 03 Jul 2025 04:56:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkE-000824-GK; Thu, 03 Jul 2025 04:56:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso4819831b3a.2; 
 Thu, 03 Jul 2025 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532996; x=1752137796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKRfOMZpAFbQW59XcJc9qTc3jh/YMdne3jcVAlhxqzs=;
 b=hhB2hXRBMcj083kErq/iYSX+lcEiF6uWUBN9eLE9Pdao/V2PrOHD65Bjro62c9CDPn
 voK1kWvh2EbLlP4rcn+Qx4Ma2MiiFMMiO04/N4nj0apAT++5SAI3GSV9ezwTBRRqUWlO
 vGejemD29VwWucBvW1CJ9MIhQy2ujN3fYIBYEKuOUeZVWiLGzba68OKb3wbcb4Yahvmr
 nGvfvjN4MPxOjsP0gF8z3Hpmupoxe56Hr6l6gju5hLldokK9K+/U80baHfyptIruumE7
 s66Lk3oFdlYEckw1+7Xa10kq9vujDxW4CVCeUg6Wcv7g8GwcxSrGFb0YUWTcheebzPdS
 BaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532996; x=1752137796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKRfOMZpAFbQW59XcJc9qTc3jh/YMdne3jcVAlhxqzs=;
 b=ZCeZ4p0mb6561MPesacKUk8a9EtAtXWcaNx5iEn6SLblm4+JNWlWBMgAhP40TkiMs4
 AxuZf2KRLFIqiaRHxJebCwJIy0gmV8ZPmzomMAkOinG1Sl4X2UhzETxwD54a4QfUjpYD
 JN/QG++XduhOz0DDJnCQiGcAbg/o97/hPql2rTgbYYU04Qy4TSrr/bnJD6YBMPvfRTRN
 LSmrQLVP3b/mmzX+04T2KXr4ER8UxST5ZRXCu+Mt9UID1z0QCI/HLcjiMZOqNcIzTZBw
 FuZxOp+n0NAXDj315jnmJmUZ/DCoG2baRFl8YHN2Wvkm/3RAJJ0gEg3m1TMdxYqjDvGA
 LaGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlpkji5OB2OojtxjOjHrRrlwVe2yMY+qpKOj9AmyFe5r7ubM05ivf4Spp0GjOFoaizqaGITUDTqA==@nongnu.org
X-Gm-Message-State: AOJu0YxSwTDu73uhQhiW3R9TPrgHblYuJgpRXSkQ3dF84C7EFHjYsqNz
 crxO0CZAJAQj2fSrK7OMSozHXi9xEu5VNaGslMICDXTABhv9n3tTW/obHUTaBEWMWvU=
X-Gm-Gg: ASbGncuZTfJeZbp7WSiH3tnI8THFmFCgPeahK/AMA7lS6T9apYmj4XMq/yI+loAXepJ
 TyFIYXtMpSDfGWs8wLKJdpGQXYE2QLLA97d1foxUkJr2EH3H4ENfSQZOoDpiQEi4M7h8cpoNnCa
 0tYBxrppH9e/1S6OmfMcj/QZ1LkCxj14Ku6lLuU0UU3TIRXi6qQuxStTDMGeSNC+InAJsN5lT8A
 u7mwMnNuP0h0L1H/dDxK81vuR6BOuPyfF05/Hw1gz1uV2HHWUYCZOfjr9yZaX7iJC9fccxaBgPh
 JE3beCIABXsL24uKQ6InBAIefmHtWI20PuUvI+YV0Fp+cgh7I4aEoTrL8AjxtAnBqHkdVF9kyBk
 LvBGw6b2zr4JiBBodaV0yCl5Xt/uzBsYmtnzwW3QFrWI=
X-Google-Smtp-Source: AGHT+IGzwAlqDoi6kEjLNV9yt8UNZjj86pVaRPcoqGg/HZwvAIlKSmyjfylRqhK9d0Dzq8ITLBwF/A==
X-Received: by 2002:a05:6a21:6da0:b0:220:99ba:6b5d with SMTP id
 adf61e73a8af0-222d7f33162mr9017321637.39.1751532996074; 
 Thu, 03 Jul 2025 01:56:36 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af57ef4dbsm16631704b3a.160.2025.07.03.01.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:35 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 05/11] target/arm: Fix VSTR helper store alignment checks
Date: Thu,  3 Jul 2025 18:25:58 +0930
Message-ID: <20250703085604.154449-6-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds alignment checks in the store operations in the VSTR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 8834523c23..9587f2da7d 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -172,15 +172,17 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                         \
+#define DO_VSTR(OP, MFLAG, MSIZE, STTYPE, ESIZE, TYPE)                  \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
     {                                                                   \
         TYPE *d = vd;                                                   \
         uint16_t mask = mve_element_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (mask & (1 << b)) {                                      \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
+                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -191,9 +193,9 @@ DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
 DO_VLDR(vldrh, MO_TEUW, 2, uint16_t, ldw, 2, uint16_t)
 DO_VLDR(vldrw, MO_TEUL, 4, uint32_t, ldl, 4, uint32_t)
 
-DO_VSTR(vstrb, 1, stb, 1, uint8_t)
-DO_VSTR(vstrh, 2, stw, 2, uint16_t)
-DO_VSTR(vstrw, 4, stl, 4, uint32_t)
+DO_VSTR(vstrb, MO_UB, 1, stb, 1, uint8_t)
+DO_VSTR(vstrh, MO_TEUW, 2, stw, 2, uint16_t)
+DO_VSTR(vstrw, MO_TEUL, 4, stl, 4, uint32_t)
 
 DO_VLDR(vldrb_sh, MO_SB, 1, int8_t, ldb, 2, int16_t)
 DO_VLDR(vldrb_sw, MO_SB, 1, int8_t, ldb, 4, int32_t)
@@ -202,9 +204,9 @@ DO_VLDR(vldrb_uw, MO_UB, 1, uint8_t, ldb, 4, uint32_t)
 DO_VLDR(vldrh_sw, MO_TESW, 2, int16_t, ldw, 4, int32_t)
 DO_VLDR(vldrh_uw, MO_TEUW, 2, uint16_t, ldw, 4, uint32_t)
 
-DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
-DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-DO_VSTR(vstrh_w, 2, stw, 4, int32_t)
+DO_VSTR(vstrb_h, MO_UB, 1, stb, 2, int16_t)
+DO_VSTR(vstrb_w, MO_UB, 1, stb, 4, int32_t)
+DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 
 #undef DO_VLDR
 #undef DO_VSTR
-- 
2.48.1



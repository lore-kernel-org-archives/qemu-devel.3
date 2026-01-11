Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C338D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 21:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3SW-0005Nl-K5; Sun, 11 Jan 2026 16:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SH-0005KF-Il
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SG-0003qf-31
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29f102b013fso56050955ad.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168714; x=1768773514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7bUhjG5kmt8fzBfivCYU74VwPrNWZoXlTmfqsg4KSc=;
 b=h1qjihBYtN2lW2Uwl8L7HP068QOilkd/rmyBw12WgS3FCtSA5vosvc1RKAuUPUkoSf
 99d0D7bqMHALbOflg1nluRZ5R+82pMQrnnItLjh5FeRxZezpcL07dH20n9LkWpLfIB+s
 2ElsRLwDoVyWf7Dw7ujms5nmPaUerh2YPIi+7D5LDt0iQL+zi0eO0A/RhyiFeN0bGDOz
 6Z7zjArXipkYPs8+kBRab99515WMYnZW4s+31U37BmRtNwM7SNLz8k27Kq/5BU+xjoo2
 70EIj+RzWe6FH5zts5jvrpTVDsGXMyi8ze2WclpMLhuTd92sUtXqkgcELEvvhZVSvv70
 53yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168714; x=1768773514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R7bUhjG5kmt8fzBfivCYU74VwPrNWZoXlTmfqsg4KSc=;
 b=OKy/MNnfAJGHdXFe6iT2FX8qEzAgAIRyOlLw4LDsut1EgaWoGAG9zXLs3tqSp+9qwm
 B5s5sBD1EUvehLHbompRFj2Mxw8hn5CTJeePeRccbpA96njiNrz4G5X21itt4vSYv7A6
 UeqIDQI2229EsfP/9Arb2K5IBTm6jnCOzbAJsYPSf4HGln5UeKV9/zOhYpxc7urKHlI6
 x5SVRr+eW2JY+IcgmLPlnI+Sg/uY4o1v1e7lbNlDf1zFC/J1Afe7FyeK2Xjx2PRh0Q+b
 DVCErTUI9BBhh0bvk9JMKiLuCV0cG/oMaCtTB45nxvODTK8GVwxdZhJFy4d9cZHNuxyl
 Mmfg==
X-Gm-Message-State: AOJu0YzBHoIrP/GN7fOVvxTB/pE78IqsMIDwTCmgHRU3+ewmbJ/CI98z
 luMFFVRZuMFN9Lx52xwjR7rDUpkb/8lLYsxRhBSj0UFEoisjDvmro8GoRJjGoBxmyVavpsHnihW
 7ZbVl2qU=
X-Gm-Gg: AY/fxX5GpH7FDPhSrVi+bHmr4nKoei5ARJhhxuQJhKoiipibFZ3JBU5a80oU3Yj4SiB
 DruXdxUDyQf6aHVgsTn19gOGFfisM30aGy/ZC7XcSWIgx8unDVL9HcUzaVP/uuJW8/P1TjoJJxd
 0mI4qWS7zHsSTF2Kb2sqMIumFLIvTYCA5LErwjytKlpG6AMU5tNYSVNvh62+OSX2ru4Lid5Kj+R
 XoKxsVGqbaVKNpDOJXIm6G+khW6NegKQfLuCGj/2BcJPdJaT2Ymu51G4M8/DqHR2KEzFx/dEGH4
 Skc22Wa3mA0eZSZiCclHwKBttbb69rgFtfJ19SENpTv1VY/lcTK6EtbrhQRpFyltWoLeWRo/c2z
 UgHQVCUz7hx6TtyELMETAm3L97rksHeOSBbH7zlfWAG1bhfPLoGt3nIfhwPDt5U2g7xE846slc1
 v3uMTGh6U2Y8Pp/I8=
X-Google-Smtp-Source: AGHT+IEMBwzALb1eOZAnGxGp6+biNRKQN3m44QN2gviEyS91ybNDI0Ug/UFA8fO+HAFIMRyhv92N2g==
X-Received: by 2002:a17:902:e784:b0:298:5abe:4b1 with SMTP id
 d9443c01a7336-2a3ee4c11c5mr158799065ad.52.1768168713576; 
 Sun, 11 Jan 2026 13:58:33 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PULL 03/13] tcg/optimize: Do use affected bits
Date: Mon, 12 Jan 2026 08:58:08 +1100
Message-ID: <20260111215819.569209-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

We inadvertently disabled affected bits optimizations on operations
that use fold_masks_zosa.  These happen relatively often in x86 code
for extract/sextract; for example given the following:

   mov %esi, %ebp
   xor $0x1, %ebp

the optimizer is able to simplify the "extract_i64 rbp,tmp0,$0x0,$0x20"
produced by the second instruction to a move.

Cc: qemu-stable@nongnu.org
Fixes: 932522a9ddc ("tcg/optimize: Fold and to extract during optimize")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251223163720.985578-1-pbonzini@redhat.com>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index db1d89396b..5ae26e4a10 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1103,7 +1103,7 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
 static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
                             uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
 {
-    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
+    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask);
     return true;
 }
 
-- 
2.43.0



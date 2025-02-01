Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707A0C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYC-0006KV-GP; Sat, 01 Feb 2025 11:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY5-0006DH-I3
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY4-00019Q-3G
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso20904865e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428047; x=1739032847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Egp+V0OHLXdATyi6Key5uNeDOPsftZFQN0XkAxWwkRw=;
 b=Tk1KND8tmSrLUUTOLZpNhBMTnsk+CAdswD3fsRLBGb0ugjZ5MI/q+u0OAztBM0N8y/
 fpRMT8MWS+kqhXGsh6txCwO9NqrdOu++JtzY/1Mp/BlDJcXIlXnCIT2DehHB1IXQBPu7
 ZDksYF4iqNrtSIHrfxYA88mpvppdcYBzpTyGFNGcIjU/O14KYJTnSSw+KqJV97iSZ8D6
 cE/Mf4BAKKQBBJ1ia0/roS7SfTKd/CEe0PUgXB0yCZ/Bc+x3oZZE8Kv2Kytli3aiLbjk
 v0GFIf3eIRtvPxFU39qmmhUlILpfltb5DBUbnmm5SlunY61YANdfKVNvxaLeG/UI6Zbb
 cAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428047; x=1739032847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Egp+V0OHLXdATyi6Key5uNeDOPsftZFQN0XkAxWwkRw=;
 b=anGJbCVt0duI7S2s/0Gz7nidHeD28Z32izL95aESao1EfDQ2rcpn8/UlkCqoMover6
 lVP7SgXMk3vBPhzaPE9xrsa4YfJvR+UT3MiVm/5vcvgEQnhBEiad8+DwkgzXwFrcQfY1
 FXq+DpdGb4uvSYvFXw6oKT97i2XqXHOW+JUvjbOPn7+uwSMPLaro+a3o3FGd+yUsFOv8
 Ps6IwHORfwRzL0js5UFZpWqBazxCMrhhc21fImsAXW4fcn8QtzZKf6UfvLae9hjl9xv1
 HD8YcaN2Qzsnb04+TstcvKT+2E7JDlwGBfzEM8MFq7R9yrd7LeGdyEouTySLqRA+WKXm
 m+Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaRrhRjIA2KpGZV5fPA/w7pbD7VILxGHM4adVwbit815Kc5dyJMeuZbFfakPNUjtLBxNn07MNAKh3L@nongnu.org
X-Gm-Message-State: AOJu0YwLmTc0q4EqeERHJzIYwx/NCeFFTm4/WMx5+uns7WNgOrkl1nr1
 2GiQINRm9tpndKcgCbQdmF1rJgxeT0Qms7pfZalw/nErZnPyNCpFK9v3SGaz84E=
X-Gm-Gg: ASbGncuB4eNysVsklmhdCp48nqISJtamg/+EaMTwHIp4gkufUGgD4YLuR+5GYJl+CUu
 KFWeL86K2tlv3WmsuUg7ESUjP5dvj5WkA88ta+Ott6v71UO3eEuBr+JIlBV8oon1i0lGbcylXdI
 ebsDYlETLWrhe04DePR97lGRtdFI6najDtMcOIYVpF/2WMtFmUqZE5xUKqQpnWTp9B7uy0du94k
 mtpXX8hXyofeuwL3B7Nbt59Fd745eJLARFpaLeedYGzXRz3kzuYlYuPqVIDVFzz/1yCpi+hMY4K
 YDJarZ1/Sc4o9vM1oa+7
X-Google-Smtp-Source: AGHT+IFARyVo6K+nn9sGWHOEsyk29eU+GIFuuck0iXhpBFmlcKsr3hiOvvXI7jbWpmwwDO9OMq2MTg==
X-Received: by 2002:a05:6000:1842:b0:38b:e26d:ea0b with SMTP id
 ffacd0b85a97d-38c5195f9bcmr14140204f8f.25.1738428046743; 
 Sat, 01 Feb 2025 08:40:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 23/69] target/arm: Handle FPCR.NEP for NEP for FMUL,
 FMULX scalar by element
Date: Sat,  1 Feb 2025 16:39:26 +0000
Message-Id: <20250201164012.1660228-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

do_fp3_scalar_idx() is used only for the FMUL and FMULX scalar by
element instructions; these both need to merge the result with the Rn
register when FPCR.NEP is set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 73054b6137f..334aff42753 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6307,7 +6307,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element(s, t1, a->rm, a->idx, MO_64);
             f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_32:
@@ -6317,7 +6317,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
             f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     case MO_16:
@@ -6330,7 +6330,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
             f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rn, t0);
         }
         break;
     default:
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2258C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMbs-0002dj-1R; Fri, 24 Jan 2025 11:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYj-0004bI-6C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYh-0005cw-0L
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so16742425e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736165; x=1738340965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v5Tz/8qeASxQsHbh8eTYF0AFW/V0SNYL2us/VX5QjOQ=;
 b=E03nogmvOwWcKOnvcfiv9M9R4vr0jCyaHIbZt0VachBund4gInyQ9oNB79iqWKZDt0
 Rl6MphP9JazBJd8kAHWQWrylJZtclXRxVnX64mVWaedF1bkJJAWVNxZ37r+AhUz4sqwP
 8w250F0peIit/BlPtz5OccedlNsh/6nrPESX2VIosbiuoVvMDSRtJUYZzM/G7tt+JkST
 8Mr+k9B394CUWbhgWCn3TC/2gb94qIaSUT1kToBeVncavmE8yHDLmCHKUpykt0omBp5g
 hqkstzMSusoIelkb6NAyX6CxVh3D3aLNVzHk9HuvYkxZueW5+Anvht1paJCfjLjQWFqM
 3sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736165; x=1738340965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5Tz/8qeASxQsHbh8eTYF0AFW/V0SNYL2us/VX5QjOQ=;
 b=j6jRhz/5TBNl5Iedlbc3VpaekHNm+6Pyu8vMtKXX8FTvxfaxz0SBNt/FChhDcZCGbX
 TfNhckSukRkaq/dLtsmSolK4Z12DH8BxuzRStzSUB3x2Is+m0s94AAIsR1veSmfVlsAy
 WzBhj3S+zOw+4V0Yvt9En9947yAr2Cn4V899Av1Ly9YaTXAVdrzo7MgdIRM7Ezf5E3BG
 q+zCVoAfEdd3TLxu6AD1FPGzsdrj3Rl8qNawVdOY/nWV0QnG+2jRZKEuXajyuZjYLeWd
 wcsYKorKG8vT0W8jBBAOTWAXFdwuAC1uienyqHFmU2SvfeOlEb5LHElI9Lgvh+iyY4hk
 Lcbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzzhD/mbJa5wV27eHNjydA9SwH3M78hDfFtcEeV0il+iTpJ+r68P9Zpn+o1ie0a6nXW1ueTp8cl0H0@nongnu.org
X-Gm-Message-State: AOJu0YwGNMze59aNe//JhCyIU7G+y4+t26cWw2ibOf7LB88igfU7U9YL
 Dz4MpdXb8Uyb1dx1mWTjXS+w8ab+lS+B3nnFnkOZI/lrvj9Y513nITqkGzCP4pM=
X-Gm-Gg: ASbGnct2jLyRWvydKhE1kG35JDt0NqAUItexQJh9knDMuIMe0Gw4vD2m9w3lgIFKKu+
 W+p5ktnybpBq9oIJ4mNpOd4mhWvbE3t2PgHlNd/jTwXRWFJKJLeNaqO8wd9gVg2A0BfOvlLOg9m
 C0rr4hcrE6gd17iXLzrPwJMJbPwfZh6cXKJTmmYbAV7uz4zAB59Cj2b2EjYAkpAN973EpWZdoEW
 KnTj5iUECOEdnLMDUvq1MVadlzq/qiGwSCBSQ5P0rZAhp5mPA3SQIpjRfQQ7YwaZsb1PLbhbB3A
 xO/FGFzqUQE=
X-Google-Smtp-Source: AGHT+IFhxEWfwozrb1Va2N7rwV/4svKDaV37P71P6X1gBBjPnIMVPALyIHxcCH6gTiKI5Oib8f2XhA==
X-Received: by 2002:a05:600c:450c:b0:434:a91e:c709 with SMTP id
 5b1f17b1804b1-4389145145fmr259338315e9.28.1737736165503; 
 Fri, 24 Jan 2025 08:29:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 38/76] target/arm: Handle FPCR.NEP for 3-input scalar
 operations
Date: Fri, 24 Jan 2025 16:27:58 +0000
Message-Id: <20250124162836.2332150-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Handle FPCR.NEP for the 3-input scalar operations which use
do_fmla_scalar_idx() and do_fmadd(), by making them call the
appropriate write_fp_*reg_merging() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 19a4ae14c15..66c214ed278 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6356,7 +6356,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negd(t1, t1);
             }
             gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_32:
@@ -6370,7 +6370,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negs(t1, t1);
             }
             gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_16:
@@ -6388,7 +6388,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
                                        fpstatus_ptr(FPST_FPCR_F16_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     default:
@@ -6867,7 +6867,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_FPCR_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
-            write_fp_dreg(s, a->rd, ta);
+            write_fp_dreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6885,7 +6885,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_FPCR_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_sreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6906,7 +6906,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_hreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
-- 
2.34.1



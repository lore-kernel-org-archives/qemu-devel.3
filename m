Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C414C021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5d-0006Vb-NR; Tue, 11 Feb 2025 11:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5V-0006Sp-Tx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5U-00036n-9W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394820123dso13876255e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291175; x=1739895975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0k0Kw4Ra8wn9+INZJ2lXGRkC7tjdgx3LJCN8hyvaYL8=;
 b=TtKXpclyAcQCssMik9eO4l5dkDHjNSYZu6dSgzS14P4cMSPMDdFN5Fen7V9w975Qy/
 xvCkfTR6f6d47b/bi48g1nLraSDBtgXbS+5kRLsNIvciul4Misy/7/OSbRhKNFSw1JnD
 928y6p1PpiyTXkoV5O9IfPRy+ba/l4ip4JeDQTEv5VCpOR0hM3waOchh+Kl1wjgTa75d
 5vqyjt2b54JpJIusQ/cXcw5u5daQESXFDl8nTDab/ZTNQ4RtpbueXGJxSitf+ZQOCXaC
 Ql02QDuSSP60UFt75rAyhKvBh5i/b6AnzRiEOMGXDeAffSZmJwThWA+WiIUl/kX8JVfN
 Jxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291175; x=1739895975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k0Kw4Ra8wn9+INZJ2lXGRkC7tjdgx3LJCN8hyvaYL8=;
 b=TDCzApo6fUmCHTb0wWAgHMAXJ5haDNCv8r/xDSkaHU3Y99sq8ZmWHzOXYkhA8Fsx/n
 k0fVZ7rKvCkKGRnTd3sO/RS9PMS4c7JiaPzZDsILo51HvHUZk4fH9+9/hcnh9fzhd37c
 6t07MbMU2Jn0QkC7g1EDJKiSXK8UB3UHU4MK9wHZ/QWThno8Kw4rI0VNKULho/CA5GIJ
 cF8gEMJJQ1j4wwdFdNN8DtoOIs0lZhE5Y+wJ2/A+/UpEvnMMZYb9v94Jr3wcJM0oXELw
 CeO60m0sLdsLUKDOZYiIff+BcYYSseoJSuSnU8g92UVevZqKgjODsugxkp7zSc4G1YdR
 JZBQ==
X-Gm-Message-State: AOJu0YzNWmkVYtM4UWeZhBXfP6QnaGPfiFgQlTzPJXP7c8AOO4svTnS7
 opKQdvcyVBR0/vCXSXmqIhPoxnr3YH57U4ng0rBsMzTrDVMCd+r6Yn54BQwdFWzabeID/9nvZCp
 K
X-Gm-Gg: ASbGncu3qBpdn9TA7IxdpiIUbf68QTX0CXcIwiPIKv6EQZm7MAwe25H4Nji2tGvirOL
 AyrahBufQZ9e5qje2oB8ySYFdk0vbIQshMUH6H4a39/ZTBmYFho0v8ZxzBJ9zgweu6KYcV27pHL
 XAcgQvJzL5mpGjxp0DT5qJlvVARQ8rOfO+L0SQpjSmvElL9MEH23virmHOpKifuRL0wsoAiz/c3
 6aIb5zJ2MPli68C6Aj2jskA7KNPWz/R6MxtivmfPcplaMY8EFWtDRpKmA2yz/HZ6s27/D3FNu/h
 fZC8Tu9fc2+ABtT6mVTS
X-Google-Smtp-Source: AGHT+IEsJnjXh95O4Yhx8Bv63mts2JFVHhNftN6R6rWbm9OtnBFfskXjhUDPNMyVvbo8j8YMb4NQVw==
X-Received: by 2002:a05:600c:55d9:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-4392508f359mr174446735e9.30.1739291174776; 
 Tue, 11 Feb 2025 08:26:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/68] target/arm: Handle FPCR.NEP for 3-input scalar operations
Date: Tue, 11 Feb 2025 16:25:02 +0000
Message-Id: <20250211162554.4135349-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Handle FPCR.NEP for the 3-input scalar operations which use
do_fmla_scalar_idx() and do_fmadd(), by making them call the
appropriate write_fp_*reg_merging() functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 67c85db4775..3f6e31d36a5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6345,7 +6345,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negd(t1, t1);
             }
             gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_32:
@@ -6359,7 +6359,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negs(t1, t1);
             }
             gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     case MO_16:
@@ -6377,7 +6377,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
                                        fpstatus_ptr(FPST_A64_F16));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, a->rd, t0);
         }
         break;
     default:
@@ -6856,7 +6856,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
-            write_fp_dreg(s, a->rd, ta);
+            write_fp_dreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6874,7 +6874,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_sreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
@@ -6895,7 +6895,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             }
             fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
-            write_fp_sreg(s, a->rd, ta);
+            write_fp_hreg_merging(s, a->rd, a->ra, ta);
         }
         break;
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6386CCAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298Z-0007Sj-A5; Fri, 26 Sep 2025 10:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298N-0007CL-TC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2989-0005dk-KQ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso1453133f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895733; x=1759500533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b4EBqWxQdk+JIDg5eMqs4H05RLmTftPiIh75XqyWcMU=;
 b=Rwzht6fNHWRWli12emK++aJ/m7qkc9dUfD/mk3lC2Q5Q9ruRqXfA9qwggYOCC6Ic2e
 asPWOqo7D9tlbIn+6exhh4o0S9fu1BF0Q1TKR2H8v1F/6hspngcwfJbYsSSaxdUE0lax
 08xmPjIa/Ui7ddv1zAEK2CKBwnQ7Wr8FOu3aIKg3wBBlCmOd3qdNGPoJwd89UJwUwbDs
 CBultIJ1CLtoxtvfFzu8xxhfSmHHnXKJ4TW5iVCToCQ7gOkR0iKkFQT4+Jhgbj7g8EAG
 tygDIf5WCWU7eHVnohA1J5bjIRH+KS/C5LlijupWS7HR9Rh18bylq+Hg4xN6AMJioe1O
 mgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895733; x=1759500533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4EBqWxQdk+JIDg5eMqs4H05RLmTftPiIh75XqyWcMU=;
 b=gXN8j5/d+qHAfrnCjkK5CIEPF+S3/yNB0FAqnNazxSNAcUE0pRmWelrXrEbceGhBeh
 lhKldifbdK+Jj25HQ6A9686YZQOmw1MgpnPvy1GMrDmRVbRBqmgyFbegKcF2tdmhma/h
 s8cuJONj+nO6knVTSx4KWsCpfgDNrDPAkbihe8HrPtmMgLNwfSgld0afYpAtQRo3UGjq
 4Hl/lD5TM6jBEpcSF0B6zIgaXF0LS7cPofnHbETjIgnwc4hg0blxFathMb6uEJs4RI6o
 yEwbE+kOKOCIJdJDlYxQ1DnuUs3+0gI7YBz0migBXs3LoIUoXanMvZErVLffpL50vqBP
 uSwA==
X-Gm-Message-State: AOJu0YwRSIEQV2yD/KTg0BPBxif3AsibcB6pmzadC5tOVxfEWvXkMiuV
 SoJM8tiW21a1p9Z9hdOY02pl6DZM38dqzLMXUvTmz3WtrZY2SFP1WhGxkySsgHhM3hPrBGrHO6V
 V9Rk/
X-Gm-Gg: ASbGncu47kEPY9HoFNShlSsirLaVZTsmZ+IWkPYRpHcBBGljTm5GCytmFbXDhP+i2jz
 8TE1bXj8PRHxg0pxogBSTYNFB6luPaKk7GhEybSfbQ1nM6b0d64gjIuUlMBtfi4lZNJmziEVeaA
 XkAcpL9GCg+kf9KvATpXmcqsnnrVf0n9diULVD6rlW8q5NyH55qEm+9srmfQIv9rsUOaa3t0GyL
 oelYAjQn/l/FYKnaYpSAf8kEcy32Za4TnqcDr2NliqmKgRbV79nG5LaraxmqxtpNfGz35lq5mrl
 meCkGcAmf3yCbFgMB6QWUbuwLVwZaF8Jjc29DVnz551nn9d2NGXYfDsC3iZYABUEDGi+XEFwM1r
 l8ceuRdeWF/QcrLqWGaJ9WVL899VZufNqgP0F1PuF0wsd13W6Lg==
X-Google-Smtp-Source: AGHT+IHoK98wOuuSNCne7tjZAd1n4EFCzVhedIQdTB6gWDw//cqswXhnj9UTvokdtqZAajL2kXvZ+w==
X-Received: by 2002:a05:6000:2410:b0:405:ed47:b22b with SMTP id
 ffacd0b85a97d-40e42502e37mr7975350f8f.10.1758895733420; 
 Fri, 26 Sep 2025 07:08:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/44] target/arm/hvf: Reorder DEF_SYSREG arguments
Date: Fri, 26 Sep 2025 15:08:06 +0100
Message-ID: <20250926140844.1493020-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The order of the parameters in the Arm ARM is

  op0, op1, crn, crm, op2

Reorder the arguments of DEF_SYSREG to match.
Mechanical change to sysreg.c.inc using

  sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\1,\4,\5,\2,\3/'

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        |   2 +-
 target/arm/hvf/sysreg.c.inc | 224 ++++++++++++++++++------------------
 2 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9f8e3083b4f..f68924ba1f3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,7 +403,7 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
-#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
     { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
 
 static struct hvf_sreg_match hvf_sreg_match[] = {
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 222698f1d19..f2276d534e6 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -1,146 +1,146 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 2, 0, 0, 0, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 2, 0, 0, 0, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 2, 0, 0, 0, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 2, 0, 0, 0, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 2, 0, 0, 1, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 2, 0, 0, 1, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 2, 0, 0, 1, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 2, 0, 0, 1, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 2, 0, 0, 2, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 2, 0, 0, 2, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 2, 0, 0, 2, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 2, 0, 0, 2, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 2, 0, 0, 3, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 2, 0, 0, 3, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 2, 0, 0, 3, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 2, 0, 0, 3, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 2, 0, 0, 4, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 2, 0, 0, 4, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 2, 0, 0, 4, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 2, 0, 0, 4, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 2, 0, 0, 5, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 2, 0, 0, 5, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 2, 0, 0, 5, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 2, 0, 0, 5, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 2, 0, 0, 6, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 2, 0, 0, 6, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 2, 0, 0, 6, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 2, 0, 0, 6, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 2, 0, 0, 7, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 2, 0, 0, 7, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 2, 0, 0, 7, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 2, 0, 0, 7, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 2, 0, 0, 8, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 2, 0, 0, 8, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 2, 0, 0, 8, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 2, 0, 0, 8, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 2, 0, 0, 9, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 2, 0, 0, 9, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 2, 0, 0, 9, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 2, 0, 0, 9, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 2, 0, 0, 10, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 2, 0, 0, 10, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 2, 0, 0, 10, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 2, 0, 0, 10, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 2, 0, 0, 11, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 2, 0, 0, 11, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 2, 0, 0, 11, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 2, 0, 0, 11, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 2, 0, 0, 12, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 2, 0, 0, 12, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 2, 0, 0, 12, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 2, 0, 0, 12, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 2, 0, 0, 13, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 2, 0, 0, 13, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 2, 0, 0, 13, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 2, 0, 0, 13, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 2, 0, 0, 14, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 2, 0, 0, 14, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 2, 0, 0, 14, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 2, 0, 0, 14, 7)
 
-DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
-DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
-DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
-DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
+DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 2, 0, 0, 15, 4)
+DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 2, 0, 0, 15, 5)
+DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 2, 0, 0, 15, 6)
+DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 2, 0, 0, 15, 7)
 
 #ifdef SYNC_NO_RAW_REGS
 /*
  * The registers below are manually synced on init because they are
  * marked as NO_RAW. We still list them to make number space sync easier.
  */
-DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
-DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 2, 0, 0, 2, 0)
+DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 3, 0, 0, 0, 0)
+DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 3, 0, 0, 0, 5)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 #endif
 
-DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 
 #ifdef SYNC_NO_MMFR0
 /* We keep the hardware MMFR0 around. HW limits are there anyway */
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 #endif
 
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
 
-DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
-DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
+DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 2, 0, 0, 2, 2)
+DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 3, 0, 1, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 3, 0, 1, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 3, 0, 2, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 3, 0, 2, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TCR_EL1, 3, 0, 2, 0, 2)
 
-DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
-DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
-DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
-DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
+DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 3, 0, 2, 1, 0)
+DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 3, 0, 2, 1, 1)
+DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 3, 0, 2, 1, 2)
+DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 3, 0, 2, 1, 3)
+DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 3, 0, 2, 2, 0)
+DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 3, 0, 2, 2, 1)
+DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 3, 0, 2, 2, 2)
+DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 3, 0, 2, 2, 3)
+DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 3, 0, 2, 3, 0)
+DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 3, 0, 2, 3, 1)
 
-DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
-DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
-DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
-DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
-DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
-DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
-DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
-DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
-DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
+DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 3, 0, 4, 0, 0)
+DEF_SYSREG(HV_SYS_REG_ELR_EL1, 3, 0, 4, 0, 1)
+DEF_SYSREG(HV_SYS_REG_SP_EL0, 3, 0, 4, 1, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 3, 0, 5, 1, 0)
+DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 3, 0, 5, 1, 1)
+DEF_SYSREG(HV_SYS_REG_ESR_EL1, 3, 0, 5, 2, 0)
+DEF_SYSREG(HV_SYS_REG_FAR_EL1, 3, 0, 6, 0, 0)
+DEF_SYSREG(HV_SYS_REG_PAR_EL1, 3, 0, 7, 4, 0)
+DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 3, 0, 10, 2, 0)
+DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 3, 0, 10, 3, 0)
+DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 3, 0, 12, 0, 0)
+DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 3, 0, 13, 0, 1)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 3, 0, 13, 0, 4)
+DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 3, 0, 14, 1, 0)
+DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 3, 2, 0, 0, 0)
+DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 3, 3, 13, 0, 2)
+DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
+DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
+DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
+DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
-- 
2.43.0



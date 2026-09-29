Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A710DCA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUez-00075f-Vp; Tue, 29 Sep 2026 06:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUex-00074v-Fy
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:03 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUev-0008Bu-AJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:02 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaf688ebb0so4636401a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676120; x=1791280920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=poshx478E6vGrDMuogQqEUiHV93XSi9ZIq1S7fYheUE=;
 b=bj3+W4ojDs9ArqwnscpFhhNpc3zCp61rz+Ynd6NrJuU59Uqc6Dn1zv++inUob2Z+yK
 QENlcpKnQ+JqQHGq3tHbJLEuO45uw2trCQMyizUH9DHf6n5Ne2MPE/WVTxUWDLVNrnYS
 RNj8O/93kQtkV938E19MYTNoni6W9nLG9XRqomPMe3PjvPjiIrWK6UMaZtkYcYSESg2f
 RB8bXeazL4gNE9yFNMCP7qRE5itCwxbOsPin7XogSzeVZ6za3MCypry0nEoQjm/yO6cN
 1z2a5YYymEvczmeEuz/fLbBOx4PjaZLpuRyVp9lJs9qKh0WTt3ksTK7H/SMDTWMC9QcE
 EP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676120; x=1791280920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=poshx478E6vGrDMuogQqEUiHV93XSi9ZIq1S7fYheUE=;
 b=mbAUN89ZdXwbv0oxBuFf5A/sBrMSnVQwNk18rGW2OCyQxB4xjw2F+sUy0wCxX9diZH
 Jdk+bJA5CLO0TWzzoJ/RFYA6FIJhkD1DgWEGGdw/0ZFBXOeCW8vjZ94dwyMIRstIDRmM
 HTAN3VBArQuxTqdN9UBQWu4CCmxdb+SkpMnpEC3WQB2E6lGRFD1dcFX3qiIGYgWZMqvB
 LEPAV6ze3xI0nFMvFlORnWlQ6bgKxjG0EzoKoQyO6a+AWpoTbVLtsyApRAnSEWdgQZuC
 OHWZkbKDx96MHkQHBr2RcHfCTJOwYX4Pbgp9Wem6brG3EufUolU6bn0vG0BK3yATOBDi
 HBXw==
X-Gm-Message-State: AFq9FYKZSBI7XtLUA8MsrLQvNq8bYRt76g+xkEOcIFpEb+P/9MZjhT3D
 7McQuj1nQ0u+iTg1c5CkzSplbUkIvhERmkXP+hLyLgk3jhcPaNne28RNOMVklDYCl02zhoDY7Ag
 HXpND
X-Gm-Gg: AYBFou0TjyZNCfHSIPcfwk+X4nULkdZHhovaLmAvWxJBsOUpqWfqL26JzofivsdsZud
 FMn1X4ZnHe8WmUfphgQp12UvdMCSLdNDRjlZpvlulEp8TDEsk0ZZ9SQNCV3hTAvwUdnf2N1zeRt
 aBokO9qpjT6BdRNVEBLxBAKLKph1u5qg9m0Bax6ycXbdvDxdRWLnRPAviatL6nJ0ll8i0zn/xxl
 2vZFMbLa1KKsAcWsOdF5Xr4PdsbTOYTJjQJIehSOSsHjupYzJzs7rBlyLnHf5lm55K1pA4Ap33x
 NzsVbcGKpYI86gRpazWWL0znFWmHjOCdPHtE4d/ayQjH5q+gsbEqS5XXHbvv/AXT5re4iD/Mz3a
 6Vh/zev6mNA+eddPMyg6nvFhhJGPh4ePKYhfF7mM69JmbSVHDR3yrO2T3UxZW6T/Cf4/rP4wuva
 /UGvGrlyeji+ApmcCjfE0jYCy6w8qrAOyP8mY4qBQL60cBExaTWVKemhdk+LLt1w5tjI71gVPvT
 iKo/KXTTbWeVfnLTQydfiqeHSNJcMyGkq6oTrhAEz9KV5tCSikc0Zx0Tf6s92K0fupkYYG6gpYF
 MhQWbZyQ8w+Zhw==
X-Received: by 2002:a17:907:d9f:b0:c2d:cf0e:49e9 with SMTP id
 a640c23a62f3a-c2dcf0e6d27mr544268166b.15.1790676119297; 
 Tue, 29 Sep 2026 03:01:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/37] target/arm: Don't use arm_cp_reset_ignore when
 fieldoffset is 0
Date: Tue, 29 Sep 2026 11:01:11 +0100
Message-ID: <20260929100133.2598676-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In cp_reg_reset(), we treat an ARMCPRegInfo::fieldoffset value of 0
as "reset is handled elsewhere".  So we don't need to explicitly set
ri->resetfn to arm_cp_reset_ignore() when we haven't defined a
fieldoffset in the cpreg struct.

Remove the setting of resetfn to arm_cp_reset_ignore in the handful
of places where we were doing this unnecessarily.  These are all
timer registers, and doing this brings them in to line with the other
timer registers (e.g.  CNTPCT_EL0 has no resetfn, and now CNTPCT
doesn't either).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260907130223.3148989-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2bba059b521..c2e94153634 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2209,7 +2209,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTPCT", .cp = 15, .crm = 14, .opc1 = 0,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_pct_access,
-      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_cnt_read,
     },
     { .name = "CNTPCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 1,
@@ -2219,7 +2219,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTVCT", .cp = 15, .crm = 14, .opc1 = 1,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_vct_access,
-      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_virt_cnt_read,
     },
     { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
@@ -2310,7 +2310,7 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     { .name = "CNTVCTSS", .cp = 15, .crm = 14, .opc1 = 9,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_vct_access,
-      .readfn = gt_virt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_virt_cnt_read,
     },
     { .name = "CNTVCTSS_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 6,
@@ -2320,7 +2320,7 @@ static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] = {
     { .name = "CNTPCTSS", .cp = 15, .crm = 14, .opc1 = 8,
       .access = PL0_R, .type = ARM_CP_64BIT | ARM_CP_NO_RAW | ARM_CP_IO,
       .accessfn = gt_pct_access,
-      .readfn = gt_cnt_read, .resetfn = arm_cp_reset_ignore,
+      .readfn = gt_cnt_read,
     },
     { .name = "CNTPCTSS_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 5,
-- 
2.43.0



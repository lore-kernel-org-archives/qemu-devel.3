Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA95FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2990-00087O-FG; Fri, 26 Sep 2025 10:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298W-0007NU-KV
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298E-0005fh-D7
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46cf7bbfda8so12136035e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895740; x=1759500540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q3RNZ4P3Tq3zjqcHANGsM138DWjS8vi9+XNzo2XY8fw=;
 b=n7zU10VQNlHtoILDgw07275e0A52IdeTHOGWa6qSn4lxvscvYLIz1ZX7K1Offt1KBY
 yWZgoxRYq3LLm3jHlm7VI4zU5ehQ4/yTmQfKeh+LrmnOcNZ6Hqo/sBekfZfXfbOoHoTm
 sB/LzB8oRbkDxNYPm18PGTsyI3EyuS418DDhmzkJLR/olL6YBoCae2QrlNsGEa5i8Yds
 AKKA/fL8xPIdjM6MRCvfOr9dpokrEvdZ7VCmCgUxcoI62gB+IA1NVU/AjDRIbOKsOYCk
 pMN3/p1GWeZZ+Wcskh0/vBfefbJhM6snFTLlflMjpG35RBk/gldIrTJ6ZGb4bTQQ20Ws
 UZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895740; x=1759500540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3RNZ4P3Tq3zjqcHANGsM138DWjS8vi9+XNzo2XY8fw=;
 b=hI7YxXc4cPk4OMl4SVybqtfFsxBhBW1rTL+rfHeNSUg+OaM/XvW5JrMVhB4QbsnMYI
 3QBmDFzsyvvkEwLEt2h6OcL7EezVcqGjpWVvTUK6YmONc9NSmjALHUbpBr7L7B3ln60O
 AhhsX2xRKGYO/9LZXcdgmzvQnYp+xts16Vy5VUe3eILOa3RIuqSjlMG4zsBqXDqioDXN
 cFeczCAQ3CmTGKjADlm+uE1mPG6Q/W3whdThJuLGWP115UmE2s0uKkw3wwTGRDsPrGKR
 MEAjdFxaaievYyhEV0o61UjT4+nXnY6Kj+xB8spOykwv7Uc1/XtRTE5lUtg73ODBCklS
 viSQ==
X-Gm-Message-State: AOJu0YxiT4ON+lQwgcHRFgJBMrAQzhtWNSm3QW1p1PGQ9Xlgh2BvNCW/
 vuXeqzwuIvdG+ix5/AFoeI2ve8sZfHuSB6y2tkzWhwKBkLzDqncXlFdh3H+/2+8kTo2kV/kkb6K
 Oc/8o
X-Gm-Gg: ASbGncuoptICyEEfKJ/W5SGfzM8kIM4Yg64XHQS39ygMXmeZLhPMi8NyDuGNFhDEnkf
 0UWyQvL4HRP5igSXsousriP7ueHsJhZReTCL41GM2NeZ9dE+vYjzkmOTPrxlsKo0hdj93pTn+1H
 lmgRn9fDGlZSFvcnNl/ruLRa1ShI8UP3NTM/pZVuCISdewL7CRfLkIGkrV4SOKFtvyjvn3ijrzw
 M3qP/Iy+ftsZp/VzSZYxcwz4v4mZVmwLRvgQ9TyCmoR9Tk8g0hq+C0ijjhVGnIfgHF5Imzg8hWh
 TUXey6zsSlrG/KOzNS4eNFbE6IW7ui4FCXu/sp6vZ96b5JDHAYmPxJCavi+kON1RMAjvoIof+Hm
 9HwPYSzm5yuaVsL+OJ2OdhLErk3zB0RPFzOUB3GU=
X-Google-Smtp-Source: AGHT+IFRcgRb8fY8Vo9zR2iQtE7cg1FfM5Ytvevipl4wSITKKtlU/yZh03r+Lj25NQim8D4JrLxFuw==
X-Received: by 2002:a05:600c:4816:b0:46e:3287:57d6 with SMTP id
 5b1f17b1804b1-46e32a0bd2amr44971485e9.27.1758895740090; 
 Fri, 26 Sep 2025 07:09:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/44] target/arm: Rename all ARMCPRegInfo from opaque to ri
Date: Fri, 26 Sep 2025 15:08:13 +0100
Message-ID: <20250926140844.1493020-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These pointers are no opaque, they have a specific type.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 10 +++++-----
 target/arm/helper.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2a4826f5c4f..8f3e728d8ed 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -866,15 +866,15 @@ typedef struct ARMCPRegInfo ARMCPRegInfo;
  * Access functions for coprocessor registers. These cannot fail and
  * may not raise exceptions.
  */
-typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
-typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *opaque,
+typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *ri);
+typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value);
 /* Access permission check functions for coprocessor registers. */
 typedef CPAccessResult CPAccessFn(CPUARMState *env,
-                                  const ARMCPRegInfo *opaque,
+                                  const ARMCPRegInfo *ri,
                                   bool isread);
 /* Hook function for register reset */
-typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *opaque);
+typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *ri);
 
 #define CP_ANY 0xff
 
@@ -1100,7 +1100,7 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
  * CPResetFn that does nothing, for use if no reset is required even
  * if fieldoffset is non zero.
  */
-void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque);
+void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
  * Return true if this reginfo struct's field in the cpu state struct
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 009f8d6fa1c..7b23e7e5889 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1073,7 +1073,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
       .resetvalue = 0 },
 };
 
-static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
 
@@ -5382,7 +5382,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
       .access = PL0_R, .readfn = rndr_readfn },
 };
 
-static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
+static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
 #ifdef CONFIG_TCG
@@ -7829,7 +7829,7 @@ uint64_t arm_cp_read_zero(CPUARMState *env, const ARMCPRegInfo *ri)
     return 0;
 }
 
-void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque)
+void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Helper coprocessor reset function for do-nothing-on-reset registers */
 }
-- 
2.43.0



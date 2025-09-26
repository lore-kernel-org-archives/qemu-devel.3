Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26039CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299M-0008S6-KX; Fri, 26 Sep 2025 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2991-0008CJ-14
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0005hY-WB
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1620811f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895749; x=1759500549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dLbVo5gphpDJsQEOgdA7afnCMZlPZYSWdI1A0qKmpW8=;
 b=zUZSgCRkd2I8Se2plEd+AFeIXweaazW6MVpgKrnht9+VF2yeJYOEvTzGmv2eOQT7Sm
 dHjSv+co9MBobNFERRyfaLCLeCv4qfRA9k/ckTpC8HwCp2YCFmevUA1p7HOi9KdxEpF0
 wffz0OJGby+NpJrJ9TNUl/aUkSWGu/IZv9U1GAqTv/5Vzys85dfyrHVK3hsdNN4OVwkt
 UdJWWmkohsDzAVY9XOqztZPW2xHxZox8fryRNIJqpI9gnRBRQMd+dJHiHPukZiR4X5Vd
 DRbpvrtenTMWf8PJwMwTDtDmk+MNk8qCy6s8jwcQNOdWYd3Fb7T0BoRZX3MP7QTUqCfa
 ghbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895749; x=1759500549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLbVo5gphpDJsQEOgdA7afnCMZlPZYSWdI1A0qKmpW8=;
 b=CmcV+g4FbWrDOXUy95yqb4qnscj1DjFEM/sdLF2Ahsg8UV5Z9aUHDV7OJk2/DQ+Q7C
 OozO7NRoqE8itmLuY1jblJq/HCaCMkO019PmjOaVgLNgosesV/rw+kUdB9pJ8aM2lIeE
 vWNNB8P2JDNPyBEtvofCljO7WzTfp4E/f5xpsAfry9JnHAR99ubs0dLdYjmKLNUFgkqP
 /1fk+829DP+jvQGnRsT6BQ9vGhuByPfCD0ezOJYj8VW5Kv1fACPmZ/EppbywQCH+rP2D
 2B5RLnIi5lb0V9gFfjuO49CodVdBGMH/aL6YNpt+gnSxVWMUZLUgqCX+YGyN0616g7PG
 6wEA==
X-Gm-Message-State: AOJu0YxZ3TkcqlnPQxb4Ropx1PD0dx7cf65dfMrwvjIq1GDmvTufrTqD
 PFJmdD8L4FygpDjKGbjHAmZ/igKq1XkzX9y0dVT2WGUJUbuBV4ixr2fEq0tcFXAVZW64g36KCME
 iujcu
X-Gm-Gg: ASbGnctf6ma4ocDVIQkIX9esGclVbeQq+o9gWEBseeA21RuwOwudKuosHVB4x+rIgMo
 qCyXkKMz+TBy9uZjVCPHwG3D93zFIKO5UbxJvNAwXB08ZtW3dIER/8w53D4LGfrRqCz382+i8/o
 oAFH8RBOKnJq1VnuNaUd3tZawClDq7KEB+sW6jhy3xqirPwXMVmM+HUYqgFyBKkn1KbDNz2qwKE
 htnhxYMAsBdYTtxxIGTqB6FuGsIrNpb/Ui8koIvgOnVJUuK0YvTrxbzgyZz1ivU2tWrUSEbCw5U
 miY7hpJ67xUz7jPnJi+iMSrZdPn/h4tyDCwFr3lf5jqa5MsarYmnz+2YNb6KPjOCSMXL8xsJ9DG
 r+rzoF1qfj6g8FaleD7CH7582Ux6RxFL/IQWBMiA=
X-Google-Smtp-Source: AGHT+IEaCXvPMqoN2fi74bXL1TG1vU6FlvfQHTEqy22LnlMYSf8oBxJe50EJZkOduAdMKPHlKZxaRw==
X-Received: by 2002:a05:6000:2410:b0:405:ed47:b22b with SMTP id
 ffacd0b85a97d-40e42502e37mr7976253f8f.10.1758895748649; 
 Fri, 26 Sep 2025 07:09:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/44] target/arm: Reorder ENCODE_AA64_CP_REG arguments
Date: Fri, 26 Sep 2025 15:08:21 +0100
Message-ID: <20250926140844.1493020-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The order of the parameters in the Arm ARM is

  op0, op1, crn, crm, op2

Reorder the arguments of ENCODE_AA64_CP_REG to match.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            | 2 +-
 target/arm/helper.c            | 4 ++--
 target/arm/hvf/hvf.c           | 6 +++---
 target/arm/tcg/translate-a64.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index a10abadb932..08fc42ea571 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -187,7 +187,7 @@ enum {
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
-#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
+#define ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2) \
     (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2732112ff21..965941f04e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4503,7 +4503,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     };
 
 #define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
+    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
@@ -7398,7 +7398,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
          */
         assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
         cp = 0;
-        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
+        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6e67d89163f..8b467b36638 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1124,10 +1124,10 @@ static bool is_id_sysreg(uint32_t reg)
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
-    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
-                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
-                              (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
+                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a560ef0f42c..0ec309f1ea9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2466,7 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
+    uint32_t key = ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
@@ -2602,7 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
+        key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
         ri = get_arm_cp_reginfo(s->cp_regs, key);
         assert(ri);
         assert(cp_access_ok(s->current_el, ri, isread));
-- 
2.43.0



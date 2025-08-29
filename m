Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20037CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7R-00087V-38; Sat, 30 Aug 2025 11:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtkT-0000uN-CL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:42:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtkQ-0004rB-V8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:42:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so10591215e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756453328; x=1757058128; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l+2TI0bjgXnqdVs75iWIYrWQx8vb/t3W54+0JniDy7g=;
 b=ZxvXrwejGBL8t1Rqo7BvGYGXbAEuTSJmXAU/bSo8wSTkZ6eO/xZtDIMOffZBDTCOrw
 K/NI8xK+RnsDq0KZKGXcg1GMjNfIi2oxCeQYAKeQdmRvcfQKhXesNuBP5uiuzUx95EHn
 o5H6cSaVPf8bmX2UcoJ44QTWEMJF8l1k8L/ko8ETTDZtpnxuW1nfAMR6JpsxitQzjlpz
 0yWHe41zI9WeFS49cf12yNC5k0KhMUkff0s+YNDJPDhtrrtqjbcFnBUCtV4vNrCVYTCb
 VxtYWigvDMUdelFBtbMQUtze4N8Mbvs2yp1btxHU1w8GpcLjwqDBbVl3SzxwYC2bi+mT
 hYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756453328; x=1757058128;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+2TI0bjgXnqdVs75iWIYrWQx8vb/t3W54+0JniDy7g=;
 b=YNbIyIf6mHytvrq1FKsurlfbsWlhMODXvqYmSbg1mG0YKG+ZOfOtVKtu4WKbi6wb+a
 PBfpIHO/0hjYAgvQiyhu3sGr+D3IJwjhFd9JGWcwlX1WO4U7zM2Fi+v08TQL2gtq/wb9
 dlBJ2ZEBiJieWPDyaHU5bI0msWbdUFY8s4dzshH6XO5YNxmPvMnGhFihVPLT8c4pby/Y
 //FNXYigshiRrt3cufAYKP3OK9j1l1Bb1aMC5Wcn7dMDWRj5Xhkhs464iOencaJWZT3R
 dm1q+LLDxqoUehPW2NXnIkoU7rnJ74bQdJlNPMExZIpDPLonrdswpXT9MGPLoS5gnpMT
 x55g==
X-Gm-Message-State: AOJu0Yx80k8P4pq3mQ9b3mjji9b2pj2/K46tAAFbddDB5m3sPIppq54e
 W5uuVKMMgMVwsElbCn/cE5C5LbI/ic54nkR7RjSHSDtC/hMEbr5CSPGcX7Zj10rYGCdb3+3DdDs
 bGMyxY1M=
X-Gm-Gg: ASbGncvAMqDTQIVpkKeZJXryjvakPkjUF/2b4A94cwh0hPl8veXEQPcCB61RZBm9tHi
 yKYEoc0FQ8MpdQrjyOQg2wjV3w8JpwOcxskE+HIlDnx9TPf6sFNWGMOUAqm64tbo2RzN+WfC0gf
 AKoZsZuePR8mHiNdUVCVIgYPhrEcQbkjRlSyoQ+8/NUhorLQdxailzilstc9rQPkg1PKGjJJIw8
 U5IsN50VWd9HZT6Uh87vefjTsB6eeOF6Sqa/YAl69RApAb2izI2h6IliDE7BaxJHMsmUF30ijI4
 76pl5hJNIE//fqVF2IxEGisHqPwKsglfvmLwsfAmtk9uCXvreGcfgo8tZePDX1lYFlL68/VsZDE
 gPsaIIgPBKun66+mlBP+ceNzNWZuVYJOB/jbxmG+MHCR7pAwVmYxn6gvy2jIPaBUCQxknIkeA
X-Google-Smtp-Source: AGHT+IF0AeISCiQvF6TlOHNlsUfD79Zz8LRsc7v7mDkuTtqjNZrivHDW1LH6vLiEoDa/pVftPu/k3w==
X-Received: by 2002:a05:600c:3592:b0:45b:7e68:c6a3 with SMTP id
 5b1f17b1804b1-45b7ec0ae32mr22281555e9.16.1756453328159; 
 Fri, 29 Aug 2025 00:42:08 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d3073sm117318105e9.7.2025.08.29.00.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:42:07 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:40:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 19/61] target/arm: Reorder ENCODE_AA64_CP_REG arguments
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-24-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-24-richard.henderson@linaro.org>
Message-ID: <t1qw27.1nxwnzs1wma9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>The order of the parameters in the Arm ARM is
>
>  op0, op1, crn, crm, op2
>
>Reorder the arguments of ENCODE_AA64_CP_REG to match.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h            | 2 +-
> target/arm/helper.c            | 4 ++--
> target/arm/hvf/hvf.c           | 6 +++---
> target/arm/tcg/translate-a64.c | 4 ++--
> 4 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 95b0b9c78e..7bdf6cf847 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -187,7 +187,7 @@ enum {
>      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
>      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
> 
>-#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
>+#define ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2) \
>     (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
>      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
>      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index 93cae888e2..b48b669a6a 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -4527,7 +4527,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
>     };
> 
> #define K(op0, op1, crn, crm, op2) \
>-    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
>+    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
> 
>     static const struct E2HAlias aliases[] = {
>         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
>@@ -7299,7 +7299,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>          */
>         assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
>         cp = 0;
>-        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
>+        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
>         break;
>     default:
>         g_assert_not_reached();
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index af03fc7fc1..bda57614ed 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -1124,10 +1124,10 @@ static bool is_id_sysreg(uint32_t reg)
> 
> static uint32_t hvf_reg2cp_reg(uint32_t reg)
> {
>-    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
>-                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
>-                              (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
>+    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
>                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
>+                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
>+                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
>                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
> }
> 
>diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>index 743c5a10e1..58303c224f 100644
>--- a/target/arm/tcg/translate-a64.c
>+++ b/target/arm/tcg/translate-a64.c
>@@ -2466,7 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
>                        unsigned int op0, unsigned int op1, unsigned int op2,
>                        unsigned int crn, unsigned int crm, unsigned int rt)
> {
>-    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
>+    uint32_t key = ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2);
>     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
>     bool need_exit_tb = false;
>     bool nv_trap_to_el2 = false;
>@@ -2602,7 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
>          * We don't use the EL1 register's access function, and
>          * fine-grained-traps on EL1 also do not apply here.
>          */
>-        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
>+        key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
>         ri = get_arm_cp_reginfo(s->cp_regs, key);
>         assert(ri);
>         assert(cp_access_ok(s->current_el, ri, isread));
>-- 
>2.43.0
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C39CCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyQG-0001Q5-Bk; Mon, 01 Sep 2025 02:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyQF-0001P3-5Q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:53:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyQC-0004F5-ME
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:53:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso26301485e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709621; x=1757314421; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P3LW9zCXIIG50rJWUXTkvlT1ZBqlgJQW3vF+bn7hIR8=;
 b=NCd196fjFR0a/NDK0iJ63h/VL0V3q3Bl1jshNpv1td3Wh/S/fjsGqW0kP3q/Xnz5Ab
 zD9rzXc9HaRGSOPHFdF3pv4f7fVeLcsc33Lhzd4lC07n2wGoCpqF0RNw/iOtOmTwdv9Q
 A0TUJKlLRCM+1UCGPzX/AccW1eLZ2rC6qdLSv2040xP4R09fU6IBpzb5SfF2nTRo23+x
 XBrv2hn6rTJJlIl+5fb0YSCEh6RFM0t5Li0CRuBFX+7vG3ZpU1PhAv6YAtfWonM14yOb
 cgVl5HCX1wnNAniA++5vDzwgsMhbsnwlYhnWo21vcZrhgSrljZK1F8G7dXlF/hkDyena
 yBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709621; x=1757314421;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3LW9zCXIIG50rJWUXTkvlT1ZBqlgJQW3vF+bn7hIR8=;
 b=oGJk1+g5OQYaqRT0S7Re5qF40Xsy8ZyqQ1zQ9SxSp2r2PQn4kM7CIX263Il29iStva
 nlsMVl0ksCirFhjLdCQbz6TB3t3KRb9biM4Auie2/C+rIU6YfCrHgMp6XywYGhY2dEwe
 bXb/mdm/M3OozMLtZL796VWCIKk7N6Uq3AfjWLdkWO0DkHHkDsZCPFT71duKyAUYFHmc
 RM9OIqt9pl5mQNVPnwj1oZ3uYMVqeft7uFZ+oqmfop8hE3pRAXWzPqmeMxhQBADlCLmn
 PNs3U4oVo76kuDamZ+dqgU7TQFKGpEdlvtcjh+pN6RyOMUtWWv+BpvB9bpmwm6YUPqHg
 dORA==
X-Gm-Message-State: AOJu0Yy7E1WX3dhAcdn790C1BW2NSVi83lfk49v3ElXE0G24SF9rw3m4
 4RHvophY9dmYyhbaNvL5g1KUP96REcsN/c8QstfTuJ9WdSmVRwL5KtQ/LyzsCduLhwAEe4LfmaC
 i4MGG
X-Gm-Gg: ASbGncuZDpwG0pkW9RUyuwzXA83LbfL6T6GM3s5BI4L57g23VHDNmOL5fashrX1LQFl
 gqSdmvTkBIm4TPTz9JypTkP015kPyb+hrmtfc1/k5R7ngvethDgx7lh6moMBVNeYxXOacfWEsJ4
 grfWPz8wfXZkHpLhdlrE9OxkZauXTar7xHX/lxRR8EWJ3dksQqlTRxsRyxdz4jwVcPtLMHFWVXf
 a2H8thQ7TLwhIrrpOUE9kGdHVzW41tCB4Y0qYe5obe+Ill5A5BhUaD+AZh4//ozONX0jx9AYlqn
 MpR4GSvwQB8WY1xlwyUN6TNfMMniQI8gKgZf308aTOV1EssiR8iYHJOW0i6/+cYd54EhSCsntLK
 9skkdKMeXimuIt0jnlPv0Fd+xCHr+poc6SNOI8hSzDbNU7iLML8P4SixsfyTJK8y/TnYqwiWQku
 E/DX0JyW8=
X-Google-Smtp-Source: AGHT+IHjMkojGQdgCfJtFGG6fnS+XXINxuJJfMcDtY1JTEsznzva4BjRE5sPkoXbYRq5+hUuFfRy1Q==
X-Received: by 2002:a05:600c:3587:b0:45b:804a:a65e with SMTP id
 5b1f17b1804b1-45b8559a928mr48675645e9.28.1756709620677; 
 Sun, 31 Aug 2025 23:53:40 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8525a94bsm93405385e9.15.2025.08.31.23.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 23:53:40 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:53:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 35/61] target/arm: Rename some cpreg to their aarch64 names
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-40-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-40-richard.henderson@linaro.org>
Message-ID: <t1wdtf.29jax9ip73h4x@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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
>Rename those registers which will have FOO_EL12 aliases.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/helper.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>
>diff --git a/target/arm/helper.c b/target/arm/helper.c
>index a19406e136..255ca6fdcb 100644
>--- a/target/arm/helper.c
>+++ b/target/arm/helper.c
>@@ -671,7 +671,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
>      */
>     { .name = "WFAR", .cp = 15, .crn = 6, .crm = 0, .opc1 = 0, .opc2 = 1,
>       .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0, },
>-    { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
>+    { .name = "CPACR_EL1", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
>       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
>       .fgt = FGT_CPACR_EL1,
>       .nv2_redirect_offset = 0x100 | NV2_REDIR_NV1,
>@@ -2012,7 +2012,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>       .resetfn = arm_gt_cntfrq_reset,
>     },
>     /* overall control: mostly access permissions */
>-    { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
>+    { .name = "CNTKCTL_EL1", .state = ARM_CP_STATE_BOTH,
>       .opc0 = 3, .opc1 = 0, .crn = 14, .crm = 1, .opc2 = 0,
>       .access = PL1_RW,
>       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntkctl),
>@@ -3071,8 +3071,8 @@ static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> }
> 
> static const ARMCPRegInfo lpae_cp_reginfo[] = {
>-    /* NOP AMAIR0/1 */
>-    { .name = "AMAIR0", .state = ARM_CP_STATE_BOTH,
>+    /* AMAIR0 is mapped to AMAIR_EL1[31:0] */
>+    { .name = "AMAIR_EL1", .state = ARM_CP_STATE_BOTH,
>       .opc0 = 3, .crn = 10, .crm = 3, .opc1 = 0, .opc2 = 0,
>       .access = PL1_RW, .accessfn = access_tvm_trvm,
>       .fgt = FGT_AMAIR_EL1,
>@@ -4454,9 +4454,9 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
> 
>     static const struct E2HAlias aliases[] = {
>         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
>-          "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
>+          "SCTLR_EL1", "SCTLR_EL2", "SCTLR_EL12" },
>         { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
>-          "CPACR", "CPTR_EL2", "CPACR_EL12" },
>+          "CPACR_EL1", "CPTR_EL2", "CPACR_EL12" },
>         { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
>           "TTBR0_EL1", "TTBR0_EL2", "TTBR0_EL12" },
>         { K(3, 0,  2, 0, 1), K(3, 4,  2, 0, 1), K(3, 5, 2, 0, 1),
>@@ -4478,13 +4478,13 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
>         { K(3, 0, 10, 2, 0), K(3, 4, 10, 2, 0), K(3, 5, 10, 2, 0),
>           "MAIR_EL1", "MAIR_EL2", "MAIR_EL12" },
>         { K(3, 0, 10, 3, 0), K(3, 4, 10, 3, 0), K(3, 5, 10, 3, 0),
>-          "AMAIR0", "AMAIR_EL2", "AMAIR_EL12" },
>+          "AMAIR_EL1", "AMAIR_EL2", "AMAIR_EL12" },
>         { K(3, 0, 12, 0, 0), K(3, 4, 12, 0, 0), K(3, 5, 12, 0, 0),
>-          "VBAR", "VBAR_EL2", "VBAR_EL12" },
>+          "VBAR_EL1", "VBAR_EL2", "VBAR_EL12" },
>         { K(3, 0, 13, 0, 1), K(3, 4, 13, 0, 1), K(3, 5, 13, 0, 1),
>           "CONTEXTIDR_EL1", "CONTEXTIDR_EL2", "CONTEXTIDR_EL12" },
>         { K(3, 0, 14, 1, 0), K(3, 4, 14, 1, 0), K(3, 5, 14, 1, 0),
>-          "CNTKCTL", "CNTHCTL_EL2", "CNTKCTL_EL12" },
>+          "CNTKCTL_EL1", "CNTHCTL_EL2", "CNTKCTL_EL12" },
> 
>         /*
>          * Note that redirection of ZCR is mentioned in the description
>@@ -6999,7 +6999,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> 
>     if (arm_feature(env, ARM_FEATURE_VBAR)) {
>         static const ARMCPRegInfo vbar_cp_reginfo[] = {
>-            { .name = "VBAR", .state = ARM_CP_STATE_BOTH,
>+            { .name = "VBAR_EL1", .state = ARM_CP_STATE_BOTH,
>               .opc0 = 3, .crn = 12, .crm = 0, .opc1 = 0, .opc2 = 0,
>               .access = PL1_RW, .writefn = vbar_write,
>               .accessfn = access_nv1,
>@@ -7015,7 +7015,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>     /* Generic registers whose values depend on the implementation */
>     {
>         ARMCPRegInfo sctlr = {
>-            .name = "SCTLR", .state = ARM_CP_STATE_BOTH,
>+            .name = "SCTLR_EL1", .state = ARM_CP_STATE_BOTH,
>             .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
>             .access = PL1_RW, .accessfn = access_tvm_trvm,
>             .fgt = FGT_SCTLR_EL1,
>-- 
>2.43.0
>
>


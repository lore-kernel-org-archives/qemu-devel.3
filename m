Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA85CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3y-0008A2-SE; Thu, 04 Apr 2024 10:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsO3w-0007qN-7U
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsO3u-0006DF-J5
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e2ac1c16aso10129a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240849; x=1712845649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNmD2zvccXxBiRyDCZ5QsCEdO6xkpxPE/hEP78GGnt8=;
 b=frJcs/3ia6Opx6xc1m7OG8E2g4XHlpWAcjjgCAR968MXvYxrYu0BkOqteFN6JO3nTL
 TxsydO3/W1YXsq1oILPyg2eAVm9rJcQBvfR+QMFWgy1DSRorh17HGfzglPqNx40vhu/l
 mnbA8R4vw2Hj3pAvYMUHG72M4XVpRcxnu8kw6Cb7TKTxddsIhhuRqxtCjPWCz+WBuOCV
 R0/wwRtD0yev5guq/ixPcC+skrw7tzF3hepx2j3DKetdiOYpR0QXYBkuue277ph3kZcd
 yI4rXuy7+ytooqEawxNhVcGtH1FQcdAR+auoc8ncGzp91UxZpEScLXwn8IJ76bpMifOD
 RHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240849; x=1712845649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNmD2zvccXxBiRyDCZ5QsCEdO6xkpxPE/hEP78GGnt8=;
 b=mx6MEZkmt/yHFiSkJDm51R5I3Y77QInu4iH8IZ/n6YfFTDj5akRfm2hDEvi1Q3SlsH
 tmlzThkPBXvPwWGU/pJH/o2aG0YCBPHj3fI0nAnXYuYlTjiBE2Kkt31wVkQ4Rpv0RHhV
 HUt+SC8IB9AlGKSidwV+UNjMCvo8FFtWw1kxbgt6EwIcQS1u0z9+ZhCcfMVeQ3mmbMog
 veqATNp5B57rCrA+9EALJyXG/4pS1fwZEKCESTHcny+J+UK7yWMolv9E7KJiaFwelijL
 pV8nEyLqdFWoHCHbxcTO6017TlSNoquJ+1QB0SEXDyF2heP2OqkSmSb6MkcuAT3VeNo7
 5SHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyAsHhW8GxAqhfsNaggA6W4yYjBE8DdtnaDKxklb+bqapvN0KfPpkTz2wLgmPCnQ9AK1emLsy8N2XA35Q92dY4hjcwhA=
X-Gm-Message-State: AOJu0YwG2poOo9b4gwYrDqODE0RuX7sXASWdZRoORWCDivPe6k+ishYs
 m8Lmx4Nrct1WbpttB388PsGtRIrsXsGLJxB2blpJuk3zoPNDYuynxWJYvACB+4BJypq7XftYdBT
 UGVoGTDCievu1/rLyd8c8O8gTVOIDkzJb+qKFvg==
X-Google-Smtp-Source: AGHT+IGCX1Lsibqn0Y2vT97P2aOdt6DQpAjdv848sZHtY8rDmQn6/C6t1p9FXAYK4bmW6DLp3k4riInvp4yuKfdZgjg=
X-Received: by 2002:a50:d7d4:0:b0:56e:bad:36b with SMTP id
 m20-20020a50d7d4000000b0056e0bad036bmr1157566edj.21.1712240848773; 
 Thu, 04 Apr 2024 07:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-19-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-19-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:27:18 +0100
Message-ID: <CAFEAcA8v8guoP37xO81jGRpydbriSjgow0MBv+OnDGjZ52+Tww@mail.gmail.com>
Subject: Re: [PATCH v12 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
> ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.
>
> If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
> bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
> should be set or clear according to the Non-maskable property. And the RPR
> priority should also update the NMI bit according to the APR priority NMI bit.
>
> By the way, add gicv3_icv_nmiar1_read trace event.
>
> If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
> NMI again
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -301,10 +310,11 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
>       */
>
>      prio = ich_lr_prio(lr);
> +    is_nmi = lr & ICH_LR_EL2_NMI;

If you want to be able to skip the cs->gic->nmi_support check here
then you need to enforce in ich_lr_write() that the guest cannot
write a 1 to the ICH_LR_EL2_NMI bit when the GIC doesn't implement NMIs.

@@ -2833,6 +2833,10 @@ static void ich_lr_write(CPUARMState *env,
const ARMCPRegInfo *ri,
                           8 - cs->vpribits, 0);
     }

+    if (!cs->gic->nmi_support) {
+        value &= ~ICH_LR_EL2_NMI;
+    }
+
     cs->ich_lr_el2[regno] = value;
     gicv3_cpuif_virt_update(cs);
 }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


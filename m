Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B68C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnMM5-0006Hx-6i; Thu, 21 Mar 2024 13:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnMM3-0006HO-Kb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:37:27 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnMLy-0003Tl-Es
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:37:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56bcede226eso1018484a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711042640; x=1711647440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W8lVGErRqbjGqv02pUOMe0Bx7em7CuZVbj4WIMLHLSs=;
 b=fsFg6b0h9ESawjrnuVtgb5eeLuOjgb8d5emmZl8Bh0DR1zLEt4qlpgtycv9R304yBD
 zAp3ydeE6BqpqEzPS6s75XgpWEjdY9+OJC9qL5IYvPTddRZnCYKqPhTDaQ5B5rAneFs9
 W8GBWRQwAqyvahSVEG5haJcoM+JgQHsgNhxnY6qXlFCDh+6Dlo5MvoiOe08+SaE7rib7
 I3gLm78FrbCMbko+aRTVROg9oeMtgmN3Zc0OlXnKuRZ98eOYOOC10UCQ/Si4P5yPm1vK
 Lo6qBpIXWly6/wLNSY5n8ldEDv7kqzg0lhg6IHiZBXNngld5MBmKMnD5o81iJo+8DKsk
 UznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711042640; x=1711647440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8lVGErRqbjGqv02pUOMe0Bx7em7CuZVbj4WIMLHLSs=;
 b=MQD48r1r1W8cEglq963hLPVJrXEwTh34xIoUKV/kqqYuewq3dHGNrLChlR/UGx4mDg
 eDGyTVDE29gKZiuvATodv2sapjy3ApGD27Hacy8Aog1pbNybI09wXhJ+x4hy6K/n+NlA
 KcHfip9N7H86VhTw2yvRAlqHdXI13C9YOQfJLIT3KNetB/td6t4nnhGlzkGqibcNdW7K
 bvF1XU/sFgl5JAxah90jtB3q/mwN0zxazU6fA/npwxeoTlr9fNUsobqy3kuhoZcN4K3F
 +6MMqgnoHpAe3CirkKApnjuZOCN4vii17gmyERL8InFnNSg+TpnqwqAAxpMWXiXh4U3Q
 FI/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTKr25t8SKhSPPvZ1N+rrd7kbSgc3cejjtD/O9x8nvz5RcewpV3Qgnkk/NupiXdVjGYF5GlLiraG/xBUBMS8fkuDhB4dg=
X-Gm-Message-State: AOJu0YxmRHlxwKGpBTjyhJM5ih5lyK0z0FK+sip4mc6m6AAaqfUN/0J+
 m/bL/3PI2edDWV2Zm9T+nB9BpVf8eOdB0P0VbBHkGQj9Dy4LEZrUoh8N8YB7bhb/L+1DsJsgApt
 46AH51viCH9FvNBwWIuLEHDE9K8sKprY/zXNn2Q==
X-Google-Smtp-Source: AGHT+IHIN7St6HFO6wPf/kzS+eqwQhqedC9voaSepmskGaq79TiaiU5C3m/D9Umchw1d70eY6Djk4yyTgJpzp6ccqDk=
X-Received: by 2002:a05:6402:1f15:b0:56b:b146:2235 with SMTP id
 b21-20020a0564021f1500b0056bb1462235mr4590054edb.0.1711042640451; Thu, 21 Mar
 2024 10:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
 <20240321130812.2983113-5-ruanjinjie@huawei.com>
In-Reply-To: <20240321130812.2983113-5-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 17:37:09 +0000
Message-ID: <CAFEAcA97LQ87S+XRfbNFAbZMef=Bsnk-xLELkLDVsrsAJgWC3w@mail.gmail.com>
Subject: Re: [RFC PATCH v9 04/23] target/arm: Implement ALLINT MSR (immediate)
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 21 Mar 2024 at 13:10, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
> EL0 check is necessary to ALLINT, and the EL1 check is necessary when
> imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
> unconditional write to pc and use raise_exception_ra to unwind.

> +void HELPER(msr_set_allint_el1)(CPUARMState *env)
> +{
> +    /* ALLINT update to PSTATE. */
> +    if (arm_hcrx_el2_eff(env) & HCRX_TALLINT) {
> +        raise_exception_ra(env, EXCP_UDEF,
> +                           syn_aa64_sysregtrap(0, 1, 0, 4, 1, 0x1f, 0),
> +                           exception_target_el(env), GETPC());
> +    }
> +
> +    env->pstate |= PSTATE_ALLINT;
> +}

This is a hypervisor trap from EL1 to EL2, so the target_el
argument to raise_exception_ra() should be "2", not
"exception_target_el(env)". Otherwise we will trap to EL1.

thanks
-- PMM


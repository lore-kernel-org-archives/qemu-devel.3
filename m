Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDEEC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcci-0000Hm-OJ; Tue, 19 Mar 2024 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmcci-0000HM-19
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:47:36 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmccg-0000f6-IG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:47:35 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5101cd91017so9041320e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710866853; x=1711471653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IBaiRPredbqYgZQPnp8ZalF7vsr6iFg3y624z8HxiP4=;
 b=iJVJ291AO+U+a3FShLV8c5YWjPArzntXat3elJ0qldTuQL71rJuWaFJ7lT9ex9VAR6
 j492L09go6eUJtI5ypqlYczhHrtCfBkv28UM1oEjkMn6C0WDRCxIPdjavwhLPpXpOzaX
 KVg3K+VBWNoYQR1oM209Tlp6NONYWPSNNAOe3SYqQFrHFpFeQHHDcIEFcDsGeDq5pCKW
 v3DkT3t/SPszpKBKrRLHOxmi9kVOND/DLetZLx4RxLFO9jO7lcLuHTCVxnkCvf5byT9h
 JAcIHSh28ymSv/ErPZr2JXVECd8zqXD5YO9MknYE/nJRKmbF3iZNYsihj+B+z7Mw+k5T
 dPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710866853; x=1711471653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBaiRPredbqYgZQPnp8ZalF7vsr6iFg3y624z8HxiP4=;
 b=F1PKKFmWBOFOdRhj9rF14jwrlxOZrY4+xuG3Cfm8Bgtf1oZTxc30X8RpWxmXEE22W5
 21+SFG7tuQ0Nyb1gws4JKvmfa4dwqwr73hyq7KkWUm4BBDq72uKhQVlgDkMhDL6t4xuY
 MFcUM035YsJHzMd3rV3kEpb3+ySoFefQsQiTCNNgN7toewcVFehiwT0uNYqGJr6Azm6E
 NYs73vnjrM09EAaijlGiqOtrD24KS/snpavA307MWyEdUBbqY52x7h8/xC051c2BHyAZ
 ZiPymmYUFxnydkGe5phco1i8sLYTc4QKTYBIs8Job9kkV1HcX5PjKMVWp0LzJ6xJw0g3
 sp/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxwM1DvRoT+jH7NsVk0cymWaB9pHv7ndLRQkKIrns4wRiR9txMdZPWScLuz0H5YDS1k6e8E882L03aRAY6LwFRmFX9bJs=
X-Gm-Message-State: AOJu0YxHHxG1i65Mns4Nu8NHl82xvMh8y4ildTOAoAP7RGnmi4LDPXZT
 QlMFieYwPIV9Lo9Le95XQOSUwgIkphlUcL4hyXfd50V2AMcPy60FGacCM4heY12yAHkiVz1aYH6
 n1gv5jeD3KYM0OOf1A5EPMgQLtIO9RXAgWIMK1g==
X-Google-Smtp-Source: AGHT+IGlbEFcrJM7Eph8TMmpDLkP93r2gPHASDtryoXbwzKzTDAXxmKHzTeH/9N6wTIXDO+UqstRRFuoU1ktD6fTnY8=
X-Received: by 2002:a05:6512:102a:b0:512:e00b:8da4 with SMTP id
 r10-20020a056512102a00b00512e00b8da4mr10010759lfr.53.1710866852637; Tue, 19
 Mar 2024 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-10-ruanjinjie@huawei.com>
In-Reply-To: <20240318093546.2786144-10-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 16:47:21 +0000
Message-ID: <CAFEAcA8_2U6bydhixx+j84FUBY3tT5rN8Y4c6KHGjbbAX+1v3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v8 09/23] target/arm: Handle PSTATE.ALLINT on taking
 an exception
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Set or clear PSTATE.ALLINT on taking an exception to ELx according to the
> SCTLR_ELx.SPINTMASK bit.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3:
> - Add Reviewed-by.
> ---
>  target/arm/helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4bc63bf7ca..81f4a8f194 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11705,6 +11705,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>          }
>      }
>
> +    if (cpu_isar_feature(aa64_nmi, cpu) &&
> +        (env->cp15.sctlr_el[new_el] & SCTLR_NMI)) {

This shouldn't be checking the value of SCTLR_NMI here:
the new PSTATE.ALLINT is set to !SPINTMASK even if NMI == 0.
(The SPINTMASK bit description is a bit confusing, but
the correct behaviour is clear in the AArch64.TakeException()
pseudocode.)

> +        if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPINTMASK)) {
> +            new_mode |= PSTATE_ALLINT;
> +        } else {
> +            new_mode &= ~PSTATE_ALLINT;
> +        }
> +    }
> +
>      pstate_write(env, PSTATE_DAIF | new_mode);
>      env->aarch64 = true;
>      aarch64_restore_sp(env, new_el);
> --
> 2.34.1
>

thanks
-- PMM


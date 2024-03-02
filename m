Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7598FC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 11:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgN5b-0007hx-Ja; Sat, 02 Mar 2024 05:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rgN5a-0007hg-1f
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 05:59:34 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rgN5Y-000561-G9
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 05:59:33 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-566e6192da8so1901228a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709377170; x=1709981970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmQgw3K4rJPuao8UsehHU0Q2R2CBEgNDV+jIA0TZycM=;
 b=nI/ix9FgohsjxAkd9x+X8sZ9sxmPzCWJAtqE9aO0z0iNCpeIpv99HRij3WIebgCV/H
 fKuqvrbV3/DeDK2Q3Y0vouvLvFlqiJ0xJcoTI0iVB+2m3N/IQImUG/FnG02nlNKn40sh
 ZLTk239VemQSX45th5M8C8IjNib9jh/KN0FHSFtv4q89cXEAS/yXSVqO4rnhMPHhlUG4
 3QoM+Vr8tnikXq1R1gdXrk1r5XFh6eUH/f4XtTu88Ir+u5RBp8jFqLN/uJAEKES3ua1f
 v/yOf91eEl7bc9U6sqBTM0V3m4MhMEUupMNlmK0qT1Cs65OmJPmzkZwRdPuu8M5NXYs+
 hNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709377170; x=1709981970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmQgw3K4rJPuao8UsehHU0Q2R2CBEgNDV+jIA0TZycM=;
 b=p1ASM9mqaw+vTwlQV63C1XyVsoste2ZHNgFRUNBZIcAy0CMkbihSVkoheoCnRk9Ide
 pM3N73OIUsRGA9KkpHlOyyFpwOK3EPoXIiXe6SjRas7ZsyhfPLzEH8F/I+MGZI3BgFyv
 h+PbjZvcS9hdwrBW1kZ7wOunnsFg9J9vGYQWmZTr0e56bvXjdbikAdJYe9OJjB4iexXO
 tdsSz9JFnoCbuKb3eYyd2sazdmjUyIJdiAYV+0LYMcMN664g0LZ1C89dE4zlEXwIXYBJ
 LHy/un/y9rDC4GkIyzLv/hAuxTKfaaAVP7Luw8epF2mIXqoCJzn0om6r4C1oxolkIsIo
 eqcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWK8mR/ZC8MjE+xscRqYL/VscRmxBPcW/mN2Xm+LAKlFD52bFzHatcyuYDYSgci82eEl6H+BuVlQmMkSPbZXIWm/ynyr0=
X-Gm-Message-State: AOJu0YwSJp+yeDMNThajovgNHcRY1j6+wMswWaJOCSBRIe4UcG/YXC/W
 Y5HV1aIJES+bs8H0t7tLViJhIQJtp+CvfcELbh2oCp6R4bPJXVAygCisJCDmgnvaAfb5zCUTFd9
 XowdrefFPCEUngYilv8vsjZnabRPVzgWaeVBjEA==
X-Google-Smtp-Source: AGHT+IERCh8LArE6nSwZpT32M7j/NnsIryRGgwLcM59NPLrH4h2OeDrxV/sUFxB7T4K/o9y5yEzOILIekat4lVTE/kY=
X-Received: by 2002:a50:85c5:0:b0:566:1683:f517 with SMTP id
 q5-20020a5085c5000000b005661683f517mr2987722edh.4.1709377170358; Sat, 02 Mar
 2024 02:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-8-peter.maydell@linaro.org>
 <97dbadc0-a9f0-4c32-abb1-7613380e2a5c@linaro.org>
In-Reply-To: <97dbadc0-a9f0-4c32-abb1-7613380e2a5c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Mar 2024 10:59:19 +0000
Message-ID: <CAFEAcA8PB=601P-sWbBfVbDr1DMyLkZ0V6aseEX5Z=s=Bv0v0A@mail.gmail.com>
Subject: Re: [PATCH 7/8] target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 1 Mar 2024 at 21:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/1/24 08:32, Peter Maydell wrote:
> > +static uint64_t gt_phys_raw_cnt_offset(CPUARMState *env)
> > +{
> > +    if ((env->cp15.scr_el3 & SCR_ECVEN) &&
> > +        FIELD_EX64(env->cp15.cnthctl_el2, CNTHCTL, ECV) &&
> > +        arm_is_el2_enabled(env) &&
> > +        (arm_hcr_el2_eff(env) & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
>
> arm_hcr_el2_eff checks arm_is_el2_enabled and returns 0 if disabled.

Yes, and if it returns 0 then the E2H|TGE bits will not be E2H|TGE,
and so we'll incorrectly apply the CNTPOFF value. We can only elide
the arm_is_el2_enabled() test if we're checking for some HCR bit
being 1. (I also initially thought the arm_is_el2_enabled() check was
redundant and then found it was not :-))

-- PMM


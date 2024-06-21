Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0119DC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgTh-0004A6-GJ; Fri, 21 Jun 2024 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgTd-00049S-Eo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:47:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKgTb-0004lg-T7
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:47:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6cb130027aso137136466b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718984817; x=1719589617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0foJIqq89kkb1sR2lxAA/3c9445w60E9nij82OhyHSs=;
 b=PqRr0RaBV5QhP/SoeYzfyIB0sGeFZoZmBxI9Oxr/WR1bRiS5FFScJvZst8qZ5shRUC
 pYgbUOgTo2PiJrFFMa2IY/KZgye0+yYGK946hY52O3rVFsoNCqta+fdxi0ujBydHQSlQ
 EpZgo9lzruScpOOMpBR7vEsm4dAXxrrDQoFkQAyGTcnt9qnn5y2nTPDKakWVXrHRrBkM
 UEM5oR23f3Y10DVFg7AFX45QbsVWo0VTGQsYhXiArq274CJ2VOghepNxkxYC6G8bSHhH
 OekkMhaI/oE5xBnscC7MNkJnm4LCi+rUDV7ylSHD00bHVFhMiVHVOAnk0kwVoYYXHOZ2
 OL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718984817; x=1719589617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0foJIqq89kkb1sR2lxAA/3c9445w60E9nij82OhyHSs=;
 b=ZudYEo5Fc1WdN6I+JDbH5hx2g7lGk5/xTLZ0urla0IzcfcjS4LCnNZJW2Rw1nR/nVn
 VnUrFfvVJvOUHvTORU9NOvV7m0YpbRikBhdllFwPC/PaWtA0nQoglB0rk4OyDSC1zZCJ
 dErSKS8/J2TrtubAswelluUJJ/Drim2zO7vP2kwjCjhbYM+dfBpRA3+nDHas8PZez0JR
 5XW8T/CSQ5TdP7/Z2I+vlvJpauHauC+G4G6HiryEdbr6KfvUcVSq6k9oC10I/uPIfNo0
 L/XfQvPtnJfps9B/b08GOaQzPVFkP6J4IAnCzgZHiY/rHBHwlVO8UI0DYqqJFnRGR58P
 afnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEaW5jWdsI2nqypL+YNESB92vPfK1tuNZ8AayfHfwBA80RNdn/DokTVH3QO0lrvUFIgqYTpOJegGKnXoQR9LD1lNMAeKo=
X-Gm-Message-State: AOJu0YzCrP3XgJrEtVK4kfOKAuIwQTMpJ7tGpjciR4/hVKgJXVFJWs4c
 nddRyMQEirS6EEiPoO5+kf5DwaO0C8SqDSfvqa66Q3j8oyIBlw2K6WifpoSNyVHF6wQcRXIb/+u
 LAqnwMr+jdxCu1hnh8YgfBjSyrii6JjFV24bNpA==
X-Google-Smtp-Source: AGHT+IHc2BARzVl822q1LB8AZOncw47uQdfTk7oxqdHfqWbIi06JarTTB5Mj/gUynWYsAdLy5eeeNieFPZ2DvIUhM/E=
X-Received: by 2002:a50:d717:0:b0:57c:b810:1062 with SMTP id
 4fb4d7f45d1cf-57d07e421admr6442306a12.13.1718984817287; Fri, 21 Jun 2024
 08:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240614093026.328271-1-sai.pavan.boddu@amd.com>
 <20240614093026.328271-4-sai.pavan.boddu@amd.com>
In-Reply-To: <20240614093026.328271-4-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:46:46 +0100
Message-ID: <CAFEAcA-t7G0Y7GazmPV=hThRZT+w8cveNCU0kxv091+wAhXsiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] target/arm/debug_helper: Add fieldoffset for
 MDCCSR_EL0 reg
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Fri, 14 Jun 2024 at 10:30, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> MDCCSR_EL0 is aarch64 varient of DBGDSCRint, so utilize the same cpreg
> offset.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  target/arm/debug_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 7d856acddf..5deafa4d1f 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -970,7 +970,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>      { .name = "MDCCSR_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 1, .opc2 = 0,
>        .access = PL0_R, .accessfn = access_tdcc,
> -      .type = ARM_CP_CONST, .resetvalue = 0 },
> +      .fieldoffset = offsetof(CPUARMState, cp15.mdscr_el1)}, /* Xilinx */

MDCCSR_EL0 and MDSCR_EL1 aren't the same thing -- MDCCSR_EL0
only has bits 30 and 29 (RXfull and TXfull), not the full contents
of MDSCR_EL1.

thanks
-- PMM


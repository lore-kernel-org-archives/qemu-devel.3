Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF47DC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2nr-00039a-5j; Thu, 08 Aug 2024 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2np-00037Q-N2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:03:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2nn-0002jE-G0
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:03:37 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso994221a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723122213; x=1723727013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2x+upV4aKqH/ReQCdsxjfOCLOWnfSZw1DbO3TJVHrTc=;
 b=Eeb4IMP7nIyRGos1q3M2E5sdjKUcAcZl2L3vv0/EGAfG/eRyVWf+ZAgavKiPrFH9q6
 qwI2hXty+PMqIqRaFdA7XV3B+AtDkIW1nSW6u+UuMBYPCxGo6kE9W5/PC+PdZzXX4VLb
 b3fVN6i3gsMpyP37vvm7q2gBTWZDXu9DSsnf6RjtKzE+kiVmjsZY7ego8GPloidsn5YD
 b8w4kZYELt41Wnu416EW4VuDv3gMWMfOvWPgt/ZBvsQOJQ0JcVOvoPlWZtmYDfdcYU2b
 td9HBqEBTLLGObNwMfoYiqkL3DVfTHW76/fEylSEXFcEO6Ghvp1WiyftHkMKrJjcGmOZ
 qhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723122213; x=1723727013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2x+upV4aKqH/ReQCdsxjfOCLOWnfSZw1DbO3TJVHrTc=;
 b=MXRVMQusj/RDg1CRlsvLnyVdaSlfd/wJ8hJ2qaMnD7Dc/odeZIldrJql5oPuUrjf7P
 +v8XrU2Q5Jm5rDrSItOAomg+nhZctVGLgW28I91yvCYHXB9SxYpZPQpvPhpyM2X3Tx2C
 FFZycwsIwa8uZVgfN0nsMOGDKvaLJJ1kdaOLjs+lVQuebclMO9p0a7ULj73f8mlQisIM
 q/ZJfKgCMqf2woNBBazhAetR4ihgYUsBJTmZCHDKhw3VIuMxX4/OKWiumHKF902zJi0F
 c7WWJu7Zxb3G2oomaf2o3BC3mRY7W74Fyttye6KlJKgHxf3w+PYk3x4tcwbu7UWgd14g
 IhHw==
X-Gm-Message-State: AOJu0YxmkhdqMQWnIJAwaeaKQbuzOL8lyVHdDCkUdoYuKtf8RAtodUAZ
 d1uUMUIE16KHbDMTr8gsYNhPEuKf5srWxeZNXZSPloXbq1YT4Hf3thSnyDsd820XwwReifF3C0+
 R0ZsLc/ris9Xgh0upjh1TVeu0RKnIsgWpuCWbIKE9l5aR+LW8
X-Google-Smtp-Source: AGHT+IFKxp0gr4fyoe2rc9Hu96Tzt2xdkLYGPRo0vprZoyHjrH8/+CrUPOJ+q3pFPUfBb9qFbcPQEMcJ65p1EPF3/Zk=
X-Received: by 2002:a05:6402:42c2:b0:5a1:faf:e5ac with SMTP id
 4fb4d7f45d1cf-5bbb23c6440mr1615459a12.26.1723122212996; Thu, 08 Aug 2024
 06:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240801220328.941866-1-alexrichardson@google.com>
In-Reply-To: <20240801220328.941866-1-alexrichardson@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 14:03:21 +0100
Message-ID: <CAFEAcA88Y=VXcTAGyZ396L2VDQp77E5KaStjpKrT5AS1aouC9w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
To: Alex Richardson <alexrichardson@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 2 Aug 2024 at 02:00, Alex Richardson <alexrichardson@google.com> wrote:
>
> See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en
>
> Signed-off-by: Alex Richardson <alexrichardson@google.com>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 8fb4b474e8..94900667c3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>        .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
>        .writefn = sdcr_write,
>        .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
> +    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
> +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> +      .cp = 15, .crm = 9, .opc1 = 0,
> +      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
> +      .readfn = pmccntr_read, .writefn = pmccntr_write,
> +      .accessfn = pmreg_access_ccntr },
>  };
>
>  /* These are present only when EL1 supports AArch32 */
> --
> 2.46.0.rc2.264.g509ed76dc8-goog

Coincidentally I'd also noticed recently that we don't implement
the 64-bit accessor for PMCCNTR, but I hadn't got round to
writing a patch, so thanks for doing this.

The 64-bit AArch32 PMCCNTR was added in v8 with the PMUv3, and
presumably most guests which use the PMU in AArch32 code want
to retain the ability to work with PMUv1 or v2 (or were simply
written for PMUv1/v2 and never updated), so they stick to the
32-bit sysreg, which is why we haven't noticed this bug before.

There is an argument that we should gate this on
ARM_FEATURE_PMU being set (or on an ID register test
for the PMU version field being at least 3), but we don't
currently do that for the existing PMU registers, which we
just add regardless for v7 CPUs. So I think we should
consider that a separate cleanup, and this is OK.

I've applied this to target-arm.next (with an expansion
of the commit message to note some of the above).

thanks
-- PMM


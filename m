Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AF2D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6lJ-00065x-Hx; Mon, 02 Dec 2024 08:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6lI-00065X-I5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:46:52 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6lG-00070t-Ph
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:46:52 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffa8092e34so46000931fa.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733147208; x=1733752008; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVRIpEznl8oDcQBXG13TIiy7xFGZv25yp13RR2IH8Fk=;
 b=loR9WnT/41qIFxWNkOOvBKWDsksmmxlrVIfaslyBmkcGAt/P4j4FO9YIaNndplEY+r
 cMAs3FVKhri5zrPuTgvOPcLL1C8cPX2vltCqaFb+Udl+2ChCZ8eruA9INhBwjuI6O1s8
 3sNGv8IVM6Y3piCcmYTjuDUA8a9vW6/KUNwJVE/WmwaDkHT+BxoeIO5G+KXFocQD/P4C
 iPVE+S0D/wVTERWN/1eVlz6/PzXDB7S5xoeeO7CybnxvWLW7CV8NyjzbaKu8Z9QXp/Mg
 54LgOXqO8Y2EvoLKX4HGsWNO6mcdwMX2rFG0aEv4+ta3rA+Zd2LQV1TfZZw9GIZuTcPl
 K1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733147208; x=1733752008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVRIpEznl8oDcQBXG13TIiy7xFGZv25yp13RR2IH8Fk=;
 b=Cze8l8KGyacs+0pk36Qz74DlpOnE9w+3HlhasjK7Dp25AyQbUu7YlN9h2fQFd2HXxB
 b15sVbys9m1X3cpovSXSfvXpEh4UYkILNSH5u+GRXYi509DV8keYWxS/JTVZQVARC8Yz
 F8aqw3sc0kT+jrqmyAj2LnfFOcl/hMRETCi1Aod/KOpWWKEA9uzkZPIuevYWHwYPEn4p
 Taoi2sCVgFAW23S+UeZTCIiFwtr985v/F+KWjQJ5YSCIoWFTWou1gwnmhAje3MWpXzlZ
 wnZA2z+4yX6hi8L/SlkmknEv+MdyPnzI4DqQONsAqweOcfLPkMFWtgwZxQmrC7LCjuVi
 EXyA==
X-Gm-Message-State: AOJu0YxiGV0KkSmktk5QW1BlaaiRl1GA/pdNNAqlXOpoiyDhu1mOAdAB
 ZCEbJSIKeRQQmBGCV8ZLISuNVEtxFuyQ1VzxBJc3wQwwyJKEPzxjJRaSpBXWg9A1i1fT4XQPVpM
 O0k+qQtiFvxK+kp6tILlYFA57OIWOuXSgylBFfFn2sswsO+pd
X-Gm-Gg: ASbGnctsrsQ7+qHY41jsuumy4Jh/JGNM2/sPNFWnlws5Hipc+6vBXb94/CDeQarkx9x
 yCRlucSt9vjd0xckUpVbhAYC0YtY054JO
X-Google-Smtp-Source: AGHT+IGF6SyGJghqTcFtw6y6tsOXfnOtLkboLVge9m9V1cNnMBEgkVXOEKUlf/kuVb4uiJ8N91H0H/Y+MDb0Szf8aXg=
X-Received: by 2002:a2e:bc22:0:b0:2fb:62ad:89fe with SMTP id
 38308e7fff4ca-2ffd604941emr108380741fa.16.1733147208471; Mon, 02 Dec 2024
 05:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
 <c6ea5acc-e07f-4eb8-ad8a-b339f27c9102@linaro.org>
In-Reply-To: <c6ea5acc-e07f-4eb8-ad8a-b339f27c9102@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 13:46:37 +0000
Message-ID: <CAFEAcA_GA+UKqj6izUXY_snEECJc6buNiKrgA9yXXAW8skqcBg@mail.gmail.com>
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Thu, 28 Nov 2024 at 12:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/28/24 04:38, Peter Maydell wrote:
> > In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> > cs->exception as a shift value.  However this value can be larger
> > than 31, which means that "1 << cause" is undefined behaviour,
> > because we do the shift on an 'int' type.
> >
> > This causes the undefined behaviour sanitizer to complain
> > on one of the check-tcg tests:
> >
> > $ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
> > ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
> >      #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
> >      #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
> >
> > In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
>
> Semihosting is completely artificial and should never be injected.
> The maximum "real" cause is
>
>      RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
>
> We ought to hoist the handling of RISCV_EXCP_SEMIHOST higher in the function, before these
> calculations.

Perhaps so, but looking at
https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts-1.0.pdf
it says that mvien, mie, etc are 64-bit registers and the
cause value can be validly greater than 31. So we need to
use the ULL suffix here. And if we're doing that, then it's
harmless to also calculate these booleans even in the
semihosting case, because we don't look at them then.

So I think we definitely need this patch, and whether
to refactor the code to move the bool initializers around
is a separate question.

thanks
-- PMM


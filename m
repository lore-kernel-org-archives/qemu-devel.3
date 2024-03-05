Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB081C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWgT-0000ul-Cm; Tue, 05 Mar 2024 10:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhWgO-0000sp-4n
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:26:21 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhWgM-0002n0-EU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:26:19 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so8700977a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709652376; x=1710257176; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t79qxtDjvCjVIncwS12U6PxJd8QcEk1F5iBOvkG0Cbw=;
 b=DHKQceXis0gA7A0Fkxzbznkwi982akTOO/g81m07Kb3oxFxZDbIySbNDjS8ZHTjGkk
 NjT21MLunjR/7sgrE1f+EzCvYbasKnkg5+St77+Ou4+xBoPSpbYMqueAkiKfJEptgyRW
 56JFP2vxe8ie/JpyO0F7wb9BeNzHauT7xb1QxXelhtjohedigzf8/vzjH+Bw9kgUvxsV
 pbRzGcMHM8VNN/B4K2ckL3TSuUDhbjNSCmL7Lk8kGMXgzLKAebZBcyKO8HdpvY+Ri2oJ
 36S1CGp/3FDNUS4HYc0mKh4+mRHC39c6+FRgYy2ZNj/ZH694Y98D6W8wvMLkGVHyNo8P
 sNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709652376; x=1710257176;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t79qxtDjvCjVIncwS12U6PxJd8QcEk1F5iBOvkG0Cbw=;
 b=AbHePsxav9KMgYonjQTNV+WmG1iOWIoCw7/oUkOs2us9DOJXStcjzqdvgb8iYsZhNs
 zwpd35E1L3/bO8JZzyUMGkLnDYxcSXfANXEpYfOtlpToN2yuCf4CKl779zvF0nCE/ncL
 ECM5/paxkQ1WAG/NqgJr3raYTUoATg9lHx0MW4y+1b+VytVm4jpuNffSDKVDstqufQft
 ZDZb+3twxL1l1px0KK8fMmyfcGE6G9mO6g1tAjqP5ZVhtMnfseFdnY1rILi4n9Tf/lQ9
 b46w/iddDYFeHzD728XEGhCNEn3qiTsDJQKEFa5wKuTl11Nksy6UTqRaQpb21WzI+kAm
 FM3g==
X-Gm-Message-State: AOJu0YyW2mN/JDBB+10O7bQGFe8+NwRTKGrZRAhB/vaaZ599iBsVwyZp
 LQmZ3Xuh0yJo1QAtZpp5NAtKp3v6RR9wE/ZKWI1XCFKVTvnJE1vq35u7bQ4Ime4Uc/unP55FyKZ
 CMyHj48EvM4Srd2e21mPskg2oVSouW+XfXErNMwKUWa+S8Vi3
X-Google-Smtp-Source: AGHT+IGK+NXhF6vdCrOmdCdG29EaOtMOItyCY/nrir2ZcvskTs86w9FCV4w0ETRlcORnyeYlCbGzq8Q7dvKG265T6/M=
X-Received: by 2002:aa7:cf06:0:b0:565:a562:9fc3 with SMTP id
 a6-20020aa7cf06000000b00565a5629fc3mr7902185edy.38.1709652376484; Tue, 05 Mar
 2024 07:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 15:26:05 +0000
Message-ID: <CAFEAcA9rQc3-QzsiNkhGB_C0uQHAW6askWz5HwJGTDn8PmXTVw@mail.gmail.com>
Subject: Re: [PULL 00/20] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 5 Mar 2024 at 13:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 4eac9dfbd72d346505642fb45ac3141c7eb2c516:
>
>   Merge tag 'pull-tcg-20240301' of https://gitlab.com/rth7680/qemu into staging (2024-03-05 09:45:22 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240305
>
> for you to fetch changes up to 7558300c53057126514ee0fd5cf629c65ccc20e1:
>
>   qemu-options.hx: Don't claim "-serial" has limit of 4 serial ports (2024-03-05 13:22:56 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * raspi: Implement Broadcom Serial Controller (BSC) for BCM2835 boards
>  * hw/char/pl011: Add support for loopback
>  * STM32L4x5: Implement RCC clock control device
>  * target/arm: Do memory type alignment checks
>  * atomic.h: Reword confusing comment for qatomic_cmpxchg
>  * qemu-options.hx: Don't claim "-serial" has limit of 4 serial ports
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


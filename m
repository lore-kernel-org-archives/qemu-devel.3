Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA0C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 13:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTiIk-0005Tx-At; Sat, 27 Jan 2024 08:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiIi-0005Ti-Uw
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 08:00:48 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTiIh-0008W7-30
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 08:00:48 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55c2c90c67dso935713a12.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706360445; x=1706965245; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUYQ9FPbYSZb1yEmUq5n4Y3dMHXySccT4uPzWsxg0BM=;
 b=RAqp0ly3/w9wpbNj5aXrevqYDBcyxy4/qE7LIZjDRSGQNJh7vJG0PmIXDFYkAGlrKr
 CtfP60ADaip9mIkeAAQhfLZJYX497LTnZ5r6yCk6xDgt3S1u55HeRLCKHiB50VgaAQNK
 dlituF0WDqSLSBpmvrDMTRdvBBsxB1qo6k0kX5QSiv9dSW09Me0zgrUQNniQ9G/kfrZS
 on6mszEeFJUJUIqztViFIlH+BZaTRyqrMPXLBEQAAzgG8lFy7efmtb9iRAj7lvpbEZEU
 6mSvyWNn5dDhiQhHKbpw0gzjBsHyBCuKcwpoCgdUJGSV0PRC1c2FXIGI6U/DCaCua2h2
 /mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706360445; x=1706965245;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUYQ9FPbYSZb1yEmUq5n4Y3dMHXySccT4uPzWsxg0BM=;
 b=Cy3fS2pDnRd7AX+LHUii9ZG4YW3+oIBHx2Hayc72ULI/s9AtDqM/TJeFxxweHDzmzX
 3B7QGit8oWUR3awBs8XYPFKalpbdWm0Ke/rnZMO47dp5ofx/49mOTGkyEPiWXThusPj6
 6gVlyQivguBAXYL++FPEmcrIq8SRiiUwYdkiqJcCiNmLcYFA11nBCuGB+fvhejvSvlYH
 zCUOuxw8sSHu6hVSRLRt2JrtMD/cKQLJPYjQqynxSg5o9UZZk6+EHKGEDs/EMNGFPAyD
 Q1fULVR+nUfH64eWfoCLusFTmG36PWDcRO/HryOCC+KiIpJNzezyvJB+EblP07nOYc0p
 Qshw==
X-Gm-Message-State: AOJu0YwFUEjCCDOZhUmzy9Mn4jEE0uAVlYleUYPrMjYIhxUOGncJGkyr
 2rRa2XebvtAQg3GUPjnNIJ0Ikc1vF/RAA9wGlkhZVMbcHzcZtPTTlfH+GHJj7QChZ+pJnio1LiK
 2jGUGhTlbTkAS6PS1lg/m+6/iAgNHNJYTCxsgIMmpOJyI4H9c
X-Google-Smtp-Source: AGHT+IGW5pZxUE+CRfku+lOuO3LJipcUZZ5HgacYUWTF229nhZguOVDwxBmiW+c+8LhMKLMt2pj0gwhWZgpmnKxFz0w=
X-Received: by 2002:a05:6402:70d:b0:55c:d5e3:9177 with SMTP id
 w13-20020a056402070d00b0055cd5e39177mr999491edx.30.1706360445396; Sat, 27 Jan
 2024 05:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jan 2024 13:00:14 +0000
Message-ID: <CAFEAcA8vMxX2SvuX5RhxUdeimKA_18vMZUDhuC8PJkd9Vi8sAw@mail.gmail.com>
Subject: Re: [PULL 00/36] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 26 Jan 2024 at 14:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:
>
>   Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240126
>
> for you to fetch changes up to 5e6be95ed1578c7cfac2082b39384d99fd912508:
>
>   hw/arm: add PCIe to Freescale i.MX6 (2024-01-26 12:23:04 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix VNCR fault detection logic
>  * Fix A64 scalar SQSHRN and SQRSHRN
>  * Fix incorrect aa64_tidcp1 feature check
>  * hw/arm/virt.c: Remove newline from error_report() string
>  * hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
>  * hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
>  * hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller
>  * hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and Bananapi board
>  * hw/arm: Add AHCI/SATA controller to Allwinner R40 and Bananapi board
>  * hw/arm: Add watchdog timer to Allwinner H40 and Bananapi board
>  * arm: various include header cleanups
>  * cleanups to allow some files to be built only once
>  * fsl-imx6ul: Add various missing unimplemented devices
>  * docs/system/arm/virt.rst: Add note on CPU features off by default
>  * hw/char/imx_serial: Implement receive FIFO and ageing timer
>  * target/xtensa: fix OOB TLB entry access
>  * bswap.h: Fix const_le64() macro
>  * hw/arm: add PCIe to Freescale i.MX6


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


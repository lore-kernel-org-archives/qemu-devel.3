Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4AC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf17P-0004m0-EI; Tue, 27 Feb 2024 12:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf17N-0004lW-3J
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:19:49 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf17L-0000ZF-69
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:19:48 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so8062261a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709054385; x=1709659185; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOfATZXUwIjVOsUxACJffWxuM1hsPHNRWZYYoKNrVoM=;
 b=tX2Ro9P8rkPfGLS8NhszC/3lcxmfyOgjP01WjT5fzu1sBDoiiNhgnJgx+MSU+YW5k4
 diAa57wB8gKvsmt8iep7f7v+LWVOOdNXovtcMiwHNFKxTzctE6Q3AoZ/m0HlCLPvhDx2
 I93CNu8fvj0oLnoh8oG6nFqsz6VV0EFdwE+gFgFHtH7LFYgrhkSB4JGfY44QemASHJjc
 mudUg5V2R0s++Uk2CxVTgEZeX21aC9sXDBPPr47A+qWvVwrRpoIaXRf8b2mQ+OGInpFn
 g9JkjyhZOjNqb6kFnJnS7ZQtpPKWAG27wCuZ6LCJsoHSUavOFzDCfRgEmwe4B4+P07fh
 KiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709054385; x=1709659185;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOfATZXUwIjVOsUxACJffWxuM1hsPHNRWZYYoKNrVoM=;
 b=MleBqGGSy5ovhIytOBMlzReTSJ8gi7bIM01bDv3mnQIfZUgUUVRgWULGzacZbgJRJK
 AcaAm8i7qXS21G3JycW07b7NPTeHm+7xfJ+KOQSzwTV39GyhT6/TcZ+lxUZTcGN+jOBk
 zD/Qb66/kaAQO31s80DCREdwVwTmKGfdW3WhtyIzQteNHAivAHfpoA03a7D7qDdKAKJp
 F16mAvBQK+TwevG4hDxKm7cJ7fqJRQfM+sU+KlyHAQnU2Wvn3/qvrRp5EtwSELozIVSj
 9svWS//KtoBrSWdCVKUG5UKTpOS4bl3OepZDXYKf0TcoNfZwBhVB/WH1pQRmWeG6cJy1
 WM/Q==
X-Gm-Message-State: AOJu0Yyge22zuPuUGXvD9A4w0nGJez5fDMnVM+NC6Pkleahtn+zwiziE
 C/GZp5Rz6FsvOSOg8OlmpnPqEhOqZCQQkuNGpPH8ObahQfmLb4WbtNIpnHWEkavKDF8Odt/pTxK
 aNfCBr7FWl2hF/KsJn4YnR+KByxMZ5FUdho7i93+PCBp53IZl
X-Google-Smtp-Source: AGHT+IHLG65VTvcbar7ErGHRJygZwBne36YhC1V1/RAu/czlQwbm/YeI0MTsP5Z8EzkbnGA9EdVSMvzi4Yf4vWWUUOs=
X-Received: by 2002:a50:fc18:0:b0:565:4ac9:d69c with SMTP id
 i24-20020a50fc18000000b005654ac9d69cmr7119800edr.11.1709054384758; Tue, 27
 Feb 2024 09:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20240227153410.1917221-1-peter.maydell@linaro.org>
In-Reply-To: <20240227153410.1917221-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 17:19:33 +0000
Message-ID: <CAFEAcA-PP-+aVpf10B=ZQ3qkBLVbZfxgpvo4A0m8KbayP-CPzA@mail.gmail.com>
Subject: Re: [PULL v2 00/36] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 27 Feb 2024 at 15:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Changes v1->v2: dropped all the patches for the bcm2828-mailbox qtest,
> which turns out to have portability problems on big-endian hosts and macos.
>
> thanks
> -- PMM
>
> The following changes since commit dccbaf0cc0f1744ffd7562a3dc60e4fc99fd9d44:
>
>   Merge tag 'hw-misc-20240227' of https://github.com/philmd/qemu into staging (2024-02-27 10:11:07 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240227-1
>
> for you to fetch changes up to 9c5c959dd748f2972e46a84b8d5f77794f515014:
>
>   docs/system/arm: Add RPi4B to raspi.rst (2024-02-27 15:24:20 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Handle atomic updates of page tables entries in MMIO during PTW
>  * Advertise Cortex-A53 erratum #843419 fix via REVIDR
>  * MAINTAINERS: Cover hw/ide/ahci-allwinner.c with AllWinner A10 machine
>  * misc: m48t59: replace qemu_system_reset_request() call with watchdog_perform_action()
>  * misc: pxa2xx_timer: replace qemu_system_reset_request() call with watchdog_perform_action()
>  * xlnx-versal-ospi: disable reentrancy detection for iomem_dac
>  * sbsa-ref: Simplify init since PCIe is always enabled
>  * stm32l4x5: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI fan-in IRQs
>  * pl031: Update last RTCLR value on write in case it's read back
>  * block: m25p80: Add support of mt35xu02gbba
>  * xlnx-versal-virt: Add machine property ospi-flash
>  * reset: refactor system reset to be three-phase aware
>  * new board model raspi4b
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


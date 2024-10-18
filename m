Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C944D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pHs-0001Ft-21; Fri, 18 Oct 2024 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pHp-0001FL-LL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:53:09 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pHn-0001qU-UI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:53:09 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb6110c8faso25277241fa.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729266786; x=1729871586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSQrqbANsNOJA3Vqx/Lfg4s4ZRU/2vkIVIuwMW43r2A=;
 b=iw7hAxESn18ZD8wJM+iBHL8ynnmxEMakTPoCbiSwhOvhK+CTBmaxoSVvNhDvHvDvgR
 PjQVmmLOmwR3UaiSmEJYQk7ySs30iNtcXKsEfxxeUzDUWnj5etel+epb/ZdijNYGSCB0
 wlEPjXtFSfVMXpSrT/eFx2cciNQ9cnCMvTl9hrux1AqOInFM832IjzkDZIbJVvxfB3q8
 oH3uM3qVyMXa2kNLOXvJ47IU7iKUrf53Oa56J9+TjimDUMxM1bCjUP4FtAUshX0BV1nz
 U+BKroag+XzDOavbrMar54Brlo39T65ZGR3HNTxff3CIIqERzl19t9uS8jzo1+EZFBlo
 0kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266786; x=1729871586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSQrqbANsNOJA3Vqx/Lfg4s4ZRU/2vkIVIuwMW43r2A=;
 b=E/aKj91JhE1NBM2AOrktrXv5XJvdcmh9Z/23AGwuhG+3TOOX4BNX9hIhWmw4hVepip
 aSG+hF/DdrJfEDeO/ADrfCs/CrCyKY0ZHDNF30/iSm2fc6MAtCjBIw8tfGF7e0WB2ynt
 YcNiLNecDyAWcwPN1gpf1Mav4UfIgisasHfgvwth0Jwf0LbXxu9lE6SZ7Hwi8RnWkGnw
 7EE2IMPxFmE/V4XYj2d5SUiVlZnHxSMonLvt48BMaTxRdnuutPuMdZc7/ivcdHxbUNDV
 YICWgd/RAf9pV7WTS+onvjY2RKfWgnmYHNVeNcsvgVAQPpuirOWO++4exxqgdl/AKG7E
 LPAw==
X-Gm-Message-State: AOJu0YyGkuEckwngzMAVJgD35MTp0OFxx2QW4ZgjFxOBPEednW3oVwom
 r1wgH8fasXWZuu8FUOyKwbk3pUInK0+HqGkIfVmOKxsc/bA3ax2rB9ViAzTbIzIZ4K1LnffFvmE
 ObsQr7pfn0bHiz/Q86w5oam65RU92K+cktan9il593x0/svSb
X-Google-Smtp-Source: AGHT+IEm/Th3TzUgSIRILFWkIVQJ+42jWeobcgh6KCobAPheKyGMGnF5eyozXonWKhIP6VFGqhzrgTfeIBcOkxOytA8=
X-Received: by 2002:a2e:b8c5:0:b0:2fa:fc41:cf84 with SMTP id
 38308e7fff4ca-2fb832a9d57mr11881101fa.45.1729266784713; Fri, 18 Oct 2024
 08:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241010131800.3210161-1-peter.maydell@linaro.org>
In-Reply-To: <20241010131800.3210161-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:52:52 +0100
Message-ID: <CAFEAcA-Hc0MokLOqQ_vNNEY4k-fVOMvw1Hu+fODoWcqu9mZ=Ow@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system/cpu-hotplug: Update example's
 socket-id/core-id
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Thu, 10 Oct 2024 at 14:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The example of how to do vCPU hotplug and hot-unlpug in the
> cpu-hotplug documentation no longer works, because the way we
> allocate socket-id and core-id to CPUs by default has changed at some
> point.  The output also no longer matches what current QEMU produces
> in some more cosmetic ways.
>
> Update the example to match current QEMU. The differences are:
>  * the second CPU is now socket-id=0 core-id=1,
>    not socket-id=1 core-id=0
>  * the order of fields in QMP responses is now in alphabetical order
>  * the "arch" member is no longer present in the query-cpus-fast
>    output (it was removed in QEMU 6.0)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Message-id: 20240819144303.37852-1-peter.maydell@linaro.org


I'll take this via target-arm.next unless there are any
objections.

thanks
-- PMM


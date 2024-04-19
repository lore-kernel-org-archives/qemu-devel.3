Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A5FC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 14:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxpRu-0002DA-P5; Fri, 19 Apr 2024 10:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpRs-0002CT-6Q
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:42:44 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxpRp-0002Jp-Ec
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 10:42:43 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso27733291fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713537759; x=1714142559; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TrM9X4uMslc4/C1Na1YYTRdStooeAAUKzGJl409xXY4=;
 b=K0yx40e0v54DbrISlaY2hMkpoQi5qRJ17WNke5nm0GE+fUSnNj6VjZFXYeecu5J0Wt
 p/6gn0dAix/X3wRPUY8DEnURE1qWvKa2utH6YXk8QsxvmaAhECNHTygviLWON1ObeqRd
 Jb5rqIda8Wc7Hy9EVCojvdo0GdW7u6tkk1nvpHAI1GO0yWF+nUkhe38KFw/K83ZF59qU
 TFP4NpDE+6XK/24iDbAIG2v3djitIr7DcD/ikc9UdUKISD//UH9j7+O9qtKWOtYMcwuc
 90v8E6gInAsgSeo/RoWuc/NtB4npZpcS+H2gj1KzUPg7aj+UO9hGYvQ3VCtOt8ElRMVz
 RjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713537759; x=1714142559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TrM9X4uMslc4/C1Na1YYTRdStooeAAUKzGJl409xXY4=;
 b=i6ogEJb0e5B8ElixAt925m7GhDlDbHkkSmXCufFSA++LT/AkEPYtSOgmp8+oj0Fhc+
 4aQYSXpimXATKtoxCQwgth07ZKpvkrsgF8blHr1io3Zf+0rDTe3WkG0z2oeag4u9ELyA
 ma5bvPixdV464J+Pn2nzzGXjfhNFFdmNU/cgR6HOdMgNFDp+SA8OPrLZJHqnkBT0E8k0
 CIJLBGjS64deIWoZ8LGYosboNLAvN/u1re4N8lHPiNgZaRswyBRndSA979oBlfcRO5gl
 f9uQwfjBPDsC4GDUito5PDyvQHw/W3Pda/4FIREVjY7oGzjaQVERxVzTQzfEcNjSE/uL
 5Deg==
X-Gm-Message-State: AOJu0YwtFlbdidErJy2hFaZ+jXSIMSMPNYpAiT3QAyJJy/cVkVtL6uSs
 DhEFZERdn88EX5dPAfDD4NdYstL/3QzShFFi1oD951ZyDWWoMcYVEodELSWPJy80+xQLn4fEoCz
 Ow1OvvNlf0Ztie4x4k8bqRsLY5t/eg445tmQOhA==
X-Google-Smtp-Source: AGHT+IGCI0rJIoUbXgsgfb8gxC3yyQpokkmmR40s7mcHPcQgKd6fzRV+3QY7qS3U7jYGXlNkJ+o1Uaf4MGrlhozCcOs=
X-Received: by 2002:a2e:8195:0:b0:2da:4bf:ab14 with SMTP id
 e21-20020a2e8195000000b002da04bfab14mr1922719ljg.45.1713537759226; Fri, 19
 Apr 2024 07:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240329174402.60382-1-arnaud.minier@telecom-paris.fr>
 <CAFEAcA_xuXMRnmFMs_GzfrDN_kpR+c4C04OcPjxtz+hSB_ga2w@mail.gmail.com>
In-Reply-To: <CAFEAcA_xuXMRnmFMs_GzfrDN_kpR+c4C04OcPjxtz+hSB_ga2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 15:42:27 +0100
Message-ID: <CAFEAcA-mQk8XZ=nBRqRBCotMVP_cFW3V_cn0efHq0UbKfDgZow@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/char: Implement the STM32L4x5 USART,
 UART and LPUART
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Fri, 5 Apr 2024 at 15:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 29 Mar 2024 at 17:44, Arnaud Minier
> <arnaud.minier@telecom-paris.fr> wrote:
> >
> > This patch adds the STM32L4x5 USART
> > (Universal Synchronous/Asynchronous Receiver/Transmitter)
> > device and is part of a series implementing the
> > STM32L4x5 with a few peripherals.
> >
> > It implements the necessary functionalities to receive/send
> > characters over the serial port, which are useful to
> > communicate with the program currently running.
>
> All the patches here are reviewed, so once we reopen
> for the 9.1 release (in another two or three weeks) it
> should be ready to go in. I'll keep it on my list to apply
> once I start collecting 9.1 patchsets.

I've now applied this to target-arm.next for 9.1; thanks.

-- PMM


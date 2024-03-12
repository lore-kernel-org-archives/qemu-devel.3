Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10031C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3Rl-0001wF-Dl; Tue, 12 Mar 2024 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3Ri-0001rc-7K
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:49:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk3Rf-0001Dg-Gx
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:49:37 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-568307fe62eso5778888a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710254973; x=1710859773; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGlAorUVssSBcEt1yAdhq3ZZUCMc/3aU7B9ByxNY6IU=;
 b=MQaFUTtWWqX4qixkidcohfojyUhVcMZN3/ZnjNtjzV9QR8Fz66h8AheSLyhN7oDA1+
 qWn0toS+6ObJGH/TFWvOyZaXrv6rl0jSk/ZduAJvGaV5jtIxlrxlpLJ9XyjKsPbNz0B5
 Vaxv6cRHokW6w1a2tepTIrxTQZbvq6UJnwSukWHASK3bTCQJfID1QwW2M2CAmXgRxpks
 uvUOhYW/mnREXpm6D66SpfjzS8JsPt0dDUOCQdEfKhTef0uy4ZGxgRq97fzc7mXN7Keg
 erfRLVEy8l4wshcLNrZt5msjDy6H25Mmjv2zcDID1ETXg6d+N24K15HXqfWhCfpYU0v5
 OmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710254973; x=1710859773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGlAorUVssSBcEt1yAdhq3ZZUCMc/3aU7B9ByxNY6IU=;
 b=J+fSXeP2Sge1jcN/1Iwp8m6QdzVPASHZ+tczlzxIz/aISHOl3DnQEotgxJu9tTChbO
 uTB43nuKWuKE/jvaj2UnjtNw+R0wBLd0FN/rmuh2AxUW9Nsqp/DMxB/Z/bJQdkR1Lp30
 oxyR9aaXa3Al3UOTkYpA0RTDwv4nWhCwIyOnFN3bQl93xPK1ZoOtnA19zz3D7aTP4axs
 +7T87bpslnvgRoWrrBB2oLKEpkbzaYspCNwiM98Z4tHr4vSLbEIJYSBAwkgEB6X4q284
 AFumBa7qSwf7O7j+w0CtKkJZO3w7AICmBXjhoQdfyVcK587zqwhsdlIq4/K8PrrcVB9z
 TALw==
X-Gm-Message-State: AOJu0YxG9BYnd331RJbYbjF02SarO128lalhWTjIRjWaVEddvv1ke25H
 2wRtiiJZqEiEq+trVECuccYEeTyY+qTN3dIl8oGnYHnTfeQrCtApZZ+ZU16vqZhIBnyYQYql4DL
 iIBHN2/W26epUxoasWnUG64ixDmDOk/pf99gnIg==
X-Google-Smtp-Source: AGHT+IGIHEOvSPMj3vjrdKTbsdo7C4Si1MbM9/txBoM1h3KBqznTBp6/aK4IvY0wzihdYBFda985Tm2gFmFcLjG8XGc=
X-Received: by 2002:a50:ab14:0:b0:566:1725:1c86 with SMTP id
 s20-20020a50ab14000000b0056617251c86mr5769634edc.12.1710254973607; Tue, 12
 Mar 2024 07:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240228120215.277717-1-ines.varhol@telecom-paris.fr>
 <20240228120215.277717-3-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240228120215.277717-3-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 14:49:22 +0000
Message-ID: <CAFEAcA--9tcBoFGznv4cFCNYGyKvgtav6aURL1t1vQBDFLwLYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5
 SoC
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Samuel Tardieu <sam@rfc1149.net>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 28 Feb 2024 at 12:02, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> Exposing SYSCFG inputs to the SoC is practical in order to wire the SoC
> to the optional DM163 display from the board code (GPIOs outputs need
> to be connected to both SYSCFG inputs and DM163 inputs).
>
> STM32L4x5 SYSCFG in-irq interception needed to be changed accordingly.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---
>
> Hello,
>
> If SYSCFG inputs are exposed, should GPIOs be part of the board
> rather than the SoC?

I generally approach this kind of question from the starting point
of "what does the hardware we're modelling do?". Does the actual
SoC expose these lines as pins? If so, QEMU's model reasonably
should too. If the hardware SoC doesn't expose the lines, then
presumably it handles the DM163 in some other way, in which case
QEMU's model should follow whatever that other way is. This isn't
always feasible, but it's usually a good guiding principle.

If you can explain in more detail what's going on with this
particular board/device I can maybe give more specific advice.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A304C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seDx1-0003Ry-HH; Wed, 14 Aug 2024 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seDws-00034G-Py
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:21:59 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seDwp-0001u7-OP
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:21:58 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62575eso2671031a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723641714; x=1724246514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ+Iuc+bftzG3jaPUVciqdxI8fDatMJevUO9DZjOZDM=;
 b=KprRmy2oa28D0q/YrHIIW+7o64k5/QAPt1627Jg1tA8WC6tA8hHbMTv6A7HGjes97x
 +bREf6cIXblEv9xXNZUagcJFee3k/wACohu5ofQDO61T/UTKtp2BW+phE0DVe0efQXup
 coan6gnat6Sat3wVC/KQnjWiaS0dYnib2jOhIQpPwHcU+WC4ptnDeo6C6hVHdAEKeX1e
 oMhjPviYLzU9KHDK7x1xrLcPVqCiilrSm2JnGqpnadPE0NiNW2wPCl3oLCxL/kvuZB6D
 aJeduh2cYfAFGyj1QawNdlBgMShfJ+H8R+Fs+RZM7cQh+x4IJ8sH6RCrL+x+gJ+hOx0Y
 Q4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723641714; x=1724246514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GJ+Iuc+bftzG3jaPUVciqdxI8fDatMJevUO9DZjOZDM=;
 b=RXLJdf+Y3v4iCl801/xcqOnYCf8SAN1+rmu/zOdtJBD6jt2BpHxKmMaVAPHE07dtbk
 HlhirRI8Bg7LuJEKE7F+MzegR3tFBhQw2HRwmMOMljddS2aufBq+hTtASvfJBW78p5nj
 bT8tiZxjn4vrD+t1+G3clJOqD+v0jegqJTEzkzWtMH8/bdSPxdFLdNw83z7dMy9J36yB
 523wsa6d6+l+kYqsrhatBYIyDhOz6xSR8s6EzSWjDnwTqXzovPLwL6L7GepcaVL5TbmO
 GKZzOplkej8pBR1Go2haM+b9Geq0eVkkyjoaTGgteqdXtgk92GldHgBvslAtd/lGSzec
 SJ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ+buRBN37C4ahZlO6JSnX6m2ZgR2CXCobZhkeJftkbNnKCfNWjHhMgIEll6gp9bu9QYgliDyKVRbKBDE2xLUTuSlwPQ8=
X-Gm-Message-State: AOJu0Yyy3kACn/+DmDGvFjLKk0hibS4ceIBwExLC2kEybbUMRVieXRpw
 HC9EoXNEZfmQ+R1w6/VHNVrO0xrbkgebUmtn7aHaR92EYt+xxLu5F+iS/xqRcNF+RT7U+uvtwtl
 DmTNA2FAWK+mM97PR80E+sHSbPnNB4nuGWrjdHA==
X-Google-Smtp-Source: AGHT+IHvHgaJ68W3I1VlM/ud74ml+XndxOZMOsneJxEPLPjKhI5oade3M1rlr/4tol5SOfSL7OkWsXl/elwP9PaeCUA=
X-Received: by 2002:a05:6402:354b:b0:58e:2f7c:a9c with SMTP id
 4fb4d7f45d1cf-5bea1cad16dmr2519600a12.26.1723641713567; Wed, 14 Aug 2024
 06:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135550.3108739-1-zheyuma97@gmail.com>
 <369e356e-4882-4290-bd7d-f37ad0058529@tls.msk.ru>
In-Reply-To: <369e356e-4882-4290-bd7d-f37ad0058529@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Aug 2024 14:21:42 +0100
Message-ID: <CAFEAcA99vDSOgO7rDacV=Y8LfWoO9Ef_xcyatd4X8B86C2S35g@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and
 MCOSEL values
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 14 Aug 2024 at 05:35, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 18.06.2024 16:55, Zheyu Ma wrote:
> > This commit adds validation checks for the MCOPRE and MCOSEL values in
> > the rcc_update_cfgr_register function. If the MCOPRE value exceeds
> > 0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
> > corresponding clock mux is disabled. This helps in identifying and
> > handling invalid configurations in the RCC registers.
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=qtest, -m 512M -machine b-l475e-iot01a -qtest \
> > stdio
> > writeq 0x40021008 0xffffffff
> > EOF
>
> Is it a -stable material?

No, it's not worthwhile. It turns a case where the guest
misprograms the register from an assert to a log-the-error.
No real guest code is going to do this.

thanks
-- PMM


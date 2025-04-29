Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB01FC3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gQ7-0000kR-VH; Tue, 29 Apr 2025 04:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9gQ3-0000jL-Nz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:34:23 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9gQ1-0006Zd-Uq
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:34:23 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-702599fa7c5so53008387b3.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745915659; x=1746520459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJdXS513DaZqn2tyTP0u1sBIKi56jeLcaOX/W+hUxrw=;
 b=Ysa1zd3znK/Jyt6wIUJinqTGpVnnmTRJYr6DbyyH+KlZsBCg3hBfawOJ99gD5LW7Qg
 oUxiF94PlKCiD2FXXufdaTg+QyEshg1E6uxqyW6+2op0kW1IRFz7KoOZEMaGunZIPsGr
 k+S0ypKqUISiFvt1IMekcX8nT1FQN/jmTp6VoRJMoU3Ktbl/HhbrlAKNqAiJs6zbcXdZ
 Nzdg9G29vI4Ftx/Z2bVXi2r4jfQIJfXJ2GCTdQnc1PVD7mwUyKTLL5/6TYoJaTWX3u68
 0NYSKH4VCOmHCiRd8mePzHJYHDelgC5BhlgewgdD/K4LtXHRwX1YLs4dWb022TUEEK+U
 xPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745915659; x=1746520459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJdXS513DaZqn2tyTP0u1sBIKi56jeLcaOX/W+hUxrw=;
 b=S3oNg0lK0StrU1oUOgRi1y4mizx0/6M0CB8xl24s+E2ybCjzm0Gl4c0n+jWaWC7iDH
 DvRuTh2yPd9wMYv7mRnEjOJdxmafdJtu7BZjIu8HdxeKRJ9eFmgpIbnkrOJosB8DyzmT
 2yZUWgtX24DSEeKt/2zUhplfhnF0ZXefQ/1vngE38faiHkTeW34473vLgdwKO1uSwaZd
 L8mHfsx+nGsxtlGgWiWEk8K26V5qHjnfumhsEBo+z1Z9GnUzzsKDyum7hnG6wGZzJAMo
 OCosZelB7Jtx/QXHYziJL3KgLiI1fPSkaBWkVeRHB9KWKlnmDc3/cHPI8smz90wK2AEM
 gs5A==
X-Gm-Message-State: AOJu0YwC8mbVEetrTDNCE79YjOLEZMH+Zriu7whfor0pU+D3V7f6GQca
 UnV6jsOAQgjt6TBPr/pa7S0db77GUXWXAFoiNz9+o+wD5WExmhDFLBS6i4PHGE0UZrHyNr0jvrS
 dE5u9UnHaNZOOZTz+SXbBqYwsEZk27D/o+LwF5eKyYSZFINXU
X-Gm-Gg: ASbGncuEV5s1hkT/E/pyrOuAdhj6U1HjB4pqAuTSguvYXN4mZMtY35Me1RCX+Xha84y
 3Z88TCtZPMhnphkJzDKi+DNVgALVeQaLekICjpFu5XHKfEDst7umvhOlCnnqNm6tFOfSgQRLHGu
 TxCi7AV6lwZgvIicf70Fz+WL4=
X-Google-Smtp-Source: AGHT+IGclq8YL4D4x+kwaClqwQXldYDn9wyb0kyWidhDQM9N5XlQ3pCJUOGqmeiwAdh+u9Y7NuquBJ8EvIA0xj3kuek=
X-Received: by 2002:a05:690c:f0b:b0:6f9:b144:34e6 with SMTP id
 00721157ae682-7089ab05c82mr32598527b3.13.1745915659513; Tue, 29 Apr 2025
 01:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
 <CAFEAcA_kekj7L9a1TwQ__WCyhgFd8P+32pB+dQGO570tEoNZMw@mail.gmail.com>
 <tencent_B77227163765667B525580026461F5007805@qq.com>
In-Reply-To: <tencent_B77227163765667B525580026461F5007805@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Apr 2025 09:34:08 +0100
X-Gm-Features: ATxdqUGWE771yJGNQE3lxEdhxCbtEGRiJg6B2PcRSESY6es5feJass23I5SE-Oo
Message-ID: <CAFEAcA9Gpg-2-R0M+GUvD6LRRcDxEaqEh1HPeUTNRP2o_Woo2w@mail.gmail.com>
Subject: Re: Whether the qemu mps2-an385 model support getchar?
To: =?UTF-8?B?5bCP6ams6am5?= <1353455048@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 28 Apr 2025 at 18:24, =E5=B0=8F=E9=A9=AC=E9=A9=B9 <1353455048@qq.co=
m> wrote:
> Peter Maydell wrote:
>> The UARTs on that board work fine. The error message means your
>> guest code took a fatal exception (i.e. it crashed). You should
>> start by debugging to find out why the crash happened, which
>> might or might not be related to the UARTs specifically.

> But I just write getchar() in the demo's main_blinky() function
> without any other order, I just keep the original UART address
> configuration in demo and annotation other codes, however, the
> error still occurred. The program can enter the main_blinky()
> successfully but can't excute getchar().

When I say "guest code" I don't mean just "the three lines
of code you wrote in the main function", I mean the entire
guest image:
 * your code
 * the RTOS/support libraries/etc
 * the configuration, e.g. which machine it was built for

Something in there is probably wrong (e.g. perhaps you're
using an RTOS setup that's configured for the wrong board
or that thinks the UART is at the wrong address, or perhaps
the RTOS is trying to use a non-UART device that QEMU
doesn't emulate). The first step is the same: you need
to debug the guest image to find out why it's hitting an
exception.

thanks
-- PMM


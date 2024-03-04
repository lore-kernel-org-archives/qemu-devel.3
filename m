Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C8AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBRD-0001b4-8E; Mon, 04 Mar 2024 11:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBRB-0001YJ-Ff
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:45:13 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhBR9-0007CI-MO
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:45:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso6218561a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709570710; x=1710175510; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRoFfZS6WhZ4JpL4Bamd0JVsZ/xh7vi9fLKC22s7ctA=;
 b=sgk4p/U2iicNE8qSbK+7cGj3F+Px166E4JLuoF2o2o7XlOvDsiF6Bf2JaqxpZMXPii
 iF2fML/3DAulLZoZvk2FRiqVX7wcBoMBR8foR4RSBdR2/VTs65/U+z1OmyE/KPIH+HCl
 u2rT7oNx1oq4MTBZq0p3DtUOtw2p5rXNVNW6pGa1WJXz5sYBdmIteg3sCT5mNReQQBEX
 Ow/lVWNT/m+oC/CaoN6GwqpmG56SebHtA7TrFqD3E1qMxYOLSJ2JLJYwRUVzsnMy6iJ1
 htb8T832dCN460WvodgQT6B8DCv5m4xGZAipp0T78eOT8ebW4h0HFv5RDKWaN9Lyxkn0
 R21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709570710; x=1710175510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRoFfZS6WhZ4JpL4Bamd0JVsZ/xh7vi9fLKC22s7ctA=;
 b=czbnVo86dxPhVc04tEvnWGWaFVKFYgIV9WFB44DxtKFyGQZ/Fwj2L1dkJEbAV5ziWv
 7P7Fq/jVWns+zxE+slIkvSB06csRHKT2KSACS4xJsGEYzPjr9dFCBCVap2H2ySedO69Y
 HQjMYrxSm4LaYxriIPCoU1Fr56xICOEgOGwyMxGg6zUBZosuG+0j8QmSArLA/SIE/YYE
 5OOZ9kYOTapXU2UukXB0ktmup8zmo/Yf+iLDpQGOFLQqJ5oFrTv2MLUXzblXvdIf0HGi
 up0OkKNUfvo37wz7WAzXdM3b2alpWUztdPJZVrolsB1tWvFtKY7m5M4a7A/eM3VqAbWX
 fLSw==
X-Gm-Message-State: AOJu0Yy24Fxh7sQc+4UPOc/gm9blewYvbKrnHLJ4waF1O+oO6qU3B3tw
 bu8yCxz3shtQQn8TM59aIV9lm5/M0QOiCIb1xT8fVlcr5tbjN9hvSYYxB9FY2r2Mi3uV6+mml4M
 lUw0i5PrrfM6gw9o4S+/sjqe+OyX1HU9dk7S5Bw==
X-Google-Smtp-Source: AGHT+IF0JFFtCjDtzYf4M4BoY2UFZ2hdmOsufQiKcOvK3rw5Ak6qLW0U9DXj7MbxjLWw5q5Ri4Z+BryUbQTIsBAyOow=
X-Received: by 2002:a50:8dc7:0:b0:565:7116:d533 with SMTP id
 s7-20020a508dc7000000b005657116d533mr6199844edh.6.1709570710006; Mon, 04 Mar
 2024 08:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20240303140643.81957-1-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240303140643.81957-1-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 16:44:58 +0000
Message-ID: <CAFEAcA_f2MJ4OxO+qyev+kUHMDoniT9P7seUYzsni-xeac1eTA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Add device STM32L4x5 RCC
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 3 Mar 2024 at 14:07, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> This patch adds the STM32L4x5 RCC (Reset and Clock Control) device and is=
 part
> of a series implementing the STM32L4x5 with a few peripherals.
>
> Due to the high number of lines, I tried to split the patch into several =
independent commits.
> Each commit compiles on its own but I had to add temporary workarounds in=
 intermediary commits to allow them to compile even if some functions are n=
ot used. However, they have been removed once the functions were used. Tell=
 me if this is ok or if I should remove them.
>
> Also, the tests are not very exhaustive for the moment. I have not found =
a way to test the clocks' frequency from the qtests, which limits severely =
the exhaustiveness of the tests.
>
> Thanks to Philippe Mathieu-Daud=C3=A9 and Luc Michel for guiding me towar=
d the hw/misc/bcm2835_cprman.c implementation and answering my questions ab=
out clock emulation in qemu !



Applied to target-arm.next, thanks.

-- PMM


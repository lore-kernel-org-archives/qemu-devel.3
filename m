Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FEEC3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJRg-0000dr-JI; Mon, 01 Jul 2024 12:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJRe-0000dS-Sl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:59:58 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJRd-0002NH-9u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:59:58 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ebe0a81dc8so42977681fa.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719849595; x=1720454395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvO4Fv+Y+DL5BbqEn9EVtgIlL4+merQC7QePoWopc20=;
 b=RsMt9P5BVvwvEguS5FL7BE1UdPVsO41B78NKzOaEQ6r0QttZyhkfuUbZZtADRNjwKJ
 96NJtbkisi3GLYLprADxl0pBrgvie8ixenUhZPIC9OxqjfS0AMyWWlTWTTA7seSq/7IX
 qfxLB0Def0mlj4dtJMbex35xxOhPAEyZEwj09lVtHcPpq+pfznoxfSjqcv/9V1uKusOk
 rrCwmav0i5m+Sp27xDe/8COnI0vOnMN7WaD/40bpKGFF3Hv5JeN7cn58l9E1TNXem5Vj
 oZ6lqxbulxmzyHojls3ocKvrK1Fp5RYHu/8gS6dDvFOtBvGkeZvKbdpLwcoP0RDz/TLU
 sAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849595; x=1720454395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvO4Fv+Y+DL5BbqEn9EVtgIlL4+merQC7QePoWopc20=;
 b=oFIaVpXzy9qrw2C8JW/gjfj6Hk1yNUB8+wJqUlbSqmTUlb1GF6VgTbsMfeut60OE8V
 tugWgFyGtE2PAe5ojhVv1UVWOqKUjG7keTkB27TO5H5NFkEzSXLWqBB7Bj2MRncy7NGO
 k8aZe06GSnbACOBEowgkZxDul2735jquwjtaDJVLlMkCStA07UbwVBfo5cZYFqlQ2YYv
 NKhEtg61YyHRsylBUd5zvFFVwf7vipxkjGzkjZQtBAzWQgJqRIk+KQDDmwgvufi3k4l4
 WfHJz7KoaKJeQ255nleCsssI71Pgg0Ue/PrKrbRZNarHnskMUK7cdd9VnU6lgWj1BiWs
 NIgg==
X-Gm-Message-State: AOJu0YzGDekIh38tz3L+uynfiInz3vmQWqI3Y6xA14BtPZahVhyTX7oh
 AEXgNveIlAvUllvVkXFEYs+47BGmbShksHFDbSGd9tQOSWjH/TVIbnmiI8ZLG850Y6LH78wQKO9
 /Tr3wZMoGMhVLv9SUgLNe3Gk/UmC9SIL6nqvNhQ==
X-Google-Smtp-Source: AGHT+IHL05crMW8tHklnYJ5dNn4VS4RHALKP++RnYqumXXDjTdZUM3lvg3oXx6uZRmF2nsCbHk9t1k31bwALER5B7RY=
X-Received: by 2002:a05:651c:3db:b0:2e9:768a:12b0 with SMTP id
 38308e7fff4ca-2ee5e6f78c3mr40161581fa.50.1719849594935; Mon, 01 Jul 2024
 08:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-8-philmd@linaro.org>
In-Reply-To: <20240628070216.92609-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 16:59:43 +0100
Message-ID: <CAFEAcA8i3A3Rs=sUkNsP4yOk3ie1V0e59KGDN0=JdbArgRNvgw@mail.gmail.com>
Subject: Re: [PATCH v42 07/98] hw/sd/sdcard: Send WRITE_PROT bits MSB first
 (CMD30)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Fri, 28 Jun 2024 at 08:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):
>
>   In the CMD line the Most Significant Bit is transmitted first.
>
> Use the stl_be_p() helper to store the value in big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
> RFC because I'm surprised this has been unnoticed for 17 years
> (commit a1bb27b1e9 "initial SD card emulation", April 2007).
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It looks like Linux never uses this command at all, which is
probably why we haven't noticed the issue.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


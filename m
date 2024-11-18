Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F32D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyiD-0004Ey-GK; Mon, 18 Nov 2024 05:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCyiC-0004Ef-Ak
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:10:28 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCyiA-0007w4-Ea
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:10:28 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fc968b3545so28037791fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731924624; x=1732529424; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MK7BOP7Ei1yKNKupjCO/INk13vv4sKScdgQxzbucQ/0=;
 b=RsCgZ2yic6ev0+v9Npa3VXtwoZjiP0jye2Y3UPvYXS7Iu06ENAgtUR3jJIA3X4S+bn
 4yV2iKTpHEnYYNWDktGv7M2IfezUIN6QH3gP7meGHKyiaxHe8S1wN/CsZo1rlH5+y6n0
 p3e9+T0PHqvQUtTe2MFLiLoUolIi6n8OplaW3Py1VZpVh2VRwVESwbWgvjrqDxbwNXIW
 1Pu4ACOHFGf7/biDFJ2qp5uTbZzSXfQvOJzy6Au5xJMGnK6Hes47A8iMepkdKY+XKeuC
 MEMqHmcIz6cLSzEtf5KFnrGdvl3fdk8xm8M446tl8MY477A1locen8WO+OeepHKQtFhj
 aouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731924624; x=1732529424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MK7BOP7Ei1yKNKupjCO/INk13vv4sKScdgQxzbucQ/0=;
 b=O4XXXnflhe9/3mEkJaWWCG5SVGbKPnWA31g2wiHxdezIG0/lCsZdw+9G/ZsF0m6AVL
 Xjoq0oYtpWc0ZSDlQLl8N+E5jYCxO0h1C5xUWLsw4UVWfyLD4os7xUP3h/JBwYHpYst2
 2KrWWC+/GjwRYpiyduggDsbFeKwKiEqutTL3Lh+hpZEBuBCjI/DehO8ptIG2cpTVpWQO
 Zhv6CsDtyHXdZmmOiqczDxfpmWEMC0Gny45vCFwVFBasBFFbeU/C0F5Zw8pEm47GrGdV
 fVKOeHBE+8k43Z/IxYCokydR1vkRsmHUKGRHFy2Xq7LQSpl4aI6Avccutjl9j/cl8iV3
 k1Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRqhn6X0B0GLEln/GTAZ/Qnl+g4G4I+zQJ8I8VppacEZnduaPEsDf6Iga5rjPQRWqkAlr9MWwUhXdg@nongnu.org
X-Gm-Message-State: AOJu0Yz/qL/yoV5vVoAMcQBLHZLKqzDD+g+Os8VCc51soA0XzmP8VOWV
 Y/qPU6LZKcZFUqr6LI31h90lKwIOmsDaoRB6JnS/0ZDpeNHGSvtQ/BY+3eItrAH2nTBkKSbYR6M
 YF7PIpmEwgE+P6KesG06pEXm1CYnvYm60Wmx2Tw==
X-Google-Smtp-Source: AGHT+IHrVhgkskSpxFt65Pt7fj/aC02b8HVwGjotDTndXt5bEoHUZvhJOi4tIZpO0+xZ30GtgQVrW7G8Loi4zaCj6/I=
X-Received: by 2002:a05:651c:98f:b0:2fb:5035:11da with SMTP id
 38308e7fff4ca-2ff6072531fmr60666931fa.33.1731924623733; Mon, 18 Nov 2024
 02:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20241118021820.4928-1-joel@jms.id.au>
In-Reply-To: <20241118021820.4928-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 10:10:12 +0000
Message-ID: <CAFEAcA9tPhbjnJ6XjMcZq6iWS4i1BdrTB+=391L5UgaVSMkCLQ@mail.gmail.com>
Subject: Re: [PATCH] hw/aspeed: Correct minimum access size for all models
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 BMC-SW@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Mon, 18 Nov 2024 at 02:19, Joel Stanley <joel@jms.id.au> wrote:
>
> Guest code was performing a byte load to the SCU MMIO region, leading to
> the guest code crashing (it should be using proper accessors, but
> that is not Qemu's bug). Hardware and the documentation[1] both agree that
> byte loads are okay, so change all of the aspeed devices to accept a
> minimum access size of 1.
>
> [1] See the 'ARM Address Space Mapping' table in the ASPEED docs. This
> is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
> ast2600 datasheets.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/fsi/aspeed_apb2opb.c  | 2 +-
>  hw/gpio/aspeed_gpio.c    | 4 ++--
>  hw/intc/aspeed_vic.c     | 2 +-
>  hw/misc/aspeed_scu.c     | 4 ++--
>  hw/misc/aspeed_sdmc.c    | 2 +-
>  hw/misc/aspeed_xdma.c    | 2 +-
>  hw/net/ftgmac100.c       | 4 ++--
>  hw/sd/aspeed_sdhci.c     | 2 +-
>  hw/timer/aspeed_timer.c  | 2 +-
>  hw/watchdog/wdt_aspeed.c | 2 +-
>  10 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
> index 0e2cc143f105..855dccf6094c 100644
> --- a/hw/fsi/aspeed_apb2opb.c
> +++ b/hw/fsi/aspeed_apb2opb.c
> @@ -259,7 +259,7 @@ static const struct MemoryRegionOps aspeed_apb2opb_ops = {
>      .read = fsi_aspeed_apb2opb_read,
>      .write = fsi_aspeed_apb2opb_write,
>      .valid.max_access_size = 4,
> -    .valid.min_access_size = 4,
> +    .valid.min_access_size = 1,
>      .impl.max_access_size = 4,
>      .impl.min_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,

Have you reviewed all the device read/write function
implementations for these devices to check whether
(a) changing the .valid value does the right thing, or
(b) whether there are cases where we should instead
be updating the implementation and setting the .impl
min access size ?

thanks
-- PMM


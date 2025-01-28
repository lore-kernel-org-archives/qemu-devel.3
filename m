Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90108C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmeh-0001i3-6i; Tue, 28 Jan 2025 09:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmef-0001gR-20
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:33:29 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmed-0004JT-8l
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:33:28 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso10048777276.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074806; x=1738679606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yBonQdWSAJdGgs1uTdENENUxX2xyohdOtyf/B381iQQ=;
 b=K9xb43AyoBcD+e6XH5IA8KzzZ1DKYnWcYstAIVLmje6f8O/m8rK7+qZtcW4IZzIuBQ
 Ltwons1MO37JGjWwuiCTxc0Zx51iWWk8iZTSLyTOnNWkn8AECeWXRyioQ+0tY8e+UH5S
 Q2TOfCIeaZA6cS7IPWJ9uwuSVa1aIhagP+/bETHzpTj7nJEMbnQytGExvkVwXgns+sLe
 bVq23/3KrAMMH/OP9Fgvm8HRLQfpOqwl8nUZvCPjbkDTY18CcMdbnKQDntw4pdeH1TVH
 yEV/2/FOcZRh95yGtOdjHoszcLgXzAOAbnd5hBuySOCE+N79bZUKDi4Fiey+7GlfV/rW
 1ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074806; x=1738679606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBonQdWSAJdGgs1uTdENENUxX2xyohdOtyf/B381iQQ=;
 b=sAnKgaue5Aw6eJprQp9LGXNi0JThuvhgDlA/dAdfnhr0e2VeiuwCdCeY7i6eTBPx59
 6StG+FuiCy1KMhuF/DQ602TrRuZQjmAIsXXpaA0VngELPxkoSabevHAtJ38NCiAZjl5D
 Hy3bVB+M9bWNLk/z1SZwtyrDLAX8AXJX4Qa0h+sfzgLJFHkkzBZmRNu9bpcOAYsa4i2l
 ZhcCgboBXYcWCm6/R7PnJK5udye/XnUC+3oE+PsA8pV+G3pXE/rDU96uU/QnUykJT4r0
 yebIIL/cP3n66zNOlJ+AZrdZmqPxZDYuy2/9esRIB//BvVXmV2PPn68lo5FtNi4VoN88
 jl6g==
X-Gm-Message-State: AOJu0YycPsGYv5Iy8WINZfPx7FE86SDBElJDNQLg8kZ7XFPWt6hvQtNO
 Q9XOHyamLPeorN6ImwyWq4moxRr5uOeV7EMiwKj767+LRXG7ifp4JmRJcrJBRaHt4oqtYVIS3m4
 r+zL8GrahSiWAWbyUm6ALHhKTECEjj1sf5zIfTA==
X-Gm-Gg: ASbGncsrt2Sw8Q2wlOfjlHkZIB0okVzevR9HtlHyJ5mh+NfuQJWzpd01o/cka2fT/yS
 FYA6jhsQQg1ifadNWE2XI3hSDZTzpCx7A5KgIfSI0YfTkTQUjT8rX1wt0TkwpHW+MySHuo02usQ
 ==
X-Google-Smtp-Source: AGHT+IHQElr4rr1qMCU9AUnLoiDmgATiArJdMCBlb6XNZGQvpo2KUZW2my4j+R6ikcs0Djuu2TuOQMl+FDfqVv5c9zM=
X-Received: by 2002:a05:6902:c09:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e57b1064482mr29044838276.18.1738074805987; Tue, 28 Jan 2025
 06:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-10-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-10-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:33:14 +0000
X-Gm-Features: AWEUYZny2nrgaLwmdeTrSwbgWY32uyfmH1C0zgj-b-gG36LlnfuW27Fun1d5xLA
Message-ID: <CAFEAcA9efWMDxaTCfa6t8MiCgFUEU+nsyurNOqVDxAa9=KS=-Q@mail.gmail.com>
Subject: Re: [PATCH 09/21] hw/arm/fsl-imx8mp: Add PCIe support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Linux checks for the PLLs in the PHY to be locked, so implement a model
> emulating that.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
> index 1514bc5864..8d48580cb4 100644
> --- a/docs/system/arm/imx8mp-evk.rst
> +++ b/docs/system/arm/imx8mp-evk.rst
> @@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
>   * Generic Interrupt Controller (GICv3)
>   * 4 UARTs
>   * 3 USDHC Storage Controllers
> + * 1 Designware PCI Express Controller
>   * Secure Non-Volatile Storage (SNVS) including an RTC
>   * Clock Tree
>
> @@ -62,3 +63,15 @@ Now that everything is prepared the newly built image can be run in the QEMU
>        -dtb imx8mp-evk-patched.dtb \
>        -append "root=/dev/mmcblk2p2" \
>        -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
> +
> +Using PCI Devices
> +-----------------
> +
> +The PCI Express controller spawns two PCI buses, of which only one can be used.
> +By default QEMU assigns the wrong bus, so the correct one has to be specified
> +manually by adding ``bus=dw-pcie``. For example, when adding an Intel e1000
> +network card, the command line looks like:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-aarch64 -M imximp-evk ... -device virtio-net-pci,bus=dw-pcie

Why does this happen? Isn't there some way to make QEMU default to
using the right bus? Otherwise there's likely to be a lot of
user confusion because PCI "doesn't work"...

thanks
-- PMM


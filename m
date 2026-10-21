Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B203606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dgrqDUa9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJSkD-0000mi-IW; Wed, 21 Oct 2026 05:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xJSk8-0000lj-GE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:36:20 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xJSk5-0006G0-Cr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:36:20 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0a28a720aso4779587b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792575375; cv=none;
 d=google.com; s=arc-20260327;
 b=sxUTfqw0GBA942hfAXpAR/gg3t9tyrbrfCN6Fi1vFdxZ9/DaDuO3Cjp5p5bIdhSjoG
 h0R/ex6JLNqMQqxGBohGAjqN6HJfHTSpSfmwe5od3TeUMCAelVHolTtkvnwFEF1zHnyU
 UUGMoPilL7lKXTwf582jSqCx+v0P/FVHDRVoz7QgbvoqKXOyHarWITfQOVWgjxmAaccC
 4Qe804xOVWskzVBbjSjtCIwHvbwSa9aquTqgJS13z9gRLsALUKGun2m1cZKa1nT0JrCO
 GgALKlYDl/vBQinRfxz89w8zmPvi0uAMVuDPH4kjLMjdoBEx5S8uGm04d+lPkDqYjYQE
 J+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0osC1y0GY2PfGebCDc0STpXZVu7DCU6L9/k8k4hX1nY=;
 fh=/ShXTWNqaHFvllhLZGkWx4O06YRB7Empo6DuRZKqKoM=;
 b=e3VKUV6iR4wE5/RN56GSqcqvlqc5au5BJPTE/J8GfDgfVDGFvmQIrYsVGNNg+iC+1I
 X/ToPO853bD4+NvVaAHe6B+OS4Nr8SCXhqisy3Cxgqtj1VD8nfQ2C3aImpJzaHEM7hL8
 8HTY68fAwQdg3SRojLMBicDXSKcf/Su4eXB7kr/hOWvD6sK+9419xmrJak/Fl7S7E+zo
 KLYt+74kvUhGdaObEiewcdPLDMFGRddq2gTZjqQoZkSLTFc3/uupgBf31fTmJYMiIVFK
 dxZziY///afLjkVNifO2jkiOtu8v4AHen/MUh4zURgqNnIWraaVb06ThlPm/ObwO/B41
 Z7+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792575375; x=1793180175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0osC1y0GY2PfGebCDc0STpXZVu7DCU6L9/k8k4hX1nY=;
 b=dgrqDUa99pDLK3NGpkqlRQs6Jty+2q4r+yMgV9R5ZtTpXe3ouzKpH35NDhpfrG9DW5
 COl6ynEan4uXeVkr0/1s7Ae1FLzyZ6si6KXpY8TuKdD/oOu1RiHZ4fTvLdl39ZYwkjJe
 m1Mfh8YVPFln/ztmb6OdcB+Py3+0K7HQ++FJnuqM83y4NTh8Uuv4K/MhHlE+GEaWM7r2
 /DrNRXOLXhZcnaObnlFqOGZihJy9my3W1RWnr2GGSxbqsD0OewerkKhcildLzoaZViDt
 DPvTEKG3Tge5lbmlTDVOXfouNhKv99Uj2JoC38LMBz1fLihR2mqBchDZi+DOUb+IEDHv
 cdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575375; x=1793180175;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0osC1y0GY2PfGebCDc0STpXZVu7DCU6L9/k8k4hX1nY=;
 b=WkUaDfEFEY+eIEJLcwPPCk4iD/x/VDVSWQ4mUPptqDf2z5WwqzXqhkB3GQUZpKqnJX
 qAh84EI3OG4Q+PdEgYcHMfxXdcl/xaOxlWYwjIgi9cxnlkNvd4ouai7CwhZy07Oi9a3Y
 A5ARSW1i3qmY3xbRRgMLA7WtQCkbmTwnHt/FZ+sXHFaS/WNGo21Z8U9hvaAFBpjoJbjA
 1V0RK+Ymhjnp1poVrr0iNFUYH1xaOMjkgnjwxbesz20ejgv81v7vyxjsM6E1Nfy8a376
 3/Hfu1zA0JiPEjaeDnNJB+3WvdcCkM4YcIIg9gjtK7MJ/JHswz4pOJuLeXAz21O4kj5J
 I0yg==
X-Gm-Message-State: AFq9FYKmhUVCsPPwPsFXUGuVihUqu6CtJKP1mzC1sFxUsD7lYCTareE0
 nxbvNi+HB6yPg4K+6Wh3GQ1pf1HZVRCULUNnMagm7ycePWy6GfLoJABYC5gnGmnV5Wsv6I8Nqf2
 QtqjBafaQAbXOjhob+QXCFpH1qTSJBF8=
X-Gm-Gg: AYBFou2590bT8Hq+iI9+lhdP4Qca9QYZm/1krW2hw9t6ms5IRgadQnlLTl9/0UFg4uU
 2sVpAQzWqKeQRrNbL51fGB7X9kNC0JbBQa+KNBq3FQ7sHKO9bKkgcyTqM/1tx/1j8sXf5iB15Y0
 oS+n/U/0JQBVzwtAriS2PMYfq91HSAhzy18zB/YZTjLHcqVykBm8rm9Ir7ctLA17C9OTXh3acHM
 2PTGWpEM+Ep6tOPDQTlMVUk2PC7Mg7nrABtwPpJ55bm8rC7tT58zI+v4giP9kdnM4d+B30NDDgJ
 mWRLqDoYIMJMEjE2FDX2k84B+sGEV3WQtf/mwpAQl5LFlBp/7Sp9N7skwjohe3Z6zUtUXPwDjUZ
 7ynHkSAbedt8GXIpS9+sj1vx3eaZidMgVJM5zIa5YKqd4ATg5dRl0H28V66DXMOGAInsbfcSrY7
 a6ytW334xM3/tK8CVIfs0=
X-Received: by 2002:a05:690c:e1c4:20b0:8b1:9c2:87d6 with SMTP id
 00721157ae682-8b133e4a8d1mr4988887b3.17.1792575375375; Wed, 21 Oct 2026
 02:36:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014012323.322790-1-bin.meng@processmission.com>
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 21 Oct 2026 17:36:02 +0800
X-Gm-Features: AclHuK9JtP5Y1mbTTftwyHmrDTrRyPLvJfGqAGzJ680MeJpCOHJ2ZVE-5-4ap3I
Message-ID: <CAEUhbmWVuSF9KicCjd1fyFycgR7sLErsW7x_wk4HO0ZJPtwquQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] hw/riscv: Restore Microchip PolarFire SoC Icicle
 Kit firmware boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Thomas Huth <th.huth@posteo.eu>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 9:23=E2=80=AFAM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
> The microchip-icicle-kit machine was originally validated with an older
> Hart Software Services (HSS) firmware stack. HSS v2026.04.1 cannot boot
> through U-Boot to Linux because several firmware-visible parts of the
> PolarFire SoC are missing or incomplete.
>
> The first failure occurs before the UART is initialized because the L2
> zero window is not mapped. HSS then needs additional L2 cache controller
> and DDR training behavior. Later boot stages exercise system services,
> the RTC, SDHC version 4 DMA, and high-capacity SD card block sizing,
> along with the complete DDR aliases. The existing models ither reject
> these accesses or expose behavior that does not match the hardware
> specifications.
>
> This series restores the complete firmware boot flow. With these
> changes, QEMU boots the HSS v2026.04.1 eNVM image, loads its U-Boot
> payload from an SD card, and reaches the Buildroot 2026.05 Linux
> login prompt.
>
> The changes are organized around the firmware boot sequence:
>
> * Correct the L2-LIM size, map the L2 zero window, and provide the DMC
>   status transitions required by HSS DDR initialization.
> * Model the documented L2CC Config, WayEnable, and WayMask registers,
>   and resize L2-LIM as cache ways are enabled.
> * Complete SDHCI version 4 support used by the Cadence controller,
>   including Host Control 2, SDMA system addressing, 64-bit ADMA2
>   descriptors, and SDMA boundary continuation.
> * Run ADMA from a bounded timer-driven engine instead of performing work
>   from command or unrelated MMIO accesses.  This keeps DMA progress
>   independent of guest register traffic and avoids consuming a polling
>   deadline inside the command write.
> * Keep SDHC and SDXC memory transfers at their fixed 512-byte block
>   size, and advertise the Cadence controller's 64-bit system bus
>   support.
> * Add the PolarFire SoC serial-number system service and RTC, and honor
>   the system-service notification control bit.
> * Correct the DDR aliases and fix the board topology at its physical
>   configuration of 2 GiB of RAM and five harts.
> * Document direct and HSS boot, add focused qtests and a full firmware
>   functional test, and restore the machine's Supported maintainer
>   status.
>
> Testing performed:
>
> * Built qemu-system-riscv64 and the documentation.
> * Passed various newly added qtests.
> * Booted HSS v2026.04.1, U-Boot, and Buildroot 2026.05 Linux to
>   the login prompt using the functional-test image.
>
> The functional test uses the processmission/qemu-machine-images release
> v1.1.1 tarball:
>
> https://github.com/processmission/qemu-machine-images/releases/download/
> v1.1.1/riscv64-microchip-icicle-kit-v1.1.1.tar.zst
>
> When restoring the HSS boot support, 3 potential bugs were identified in
> the upstream HSS source codes that either blocks the DDR training from
> succeed or traps in a multi-core race at the very beginning or after
> a succesfully DDR training but stuck at OpenSBI/U-Boot hand-off. There
> are already bug reports filed aginst various upstream projects.
>
> Changes in v4:
> - Drop the unused ADMA callback forward declaration
> - Move helper definitions before the data-transfer declaration
> - Merge the ADMA timer callback and batch routine
> - Use HSS v2026.04.1 and the v1.1.1 test-image recipe
> - Select the SoftConsole toolchain explicitly
> - Use the generated complete boot-mode-1 eNVM binary
> - Use the v1.1.1 test images with HSS v2026.04.1
> - Add the execution bit to the python script
> - Collect Conor Dooley's Tested-by for the complete series
> - Collect Bernhard Beschow's Tested-by for the ADMA patch
>

Ping for review?


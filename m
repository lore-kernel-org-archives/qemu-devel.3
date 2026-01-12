Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266F5C9EC6F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFe2-0000Wl-Ep; Mon, 12 Jan 2026 05:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfFe1-0000WS-6N
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:59:33 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfFdz-0005kb-Ev
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:59:32 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so10299724a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768215569; x=1768820369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48x7qwovVElWvGwBKSnaneaSLyUnOvpL9gAGm+M9ITM=;
 b=kJr14gzFz1SdiqwuedkCqWuJqVgWHD9mbUU+lJN8+2cpwTdvdEI4y8yTqD7vJ4DEMk
 l9Ys095jHivFgQ7WV3apWCWaKCZIqzwLNcIBLzvbq5SZElsfgkzmR7ZDK6GIg3RpBpxE
 DGbuRRy+oItECqXNIaZM31Y6dbC/KpqbKcGu1XPk560H+KkrFJdqPQJyZU/Wp1RK5a8a
 gtAitskFGyBpT1hy7GUGfltGWJ5jgAI4gA7BqzL5GfxWAZLzAU3Yqg3dwB0MYMrILBSq
 1i8qxPXacemvc2FqYUcj4KV6pkMQXiCEwrgz6ynhJQ8l/RIhhm7nupZ3NyEypFCn+ehc
 suSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768215569; x=1768820369;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=48x7qwovVElWvGwBKSnaneaSLyUnOvpL9gAGm+M9ITM=;
 b=eaFfwvE97Lxqv5QIVCsstnWKbeN8PuWMMyYhelmgKt5DaRg+HA7N3bT5s4MXUPodpR
 Ip3tjiuZsb+6Hh94AXNKSyqAbrnfBBQugfBW8HNCAH9lMcFBz3bDHUO0OIOldtaO/GBK
 J1aa0u46Mm7AVMxKMwo82ePRsZi7WUw+KbpJ4bCdCB5iYD7ww70joeBmkb941ZMXmw+L
 4AN4PcFIZk/44OI9rEszx51NgLihVVeLFH3vojQX67R462oe/LZsWO0fYgCTKZ4nw0Dg
 bsKChQpd4hiXNpits7sy8bTMyGwxS8Ytx4rZ7A5scSizz6/5VnfRpEtjT86CqA7oh2Ff
 OEsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0WaALNIEvTeukhbiY2E+Wbf7HRviE/Cf1kJARMRPb6CPyC7tE4aQ6tM10IJRvM8nH3CerJtcI/wtQ@nongnu.org
X-Gm-Message-State: AOJu0YyaEcg1c/uC/vkSbUCnpBGlCaLSE3BrsAF2/o3Ppar3PUco51on
 SOEnE4TJ2DivHrmZrctn3hNJ1QvKx7onmsiBMeqN+M4hCeSL4YNjDhZybE8LpQ==
X-Gm-Gg: AY/fxX66HWshGlfdQcpI5z8J1+LSDt3OP3uUhw8Njnm74oBeRK9llGpYQAozR3l1T9v
 YuwOZ215lXaAqjWP+x2fOa4rm9WEM6L29BYTzOwOVAhk128V4wtoXF4bVmHjtM89NrG9hEDIflL
 0NW1IM3oxq8MlJeECZMaUanI0MQkC92MCJfA1GPFK3JbjGnCBlSqUwl2J/RYTAMsVheabA/5jLD
 q58T2gyiI/8/Gjaq9bjM92MZJd2pXc/4RmzApwDHLlIGn3zxKt+iSdhvvuk+sBcHPUmGc1VPAHy
 i77bhfqEoNxrImsuSpD9WdjzSFiBLH3hW5GSI+K8BJiam2AxtTuvpac2XKiNMohV/1b5nH8oR0R
 0kR+jdEfESeSvKajyZtR+ibT2PnAITevKN/xmC/X2P5Yd1fDFseSUAt+KzXCAe6Buv+Vozi+qN8
 9GNTWOGBHmirI+d82t8FK276OJINRH+UJO9YZbM0FM7h1LVT/U5oeBVZudnXAjZCF4sit+aXGnO
 OLypLw9gpjJAOMYC3AN2jeU75AqkbZ/VBw=
X-Google-Smtp-Source: AGHT+IHLxMIAeTy9gVhPLhiaWBPuqwifAscuizvPVCTscYRhDY1UFMYDs9bBmqnKhWpTtFe5v+ZUIw==
X-Received: by 2002:a05:6402:2683:b0:64b:62f7:c897 with SMTP id
 4fb4d7f45d1cf-65097de7c13mr15498266a12.5.1768215569434; 
 Mon, 12 Jan 2026 02:59:29 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-299b-b200-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:299b:b200:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be658b3sm17078236a12.18.2026.01.12.02.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:59:29 -0800 (PST)
Date: Mon, 12 Jan 2026 10:37:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCHv4_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <AM9PR04MB84870CEFAFB934E3458CD0768786A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <AM9PR04MB8487B6CDD04406F5EF2F8F1687A9A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB84870CEFAFB934E3458CD0768786A@AM9PR04MB8487.eurprd04.prod.outlook.com>
Message-ID: <755AFD3B-F733-466D-B623-246FA3FC78B9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 5=2E Januar 2026 12:43:38 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>Ping

Hi Gurav!

I've somehow missed your new iteration so far=2E Anyway, I've left some R-=
b's as well as some comments mostly regarding further consolidation with im=
x8mp-evk which should ease maintenance in the future=2E

Thanks for your great work!

Best regards,
Bernhard

>
>> -----Original Message-----
>> From: Gaurav Sharma
>> Sent: 19 December 2025 10:37
>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eor=
g
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> Subject: RE: [PATCHv4 00/15] Adding comprehensive support for i=2EMX8MM
>> EVK board
>>=20
>> ping
>>=20
>> > -----Original Message-----
>> > From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> > Sent: 05 December 2025 11:08
>> > To: qemu-devel@nongnu=2Eorg
>> > Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Gaurav Sharm=
a
>> > <gaurav=2Esharma_7@nxp=2Ecom>
>> > Subject: [PATCHv4 00/15] Adding comprehensive support for i=2EMX8MM E=
VK
>> > board
>> >
>> > Changes in v4:
>> > - Update Maintainers file
>> > - Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a varian=
t
>> >   specific property
>> > - Split up the patch that enabled CCM and Analog in the previous
>> >   revision=2E Now we have 3 patches to enable CCM and Analog in iMX8M=
M
>> > - Updated copyrights
>> > - Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
>> > failures
>> >
>> > Changes in v3:
>> > - Minor documentation change - Added KVM Acceleration section in
>> > docs/system/arm/imx8mm-evk=2Erst
>> >
>> > Changes in v2:
>> > - Fixed the DTB offset in functional testing script test_imx8mm_evk=
=2Epy
>> >   and preserved alphabetical order of machine names in
>> > tests/functional/aarch64/meson=2Ebuild
>> > - Fixed a typo and updated the documentation
>> > - Modified structures type to static const in fsl-imx8mm=2Ec wherever
>> >   applicable=2E
>> > - Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk=
=2Ec=2E
>> > This
>> >   is needed because the default DTB in the iMX LF BSP images have CSI
>> >   and DSI enabled=2E Developers/Hobbyists using these BSP images will
>> >   observe CSI and DSI crash logs on the console since these are
>> > unimplemented=2E
>> >   With this change, both debian and iMX LF images will boot up withou=
t
>> > any issues=2E
>> >
>> > Changes in v1:
>> >
>> > This patch series adds support for the NXP i=2EMX8MM EVK (Evaluation
>> > Kit) board to QEMU, enabling emulation of this ARM Cortex-A53 based
>> > development platform=2E
>> >
>> > The series includes:
>> >
>> > 1=2E Core peripheral support (CCM clock controller, Analog module) 2=
=2E
>> > GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
>> > 3=2E GPIO,I2C,SPI,USDHC and USB Emulation support 4=2E PCIe and ENET
>> > Controller Emulation support 5=2E Documentation and functional test
>> > included
>> >
>> > Key features ported:
>> > - Basic boot support with Linux
>> > - UART console for serial communication
>> > - Interrupt handling
>> > - Clock and power management infrastructure
>> >
>> > Testing:
>> > - Linux kernel boots to console
>> >
>> > Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >
>> > Gaurav Sharma (15):
>> >   hw/arm: Add the i=2EMX 8MM EVK(Evaluation Kit) board
>> >   hw/misc/imx8mp_analog: Add property to analog device
>> >   hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
>> >   hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
>> >   hw/arm/fsl-imx8mm: Implemented support for SNVS
>> >   hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>> >   hw/arm/fsl-imx8mm: Add PCIe support
>> >   hw/arm/fsl-imx8mm: Add GPIO controllers
>> >   hw/arm/fsl-imx8mm: Adding support for I2C emulation
>> >   hw/arm/fsl-imx8mm: Adding support for SPI controller
>> >   hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>> >   hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>> >   hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>> >   hw/arm/fsl-imx8mm: Adding support for USB controller
>> >   hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
>> >
>> >  MAINTAINERS                                 |  10 +
>> >  docs/system/arm/imx8mm-evk=2Erst              |  79 +++
>> >  docs/system/target-arm=2Erst                  |   1 +
>> >  hw/arm/Kconfig                              |  24 +
>> >  hw/arm/fsl-imx8mm=2Ec                         | 692 ++++++++++++++++=
++++
>> >  hw/arm/imx8mm-evk=2Ec                         | 128 ++++
>> >  hw/arm/meson=2Ebuild                          |   2 +
>> >  hw/misc/imx8mp_analog=2Ec                     |  12 +-
>> >  hw/timer/imx_gpt=2Ec                          |  26 +
>> >  include/hw/arm/fsl-imx8mm=2Eh                 | 241 +++++++
>> >  include/hw/misc/imx8mp_analog=2Eh             |   3 +
>> >  include/hw/timer/imx_gpt=2Eh                  |   2 +
>> >  tests/functional/aarch64/meson=2Ebuild        |   2 +
>> >  tests/functional/aarch64/test_imx8mm_evk=2Epy |  67 ++
>> >  14 files changed, 1288 insertions(+), 1 deletion(-)  create mode
>> > 100644 docs/system/arm/imx8mm-evk=2Erst  create mode 100644 hw/arm/fs=
l-
>> > imx8mm=2Ec  create mode 100644 hw/arm/imx8mm-evk=2Ec  create mode
>> 100644
>> > include/hw/arm/fsl-imx8mm=2Eh  create mode 100755
>> > tests/functional/aarch64/test_imx8mm_evk=2Epy
>> >
>> > --
>> > 2=2E34=2E1
>
>


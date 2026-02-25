Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2204FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMSQ-0007xb-Ae; Wed, 25 Feb 2026 16:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvMSO-0007xJ-Jy
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:30:08 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvMSM-0002oS-1c
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:30:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4398dd671daso174552f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772055003; x=1772659803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwyDepRMsFhbikBTmgSiHJuLJakYpzEzEKPdMq89NHw=;
 b=Qw6AYZyCBWPMgaMcFtIIbHrbD7OHP+tHjamyTjEjX5Xh4yi0bBKhGEmB77EGFCJEvv
 y7Ym88qH7d9BIdwkqhd1Wkr5AHsVx46DkIFhB/IL2nuJFMSYAy8g22GWypWpY9J4BkGn
 PiJO3C4oW14u7NLa7NASZwJ2q2dbaY8zEjDD4YocIAojdkNWRg+TIVVIffplhtMtW3zb
 qMm2YJTQNxUnx9r9ewTQw8REMZcEVSB5JiGHpnzjgmMFZQcCT1ek9CSM/Xwkrfco2bL7
 DJhGrOoKPPWgoKOqZhTn8PhnMzdVx2oTkZHwgHYJiFkcCfa7LZoNu1HO69JI2zbUWz3+
 Ae6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055003; x=1772659803;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwyDepRMsFhbikBTmgSiHJuLJakYpzEzEKPdMq89NHw=;
 b=FxsyURU9TbBWNhg5GBknOwhk8u6qltGyYuLtVWQlPUBzOZ6tvFTg7GvNHIz5JCuCec
 s1aV5V169j+mkAz/shZp6JznKo7J6hfW2c4jQw8YoNurEvzSg1Av3eK4vTAin/zZK3jF
 65wI9hb8s3+ls4atuWnIL2G1brdcd7iW9SrzA4QA3yLZw6h+quyVsl7h2u9eQUJdrPWa
 WnDbuaKCxubx8mgsYOQlDh91IYNhpF9nsNtNBolrLusHBEYUhq4PHi7sNK4M0a25E+5v
 UJTDLeGiA9oi3kNs4DLOg0kYc/JI0oJyISY1RlslAQDcb1ikLRQ7ehp+rTTZLFBVU3CY
 axEg==
X-Gm-Message-State: AOJu0Yy5IZCdHjcC3yk68r+FHWpQhHHcewPAHM8kXpQ2lmgsizlY4B0N
 uGlfPqVCh9GFcjGoHh40t0pAtJ2tmECFTHYwQRyxLVUhwrbpdqiA/v2a/6r0vA==
X-Gm-Gg: ATEYQzxDtUDu6sPy3lBPCy+ixwzYs/9pAMOnzTtaTSQoeTLrbsT31eytTrwlf19VRgt
 FvCYZT1Z0Cmr6MzqTXpltcA0Bmwao6xuGCjHnm+DvDYG8BDdq+jmQcwumJk+tAwrhKl6EEjCxyv
 azcbnohLPDmha5LnX59JfPsqPeeV5mdlV9m8eTbYgGq27WSowzDq7qkkC4uPfk+rv0Fn+0tx8SS
 kRoSDTqs/X//lmOFpOOhOw7Q2SUhZqU2URR+66p3tGxnlLHuUJU4uB6UM3fMWuLYxyqaPflOD33
 EC7XbkrllBlX4QiKaUe4iZh8doyZ2/EBz3+jlyJhUweS6E2MfZ9yLVDiMh50cS9bqCFCOgZUBay
 3CpztwmFRJP7BqUFu9u1j/bxZ2snLH052J1YWuDE7Qeyc1gnSWP5JjDrixT23cV7JtwbnDSe6E9
 899POzQDSR06pUqleeTklyV7BfZBxia1LSZx4hqUfzfeGai8YPWQEzpxwUQTrcSD6rYu2A5nKYs
 9XV9rapuNUbkcXjiAv6LHys1MZ/kHL/A6YMGNCOfh1pxYQ=
X-Received: by 2002:a05:6000:184e:b0:437:65ff:e83 with SMTP id
 ffacd0b85a97d-43997eeac99mr114513f8f.20.1772055002544; 
 Wed, 25 Feb 2026 13:30:02 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-246b-1a00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:246b:1a00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm35817389f8f.26.2026.02.25.13.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:30:02 -0800 (PST)
Date: Wed, 25 Feb 2026 21:30:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv4_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
Message-ID: <DCE00F5D-4732-4F89-9254-092B8484603E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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



Am 5=2E Dezember 2025 05:38:04 UTC schrieb Gaurav Sharma <gaurav=2Esharma_=
7@nxp=2Ecom>:
>Changes in v4:
>- Update Maintainers file
>- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
>  specific property
>- Split up the patch that enabled CCM and Analog in the previous
>  revision=2E Now we have 3 patches to enable CCM and Analog in iMX8MM
>- Updated copyrights
>- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check' failures

With the changes as discussed under patch 1: Series:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Changes in v3:
>- Minor documentation change - Added KVM Acceleration section in docs/sys=
tem/arm/imx8mm-evk=2Erst
>
>Changes in v2:
>- Fixed the DTB offset in functional testing script test_imx8mm_evk=2Epy
>  and preserved alphabetical order of machine names in tests/functional/a=
arch64/meson=2Ebuild
>- Fixed a typo and updated the documentation
>- Modified structures type to static const in fsl-imx8mm=2Ec wherever
>  applicable=2E
>- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk=2Ec=
=2E This
>  is needed because the default DTB in the iMX LF BSP images have CSI
>  and DSI enabled=2E Developers/Hobbyists using these BSP images will
>  observe CSI and DSI crash logs on the console since these are unimpleme=
nted=2E
>  With this change, both debian and iMX LF images will boot up without an=
y issues=2E
>
>Changes in v1:
>
>This patch series adds support for the NXP i=2EMX8MM EVK (Evaluation Kit)
>board to QEMU, enabling emulation of this ARM Cortex-A53 based developmen=
t
>platform=2E
>
>The series includes:
>
>1=2E Core peripheral support (CCM clock controller, Analog module)
>2=2E GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
>3=2E GPIO,I2C,SPI,USDHC and USB Emulation support
>4=2E PCIe and ENET Controller Emulation support
>5=2E Documentation and functional test included
>
>Key features ported:
>- Basic boot support with Linux
>- UART console for serial communication
>- Interrupt handling
>- Clock and power management infrastructure
>
>Testing:
>- Linux kernel boots to console
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>
>Gaurav Sharma (15):
>  hw/arm: Add the i=2EMX 8MM EVK(Evaluation Kit) board
>  hw/misc/imx8mp_analog: Add property to analog device
>  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
>  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
>  hw/arm/fsl-imx8mm: Implemented support for SNVS
>  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>  hw/arm/fsl-imx8mm: Add PCIe support
>  hw/arm/fsl-imx8mm: Add GPIO controllers
>  hw/arm/fsl-imx8mm: Adding support for I2C emulation
>  hw/arm/fsl-imx8mm: Adding support for SPI controller
>  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>  hw/arm/fsl-imx8mm: Adding support for USB controller
>  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
>
> MAINTAINERS                                 |  10 +
> docs/system/arm/imx8mm-evk=2Erst              |  79 +++
> docs/system/target-arm=2Erst                  |   1 +
> hw/arm/Kconfig                              |  24 +
> hw/arm/fsl-imx8mm=2Ec                         | 692 ++++++++++++++++++++
> hw/arm/imx8mm-evk=2Ec                         | 128 ++++
> hw/arm/meson=2Ebuild                          |   2 +
> hw/misc/imx8mp_analog=2Ec                     |  12 +-
> hw/timer/imx_gpt=2Ec                          |  26 +
> include/hw/arm/fsl-imx8mm=2Eh                 | 241 +++++++
> include/hw/misc/imx8mp_analog=2Eh             |   3 +
> include/hw/timer/imx_gpt=2Eh                  |   2 +
> tests/functional/aarch64/meson=2Ebuild        |   2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy |  67 ++
> 14 files changed, 1288 insertions(+), 1 deletion(-)
> create mode 100644 docs/system/arm/imx8mm-evk=2Erst
> create mode 100644 hw/arm/fsl-imx8mm=2Ec
> create mode 100644 hw/arm/imx8mm-evk=2Ec
> create mode 100644 include/hw/arm/fsl-imx8mm=2Eh
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>


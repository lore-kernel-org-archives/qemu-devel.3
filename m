Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C10F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdYR-0006Ob-IX; Tue, 14 Apr 2026 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCdYO-0006OB-SX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:11:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCdYN-0005d6-78
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:11:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488d2079582so50624365e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776172301; x=1776777101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qcx+Vf7JRe6MxL+PiQzcxxKPVeUUmreyhh2uqlASiBg=;
 b=Lz2njnW2oS2aJ64hWHyqnycKAJUGWdXdHqnWMjAuT5xJH2NnfZKT24R90LNy7XWZCM
 sdPPy7d2ryLVua9YHYNOWhn8IIzp9co0bDnXYYcvbnkVJ/wndfaTqS+AG+uVj+f/5kLT
 TMicoHuRmJENWG6pZqlOP+z91ye0kFM3rS7Gy5d3qsjwzNCLsv6pMOvCOhLcjhlyYxca
 UW4fpayHR+nfkDtMDGb3KeuzvjSf3xHO0/YEnjCOwtpUyeBYpQwEknKe8ur3frq2m596
 KLRoS4qZPkCE6Fk2wM0pK6q4Z1K+1MEIf4+z7AaeEbWWClYacYDLR/R5zcr9hjSINDvP
 FWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776172301; x=1776777101;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qcx+Vf7JRe6MxL+PiQzcxxKPVeUUmreyhh2uqlASiBg=;
 b=T2BjwViS2uQMsRSYS2WiR7l3KvgnQa/1VZN29AUMUU5sVGjHyfHof4v6FPxFO/r07V
 lvt2jXsyHT5DQzDmb47FJFkdU/5DWtoi47OTrZKHkIfgD9z4M0uREY8uA8+4NF9eXvxO
 w9jpEmmpZMN/yIcS8mq0AfUHZ1jFlgqShRNFu40aAKdVzvc76r+AGNwIQlYVKpZPbXf2
 lD8jE0OAW5ouGexh9e8Vj78ZlAjED7VzAYE2dGV/6DCYvjOnN0lIDgczfbpIxo4Z39ng
 ST0SlMbu8T8ZiKUPBLxia61CBUp9xrUWMDXRoHbwVCk1/o7BAkx0XvUoRBLn5deDDgdn
 tE5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rQ9/qyU7wk74psR+WJxHJFO5UYdMVAlfOlBhlWbZiwLirmPICxFBw/eOUPcrGmrxZHdJfXx+nyTkt@nongnu.org
X-Gm-Message-State: AOJu0YwK1PIM+H/eMBOzsfiRiOHhdIY546SSY8YShLKvagEKpxeS9jS6
 vDU784dwGpPrwQP42hHYn/f+0MeWpnr/MIw7xzG6aTv/1z+GBSRgdLAI
X-Gm-Gg: AeBDievlvLIbyH24fz4RQOq/66jUTNbl9/PJkBN7TL9CMTvos0a5j8++g8pQ0sCRkF/
 oBjuzkQb+bGKkDJVDflIWt7/uoynv/WGFxRzXrxkOBIYoe+j7fhHg/9Ap1/N0qUwBcr6TrEjkqt
 9T4pHlh7W3y0wRBWgN2IHJ9h1qjcdAw2rN+rxalUjk151yU3nQG5c8VHO2NyO812K7juMQkEGqr
 bv6gINXlhDwpfzQkK2heh2b4YYHAIKeUWH90nzNKGK5UXs2yCOouvu05TEDpNb4JPCRKGW3dLbM
 lqo/T5In/7fuK4qGYS9AmVvicswVil5JwqyxIX2hJ1r9m2+HpIMhUA/0d3ajTMHclIp2SGcgZYC
 VJZgN+ny3paTyNhvxY7fHadN8LmldknZ/fpcLHsAqmjOvA9fwh/JyiopPINyWxAl5eG6oapRDDZ
 4PNZXuHS4qTCOUw++qg0F1aiMh7OAy9oSBdJQr8IfQ/op/+qniE6GFsDY7PRh+s+o8zgXwfGh5v
 CmlauUBkZDkmePbyU8j
X-Received: by 2002:a05:600c:c117:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-488d67e370bmr164153255e9.9.1776172300717; 
 Tue, 14 Apr 2026 06:11:40 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d762decf6sm29695585f8f.8.2026.04.14.06.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:11:40 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:11:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv5_00/15=5D_Adding_comprehe?=
 =?US-ASCII?Q?nsive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
References: <20260414053715.1378021-1-gaurav.sharma_7@nxp.com>
Message-ID: <5D98050B-ADB5-4481-80BA-88F07EC88876@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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



Am 14=2E April 2026 05:37:00 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>Changes in v5:
>- Fixed SoC object reference counting by using object_new_with_props()
>  instead of object_new() + object_property_add_child()
>- Merged imx8mm-evk=2Erst documentation into imx8mp-evk=2Erst to avoid
>  duplication and updated the title accordingly
>- Added on-chip RAM (OCRAM) support to match iMX8MP dev

With my comments addressed/fixed:

Series:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Changes in v4:
>- Update Maintainers file
>- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
>  specific property
>- Split up the patch that enabled CCM and Analog in the previous
>  revision=2E Now we have 3 patches to enable CCM and Analog in iMX8MM
>- Updated copyrights
>- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check' failures
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
>Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>=20
>
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
> docs/system/arm/imx8mp-evk=2Erst              |  33 +-
> docs/system/target-arm=2Erst                  |   1 +
> hw/arm/Kconfig                              |  24 +
> hw/arm/fsl-imx8mm=2Ec                         | 704 ++++++++++++++++++++
> hw/arm/imx8mm-evk=2Ec                         | 130 ++++
> hw/arm/meson=2Ebuild                          |   2 +
> hw/misc/imx8mp_analog=2Ec                     |  12 +-
> hw/timer/imx_gpt=2Ec                          |  26 +
> include/hw/arm/fsl-imx8mm=2Eh                 | 242 +++++++
> include/hw/misc/imx8mp_analog=2Eh             |   3 +
> include/hw/timer/imx_gpt=2Eh                  |   2 +
> tests/functional/aarch64/meson=2Ebuild        |   2 +
> tests/functional/aarch64/test_imx8mm_evk=2Epy |  67 ++
> 14 files changed, 1251 insertions(+), 7 deletions(-)
> create mode 100644 hw/arm/fsl-imx8mm=2Ec
> create mode 100644 hw/arm/imx8mm-evk=2Ec
> create mode 100644 include/hw/arm/fsl-imx8mm=2Eh
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk=2Epy
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB309F531CF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOE9-0005uc-SO; Mon, 13 Apr 2026 16:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCOE7-0005t7-RV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:49:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCOE5-0007JH-O5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:49:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so1488802f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776113384; x=1776718184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0lpLGWEf3jcupvQE27VyWyLYYCpebeHdQNrRxPS3Pc=;
 b=f6NJJ4QiOlfh7Eapsk0fNTuOWUDc/EugDwcnlrQFSRv19XMu63Xr6v93w3oorjRMty
 cl+abp2wpuUxLBwlpn029cibIxXdurXFsgxrxhZixUarZF8Zl3SKGDtlYFWADvm1Gpdp
 XT+oVEkZTeuAEDrzLP/09xXg0bq6VyfypbcdotICA1n7WNzBs/QNcpCyulBfbyRbaSS3
 3k39LXpdAgVzbv/uDOs1T6eXJYzHYPZQGldsHHuVWz+DvB/qNKMtiz22mj0qmqJP9eGu
 2t5/0/4eL5hlTwbohZjXXxNNBfWUP20z0lFK64Fi6WFGUC0QVui8AegRIsAdMA8BV3qx
 2WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776113384; x=1776718184;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0lpLGWEf3jcupvQE27VyWyLYYCpebeHdQNrRxPS3Pc=;
 b=iuGFp62qIJjbeNlDKGc3c381PMfOMzPopn4tz+qDSl1h7Ke0a/KW1/4u0vSDTrwgRN
 h1FOaP6BoK1BJTO/2ChIq+/b7nVLdqCVmcOQTHOjmj+M8UweDmX09UCGTsxdOiknYq+Z
 PhRIONSeACv1k52dZLdodqcrPvTBWp+DDd+ncqFf1MSEgiSDQwzEeX4xY2vbKmxkn5X/
 0kV0BFnZnJm9aX31MyOs0jpuuH2Wsj0v2fjyfsPEWY9uwxY6ItWdNKyST0N7qdzPsH8u
 e/vuanlSlkNkGKUGYFnhDEs4M/Ll6KKqzC5rg2DKpz7cqyzV9ZBuqVBNwq3Tz9M/HeMs
 QNXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83io8+GcuFQPVtNKoW6Gfyz80+ATjuUeNeTQB138Togyal3HxeJYLjexkxuULw9mgGkAhAxD1COv9c@nongnu.org
X-Gm-Message-State: AOJu0YwkaJk72AIE34IZx4TEKcqQwtUlpGA/ZZvuu6SUWhLoKwRs9UNH
 vBmHi6GYZfk8qJYkrZ2/bF4YpKtTPNtjN0AGLU8rVEVK1eqSZPjTptCMSexZXA==
X-Gm-Gg: AeBDieuM8kSulmr1z8T8J17zCepLVx1jwEnL582RvUSkk7NS3Ng4pWXb7a5gSqCt1jp
 Hp+v/Y4ytaDRKn+Ncq4/8KoaQ5zoZ8ifv1g2vehuVPOPcxSeCl8ZiVIbwhsHQr31r1Kpjfx/5wk
 Cikxa678klHioOF8rUn0mSKXZ+LHBZ+jnPAZAcfQITDp0lOGWmYFYKMTxUXdgw9BAGNgtWuqnof
 HT66OBD41YVzdC9121uN8UKIP68wayPwFSTH+pL9SBhVia4Go7XtOTAGVl/knk6CWUGPlQo4tXr
 zFpTiZccv2d8u3e4gYsDghrepCSP3IoHJKbgj8I3Zh1Vw9FQKiMBKkJPtZZzZiUNSPI6sMqo4dW
 4+9ENeo0KSfqv7OAEtTJKj90pMI7nW1f2qNqVIBENBmZTe3U5VXmuNbaNMOi7t4o10Br5MpK4Td
 XWopum4+lNR88q7Z0Kc1LQogeq52w2PAWGfm945cXoS/mqlnlDv3xFrZFKOezdwMYw4hoPAX/hU
 PquucupaJJxcokkbkS8
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id
 ffacd0b85a97d-43d642cd287mr21999512f8f.37.1776113384014; 
 Mon, 13 Apr 2026 13:49:44 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d762decf6sm22203242f8f.8.2026.04.13.13.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 13:49:43 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:49:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_Re=3A_=5BPATCHv5_00/15=5D_Adding_com?=
 =?US-ASCII?Q?prehensive_support_for_i=2EMX8MM_EVK_board?=
In-Reply-To: <AM0PR04MB4370028D6C330307CADBF81D87242@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
 <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
 <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
 <AM0PR04MB4370028D6C330307CADBF81D87242@AM0PR04MB4370.eurprd04.prod.outlook.com>
Message-ID: <AE626996-1262-42ED-8400-9684DA86F871@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
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



Am 13=2E April 2026 19:54:29 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@=
nxp=2Ecom>:
>@'Bernhard Beschow', after I rebased to master and build the changes, so =
far I have observed build errors like:-
>
>1=2E 2 of those attributed to qdev-properties=2Eh header file moved from =
hw/ to hw/core/
>2=2E 2 errors attributed to boards=2Eh header file moved from hw/ to hw/c=
ore/
>3=2E One attributed to smmu :-
>
>In file included from =2E=2E/hw/arm/smmuv3=2Ec:37:
>=2E=2E/hw/arm/smmuv3-accel=2Eh:17:10: error: #include expects "FILENAME" =
or <FILENAME>
>   17 | #include CONFIG_DEVICES
>      |          ^~~~~~~~~~~~~~
>=2E=2E/hw/arm/smmuv3-accel=2Eh:44:8: error: attempt to use poisoned "CONF=
IG_ARM_SMMUV3_ACCEL"
>   44 | #ifdef CONFIG_ARM_SMMUV3_ACCEL
>      |        ^
>=2E=2E/hw/arm/smmuv3=2Ec: In function 'smmu_validate_property':
>=2E=2E/hw/arm/smmuv3=2Ec:1968:9: error: attempt to use poisoned "CONFIG_A=
RM_SMMUV3_ACCEL"
> 1968 | #ifndef CONFIG_ARM_SMMUV3_ACCEL
>      |         ^
>
>Build command used:-
>
>=2E=2E/configure --target-list=3Daarch64-softmmu
>make -j$(nproc)
>
>are these expected ?=20

Certainly not, since we're close to a release=2E The only advice I can giv=
e for now is to double check against imx8mp=2E=2E=2E

>
>
>
>> -----Original Message-----
>> From: Gaurav Sharma
>> Sent: 14 April 2026 00:30
>> To: 'Bernhard Beschow' <shentey@gmail=2Ecom>; qemu-devel@nongnu=2Eorg
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
>> i=2EMX8MM EVK board
>>=20
>>=20
>>=20
>> > -----Original Message-----
>> > From: Bernhard Beschow <shentey@gmail=2Ecom>
>> > Sent: 13 April 2026 19:01
>> > To: qemu-devel@nongnu=2Eorg; Gaurav Sharma
>> <gaurav=2Esharma_7@nxp=2Ecom>
>> > Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> > Subject: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
>> > i=2EMX8MM EVK board
>> >
>> > Caution: This is an external email=2E Please take care when clicking
>> > links or opening attachments=2E When in doubt, report the message usi=
ng
>> > the 'Report this email' button
>> >
>> >
>> > Am 13=2E April 2026 07:37:22 UTC schrieb Gaurav Sharma
>> > <gaurav=2Esharma_7@nxp=2Ecom>:
>> >
>> > Hi Gurav,
>> >
>> > >Changes in v5:
>> > >- Fixed SoC object reference counting by using
>> > >object_new_with_props()
>> > >  instead of object_new() + object_property_add_child()
>> > >- Merged imx8mm-evk=2Erst documentation into imx8mp-evk=2Erst to avo=
id
>> > >  duplication and updated the title accordingly
>> > >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
>> >
>> > I tried to apply v5 but I'm hitting the same issues as Patchew:
>> > <https://eur01=2Esafelinks=2Eprotection=2Eoutlook=2Ecom/?url=3Dhttps%=
3A%2F%2Fpat
>> > ch
>> > ew=2Eorg%2FQEMU%2F20260413073737=2E986219-1-
>> >
>> gaurav=2Esharma=2E_5F7%40nxp=2Ecom%2F&data=3D05%7C02%7Cgaurav=2Esharma_=
7%4
>> >
>> 0nxp=2Ecom%7Cfbdcd381f0014ebd086a08de9960ed16%7C686ea1d3bc2b4c6fa
>> >
>> 92cd99c5c301635%7C0%7C0%7C639116838724991885%7CUnknown%7CTWF
>> >
>> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
>> >
>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnyynvYO
>> > v87nTkxEFkU8k3eSt4r%2Fa17rQkr9STABgaaA%3D&reserved=3D0> Mind
>> resending a
>> > version rebased onto master?
>> >
>> > Moreover, you may keep my R-b tags which I've given during v4=2E
>> >
>> > Best regards,
>> > Bernhard
>> >
>>=20
>> Hey Bernhard,
>> yes, looks like I need to rebase and create patches again=2E Lemme do t=
hat and
>> send over as v6=2E
>>=20
>> > >
>> > >Changes in v4:
>> > >- Update Maintainers file
>> > >- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a
>> > >variant
>> > >  specific property
>> > >- Split up the patch that enabled CCM and Analog in the previous
>> > >  revision=2E Now we have 3 patches to enable CCM and Analog in iMX8=
MM
>> > >- Updated copyrights
>> > >- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
>> > >failures
>> > >
>> > >Changes in v3:
>> > >- Minor documentation change - Added KVM Acceleration section in
>> > >docs/system/arm/imx8mm-evk=2Erst
>> > >
>> > >Changes in v2:
>> > >- Fixed the DTB offset in functional testing script
>> > >test_imx8mm_evk=2Epy
>> > >  and preserved alphabetical order of machine names in
>> > >tests/functional/aarch64/meson=2Ebuild
>> > >- Fixed a typo and updated the documentation
>> > >- Modified structures type to static const in fsl-imx8mm=2Ec whereve=
r
>> > >  applicable=2E
>> > >- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk=
=2Ec=2E
>> > >This
>> > >  is needed because the default DTB in the iMX LF BSP images have CS=
I
>> > >  and DSI enabled=2E Developers/Hobbyists using these BSP images wil=
l
>> > >  observe CSI and DSI crash logs on the console since these are
>> > unimplemented=2E
>> > >  With this change, both debian and iMX LF images will boot up
>> > > without any
>> > issues=2E
>> > >
>> > >Changes in v1:
>> > >
>> > >This patch series adds support for the NXP i=2EMX8MM EVK (Evaluation
>> > >Kit) board to QEMU, enabling emulation of this ARM Cortex-A53 based
>> > >development platform=2E
>> > >
>> > >The series includes:
>> > >
>> > >1=2E Core peripheral support (CCM clock controller, Analog module) 2=
=2E
>> > >GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation
>> support
>> > 3=2E
>> > >GPIO,I2C,SPI,USDHC and USB Emulation support 4=2E PCIe and ENET
>> > >Controller Emulation support 5=2E Documentation and functional test
>> > >included
>> > >
>> > >Key features ported:
>> > >- Basic boot support with Linux
>> > >- UART console for serial communication
>> > >- Interrupt handling
>> > >- Clock and power management infrastructure
>> > >
>> > >Testing:
>> > >- Linux kernel boots to console
>> > >
>> > >Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> > >
>> > >Gaurav Sharma (15):
>> > >  hw/arm: Add the i=2EMX 8MM EVK(Evaluation Kit) board
>> > >  hw/misc/imx8mp_analog: Add property to analog device
>> > >  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
>> > >  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
>> > >  hw/arm/fsl-imx8mm: Implemented support for SNVS
>> > >  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>> > >  hw/arm/fsl-imx8mm: Add PCIe support
>> > >  hw/arm/fsl-imx8mm: Add GPIO controllers
>> > >  hw/arm/fsl-imx8mm: Adding support for I2C emulation
>> > >  hw/arm/fsl-imx8mm: Adding support for SPI controller
>> > >  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>> > >  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>> > >  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>> > >  hw/arm/fsl-imx8mm: Adding support for USB controller
>> > >  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
>> > >
>> > > MAINTAINERS                                 |  10 +
>> > > docs/system/arm/imx8mp-evk=2Erst              |  33 +-
>> > > docs/system/target-arm=2Erst                  |   1 +
>> > > hw/arm/Kconfig                              |  24 +
>> > > hw/arm/fsl-imx8mm=2Ec                         | 704 +++++++++++++++=
+++++
>> > > hw/arm/imx8mm-evk=2Ec                         | 130 ++++
>> > > hw/arm/meson=2Ebuild                          |   2 +
>> > > hw/misc/imx8mp_analog=2Ec                     |  12 +-
>> > > hw/timer/imx_gpt=2Ec                          |  26 +
>> > > include/hw/arm/fsl-imx8mm=2Eh                 | 242 +++++++
>> > > include/hw/misc/imx8mp_analog=2Eh             |   3 +
>> > > include/hw/timer/imx_gpt=2Eh                  |   2 +
>> > > tests/functional/aarch64/meson=2Ebuild        |   2 +
>> > > tests/functional/aarch64/test_imx8mm_evk=2Epy |  67 ++
>> > > 14 files changed, 1251 insertions(+), 7 deletions(-) create mode
>> > > 100644 hw/arm/fsl-imx8mm=2Ec create mode 100644 hw/arm/imx8mm-
>> evk=2Ec
>> > > create mode 100644 include/hw/arm/fsl-imx8mm=2Eh create mode 100755
>> > > tests/functional/aarch64/test_imx8mm_evk=2Epy
>> > >


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE152C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy6uL-0006BV-9U; Sun, 23 Aug 2026 08:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wy6uF-00067p-HH
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 08:02:33 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wy6uD-0000LD-A9
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 08:02:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso371848066b.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787486547; x=1788091347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5zp5F1hJz18rIpdzbWFl5EUWBWlRdY//JqR/iR0aIQ=;
 b=Coh0CRyM19H/DnYgCb/awOJOe2I8MlmBTX1/C0XrMJOzwbUN+Gi9UcHGkWMCm166Fm
 bxZDEBdGiWbvC2m3AvRFpR/rp83M15fwNTpbmv29CADLilxUI4rrJVcS+JO3Ge5lS77I
 K/dy2g2tVXcwJadpvAG3DnJFJg5RuCLjA3s5AIoIjyF8NaiYBBJcJelQXta+0MTcPN8C
 0jY9/kni1tHjZS8JKRRKsUnv5ELXxsRTtCbCyhoWTeds1Ff+2Rxy0BK0H1rcxgQXDkNb
 1nzXFD3BU/emTgAB7oAAZ2L1osK2czZZ2+x9hPqM391cVjeEln9KfmDn7901NweqH6Pi
 +4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787486547; x=1788091347;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5zp5F1hJz18rIpdzbWFl5EUWBWlRdY//JqR/iR0aIQ=;
 b=r9ClhThs5rQNVaU/7AUjjOet0sTXa82scWdRQSGHIzAAmNhzuKCBzpx66aBOU5PxEZ
 8aOFT2f7RARawDizK1GIHLRAnGjbJH3NtkTUwwgwMxjuLNtyr9bxKzGmf8J8XBv+aWnj
 BRD3aGAcIPGIgR3ROI4EMJX8rGBdFb2MGeRRUyWEB5p77PVYVyjrrUW73F7hrBcTldgh
 omFlXWjBonvcuD6XH6Z0l2VKtcv5J/aBpR3+1Q/43759y00e85BM3ffPqHNZRhUt5Uy3
 3TsuqIdRQcgqMrlm5BdNGBwOdJJI5CB/Osawr7sT/8CHN9rKf2P0H4/nVLzPOiLMQFNL
 ADPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9RCjEq1UF+mmcJDuMUiqBs18OiHpovYy51IAzMgUBv5W3cVGRQexUlc5oQXMcHMTUw6mpIRi3WhZO@nongnu.org
X-Gm-Message-State: AFuF++mF187Pv+7eHMxys1w0KPbFLdyEFlPErrNZJG8QNsht0expFVF+
 W3nsG4UfmPyOKIIVTm2HWucN67PyXKfViAteiUMpkMwVo8Yaddp/gHEO
X-Gm-Gg: AR+sD123oT1ZGQm3ie7JI4FIWA9oBkkGL36eJOPvv8z+gsRgZq7lIx/cwq2J742q0w+
 TdSf7VslEba6tpA0uKIN43XPDoOoCYb6RRTrkUAS9ntQ2rxlM2hz0uVs7BE7q7IR066HOprYIna
 tpbe0BGx7mu/4NZtzGLqcYd91+bGAE0AeHBzsl/S4VeFVduKH/vQBOAFgtx23WoNS6LNBAbdBtK
 8pG5Ph900hqZDnX3zLKrtT7FNpSXpCmDejFSWXPBmImhZ90uW3f02f0qcLz7WMmenEpss/ubIxJ
 nl1C1RzFmhTV/xajoJR433tVFWaLWCNI2z8YJKW6Os7DBMQVKkg0I3fbiBepHoeijFLMe/eh4+b
 UkbbqkgfgNMaWGcZN0uQTnIE1/4SVfiAUb3T62UYbc76HVjI5iqRs4XWek6YRqmRGdxGwWmv2gV
 uBL/K3ROtHIktjGNckeIsrVD7HA96PhxZGzCx0rg+zjADJR6UeF2CApq1/Nn/vYUiy2fOOMc1UB
 PlpNZr0uxpvQXuoYaLr+JGz1NUWh/d631KOBPPFeV99sIlTzc8=
X-Received: by 2002:a17:907:3fa0:b0:c16:16b9:98fa with SMTP id
 a640c23a62f3a-c249257b3abmr1198391866b.5.1787486546870; 
 Sun, 23 Aug 2026 05:02:26 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-092-224-251-016.92.224.pool.telefonica.de. [92.224.251.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9c9fsm730081666b.39.2026.08.23.05.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 05:02:26 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:02:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCHv2_0/7=5D_hw/arm=3A_Adding_Cortex-M7_Asym?=
 =?US-ASCII?Q?metric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <DB8PR04MB717730147C8E5B87FF57D07D87DD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <DB8PR04MB717730147C8E5B87FF57D07D87DD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
Message-ID: <C7FBB1C7-732B-4BFB-9073-CA8A44C41C3B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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



Am 11=2E August 2026 04:47:40 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7=
@nxp=2Ecom>:
>ping
>
>> -----Original Message-----
>> From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> Sent: 24 July 2026 09:32
>> To: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>; qemu-devel@nongnu=2Eor=
g
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Bernhard Besch=
ow
>> <shentey@gmail=2Ecom>
>> Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> Multiprocessing boot support for i=2EMX8MP
>>=20
>> Ping

Hi Gurav,

I finally could test your series=2E I built Buildroot's freescale_imx8mpev=
k_defonfig (v2026=2E05) which has the required kernel options already enabl=
ed and passed imx8mp-evk-rpmsg=2Edtb to QEMU=2E QEMU starts successfully=2E=
 However, when attempting to load an =2Eelf image to remoteproc0/firmware, =
I get:

    # echo zephyr=2Eelf > /sys/devices/platform/imx8mp-cm7/remoteproc/remo=
teproc0/firm
ware=20
    [  887=2E325597] imx-rproc imx8mp-cm7: can't change firmware while run=
ning
    sh: write error: Device or resource busy

Checking the state results in:

    # cat /sys/devices/platform/imx8mp-cm7/remoteproc/remoteproc0/state=20
    attached

I didn't dig into the Linux kernel sources to investigate this further=2E =
Do you have an idea of what is missing?

Note that I built Zephyr's imx8mp_evk for the M7 [1] which produces zephyr=
=2Eelf=2E Does the series provide everything to use Zephyr or do we need to=
 add ITCM memory? Adding a dedicated memory map including ITCM for the M7 c=
ore doesn't seem too complicated=2E Using Zephyr may allow for having a fun=
ctional test in our CI, though of course binary images had to be provided=
=2E

Best regards,
Bernhard

[1] https://docs=2Ezephyrproject=2Eorg/latest/boards/nxp/imx8mp_evk/doc/in=
dex=2Ehtml#programming-and-debugging-m7


>>=20
>> > -----Original Message-----
>> > From: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> > Sent: 06 July 2026 21:59
>> > To: qemu-devel@nongnu=2Eorg
>> > Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg; Gaurav Sharm=
a
>> > <gaurav=2Esharma_7@nxp=2Ecom>
>> > Subject: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
>> > Multiprocessing boot support for i=2EMX8MP
>> >
>> > Changes in v1:
>> >
>> > This series adds Asymmetric Multiprocessing (AMP) boot support for th=
e
>> > Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be loaded =
and
>> > started from Linux running on the Cortex-A53 cores via the remoteproc
>> > framework=2E
>> >
>> > The series introduces the following peripheral models needed for AMP:
>> >   - GPC (General Power Controller)
>> >   - GPR (General Purpose Registers)
>> >   - SRC (System Reset Controller) authored by Bernhard Beschow
>> > <shentey@gmail=2Ecom>
>> >   - MU (Messaging Unit)
>> >   - Extends the CCM with M7 clock outputs and wires into the i=2EMX8M=
P SoC
>> >   - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>> >
>> > Changes in v2:
>> >
>> > - Removed the usage of device_class_set_legacy_reset in imx8mp
>> > gpc,gpr,mu and
>> >   src=2E
>> > - Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make the
>> >   invocation simpler=2E
>> > - Cleaned up imx8mp_src by removing redundant/unused code=2E
>> > - Updated Maintainers and improved the imx8mp documentation
>> >
>> > Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >
>> > Bernhard Beschow (1):
>> >   hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>> >
>> > Gaurav Sharma (6):
>> >   hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>> >   hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>> >   hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>> >   hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>> >   hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>> >   tests/functional: Enable Cortex-M7 boot in i=2EMX8MP EVK functional
>> > test
>> >
>> >  MAINTAINERS                                 |  13 +-
>> >  docs/system/arm/imx8m=2Erst                   | 188 ++++++++++-
>> >  hw/arm/Kconfig                              |   4 +
>> >  hw/arm/fsl-imx8mp=2Ec                         | 220 ++++++++++++-
>> >  hw/arm/imx8mp-evk=2Ec                         |   3 +-
>> >  hw/misc/Kconfig                             |  12 +
>> >  hw/misc/imx8mp_ccm=2Ec                        |   9 +
>> >  hw/misc/imx8mp_gpc=2Ec                        | 146 +++++++++
>> >  hw/misc/imx8mp_gpr=2Ec                        | 153 +++++++++
>> >  hw/misc/imx8mp_mu=2Ec                         | 328 ++++++++++++++++=
++++
>> >  hw/misc/imx8mp_src=2Ec                        | 275 ++++++++++++++++
>> >  hw/misc/meson=2Ebuild                         |   4 +
>> >  hw/misc/trace-events                        |   5 +
>> >  include/hw/arm/fsl-imx8mp=2Eh                 |  29 +-
>> >  include/hw/misc/imx8mp_ccm=2Eh                |   3 +
>> >  include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
>> >  include/hw/misc/imx8mp_gpr=2Eh                |  56 ++++
>> >  include/hw/misc/imx8mp_mu=2Eh                 |  53 ++++
>> >  include/hw/misc/imx8mp_src=2Eh                |  31 ++
>> >  tests/functional/aarch64/test_imx8mp_evk=2Epy |   1 -
>> >  20 files changed, 1539 insertions(+), 28 deletions(-)  create mode
>> > 100644 hw/misc/imx8mp_gpc=2Ec  create mode 100644
>> hw/misc/imx8mp_gpr=2Ec
>> > create mode 100644 hw/misc/imx8mp_mu=2Ec  create mode 100644
>> > hw/misc/imx8mp_src=2Ec  create mode 100644
>> include/hw/misc/imx8mp_gpc=2Eh
>> > create mode 100644 include/hw/misc/imx8mp_gpr=2Eh  create mode 100644
>> > include/hw/misc/imx8mp_mu=2Eh  create mode 100644
>> > include/hw/misc/imx8mp_src=2Eh
>> >
>> > --
>> > 2=2E34=2E1
>


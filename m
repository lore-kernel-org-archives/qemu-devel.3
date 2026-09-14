Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4F0C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64G3-0005Et-8S; Mon, 14 Sep 2026 06:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x64G0-0005Dt-6L
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:49:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x64Fw-0000xH-SK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:49:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49e6e69d528so18661325e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789382986; x=1789987786; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVaUyAvaa7HzuWGqoYU+V8bzrorYtlZRkuYdZ2CBmwg=;
 b=kQFAr9au5VB1udxKJg2//AOUWQdc0PMKXblAHb83mxEwYTEORHtgOC/QpiklF1hUrt
 taH+mewoagCJ1lMwmyb/lshhyt1XtMW1pDLk8EFp60V/52HDov5REEa8CaLZX4wxOGxG
 ZYNw579jAyiThPlNw+jNu5NyI5YINVTa2L+xdzTDPrSSb594zzEmH+T1hEl/mTEZpsxs
 py86cQilKozaat5UgOIvgNI4TakW7hjPx4ycYiyfaIWY3m0TP8gF364tChWil6abm3bY
 UExTlkLu1u5tFkb3toruEMFSDruwNOtvEAinjDbSuGzw/W1lAAwccWO+5/rG03z0gPJw
 rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789382986; x=1789987786;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVaUyAvaa7HzuWGqoYU+V8bzrorYtlZRkuYdZ2CBmwg=;
 b=bPmawgryZLM2yRTxedItlM/J+rPTwfLh4bzSuSEWsdahufopYYSn32TmLSU8cqO60C
 2+0D2TEs5FtAWBIHPubCNUzONsaqC/JwhdDvPQm/hq1dGS2RhrvAVPzyC2HLiSupkTp+
 XCJn3jdylWO/0AfuqJn82SLeuZ+E372ap0n7t+KE1H26gASwnGwbmsQgFZoplqHbaDzi
 Mxp/XSAZD0n/HYNUW86aErIo4z5I/P72EJapL6HUIqbWJOCoLO0rqJCEau4OJJD876rE
 kMhCLISX/0gzrPdvHRAVnG3/mATkK18uvWzX0986UquzS86hxVRGtF6fN/cNVW/wETIA
 8DNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Z9tEHMd/DQ6l+v6RrDqg6rEaWQqy7n33wy85JxbUbcuZs+qmRNGZ3E+stXyuFTmscz2BqNW9V1HY@nongnu.org
X-Gm-Message-State: AFuF++lzPJogW1FEiIznNK2ANdaQvBzbo5VOHQzzEdwOa12ETdz+ygZD
 sIr1zQZ6X7WouxOstQyzhBonc/WbkgrVpo6AtlO7gdGL7uyDxrkvBkP+
X-Gm-Gg: AYBFou1Zp1v1ZFwaZtNoi5PLAC36qZnp0GYdwPYbNFdoCBqH5RmBy9P3LnUopZYdXOo
 TMwA+v65KfwW/CnnIclIEPUo7VLb0UctL1ASdGluUNxWPm31/A1QTK4OcYT4m8EyT6ffn6ifgk5
 4hp52+9tyHZ+apLQHVMGnAh/AmyP29kD4sn/8467UFoja0C2NiEe6s5226+ixB9ikRJo7BUDSdB
 rrqrsmoRiteRrTtt7p9nDgzCf5mko+GiMWt6XA5RKqhynL+GQAqp8S+DtQ0R+zc7wFPrcdPsyOp
 uVXFe8v9X7drqxFF8zIt5fA48YUdy4e32ukR+kBKBe7aRjeW1vvWGTg2fjIk0Cd+i3pIbWWUPtJ
 oSmBVONU3lSQyVE10KZI0mYwBddbvciDcegfZYh9cbqLSczbZvTjgcdco6UdYldC5zSCATQXBII
 Imobs8AA+s0ymK1b2CMc8Jq7OfrwlxbnHYLSmM0wB7GjVcaMMmuve4ZI/tO76bhzM4TCwtVujgk
 Danzg==
X-Received: by 2002:a05:600c:3593:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-49e7a5eda7dmr24563445e9.0.1789382986041; 
 Mon, 14 Sep 2026 03:49:46 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.218.62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62225628sm226679345e9.3.2026.09.14.03.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 03:49:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:49:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: =?US-ASCII?Q?RE=3A_=5BEXT=5D_Re=3A_=5BPATCHv2_6/7=5D_hw/arm=3A_?=
 =?US-ASCII?Q?Enable_Cortex-M7_AMP_boot_on_i=2EMX8MP?=
In-Reply-To: <DB8PR04MB71771AF07412A94C9036BD5487BD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
 <20260706162859.3361063-7-gaurav.sharma_7@nxp.com>
 <DE3192D0-CBB5-4221-9E52-5B447E5BD90F@gmail.com>
 <DB8PR04MB71771AF07412A94C9036BD5487BD2@DB8PR04MB7177.eurprd04.prod.outlook.com>
Message-ID: <CD11A462-F087-497A-BBD5-6956247C98EC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_CSS=0.1, URIBL_CSS_A=0.1,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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



Am 12=2E September 2026 07:53:38 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:
>
>
>
>NXP Confidential
>> -----Original Message-----
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>> Sent: 05 September 2026 12:22
>> To: qemu-devel@nongnu=2Eorg; Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom=
>
>> Cc: pbonzini@redhat=2Ecom; peter=2Emaydell@linaro=2Eorg
>> Subject: [EXT] Re: [PATCHv2 6/7] hw/arm: Enable Cortex-M7 AMP boot on
>> i=2EMX8MP
>>
>> Caution: This is an external email=2E Please take care when clicking li=
nks or
>> opening attachments=2E When in doubt, report the message using the 'Rep=
ort
>> this email' button
>>
>>
>> Am 6=2E Juli 2026 16:28:58 UTC schrieb Gaurav Sharma
>> <gaurav=2Esharma_7@nxp=2Ecom>:
>> >Configure the i=2EMX8MP to boot the Cortex-M7 core alongside the
>> >Cortex-A53 cores in an Asymmetric Multiprocessing (AMP) configuration=
=2E
>> >The M7 firmware can be loaded and started from Linux running on the A5=
3
>> >cores via the remoteproc framework=2E
>> >
>> >CM7 boot is made optional=2E A GPR IRQ is connected to a cpuwait handl=
er=2E
>> >The handler translates the CPUWAIT into STOP and RUN=2EIt follows the
>> >classic Cortex-M boot sequence: initial SP and reset vector taken from
>> >the vector table=2E
>> >
>> >Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>> >---
>> > docs/system/arm/imx8m=2Erst   | 184
>> +++++++++++++++++++++++++++++++++++-
>> > hw/arm/fsl-imx8mp=2Ec         | 151 ++++++++++++++++++++++++++---
>> > hw/arm/imx8mp-evk=2Ec         |   3 +-
>> > include/hw/arm/fsl-imx8mp=2Eh |  13 ++-
>> > 4 files changed, 333 insertions(+), 18 deletions(-)
>> >
>> >diff --git a/docs/system/arm/imx8m=2Erst b/docs/system/arm/imx8m=2Erst
>> >index c482bf180f=2E=2E294c333127 100644
>> >--- a/docs/system/arm/imx8m=2Erst
>> >+++ b/docs/system/arm/imx8m=2Erst
>> >@@ -12,6 +12,7 @@ The ``imx8mp-evk`` and ``imx8mm-evk`` machines
>> >implement the  following devices:
>> >
>> >  * Up to 4 Cortex-A53 cores
>> >+ * 1 Cortex-M7 core (``imx8mp-evk`` only)
>> >  * Generic Interrupt Controller (GICv3)
>> >  * 4 UARTs
>> >  * 3 USDHC Storage Controllers
>> >@@ -36,6 +37,187 @@ Boot options
>> > The ``imx8mp-evk`` and ``imx8mm-evk`` machines can start a Linux
>> >kernel directly using the standard ``-kernel`` functionality=2E
>> >
>> >+
>> >+Asymmetric Multiprocessing (AMP) Boot Recipe (``imx8mp-evk`` only)
>> >+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> >+
>> >+The ``imx8mp-evk`` machine includes a Cortex-M7 core alongside the
>> >+Cortex-A53 cores, enabling Asymmetric Multiprocessing (AMP)=2E The M7
>> >+firmware can be loaded from Linux using the remoteproc framework=2E
>> >+
>> >+There are 2 control paths for Cortex-M7 on iMX8MP:- 1=2E
>> >+Firmware-mediated (via SMC/ATF) 2=2E MMIO driven path (via SRC and GP=
R
>> >+access)
>> >+
>> >+``fsl,imx8mp-cm7-mmio`` exists specifically to select the MMIO path a=
nd
>> avoid dependence on firmware interfaces that aren=E2=80=99t guaranteed =
in qemu=2E
>> >+This mode uses the SRC syscon block and the IOMUXC GPR for start/stop
>> control=2E
>> >+
>> >+Memory carveouts for resource table, vrings need to be specified in t=
he
>> ``imx8mp-evk-rpmsg=2Edts``=2E
>> >+Follow this application note to make the necessary changes -
>> >+https://eur01=2Esafelinks=2Eprotection=2Eoutlook=2Ecom/?url=3Dhttps%3=
A%2F%2Fwww
>> =2E
>> >+nxp=2Ecom%2Fdocs%2Fen%2Fapplication-
>> note%2FAN5317=2Epdf&data=3D05%7C02%7Cgau
>> >+rav=2Esharma_7%40nxp=2Ecom%7Ced0ccff0b93040223a7908df0b1a3c30%7C68
>> 6ea1d3bc
>> >+2b4c6fa92cd99c5c301635%7C0%7C0%7C639241879466409660%7CUnknow
>> n%7CTWFpbG
>> >+Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
>> MiIsIkFO
>> >+IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DfgR89RxBAKwbh
>> TmwuBGOe4
>> >+8JRAJmNGlRlhiq%2BonQfiM%3D&reserved=3D0
>> >+
>> >+When Linux boots CM7 via remoteproc, the typical flow is:
>> >+
>> >+1=2E Linux booted with imx8mp-evk-rpmsg=2Edtb 2=2E Linux loads the CM=
7 ELF
>> >+into a reserved DDR region 3=2E Linux toggles the CM7 start/stop cont=
rol
>> >+(SRC/GPR CPUWAIT, etc=2E) 4=2E CM7 starts executing from that DDR ent=
ry
>> >+
>> >+
>> >+Prerequisites
>> >+~~~~~~~~~~~~~
>> >+
>> >+To manually test Cortex-M7 firmware loading from Linux, the following
>> >+components are needed:
>> >+
>> >+1=2E Linux kernel configuration to enable i=2EMX remoteproc support=
=2E
>> >+2=2E ``imx8mp-evk-rpmsg=2Edtb`` -  device tree that enables the Corte=
x-M7
>> remoteproc node, reserves DDR memory regions
>> >+   for the Cortex-M7 firmware, resource table,vrings and buffers=2E
>> >+3=2E A Cortex-M7 ELF firmware image linked to execute from DDR=2E
>> >+
>> >+NXP application note AN5317 describes the required remoteproc and
>> >+reserved-memory setup for loading Cortex-M firmware from Linux=2E
>> >+
>> >+
>> >+Linux kernel configuration
>> >+~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >+
>> >+The guest kernel needs remoteproc support=2E On official linux-imx ke=
rnels,
>> this support is enabled by default=2E
>> >+When using Buildroot, verify that the kernel configuration enables th=
e
>> >+remoteproc and rpmsg options needed by the i=2EMX remoteproc driver, =
for
>> example:
>> >+
>> >+=2E=2E code-block:: none
>> >+
>> >+  CONFIG_REMOTEPROC=3Dy
>> >+  CONFIG_IMX_REMOTEPROC=3Dy
>> >+  CONFIG_RPMSG=3Dy
>> >+  CONFIG_VIRTIO_RPMSG_BUS=3Dy
>> >+  CONFIG_RPMSG_CHAR=3Dy
>> >+
>> >+Depending on the kernel version and configuration, some options may b=
e
>> >+selected automatically by the i=2EMX remoteproc driver=2E
>> >+
>> >+
>> >+
>> >+Device tree preparation
>> >+~~~~~~~~~~~~~~~~~~~~~~~
>> >+
>> >+1=2E Refer to ``9=2E1 i=2EMX Linux rproc support`` of application not=
e AN5317 to
>> add the
>> >+   following nodes in ``imx8mp-evk-rpmsg=2Edts`` :-
>> >+
>> >+   m7_ddr_alias
>> >+   m7_itcm
>> >+   m7_dtcm
>> >+
>> >+2=2E Modify the compatible string of ``imx8mp-cm7`` node from
>> >+``fsl,imx8mn-cm7`` to ``fsl,imx8mp-cm7-mmio`` 3=2E Add the following
>> >+properties to the ``imx8mp-cm7`` node :-
>> >+
>> >+   ``syscon =3D <&src>;``
>> >+   ``fsl,iomuxc-gpr =3D <&gpr>;``
>> >+
>> >+   These references are needed by imx_rproc_mmio_detect_mode in i=2EM=
X
>> remoteproc driver
>> >+   for M7 boot mode detection=2E
>> >+
>> >+
>> >+   Build ``imx8mp-evk-rpmsg=2Edtb`` from the above dts changes=2E
>> >+
>> >+
>> >+
>> >+Building a Cortex-M7 ELF firmware
>> >+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >+
>> >+A simple manual test is the MCUXpresso SDK UART polling example for
>> >+the i=2EMX8MP EVK=2E It prints to a UART and is therefore easy to obs=
erve from
>> QEMU=2E
>> >+
>> >+1=2E Follow this guide to set up MCUXpresso SDK for i=2EMX8MPEVK :-
>> >+MCUXSDKIMX8MPGSUG[https://eur01=2Esafelinks=2Eprotection=2Eoutlook=2E=
com/?u
>> rl=3D
>> >+https%3A%2F%2Fshare=2Egoogle%2FqD4D09FCkkydTurqp&data=3D05%7C02%7
>> Cgaurav=2Es
>> >+harma_7%40nxp=2Ecom%7Ced0ccff0b93040223a7908df0b1a3c30%7C686ea1
>> d3bc2b4c6
>> >+fa92cd99c5c301635%7C0%7C0%7C639241879466438460%7CUnknown%7C
>> TWFpbGZsb3d
>> >+8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
>> OIjoiT
>> >+WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DXrPUCKlzeehjw%2FH
>> idRtH8wUq%
>> >+2F5qQWjnHJSetXGkTvKM%3D&reserved=3D0]
>> >+2=2E Build a DDR-linked Cortex-M7 ELF using the ARM GNU toolchain fro=
m
>> >+the MCUXpresso SDK:-
>> >+
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  $ cd
>> >+ ${MCUX_SDK}/boards/evkmimx8mp/driver_examples/uart/polling/armgcc
>> >+  $ =2E/build_ddr_release=2Esh
>> >+
>> >+As a result, ``iuart_polling_cm7=2Eelf`` will be generated  in ``ddr_=
release``
>> folder=2E
>> >+
>> >+Boot qemu i=2EMX8MP EVK machine with the updated linux kernel and
>> >+``imx8mp-evk-rpmsg=2Edtb``
>> >+
>> >+3=2E Copy the ``iuart_polling_cm7=2Eelf`` to ``/lib/firmware/`` path =
inside
>> iMX8MPEVK qemu emulation=2E
>> >+
>> >+
>> >+Serial ports (UARTs)
>> >+''''''''''''''''''''
>> >+
>> >+The i=2EMX 8M Plus EVK model provides four UARTs=2E QEMU connects eac=
h
>> >+UART to a host character backend using the ``-serial`` option=2E This
>> >+option can be used multiple times to create and wire multiple serial =
ports=2E
>> >+
>> >+The ``-serial`` options are positional:
>> >+
>> >+* the 1st ``-serial =2E=2E=2E`` maps to ``serial0`` (UART1)
>> >+* the 2nd ``-serial =2E=2E=2E`` maps to ``serial1`` (UART2)
>> >+* the 3rd ``-serial =2E=2E=2E`` maps to ``serial2`` (UART3)
>> >+* the 4th ``-serial =2E=2E=2E`` maps to ``serial3`` (UART4)
>> >+
>> >+Example usage:- To enable serial console for the official M7
>> >+mcuxpresso sdk driver example - driver_examples/uart/polling which
>> >+uses UART4, use:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  -serial null -serial stdio -serial null -serial
>> >+ pty:/tmp/imx8mp-uart4
>> >+
>> >+This will create a symlink /tmp/imx8mp-uart4 pointed to the allocated
>> >+PTY=2E On a different tab the console for UART4 can be opened using t=
he
>> >+following:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  $ screen /tmp/imx8mp-uart4 115200
>> >+
>> >+
>> >+Starting QEMU for Cortex-M7 remoteproc testing
>> >+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >+
>> >+1=2E Execute the following command to start i=2EMX8MPEVK emulation:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  $ qemu-system-aarch64 -M imx8mp-evk \
>> >+      -display none -serial null -serial stdio -serial null -serial /=
tmp/imx8mp-
>> uart4 \
>> >+      -kernel Image \
>> >+      -dtb imx8mp-evk-rpmsg=2Edtb \
>> >+      -append "root=3D/dev/mmcblk2p2" \
>> >+      -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3Dmm=
cblk2
>> >+
>> >+2=2E On a new tab execute the following to open a console:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  $ screen /tmp/imx8mp-uart4 115200
>> >+
>> >+3=2E Execute the following commands inside emulation to load the
>> >+firmware elf:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+   $ echo iuart_polling_cm7=2Eelf >
>> /sys/class/remoteproc/remoteproc0/firmware
>> >+   $ echo start > /sys/class/remoteproc/remoteproc0/state
>> >+
>> >+
>> >+On the tab where the console is opened, you will observe the UART
>> >+logs=2E The characters typed from the keyboard will echo on the conso=
le=2E
>> >+
>> >+
>> >+Note:-
>> >+
>> >+Only DDR-linked bare-metal ELF images are currently supported by QEMU
>> >+emulation=2E If the firmware is linked for a vector table base addres=
s
>> >+other than ``0x80000000``, configure the Cortex-M7 vector base using
>> >+the SoC property
>> >+``cm7-vector-base``:-
>> >+
>> >+=2E=2E code-block:: bash
>> >+
>> >+  -global fsl-imx8mp=2Ecm7-vector-base=3D0x80000000
>> >+
>> >+If this property is not provided, QEMU uses ``0x80000000`` by default=
=2E
>> >+
>> >+
>> >+
>> > Direct Linux Kernel Boot
>> > ''''''''''''''''''''''''
>> >
>> >@@ -72,7 +254,7 @@ For i=2EMX 8M Plus EVK:
>> > =2E=2E code-block:: bash
>> >
>> >   $ qemu-system-aarch64 -M imx8mp-evk \
>> >-      -display none -serial null -serial stdio \
>> >+      -display none -serial null -serial stdio -serial null -serial
>> >+ /tmp/imx8mp-uart4 \
>> >       -kernel Image \
>> >       -dtb imx8mp-evk=2Edtb \
>> >       -append "root=3D/dev/mmcblk2p2" \
>> >diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec index
>> >eec83deced=2E=2E8d6a1c3f4d 100644
>> >--- a/hw/arm/fsl-imx8mp=2Ec
>> >+++ b/hw/arm/fsl-imx8mp=2Ec
>> >@@ -22,6 +22,8 @@
>> > #include "qapi/error=2Eh"
>> > #include "qobject/qlist=2Eh"
>> >
>> >+#define IMX8MP_NUM_A53 4
>> >+
>> > static const struct {
>> >     hwaddr addr;
>> >     size_t size;
>> >@@ -196,6 +198,10 @@ static void fsl_imx8mp_init(Object *obj)
>> >     FslImx8mpState *s =3D FSL_IMX8MP(obj);
>> >     int i;
>> >
>> >+    s->cm7_booted =3D false;
>> >+
>> >+    object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
>> >+
>> >     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>> >
>> >     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM); @@
>> >-269,6 +275,93 @@ static void fsl_imx8mp_init(Object *obj)
>> >                             TYPE_FSL_IMX8M_PCIE_PHY);  }
>> >
>> >+static inline void imx8mp_cm7_halt(CPUState *m7cs) {
>> >+    cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
>> >+    m7cs->halted =3D 1;
>> >+    qemu_cpu_kick(m7cs);
>> >+}
>> >+
>> >+static inline void imx8mp_cm7_resume(CPUState *m7cs) {
>> >+    /* Clear HALT interrupt (from STOP) and resume */
>> >+    cpu_reset_interrupt(m7cs, CPU_INTERRUPT_HALT);
>> >+    m7cs->halted =3D 0;
>> >+    m7cs->stopped =3D 0;
>> >+    cpu_resume(m7cs);
>> >+    cpu_interrupt(m7cs, CPU_INTERRUPT_EXITTB);
>> >+    qemu_cpu_kick(m7cs);
>> >+}
>> >+
>> >+static void imx8mp_cm7_ctrl_apply(CPUState *cpu, run_on_cpu_data data=
)
>> >+{
>> >+    struct CM7CtlReq *r =3D data=2Ehost_ptr;
>> >+    FslImx8mpState *s =3D r->s;
>> >+    ARMCPU *m7 =3D s->cm7=2Ecpu;
>> >+    CPUState *m7cs =3D CPU(m7);
>> >+
>> >+    if (!r->run) {
>> >+        /* STOP: halt the M7 */
>> >+    imx8mp_cm7_halt(m7cs);
>> >+        goto out;
>> >+    }
>> >+
>> >+    /*
>> >+     * RUN:
>> >+     * CPUWAIT is modeled as a run/stop gate=2E On first RUN, boot fr=
om
>> vector
>> >+     * table=2E Subsequent RUN resumes execution without resetting CM=
7
>> state=2E
>> >+     */
>> >+    if (s->cm7_booted) {
>> >+        imx8mp_cm7_resume(m7cs);
>> >+        goto out;
>> >+    }
>> >+
>> >+    uint32_t msp_le =3D 0, pc_le =3D 0;
>> >+    uint32_t msp, pc;
>> >+    hwaddr vbase =3D s->cm7_vector_base;
>> >+
>> >+    address_space_read(&address_space_memory, vbase,
>> >+                       MEMTXATTRS_UNSPECIFIED, &msp_le, sizeof(msp_le=
));
>> >+    address_space_read(&address_space_memory, vbase + 4,
>> >+                       MEMTXATTRS_UNSPECIFIED, &pc_le, sizeof(pc_le))=
;
>> >+    msp =3D le32_to_cpu(msp_le);
>> >+    pc  =3D le32_to_cpu(pc_le);
>> >+
>> >+
>> >+    /* Clear Thumb indicator bit (bit0) */
>> >+    pc &=3D ~1u;
>> >+
>> >+    cpu_reset(m7cs);
>> >+
>> >+    /* Set SP (R13) and PC (R15)=2E Cortex-M uses Thumb */
>> >+    m7->env=2Eregs[13] =3D msp;
>> >+    m7->env=2Eregs[15] =3D pc;
>> >+    m7->env=2Ethumb =3D 1;
>> >+
>> >+    imx8mp_cm7_resume(m7cs);
>> >+
>> >+    s->cm7_booted =3D true;
>> >+out:
>> >+    g_free(r);
>> >+};
>> >+
>> >+static void imx8mp_cm7_cpuwait_handler(void *opaque, int n, int level=
)
>> >+{
>> >+    FslImx8mpState *s =3D opaque;
>> >+    (void)n;
>> >+
>> >+    if (!s->cm7=2Ecpu) {
>> >+        return;
>> >+    }
>> >+
>> >+    struct CM7CtlReq *r =3D g_new0(struct CM7CtlReq, 1);
>> >+    r->s =3D s;
>> >+    r->run =3D !!level;
>> >+
>> >+    async_run_on_cpu(CPU(s->cm7=2Ecpu), imx8mp_cm7_ctrl_apply,
>> >+                     RUN_ON_CPU_HOST_PTR(r)); }
>> >+
>> > static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)  {
>> >     MachineState *ms =3D MACHINE(qdev_get_machine()); @@ -277,21
>> +370,15
>> >@@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> >     const char *cpu_type =3D ms->cpu_type ?: ARM_CPU_TYPE_NAME("corte=
x-
>> a53");
>> >     int i;
>> >
>> >-    if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>> >-        error_setg(errp, "%s: Only %d CPUs are supported (%d requeste=
d)",
>> >-                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp=2Ecp=
us);
>> >-        return;
>> >-    }
>> >-
>> >-    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> >+    for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>> >         g_autofree char *name =3D g_strdup_printf("cpu%d", i);
>> >         object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_ty=
pe);
>> >     }
>> >
>> >     /* CPUs */
>> >-    for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> >+    for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>> >         /* On uniprocessor, the CBAR is set to 0 */
>> >-        if (ms->smp=2Ecpus > 1 &&
>> >+        if (IMX8MP_NUM_A53 > 1 &&
>> >                 object_property_find(OBJECT(&s->cpu[i]), "reset-cbar"=
)) {
>> >             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>> >
>> >fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST]=2Eaddr,
>> >@@ -334,11 +421,11 @@ static void fsl_imx8mp_realize(DeviceState *dev,
>> Error **errp)
>> >         QList *redist_region_count;
>> >         bool pmu =3D object_property_get_bool(OBJECT(first_cpu), "pmu=
",
>> >NULL);
>> >
>> >-        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp=2Ecpus);
>> >+        qdev_prop_set_uint32(gicdev, "num-cpu", IMX8MP_NUM_A53);
>> >         qdev_prop_set_uint32(gicdev, "num-irq",
>> >                              FSL_IMX8MP_NUM_IRQS + GIC_INTERNAL);
>> >         redist_region_count =3D qlist_new();
>> >-        qlist_append_int(redist_region_count, ms->smp=2Ecpus);
>> >+        qlist_append_int(redist_region_count, IMX8MP_NUM_A53);
>> >         qdev_prop_set_array(gicdev, "redist-region-count",
>> redist_region_count);
>> >         object_property_set_link(OBJECT(&s->gic), "sysmem",
>> >                                  OBJECT(get_system_memory()),
>> >&error_fatal); @@ -353,7 +440,7 @@ static void
>> fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> >          * maintenance interrupt signal to the appropriate GIC PPI in=
puts, and
>> >          * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs=2E
>> >          */
>> >-        for (i =3D 0; i < ms->smp=2Ecpus; i++) {
>> >+        for (i =3D 0; i < IMX8MP_NUM_A53; i++) {
>> >             DeviceState *cpudev =3D DEVICE(&s->cpu[i]);
>> >             int intidbase =3D FSL_IMX8MP_NUM_IRQS + i * GIC_INTERNAL;
>> >             qemu_irq irq;
>> >@@ -383,11 +470,11 @@ static void fsl_imx8mp_realize(DeviceState *dev,
>> >Error **errp)
>> >
>> >             sysbus_connect_irq(gicsbd, i,
>> >                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ))=
;
>> >-            sysbus_connect_irq(gicsbd, i + ms->smp=2Ecpus,
>> >+            sysbus_connect_irq(gicsbd, i + IMX8MP_NUM_A53,
>> >                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ))=
;
>> >-            sysbus_connect_irq(gicsbd, i + 2 * ms->smp=2Ecpus,
>> >+            sysbus_connect_irq(gicsbd, i + 2 * IMX8MP_NUM_A53,
>> >                                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ)=
);
>> >-            sysbus_connect_irq(gicsbd, i + 3 * ms->smp=2Ecpus,
>> >+            sysbus_connect_irq(gicsbd, i + 3 * IMX8MP_NUM_A53,
>> >                                qdev_get_gpio_in(cpudev,
>> > ARM_CPU_VFIQ));
>> >
>> >             if (kvm_enabled()) {
>> >@@ -459,6 +546,38 @@ static void fsl_imx8mp_realize(DeviceState *dev,
>> Error **errp)
>> >     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
>> >                     fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR]=2Eaddr);
>> >
>> >+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpr), 0,
>> >+                   qemu_allocate_irq(imx8mp_cm7_cpuwait_handler, s,
>> >+ 0));
>> >+
>> >+    /* Realize Cortex-M7 subsystem */
>> >+    {
>> >+        DeviceState *cm7dev =3D DEVICE(&s->cm7);
>> >+        DeviceState *ccmdev =3D DEVICE(&s->ccm);
>> >+        qdev_prop_set_string(cm7dev, "cpu-type",
>> >+                             ARM_CPU_TYPE_NAME("cortex-m7"));
>> >+        qdev_prop_set_uint32(cm7dev, "num-irq", 64);
>>
>> The reference manual lists 160 IRQs for the M7=2E Any idea how these co=
uld be
>> wired up?
>>
>
>num-irq is corrected to 160=2E the same 160 SoC interrupt lines are route=
d to both the A53 GIC and the M7 NVIC with no mux =E2=80=94 so the wiring m=
odel is: each peripheral's IRQ output connects to both the GIC SPI input an=
d the corresponding M7 NVIC input at the same index=2E In the current patch=
, the 160 NVIC inputs are declared but not yet wired (all inputs float low,=
 which is harmless for the Linux+remoteproc use case)=2E Full wiring would =
be a follow-up, done incrementally per peripheral as M7 firmware use cases =
are added

Hi Gaurav,

It shouldn't be too hard to add and wire up the NVIC: First create a patch=
 before this one which adds an array of 160 TYPE_SPLIT_IRQ, initialize all =
in the init function to have two out IRQs, wire up all 160 gic IRQs at out =
index 0 where the GIC is initialized, and wire the peripherals to the array=
 instead of the GIC=2E Then the NVIC could be added in this patch too where=
 all its 160 IRQs would be wired to out index 1 of the array=2E This way, w=
e wouldn't have to worry about the IRQ wiring any more=2E Does this sound f=
easible or would there still something be missing?

Best regards,
Bernhard

>
>> >+        qdev_prop_set_bit(cm7dev, "enable-bitband", true);
>>
>> Is this correct?
>>
>
>It has been corrected to 'false'=2E Will be updated in the next patch ser=
ies version=2E
>
>> Best regards,
>> Bernhard
>>
>> >+
>> >+        /* CM7 vector table base (configurable) */
>> >+        qdev_prop_set_uint32(cm7dev, "init-nsvtor",
>> >+ s->cm7_vector_base);
>> >+
>> >+        /* Connect CM7 clocks from CCM exported outputs */
>> >+        qdev_connect_clock_in(cm7dev, "cpuclk",
>> >+                              qdev_get_clock_out(ccmdev, "cm7_cpuclk"=
));
>> >+        qdev_connect_clock_in(cm7dev, "refclk",
>> >+                              qdev_get_clock_out(ccmdev, "cm7_refclk"=
));
>> >+        object_property_set_link(OBJECT(&s->cm7), "memory",
>> >+                                 OBJECT(get_system_memory()),
>> >+ &error_abort);
>> >+
>> >+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->cm7), errp)) {
>> >+            return;
>> >+        }
>> >+
>> >+        CPUState *m7cs =3D CPU(s->cm7=2Ecpu);
>> >+        cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
>> >+        m7cs->halted =3D 1;
>> >+    }
>> >+
>> >     /* GPTs */
>> >     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2=
,
>> >                             &error_abort); @@ -784,6 +903,8 @@ static
>> >void fsl_imx8mp_realize(DeviceState *dev, Error **errp)  static const
>> >Property fsl_imx8mp_properties[] =3D {
>> >     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
>> >     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState,
>> >phy_connected, true),
>> >+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
>> >+                       cm7_vector_base, 0x80000000),
>> > };
>> >
>> > static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
>> >diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec index
>> >b84ac91a17=2E=2E0f92bf5dc8 100644
>> >--- a/hw/arm/imx8mp-evk=2Ec
>> >+++ b/hw/arm/imx8mp-evk=2Ec
>> >@@ -117,7 +117,8 @@ static void imx8mp_evk_machine_init(MachineClass
>> >*mc)  {
>> >     mc->desc =3D "NXP i=2EMX 8M Plus EVK Board";
>> >     mc->init =3D imx8mp_evk_init;
>> >-    mc->default_cpus =3D 4;
>> >+    mc->default_cpus =3D 5;
>> >+    mc->min_cpus =3D 5;
>> >     mc->max_cpus =3D FSL_IMX8MP_NUM_CPUS;
>> >     mc->default_ram_id =3D "imx8mp-evk=2Eram";
>> >     mc->default_ram_size =3D 6 * GiB;
>> >diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=
=2Eh
>> >index 94d198b932=2E=2E335e4beb6c 100644
>> >--- a/include/hw/arm/fsl-imx8mp=2Eh
>> >+++ b/include/hw/arm/fsl-imx8mp=2Eh
>> >@@ -10,6 +10,7 @@
>> > #define FSL_IMX8MP_H
>> >
>> > #include "target/arm/cpu=2Eh"
>> >+#include "hw/arm/armv7m=2Eh"
>> > #include "hw/char/imx_serial=2Eh"
>> > #include "hw/gpio/imx_gpio=2Eh"
>> > #include "hw/i2c/imx_i2c=2Eh"
>> >@@ -30,6 +31,7 @@
>> > #include "hw/timer/imx_gpt=2Eh"
>> > #include "hw/usb/hcd-dwc3=2Eh"
>> > #include "hw/watchdog/wdt_imx2=2Eh"
>> >+#include "hw/core/qdev-clock=2Eh"
>> > #include "hw/core/sysbus=2Eh"
>> > #include "qom/object=2Eh"
>> > #include "qemu/units=2Eh"
>> >@@ -43,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState,
>> >FSL_IMX8MP)  #define FSL_IMX8MP_MU1_A_IRQ  88
>> >
>> > enum FslImx8mpConfiguration {
>> >-    FSL_IMX8MP_NUM_CPUS         =3D 4,
>> >+    FSL_IMX8MP_NUM_CPUS         =3D 5,
>> >     FSL_IMX8MP_NUM_ECSPIS       =3D 3,
>> >     FSL_IMX8MP_NUM_GPIOS        =3D 5,
>> >     FSL_IMX8MP_NUM_GPTS         =3D 6,
>> >@@ -65,6 +67,10 @@ struct FslImx8mpState {
>> >     SysBusDevice   parent_obj;
>> >
>> >     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
>> >+    ARMv7MState        cm7;
>> >+    bool               enable_cm7;
>> >+    bool               cm7_booted;
>> >+    uint32_t           cm7_vector_base;
>> >     GICv3State         gic;
>> >     IMX8MPGPCState     gpc;
>> >     IMX8MPGPRState     gpr;
>> >@@ -91,6 +97,11 @@ struct FslImx8mpState {
>> >     bool               phy_connected;
>> > };
>> >
>> >+struct CM7CtlReq {
>> >+    FslImx8mpState *s;
>> >+    bool run;
>> >+};
>> >+
>> > enum FslImx8mpMemoryRegions {
>> >     FSL_IMX8MP_A53_DAP,
>> >     FSL_IMX8MP_AIPS1_CONFIGURATION,


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1620C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiem-0006D6-Nq; Tue, 25 Aug 2026 00:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wyiek-0006Ce-PT; Tue, 25 Aug 2026 00:21:02 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wyiei-0003ii-1R; Tue, 25 Aug 2026 00:21:02 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 712681D00144;
 Tue, 25 Aug 2026 00:20:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 25 Aug 2026 00:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1787631656; x=1787718056; bh=b+781eN3zL1DV+j8WdVUkBGQWppDyygz
 KeAJXlJZWWg=; b=gmYfH5qPu2yYbNP3hWLuP9/X6CuZBgwTgQeB3p5FG+SvbGDA
 IcOq/CPs52wEgIKGIa7b0MqDaceALCKRrVwiNYIbGC7CxmiHKMTu04bjZ5Asc7qN
 fbwpjIKuLkDbQCqOyRzxZd1itUYw7oeWNSbX/wz0Kipdrx8avY/E3W4Jrn++pj6l
 RLi9XZNZc2nvIdwyEggowRvRIG7IJdT7ZbyjmvaJgaFE9SQfoKnvzquuBKx2ECeu
 wBPtF9aDVsYF0O71Dzh6xISfkcBW8dqiGerfqlHREURgTUOLs5PVRve3pJy0FMv4
 hSedqaUQ9vyijUsnZqdBorG8xESoIAxR8xZ6PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787631656; x=
 1787718056; bh=b+781eN3zL1DV+j8WdVUkBGQWppDyygzKeAJXlJZWWg=; b=T
 /y6M4AauSXYvlO6WgOMnH4MOPy3lfDkvU9G8ZeDyxvQU281+HV/B2kvESYbdU0sG
 wk/PJKdmaS75IGXKkvyiALkwrGot567WdDokbKVOL1ktmqSeC9qm0g4MvXhy568B
 fYO4fhliOGrM5WLae3lCNBMZ+GnZSLHhSHyxcApykMsslntu8aGyhTgwonbqaUMf
 9bpYUVbKkViFH0EffRAZs0xhblMKQqEyArmyskRP+TCBkm0vM0PLPuTo1JxDfVlX
 eNOOary6SAUa4+oIWzT1TuqNMpIAS0CeMuaKrKL5Tro5SeUJNQ1xueAsXt+P7aMa
 wWuFtCP/nI4XBc1sV8gzw==
X-ME-Sender: <xms:JxiNakkIg5w01XvrI1gh8pslNd7PXw-WxXfxn8ZDCQBNjye8oxAjWg>
 <xme:JxiNanhe-UUNfcjS56SQjxcRj0GmC78uS83AAWhw6-lRcZaV19vvsRUSqiS-qUTFg
 22fA4b4hKYrojedX0R8ks1-2n14IZx36VFq1Q5wu0vmKSwGU-HURaM>
X-ME-Received: <xmr:JxiNasdjcEUWK1fSxz0TxFAgXfZUX4r_sAEgcZj23Y3ifujSPDICgoOs_Xajn6ud4EYbji0wqUFu7LP7hyR4x34jabM>
X-ME-Proxy-Cause: dmFkZTELm/yGqF/abJz4HJTB3Nxaack2JE5Mm+wLDqZSH6byP1nesleUbdtFA+Zp0ZzsFU
 SJBBS4saJkaiOSvvIAL2A/9bz+xLN8b31x7xFXP0si2seNfMp3UjcJ9c1jfmcqslLvp7Ou
 Fygu/boAmBT7stUV7ssOLyZ+VmdVo1ksuQFazlREGItSI6nCCK4W/yEbMl+XETlZTfGKIH
 vZwa3OmFMcWHH8zIkQDlBN4rmQAp5ZyTI2JLgpVkbVwLRmGFxpiZe9sPUlb2RUqfGAWrX7
 N/LOAl5pn/5Ry1OHYkHHfVyuKhcGODb4/WC/KxgbHZnjkRXXw9QVfNHf5Rx/qYjgOla9tY
 gVLFYMo87nvfq0iN5FKGLO6KAj4i2E1VuIgc9c8/MOT1MUSc5Z3KqEHomRwlOj5EXL14Vr
 +Vc18MdVRRUUWIZ5gBJ8y43mnBlAfO9XLmilzO6ehC+W3Ibs6+jBLuEWMerwCYW8RfDPkP
 xjNR34wgjlEexloVn14+wJK4hTtP1jI2p5JBq9ywAtBNCvM9HkMYqVMy90H2Xkhu042r3w
 mOA0VRFrmaRnIC7xJ5u0QgkuJbhdXyIwlJbzCx47T+ImLOhtJki34bc0GE2UO6wMS9n4RP
 FONrYDk0B3SYxCs9fy0h4brevCct38uBFWxU8bMc113UYJEmTjzrNbqIP2ww
X-ME-Proxy: <xmx:KBiNani14Pspn64a4eOzcMeQCiiyXT8MCb_du4FoRtuRiaRLAeGRWA>
 <xmx:KBiNakzjzOIKJvz0LQTT32iKlewgv74OFu52JCMhDb3Lopy7e5873g>
 <xmx:KBiNajMus6ZDNi4OHH63LdjXAVXXFMTg0qtkH271BzzYQBbA6t16sA>
 <xmx:KBiNalX02NTGkT_o2GArDdhddbDzm2_xnk5WZ2Ar9AQJJOVvsu75CQ>
 <xmx:KBiNap5YhfZTiButj3M_PgQdIX8jsF3WIGAS9HEloKk4-UB0GkC3TLYS>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 00:20:53 -0400 (EDT)
Message-ID: <4c1c01709d9e903fbe93fbce5b901ff959a5a01f.camel@alistair23.me>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell	
 <peter.maydell@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, 	qemu-arm@nongnu.org
Date: Tue, 25 Aug 2026 14:20:51 +1000
In-Reply-To: <20260627154225.863984-2-bin.meng@processmission.com>
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.149;
 envelope-from=alistair@alistair23.me; helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Sat, 2026-06-27 at 23:42 +0800, Bin Meng wrote:
> Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> in terms of ZynqMP PM firmware providers for clocks, resets, power
> domains and pin control. QEMU does not model those runtime firmware
> providers, so using such a DTB with -kernel currently requires users
> to edit the DTB before Linux can probe the boot-critical devices.
>=20
> Add a board DTB fix-up for direct kernel boot that removes those
> provider-only properties from the boot-critical nodes and rewrites
> their clocks to fixed reference clocks already present in the DTB.
> This keeps the user command line using the Buildroot-generated DTB
> while limiting the compatibility adjustment to devices modeled by
> QEMU.
>=20
> Document the direct boot flow, the SD and QSPI image layout details,
> and the remaining firmware and real-board peripheral limitations.
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>=20
> ---
>=20
> =C2=A0docs/system/arm/xlnx-zcu102.rst | 139
> +++++++++++++++++++++++++++++++-
> =C2=A0hw/arm/xlnx-zcu102.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 109 +++++++++++++++++++++++++
> =C2=A02 files changed, 247 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/system/arm/xlnx-zcu102.rst b/docs/system/arm/xlnx-
> zcu102.rst
> index 534cd1dc88..41ddd15592 100644
> --- a/docs/system/arm/xlnx-zcu102.rst
> +++ b/docs/system/arm/xlnx-zcu102.rst
> @@ -4,8 +4,30 @@ Xilinx ZynqMP ZCU102 (``xlnx-zcu102``)
> =C2=A0The ``xlnx-zcu102`` board models the Xilinx ZynqMP ZCU102 board.
> =C2=A0This board has 4 Cortex-A53 CPUs and 2 Cortex-R5F CPUs.
> =C2=A0
> +Supported devices
> +-----------------
> +
> +The machine is based on QEMU's Xilinx ZynqMP SoC model and includes
> +the following Processing System devices:
> +
> + * Cortex-A53 APU and Cortex-R5F RPU CPU cores
> + * Generic Interrupt Controller
> + * DDR memory
> + * On-chip memory
> + * Cadence UARTs
> + * Cadence GEM Ethernet controllers
> + * SDHCI controllers
> + * SPI controllers
> + * GQSPI controller
> + * RTC
> + * CAN controllers
> + * USB controllers
> + * SATA controller
> + * DMA controllers
> + * BBRAM and eFUSE devices
> +
> =C2=A0Machine-specific options
> -""""""""""""""""""""""""
> +------------------------
> =C2=A0
> =C2=A0The following machine-specific options are supported:
> =C2=A0
> @@ -17,3 +39,118 @@ virtualization
> =C2=A0=C2=A0 Set ``on``/``off`` to enable/disable emulating a guest CPU w=
hich
> implements the
> =C2=A0=C2=A0 Arm Virtualization Extensions. The default is ``off``.
> =C2=A0
> +Boot options
> +------------
> +
> +The ``xlnx-zcu102`` machine can start a Linux kernel directly with
> +``-kernel``. It does not provide a ZynqMP BootROM flow for loading a
> +Xilinx boot image from SD or QSPI flash, so images such as
> ``boot.bin``
> +or ``qspi.bin`` cannot be passed alone and expected to boot like
> they
> +would on real hardware.
> +
> +QEMU does not generate a built-in device tree for this machine. Pass
> a DTB
> +with ``-dtb``. For direct Linux boot with a real-board ZCU102 DTB,
> QEMU
> +applies compatibility adjustments for the boot-critical UART, SDHCI
> and
> +GQSPI nodes so that Linux can use the devices modeled by QEMU
> without
> +requiring user-side DTB edits.
> +
> +This is not the same as emulating the complete ZynqMP firmware
> stack. The
> +DTB can still contain non-boot devices that depend on board
> peripherals,
> +external clock chips, power domains, pin control, or firmware
> services
> +that QEMU does not model.
> +
> +Direct Linux boot with Buildroot
> +--------------------------------
> +
> +Buildroot has a ZCU102 defconfig. Buildroot 2026.05 release is
> tested at the
> +time of writing. From the Buildroot source tree:
> +
> +.. code-block:: bash
> +
> +=C2=A0 $ make zynqmp_zcu102_defconfig
> +=C2=A0 $ make
> +
> +The generated files are in ``output/images/``. The examples below
> use:
> +
> + * ``Image``
> + * ``zynqmp-zcu102-rev1.0.dtb``
> + * ``sdcard.img``
> + * ``qspi.bin`` if QSPI flash probing is desired
> +
> +QEMU's SD card model requires a power-of-two image size. Work on a
> copy
> +of the Buildroot SD image and resize the copy, not the original
> output:
> +
> +.. code-block:: bash
> +
> +=C2=A0 $ cp output/images/sdcard.img sdcard-qemu.img
> +=C2=A0 $ qemu-img resize -f raw sdcard-qemu.img 128M
> +
> +The real-board DTB enables the SDHCI controller at ``mmc@ff170000``.
> +In QEMU this is SD index 1, so attach the SD card with
> +``if=3Dsd,index=3D1``.
> +
> +Boot Linux with the Buildroot kernel and the native Buildroot DTB:
> +
> +.. code-block:: bash
> +
> +=C2=A0 $ qemu-system-aarch64 -M xlnx-zcu102 -m 2G -nographic \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel output/images/Image \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -dtb output/images/zynqmp-zcu102-rev1.0.d=
tb \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Dcdns,mmio,0xff000000,=
115200n8 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 console=3DttyPS0,115200 root=3D/dev/mmcblk0p2 rw
> rootwait" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive file=3Dsdcard-qemu.img,if=3Dsd,ind=
ex=3D1,format=3Draw
> +
> +This should get the kernel booting all the way to the Buildroot
> login
> +prompt on ``ttyPS0``.
> +
> +QSPI flash
> +----------
> +
> +The board creates two PS SPI NOR flashes first and the ZynqMP GQSPI
> +flashes after them. Therefore the first GQSPI flash is
> +``if=3Dmtd,index=3D2``. The remaining GQSPI flash backends use indices
> 3, 4
> +and 5.
> +
> +The Buildroot ``qspi.bin`` image is smaller than the 64 MiB
> +``n25q512a11`` flash model. To attach it as the first GQSPI flash,
> +place it in a 64 MiB raw backing file:
> +
> +.. code-block:: bash
> +
> +=C2=A0 $ qemu-img create -f raw qspi-cs0.img 64M
> +=C2=A0 $ dd if=3Doutput/images/qspi.bin of=3Dqspi-cs0.img bs=3D1M conv=
=3Dnotrunc
> +
> +Add the following drive to the direct Linux boot command above:
> +
> +.. code-block:: bash
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -drive file=3Dqspi-cs0.img,if=3Dmtd,index=
=3D2,format=3Draw
> +
> +With this drive attached, Linux should probe the ZynqMP GQSPI
> +controller and register the SPI NOR partitions from the DTB, for
> +example ``qspi-fsbl-uboot``, ``qspi-linux``, ``qspi-device-tree``
> and
> +``qspi-rootfs``.
> +
> +The default Buildroot ``qspi.bin`` is a boot image, not a root
> +filesystem image. The default DTB's ``qspi-rootfs`` partition is
> also
> +too small for Buildroot's ``rootfs.ext2``. Booting with the root
> +filesystem in QSPI flash therefore requires a custom image layout
> and
> +matching DTB changes.
> +
> +Known limitations
> +-----------------
> +
> +The machine does not emulate the complete real-board firmware stack.
> +In particular:
> +
> + * ZynqMP BootROM boot-mode selection is not modeled.
> + * Passing the Buildroot ``boot.bin`` with ``-bios`` does not boot
> Linux.
> + * Attaching ``qspi.bin`` as an MTD drive without ``-kernel`` does
> not
> +=C2=A0=C2=A0 boot from QSPI flash.
> + * ZynqMP PM firmware services are not modeled. For direct Linux
> boot,
> +=C2=A0=C2=A0 QEMU adjusts the supplied DTB only for the boot-critical UA=
RT,
> SDHCI
> +=C2=A0=C2=A0 and GQSPI nodes.
> + * Other real-board DTB nodes can still defer or fail probing when
> they
> +=C2=A0=C2=A0 depend on devices that are not present in the QEMU model, s=
uch as
> +=C2=A0=C2=A0 external I2C clock generators, board sensors, some GPIO
> consumers,
> +=C2=A0=C2=A0 PHYs, or non-boot DMA/display paths.
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 4e48970274..839e4e90d5 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -26,6 +26,7 @@
> =C2=A0#include "system/device_tree.h"
> =C2=A0#include "qom/object.h"
> =C2=A0#include "net/can_emu.h"
> +#include <libfdt.h>
> =C2=A0
> =C2=A0struct XlnxZCU102 {
> =C2=A0=C2=A0=C2=A0=C2=A0 MachineState parent_obj;
> @@ -43,6 +44,112 @@ struct XlnxZCU102 {
> =C2=A0#define TYPE_ZCU102_MACHINE=C2=A0=C2=A0 MACHINE_TYPE_NAME("xlnx-zcu=
102")
> =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(XlnxZCU102, ZCU102_MACHINE)
> =C2=A0
> +static bool zcu102_fdt_get_phandle(void *fdt, const char *node_path,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t *phandle=
)
> +{
> +=C2=A0=C2=A0=C2=A0 int offset;
> +
> +=C2=A0=C2=A0=C2=A0 offset =3D fdt_path_offset(fdt, node_path);
> +=C2=A0=C2=A0=C2=A0 if (offset < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 *phandle =3D fdt_get_phandle(fdt, offset);
> +=C2=A0=C2=A0=C2=A0 return *phandle !=3D 0;
> +}
> +
> +static void zcu102_fdt_nop_prop(void *fdt, const char *node_path,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *prop)
> +{
> +=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0 int offset;
> +
> +=C2=A0=C2=A0=C2=A0 offset =3D fdt_path_offset(fdt, node_path);
> +=C2=A0=C2=A0=C2=A0 if (offset < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D fdt_nop_property(fdt, offset, prop);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=3D -FDT_ERR_NOTFOUND) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s: Couldn't no=
p %s/%s: %s", __func__,
> node_path,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop, fdt_strerror(ret));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static void zcu102_fdt_fixup_clocks(void *fdt, const char
> *node_path,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ph=
andle)
> +{
> +=C2=A0=C2=A0=C2=A0 if (fdt_path_offset(fdt, node_path) < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 qemu_fdt_setprop_cells(fdt, node_path, "clocks", phan=
dle,
> phandle);
> +}
> +
> +static void zcu102_fdt_fixup_qemu_direct_boot_nodes(void *fdt)
> +{
> +=C2=A0=C2=A0=C2=A0 uint32_t pss_ref_clk;
> +=C2=A0=C2=A0=C2=A0 int i, j;
> +
> +=C2=A0=C2=A0=C2=A0 static const char * const provider_props[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "power-domains",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resets",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "assigned-clocks",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "assigned-clock-rates",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "assigned-clock-parents",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pinctrl-names",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pinctrl-0",
> +=C2=A0=C2=A0=C2=A0 };
> +=C2=A0=C2=A0=C2=A0 static const char * const direct_boot_nodes[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/axi/serial@ff000000",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/axi/serial@ff010000",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/axi/mmc@ff170000",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/axi/spi@ff0f0000",
> +=C2=A0=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * The Linux ZCU102 DTB inherits these boot-crit=
ical nodes from
> +=C2=A0=C2=A0=C2=A0=C2=A0 * arch/arm64/boot/dts/xilinx/zynqmp.dtsi:
> +=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 uart0: serial@ff000000
> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 uart1: serial@ff010000
> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 sdhci1: mmc@ff170000
> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 qspi: spi@ff0f0000
> +=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0 * zynqmp.dtsi, zynqmp-clk-ccf.dtsi and zynqmp-z=
cu102-revA.dts
> +=C2=A0=C2=A0=C2=A0=C2=A0 * wire them to PM firmware-backed clock, reset =
and pinctrl
> providers.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Linux reaches that firmware through zynqmp_pm=
_invoke_fn() in
> +=C2=A0=C2=A0=C2=A0=C2=A0 * drivers/firmware/xilinx/zynqmp-core.c; exampl=
es include
> +=C2=A0=C2=A0=C2=A0=C2=A0 * zynqmp_pm_query_data() for drivers/clk/zynqmp=
/clkc.c,
> +=C2=A0=C2=A0=C2=A0=C2=A0 * zynqmp_pm_reset_assert() for drivers/reset/re=
set-zynqmp.c,
> and
> +=C2=A0=C2=A0=C2=A0=C2=A0 * zynqmp_pm_pinctrl_request() for drivers/pinct=
rl/pinctrl-
> zynqmp.c.
> +=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Direct kernel boot has no PM firmware stage f=
or those calls.
> Bypass the
> +=C2=A0=C2=A0=C2=A0=C2=A0 * firmware-backed providers for just these node=
s and describe
> their clocks
> +=C2=A0=C2=A0=C2=A0=C2=A0 * as fixed inputs, avoiding a QEMU model of the=
 runtime PM
> firmware.
> +=C2=A0=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0 * The Linux ZynqMP clock description defines ps=
s-ref-clk as a
> 33.333333 MHz
> +=C2=A0=C2=A0=C2=A0=C2=A0 * fixed clock with #clock-cells =3D <0>. Use it=
 as a conservative
> direct-boot
> +=C2=A0=C2=A0=C2=A0=C2=A0 * fallback for both clock inputs of these devic=
es. That
> satisfies the
> +=C2=A0=C2=A0=C2=A0=C2=A0 * existing two clock-names entries while keepin=
g the DTB
> independent from
> +=C2=A0=C2=A0=C2=A0=C2=A0 * the firmware-backed ZynqMP clock controller.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (!zcu102_fdt_get_phandle(fdt, "/pss-ref-clk", &pss=
_ref_clk))
> {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(direct_boot_nodes); i++)=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0; j < ARRAY_SIZE(=
provider_props); j++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zcu10=
2_fdt_nop_prop(fdt, direct_boot_nodes[i],
> provider_props[j]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff000000",
> pss_ref_clk);
> +=C2=A0=C2=A0=C2=A0 zcu102_fdt_fixup_clocks(fdt, "/axi/serial@ff010000",
> pss_ref_clk);
> +=C2=A0=C2=A0=C2=A0 zcu102_fdt_fixup_clocks(fdt, "/axi/mmc@ff170000", pss=
_ref_clk);
> +=C2=A0=C2=A0=C2=A0 zcu102_fdt_fixup_clocks(fdt, "/axi/spi@ff0f0000", pss=
_ref_clk);

I don't think this is something QEMU should be doing. Modifying the DTB
on the fly just seems very brittle and prone to breakage and confusion.

Alistair

> +}
> =C2=A0
> =C2=A0static bool zcu102_get_secure(Object *obj, Error **errp)
> =C2=A0{
> @@ -98,6 +205,8 @@ static void zcu102_modify_dtb(const struct
> arm_boot_info *binfo, void *fdt)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strfreev(node_path);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 zcu102_fdt_fixup_qemu_direct_boot_nodes(fdt);
> =C2=A0}
> =C2=A0
> =C2=A0static void bbram_attach_drive(XlnxBBRam *dev)


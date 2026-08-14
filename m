Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55E0C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuttN-0000zi-MA; Fri, 14 Aug 2026 11:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuttK-0000zH-D3; Fri, 14 Aug 2026 11:32:19 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuttI-0006X7-PZ; Fri, 14 Aug 2026 11:32:18 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A37BA1400041;
 Fri, 14 Aug 2026 11:32:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 11:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786721535; x=1786807935; bh=/R2+qfqo89CJTk5A9ZfK/lTuy9hfMRLo
 37jFOzHuERw=; b=Tbf5Ykjw1T2orzedWP5Ijq7Ntn9X5Gwsia0PQez1nA0MsJQU
 rhn52cjMaI80azkbq3LZbyST18JkhsLOp5NP+xPV+3PZV2OT3eSLeQWEwTM9hjjf
 V360k3IlWba37IJApGMagm0iGBEkQpkbud9rySAy2BU53pKKhypzp8LDl/pgFN7w
 ZV4ces/lHG5tAREYIVtdvaC0UHlbm1TRpswaVFTgZwl+MUwE1RZJIsf/RkcBSg2J
 YxrkJOKkdZ0zWrUdM6vJSbonyvHXJ+zjdSXNzE30Mn0zd8F/+jiNpxBmXgPpkx7J
 iB8W6KhVqkXBJ/cliLxbdGlp6znetgsl9tx6qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786721535; x=
 1786807935; bh=/R2+qfqo89CJTk5A9ZfK/lTuy9hfMRLo37jFOzHuERw=; b=J
 IvHpiiz6xQWZ1IJIebdAcOTWcuHeOcfn6rcsAyeX8e2vyJlk8GE/5kGeEPTvoqnw
 kaxpnzSaT6wgf1rMO2PR00m9eyhUy0fpCHzVtTTqkKmsCRa4qasGn4MMf+Bu7FXH
 8h11MacI6TmK5w4ioivpFLIlsGtLl0O4GAfSblhruI9CtNZrz+4w1uCZF/DMoOwl
 kuT75sb6H0Wt5ZxH3vLB0aZdKpLu2wW9poNiHaTrhg4ZoXHXLA/kK9bCKdlXTKK5
 ge0FsqiRjI3ZCg6IPOsXFUuJYTf5WWWK6vFggg+eP8ylF+BKGfo4Ubva5PE8hN7P
 UC+o3KPsXEpuBRVTLMZIg==
X-ME-Sender: <xms:_zR_aiD_ipvsZt-LatjVIaNZmzrmhQN0L6WzmO6VhJEPTECURIh2Gg>
 <xme:_zR_an-ue1uhX-zcLSG_I1kif2wMBzrbtKXFRurCRT2VLKMgUqflqH5UDS2xGuK6v
 vvnPqnuu4d2aEq0tQtIyAH-Rpzx8nHkbncRXRnDgzzJMzEh0pxNz7U5>
X-ME-Received: <xmr:_zR_apF5bpkpMwEfcfZ2yOQ1MhV8OJiMJ-YNsurajP6z4qUqVD0yNozkX36MuLOHj_69ZQ>
X-ME-Proxy-Cause: dmFkZTFlcj0k83MDKof4hWght9wvWbkOEwpuDE0fkMrVuocNeArmHJvdtT3rMdqqS6m02n
 7G9VwTmOi+iFCwtEEtGd5g+HURCZegAA3VRKonw6oNd9hCxrBsSdMb5WcJxoxnocI1jCs0
 LjVabEAzdNLrkARToj04UtE1/VO8+PN1epJRjYUcf3ArmuxMm5RJIT4Yt+xZbVBidK8PbN
 wwoA5U9URoTlQlh4RcNcswyv+srWLgMXTBQUhLL0uGD0WJmcf5qKks7Jma28s6ep1TiN8o
 gNaImo+biO3HSch2MzzB7c6Ah++9GMQjO7ZiFNRFf78KMv6sxke13FdjYxkStrg/08hDtC
 0a0+b/uTiuedGHXhMqSDax5b4hZvwXU4dTC6BDPF/xOYds/yiyIPit2sNLMO3HEYJewpWM
 cuPJCyHVpFDxHepVG445Y0xoV2z2KFJrHLcHIv/1YfsS6k6kOVt+q1wBN9QyHJfgPLxvQB
 40JMwqBGmgY3X1nKZc3Yatcl3wNamJi1oUz0jYCYTzNr6UEJ7Nxnve/uLNYeHxWKzipr3k
 Mq3SJj/NG2mPoWtP9cP5NpSv7GyTQdwqTI/e8fc7EmqrHeHzVmL3PwRl4kNKV/F5ve54hf
 iinRycae2bXIAv2SXz1AgRT9I+HZ2we9kkRAgdJngctIVQ1UJ1D0rFx0UAbA
X-ME-Proxy: <xmx:_zR_alPvGoDY4nTveZFrzAj9bWMARQij_Pcsjq1tjg68Bphhvwv4fw>
 <xmx:_zR_ajcLE_wlZgZatQh5-IFQtNu5LYRnZAS9ZGCMEK-gdj5E3AvQwQ>
 <xmx:_zR_aqtahP6IQeqiuUnnhNC8z8RkSmakQgr2p-WcmV43BuGTeRINsA>
 <xmx:_zR_asn5iVzT7_A0NDY_3LHcXubZoxzewnr4scfz67WseawUBmfrKw>
 <xmx:_zR_ar1oDIx1EW1ELVmmuE9Cks8wbk0FyUwyRXATAVZMpxs61T479i8W>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:32:15 -0400 (EDT)
Message-ID: <8316af1480bdd869f8b2e81eb60ac24fa1d8698d.camel@alistair23.me>
Subject: Re: [PATCH 20/20] hw/arm: xilinx_zynq: Store boot info in the
 machine state
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Date: Sat, 15 Aug 2026 01:32:14 +1000
In-Reply-To: <20260813154918.996812-21-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
 <20260813154918.996812-21-bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-08-13 at 23:49 +0800, Bin Meng wrote:
> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
>=20
> Move the boot info into the existing ZynqMachineState.
>=20
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
>=20
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into
> XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to
> RaspiMachineState")
>=20
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>=20
> ---
>=20
> =C2=A0hw/arm/xilinx_zynq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 ++++++++---------
> =C2=A0include/hw/arm/xilinx_zynq.h |=C2=A0 2 ++
> =C2=A02 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 6c83439017..f314897540 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -103,8 +103,6 @@ static void zynq_write_board_setup(ARMCPU *cpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(b=
oard_setup_blob), BOARD_SETUP_ADDR);
> =C2=A0}
> =C2=A0
> -static struct arm_boot_info zynq_binfo =3D {};
> -
> =C2=A0static void gem_init(uint32_t base, qemu_irq irq)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev;
> @@ -268,7 +266,7 @@ static void zynq_init(MachineState *machine)
> =C2=A0=C2=A0=C2=A0=C2=A0 busdev =3D SYS_BUS_DEVICE(dev);
> =C2=A0=C2=A0=C2=A0=C2=A0 sysbus_realize_and_unref(busdev, &error_fatal);
> =C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.gic_cpu_if_addr =3D MPCORE_PERIPHBASE + 0x=
100;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.gic_cpu_if_addr =3D MPCORE_PER=
IPHBASE +
> 0x100;
> =C2=A0=C2=A0=C2=A0=C2=A0 sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE =
+ 0x2000, NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0 for (n =3D 0; n < smp_cpus; n++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* See "hw/intc/arm_gic.=
h" for the IRQ line association */
> @@ -444,13 +442,14 @@ static void zynq_init(MachineState *machine)
> =C2=A0=C2=A0=C2=A0=C2=A0 create_unimplemented_device("zynq.qos301_dmac", =
0xF8947000,
> 0x130);
> =C2=A0=C2=A0=C2=A0=C2=A0 create_unimplemented_device("zynq.qos301_iou", 0=
xF8948000,
> 0x130);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.ram_size =3D machine->ram_size;
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.board_id =3D 0xd32;
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.loader_start =3D 0;
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.board_setup_addr =3D BOARD_SETUP_ADDR;
> -=C2=A0=C2=A0=C2=A0 zynq_binfo.write_board_setup =3D zynq_write_board_set=
up;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.ram_size =3D machine->ram_size=
;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.board_id =3D 0xd32;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.loader_start =3D 0;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.board_setup_addr =3D BOARD_SET=
UP_ADDR;
> +=C2=A0=C2=A0=C2=A0 zynq_machine->bootinfo.write_board_setup =3D
> zynq_write_board_setup;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_=
binfo);
> +=C2=A0=C2=A0=C2=A0 arm_load_kernel(zynq_machine->cpu[0], machine,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &zynq_machine->bootinfo);
> =C2=A0}
> =C2=A0
> =C2=A0static void zynq_machine_class_init(ObjectClass *oc, const void
> *data)
> diff --git a/include/hw/arm/xilinx_zynq.h
> b/include/hw/arm/xilinx_zynq.h
> index cefb7789ff..669c516ad1 100644
> --- a/include/hw/arm/xilinx_zynq.h
> +++ b/include/hw/arm/xilinx_zynq.h
> @@ -14,6 +14,7 @@
> =C2=A0
> =C2=A0#include "target/arm/cpu-qom.h"
> =C2=A0#include "hw/core/qdev-clock.h"
> +#include "hw/arm/boot.h"
> =C2=A0
> =C2=A0#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
> =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
> @@ -25,6 +26,7 @@ struct ZynqMachineState {
> =C2=A0=C2=A0=C2=A0=C2=A0 Clock *ps_clk;
> =C2=A0=C2=A0=C2=A0=C2=A0 ARMCPU *cpu[ZYNQ_MAX_CPUS];
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t boot_mode;
> +=C2=A0=C2=A0=C2=A0 struct arm_boot_info bootinfo;
> =C2=A0};
> =C2=A0
> =C2=A0#endif /* QEMU_ARM_ZYNQ_H */


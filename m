Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F9606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMwfi-00050x-Mf; Fri, 30 Oct 2026 20:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMwff-000500-Ok; Fri, 30 Oct 2026 20:10:07 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMwfd-0005iY-CX; Fri, 30 Oct 2026 20:10:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA36A60C0DB;
 Sat, 31 Oct 2026 01:09:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 9e_z2L1I9kjY; Sat, 31 Oct 2026 01:09:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D12A760C072; Sat, 31 Oct 2026 01:09:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA50A13996F;
 Sat, 31 Oct 2026 01:09:55 +0100 (CET)
Date: Sat, 31 Oct 2026 01:09:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yonggang Luo <luoyonggang@gmail.com>
cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Felipe Balbi <balbi@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
Message-ID: <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026, Yonggang Luo wrote:
> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the type_init
> function that calls type_register_static(). A later change needs to pass a

That's the point of the macro to hide the boiler plate code.

> target mask into that registration, and the macros have no parameter for it.

Couldn't you just change the macros to take that parameter instead of 
expanding it everywhere?

Regards,
BALATON Zoltan

> This series expands every caller first, with no behavior change, so the
> follow-up only replaces the type_register_static() call.
>
> Each machine file gains a class_init function, a TypeInfo, and a type_init
> function that calls type_register_static(). The last patch removes
> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/boards.h.
>
> Yonggang Luo (15):
>  hw/alpha: expand DEFINE_MACHINE in dp264.c
>  hw/m68k: expand DEFINE_MACHINE for M68K machines
>  hw/microblaze: expand DEFINE_MACHINE for MicroBlaze
>  hw/tricore: expand DEFINE_MACHINE in tricore_testboard.c
>  hw/arm: expand DEFINE_MACHINE for ARM machines
>  hw/riscv: expand DEFINE_MACHINE for RISC-V machines
>  hw/core/null-machine: expand DEFINE_MACHINE
>  hw/mips: expand DEFINE_MACHINE for MIPS machines
>  hw/ppc: expand DEFINE_MACHINE for PowerPC machines
>  hw/sh4: expand DEFINE_MACHINE in r2d.c
>  hw/sparc: expand DEFINE_MACHINE in leon3.c
>  hw/xenpv: expand DEFINE_MACHINE in xen_machine_pv.c
>  hw/xtensa: expand DEFINE_MACHINE in sim.c
>  hw/xtensa: expand DEFINE_MACHINE in virt.c
>  hw/core/boards: remove unused DEFINE_MACHINE* macros
>
> hw/alpha/dp264.c                    | 18 +++++++++--
> hw/arm/bananapi_m2u.c               | 18 +++++++++--
> hw/arm/cubieboard.c                 | 19 +++++++++---
> hw/arm/digic_boards.c               | 18 +++++++++--
> hw/arm/imx25_pdk.c                  | 18 +++++++++--
> hw/arm/imx8mm-evk.c                 | 20 +++++++++---
> hw/arm/integratorcp.c               | 14 ++++++---
> hw/arm/kzm.c                        | 18 +++++++++--
> hw/arm/max78000fthr.c               | 17 ++++++++--
> hw/arm/mcimx6ul-evk.c               | 18 +++++++++--
> hw/arm/mcimx7d-sabre.c              | 20 +++++++++---
> hw/arm/msf2-som.c                   | 17 ++++++++--
> hw/arm/netduino2.c                  | 17 ++++++++--
> hw/arm/netduinoplus2.c              | 17 ++++++++--
> hw/arm/olimex-stm32-h405.c          | 18 +++++++++--
> hw/arm/orangepi.c                   | 19 +++++++++---
> hw/arm/stm32vldiscovery.c           | 18 +++++++++--
> hw/core/null-machine.c              | 18 +++++++++--
> hw/m68k/an5206.c                    | 18 +++++++++--
> hw/m68k/mcf5208.c                   | 18 +++++++++--
> hw/microblaze/petalogix_ml605_mmu.c | 19 ++++++++++--
> hw/microblaze/xlnx-zynqmp-pmu.c     | 19 ++++++++++--
> hw/mips/boston.c                    | 18 +++++++++--
> hw/mips/fuloong2e.c                 | 18 +++++++++--
> hw/mips/malta.c                     | 12 ++++++--
> hw/ppc/amigaone.c                   | 18 +++++++++--
> hw/ppc/pegasos.c                    | 21 ++++++++-----
> hw/ppc/ppc440_bamboo.c              | 18 +++++++++--
> hw/ppc/prep.c                       | 18 +++++++++--
> hw/ppc/sam460ex.c                   | 18 +++++++++--
> hw/ppc/virtex_ml507.c               | 18 +++++++++--
> hw/riscv/boston-aia.c               | 18 +++++++++--
> hw/riscv/microblaze-v-generic.c     | 18 +++++++++--
> hw/sh4/r2d.c                        | 18 +++++++++--
> hw/sparc/leon3.c                    | 18 +++++++++--
> hw/tricore/tricore_testboard.c      | 18 +++++++++--
> hw/xenpv/xen_machine_pv.c           | 18 +++++++++--
> hw/xtensa/sim.c                     | 18 +++++++++--
> hw/xtensa/virt.c                    | 18 +++++++++--
> include/hw/core/boards.h            | 48 -----------------------------
> 40 files changed, 605 insertions(+), 142 deletions(-)
>
>


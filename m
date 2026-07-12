Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF774C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 15:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wivrA-0008I0-C8; Sun, 12 Jul 2026 11:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wivr3-0008HG-2j
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 11:12:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wivqw-0006Kf-7o
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 11:12:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso23060035e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783869140; x=1784473940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bE1ogIVM9CDSSK/3uFYAFG4jqyUStQYpxbMcC9RYUK0=;
 b=Mrh5L4X3W5Q/EPXM9YMsLfymLxofq0c61rOmV4pTehJEwkfqMYKwSZHxtSJk+LPF1+
 DsY4ijC+17p+mjdwEtReCcbxLWd05JS8gLF65zMV2uFo+Ml6aE+96DDalBchq2d2yeN8
 6fdhGy1sAT0G1u+2IibScBJJ88LlTJdsI29Z5SQgiHLgTrMuU3xXLAAGO37hv0E8PNo/
 K8Fzyc9m10WZJuoTolc9CwtaWavL2JsI4RPShUVITDEg5xPlyNr/VOKpJKs20KT/lQ+O
 XXMhj29XP/QZj2yulWk+HLXpah2N3PT0fOjPTLsGrLJMc5FNKm2tB8a4LXe4IWGcFly5
 75FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783869140; x=1784473940;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bE1ogIVM9CDSSK/3uFYAFG4jqyUStQYpxbMcC9RYUK0=;
 b=JecCYRuPrzM3YvHNOn7EEW9MOeOcf+8VB87fX/wHBrisnJ+gCc7eKRSDXFs/n8mYbu
 Jo+YMT2m0hCGQETOO+3gW1qOjqQ5B0GuMYV8FPMRpH3yJaftEzUxSv9Ps6eHLZCBM6wg
 4r4kZuIvTrCK84AYnfCFWF1n5EWi/4yFAGoJSQO61xkoI0V53ko/ejJ1FYnQHCeJZdH0
 Pdd/NJnKIMfRto3FTUtGaApr2mO14zYB8q33jvqoXSGmNd/g+qhzMdSC23hjpVTPjkoH
 vWwSjefmSagHWmRXsnApSQ2EeAAmlrVa1LLvRCd8sITcs4LF7mYTJlJdkcn6Hb1Ro1CE
 I64g==
X-Forwarded-Encrypted: i=1;
 AHgh+Roz7/kVlhynZ19peuw5u/4wRIHQZ0Ba528Rsz/pNbObRYUMAzwUuPKKplcywZLmYJXgM2CIJqjPDstm@nongnu.org
X-Gm-Message-State: AOJu0Yyw5nVDkf3+OIPQfQzfe8OYC3bFVYdZh8aDZ9pzW0zwEQFrdif6
 UBSvUbVq52mKaeEI4giZZBMpdu/JCI4AJ8toT7At+8eb9bKi7eUE6gPi
X-Gm-Gg: AfdE7ckP7VkDwMMl4UGs/1wpjunJ6ZYtLzfLmN/VdRAIi1hl4Dc4tyEWip+3kabYbRM
 4lwq+VlO8qJl9gLgWfMO+XbLyj/bKXJpn9l0kjdIka8X7LcBMHFRzm3Lnd4JPpnbm5p4t5lxRtC
 JhJkS0ZQAN6R2EtaP53BeCgeblorrfY+XpEa9AUeEKeyiXQdXqG0ZPaFVQVuohGjLEzpw6ta4ZE
 d7F72xfMJEncNVgB4fn3/OraTM9qTlS4bjOAcBzMYw+t9vVtvFTBo7sqQPIa0j4Tq38v7SsNJfh
 4AtE3aoJmCOuw0u5zXdZCIt/ekz7vq1WnugutSIvztMkWiHQWZD8G8z+c9bT3Uz4pHykig/hNun
 o2eq7iK9ymzjtG8AxslBwS0xIkDuxkhs5IIcATWnMqGCxO66qtPLkvWs4zKjh9huqbYM6BJ4+YH
 c7yEhEG4qB7JpRa23N5dQh2BtmRamuYe8ppv4l5M7wKWbe5ME=
X-Received: by 2002:a05:600c:6d8c:b0:493:d0f7:69c3 with SMTP id
 5b1f17b1804b1-493f882ec68mr35953235e9.33.1783869139326; 
 Sun, 12 Jul 2026 08:12:19 -0700 (PDT)
Received: from ehlo.thunderbird.net (p5b3df423.dip0.t-ipconnect.de.
 [91.61.244.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f4f09f89sm408711585e9.10.2026.07.12.08.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 08:12:18 -0700 (PDT)
Date: Sun, 12 Jul 2026 15:12:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>,
 =?ISO-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 094/134] hw/arm: Give memory regions an explicit owner
In-Reply-To: <20260711223707.42139-95-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-95-graf@amazon.com>
Message-ID: <5A08CB9F-0699-41D6-9710-D5D5C3730C31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 11=2E Juli 2026 22:36:27 UTC schrieb Alexander Graf <graf@amazon=2Ecom>=
:
>Convert memory_region_init*() calls that pass NULL owner to pass
>the enclosing SoC device or machine instead=2E
>
>Static helpers make_ram()/make_ram_alias() in mps2=2Ec and mps2-tz=2Ec,
>create_tag_ram() in virt=2Ec, and exynos4_boards_init_ram() gain an
>Object *owner first argument=2E armsse=2Ec:make_alias() and
>aspeed_install_boot_rom() already carry a QOM-derived first
>argument; use it=2E
>
>hw/arm/omap1=2Ec is handled in a separate commit as its 20+ non-QOM
>sub-init helpers all need owner threading=2E
>
>No functional change intended=2E
>
>Assisted-by: Kiro
>Signed-off-by: Alexander Graf <graf@amazon=2Ecom>

For the imx machines we don't care about migration compatibility, so:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/arm/armsse=2Ec            |  8 ++++----
> hw/arm/aspeed=2Ec            |  2 +-
> hw/arm/aspeed_soc_common=2Ec |  2 +-
> hw/arm/exynos4210=2Ec        |  2 +-
> hw/arm/exynos4_boards=2Ec    |  8 ++++----
> hw/arm/fsl-imx25=2Ec         |  2 +-
> hw/arm/fsl-imx31=2Ec         |  2 +-
> hw/arm/fsl-imx6=2Ec          |  2 +-
> hw/arm/fsl-imx6ul=2Ec        |  2 +-
> hw/arm/fsl-imx7=2Ec          |  8 ++++----
> hw/arm/imx25_pdk=2Ec         |  2 +-
> hw/arm/integratorcp=2Ec      |  2 +-
> hw/arm/kzm=2Ec               |  2 +-
> hw/arm/max78000_soc=2Ec      |  2 +-
> hw/arm/mps2-tz=2Ec           |  9 +++++----
> hw/arm/mps2=2Ec              | 33 +++++++++++++++++----------------
> hw/arm/mps3r=2Ec             |  4 ++--
> hw/arm/msf2-soc=2Ec          |  2 +-
> hw/arm/msf2-som=2Ec          |  2 +-
> hw/arm/musca=2Ec             |  4 ++--
> hw/arm/musicpal=2Ec          |  2 +-
> hw/arm/omap_sx1=2Ec          | 14 +++++++-------
> hw/arm/realview=2Ec          |  8 ++++----
> hw/arm/sbsa-ref=2Ec          |  2 +-
> hw/arm/stellaris=2Ec         |  4 ++--
> hw/arm/stm32f100_soc=2Ec     |  2 +-
> hw/arm/stm32f205_soc=2Ec     |  2 +-
> hw/arm/stm32f405_soc=2Ec     |  4 ++--
> hw/arm/vexpress=2Ec          |  8 ++++----
> hw/arm/virt=2Ec              | 13 +++++++------
> hw/arm/xilinx_zynq=2Ec       |  2 +-
> hw/arm/xlnx-zynqmp=2Ec       |  2 +-
> 32 files changed, 83 insertions(+), 80 deletions(-)
>
>diff --git a/hw/arm/armsse=2Ec b/hw/arm/armsse=2Ec
>index ddb210c895=2E=2E81895ad370 100644
>--- a/hw/arm/armsse=2Ec
>+++ b/hw/arm/armsse=2Ec
>@@ -620,7 +620,7 @@ static uint32_t armsse_sys_config_value(ARMSSE *s, co=
nst ARMSSEInfo *info)
> static void make_alias(ARMSSE *s, MemoryRegion *mr, MemoryRegion *contai=
ner,
>                        const char *name, hwaddr base, hwaddr size, hwadd=
r orig)
> {
>-    memory_region_init_alias(mr, NULL, name, container, orig, size);
>+    memory_region_init_alias(mr, OBJECT(s), name, container, orig, size)=
;
>     /* The alias is even lower priority than unimplemented_device region=
s */
>     memory_region_add_subregion_overlap(container, base, mr, -1500);
> }
>@@ -1161,7 +1161,7 @@ static void armsse_realize(DeviceState *dev, Error =
**errp)
>         SysBusDevice *sbd_mpc;
>         uint32_t sram_bank_size =3D 1 << s->sram_addr_width;
>=20
>-        memory_region_init_ram(&s->sram[i], NULL, ramname,
>+        memory_region_init_ram(&s->sram[i], OBJECT(dev), ramname,
>                                sram_bank_size, errp);
>         g_free(ramname);
>         if (*errp) {
>@@ -1226,11 +1226,11 @@ static void armsse_realize(DeviceState *dev, Erro=
r **errp)
>=20
>     if (info->has_tcms) {
>         /* The SSE-300 has an ITCM at 0x0000_0000 and a DTCM at 0x2000_0=
000 */
>-        memory_region_init_ram(&s->itcm, NULL, "sse300-itcm", 512 * KiB,=
 errp);
>+        memory_region_init_ram(&s->itcm, OBJECT(dev), "sse300-itcm", 512=
 * KiB, errp);
>         if (*errp) {
>             return;
>         }
>-        memory_region_init_ram(&s->dtcm, NULL, "sse300-dtcm", 512 * KiB,=
 errp);
>+        memory_region_init_ram(&s->dtcm, OBJECT(dev), "sse300-dtcm", 512=
 * KiB, errp);
>         if (*errp) {
>             return;
>         }
>diff --git a/hw/arm/aspeed=2Ec b/hw/arm/aspeed=2Ec
>index 2e76e09f8f=2E=2Ef9249a9851 100644
>--- a/hw/arm/aspeed=2Ec
>+++ b/hw/arm/aspeed=2Ec
>@@ -201,7 +201,7 @@ static void aspeed_machine_init(MachineState *machine=
)
>     if (machine->kernel_filename && sc->num_cpus > 1) {
>         /* With no u-boot we must set up a boot stub for the secondary C=
PU */
>         MemoryRegion *smpboot =3D g_new(MemoryRegion, 1);
>-        memory_region_init_ram(smpboot, NULL, "aspeed=2Esmpboot",
>+        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed=2Esmpboot",
>                                0x80, &error_abort);
>         memory_region_add_subregion(get_system_memory(),
>                                     AST_SMP_MAILBOX_BASE, smpboot);
>diff --git a/hw/arm/aspeed_soc_common=2Ec b/hw/arm/aspeed_soc_common=2Ec
>index 780a9659cc=2E=2Ec79b27c561 100644
>--- a/hw/arm/aspeed_soc_common=2Ec
>+++ b/hw/arm/aspeed_soc_common=2Ec
>@@ -177,7 +177,7 @@ void aspeed_install_boot_rom(AspeedSoCState *soc, Blo=
ckBackend *blk,
> {
>     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(soc);
>=20
>-    memory_region_init_rom(boot_rom, NULL, "aspeed=2Eboot_rom", rom_size=
,
>+    memory_region_init_rom(boot_rom, OBJECT(soc), "aspeed=2Eboot_rom", r=
om_size,
>                            &error_abort);
>     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
>                                         boot_rom, 1);
>diff --git a/hw/arm/exynos4210=2Ec b/hw/arm/exynos4210=2Ec
>index 74ce36c1e6=2E=2E676915e814 100644
>--- a/hw/arm/exynos4210=2Ec
>+++ b/hw/arm/exynos4210=2Ec
>@@ -660,7 +660,7 @@ static void exynos4210_realize(DeviceState *socdev, E=
rror **errp)
>                                 &s->irom_alias_mem);
>=20
>     /* Internal RAM */
>-    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210=2Eiram",
>+    memory_region_init_ram(&s->iram_mem, OBJECT(socdev), "exynos4210=2Ei=
ram",
>                            EXYNOS4210_IRAM_SIZE, &error_fatal);
>     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
>                                 &s->iram_mem);
>diff --git a/hw/arm/exynos4_boards=2Ec b/hw/arm/exynos4_boards=2Ec
>index dce2c24860=2E=2E8430317815 100644
>--- a/hw/arm/exynos4_boards=2Ec
>+++ b/hw/arm/exynos4_boards=2Ec
>@@ -88,14 +88,14 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
>     }
> }
>=20
>-static void exynos4_boards_init_ram(Exynos4BoardState *s,
>+static void exynos4_boards_init_ram(Object *owner, Exynos4BoardState *s,
>                                     MemoryRegion *system_mem,
>                                     unsigned long ram_size)
> {
>     unsigned long mem_size =3D ram_size;
>=20
>     if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
>-        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210=2Edram1"=
,
>+        memory_region_init_ram(&s->dram1_mem, owner, "exynos4210=2Edram1=
",
>                                mem_size - EXYNOS4210_DRAM_MAX_SIZE,
>                                &error_fatal);
>         memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_AD=
DR,
>@@ -103,7 +103,7 @@ static void exynos4_boards_init_ram(Exynos4BoardState=
 *s,
>         mem_size =3D EXYNOS4210_DRAM_MAX_SIZE;
>     }
>=20
>-    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210=2Edram0", me=
m_size,
>+    memory_region_init_ram(&s->dram0_mem, owner, "exynos4210=2Edram0", m=
em_size,
>                            &error_fatal);
>     memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
>                                 &s->dram0_mem);
>@@ -122,7 +122,7 @@ exynos4_boards_init_common(MachineState *machine,
>     exynos4_board_binfo=2Egic_cpu_if_addr =3D
>             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
>=20
>-    exynos4_boards_init_ram(s, get_system_memory(),
>+    exynos4_boards_init_ram(OBJECT(machine), s, get_system_memory(),
>                             exynos4_board_ram_size[board_type]);
>=20
>     object_initialize_child(OBJECT(machine), "soc", &s->soc,
>diff --git a/hw/arm/fsl-imx25=2Ec b/hw/arm/fsl-imx25=2Ec
>index 7f65f4ca4b=2E=2Ef589c83567 100644
>--- a/hw/arm/fsl-imx25=2Ec
>+++ b/hw/arm/fsl-imx25=2Ec
>@@ -292,7 +292,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error=
 **errp)
>                                 &s->rom[1]);
>=20
>     /* initialize internal RAM (128 KB) */
>-    if (!memory_region_init_ram(&s->iram, NULL, "imx25=2Eiram",
>+    if (!memory_region_init_ram(&s->iram, OBJECT(dev), "imx25=2Eiram",
>                                 FSL_IMX25_IRAM_SIZE, errp)) {
>         return;
>     }
>diff --git a/hw/arm/fsl-imx31=2Ec b/hw/arm/fsl-imx31=2Ec
>index 190f863355=2E=2Efc387bbbc3 100644
>--- a/hw/arm/fsl-imx31=2Ec
>+++ b/hw/arm/fsl-imx31=2Ec
>@@ -204,7 +204,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error=
 **errp)
>                                 &s->rom);
>=20
>     /* initialize internal RAM (16 KB) */
>-    if (!memory_region_init_ram(&s->iram, NULL, "imx31=2Eiram",
>+    if (!memory_region_init_ram(&s->iram, OBJECT(dev), "imx31=2Eiram",
>                                 FSL_IMX31_IRAM_SIZE, errp)) {
>         return;
>     }
>diff --git a/hw/arm/fsl-imx6=2Ec b/hw/arm/fsl-imx6=2Ec
>index f0fbdc1a68=2E=2E99250910cb 100644
>--- a/hw/arm/fsl-imx6=2Ec
>+++ b/hw/arm/fsl-imx6=2Ec
>@@ -491,7 +491,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error =
**errp)
>                                 &s->caam);
>=20
>     /* OCRAM memory */
>-    if (!memory_region_init_ram(&s->ocram, NULL, "imx6=2Eocram",
>+    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6=2Eocram",
>                                 FSL_IMX6_OCRAM_SIZE, errp)) {
>         return;
>     }
>diff --git a/hw/arm/fsl-imx6ul=2Ec b/hw/arm/fsl-imx6ul=2Ec
>index adbb896fd1=2E=2Ef830dce9df 100644
>--- a/hw/arm/fsl-imx6ul=2Ec
>+++ b/hw/arm/fsl-imx6ul=2Ec
>@@ -699,7 +699,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Erro=
r **errp)
>     /*
>      * OCRAM memory
>      */
>-    memory_region_init_ram(&s->ocram, NULL, "imx6ul=2Eocram",
>+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6ul=2Eocram",
>                            FSL_IMX6UL_OCRAM_MEM_SIZE,
>                            &error_abort);
>     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_OCRAM_ME=
M_ADDR,
>diff --git a/hw/arm/fsl-imx7=2Ec b/hw/arm/fsl-imx7=2Ec
>index 07a5ae8cd0=2E=2Eceb26b4efd 100644
>--- a/hw/arm/fsl-imx7=2Ec
>+++ b/hw/arm/fsl-imx7=2Ec
>@@ -689,7 +689,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error =
**errp)
>     /*
>      * OCRAM memory
>      */
>-    memory_region_init_ram(&s->ocram, NULL, "imx7=2Eocram",
>+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx7=2Eocram",
>                            FSL_IMX7_OCRAM_MEM_SIZE,
>                            &error_abort);
>     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_MEM_=
ADDR,
>@@ -698,7 +698,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error =
**errp)
>     /*
>      * OCRAM EPDC memory
>      */
>-    memory_region_init_ram(&s->ocram_epdc, NULL, "imx7=2Eocram_epdc",
>+    memory_region_init_ram(&s->ocram_epdc, OBJECT(dev), "imx7=2Eocram_ep=
dc",
>                            FSL_IMX7_OCRAM_EPDC_SIZE,
>                            &error_abort);
>     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_EPDC=
_ADDR,
>@@ -707,7 +707,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error =
**errp)
>     /*
>      * OCRAM PXP memory
>      */
>-    memory_region_init_ram(&s->ocram_pxp, NULL, "imx7=2Eocram_pxp",
>+    memory_region_init_ram(&s->ocram_pxp, OBJECT(dev), "imx7=2Eocram_pxp=
",
>                            FSL_IMX7_OCRAM_PXP_SIZE,
>                            &error_abort);
>     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_PXP_=
ADDR,
>@@ -716,7 +716,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error =
**errp)
>     /*
>      * OCRAM_S memory
>      */
>-    memory_region_init_ram(&s->ocram_s, NULL, "imx7=2Eocram_s",
>+    memory_region_init_ram(&s->ocram_s, OBJECT(dev), "imx7=2Eocram_s",
>                            FSL_IMX7_OCRAM_S_SIZE,
>                            &error_abort);
>     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_S_AD=
DR,
>diff --git a/hw/arm/imx25_pdk=2Ec b/hw/arm/imx25_pdk=2Ec
>index 9351d53850=2E=2Ececfc25e9a 100644
>--- a/hw/arm/imx25_pdk=2Ec
>+++ b/hw/arm/imx25_pdk=2Ec
>@@ -104,7 +104,7 @@ static void imx25_pdk_init(MachineState *machine)
>         ram_size -=3D size;
>=20
>         if (size < ram[i]=2Esize) {
>-            memory_region_init_alias(&s->ram_alias, NULL, "ram=2Ealias",
>+            memory_region_init_alias(&s->ram_alias, OBJECT(machine), "ra=
m=2Ealias",
>                                      machine->ram,
>                                      alias_offset, ram[i]=2Esize - size)=
;
>             memory_region_add_subregion(get_system_memory(),
>diff --git a/hw/arm/integratorcp=2Ec b/hw/arm/integratorcp=2Ec
>index ed715a3eb8=2E=2E81c0bce8f9 100644
>--- a/hw/arm/integratorcp=2Ec
>+++ b/hw/arm/integratorcp=2Ec
>@@ -617,7 +617,7 @@ static void integratorcp_init(MachineState *machine)
>     /* SDRAM at address zero*/
>     memory_region_add_subregion(address_space_mem, 0, machine->ram);
>     /* And again at address 0x80000000 */
>-    memory_region_init_alias(ram_alias, NULL, "ram=2Ealias", machine->ra=
m,
>+    memory_region_init_alias(ram_alias, OBJECT(machine), "ram=2Ealias", =
machine->ram,
>                              0, ram_size);
>     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias=
);
>=20
>diff --git a/hw/arm/kzm=2Ec b/hw/arm/kzm=2Ec
>index 36e12bb362=2E=2E3e879c492d 100644
>--- a/hw/arm/kzm=2Ec
>+++ b/hw/arm/kzm=2Ec
>@@ -104,7 +104,7 @@ static void kzm_init(MachineState *machine)
>         ram_size -=3D size;
>=20
>         if (size < ram[i]=2Esize) {
>-            memory_region_init_alias(&s->ram_alias, NULL, "ram=2Ealias",
>+            memory_region_init_alias(&s->ram_alias, OBJECT(machine), "ra=
m=2Ealias",
>                                      machine->ram,
>                                      alias_offset, ram[i]=2Esize - size)=
;
>             memory_region_add_subregion(get_system_memory(),
>diff --git a/hw/arm/max78000_soc=2Ec b/hw/arm/max78000_soc=2Ec
>index b8e0265de2=2E=2E41cfaee925 100644
>--- a/hw/arm/max78000_soc=2Ec
>+++ b/hw/arm/max78000_soc=2Ec
>@@ -74,7 +74,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, =
Error **errp)
>=20
>     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
>=20
>-    memory_region_init_ram(&s->sram, NULL, "MAX78000=2Esram", SRAM_SIZE,
>+    memory_region_init_ram(&s->sram, obj, "MAX78000=2Esram", SRAM_SIZE,
>                            &err);
>=20
>     gcrdev =3D DEVICE(&s->gcr);
>diff --git a/hw/arm/mps2-tz=2Ec b/hw/arm/mps2-tz=2Ec
>index 32e3db1134=2E=2Ea57915e208 100644
>--- a/hw/arm/mps2-tz=2Ec
>+++ b/hw/arm/mps2-tz=2Ec
>@@ -338,7 +338,7 @@ static MemoryRegion *mr_for_raminfo(MPS2TZMachineStat=
e *mms,
>     assert(raminfo->mrindex < MPS2TZ_RAM_MAX);
>     ram =3D &mms->ram[raminfo->mrindex];
>=20
>-    memory_region_init_ram(ram, NULL, raminfo->name,
>+    memory_region_init_ram(ram, OBJECT(mms), raminfo->name,
>                            raminfo->size, &error_fatal);
>     if (raminfo->flags & IS_ROM) {
>         memory_region_set_readonly(ram, true);
>@@ -349,10 +349,10 @@ static MemoryRegion *mr_for_raminfo(MPS2TZMachineSt=
ate *mms,
> /* Create an alias of an entire original MemoryRegion @orig
>  * located at @base in the memory map=2E
>  */
>-static void make_ram_alias(MemoryRegion *mr, const char *name,
>+static void make_ram_alias(Object *owner, MemoryRegion *mr, const char *=
name,
>                            MemoryRegion *orig, hwaddr base)
> {
>-    memory_region_init_alias(mr, NULL, name, orig, 0,
>+    memory_region_init_alias(mr, owner, name, orig, 0,
>                              memory_region_size(orig));
>     memory_region_add_subregion(get_system_memory(), base, mr);
> }
>@@ -767,7 +767,8 @@ static void create_non_mpc_ram(MPS2TZMachineState *mm=
s)
>         if (p->flags & IS_ALIAS) {
>             SysBusDevice *mpc_sbd =3D SYS_BUS_DEVICE(&mms->mpc[p->mpc]);
>             MemoryRegion *upstream =3D sysbus_mmio_get_region(mpc_sbd, 1=
);
>-            make_ram_alias(&mms->ram[p->mrindex], p->name, upstream, p->=
base);
>+            make_ram_alias(OBJECT(mms), &mms->ram[p->mrindex], p->name,
>+                           upstream, p->base);
>         } else if (p->mpc =3D=3D -1) {
>             /* RAM not behind an MPC */
>             MemoryRegion *mr =3D mr_for_raminfo(mms, p);
>diff --git a/hw/arm/mps2=2Ec b/hw/arm/mps2=2Ec
>index 23a814e4e4=2E=2E1dec4a5d4d 100644
>--- a/hw/arm/mps2=2Ec
>+++ b/hw/arm/mps2=2Ec
>@@ -115,20 +115,20 @@ OBJECT_DECLARE_TYPE(MPS2MachineState, MPS2MachineCl=
ass, MPS2_MACHINE)
> /* Initialize the auxiliary RAM region @mr and map it into
>  * the memory map at @base=2E
>  */
>-static void make_ram(MemoryRegion *mr, const char *name,
>+static void make_ram(Object *owner, MemoryRegion *mr, const char *name,
>                      hwaddr base, hwaddr size)
> {
>-    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
>+    memory_region_init_ram(mr, owner, name, size, &error_fatal);
>     memory_region_add_subregion(get_system_memory(), base, mr);
> }
>=20
> /* Create an alias of an entire original MemoryRegion @orig
>  * located at @base in the memory map=2E
>  */
>-static void make_ram_alias(MemoryRegion *mr, const char *name,
>+static void make_ram_alias(Object *owner, MemoryRegion *mr, const char *=
name,
>                            MemoryRegion *orig, hwaddr base)
> {
>-    memory_region_init_alias(mr, NULL, name, orig, 0,
>+    memory_region_init_alias(mr, owner, name, orig, 0,
>                              memory_region_size(orig));
>     memory_region_add_subregion(get_system_memory(), base, mr);
> }
>@@ -192,12 +192,12 @@ static void mps2_common_init(MachineState *machine)
>     memory_region_add_subregion(system_memory, mmc->psram_base, machine-=
>ram);
>=20
>     if (mmc->has_block_ram) {
>-        make_ram(&mms->blockram, "mps=2Eblockram", 0x01000000, 0x4000);
>-        make_ram_alias(&mms->blockram_m1, "mps=2Eblockram_m1",
>+        make_ram(obj, &mms->blockram, "mps=2Eblockram", 0x01000000, 0x40=
00);
>+        make_ram_alias(obj, &mms->blockram_m1, "mps=2Eblockram_m1",
>                        &mms->blockram, 0x01004000);
>-        make_ram_alias(&mms->blockram_m2, "mps=2Eblockram_m2",
>+        make_ram_alias(obj, &mms->blockram_m2, "mps=2Eblockram_m2",
>                        &mms->blockram, 0x01008000);
>-        make_ram_alias(&mms->blockram_m3, "mps=2Eblockram_m3",
>+        make_ram_alias(obj, &mms->blockram_m3, "mps=2Eblockram_m3",
>                        &mms->blockram, 0x0100c000);
>     }
>=20
>@@ -205,17 +205,18 @@ static void mps2_common_init(MachineState *machine)
>     case FPGA_AN385:
>     case FPGA_AN386:
>     case FPGA_AN500:
>-        make_ram(&mms->ssram1, "mps=2Essram1", 0x0, 0x400000);
>-        make_ram_alias(&mms->ssram1_m, "mps=2Essram1_m", &mms->ssram1, 0=
x400000);
>-        make_ram(&mms->ssram23, "mps=2Essram23", 0x20000000, 0x400000);
>-        make_ram_alias(&mms->ssram23_m, "mps=2Essram23_m",
>+        make_ram(obj, &mms->ssram1, "mps=2Essram1", 0x0, 0x400000);
>+        make_ram_alias(obj, &mms->ssram1_m, "mps=2Essram1_m",
>+                       &mms->ssram1, 0x400000);
>+        make_ram(obj, &mms->ssram23, "mps=2Essram23", 0x20000000, 0x4000=
00);
>+        make_ram_alias(obj, &mms->ssram23_m, "mps=2Essram23_m",
>                        &mms->ssram23, 0x20400000);
>         break;
>     case FPGA_AN511:
>-        make_ram(&mms->blockram, "mps=2Eblockram", 0x0, 0x40000);
>-        make_ram(&mms->ssram1, "mps=2Essram1", 0x00400000, 0x00800000);
>-        make_ram(&mms->sram, "mps=2Esram", 0x20000000, 0x20000);
>-        make_ram(&mms->ssram23, "mps=2Essram23", 0x20400000, 0x400000);
>+        make_ram(obj, &mms->blockram, "mps=2Eblockram", 0x0, 0x40000);
>+        make_ram(obj, &mms->ssram1, "mps=2Essram1", 0x00400000, 0x008000=
00);
>+        make_ram(obj, &mms->sram, "mps=2Esram", 0x20000000, 0x20000);
>+        make_ram(obj, &mms->ssram23, "mps=2Essram23", 0x20400000, 0x4000=
00);
>         break;
>     default:
>         g_assert_not_reached();
>diff --git a/hw/arm/mps3r=2Ec b/hw/arm/mps3r=2Ec
>index 4d432de6ba=2E=2Ed6c29c1172 100644
>--- a/hw/arm/mps3r=2Ec
>+++ b/hw/arm/mps3r=2Ec
>@@ -215,7 +215,7 @@ static MemoryRegion *mr_for_raminfo(MPS3RMachineState=
 *mms,
>     assert(raminfo->mrindex < MPS3R_RAM_MAX);
>     ram =3D &mms->ram[raminfo->mrindex];
>=20
>-    memory_region_init_ram(ram, NULL, raminfo->name,
>+    memory_region_init_ram(ram, OBJECT(mms), raminfo->name,
>                            raminfo->size, &error_fatal);
>     if (raminfo->flags & IS_ROM) {
>         memory_region_set_readonly(ram, true);
>@@ -397,7 +397,7 @@ static void mps3r_common_init(MachineState *machine)
>         object_unref(mms->cpu[i]);
>=20
>         /* Per-CPU RAM */
>-        memory_region_init_ram(&mms->cpu_ram[i], NULL, ramname,
>+        memory_region_init_ram(&mms->cpu_ram[i], OBJECT(mms), ramname,
>                                0x1000, &error_fatal);
>         memory_region_add_subregion(&mms->cpu_sysmem[i], 0xe7c01000,
>                                     &mms->cpu_ram[i]);
>diff --git a/hw/arm/msf2-soc=2Ec b/hw/arm/msf2-soc=2Ec
>index c03778c439=2E=2Ece320a5a38 100644
>--- a/hw/arm/msf2-soc=2Ec
>+++ b/hw/arm/msf2-soc=2Ec
>@@ -128,7 +128,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, =
Error **errp)
>     memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, &s->nv=
m);
>     memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
>=20
>-    memory_region_init_ram(&s->sram, NULL, "MSF2=2EeSRAM", s->esram_size=
,
>+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "MSF2=2EeSRAM", s-=
>esram_size,
>                            &error_fatal);
>     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>=20
>diff --git a/hw/arm/msf2-som=2Ec b/hw/arm/msf2-som=2Ec
>index 0d0e2514dd=2E=2E5493f1cf70 100644
>--- a/hw/arm/msf2-som=2Ec
>+++ b/hw/arm/msf2-som=2Ec
>@@ -55,7 +55,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machi=
ne)
>     MemoryRegion *ddr =3D g_new(MemoryRegion, 1);
>     Clock *m3clk;
>=20
>-    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
>+    memory_region_init_ram(ddr, OBJECT(machine), "ddr-ram", DDR_SIZE,
>                            &error_fatal);
>     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
>=20
>diff --git a/hw/arm/musca=2Ec b/hw/arm/musca=2Ec
>index 75d82eebca=2E=2E38eac4af76 100644
>--- a/hw/arm/musca=2Ec
>+++ b/hw/arm/musca=2Ec
>@@ -235,12 +235,12 @@ static MemoryRegion *make_mpc(MuscaMachineState *mm=
s, void *opaque,
>     switch (mpcinfo[i]=2Etype) {
>     case MPC_ROM:
>         downstream =3D &mms->ram[i];
>-        memory_region_init_rom(downstream, NULL, mpcinfo[i]=2Ename,
>+        memory_region_init_rom(downstream, OBJECT(mms), mpcinfo[i]=2Enam=
e,
>                                mpcinfo[i]=2Esize, &error_fatal);
>         break;
>     case MPC_RAM:
>         downstream =3D &mms->ram[i];
>-        memory_region_init_ram(downstream, NULL, mpcinfo[i]=2Ename,
>+        memory_region_init_ram(downstream, OBJECT(mms), mpcinfo[i]=2Enam=
e,
>                                mpcinfo[i]=2Esize, &error_fatal);
>         break;
>     case MPC_CRYPTOISLAND:
>diff --git a/hw/arm/musicpal=2Ec b/hw/arm/musicpal=2Ec
>index 86ea348d3d=2E=2Efda42f71d5 100644
>--- a/hw/arm/musicpal=2Ec
>+++ b/hw/arm/musicpal=2Ec
>@@ -1236,7 +1236,7 @@ static void musicpal_init(MachineState *machine)
>=20
>     memory_region_add_subregion(address_space_mem, 0, machine->ram);
>=20
>-    memory_region_init_ram(sram, NULL, "musicpal=2Esram", MP_SRAM_SIZE,
>+    memory_region_init_ram(sram, OBJECT(machine), "musicpal=2Esram", MP_=
SRAM_SIZE,
>                            &error_fatal);
>     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
>=20
>diff --git a/hw/arm/omap_sx1=2Ec b/hw/arm/omap_sx1=2Ec
>index 1bd6c6d4bc=2E=2Ef8d54c2716 100644
>--- a/hw/arm/omap_sx1=2Ec
>+++ b/hw/arm/omap_sx1=2Ec
>@@ -128,22 +128,22 @@ static void sx1_init(MachineState *machine, const i=
nt version)
>     mpu =3D omap310_mpu_init(OBJECT(machine), machine->ram, machine->cpu=
_type);
>=20
>     /* External Flash (EMIFS) */
>-    memory_region_init_rom(flash, NULL, "omap_sx1=2Eflash0-0", flash_siz=
e,
>+    memory_region_init_rom(flash, OBJECT(machine), "omap_sx1=2Eflash0-0"=
, flash_size,
>                            &error_fatal);
>     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
>=20
>-    memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
>+    memory_region_init_io(&cs[0], OBJECT(machine), &static_ops, &cs0val,
>                           "sx1=2Ecs0", OMAP_CS0_SIZE - flash_size);
>     memory_region_add_subregion(address_space,
>                                 OMAP_CS0_BASE + flash_size, &cs[0]);
>=20
>=20
>-    memory_region_init_io(&cs[2], NULL, &static_ops, &cs2val,
>+    memory_region_init_io(&cs[2], OBJECT(machine), &static_ops, &cs2val,
>                           "sx1=2Ecs2", OMAP_CS2_SIZE);
>     memory_region_add_subregion(address_space,
>                                 OMAP_CS2_BASE, &cs[2]);
>=20
>-    memory_region_init_io(&cs[3], NULL, &static_ops, &cs3val,
>+    memory_region_init_io(&cs[3], OBJECT(machine), &static_ops, &cs3val,
>                           "sx1=2Ecs3", OMAP_CS3_SIZE);
>     memory_region_add_subregion(address_space,
>                                 OMAP_CS3_BASE, &cs[3]);
>@@ -160,11 +160,11 @@ static void sx1_init(MachineState *machine, const i=
nt version)
>     if ((version =3D=3D 1) &&
>             (dinfo =3D drive_get(IF_PFLASH, 0, fl_idx)) !=3D NULL) {
>         MemoryRegion *flash_1 =3D g_new(MemoryRegion, 1);
>-        memory_region_init_rom(flash_1, NULL, "omap_sx1=2Eflash1-0",
>+        memory_region_init_rom(flash_1, OBJECT(machine), "omap_sx1=2Efla=
sh1-0",
>                                FLASH1_SIZE, &error_fatal);
>         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_=
1);
>=20
>-        memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
>+        memory_region_init_io(&cs[1], OBJECT(machine), &static_ops, &cs1=
val,
>                               "sx1=2Ecs1", OMAP_CS1_SIZE - FLASH1_SIZE);
>         memory_region_add_subregion(address_space,
>                                 OMAP_CS1_BASE + FLASH1_SIZE, &cs[1]);
>@@ -175,7 +175,7 @@ static void sx1_init(MachineState *machine, const int=
 version)
>                               SECTOR_SIZE, 4, 0, 0, 0, 0, 0);
>         fl_idx++;
>     } else {
>-        memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
>+        memory_region_init_io(&cs[1], OBJECT(machine), &static_ops, &cs1=
val,
>                               "sx1=2Ecs1", OMAP_CS1_SIZE);
>         memory_region_add_subregion(address_space,
>                                 OMAP_CS1_BASE, &cs[1]);
>diff --git a/hw/arm/realview=2Ec b/hw/arm/realview=2Ec
>index 2441137222=2E=2E73bfffa6e6 100644
>--- a/hw/arm/realview=2Ec
>+++ b/hw/arm/realview=2Ec
>@@ -159,18 +159,18 @@ static void realview_init(MachineState *machine,
>         ram_lo =3D g_new(MemoryRegion, 1);
>         low_ram_size =3D ram_size - 0x20000000;
>         ram_size =3D 0x20000000;
>-        memory_region_init_ram(ram_lo, NULL, "realview=2Elowmem", low_ra=
m_size,
>+        memory_region_init_ram(ram_lo, OBJECT(machine), "realview=2Elowm=
em", low_ram_size,
>                                &error_fatal);
>         memory_region_add_subregion(sysmem, 0x20000000, ram_lo);
>     }
>=20
>-    memory_region_init_ram(ram_hi, NULL, "realview=2Ehighmem", ram_size,
>+    memory_region_init_ram(ram_hi, OBJECT(machine), "realview=2Ehighmem"=
, ram_size,
>                            &error_fatal);
>     low_ram_size =3D ram_size;
>     if (low_ram_size > 0x10000000)
>       low_ram_size =3D 0x10000000;
>     /* SDRAM at address zero=2E  */
>-    memory_region_init_alias(ram_alias, NULL, "realview=2Ealias",
>+    memory_region_init_alias(ram_alias, OBJECT(machine), "realview=2Eali=
as",
>                              ram_hi, 0, low_ram_size);
>     memory_region_add_subregion(sysmem, 0, ram_alias);
>     if (is_pb) {
>@@ -396,7 +396,7 @@ static void realview_init(MachineState *machine,
>        startup code=2E  I guess this works on real hardware because the
>        BootROM happens to be in ROM/flash or in memory that isn't clobbe=
red
>        until after Linux boots the secondary CPUs=2E  */
>-    memory_region_init_ram(ram_hack, NULL, "realview=2Ehack", 0x1000,
>+    memory_region_init_ram(ram_hack, OBJECT(machine), "realview=2Ehack",=
 0x1000,
>                            &error_fatal);
>     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
>=20
>diff --git a/hw/arm/sbsa-ref=2Ec b/hw/arm/sbsa-ref=2Ec
>index f632df742b=2E=2Ec9adc972c1 100644
>--- a/hw/arm/sbsa-ref=2Ec
>+++ b/hw/arm/sbsa-ref=2Ec
>@@ -410,7 +410,7 @@ static void create_secure_ram(SBSAMachineState *sms,
>     hwaddr base =3D sbsa_ref_memmap[SBSA_SECURE_MEM]=2Ebase;
>     hwaddr size =3D sbsa_ref_memmap[SBSA_SECURE_MEM]=2Esize;
>=20
>-    memory_region_init_ram(secram, NULL, "sbsa-ref=2Esecure-ram", size,
>+    memory_region_init_ram(secram, OBJECT(sms), "sbsa-ref=2Esecure-ram",=
 size,
>                            &error_fatal);
>     memory_region_add_subregion(secure_sysmem, base, secram);
> }
>diff --git a/hw/arm/stellaris=2Ec b/hw/arm/stellaris=2Ec
>index 6a732a3c11=2E=2E1bc428e063 100644
>--- a/hw/arm/stellaris=2Ec
>+++ b/hw/arm/stellaris=2Ec
>@@ -1084,11 +1084,11 @@ static void stellaris_init(MachineState *ms, stel=
laris_board_info *board)
>     object_property_add_child(OBJECT(ms), "soc", soc_container);
>=20
>     /* Flash programming is done via the SCU, so pretend it is ROM=2E  *=
/
>-    memory_region_init_rom(flash, NULL, "stellaris=2Eflash", flash_size,
>+    memory_region_init_rom(flash, OBJECT(ms), "stellaris=2Eflash", flash=
_size,
>                            &error_fatal);
>     memory_region_add_subregion(system_memory, 0, flash);
>=20
>-    memory_region_init_ram(sram, NULL, "stellaris=2Esram", sram_size,
>+    memory_region_init_ram(sram, OBJECT(ms), "stellaris=2Esram", sram_si=
ze,
>                            &error_fatal);
>     memory_region_add_subregion(system_memory, 0x20000000, sram);
>=20
>diff --git a/hw/arm/stm32f100_soc=2Ec b/hw/arm/stm32f100_soc=2Ec
>index e9e722f359=2E=2Ed6d81c1338 100644
>--- a/hw/arm/stm32f100_soc=2Ec
>+++ b/hw/arm/stm32f100_soc=2Ec
>@@ -108,7 +108,7 @@ static void stm32f100_soc_realize(DeviceState *dev_so=
c, Error **errp)
>     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
>=20
>     /* Init SRAM region */
>-    memory_region_init_ram(&s->sram, NULL, "STM32F100=2Esram", SRAM_SIZE=
,
>+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F100=2Esram"=
, SRAM_SIZE,
>                            &error_fatal);
>     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>=20
>diff --git a/hw/arm/stm32f205_soc=2Ec b/hw/arm/stm32f205_soc=2Ec
>index a03c6b4002=2E=2E2997e7d777 100644
>--- a/hw/arm/stm32f205_soc=2Ec
>+++ b/hw/arm/stm32f205_soc=2Ec
>@@ -121,7 +121,7 @@ static void stm32f205_soc_realize(DeviceState *dev_so=
c, Error **errp)
>     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
>     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
>=20
>-    memory_region_init_ram(&s->sram, NULL, "STM32F205=2Esram", SRAM_SIZE=
,
>+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F205=2Esram"=
, SRAM_SIZE,
>                            &error_fatal);
>     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>=20
>diff --git a/hw/arm/stm32f405_soc=2Ec b/hw/arm/stm32f405_soc=2Ec
>index dc9b3053a5=2E=2E4783f3f64a 100644
>--- a/hw/arm/stm32f405_soc=2Ec
>+++ b/hw/arm/stm32f405_soc=2Ec
>@@ -134,7 +134,7 @@ static void stm32f405_soc_realize(DeviceState *dev_so=
c, Error **errp)
>     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->f=
lash);
>     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
>=20
>-    memory_region_init_ram(&s->sram, NULL, "STM32F405=2Esram", SRAM_SIZE=
,
>+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F405=2Esram"=
, SRAM_SIZE,
>                            &err);
>     if (err !=3D NULL) {
>         error_propagate(errp, err);
>@@ -142,7 +142,7 @@ static void stm32f405_soc_realize(DeviceState *dev_so=
c, Error **errp)
>     }
>     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sr=
am);
>=20
>-    memory_region_init_ram(&s->ccm, NULL, "STM32F405=2Eccm", CCM_SIZE,
>+    memory_region_init_ram(&s->ccm, OBJECT(dev_soc), "STM32F405=2Eccm", =
CCM_SIZE,
>                            &err);
>     if (err !=3D NULL) {
>         error_propagate(errp, err);
>diff --git a/hw/arm/vexpress=2Ec b/hw/arm/vexpress=2Ec
>index a643c6b079=2E=2Ef877ccf330 100644
>--- a/hw/arm/vexpress=2Ec
>+++ b/hw/arm/vexpress=2Ec
>@@ -392,7 +392,7 @@ static void a15_daughterboard_init(VexpressMachineSta=
te *vms,
>     /* 0x2b060000: SP805 watchdog: not modelled */
>     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
>     /* 0x2e000000: system SRAM */
>-    memory_region_init_ram(&vms->a15sram, NULL, "vexpress=2Ea15sram", 0x=
10000,
>+    memory_region_init_ram(&vms->a15sram, OBJECT(vms), "vexpress=2Ea15sr=
am", 0x10000,
>                            &error_fatal);
>     memory_region_add_subregion(sysmem, 0x2e000000, &vms->a15sram);
>=20
>@@ -677,7 +677,7 @@ static void vexpress_common_init(MachineState *machin=
e)
>         /* Map flash 0 as an alias into low memory */
>         MemoryRegion *flash0mem;
>         flash0mem =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0)=
;
>-        memory_region_init_alias(&vms->flashalias, NULL, "vexpress=2Efla=
shalias",
>+        memory_region_init_alias(&vms->flashalias, OBJECT(vms), "vexpres=
s=2Eflashalias",
>                                  flash0mem, 0, VEXPRESS_FLASH_SIZE);
>         memory_region_add_subregion(sysmem, map[VE_NORFLASHALIAS], &vms-=
>flashalias);
>     }
>@@ -687,12 +687,12 @@ static void vexpress_common_init(MachineState *mach=
ine)
>                              "vexpress=2Eflash1", dinfo);
>=20
>     sram_size =3D 0x2000000;
>-    memory_region_init_ram(&vms->sram, NULL, "vexpress=2Esram", sram_siz=
e,
>+    memory_region_init_ram(&vms->sram, OBJECT(vms), "vexpress=2Esram", s=
ram_size,
>                            &error_fatal);
>     memory_region_add_subregion(sysmem, map[VE_SRAM], &vms->sram);
>=20
>     vram_size =3D 0x800000;
>-    memory_region_init_ram(&vms->vram, NULL, "vexpress=2Evram", vram_siz=
e,
>+    memory_region_init_ram(&vms->vram, OBJECT(vms), "vexpress=2Evram", v=
ram_size,
>                            &error_fatal);
>     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], &vms->vram);
>=20
>diff --git a/hw/arm/virt=2Ec b/hw/arm/virt=2Ec
>index ea51a5f3bd=2E=2Ef2249a0b72 100644
>--- a/hw/arm/virt=2Ec
>+++ b/hw/arm/virt=2Ec
>@@ -2308,13 +2308,13 @@ static void create_platform_bus(VirtMachineState =
*vms)
>                                 sysbus_mmio_get_region(s, 0));
> }
>=20
>-static void create_tag_ram(MemoryRegion *tag_sysmem,
>+static void create_tag_ram(Object *owner, MemoryRegion *tag_sysmem,
>                            hwaddr base, hwaddr size,
>                            const char *name)
> {
>     MemoryRegion *tagram =3D g_new(MemoryRegion, 1);
>=20
>-    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
>+    memory_region_init_ram(tagram, owner, name, size / 32, &error_fatal)=
;
>     memory_region_add_subregion(tag_sysmem, base / 32, tagram);
> }
>=20
>@@ -2328,7 +2328,7 @@ static void create_secure_ram(VirtMachineState *vms=
,
>     hwaddr size =3D vms->memmap[VIRT_SECURE_MEM]=2Esize;
>     MachineState *ms =3D MACHINE(vms);
>=20
>-    memory_region_init_ram(secram, NULL, "virt=2Esecure-ram", size,
>+    memory_region_init_ram(secram, OBJECT(vms), "virt=2Esecure-ram", siz=
e,
>                            &error_fatal);
>     memory_region_add_subregion(secure_sysmem, base, secram);
>=20
>@@ -2340,7 +2340,8 @@ static void create_secure_ram(VirtMachineState *vms=
,
>     qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
>=20
>     if (secure_tag_sysmem) {
>-        create_tag_ram(secure_tag_sysmem, base, size, "mach-virt=2Esecur=
e-tag");
>+        create_tag_ram(OBJECT(vms), secure_tag_sysmem, base, size,
>+                       "mach-virt=2Esecure-tag");
>     }
>=20
>     g_free(nodename);
>@@ -2840,7 +2841,7 @@ static void virt_post_cpus_gic_realized(VirtMachine=
State *vms,
>                 exit(1);
>             }
>=20
>-            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, =
NULL);
>+            memory_region_init_ram(pvtime, OBJECT(vms), "pvtime", pvtime=
_size, NULL);
>             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime)=
;
>         }
>         if (!aarch64 && vms->virt) {
>@@ -3200,7 +3201,7 @@ static void machvirt_init(MachineState *machine)
>     }
>=20
>     if (tag_sysmem) {
>-        create_tag_ram(tag_sysmem, vms->memmap[VIRT_MEM]=2Ebase,
>+        create_tag_ram(OBJECT(vms), tag_sysmem, vms->memmap[VIRT_MEM]=2E=
base,
>                        machine->ram_size, "mach-virt=2Etag");
>     }
>=20
>diff --git a/hw/arm/xilinx_zynq=2Ec b/hw/arm/xilinx_zynq=2Ec
>index 30f0ce5b5f=2E=2E441289e63f 100644
>--- a/hw/arm/xilinx_zynq=2Ec
>+++ b/hw/arm/xilinx_zynq=2Ec
>@@ -238,7 +238,7 @@ static void zynq_init(MachineState *machine)
>     memory_region_add_subregion(address_space_mem, 0, machine->ram);
>=20
>     /* 256K of on-chip memory */
>-    memory_region_init_ram(ocm_ram, NULL, "zynq=2Eocm_ram", 256 * KiB,
>+    memory_region_init_ram(ocm_ram, OBJECT(machine), "zynq=2Eocm_ram", 2=
56 * KiB,
>                            &error_fatal);
>     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
>=20
>diff --git a/hw/arm/xlnx-zynqmp=2Ec b/hw/arm/xlnx-zynqmp=2Ec
>index e4a10861a8=2E=2Ea25d5d3158 100644
>--- a/hw/arm/xlnx-zynqmp=2Ec
>+++ b/hw/arm/xlnx-zynqmp=2Ec
>@@ -510,7 +510,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>     for (i =3D 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
>         char *ocm_name =3D g_strdup_printf("zynqmp=2Eocm_ram_bank_%d", i=
);
>=20
>-        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
>+        memory_region_init_ram(&s->ocm_ram[i], OBJECT(dev), ocm_name,
>                                XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
>         memory_region_add_subregion(get_system_memory(),
>                                     XLNX_ZYNQMP_OCM_RAM_0_ADDRESS +


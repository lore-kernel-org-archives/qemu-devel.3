Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5190DEB26EF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprH5-0002qJ-Vi; Tue, 10 Feb 2026 12:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vprH3-0002pj-Tm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:11:41 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vprH1-0000Lj-Me
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:11:41 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7192C596A0D;
 Tue, 10 Feb 2026 18:11:37 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ScAUL7U9aMDn; Tue, 10 Feb 2026 18:11:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 46D8A5969F6; Tue, 10 Feb 2026 18:11:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 453185969FF;
 Tue, 10 Feb 2026 18:11:35 +0100 (CET)
Date: Tue, 10 Feb 2026 18:11:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Anton Johansson <anjo@rev.ng>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 4/4] hppa: Add C3600 machine with PA-8600 CPU
In-Reply-To: <20260210-hppa-c3600-v2-4-9ca09c677012@rev.ng>
Message-ID: <816b7e55-ce79-25f9-42ef-fab8a98a00d8@eik.bme.hu>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
 <20260210-hppa-c3600-v2-4-9ca09c677012@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 10 Feb 2026, Anton Johansson via qemu development wrote:
> Adds a C3600/PA-8600 machine/CPU, which from the perspective of
> QEMU differ only in the size of the physical address, compared to
> C3700/PA-8700.
>
> With this addition, PA-8700 is changed to use the correct 44 bit
> physical address space.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
> target/hppa/cpu-qom.h                 |  1 +
> hw/hppa/machine.c                     | 41 ++++++++++++++++++++++++++++++-----
> target/hppa/cpu.c                     | 10 ++++++++-
> tests/functional/hppa/test_seabios.py |  3 +++
> 4 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
> index c6b82dc09b..078aa3b08a 100644
> --- a/target/hppa/cpu-qom.h
> +++ b/target/hppa/cpu-qom.h
> @@ -28,6 +28,7 @@
> #define HPPA_CPU_TYPE_NAME(name) (name HPPA_CPU_TYPE_SUFFIX)
>
> #define TYPE_HPPA_CPU_PA_7300LC HPPA_CPU_TYPE_NAME("pa-7300lc")
> +#define TYPE_HPPA_CPU_PA_8600   HPPA_CPU_TYPE_NAME("pa-8600")
> #define TYPE_HPPA_CPU_PA_8700   HPPA_CPU_TYPE_NAME("pa-8700")
>
> OBJECT_DECLARE_CPU_TYPE(HPPACPU, HPPACPUClass, HPPA_CPU)
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 8246f6bf65..ab5b8b6422 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -689,9 +689,9 @@ static AstroState *astro_init(void)
> }
>
> /*
> - * Create HP C3700 workstation
> + * Create HP C3000 series workstation
>  */
> -static void machine_HP_C3700_init(MachineState *machine)
> +static void machine_HP_C3000_init(MachineState *machine)
> {
>     PCIBus *pci_bus;
>     AstroState *astro;
> @@ -804,9 +804,30 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
>     mc->default_ram_size = 512 * MiB;
> }
>
> +static void HP_C3600_machine_init_class_init(ObjectClass *oc, const void *data)
> +{
> +    static const char * const valid_cpu_types[] = {
> +        TYPE_HPPA_CPU_PA_8600,
> +        NULL
> +    };
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "HP C3600 workstation";
> +    mc->default_cpu_type = TYPE_HPPA_CPU_PA_8600;
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mc->init = machine_HP_C3000_init;
> +    mc->max_cpus = HPPA_MAX_CPUS;
> +    mc->default_ram_size = 1024 * MiB;
> +}
> +
> static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
> {
> +    /*
> +     * SeaBIOS for C3700 currently uses a 40 bit physical address space,
> +     * allow use of use the PA-8600.

Something seems to be missing from this comment or too many uses of "use"?

Regards,
BALATON Zoltan


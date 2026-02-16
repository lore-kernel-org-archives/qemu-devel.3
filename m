Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6355E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5oz-0006ve-CQ; Mon, 16 Feb 2026 16:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5oy-0006vS-Ff; Mon, 16 Feb 2026 16:07:56 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5ow-0006nP-KJ; Mon, 16 Feb 2026 16:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IrzKmVQ8W2H/zpynPUfi60qJKPOnty3tPncO5aYqkO8=; b=xxrOJzygKFpSPUpJgQZ6CVt+5M
 qVSwUKqCo54dskomWdlGpyUIK2Iq0jezg922c+5dtuJOZ2hWz54BrhjdXC9LxxGTFgZP61ytAR+YF
 mRbTxHijg17Fvaa5zKC/ol1HzD8pBTibMz8OcGntbZozn/vo0fqOXoBejqmf9Dmj8UiaUKntCU6yJ
 ib63mvHmv7z587VxhOfx98DLAGGcBWzGY8gRDjfkRYPws5zIPSCd+RrIjMJrtAuFsKZkACQfJeDJx
 z1araY19BlRaYbQNFQM2Q+7RvXDmnxQgwGeBCpXCd5W23cCIYiJKy7TdHc9E6RHS7dhQhuJrsHNLb
 GxVHckqY7VXUax5x6pTqKsnsPE/YGRd04m3Ublx4thi3e07iEhylj8ok1updif3O4So4JEp4SLYh5
 fCZWMUN5gsakgUFdLMdNUW3K1Pd4115ulvIu/qlaIbUosdChKxbvWqAeBOkuXSPwMHY0W3flSAM78
 qrzkzuoWhssVpllbEIL/aa0yAe06BdrRSveullLAgecMZWXL8FaKKRczXFblA11lgNZ0SNECfz+wu
 MkgjPDmu6cpXnE9kfbcHZTxDJ6E61ns106DxcwK19qsJDtIsGxjvohkJ6ZzgXznQv/AepuoTMw2tW
 qnhf9gXfMIg/aoSJrL/eahqE7I/Wdk/OgnGrBOvKQ=;
Received: from [2a02:8012:2f01:0:f01d:4e0f:6874:3706]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5m1-000Cf6-IC; Mon, 16 Feb 2026 21:04:57 +0000
Message-ID: <f3a8d272-9716-49f5-92a8-2ea67b56f711@ilande.co.uk>
Date: Mon, 16 Feb 2026 21:07:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260214021240.58657-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:f01d:4e0f:6874:3706
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 14/02/2026 02:12, Philippe Mathieu-Daudé wrote:

> If a dimension is not set, have the machine init code set
> the default value by calling the ppc_graphic_dimensions()
> helper, common to all PowerPC machines. Declare local
> variables to avoid using the global ones.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/ppc.h    |  2 ++
>   hw/ppc/mac_newworld.c   | 10 ++++++----
>   hw/ppc/mac_oldworld.c   | 10 ++++++----
>   hw/ppc/ppc.c            |  8 ++++++++
>   hw/ppc/prep.c           |  4 ++++
>   hw/ppc/spapr.c          |  4 ++++
>   system/globals-target.c |  6 ------
>   7 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index cb51d704c6d..14cc09ab22b 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -102,6 +102,8 @@ enum {
>       ARCH_MAC99_U3,
>   };
>   
> +void ppc_graphic_dimensions(int *width, int *height, int *depth);
> +
>   #define FW_CFG_PPC_WIDTH        (FW_CFG_ARCH_LOCAL + 0x00)
>   #define FW_CFG_PPC_HEIGHT       (FW_CFG_ARCH_LOCAL + 0x01)
>   #define FW_CFG_PPC_DEPTH        (FW_CFG_ARCH_LOCAL + 0x02)
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 7275563a155..daf0029c01a 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
>       DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
>       hwaddr nvram_addr = 0xFFF04000;
>       uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    int graphic_width, graphic_height, graphic_depth;
>   
>       /* init CPUs */
>       for (i = 0; i < machine->smp.cpus; i++) {
> @@ -432,10 +433,6 @@ static void ppc_core99_init(MachineState *machine)
>   
>       pci_vga_init(pci_bus);
>   
> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> -        graphic_depth = 15;
> -    }
> -
>       pci_init_nic_devices(pci_bus, mc->default_nic);
>   
>       /* The NewWorld NVRAM is not located in the MacIO device */
> @@ -480,6 +477,11 @@ static void ppc_core99_init(MachineState *machine)
>       fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>   
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> +        graphic_depth = 15;
> +    }
> +
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index e679d338985..ea1f778877c 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
>       DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       void *fw_cfg;
>       uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    int graphic_width, graphic_height, graphic_depth;
>   
>       /* init CPUs */
>       for (i = 0; i < machine->smp.cpus; i++) {
> @@ -288,10 +289,6 @@ static void ppc_heathrow_init(MachineState *machine)
>           pci_create_simple(pci_bus, -1, "pci-ohci");
>       }
>   
> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> -        graphic_depth = 15;
> -    }
> -
>       /* No PCI init: the BIOS will do it */
>   
>       dev = qdev_new(TYPE_FW_CFG_MEM);
> @@ -321,6 +318,11 @@ static void ppc_heathrow_init(MachineState *machine)
>       fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>   
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> +        graphic_depth = 15;
> +    }
> +
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a512d4fa647..d7b4466d701 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -29,6 +29,7 @@
>   #include "qemu/timer.h"
>   #include "exec/cpu-interrupt.h"
>   #include "system/cpus.h"
> +#include "system/system.h"
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/error-report.h"
> @@ -1557,3 +1558,10 @@ void ppc_irq_reset(PowerPCCPU *cpu)
>           kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
>       }
>   }
> +
> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
> +{
> +    *width = graphic_width ?: 800;
> +    *height = graphic_height ?: 600;
> +    *depth = graphic_depth ?: 32;
> +}
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index c4efd1d3908..7077b047b25 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -43,6 +43,7 @@
>   #include "exec/target_page.h"
>   #include "system/kvm.h"
>   #include "system/reset.h"
> +#include "system/system.h"
>   #include "trace.h"
>   #include "elf.h"
>   #include "qemu/units.h"
> @@ -250,6 +251,7 @@ static void ibm_40p_init(MachineState *machine)
>       uint32_t kernel_base = 0, initrd_base = 0;
>       long kernel_size = 0, initrd_size = 0;
>       char boot_device;
> +    int graphic_width, graphic_height, graphic_depth;
>   
>       if (kvm_enabled()) {
>           error_report("machine %s does not support the KVM accelerator",
> @@ -412,6 +414,8 @@ static void ibm_40p_init(MachineState *machine)
>       fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
>   
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 274f38785f2..c50c7da34d5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1143,6 +1143,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>   {
>       MachineState *machine = MACHINE(spapr);
>       int chosen;
> +    int graphic_width, graphic_height, graphic_depth;
>   
>       _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
>   
> @@ -1177,6 +1178,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>           if (machine->boot_config.has_menu && machine->boot_config.menu) {
>               _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", true)));
>           }
> +
> +        ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +
>           _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
>           _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
>           _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
> diff --git a/system/globals-target.c b/system/globals-target.c
> index 17a27a06218..ffa6c308b59 100644
> --- a/system/globals-target.c
> +++ b/system/globals-target.c
> @@ -9,12 +9,6 @@
>   #include "qemu/osdep.h"
>   #include "system/system.h"
>   
> -#if defined(TARGET_SPARC) || defined(TARGET_M68K)
>   int graphic_width;
>   int graphic_height;
>   int graphic_depth;
> -#else
> -int graphic_width = 800;
> -int graphic_height = 600;
> -int graphic_depth = 32;
> -#endif

Given that these machines are so different from each other, I don't think this really 
warrants a separate ppc_graphic_dimensions() function. I think just inlining the 
defaults logic as you've done already for other displays will be fine.


ATB,

Mark.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9268010F285F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AjE-0008KE-BC; Fri, 27 Mar 2026 13:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>)
 id 1w6AjC-0008J0-QQ; Fri, 27 Mar 2026 13:12:10 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>)
 id 1w6AjA-0001N1-P0; Fri, 27 Mar 2026 13:12:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BF8360054;
 Fri, 27 Mar 2026 17:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E84C19423;
 Fri, 27 Mar 2026 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774631524;
 bh=1iD0FeDfdJgteYwshZqBWM6mXlmRyCgFWJAKo3SX3Ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JiNeXmsBgQr/qzpl3gBN/4g84MvBh/SzvvOJ3Ik9RA+WkwgoUW/Rb86d408oGRefM
 udu4yrsUdYT8t/qlo1hcD1bW+vb5d+S9u7GXRZTQcaTE3ixgkAk5SJqE9TgV/jAvt1
 G5gORN4liY2rBTBtHQoteEzelFKWDYvR0qnRtIKIqXr85oePFcNdgA8JBc4dr4i4r7
 pqMsY5mYlDH624Y3cnre7zPgtpViriEZ9h3ykyYCWyJN8D2IKsZ6dyErBmzn0WqXqn
 xs2KFJS7E1i3Psx7ZwlQ9kbQWumDzOBdnMQh6trj94ghAHuS6/eNnrLTUmOHm1dYhx
 eHUkcnKf7/NUw==
Date: Fri, 27 Mar 2026 18:11:59 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] ppc/pnv: generate dtb after machine initialization is
 complete
Message-ID: <20260327171159.GA3586365@ax162>
References: <20260327124136.983955-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327124136.983955-1-shivangu@linux.ibm.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=nathan@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Mar 27, 2026 at 06:11:36PM +0530, Shivang Upadhyay wrote:
> Currently, the machine dtb is generated in pnv_init(), before all devices
> are fully initialized. This can result in an incomplete dtb for the system,
> as seen in bug [1].
> 
> Fix this by deferring dtb generation until machine initialization is complete,
> using the machine_init_done_notifier hook.
> 
> [1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

This still works for me.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes:
> 
> v2:
> * moved pnv->bmc initialization to pnv_machine_init_done.
> 
> v1:
> * https://lore.kernel.org/all/20260324135026.247418-1-shivangu@linux.ibm.com/
> ---
>  hw/ppc/pnv.c         | 58 +++++++++++++++++++++++++-------------------
>  include/hw/ppc/pnv.h |  2 ++
>  2 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7e54b6bc60..524563dcfc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -748,31 +748,10 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
>  
>  static void pnv_reset(MachineState *machine, ResetType type)
>  {
> -    PnvMachineState *pnv = PNV_MACHINE(machine);
> -    IPMIBmc *bmc;
>      void *fdt;
>  
>      qemu_devices_reset(type);
>  
> -    /*
> -     * The machine should provide by default an internal BMC simulator.
> -     * If not, try to use the BMC device that was provided on the command
> -     * line.
> -     */
> -    bmc = pnv_bmc_find(&error_fatal);
> -    if (!pnv->bmc) {
> -        if (!bmc) {
> -            if (!qtest_enabled()) {
> -                warn_report("machine has no BMC device. Use '-device "
> -                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
> -                            "to define one");
> -            }
> -        } else {
> -            pnv_bmc_set_pnor(bmc, pnv->pnor);
> -            pnv->bmc = bmc;
> -        }
> -    }
> -
>      fdt = machine->fdt;
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>  }
> @@ -984,6 +963,37 @@ static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
>      return chip_id == 0 ? 1 * GiB : QEMU_ALIGN_DOWN(ram_per_chip, 1 * MiB);
>  }
>  
> +static void pnv_machine_init_done(Notifier *notifier, void *data)
> +{
> +    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
> +    MachineState *machine = MACHINE(pnv);
> +    IPMIBmc *bmc;
> +
> +    /*
> +     * The machine should provide by default an internal BMC simulator.
> +     * If not, try to use the BMC device that was provided on the command
> +     * line.
> +     */
> +    bmc = pnv_bmc_find(&error_fatal);
> +    if (!pnv->bmc) {
> +        if (!bmc) {
> +            if (!qtest_enabled()) {
> +                warn_report("machine has no BMC device. Use '-device "
> +                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
> +                            "to define one");
> +            }
> +        } else {
> +            pnv_bmc_set_pnor(bmc, pnv->pnor);
> +            pnv->bmc = bmc;
> +        }
> +    }
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(machine->fdt)));
> +    }
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      const char *bios_name = machine->firmware ?: FW_FILE_NAME;
> @@ -1244,10 +1254,8 @@ static void pnv_init(MachineState *machine)
>          pmc->i2c_init(pnv);
>      }
>  
> -    if (!machine->fdt) {
> -        machine->fdt = pnv_dt_create(machine);
> -        _FDT((fdt_pack(machine->fdt)));
> -    }
> +    pnv->machine_init_done.notify = pnv_machine_init_done;
> +    qemu_add_machine_init_done_notifier(&pnv->machine_init_done);
>  }
>  
>  /*
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 24f8843a40..90028f974d 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -111,6 +111,8 @@ struct PnvMachineState {
>  
>      bool         big_core;
>      bool         lpar_per_core;
> +
> +    Notifier     machine_init_done;
>  };
>  
>  PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
> -- 
> 2.53.0
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C45F4613F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 23:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4oVj-0001hk-Vf; Mon, 23 Mar 2026 19:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>)
 id 1w4oVa-0001gd-Pb; Mon, 23 Mar 2026 19:16:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>)
 id 1w4oVY-0000ai-96; Mon, 23 Mar 2026 19:16:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A5D4F600AC;
 Mon, 23 Mar 2026 23:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CF9C4CEF7;
 Mon, 23 Mar 2026 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774307777;
 bh=uU9ftH4qsnfeQi7j0IFJmFSh6KecRRkmADSExjyTIT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VYnH4EL4xjVmnVtkaVqPZvgD9DBCy8sLwAW+oRR18Z2mlFlMHvJ6ZLX3XZBxBlJoH
 rcMBnjWtAPtU6rcDygEcZEiy1nSLKYQ7HfHfh+5GBctgPNg8viw5TzDxYMtkuPYCRb
 qQq9sB5wRZ5itZiePV3YW3D2ehZw9tiGegHFwjWUwZuJr+cku1F5US75gjLsnNXrBO
 ShKJHndMIhTAeqMuf3M1ig3Vtkli8CCEwa4c298TGJgYXsKUmQNV+iA7qRzBgmmyVV
 XiqVD040UdO6NK6BaedZrubylTZK+ogqQghqq8/thdBNGOLRR7V8ZXBk/VxbzhhdAE
 75UJ28eiMODAQ==
Date: Mon, 23 Mar 2026 16:16:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
Message-ID: <20260323231612.GA2637687@ax162>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311143549.118720-1-shivangu@linux.ibm.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=nathan@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Shivang,

On Wed, Mar 11, 2026 at 08:05:49PM +0530, Shivang Upadhyay wrote:
> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
> 
> Fixing this by generating fdt blob in `pnv_init`.
> 
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> ---
> Changes
> 
> V2:
>     * added fdt_pack to newly generated fdt in pnv_init
>     * cleared the fdt generation code from pnv_reset
> 
> V1:
>     * https://lore.kernel.org/all/20260225081037.21990-1-shivangu@linux.ibm.com/
> ---
>  hw/ppc/pnv.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1513575b8f..7e54b6bc60 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -773,26 +773,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
>          }
>      }
>  
> -    if (machine->fdt) {
> -        fdt = machine->fdt;
> -    } else {
> -        fdt = pnv_dt_create(machine);
> -        /* Pack resulting tree */
> -        _FDT((fdt_pack(fdt)));
> -    }
> -
> +    fdt = machine->fdt;
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
> -
> -    /* Update machine->fdt with latest fdt */
> -    if (machine->fdt != fdt) {
> -        /*
> -         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
> -         * the existing machine->fdt to avoid leaking it during
> -         * a reset.
> -         */
> -        g_free(machine->fdt);
> -        machine->fdt = fdt;
> -    }
>  }
>  
>  static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
> @@ -1261,6 +1243,11 @@ static void pnv_init(MachineState *machine)
>      if (pmc->i2c_init) {
>          pmc->i2c_init(pnv);
>      }
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(machine->fdt)));
> +    }
>  }
>  
>  /*
> -- 
> 2.53.0
> 
> 

After this patch landed in QEMU master as commit a16d4c2f16 ("ppc/pnv:
fix dumpdtb option"), I am seeing a hang on shutdown. With the files
available at [1]:

  $ qemu-system-ppc64 \
      -display none \
      -nodefaults \
      -device ipmi-bmc-sim,id=bmc0 \
      -device isa-ipmi-bt,bmc=bmc0,irq=10 \
      -machine powernv \
      -kernel zImage.epapr \
      -initrd rootfs.cpio \
      -m 2G \
      -serial mon:stdio
  ...
  [    1.308982][    T1] Run /init as init process
  [    1.626933][   T48] mount (48) used greatest stack depth: 27552 bytes left
  [    2.044092][   T53] mount (53) used greatest stack depth: 27472 bytes left
  Saving 256 bits of creditable seed for next boot
  Starting syslogd: OK
  Starting klogd: [    2.993121][   T68] start-stop-daem (68) used greatest stack depth: 27360 bytes left
  OK
  Running sysctl: [    3.576155][   T76] logger (76) used greatest stack depth: 27104 bytes left
  OK
  Starting network: [    3.955094][   T82] run-parts (82) used greatest stack depth: 26864 bytes left
  [    4.087124][   T84] ip (84) used greatest stack depth: 26816 bytes left
  OK
  Linux version 7.0.0-rc5 (nathan@ax162) (powerpc64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT Mon Mar 23 14:40:47 MST 2026
  Stopping network: OK
  Stopping klogd: OK
  Stopping syslogd: OK
  Seeding 256 bits and crediting
  Saving 256 bits of creditable seed for next boot
  umount: devtmpfs busy - remounted read-only
  The system is going down NOW!
  Sent SIGTERM to all processes
  Sent SIGKILL to all processes
  Requesting system poweroff
  [    8.177326][  T111] reboot: Power down
  [   13.204993942,5] OPAL: Shutdown request type 0x0...

and QEMU just hangs after the shutdown print. At the parent change, the
machine shuts down cleanly. If there is any other information I can
provide or patches I can test, I am more than happy to do so.

[1]: https://github.com/nathanchance/bug-files/tree/4e7f04b87d0f8c604365be15f1dead97a08e5aa4/qemu-a16d4c2f162a86db1f84ef0836d42eabaf57fe69

Cheers,
Nathan

# bad: [eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27] Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging
# good: [559919ce54927d59b215a4665eda7ab6118a48aa] Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging
git bisect start 'eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27' '559919ce54927d59b215a4665eda7ab6118a48aa'
# bad: [5a68a3add61208aad34d47134fdcfd3f407d2ce4] Update version for v11.0.0-rc0 release
git bisect bad 5a68a3add61208aad34d47134fdcfd3f407d2ce4
# bad: [f520fc4b047a2ecd026afa4e71a4e22fce4ed4cb] Merge tag 'for-11.0-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging
git bisect bad f520fc4b047a2ecd026afa4e71a4e22fce4ed4cb
# good: [f47a5a3d47fdcc577ed009b414a07d1de483d1e1] coreaudio: Commit the result of init in the end
git bisect good f47a5a3d47fdcc577ed009b414a07d1de483d1e1
# good: [ceaa7da4c4e78d355483753cdc7a7062cae0fd54] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
git bisect good ceaa7da4c4e78d355483753cdc7a7062cae0fd54
# good: [60ed428e5d628c50bbd40f159bf13d40ee38628a] Merge tag 'pull-block-2026-03-17' of https://gitlab.com/hreitz/qemu into staging
git bisect good 60ed428e5d628c50bbd40f159bf13d40ee38628a
# good: [461632f0b1cb2c5c29ba9875857637e3356b903c] coreaudio: Initialize the buffer for device change
git bisect good 461632f0b1cb2c5c29ba9875857637e3356b903c
# bad: [c9dbd923f7ac291a4b5560b156898954d76e5ffa] Merge tag 'pull-ppc-for-11.0-hardfreeze-20260317' of https://gitlab.com/harshpb/qemu into staging
git bisect bad c9dbd923f7ac291a4b5560b156898954d76e5ffa
# bad: [a16d4c2f162a86db1f84ef0836d42eabaf57fe69] ppc/pnv: fix dumpdtb option
git bisect bad a16d4c2f162a86db1f84ef0836d42eabaf57fe69
# first bad commit: [a16d4c2f162a86db1f84ef0836d42eabaf57fe69] ppc/pnv: fix dumpdtb option


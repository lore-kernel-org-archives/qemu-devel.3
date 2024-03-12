Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjx6D-00087z-6h; Tue, 12 Mar 2024 04:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=j0G5=KS=kaod.org=clg@ozlabs.org>)
 id 1rjx63-00083k-3z; Tue, 12 Mar 2024 04:02:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=j0G5=KS=kaod.org=clg@ozlabs.org>)
 id 1rjx60-00053x-Gc; Tue, 12 Mar 2024 04:02:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tv5j94j1Zz4wqN;
 Tue, 12 Mar 2024 19:02:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv5j701vvz4wnr;
 Tue, 12 Mar 2024 19:02:34 +1100 (AEDT)
Message-ID: <01f233a4-e739-47d5-92cf-3a58c80396df@kaod.org>
Date: Tue, 12 Mar 2024 09:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] ppc/pnv: Permit ibm,pa-features set per machine
 variant
Content-Language: en-US, fr
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-8-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240311185200.2185753-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=j0G5=KS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/11/24 19:51, Nicholas Piggin wrote:
> This allows different pa-features for powernv8/9/10.
> 
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: "Frédéric Barrat" <fbarrat@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

The features could be a chip class attribute instead.

Thanks,

C.


> ---
>   hw/ppc/pnv.c | 41 +++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index aa9786e970..52d964f77a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -133,7 +133,7 @@ static int get_cpus_node(void *fdt)
>    * device tree, used in XSCOM to address cores and in interrupt
>    * servers.
>    */
> -static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
> +static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>   {
>       PowerPCCPU *cpu = pc->threads[0];
>       CPUState *cs = CPU(cpu);
> @@ -149,11 +149,6 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>       uint32_t cpufreq = 1000000000;
>       uint32_t page_sizes_prop[64];
>       size_t page_sizes_prop_size;
> -    const uint8_t pa_features[] = { 24, 0,
> -                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
> -                                    0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> -                                    0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -                                    0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
>       int offset;
>       char *nodename;
>       int cpus_offset = get_cpus_node(fdt);
> @@ -236,15 +231,14 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>                              page_sizes_prop, page_sizes_prop_size)));
>       }
>   
> -    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> -                       pa_features, sizeof(pa_features))));
> -
>       /* Build interrupt servers properties */
>       for (i = 0; i < smt_threads; i++) {
>           servers_prop[i] = cpu_to_be32(pc->pir + i);
>       }
>       _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
>                          servers_prop, sizeof(*servers_prop) * smt_threads)));
> +
> +    return offset;
>   }
>   
>   static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
> @@ -299,6 +293,17 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb)
>       return chip;
>   }
>   
> +/*
> + * Same as spapr pa_features_207 except pnv always enables CI largepages bit.
> + * HTM is always enabled because TCG does implement HTM, it's just a
> + * degenerate implementation.
> + */
> +static const uint8_t pa_features_207[] = { 24, 0,
> +                 0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
> +                 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                 0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> +                 0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> +
>   static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>   {
>       static const char compat[] = "ibm,power8-xscom\0ibm,xscom";
> @@ -311,8 +316,12 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
> +
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>   
>           /* Interrupt Control Presenters (ICP). One per core. */
>           pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_threads);
> @@ -335,8 +344,12 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
> +
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>       }
>   
>       if (chip->ram_size) {
> @@ -358,8 +371,12 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>   
>       for (i = 0; i < chip->nr_cores; i++) {
>           PnvCore *pnv_core = chip->cores[i];
> +        int offset;
> +
> +        offset = pnv_dt_core(chip, pnv_core, fdt);
>   
> -        pnv_dt_core(chip, pnv_core, fdt);
> +        _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
> +                           pa_features_207, sizeof(pa_features_207))));
>       }
>   
>       if (chip->ram_size) {



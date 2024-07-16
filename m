Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 20:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTogM-00077X-2c; Tue, 16 Jul 2024 16:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTogC-0006Nf-Pk; Tue, 16 Jul 2024 16:21:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTog7-0002TC-HJ; Tue, 16 Jul 2024 16:21:44 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNr7j1Hkwz4x0C;
 Wed, 17 Jul 2024 06:21:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNr7f68vfz4w2S;
 Wed, 17 Jul 2024 06:21:34 +1000 (AEST)
Message-ID: <0519b0e5-a3a8-452c-aa1a-c6349574d2cb@kaod.org>
Date: Tue, 16 Jul 2024 22:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
 <20240716195633.12679-5-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716195633.12679-5-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/16/24 21:56, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> The cache watch facility uses the same register interface to handle
> entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
> specification' register tells the table type. So far, that bit-field
> was not read and the code assumed a read/write to the NVP table.
> 
> This patch allows to read/write entries in the NVG and NVC table as
> well.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c | 49 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 3dbbfddacb..dfb0927fd3 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -465,10 +465,30 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>                                 word_number);
>   }
>   
> -static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
> +static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
>   {
> -    uint8_t  blk;
> -    uint32_t idx;
> +    switch (nxc_type) {
> +    case PC_NXC_WATCH_NXC_NVP:
> +        *table_type = VST_NVP;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVG:
> +        *table_type = VST_NVG;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVC:
> +        *table_type = VST_NVC;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: invalid table type for nxc operation\n");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
> +{
> +    uint8_t  blk, nxc_type;
> +    uint32_t idx, table_type = -1;
>       int i, spec_reg, data_reg;
>       uint64_t nxc_watch[4];
>   
> @@ -476,21 +496,24 @@ static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
>   
>       spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>       data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
>       blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>       idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>   
> +    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
> +
>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>           nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
>       }
>   
> -    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
> +    return pnv_xive2_vst_write(xive, table_type, blk, idx, nxc_watch,
>                                 XIVE_VST_WORD_ALL);
>   }
>   
> -static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
> +static void pnv_xive2_nxc_cache_load(PnvXive2 *xive, uint8_t watch_engine)
>   {
> -    uint8_t  blk;
> -    uint32_t idx;
> +    uint8_t  blk, nxc_type;
> +    uint32_t idx, table_type = -1;
>       uint64_t nxc_watch[4] = { 0 };
>       int i, spec_reg, data_reg;
>   
> @@ -498,11 +521,15 @@ static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
>   
>       spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>       data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
>       blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>       idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>   
> -    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
> -        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
> +    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
> +
> +    if (pnv_xive2_vst_read(xive, table_type, blk, idx, nxc_watch)) {
> +        xive2_error(xive, "VST: no NXC entry %x/%x in %s table!?",
> +                    blk, idx, vst_infos[table_type].name);
>       }
>   
>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
> @@ -1432,7 +1459,7 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>           * SPEC register
>           */
>           watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
> -        pnv_xive2_nvp_cache_load(xive, watch_engine);
> +        pnv_xive2_nxc_cache_load(xive, watch_engine);
>           val = xive->pc_regs[reg];
>           break;
>   
> @@ -1506,7 +1533,7 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>           /* writing to DATA0 triggers the cache write */
>           watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>           xive->pc_regs[reg] = val;
> -        pnv_xive2_nvp_update(xive, watch_engine);
> +        pnv_xive2_nxc_update(xive, watch_engine);
>           break;
>   
>      /* case PC_NXC_FLUSH_CTRL: */



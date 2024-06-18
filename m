Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6761AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 17:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJctI-0004Wy-Qc; Tue, 18 Jun 2024 13:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJct7-0004V3-AE; Tue, 18 Jun 2024 13:44:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJct4-0007m7-N7; Tue, 18 Jun 2024 13:44:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W3Yzj11d6z4wcJ;
 Wed, 19 Jun 2024 03:44:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3Yzf5q9Nz4wc8;
 Wed, 19 Jun 2024 03:44:46 +1000 (AEST)
Message-ID: <bc5bb99a-e4b0-4e3d-952e-133f383908ac@kaod.org>
Date: Tue, 18 Jun 2024 19:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pnv/xive2: Enable VST NVG and NVC index compression
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
 <20240617204302.12323-3-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240617204302.12323-3-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Of75=NU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 10:42 PM, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Enable NVG and NVC VST tables for index compression which indicates the number
> of bits the address is shifted to the right for the table accesses.
> The compression values are defined as:
>     0000 - No compression
>     0001 - 1 bit shift
>     0010 - 2 bit shift
>     ....
>     1000 - 8 bit shift
>     1001-1111 - No compression
> 
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2_regs.h |  2 ++
>   hw/intc/pnv_xive2.c      | 20 ++++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
> index ca05255d20..e8b87b3d2c 100644
> --- a/hw/intc/pnv_xive2_regs.h
> +++ b/hw/intc/pnv_xive2_regs.h
> @@ -427,6 +427,8 @@
>   #define X_PC_NXC_PROC_CONFIG                    0x28A
>   #define PC_NXC_PROC_CONFIG                      0x450
>   #define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
> +#define   PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS PPC_BITMASK(32, 35)
> +#define   PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS PPC_BITMASK(36, 39)
>   
>   /* NxC Cache Watch 0 Specification */
>   #define X_PC_NXC_WATCH0_SPEC                    0x2A0
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 2050ed5efd..ff3d2d9c7b 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -217,6 +217,20 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>       return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
>   }
>   
> +static uint8_t nvc_table_compress_shift(PnvXive2 *xive)
> +{
> +    uint8_t shift =  GETFIELD(PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS,
> +                              xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
> +    return shift > 8 ? 0 : shift;
> +}
> +
> +static uint8_t nvg_table_compress_shift(PnvXive2 *xive)
> +{
> +    uint8_t shift = GETFIELD(PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS,
> +                             xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
> +    return shift > 8 ? 0 : shift;
> +}
> +
>   static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
>                                      uint32_t idx)
>   {
> @@ -238,6 +252,12 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
>           return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
>       }
>   
> +    if (type == VST_NVG) {
> +        idx >>= nvg_table_compress_shift(xive);
> +    } else if (type == VST_NVC) {
> +        idx >>= nvc_table_compress_shift(xive);
> +    }
> +
>       if (VSD_INDIRECT & vsd) {
>           return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
>       }



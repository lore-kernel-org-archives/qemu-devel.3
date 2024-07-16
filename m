Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA50C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 20:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToeD-0004Iy-Rp; Tue, 16 Jul 2024 16:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sToeB-00049T-Ic; Tue, 16 Jul 2024 16:19:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sToe9-00020J-RW; Tue, 16 Jul 2024 16:19:39 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNr5M2QCnz4x4c;
 Wed, 17 Jul 2024 06:19:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNr5J6YVYz4wym;
 Wed, 17 Jul 2024 06:19:32 +1000 (AEST)
Message-ID: <b5d2ead5-1f47-4690-8dba-418468d5f83a@kaod.org>
Date: Tue, 16 Jul 2024 22:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] pnv/xive2: Structure/define alignment changes
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
 <20240716195633.12679-3-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240716195633.12679-3-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Made changes to some structure and define elements to ease review in
> next patchset.
> 
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/intc/pnv_xive2.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index af9ab68fc6..08b6da78fb 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -45,16 +45,16 @@ typedef struct XiveVstInfo {
>   
>   static const XiveVstInfo vst_infos[] = {
>   
> -    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),  16 },
> -    [VST_ESB]  = { "ESB",  1,                  16 },
> -    [VST_END]  = { "ENDT", sizeof(Xive2End),  16 },
> +    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),     16 },
> +    [VST_ESB]  = { "ESB",  1,                    16 },
> +    [VST_END]  = { "ENDT", sizeof(Xive2End),     16 },
>   
> -    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),  16 },
> -    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc), 16 },
> -    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc), 16 },
> +    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),     16 },
> +    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc),    16 },
> +    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc),    16 },
>   
> -    [VST_IC]  =  { "IC",   1 /* ? */         , 16 }, /* Topology # */
> -    [VST_SYNC] = { "SYNC", 1 /* ? */         , 16 }, /* Topology # */
> +    [VST_IC]  =  { "IC",   1, /* ? */            16 }, /* Topology # */
> +    [VST_SYNC] = { "SYNC", 1, /* ? */            16 }, /* Topology # */
>   
>       /*
>        * This table contains the backing store pages for the interrupt
> @@ -1720,13 +1720,13 @@ static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
>   /*
>    * Sync MMIO page (write only)
>    */
> -#define PNV_XIVE2_SYNC_IPI      0x000
> -#define PNV_XIVE2_SYNC_HW       0x080
> -#define PNV_XIVE2_SYNC_NxC      0x100
> -#define PNV_XIVE2_SYNC_INT      0x180
> -#define PNV_XIVE2_SYNC_OS_ESC   0x200
> -#define PNV_XIVE2_SYNC_POOL_ESC 0x280
> -#define PNV_XIVE2_SYNC_HARD_ESC 0x300
> +#define PNV_XIVE2_SYNC_IPI              0x000
> +#define PNV_XIVE2_SYNC_HW               0x080
> +#define PNV_XIVE2_SYNC_NxC              0x100
> +#define PNV_XIVE2_SYNC_INT              0x180
> +#define PNV_XIVE2_SYNC_OS_ESC           0x200
> +#define PNV_XIVE2_SYNC_POOL_ESC         0x280
> +#define PNV_XIVE2_SYNC_HARD_ESC         0x300
>   
>   static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
>                                          unsigned size)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA72C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokUe-0000iR-Io; Mon, 25 Mar 2024 09:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokUR-0000SN-M1; Mon, 25 Mar 2024 09:35:53 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=rDMc=K7=kaod.org=clg@ozlabs.org>)
 id 1rokUO-0007pf-7W; Mon, 25 Mar 2024 09:35:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3DTX4J1Kz4wyR;
 Tue, 26 Mar 2024 00:35:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3DTS2gGgz4wnq;
 Tue, 26 Mar 2024 00:35:40 +1100 (AEDT)
Message-ID: <d9745d90-2982-46b7-879f-e5ad7cde47f0@kaod.org>
Date: Mon, 25 Mar 2024 14:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] pnv/phb4: Implement IODA PCT table
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
 <20240321100422.5347-9-saif.abrar@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240321100422.5347-9-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=rDMc=K7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/21/24 11:04, Saif Abrar wrote:
> IODA PCT table (#3) is implemented
> without any functionality, being a debug table.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/pci-host/pnv_phb4.c              | 6 ++++++
>   include/hw/pci-host/pnv_phb4.h      | 2 ++
>   include/hw/pci-host/pnv_phb4_regs.h | 1 +
>   3 files changed, 9 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 6823ffab54..f48750ee54 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -263,6 +263,10 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>           mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>           mask -= 1;
>           break;
> +    case IODA3_TBL_PCT:
> +        tptr = phb->ioda_PCT;
> +        mask = 7;
> +        break;
>       case IODA3_TBL_RCAM:
>           mask = phb->big_phb ? 127 : 63;
>           break;
> @@ -361,6 +365,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>       /* Handle side effects */
>       switch (table) {
>       case IODA3_TBL_LIST:
> +    case IODA3_TBL_PCT:
> +        /* No action for debug tables */
>           break;
>       case IODA3_TBL_MIST: {
>           /* Special mask for MIST partial write */
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 91e81eee0e..6d83e5616f 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -64,6 +64,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
>   #define PNV_PHB4_MAX_LSIs          8
>   #define PNV_PHB4_MAX_INTs          4096
>   #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
> +#define PNV_PHB4_MAX_PCT           128
>   #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>   #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>   #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
> @@ -144,6 +145,7 @@ struct PnvPHB4 {
>       /* On-chip IODA tables */
>       uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>       uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>       uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>       uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>       uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index c1d5a83271..e30adff7b2 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -486,6 +486,7 @@
>   
>   #define IODA3_TBL_LIST          1
>   #define IODA3_TBL_MIST          2
> +#define IODA3_TBL_PCT           3
>   #define IODA3_TBL_RCAM          5
>   #define IODA3_TBL_MRT           6
>   #define IODA3_TBL_PESTA         7



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BADCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJrV-00069h-5Q; Tue, 05 May 2026 13:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKJrI-00068p-RG; Tue, 05 May 2026 13:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKJrE-0008V8-FK; Tue, 05 May 2026 13:46:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645AjXDq852737; Tue, 5 May 2026 17:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=titqAX
 a69+vdjXbwl8oNxmcCKgHzy4XSObnA+6W1c8o=; b=ezCv18DrxNgX+9PdibMOZP
 JDzQvKgCB9Q6/4/FPyOuAPEB6sD4A5a9QJkmGlC0R1h+eAKEBdTfgyMV1Yx6IBWE
 s0xwwo3ac8/1ZPYpzNR0IzbT1Bft9SqlFekrjU/2y34LXAqz4QoEPQkjvqUVzbip
 NoK+nZUZbGSfBxNsIhnLqFUK9LsVaroCNLMIoggux2cKJjgLJPlfw/elOaUmyr1X
 rJaUBLCuPHq5QGQgXqSiVla8SAy50HXhBi0PUvhjodIwbW2it0rpEP6KyF7MeF1Z
 Bsl21gmNddWzqQvP5ZOT/+NQPJkIwysX7ysVuiQSpDIrFUT4QlalqSpuWy2FWU3g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4mnfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 17:46:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645HdUoJ027840;
 Tue, 5 May 2026 17:46:45 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h2py7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 17:46:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645HkiWB59572520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 17:46:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849D35805D;
 Tue,  5 May 2026 17:46:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFE155805A;
 Tue,  5 May 2026 17:46:38 +0000 (GMT)
Received: from [9.39.22.124] (unknown [9.39.22.124])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 17:46:38 +0000 (GMT)
Message-ID: <ccf998df-3d57-4d4f-8ff5-5ca2981d9939@linux.ibm.com>
Date: Tue, 5 May 2026 23:16:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] pnv/phb4: Set link-active status in HPSTAT and LMR
 registers
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfXwxVPvFqYuezn
 SzzXmTIj2xlislV5fbq8SeRd6zssoH8a2cFOzXzZrvJLAcaOhjKgCq6B4Eh4d/VQBz9IKw+rb11
 J8EoAhBzYz2F+Bnsp2T6XHc5QRujPxPlERcJLv4O1r7I9eo6nLtLkITdiJ3+lP1B7ZvyZ0t1eqA
 vfVoIfVN561m7J42pivib+V7LJwM22NbBVQNd0oK5M+X0z7Miy3yuullXipmMaNLwxOwWsTh6kt
 fkZIXwdmzG/BkidmaiSrXXbFvwAI7XCdEDsZYcwqpzcde7+DBWOk87GUHvkItD9njwGzzhJm1zq
 gCyqswFWr2F9xGNyueZFxEuH4P8LarH4M8sG2nFC7r0EbEfz+OvjwEAnhjzNmWVcHObmQ3tjRnz
 uzu2N4YsIZ40zSPhOFD5ALNmvr/rJjRTiGRnW2SlBzVmUfYplfhzr2vH5V3ZcnRi4ooZbWczT26
 f+vYVtJaYVkBmisHslA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa2d06 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=utTTN3X8DS7UbbIJwekA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Os2V_fvTzxn2F7oMP6AhX1fKIFhmsGIj
X-Proofpoint-ORIG-GUID: 2s6XUO1Wk_UxIFKSt_607R6WTNhp4gyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 05/03/26 11:39 am, Saif Abrar wrote:
> Config-read the link-status register in the PCI-E macro,
> Depending on the link-active bit, set the link-active status
> in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
> Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
> after config-reading the slot-status in the PCI-E macro.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
> v3: Updates for coding guidelines.
> 
>   hw/pci-host/pnv_phb4.c | 59 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 25539b7c32..c35f632e64 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -511,6 +511,20 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>       return rpc->exp_offset;
>   }
>   
> +/*
> + * Config-read the link-status register in the PCI-E macro,
> + * convert to LE and check the link-active bit.
> + */
> +static uint32_t is_link_active(PnvPHB4 *phb)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_offset = get_exp_offset(pdev);
> +
> +    return (bswap32(pnv_phb4_rc_config_read(phb, exp_offset + PCI_EXP_LNKSTA, 4)
> +                    ) & PCI_EXP_LNKSTA_DLLLA);

Shouldn't we be reading only 16 bits for PCI_EXP_LNKSTA ?

> +}
> +
>   /*
>    * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>    * RC-config space values and masks are LE.
> @@ -729,6 +743,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           val = 0;
>           break;
>   
> +    case PHB_PCIE_HOTPLUG_STATUS:
> +        /* For normal operations, Simspeed diagnostic bit is always zero */
> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
> +        break;
> +
>       /* Read only registers */
>       case PHB_CPU_LOADSTORE_STATUS:
>       case PHB_ETU_ERR_SUMMARY:
> @@ -876,6 +895,10 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>   static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>   {
>       PnvPHB4 *phb = PNV_PHB4(opaque);
> +    /* Get the PCI-E capability offset from the root-port */
> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
> +    uint32_t exp_base = get_exp_offset(pdev);
>       uint64_t val;
>   
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> @@ -944,8 +967,37 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
>           return val;
>   
> +    /*
> +     * Read PCI-E registers and set status for:
> +     * - Card present (active low bit 10)
> +     * - Link active  (bit 12)
> +     */
>       case PHB_PCIE_HOTPLUG_STATUS:
> -        /* Clear write-only bit */
> +        /*
> +         * Presence-status bit hpi_present_n is active-low, with reset value 1.
> +         * Start by setting this bit to 1, indicating the card is not present.
> +         * Then check the PCI-E register and clear the bit if card is present.
> +         */
> +        val |= PHB_PCIE_HPSTAT_PRESENCE;
> +
> +        /*
> +         * Config-read the PCI-E macro register for slot-status.
> +         * Method for config-read converts to BE value.
> +         * To check actual bit in the PCI-E register,
> +         * convert the value back to LE using bswap32().
> +         * Clear the Presence-status active low bit.
> +         */
> +        if (bswap32(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA, 4))
> +                    & PCI_EXP_SLTSTA_PDS) {
> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
> +        }
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
> +        }
> +
> +        /* Clear write-only resample-bit */
>           val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
>           return val;
>   
> @@ -953,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>       case PHB_PCIE_LMR:
>           /* These write-only bits always read as 0 */
>           val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_LMR_LINKACTIVE;
> +        }
>           return val;
>   
>       /* Silent simple reads */



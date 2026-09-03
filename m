Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF2BC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AdT-00038o-6R; Thu, 03 Sep 2026 12:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AdR-00038I-UB; Thu, 03 Sep 2026 12:49:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2AdN-0006Xm-6z; Thu, 03 Sep 2026 12:49:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2qDX2292335; Thu, 3 Sep 2026 16:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=1GGRHx2Qpnjq4UdksfFDsktzQzjRsS
 CfnGDKDvd+SN4=; b=JBof4gBd3tr4QR/Wt8mhwTtjhuGKMkk3diedRNDgXTu5SU
 QnWvmGRto2cBhStbtSJecrIN0TaymsTX4tziJb0wQFrZF70ZeNz/0S7S1J1XB3WQ
 ihVQwVNUkwy2VJ5j7rF46V92jKpTPmAvJ2vWZgx1rCdrzg6plRc3zrN1C0zdRzrV
 wBKZu6HvDEs8nP9Aq7JH+irWWjQPBRS7egtAnM+KgwSB6W5P9VTdOMfvUaHSfzGB
 fd9AeCB1kLmsF7rW8yLWSO8QiV7GEL61RVfdkXQXeYGcuT9q5TS2AolFn0rrbm9K
 P/lJvE9kMSf71ru0WiNEVlzUCb/tC28yPdNQuI9A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue5jua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:49:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfMm2003053;
 Thu, 3 Sep 2026 16:49:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hrfrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:49:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683Gncnl21758520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:49:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEC3F58050;
 Thu,  3 Sep 2026 16:49:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23B7558045;
 Thu,  3 Sep 2026 16:49:37 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:49:37 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------z5ByZX0whrwMRzsk5Se2suYM"
Message-ID: <234bb974-eaa9-4558-8fb1-4e3d7519e0ec@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:49:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] pnv/phb5: Implement write-clear and return 1's on
 unimplemented reg read
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-6-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-6-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4k7WoP8GFDPF2xeEu8uVLfjv8SOLdoIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX3PY2f/PFSIFA
 P4dZMMX9/xzxbjSJDuNSS278YN/soNO0+8VE6eumsymxyMh55dpQDE6OH/Ym5V0PyxRz8b92e9P
 l+RkKOuCK7flpjXv9PYXNshaa4nP3dz5UbYQlrTcIlZYExBESKhluZr9pRxd9FWXP9v5fkdqKf/
 D4o9fsUQdfuNcs2wPXeT9ujJBFdqxFgwbvkXQgg2kHGTI2ZjUza06er4ynqvB6eK9PK1cq4gWbx
 D/hfGKstgV35HP4A6Ndci42HdMxPG5pgKJaAnSslDvcpUYOzKh0HuB3NLjDsrHvypBVKaubm6Mi
 iiPQkEHSwdN5ZNH8kV4w4jrJQu00yKGaShYkICvg8e9GpN3EGgNUifakk//t7jSnmNBqW/tRcdD
 PR1l/L3BiXJfKfRxWv046D2Pj8/SQN2J2ZRJe7eggvG5zPsG33/9hLgtD1LEstBbSso6ZV4ur2W
 XlDU+5hi6dm5lFdJlGg==
X-Proofpoint-ORIG-GUID: eZ9QbzhR1mSpCMuFw-Mx-dHrKRbaPwLm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX4uEOOK5lRldL
 O3IVA23/TCNIonDLiT6eukaGs5mnDDX+cxiqdw2IL6KUwbX8ggI0j8KaUT654/si0l/bYD1Ad5T
 TokLroUXOs+PnIsnY/haMU3h57BSMNE=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a99a525 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=QFJanSqRX0eI6_oFMY0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JxqXzK6u00C-Grl0AcMA:9 a=B-V5WLDoNReggvfB:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030144
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------z5ByZX0whrwMRzsk5Se2suYM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> Implement write-1-to-clear and write-X-to-clear logic.
> Update registers with silent simple read and write.
> Return all 1's when an unimplemented/reserved register is read.
>
> Test that reading address 0x0 returns all 1's (i.e. -1).
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater<clg@kaod.org>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c              | 201 ++++++++++++++++++++++------
>   hw/pci-host/pnv_phb5.c              | 110 ++++++++++++++-
>   include/hw/pci-host/pnv_phb4.h      |   3 +
>   include/hw/pci-host/pnv_phb4_regs.h |  14 +-
>   include/hw/pci-host/pnv_phb5.h      |  17 ++-
>   tests/qtest/pnv-phb-test.c          |  14 +-
>   6 files changed, 304 insertions(+), 55 deletions(-)
>
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 9730fd1f8a..b13165f84d 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -2,7 +2,7 @@
>    * QEMU PowerPC PowerNV (POWER9) PHB4 model
>    * QEMU PowerPC PowerNV (POWER10) PHB5 model
>    *
> - * Copyright (c) 2018-2026, IBM Corporation.
> + * Copyright (c) 2018-2025, IBM Corporation.
>    *
>    * This code is licensed under the GPL version 2 or later. See the
>    * COPYING file in the top-level directory.
> @@ -540,6 +540,10 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
>       RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
>       RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0,    0xFFFFFFFF);
>       RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0,    0x807FFFFF);
> +    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
> +    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
> +    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
> +    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
>   }
>   
>   /* Apply sticky-mask to the reset-value and write to the reg-address */
> @@ -577,7 +581,7 @@ static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
>       phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642470000;
>   }
>   
> -static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
> +void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>                                  unsigned size)
>   {
>       PnvPHB4 *phb = PNV_PHB4(opaque);
> @@ -602,8 +606,41 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           return;
>       }
>   
> -    /* Handle masking */
> +    /* Handle RO, W1C, WxC and masking */
>       switch (off) {
> +    /* W1C: Write-1-to-Clear registers */
> +    case PHB_TXE_ERR_STATUS:
> +    case PHB_RXE_ARB_ERR_STATUS:
> +    case PHB_RXE_MRG_ERR_STATUS:
> +    case PHB_RXE_TCE_ERR_STATUS:
> +    case PHB_ERR_STATUS:
> +    case PHB_REGB_ERR_STATUS:
> +    case PHB_PCIE_DLP_ERRLOG1:
> +    case PHB_PCIE_DLP_ERRLOG2:
> +    case PHB_PCIE_DLP_ERR_STATUS:
> +    case PHB_PBL_ERR_STATUS:
> +        phb->regs[off >> 3] &= ~val;
> +        return;
> +
> +    /* WxC: Clear register on any write */
> +    case PHB_PBL_ERR1_STATUS:
> +    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR_LOG_1:
> +    case PHB_REGB_ERR1_STATUS:
> +    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR_LOG_1:
> +    case PHB_TXE_ERR1_STATUS:
> +    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR_LOG_1:
> +    case PHB_RXE_ARB_ERR1_STATUS:
> +    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR_LOG_1:
> +    case PHB_RXE_MRG_ERR1_STATUS:
> +    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR_LOG_1:
> +    case PHB_RXE_TCE_ERR1_STATUS:
> +    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR_LOG_1:
> +    case PHB_ERR1_STATUS:
> +    case PHB_ERR_LOG_0 ... PHB_ERR_LOG_1:
> +        phb->regs[off >> 3] = 0;
> +        return;
> +
> +    /* Write value updated by masks */
>       case PHB_LSI_SOURCE_ID:
>           val &= PHB_LSI_SRC_ID;
>           break;
> @@ -642,7 +679,6 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>       case PHB_LEM_WOF:
>           val = 0;
>           break;
> -    /* TODO: More regs ..., maybe create a table with masks... */
>   
>       /* Read only registers */
>       case PHB_CPU_LOADSTORE_STATUS:
> @@ -651,6 +687,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>       case PHB_PHB4_TCE_CAP:
>       case PHB_PHB4_IRQ_CAP:
>       case PHB_PHB4_EEH_CAP:
> +    case PHB_VERSION:
> +    case PHB_DMA_CHAN_STATUS:
> +    case PHB_TCE_TAG_STATUS:
> +    case PHB_PBL_BUF_STATUS:
> +    case PHB_PCIE_BNR:
>           return;
>       }
>   
> @@ -673,6 +714,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>               pnv_phb4_update_all_msi_regions(phb);
>           }
>           break;
> +
>       case PHB_M32_START_ADDR:
>       case PHB_M64_UPPER_BITS:
>           if (changed) {
> @@ -720,32 +762,69 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>           break;
>   
>       /* Silent simple writes */
> -    case PHB_ASN_CMPM:
> -    case PHB_CONFIG_ADDRESS:
> -    case PHB_IODA_ADDR:
> -    case PHB_TCE_KILL:
> -    case PHB_TCE_SPEC_CTL:
> -    case PHB_PEST_BAR:
> -    case PHB_PELTV_BAR:
> +
> +    /* PHB Fundamental register set A */
> +    case PHB_CONFIG_DATA ... PHB_LOCK1:
>       case PHB_RTT_BAR:
> -    case PHB_LEM_FIR_ACCUM:
> -    case PHB_LEM_ERROR_MASK:
> -    case PHB_LEM_ACTION0:
> -    case PHB_LEM_ACTION1:
> -    case PHB_TCE_TAG_ENABLE:
> +    case PHB_PELTV_BAR:
> +    case PHB_PEST_BAR:
> +    case PHB_CRW_BAR ... PHB_ASN_CMPM:
> +    case PHB_CAPI_CMPM ... PHB_M64_AOMASK:
> +    case PHB_NXLATE_PREFIX ... PHB_DMA_SYNC:
> +    case PHB_TCE_KILL ... PHB_IODA_ADDR:
> +    case PHB_PAPR_ERR_INJ_CTL ... PHB_PAPR_ERR_INJ_MASK:
>       case PHB_INT_NOTIFY_ADDR:
>       case PHB_INT_NOTIFY_INDEX:
> -    case PHB_DMA_SYNC:
> -       break;
> +    /* Fundamental register set B */
> +    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
> +    /* FIR & Error registers */
> +    case PHB_LEM_FIR_ACCUM:
> +    case PHB_LEM_ERROR_MASK:
> +    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
> +    case PHB_ERR_INJECT ... PHB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_ERR_STATUS_MASK ... PHB_ERR1_STATUS_MASK:
> +    case PHB_TXE_ERR_INJECT ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_TXE_ERR_STATUS_MASK ... PHB_TXE_ERR1_STATUS_MASK:
> +    case PHB_RXE_ARB_ERR_INJECT ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_ARB_ERR_STATUS_MASK ... PHB_RXE_ARB_ERR1_STATUS_MASK:
> +    case PHB_RXE_MRG_ERR_INJECT ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_MRG_ERR_STATUS_MASK ... PHB_RXE_MRG_ERR1_STATUS_MASK:
> +    case PHB_RXE_TCE_ERR_INJECT ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
> +    case PHB_RXE_TCE_ERR_STATUS_MASK ... PHB_RXE_TCE_ERR1_STATUS_MASK:
> +    /* Performance monitor & Debug registers */
> +    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
> +    /* REGB Registers */
> +    /* PBL core */
> +    case PHB_PBL_CONTROL:
> +    case PHB_PBL_TIMEOUT_CTRL:
> +    case PHB_PBL_NPTAG_ENABLE:
> +    case PHB_PBL_SYS_LINK_INIT:
> +    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
> +    case PHB_PBL_ERR_STATUS_MASK ... PHB_PBL_ERR1_STATUS_MASK:
> +    /* PCI-E stack */
> +    case PHB_PCIE_SCR:
> +    case PHB_PCIE_DLP_STR ... PHB_PCIE_HOTPLUG_STATUS:
> +    case PHB_PCIE_LMR ... PHB_PCIE_DLP_LSR:
> +    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_TRCRDDATA:
> +    case PHB_PCIE_DLP_ERR_COUNTERS:
> +    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
> +    case PHB_PCIE_TRACE_CTRL:
> +    case PHB_PCIE_MISC_STRAP:
> +    /* Error registers */
> +    case PHB_REGB_ERR_INJECT:
> +    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
> +    case PHB_REGB_ERR_STATUS_MASK ... PHB_REGB_ERR1_STATUS_MASK:
> +        break;
>   
>       /* Noise on anything else */
>       default:
> -        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=%"PRIx64"\n",
> +        qemu_log_mask(LOG_UNIMP,
> +                      "phb4: unimplemented reg_write 0x%"PRIx64"=%"PRIx64"\n", off, val); } } -static uint64_t pnv_phb4_reg_read(void *opaque, 
> hwaddr off, unsigned size) +uint64_t pnv_phb4_reg_read(void *opaque, 
> hwaddr off, unsigned size) { PnvPHB4 *phb = PNV_PHB4(opaque); uint64_t 
> val; @@ -828,36 +907,74 @@ static uint64_t pnv_phb4_reg_read(void 
> *opaque, hwaddr off, unsigned size) return val; /* Silent simple reads 
> */ + /* PHB Fundamental register set A */ case PHB_LSI_SOURCE_ID: + 
> case PHB_DMA_CHAN_STATUS: case PHB_CPU_LOADSTORE_STATUS: - case 
> PHB_ASN_CMPM: + case PHB_CONFIG_DATA ... PHB_LOCK1: case 
> PHB_PHB4_CONFIG: + case PHB_RTT_BAR: + case PHB_PELTV_BAR: case 
> PHB_M32_START_ADDR: - case PHB_CONFIG_ADDRESS: - case PHB_IODA_ADDR: - 
> case PHB_RTC_INVALIDATE: - case PHB_TCE_KILL: - case PHB_TCE_SPEC_CTL: 
> case PHB_PEST_BAR: - case PHB_PELTV_BAR: - case PHB_RTT_BAR: + case 
> PHB_CRW_BAR ... PHB_ASN_CMPM: + case PHB_CAPI_CMPM: + case 
> PHB_M64_AOMASK: case PHB_M64_UPPER_BITS: - case PHB_CTRLR: - case 
> PHB_LEM_FIR_ACCUM: - case PHB_LEM_ERROR_MASK: - case PHB_LEM_ACTION0: 
> - case PHB_LEM_ACTION1: - case PHB_TCE_TAG_ENABLE: + case 
> PHB_NXLATE_PREFIX: + case PHB_RTC_INVALIDATE ... PHB_IODA_ADDR: + case 
> PHB_PAPR_ERR_INJ_CTL ... PHB_ETU_ERR_SUMMARY: case 
> PHB_INT_NOTIFY_ADDR: case PHB_INT_NOTIFY_INDEX: - case PHB_Q_DMA_R: - 
> case PHB_ETU_ERR_SUMMARY: - break; - - /* Noise on anything else */ + 
> /* Fundamental register set B */ + case PHB_CTRLR: + case 
> PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R: + case PHB_TCE_TAG_STATUS: + /* 
> FIR & Error registers */ + case PHB_LEM_FIR_ACCUM ... 
> PHB_LEM_ERROR_MASK: + case PHB_LEM_ACTION0 ... PHB_LEM_WOF: + case 
> PHB_ERR_STATUS ... PHB_ERR_AIB_FENCE_ENABLE: + case PHB_ERR_LOG_0 ... 
> PHB_ERR1_STATUS_MASK: + case PHB_TXE_ERR_STATUS ... 
> PHB_TXE_ERR_AIB_FENCE_ENABLE: + case PHB_TXE_ERR_LOG_0 ... 
> PHB_TXE_ERR1_STATUS_MASK: + case PHB_RXE_ARB_ERR_STATUS ... 
> PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE: + case PHB_RXE_ARB_ERR_LOG_0 ... 
> PHB_RXE_ARB_ERR1_STATUS_MASK: + case PHB_RXE_MRG_ERR_STATUS ... 
> PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE: + case PHB_RXE_MRG_ERR_LOG_0 ... 
> PHB_RXE_MRG_ERR1_STATUS_MASK: + case PHB_RXE_TCE_ERR_STATUS ... 
> PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE: + case PHB_RXE_TCE_ERR_LOG_0 ... 
> PHB_RXE_TCE_ERR1_STATUS_MASK: + /* Performance monitor & Debug 
> registers */ + case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1: + /* REGB 
> Registers */ + /* PBL core */ + case PHB_PBL_CONTROL: + case 
> PHB_PBL_TIMEOUT_CTRL: + case PHB_PBL_NPTAG_ENABLE: + case 
> PHB_PBL_SYS_LINK_INIT: + case PHB_PBL_BUF_STATUS: + case 
> PHB_PBL_ERR_STATUS ... PHB_PBL_ERR_INJECT: + case 
> PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE: + case 
> PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR1_STATUS_MASK: + /* PCI-E stack */ + 
> case PHB_PCIE_BNR ... PHB_PCIE_DLP_STR: + case PHB_PCIE_DLP_LSR: + 
> case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_CTL: + case 
> PHB_PCIE_DLP_TRCRDDATA: + case PHB_PCIE_DLP_ERRLOG1 ... 
> PHB_PCIE_DLP_ERR_COUNTERS: + case PHB_PCIE_DLP_EIC ... 
> PHB_PCIE_LANE_EQ_CNTL23: + case PHB_PCIE_TRACE_CTRL: + case 
> PHB_PCIE_MISC_STRAP: + /* Error registers */ + case 
> PHB_REGB_ERR_STATUS ... PHB_REGB_ERR_INJECT: + case 
> PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE: + case 
> PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR1_STATUS_MASK: + break; + + /* 
> Noise on unimplemented read, return all 1's */ default: - 
> qemu_log_mask(LOG_UNIMP, "phb4: reg_read 0x%"PRIx64"=%"PRIx64"\n",
> -                      off, val);
> +        qemu_log_mask(LOG_UNIMP, "phb4: unimplemented reg_read 0x%"PRIx64"\n",
> +                      off);
> +        val = ~0ull;
>       }
>       return val;
>   }
> @@ -1799,7 +1916,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
>       pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
>   }
>   
> -static void pnv_phb4_realize(DeviceState *dev, Error **errp)
> +void pnv_phb4_realize(DeviceState *dev, Error **errp)
>   {
>       PnvPHB4 *phb = PNV_PHB4(dev);
>       XiveSource *xsrc = &phb->xsrc;
> diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
> index 4906a82c6f..b09351f69f 100644
> --- a/hw/pci-host/pnv_phb5.c
> +++ b/hw/pci-host/pnv_phb5.c
> @@ -103,10 +103,117 @@ static void pnv_phb5_reset(Object *obj, ResetType type)
>       pnv_phb5_pbl_core_reset(phb);
>   }
>   
> +static uint64_t pnv_phb5_reg_read(void *opaque, hwaddr off, unsigned size)
> +{
> +    PnvPHB4 *phb = PNV_PHB4(opaque);
> +
> +    uint64_t val = ~0ull;
> +
> +    switch (off) {
> +    /* Registers removed in PHB5 from PHB4, return all 1's on read */
> +    case PHB_CRW_BAR ... PHB_ASN_CMPM:
> +    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
> +    case P16_ECAP ... P16_SRDPM:
> +    case PHB_PBL_NBW_CMP_MASK:
> +        qemu_log_mask(LOG_GUEST_ERROR, "phb5: read from reserved offset 0x%"
> +                      PRIx64"\n", off);
> +        return ~0ULL;
> +
> +    /* New registers in PHB5 from PHB4 */
> +    case P16_LDPM_PHB5 ... P16_SRDPM_PHB5:
> +    case P32_ECAP ... P32_STAT:
> +    case PHB_PCIE_DLP_LANE_PWR:
> +    case PHB_PCIE_DLP_RXMGN:
> +    case PHB_PCIE_DLP_LZC:
> +    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
> +    case PHB_PCIE_PHY_EQ_CTL:
> +    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
> +        val = phb->regs[off >> 3];
> +        break;
> +
> +    default:
> +        val = pnv_phb4_reg_read(opaque, off, size);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_phb5_reg_write(void *opaque, hwaddr off, uint64_t val,
> +                               unsigned size)
> +{
> +    PnvPHB4 *phb = PNV_PHB4(opaque);
> +
> +    switch (off) {
> +    /* Registers removed in PHB5 from PHB4 */
> +    case PHB_CRW_BAR ... PHB_ASN_CMPM:
> +    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
> +    case P16_ECAP ... P16_SRDPM:
> +    case PHB_PBL_NBW_CMP_MASK:
> +        qemu_log_mask(LOG_GUEST_ERROR, "phb5: write to reserved offset 0x%"
> +                      PRIx64"\n", off);
> +        return;
> +
> +    /* New registers in PHB5 from PHB4 */
> +
> +    /* W1C: Write-1-to-Clear registers */
> +    case P16_STAT_PHB5 ... P16_SRDPM_PHB5:
> +        phb->regs[off >> 3] &= ~val;
> +        break;
> +
> +    /* Read only registers */
> +    case P16_ECAP_PHB5:
> +    case P32_ECAP:
> +    case P32_STAT:
> +    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
> +        return;
> +
> +    /* Simple write */
> +    case P32_CTL:
> +    case PHB_PCIE_DLP_LANE_PWR:
> +    case PHB_PCIE_DLP_RXMGN:
> +    case PHB_PCIE_DLP_LZC:
> +    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
> +    case PHB_PCIE_PHY_EQ_CTL:
> +        phb->regs[off >> 3] = val;
> +        break;
> +
> +    default:
> +        pnv_phb4_reg_write(opaque, off, val, size);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_phb5_reg_ops = {
> +    .read = pnv_phb5_reg_read,
> +    .write = pnv_phb5_reg_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_phb5_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPHB4 *phb = PNV_PHB4(dev);
> +    char name[32];
> +
> +    pnv_phb4_realize(dev, errp);
> +
> +    /* Controller Registers */
> +    snprintf(name, sizeof(name), "phb5-%d.%d-regs", phb->chip_id,
> +             phb->phb_id);
> +    memory_region_init_io(&phb->mr_regs, OBJECT(phb), &pnv_phb5_reg_ops, phb,
> +                          name, 0x2000);
> +}
> +
>   static void pnv_phb5_class_init(ObjectClass *klass, const void *data)
>   {
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>       ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
> +    dc->realize         = pnv_phb5_realize;
> +    dc->user_creatable  = false;
> +
>       rc->phases.enter = pnv_phb5_reset;
>   }
>   
> @@ -114,7 +221,8 @@ static const TypeInfo pnv_phb5_type_info = {
>       .name          = TYPE_PNV_PHB5,
>       .parent        = TYPE_PNV_PHB4,
>       .instance_size = sizeof(PnvPHB4),
> -    .class_init    = pnv_phb5_class_init
> +    .class_init    = pnv_phb5_class_init,
> +    .class_size    = sizeof(PnvPHB4Class)
>   };
>   
>   static void pnv_phb5_register_types(void)
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 567a3e6e95..33e11a3fe8 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -173,6 +173,9 @@ PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
>   void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
>   void pnv_phb4_cfg_core_reset(PCIDevice *d);
>   extern const MemoryRegionOps pnv_phb4_xscom_ops;
> +uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size);
> +void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size);
> +void pnv_phb4_realize(DeviceState *dev, Error **errp);
>   
>   /*
>    * PHB4 PEC (PCI Express Controller)
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index d0962c1607..9ad6713d37 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -173,6 +173,7 @@
>   #define PHB_PEST_BAR                    0x1a8
>   #define   PHB_PEST_BAR_ENABLE           PPC_BIT(0)
>   #define   PHB_PEST_BASE_ADDRESS         PPC_BITMASK(8, 51)
> +#define PHB_CRW_BAR                     0x1B0
>   #define PHB_ASN_CMPM                    0x1C0
>   #define   PHB_ASN_CMPM_ENABLE           PPC_BIT(63)
>   #define PHB_CAPI_CMPM                   0x1C8
> @@ -357,6 +358,11 @@
>   #define PHB_AER_RERR                            0x130
>   #define PHB_AER_ESID                            0x134
>   #define PHB_SEC_ECAP                            0x148
> +#define P16_ECAP                                0x174
> +#define P16_STAT                                0x180
> +#define P16_LDPM                                0x184
> +#define P16_FRDPM                               0x188
> +#define P16_SRDPM                               0x18C
>   #define PHB_LMR_ECAP                            0x1A0
>   #define PHB_LMR_CTLSTA_2                        0x1AC
>   #define PHB_LMR_CTLSTA_16                       0x1E4
> @@ -398,6 +404,7 @@
>   #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
>   #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
>   #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
> +#define PHB_PCIE_DLP_STR                0x1A18
>   #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
>   #define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
>   #define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
> @@ -427,18 +434,20 @@
>   #define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
>   #define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
>   #define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
> -
> +#define PHB_PCIE_DLP_LSR                0x1A48
> +#define PHB_PCIE_DLP_LANEZEROCTL        0x1A70
>   #define PHB_PCIE_DLP_CTL                0x1A78
>   #define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
>   #define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
> -
>   #define PHB_PCIE_DLP_TRWCTL             0x1A80
>   #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
>   #define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
> +#define PHB_PCIE_DLP_TRCRDDATA          0x1A88
>   #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
>   #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
>   #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
>   #define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
> +#define PHB_PCIE_DLP_EIC                0x1AC8
>   
>   #define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
>   #define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
> @@ -581,5 +590,4 @@
>   
>   #define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
>   
> -
>   #endif /* PCI_HOST_PNV_PHB4_REGS_H */
> diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
> index d76846068a..4534083fd5 100644
> --- a/include/hw/pci-host/pnv_phb5.h
> +++ b/include/hw/pci-host/pnv_phb5.h
> @@ -33,17 +33,22 @@ void pnv_phb5_cfg_core_reset(PCIDevice *d);
>       OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
>   
>   /* New registers in PHB5 from PHB4 */
> -#define P16_ECAP                                0x1F4
> -#define P16_STAT                                0x200
> -#define P16_LDPM                                0x204
> -#define P16_FRDPM                               0x208
> -#define P16_SRDPM                               0x20C
> +#define P16_ECAP_PHB5                           0x1F4
> +#define P16_STAT_PHB5                           0x200
> +#define P16_LDPM_PHB5                           0x204
> +#define P16_FRDPM_PHB5                          0x208
> +#define P16_SRDPM_PHB5                          0x20C
>   #define P32_ECAP                                0x224
>   #define P32_CAP                                 0x228
>   #define P32_CTL                                 0x22C
>   #define P32_STAT                                0x230
> +#define PHB_PCIE_DLP_LANE_PWR                   0x1A38
> +#define PHB_PCIE_DLP_RXMGN                      0x1A50
> +#define PHB_PCIE_DLP_LZC                        0x1A70
> +#define PHB_PCIE_DLP_LEC0                       0x1B00
> +#define PHB_PCIE_DLP_LEC1                       0x1B08
> +#define PHB_PCIE_PHY_EQ_CTL                     0x1B38
>   #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03         0x1B40
>   #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15         0x1B98
>   
> -
>   #endif /* PCI_HOST_PNV_PHB5_H */
> diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
> index 23238f1582..0c0f7fafac 100644
> --- a/tests/qtest/pnv-phb-test.c
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -88,11 +88,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
>       g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
>                        PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
>                        PPC_BITMASK(52, 54)));
> -
>   }
>   
>   /* Check that write-only bits/regs return 0 when read */
> -static void phb4_writeonly_read_test(QTestState *qts)
> +static void phb5_writeonly_read_test(QTestState *qts)
>   {
>       uint64_t val;
>   
> @@ -143,6 +142,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
>       g_assert_cmpuint(val, ==, 0x0);
>   }
>   
> +/* Check that reading an unimplemented address 0x0 returns -1 */
> +static void phb5_unimplemented_read_test(QTestState *qts)
> +{
> +    g_assert_cmpint(PHB5_XSCOM_READ(0x0), ==, -1);
> +}
> +
>   static void phb5_tests(void)
>   {
>       QTestState *qts = NULL;
> @@ -156,7 +161,10 @@ static void phb5_tests(void)
>       phb5_sticky_rst_test(qts);
>   
>       /* Check write-only logic */
> -    phb4_writeonly_read_test(qts);
> +    phb5_writeonly_read_test(qts);
> +
> +    /* Check unimplemented register read */
> +    phb5_unimplemented_read_test(qts);
>   
>       qtest_quit(qts);
>   }
--------------z5ByZX0whrwMRzsk5Se2suYM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>
    </p>
    <div
style=3D"font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #00=
0000;background-color: #FFFFFF; font-style: normal; font-weight: normal; =
text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK
</pre>
    </div>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 8/31/2026 7:30 AM, Saif Abrar wrote=
:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20260831123005.1485518-6-saif.abrar@linux.ibm.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">From: Saif Abrar <a class=3D=
"moz-txt-link-rfc2396E" href=3D"mailto:saif.abrar@linux.vnet.ibm.com">&lt=
;saif.abrar@linux.vnet.ibm.com&gt;</a>

Implement write-1-to-clear and write-X-to-clear logic.
Update registers with silent simple read and write.
Return all 1's when an unimplemented/reserved register is read.

Test that reading address 0x0 returns all 1's (i.e. -1).

Signed-off-by: Saif Abrar <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: C=C3=A9dric Le Goater <a class=3D"moz-txt-link-rfc2396E" hre=
f=3D"mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Caleb Schlossin <a class=3D"moz-txt-link-rfc2396E" href=3D"m=
ailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/pci-host/pnv_phb4.c              | 201 ++++++++++++++++++++++------
 hw/pci-host/pnv_phb5.c              | 110 ++++++++++++++-
 include/hw/pci-host/pnv_phb4.h      |   3 +
 include/hw/pci-host/pnv_phb4_regs.h |  14 +-
 include/hw/pci-host/pnv_phb5.h      |  17 ++-
 tests/qtest/pnv-phb-test.c          |  14 +-
 6 files changed, 304 insertions(+), 55 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9730fd1f8a..b13165f84d 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -2,7 +2,7 @@
  * QEMU PowerPC PowerNV (POWER9) PHB4 model
  * QEMU PowerPC PowerNV (POWER10) PHB5 model
  *
- * Copyright (c) 2018-2026, IBM Corporation.
+ * Copyright (c) 2018-2025, IBM Corporation.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -540,6 +540,10 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
     RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
     RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0,    0xFFFFFFFF);
     RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0,    0x807FFFFF);
+    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
+    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
 }
=20
 /* Apply sticky-mask to the reset-value and write to the reg-address */
@@ -577,7 +581,7 @@ static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
     phb-&gt;regs[PHB_PBL_SYS_LINK_INIT &gt;&gt; 3] =3D 0x80088B464247000=
0;
 }
=20
-static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
+void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
                                unsigned size)
 {
     PnvPHB4 *phb =3D PNV_PHB4(opaque);
@@ -602,8 +606,41 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr =
off, uint64_t val,
         return;
     }
=20
-    /* Handle masking */
+    /* Handle RO, W1C, WxC and masking */
     switch (off) {
+    /* W1C: Write-1-to-Clear registers */
+    case PHB_TXE_ERR_STATUS:
+    case PHB_RXE_ARB_ERR_STATUS:
+    case PHB_RXE_MRG_ERR_STATUS:
+    case PHB_RXE_TCE_ERR_STATUS:
+    case PHB_ERR_STATUS:
+    case PHB_REGB_ERR_STATUS:
+    case PHB_PCIE_DLP_ERRLOG1:
+    case PHB_PCIE_DLP_ERRLOG2:
+    case PHB_PCIE_DLP_ERR_STATUS:
+    case PHB_PBL_ERR_STATUS:
+        phb-&gt;regs[off &gt;&gt; 3] &amp;=3D ~val;
+        return;
+
+    /* WxC: Clear register on any write */
+    case PHB_PBL_ERR1_STATUS:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR_LOG_1:
+    case PHB_REGB_ERR1_STATUS:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR_LOG_1:
+    case PHB_TXE_ERR1_STATUS:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR_LOG_1:
+    case PHB_RXE_ARB_ERR1_STATUS:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR_LOG_1:
+    case PHB_RXE_MRG_ERR1_STATUS:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR_LOG_1:
+    case PHB_RXE_TCE_ERR1_STATUS:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR_LOG_1:
+    case PHB_ERR1_STATUS:
+    case PHB_ERR_LOG_0 ... PHB_ERR_LOG_1:
+        phb-&gt;regs[off &gt;&gt; 3] =3D 0;
+        return;
+
+    /* Write value updated by masks */
     case PHB_LSI_SOURCE_ID:
         val &amp;=3D PHB_LSI_SRC_ID;
         break;
@@ -642,7 +679,6 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr o=
ff, uint64_t val,
     case PHB_LEM_WOF:
         val =3D 0;
         break;
-    /* TODO: More regs ..., maybe create a table with masks... */
=20
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
@@ -651,6 +687,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr =
off, uint64_t val,
     case PHB_PHB4_TCE_CAP:
     case PHB_PHB4_IRQ_CAP:
     case PHB_PHB4_EEH_CAP:
+    case PHB_VERSION:
+    case PHB_DMA_CHAN_STATUS:
+    case PHB_TCE_TAG_STATUS:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PCIE_BNR:
         return;
     }
=20
@@ -673,6 +714,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr o=
ff, uint64_t val,
             pnv_phb4_update_all_msi_regions(phb);
         }
         break;
+
     case PHB_M32_START_ADDR:
     case PHB_M64_UPPER_BITS:
         if (changed) {
@@ -720,32 +762,69 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr=
 off, uint64_t val,
         break;
=20
     /* Silent simple writes */
-    case PHB_ASN_CMPM:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
-    case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
+
+    /* PHB Fundamental register set A */
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_RTT_BAR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_PELTV_BAR:
+    case PHB_PEST_BAR:
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_CAPI_CMPM ... PHB_M64_AOMASK:
+    case PHB_NXLATE_PREFIX ... PHB_DMA_SYNC:
+    case PHB_TCE_KILL ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_PAPR_ERR_INJ_MASK:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_DMA_SYNC:
-       break;
+    /* Fundamental register set B */
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    /* FIR &amp; Error registers */
+    case PHB_LEM_FIR_ACCUM:
+    case PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_INJECT ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_STATUS_MASK ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_INJECT ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_STATUS_MASK ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_INJECT ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_STATUS_MASK ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_INJECT ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_STATUS_MASK ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_INJECT ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_STATUS_MASK ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor &amp; Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_STATUS_MASK ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_SCR:
+    case PHB_PCIE_DLP_STR ... PHB_PCIE_HOTPLUG_STATUS:
+    case PHB_PCIE_LMR ... PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP:
+    /* Error registers */
+    case PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_STATUS_MASK ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
=20
     /* Noise on anything else */
     default:
-        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=3D%"PRIx64=
"\n",
+        qemu_log_mask(LOG_UNIMP,
+                      "phb4: unimplemented reg_write 0x%"PRIx64"=3D%"PRI=
x64"\n<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:,off,val);}}-stat=
icuint64_tpnv_phb4_reg_read(void*opaque,hwaddroff,unsignedsize)+uint64_tp=
nv_phb4_reg_read(void*opaque,hwaddroff,unsignedsize){PnvPHB4*phb=3DPNV_PH=
B4(opaque);uint64_tval;@@-828,36+907,74@@staticuint64_tpnv_phb4_reg_read(=
void*opaque,hwaddroff,unsignedsize)returnval;/*Silentsimplereads*/+/*PHBF=
undamentalregistersetA*/casePHB_LSI_SOURCE_ID:+casePHB_DMA_CHAN_STATUS:ca=
sePHB_CPU_LOADSTORE_STATUS:-casePHB_ASN_CMPM:+casePHB_CONFIG_DATA...PHB_L=
OCK1:casePHB_PHB4_CONFIG:+casePHB_RTT_BAR:+casePHB_PELTV_BAR:casePHB_M32_=
START_ADDR:-casePHB_CONFIG_ADDRESS:-casePHB_IODA_ADDR:-casePHB_RTC_INVALI=
DATE:-casePHB_TCE_KILL:-casePHB_TCE_SPEC_CTL:casePHB_PEST_BAR:-casePHB_PE=
LTV_BAR:-casePHB_RTT_BAR:+casePHB_CRW_BAR...PHB_ASN_CMPM:+casePHB_CAPI_CM=
PM:+casePHB_M64_AOMASK:casePHB_M64_UPPER_BITS:-casePHB_CTRLR:-casePHB_LEM=
_FIR_ACCUM:-casePHB_LEM_ERROR_MASK:-casePHB_LEM_ACTION0:-casePHB_LEM_ACTI=
ON1:-casePHB_TCE_TAG_ENABLE:+casePHB_NXLATE_PREFIX:+casePHB_RTC_INVALIDAT=
E...PHB_IODA_ADDR:+casePHB_PAPR_ERR_INJ_CTL...PHB_ETU_ERR_SUMMARY:casePHB=
_INT_NOTIFY_ADDR:casePHB_INT_NOTIFY_INDEX:-casePHB_Q_DMA_R:-casePHB_ETU_E=
RR_SUMMARY:-break;--/*Noiseonanythingelse*/+/*FundamentalregistersetB*/+c=
asePHB_CTRLR:+casePHB_AIB_FENCE_CTRL...PHB_Q_DMA_R:+casePHB_TCE_TAG_STATU=
S:+/*FIR&amp;Errorregisters*/+casePHB_LEM_FIR_ACCUM...PHB_LEM_ERROR_MASK:=
+casePHB_LEM_ACTION0...PHB_LEM_WOF:+casePHB_ERR_STATUS...PHB_ERR_AIB_FENC=
E_ENABLE:+casePHB_ERR_LOG_0...PHB_ERR1_STATUS_MASK:+casePHB_TXE_ERR_STATU=
S...PHB_TXE_ERR_AIB_FENCE_ENABLE:+casePHB_TXE_ERR_LOG_0...PHB_TXE_ERR1_ST=
ATUS_MASK:+casePHB_RXE_ARB_ERR_STATUS...PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:=
+casePHB_RXE_ARB_ERR_LOG_0...PHB_RXE_ARB_ERR1_STATUS_MASK:+casePHB_RXE_MR=
G_ERR_STATUS...PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:+casePHB_RXE_MRG_ERR_LOG_=
0...PHB_RXE_MRG_ERR1_STATUS_MASK:+casePHB_RXE_TCE_ERR_STATUS...PHB_RXE_TC=
E_ERR_AIB_FENCE_ENABLE:+casePHB_RXE_TCE_ERR_LOG_0...PHB_RXE_TCE_ERR1_STAT=
US_MASK:+/*Performancemonitor&amp;Debugregisters*/+casePHB_TRACE_CONTROL.=
=2E.PHB_PERFMON_CTR1:+/*REGBRegisters*/+/*PBLcore*/+casePHB_PBL_CONTROL:+=
casePHB_PBL_TIMEOUT_CTRL:+casePHB_PBL_NPTAG_ENABLE:+casePHB_PBL_SYS_LINK_=
INIT:+casePHB_PBL_BUF_STATUS:+casePHB_PBL_ERR_STATUS...PHB_PBL_ERR_INJECT=
:+casePHB_PBL_ERR_INF_ENABLE...PHB_PBL_ERR_FAT_ENABLE:+casePHB_PBL_ERR_LO=
G_0...PHB_PBL_ERR1_STATUS_MASK:+/*PCI-Estack*/+casePHB_PCIE_BNR...PHB_PCI=
E_DLP_STR:+casePHB_PCIE_DLP_LSR:+casePHB_PCIE_DLP_LANEZEROCTL...PHB_PCIE_=
DLP_CTL:+casePHB_PCIE_DLP_TRCRDDATA:+casePHB_PCIE_DLP_ERRLOG1...PHB_PCIE_=
DLP_ERR_COUNTERS:+casePHB_PCIE_DLP_EIC...PHB_PCIE_LANE_EQ_CNTL23:+casePHB=
_PCIE_TRACE_CTRL:+casePHB_PCIE_MISC_STRAP:+/*Errorregisters*/+casePHB_REG=
B_ERR_STATUS...PHB_REGB_ERR_INJECT:+casePHB_REGB_ERR_INF_ENABLE...PHB_REG=
B_ERR_FAT_ENABLE:+casePHB_REGB_ERR_LOG_0...PHB_REGB_ERR1_STATUS_MASK:+bre=
ak;++/*Noiseonunimplementedread,returnall1's*/default:-qemu_log_mask(LOG_=
UNIMP,">",
                       off, val);
     }
 }
=20
-static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned siz=
e)
+uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb =3D PNV_PHB4(opaque);
     uint64_t val;
@@ -828,36 +907,74 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwa=
ddr off, unsigned size)
         return val;
=20
     /* Silent simple reads */
+    /* PHB Fundamental register set A */
     case PHB_LSI_SOURCE_ID:
+    case PHB_DMA_CHAN_STATUS:
     case PHB_CPU_LOADSTORE_STATUS:
-    case PHB_ASN_CMPM:
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_PHB4_CONFIG:
+    case PHB_RTT_BAR:
+    case PHB_PELTV_BAR:
     case PHB_M32_START_ADDR:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_RTC_INVALIDATE:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
     case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
-    case PHB_RTT_BAR:
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_CAPI_CMPM:
+    case PHB_M64_AOMASK:
     case PHB_M64_UPPER_BITS:
-    case PHB_CTRLR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_NXLATE_PREFIX:
+    case PHB_RTC_INVALIDATE ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_ETU_ERR_SUMMARY:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_Q_DMA_R:
-    case PHB_ETU_ERR_SUMMARY:
-        break;
-
-    /* Noise on anything else */
+    /* Fundamental register set B */
+    case PHB_CTRLR:
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    case PHB_TCE_TAG_STATUS:
+    /* FIR &amp; Error registers */
+    case PHB_LEM_FIR_ACCUM ... PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_STATUS ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_LOG_0 ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_STATUS ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_STATUS ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_STATUS ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_STATUS ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor &amp; Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PBL_ERR_STATUS ... PHB_PBL_ERR_INJECT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_BNR ... PHB_PCIE_DLP_STR:
+    case PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_CTL:
+    case PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERRLOG1 ... PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP:
+    /* Error registers */
+    case PHB_REGB_ERR_STATUS ... PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
+
+    /* Noise on unimplemented read, return all 1's */
     default:
-        qemu_log_mask(LOG_UNIMP, "</a>phb4: reg_read 0x%"PRIx64"=3D%"PRI=
x64"\n",
-                      off, val);
+        qemu_log_mask(LOG_UNIMP, "phb4: unimplemented reg_read 0x%"PRIx6=
4"\n",
+                      off);
+        val =3D ~0ull;
     }
     return val;
 }
@@ -1799,7 +1916,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *p=
hb)
     pci-&gt;bus-&gt;flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
 }
=20
-static void pnv_phb4_realize(DeviceState *dev, Error **errp)
+void pnv_phb4_realize(DeviceState *dev, Error **errp)
 {
     PnvPHB4 *phb =3D PNV_PHB4(dev);
     XiveSource *xsrc =3D &amp;phb-&gt;xsrc;
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index 4906a82c6f..b09351f69f 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -103,10 +103,117 @@ static void pnv_phb5_reset(Object *obj, ResetType =
type)
     pnv_phb5_pbl_core_reset(phb);
 }
=20
+static uint64_t pnv_phb5_reg_read(void *opaque, hwaddr off, unsigned siz=
e)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+
+    uint64_t val =3D ~0ull;
+
+    switch (off) {
+    /* Registers removed in PHB5 from PHB4, return all 1's on read */
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
+    case P16_ECAP ... P16_SRDPM:
+    case PHB_PBL_NBW_CMP_MASK:
+        qemu_log_mask(LOG_GUEST_ERROR, "phb5: read from reserved offset =
0x%"
+                      PRIx64"\n", off);
+        return ~0ULL;
+
+    /* New registers in PHB5 from PHB4 */
+    case P16_LDPM_PHB5 ... P16_SRDPM_PHB5:
+    case P32_ECAP ... P32_STAT:
+    case PHB_PCIE_DLP_LANE_PWR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LZC:
+    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
+    case PHB_PCIE_PHY_EQ_CTL:
+    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_1=
2_15:
+        val =3D phb-&gt;regs[off &gt;&gt; 3];
+        break;
+
+    default:
+        val =3D pnv_phb4_reg_read(opaque, off, size);
+    }
+
+    return val;
+}
+
+static void pnv_phb5_reg_write(void *opaque, hwaddr off, uint64_t val,
+                               unsigned size)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+
+    switch (off) {
+    /* Registers removed in PHB5 from PHB4 */
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
+    case P16_ECAP ... P16_SRDPM:
+    case PHB_PBL_NBW_CMP_MASK:
+        qemu_log_mask(LOG_GUEST_ERROR, "phb5: write to reserved offset 0=
x%"
+                      PRIx64"\n", off);
+        return;
+
+    /* New registers in PHB5 from PHB4 */
+
+    /* W1C: Write-1-to-Clear registers */
+    case P16_STAT_PHB5 ... P16_SRDPM_PHB5:
+        phb-&gt;regs[off &gt;&gt; 3] &amp;=3D ~val;
+        break;
+
+    /* Read only registers */
+    case P16_ECAP_PHB5:
+    case P32_ECAP:
+    case P32_STAT:
+    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_1=
2_15:
+        return;
+
+    /* Simple write */
+    case P32_CTL:
+    case PHB_PCIE_DLP_LANE_PWR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LZC:
+    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
+    case PHB_PCIE_PHY_EQ_CTL:
+        phb-&gt;regs[off &gt;&gt; 3] =3D val;
+        break;
+
+    default:
+        pnv_phb4_reg_write(opaque, off, val, size);
+    }
+}
+
+static const MemoryRegionOps pnv_phb5_reg_ops =3D {
+    .read =3D pnv_phb5_reg_read,
+    .write =3D pnv_phb5_reg_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_phb5_realize(DeviceState *dev, Error **errp)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(dev);
+    char name[32];
+
+    pnv_phb4_realize(dev, errp);
+
+    /* Controller Registers */
+    snprintf(name, sizeof(name), "phb5-%d.%d-regs", phb-&gt;chip_id,
+             phb-&gt;phb_id);
+    memory_region_init_io(&amp;phb-&gt;mr_regs, OBJECT(phb), &amp;pnv_ph=
b5_reg_ops, phb,
+                          name, 0x2000);
+}
+
 static void pnv_phb5_class_init(ObjectClass *klass, const void *data)
 {
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
     ResettableClass *rc =3D RESETTABLE_CLASS(klass);
=20
+    dc-&gt;realize         =3D pnv_phb5_realize;
+    dc-&gt;user_creatable  =3D false;
+
     rc-&gt;phases.enter =3D pnv_phb5_reset;
 }
=20
@@ -114,7 +221,8 @@ static const TypeInfo pnv_phb5_type_info =3D {
     .name          =3D TYPE_PNV_PHB5,
     .parent        =3D TYPE_PNV_PHB4,
     .instance_size =3D sizeof(PnvPHB4),
-    .class_init    =3D pnv_phb5_class_init
+    .class_init    =3D pnv_phb5_class_init,
+    .class_size    =3D sizeof(PnvPHB4Class)
 };
=20
 static void pnv_phb5_register_types(void)
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb=
4.h
index 567a3e6e95..33e11a3fe8 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -173,6 +173,9 @@ PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPH=
B *phb, Error **errp);
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
 void pnv_phb4_cfg_core_reset(PCIDevice *d);
 extern const MemoryRegionOps pnv_phb4_xscom_ops;
+uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size);
+void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned=
 size);
+void pnv_phb4_realize(DeviceState *dev, Error **errp);
=20
 /*
  * PHB4 PEC (PCI Express Controller)
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pn=
v_phb4_regs.h
index d0962c1607..9ad6713d37 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -173,6 +173,7 @@
 #define PHB_PEST_BAR                    0x1a8
 #define   PHB_PEST_BAR_ENABLE           PPC_BIT(0)
 #define   PHB_PEST_BASE_ADDRESS         PPC_BITMASK(8, 51)
+#define PHB_CRW_BAR                     0x1B0
 #define PHB_ASN_CMPM                    0x1C0
 #define   PHB_ASN_CMPM_ENABLE           PPC_BIT(63)
 #define PHB_CAPI_CMPM                   0x1C8
@@ -357,6 +358,11 @@
 #define PHB_AER_RERR                            0x130
 #define PHB_AER_ESID                            0x134
 #define PHB_SEC_ECAP                            0x148
+#define P16_ECAP                                0x174
+#define P16_STAT                                0x180
+#define P16_LDPM                                0x184
+#define P16_FRDPM                               0x188
+#define P16_SRDPM                               0x18C
 #define PHB_LMR_ECAP                            0x1A0
 #define PHB_LMR_CTLSTA_2                        0x1AC
 #define PHB_LMR_CTLSTA_16                       0x1E4
@@ -398,6 +404,7 @@
 #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
 #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
+#define PHB_PCIE_DLP_STR                0x1A18
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
 #define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
 #define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
@@ -427,18 +434,20 @@
 #define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
 #define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
 #define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
-
+#define PHB_PCIE_DLP_LSR                0x1A48
+#define PHB_PCIE_DLP_LANEZEROCTL        0x1A70
 #define PHB_PCIE_DLP_CTL                0x1A78
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
-
 #define PHB_PCIE_DLP_TRWCTL             0x1A80
 #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
 #define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
+#define PHB_PCIE_DLP_TRCRDDATA          0x1A88
 #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
 #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
 #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
 #define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
+#define PHB_PCIE_DLP_EIC                0x1AC8
=20
 #define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
 #define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
@@ -581,5 +590,4 @@
=20
 #define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
=20
-
 #endif /* PCI_HOST_PNV_PHB4_REGS_H */
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb=
5.h
index d76846068a..4534083fd5 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -33,17 +33,22 @@ void pnv_phb5_cfg_core_reset(PCIDevice *d);
     OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
=20
 /* New registers in PHB5 from PHB4 */
-#define P16_ECAP                                0x1F4
-#define P16_STAT                                0x200
-#define P16_LDPM                                0x204
-#define P16_FRDPM                               0x208
-#define P16_SRDPM                               0x20C
+#define P16_ECAP_PHB5                           0x1F4
+#define P16_STAT_PHB5                           0x200
+#define P16_LDPM_PHB5                           0x204
+#define P16_FRDPM_PHB5                          0x208
+#define P16_SRDPM_PHB5                          0x20C
 #define P32_ECAP                                0x224
 #define P32_CAP                                 0x228
 #define P32_CTL                                 0x22C
 #define P32_STAT                                0x230
+#define PHB_PCIE_DLP_LANE_PWR                   0x1A38
+#define PHB_PCIE_DLP_RXMGN                      0x1A50
+#define PHB_PCIE_DLP_LZC                        0x1A70
+#define PHB_PCIE_DLP_LEC0                       0x1B00
+#define PHB_PCIE_DLP_LEC1                       0x1B08
+#define PHB_PCIE_PHY_EQ_CTL                     0x1B38
 #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03         0x1B40
 #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15         0x1B98
=20
-
 #endif /* PCI_HOST_PNV_PHB5_H */
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
index 23238f1582..0c0f7fafac 100644
--- a/tests/qtest/pnv-phb-test.c
+++ b/tests/qtest/pnv-phb-test.c
@@ -88,11 +88,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
     g_assert_cmpuint(val, =3D=3D, (PPC_BITMASK(24, 27) | PPC_BITMASK(36,=
 37) |
                      PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
                      PPC_BITMASK(52, 54)));
-
 }
=20
 /* Check that write-only bits/regs return 0 when read */
-static void phb4_writeonly_read_test(QTestState *qts)
+static void phb5_writeonly_read_test(QTestState *qts)
 {
     uint64_t val;
=20
@@ -143,6 +142,12 @@ static void phb4_writeonly_read_test(QTestState *qts=
)
     g_assert_cmpuint(val, =3D=3D, 0x0);
 }
=20
+/* Check that reading an unimplemented address 0x0 returns -1 */
+static void phb5_unimplemented_read_test(QTestState *qts)
+{
+    g_assert_cmpint(PHB5_XSCOM_READ(0x0), =3D=3D, -1);
+}
+
 static void phb5_tests(void)
 {
     QTestState *qts =3D NULL;
@@ -156,7 +161,10 @@ static void phb5_tests(void)
     phb5_sticky_rst_test(qts);
=20
     /* Check write-only logic */
-    phb4_writeonly_read_test(qts);
+    phb5_writeonly_read_test(qts);
+
+    /* Check unimplemented register read */
+    phb5_unimplemented_read_test(qts);
=20
     qtest_quit(qts);
 }
</pre>
    </blockquote>
  </body>
</html>

--------------z5ByZX0whrwMRzsk5Se2suYM--



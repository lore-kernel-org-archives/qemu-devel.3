Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4602CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjgc-0002D0-5T; Wed, 17 Jun 2026 02:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjeK-0001k6-9a; Wed, 17 Jun 2026 02:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjeF-0003Yp-Li; Wed, 17 Jun 2026 02:21:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmTRE2746459; Wed, 17 Jun 2026 06:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LVT9sB
 QJrckXleoMYWIgQucjYo5iBNy9IdcwAFP63yY=; b=oYkIpIdfoHiWh7JQVFwdk/
 3weGYo+1JY3e1VFWNEAgj9D0snqafE9ZOiFrRDN1vOsR89fByvoiiqkV0uEW7wwt
 HMOGVR6QhGU6XoeAunt/RmIujzZb5AgDv8ISjefLSWdzxoxFhQRk7TlqdxV96Loo
 q5E36Fsq7maLilRyekPi4chnNkH1JUg2WmmSIBRwSI8Qz8mj8dUCRTfb3Mhs+U0F
 woDe0w9BJ+z9BTqEkukf8eezylNwXxxVSEOOSkfyKvBEiouiBRYQD4VcUeKTcGMP
 30kGU8ORTiPDHmavWBUy3zPKspIiIObZdNfP1dZyHwdX97P5a6En+zIvu4wDtsqQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqthgx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:21:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JajK016935;
 Wed, 17 Jun 2026 06:21:04 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva9tvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:21:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6L3W715794868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:21:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23EF958056;
 Wed, 17 Jun 2026 06:21:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF9705803F;
 Wed, 17 Jun 2026 06:20:58 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:20:58 +0000 (GMT)
Message-ID: <151df988-0aa5-4185-a0e2-4c072e5aa788@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:50:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pnv/phb4: Implement sticky reset logic in PHB4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
 <28b35521-245f-48b8-a97e-f77f08afecc5@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <28b35521-245f-48b8-a97e-f77f08afecc5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: K_Sw-6sCV04l7zmSNo32LpBhRIqey2w4
X-Proofpoint-GUID: ydpcjuTx77B45eI600gLQR-yCEbsxHGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX8Eq6AH9+Gem6
 y04/gHBGYdNKdsxT58bMgJcxFVMKGPWNcFUO3DXhe9ikzQI+1kaHPaXGVcPblrvdNDny6mrslUP
 3nWPazL/o/OuRb+NAS5s8Js7T03zenyT56Zen8dAc+JZYhkkhbpwdUs0NvEOzz2k3M5s1j/nKJM
 74sD5ocCXGhiEJoopoZnehlJ+/jSrU+bT9U7EYg7knRV5Si91TuoTk9cMguIjRkqh+vojCwgnsV
 zMQB7sMHmJOwltm/0z+EENY8KW7bnrkXZSU2hTtC4Qh0YfaimU7D9PLjHbZQucGRYt0DCiavNkT
 B3qGWUp2URTY89cxvVe0SmaLax+zx9WpPBHEw2hS1ksuZ+X/WgrpDJQTyS0HzML4aHhld4ogRgd
 XgeHeHocNB75mXIihAB5/0EzBnJ8u3Jp03hPSttTu6pEYMMbBa5OFsyT/TmpimiEj2B7xobEHMI
 if6Ri3+6euRtZAr10eA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX67DyNdcSnHQG
 oe+Ee1nT52t3CD+gNA/e1lZDuBR9phV2Rp3gz3leVpyo7pGsg0q4H8O9bE2BlsYma6wnLFY+7cT
 WBbAy4L9vj88PP2fQFZxVeGy88Gw4Rg=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a323cd1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=LwUBIle-WrN_-M1R1iEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170057
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:23:38 -0400
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


On 05-05-2026 19:59, Harsh Prateek Bora wrote:
>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> Sticky bits retain their values on reset and are not overwritten with
>> the reset value.
>> Added sticky reset logic for all required registers,
>> i.e. CFG core, PBL core, PHB error registers, PCIE stack registers and
>> REGB error registers.
>>
>> Tested by writing all 1's to the reg PHB_PBL_ERR_INJECT.
>> This will set the bits in the reg PHB_PBL_ERR_STATUS.
>> Reset the PBL core by setting PHB_PCIE_CRESET_PBL in reg 
>> PHB_PCIE_CRESET.
>> Verify that the sticky bits in the PHB_PBL_ERR_STATUS reg are still set.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> ---
>> v3: Updates for coding guidelines.
>>
>>   hw/pci-host/pnv_phb4.c              | 123 +++++++++++++++++++++++++++-
>>   include/hw/pci-host/pnv_phb4_regs.h |  20 ++++-
>>   tests/qtest/pnv-phb4-test.c         |  41 ++++++++++
>>   3 files changed, 179 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 763e9c9776..b3f46f7fe1 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -511,6 +511,18 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>>       return rpc->exp_offset;
>>   }
>>   +/*
>> + * Apply sticky-mask 's' to the reset-value 'v' and write to the 
>> address 'a'.
>> + * RC-config space values and masks are LE.
>> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
>> + * Compute new value in LE domain.
>> + * New value computation using sticky-mask is in LE.
>> + * Convert the computed value from LE to BE before writing back.
>> + */
>> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
>> +    (pci_set_word(conf + (a), bswap32( \
>> +                     (bswap32(pci_get_word(conf + (a))) & (s)) | 
>> ((v) & ~(s)))))
>
> Shouldn't we be using bswap16 here ?


Corrected.


>
>> +
>>   void pnv_phb4_cfg_core_reset(PCIDevice *d)
>>   {
>>       uint8_t *conf = d->config;
>> @@ -560,14 +572,56 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
>>       pci_set_long(conf + P16_ECAP, 0x22410026);
>>       pci_set_long(conf + P32_ECAP, 0x1002A);
>>       pci_set_long(conf + P32_CAP,  0x103);
>> +
>> +    /* Sticky reset */
>> +    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,
>> + PCI_EXP_LNKCTL2_TLS_32_0GT, 0xFEFFBF);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_UERR,      0,    0x1FF030);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_UERR_MASK, 0,    0x1FF030);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_CERR,      0,    0x11C1);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_ECAP + PCI_ERR_CAP, 
>> (PCI_ERR_CAP_ECRC_CHKC
>> +                                               | 
>> PCI_ERR_CAP_ECRC_GENC), 0x15F);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_1,    0, 0xFFFFFFFF);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_2,    0, 0xFFFFFFFF);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_3,    0, 0xFFFFFFFF);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_4,    0, 0xFFFFFFFF);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
>> +    RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0, 0xFFFFFFFF);
>> +    RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0, 0x807FFFFF);
>> +    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
>> +    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
>> +    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
>> +    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
>> +    RC_CONFIG_STICKY_RESET(P32_CTL,           0,    0x3);
>>   }
>>   +/* Apply sticky-mask to the reset-value and write to the 
>> reg-address */
>> +#define STICKY_RST(addr, rst_val, sticky_mask) (phb->regs[addr >> 3] 
>> = \
>> +            ((phb->regs[addr >> 3] & sticky_mask) | (rst_val & 
>> ~sticky_mask)))
>> +
>>   static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
>>   {
>> -    /* Zero all registers initially */
>> +    /*
>> +     * Zero all registers initially,
>> +     * with sticky reset of certain registers.
>> +     */
>>       for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; 
>> i += 8) {
>> -        phb->regs[i >> 3] = 0x0;
>> +        switch (i) {
>> +        case PHB_PBL_ERR_STATUS:
>> +            break;
>> +        case PHB_PBL_ERR1_STATUS:
>> +        case PHB_PBL_ERR_LOG_0:
>> +        case PHB_PBL_ERR_LOG_1:
>> +        case PHB_PBL_ERR_STATUS_MASK:
>> +        case PHB_PBL_ERR1_STATUS_MASK:
>> +            STICKY_RST(i, 0, PPC_BITMASK(0, 63));
>> +            break;
>> +        default:
>> +            phb->regs[i >> 3] = 0x0;
>> +        }
>>       }
>> +    STICKY_RST(PHB_PBL_ERR_STATUS, 0, \
>> +            (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
>>         /* Set specific register values */
>>       phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
>> @@ -701,6 +755,17 @@ static void pnv_phb4_reg_write(void *opaque, 
>> hwaddr off, uint64_t val,
>>           }
>>           break;
>>   +    /*
>> +     * Writing bits to a 1 in this register will inject the error 
>> corresponding
>> +     * to the bit that is written. The bits will automatically clear 
>> to 0 after
>> +     * the error is injected. The corresponding bit in the Error 
>> Status Reg
>> +     * should also be set automatically when the error occurs.
>> +     */
>> +    case PHB_PBL_ERR_INJECT:
>> +        phb->regs[PHB_PBL_ERR_STATUS >> 3] = phb->regs[off >> 3];
>> +        phb->regs[off >> 3] = 0;
>> +        break;
>> +
>>       /* Silent simple writes */
>>       case PHB_ASN_CMPM:
>>       case PHB_CONFIG_ADDRESS:
>> @@ -1621,11 +1686,65 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
>>       .get_address_space = pnv_phb4_dma_iommu,
>>   };
>>   +static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>> +{
>> +    STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
>> +    STICKY_RST(PHB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +
>> +    STICKY_RST(PHB_TXE_ERR_STATUS,       0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_TXE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_TXE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_TXE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +
>> +    STICKY_RST(PHB_RXE_ARB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_ARB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_ARB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_ARB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +
>> +    STICKY_RST(PHB_RXE_MRG_ERR_STATUS,       0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_MRG_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +
>> +    STICKY_RST(PHB_RXE_TCE_ERR_STATUS,       0, PPC_BITMASK(0, 35));
>> +    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_TCE_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_TCE_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_TCE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +}
>> +
>> +static void pnv_phb4_pcie_stack_reg_reset(PnvPHB4 *phb)
>> +{
>> +    STICKY_RST(PHB_PCIE_CRESET, 0xE000000000000000, \
>> +                        (PHB_PCIE_CRESET_PERST_N | 
>> PHB_PCIE_CRESET_REFCLK_N));
>> +    STICKY_RST(PHB_PCIE_DLP_ERRLOG1,             0, PPC_BITMASK(0, 
>> 63));
>> +    STICKY_RST(PHB_PCIE_DLP_ERRLOG2,             0, PPC_BITMASK(0, 
>> 31));
>> +    STICKY_RST(PHB_PCIE_DLP_ERR_STATUS,          0, PPC_BITMASK(0, 
>> 15));
>> +}
>> +
>> +static void pnv_phb4_regb_err_reg_reset(PnvPHB4 *phb)
>> +{
>> +    STICKY_RST(PHB_REGB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_REGB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_REGB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_REGB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_REGB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
>> +    STICKY_RST(PHB_REGB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
>> +}
>> +
>>   static void pnv_phb4_reset(Object *obj, ResetType type)
>>   {
>>       PnvPHB4 *phb = PNV_PHB4(obj);
>>         pnv_phb4_pbl_core_reset(phb);
>> +    pnv_phb4_err_reg_reset(phb);
>> +    pnv_phb4_pcie_stack_reg_reset(phb);
>> +    pnv_phb4_regb_err_reg_reset(phb);
>>   }
>>     static void pnv_phb4_instance_init(Object *obj)
>> diff --git a/include/hw/pci-host/pnv_phb4_regs.h 
>> b/include/hw/pci-host/pnv_phb4_regs.h
>> index 6892e21cc9..df5e86d29a 100644
>> --- a/include/hw/pci-host/pnv_phb4_regs.h
>> +++ b/include/hw/pci-host/pnv_phb4_regs.h
>> @@ -344,17 +344,32 @@
>>   #define   PHB_RC_CONFIG_SIZE                    0x800
>>     #define PHB_AER_ECAP                            0x100
>> +#define PHB_AER_UERR                            0x104
>> +#define PHB_AER_UERR_MASK                       0x108
>> +#define PHB_AER_CERR                            0x110
>>   #define PHB_AER_CAPCTRL                         0x118
>> +#define PHB_AER_HLOG_1                          0x11C
>> +#define PHB_AER_HLOG_2                          0x120
>> +#define PHB_AER_HLOG_3                          0x124
>> +#define PHB_AER_HLOG_4                          0x128
>> +#define PHB_AER_RERR                            0x130
>> +#define PHB_AER_ESID                            0x134
>>   #define PHB_SEC_ECAP                            0x148
>>   #define PHB_LMR_ECAP                            0x1A0
>>   #define PHB_LMR_CTLSTA_2                        0x1AC
>>   #define PHB_LMR_CTLSTA_16                       0x1E4
>>   #define PHB_DLF_ECAP                            0x1E8
>>   #define PHB_DLF_CAP                             0x1EC
>> +#define PHB_DLF_STAT                            0x1F0
>>   #define P16_ECAP                                0x1F4
>> +#define P16_STAT                                0x200
>> +#define P16_LDPM                                0x204
>> +#define P16_FRDPM                               0x208
>> +#define P16_SRDPM                               0x20C
>>   #define P32_ECAP                                0x224
>>   #define P32_CAP                                 0x228
>> -
>> +#define P32_CTL                                 0x22C
>> +#define P32_STAT                                0x230
>>   /* PHB4 REGB registers */
>>     /* PBL core */
>> @@ -388,8 +403,7 @@
>>   #define   PHB_PCIE_CRESET_PBL           PPC_BIT(2)
>>   #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
>>   #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
>> -
>> -
>> +#define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
>>   #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
>>   #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
>>   diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
>> index 8cd6c1bc59..419f34987a 100644
>> --- a/tests/qtest/pnv-phb4-test.c
>> +++ b/tests/qtest/pnv-phb4-test.c
>> @@ -22,6 +22,19 @@
>>   #define PNV_P10_CHIP_INDEX      3
>>   #define PHB4_XSCOM              0x40084800ull
>>   +/*
>> + * Indirect XSCOM write:
>> + * - Write 'Indirect Address Register' with register-offset to write.
>> + * - Write 'Indirect Data Register' with the value.
>> + */
>> +static void pnv_phb_xscom_write(QTestState *qts, const PnvChip *chip,
>> +        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
>> +        uint64_t reg, uint64_t val)
>> +{
>> +    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + 
>> indirect_addr), reg);
>> +    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + 
>> indirect_data), val);
>> +}
>> +
>>   /*
>>    * Indirect XSCOM read::
>>    * - Write 'Indirect Address Register' with register-offset to read.
>> @@ -35,6 +48,11 @@ static uint64_t pnv_phb_xscom_read(QTestState 
>> *qts, const PnvChip *chip,
>>       return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + 
>> indirect_data));
>>   }
>>   +#define PHB4_XSCOM_WRITE(a, v) pnv_phb_xscom_write(qts, \
>> + &pnv_chips[PNV_P10_CHIP_INDEX], PHB4_XSCOM, \
>> +                                   PHB_SCOM_HV_IND_ADDR, 
>> PHB_SCOM_HV_IND_DATA, \
>> +                                   PPC_BIT(0) | (a), (v))
>> +
>>   #define PHB4_XSCOM_READ(a) pnv_phb_xscom_read(qts, \
>> &pnv_chips[PNV_P10_CHIP_INDEX], PHB4_XSCOM, \
>>                                      PHB_SCOM_HV_IND_ADDR, 
>> PHB_SCOM_HV_IND_DATA, \
>> @@ -46,6 +64,26 @@ static void phb4_reset_test(QTestState *qts)
>>       g_assert_cmpuint(PHB4_XSCOM_READ(PHB_PBL_CONTROL), ==, 
>> 0xC009000000000000);
>>   }
>>   +/* Check sticky-reset */
>> +static void phb4_sticky_rst_test(QTestState *qts)
>> +{
>> +    uint64_t val;
>> +
>> +    /*
>> +     * Sticky reset test of PHB_PBL_ERR_STATUS.
>> +     *
>> +     * Write all 1's to reg PHB_PBL_ERR_INJECT.
>> +     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
>> +     *
>> +     * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg 
>> PHB_PCIE_CRESET.
>> +     * Verify the sticky bits are still set.
>> +     */
>> +    PHB4_XSCOM_WRITE(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
>> +    PHB4_XSCOM_WRITE(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
>> +    val = PHB4_XSCOM_READ(PHB_PBL_ERR_STATUS);
>> +    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 
>> 63)));
>> +}
>> +
>>   static void phb4_tests(void)
>>   {
>>       QTestState *qts = NULL;
>> @@ -55,6 +93,9 @@ static void phb4_tests(void)
>>       /* Check reset value of a register */
>>       phb4_reset_test(qts);
>>   +    /* Check sticky reset of a register */
>> +    phb4_sticky_rst_test(qts);
>> +
>>       qtest_quit(qts);
>>   }
>

Thanks,

Saif




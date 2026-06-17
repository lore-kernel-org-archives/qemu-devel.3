Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4B6CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjmy-0007H3-8Z; Wed, 17 Jun 2026 02:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjmk-00072E-PT; Wed, 17 Jun 2026 02:30:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjmi-0005Wt-De; Wed, 17 Jun 2026 02:30:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmSeQ2746450; Wed, 17 Jun 2026 06:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zqbTjc
 upCpOrI97jJeV3FQMRNY/QgF7qRpxBYaa1jr0=; b=O/uBIOe7LZ1ytyzXn1TuTu
 ZCp5DEyGib51HQN4E4UtHbI+YrVctp0T3ZtZSbGY1E1SDrkrykdR9jMe8DjPueyA
 8J1mRvieEJN5K64DBdmbLhhCBzakmfBOcsp3vAEarZbLeiCpmMIs5OaYX71orkLk
 i9GOL6osxai1J2xP8mAOLM6EGoCYg1VeXjQMETweZV64h5w8hM/9v3SnxH8ph7ng
 IryW+6PghjBmKNy2ee4acMI4yRQtRDUFkp2N0Do4ZnVI8L6TljvsnrcAzRf3cgM2
 qvnSejSi7NUK33JzDRgwi9EUVAxC224kklz966y7vZllbFWcNj8O86ABIVQr6mzg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqthhp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:29:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JvQe029690;
 Wed, 17 Jun 2026 06:29:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva1upf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:29:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6TqNw34079478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:29:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFA3F58056;
 Wed, 17 Jun 2026 06:29:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D27985803F;
 Wed, 17 Jun 2026 06:29:48 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:29:48 +0000 (GMT)
Message-ID: <1ed35ef0-3df1-478b-a688-ed1e163c6f22@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:59:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] pnv/phb4: Set link-active status in HPSTAT and LMR
 registers
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
 <ccf998df-3d57-4d4f-8ff5-5ca2981d9939@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <ccf998df-3d57-4d4f-8ff5-5ca2981d9939@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CNRmO_dIyG1vbQef02J7GeVo86l15Wry
X-Proofpoint-GUID: zey1XV2x_Zz9BWXxK8FT1y5Tl4zAaf0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX7EmM1TtgQwVh
 NE3R7QCXUc576Ggx/1QdAN6Xyv3QD3ndGoDbLByZq6wnvTjxprQP2SdZMBSqy4VVTBgLxhS5lYF
 7cBmi72zvmWsPNKyhPn3HaSMnYw3tiYiog4omgTuURVMD2Mxz7x71PNTFJJWBoe6fbj2wrcT4Mo
 HpIpc59mb7Vt914/gDwsaCuwynVIuyaQem7i/GyhT9buTUKAyiBnP478APfVrWnGEfq++Fy48uq
 EMBjJk2k/HW0DJm1PY3AWEAzllZwJOuYRD8bwsp0nY+8F63NcTuvdxISsEw9og+m0jtgZR/KrVa
 rwcAMu5SBM4uWNq7qOyHw7E6GW6LwnFJOnxLFFgKTNJQJsbYZ3Sn1NXrlGVCOhlsm7M9H/vBsKq
 +ON556OjDeg8SIFcaBx+WSapRIsu34wC8PYQ3+h+oBH9yy34BCsOw0IGROE6MgocgmD1o2k/5tX
 mIProcBN5j3BUsnTX+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX+hMROxrKBgto
 hn/MNzjbMoN3VWIql44RFHxaucje8dEO59bLc5XoDLRL7C6MiJXnuIWlMgVu5JwkLddHqkLg+a5
 uLw2B1xymbDX+ui1md8/y6Qx1uIR+tI=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a323ee3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=7wBnWPr69wzpIwNrFDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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


On 05-05-2026 23:16, Harsh Prateek Bora wrote:
>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> Config-read the link-status register in the PCI-E macro,
>> Depending on the link-active bit, set the link-active status
>> in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
>> Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
>> after config-reading the slot-status in the PCI-E macro.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v4: Variables declaration moved to the top of the method 
>> pnv_phb4_reg_read().
>> v3: Updates for coding guidelines.
>>
>>   hw/pci-host/pnv_phb4.c | 59 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 25539b7c32..c35f632e64 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -511,6 +511,20 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>>       return rpc->exp_offset;
>>   }
>>   +/*
>> + * Config-read the link-status register in the PCI-E macro,
>> + * convert to LE and check the link-active bit.
>> + */
>> +static uint32_t is_link_active(PnvPHB4 *phb)
>> +{
>> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
>> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>> +    uint32_t exp_offset = get_exp_offset(pdev);
>> +
>> +    return (bswap32(pnv_phb4_rc_config_read(phb, exp_offset + 
>> PCI_EXP_LNKSTA, 4)
>> +                    ) & PCI_EXP_LNKSTA_DLLLA);
>
> Shouldn't we be reading only 16 bits for PCI_EXP_LNKSTA ?

Using be16_to_cpu() now.

>
>> +}
>> +
>>   /*
>>    * Apply sticky-mask 's' to the reset-value 'v' and write to the 
>> address 'a'.
>>    * RC-config space values and masks are LE.
>> @@ -729,6 +743,11 @@ static void pnv_phb4_reg_write(void *opaque, 
>> hwaddr off, uint64_t val,
>>           val = 0;
>>           break;
>>   +    case PHB_PCIE_HOTPLUG_STATUS:
>> +        /* For normal operations, Simspeed diagnostic bit is always 
>> zero */
>> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
>> +        break;
>> +
>>       /* Read only registers */
>>       case PHB_CPU_LOADSTORE_STATUS:
>>       case PHB_ETU_ERR_SUMMARY:
>> @@ -876,6 +895,10 @@ static void pnv_phb4_reg_write(void *opaque, 
>> hwaddr off, uint64_t val,
>>   static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, 
>> unsigned size)
>>   {
>>       PnvPHB4 *phb = PNV_PHB4(opaque);
>> +    /* Get the PCI-E capability offset from the root-port */
>> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
>> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>> +    uint32_t exp_base = get_exp_offset(pdev);
>>       uint64_t val;
>>         if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>> @@ -944,8 +967,37 @@ static uint64_t pnv_phb4_reg_read(void *opaque, 
>> hwaddr off, unsigned size)
>>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
>>           return val;
>>   +    /*
>> +     * Read PCI-E registers and set status for:
>> +     * - Card present (active low bit 10)
>> +     * - Link active  (bit 12)
>> +     */
>>       case PHB_PCIE_HOTPLUG_STATUS:
>> -        /* Clear write-only bit */
>> +        /*
>> +         * Presence-status bit hpi_present_n is active-low, with 
>> reset value 1.
>> +         * Start by setting this bit to 1, indicating the card is 
>> not present.
>> +         * Then check the PCI-E register and clear the bit if card 
>> is present.
>> +         */
>> +        val |= PHB_PCIE_HPSTAT_PRESENCE;
>> +
>> +        /*
>> +         * Config-read the PCI-E macro register for slot-status.
>> +         * Method for config-read converts to BE value.
>> +         * To check actual bit in the PCI-E register,
>> +         * convert the value back to LE using bswap32().
>> +         * Clear the Presence-status active low bit.
>> +         */
>> +        if (bswap32(pnv_phb4_rc_config_read(phb, exp_base + 
>> PCI_EXP_SLTSTA, 4))
>> +                    & PCI_EXP_SLTSTA_PDS) {
>> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
>> +        }
>> +
>> +        /* Check if link is active and set the bit */
>> +        if (is_link_active(phb)) {
>> +            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
>> +        }
>> +
>> +        /* Clear write-only resample-bit */
>>           val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
>>           return val;
>>   @@ -953,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void 
>> *opaque, hwaddr off, unsigned size)
>>       case PHB_PCIE_LMR:
>>           /* These write-only bits always read as 0 */
>>           val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
>> +
>> +        /* Check if link is active and set the bit */
>> +        if (is_link_active(phb)) {
>> +            val |= PHB_PCIE_LMR_LINKACTIVE;
>> +        }
>>           return val;
>>         /* Silent simple reads */
>
Thanks,

Saif




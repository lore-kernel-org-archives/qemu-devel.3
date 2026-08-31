Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509D6C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15N3-0001bG-5W; Mon, 31 Aug 2026 13:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15N1-0001au-7y; Mon, 31 Aug 2026 13:00:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15My-0008OY-Ss; Mon, 31 Aug 2026 13:00:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VG1ZSG871285; Mon, 31 Aug 2026 17:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=yb1OjW83yRtWKXEDeAc7fLC4uHoQcm
 17KyByDTBJP24=; b=poB/lRmkLeAOYDOa+p1KN6nA7BXwwc9MF2zrrKnLmMmDpc
 aNxGkxFhc0nF3vJxhJ+LOJ0TOAiBnScyQ5L64VMDB93E7NUMwGrg2vLIgLuJPfvI
 94NknKsMOsMOTKcDshxvPrRai+FWSMbUnQoKc8Mz0kJqipsNSZQDh/3P2YJXNxOi
 tgfTpiWDvBXRif1yt7s4X04WC7YRkRHEM9lpmM/eVJJDNR0FYmZqnyXzOz9PA3tn
 wnRbuwj5ZeOMWyaNXutVoT4v8mQjPkVKVF3kiRm2X3dthpkCRfUEvJgjJYDu5m9f
 j60ZTGh2CZFuAL4aKAFGy5bMgzDfsM9Ua8gtqoEw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r2pea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:00:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VGuI7c017957;
 Mon, 31 Aug 2026 17:00:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjy2ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 17:00:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VH0Eke24642250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 17:00:15 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D621658069;
 Mon, 31 Aug 2026 17:00:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 143F35806E;
 Mon, 31 Aug 2026 17:00:08 +0000 (GMT)
Received: from [9.43.79.120] (unknown [9.43.79.120])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 17:00:07 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------VzM0ZsxFdhIEkvN4RLTF0wbV"
Message-ID: <e292c2c1-6032-43ba-aebe-17537c5a5b52@linux.vnet.ibm.com>
Date: Mon, 31 Aug 2026 22:30:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] pnv/phb5: Add reset logic to PHB5
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-3-saif.abrar@linux.ibm.com>
 <alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95b321 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=fZnzPqFuvzv6SQjt6DUA:9
 a=QEXdDO2ut3YA:10 a=VnNF1IyMAAAA:8 a=YedxgJ_sP0URI6W74OkA:9
 a=Gsul2j4anvSwYPvX:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXylqVhFslwRFb
 sxMGOjuUZcmqesWieRq3KA7+CRv4UWtghsJC+oVzi8fKI7qmhHpRAyOeSl/3tkC549qFNZ8ip/2
 QNx6Fn99lyRaVHLGa0mwKdB9WKYBYZzUpMHejVIEx/Tp+d84EbkaRa+LBO6ClbNY+gd1sZcf8aN
 xq/g7DAV7HZz0uwusG2PcJBCl4CcRNbA45FKLnbF542CioqOWMWty286d1iCb9NWg/TmT00gxLy
 9epcvA4T2E9twGg3F/a1ug85X1njo4qcl7Yrlfutmb9g8w9P6mIwxZ5+mEr2L+9k+OxdfOOe93d
 Da75iV4B1yYZcISAp/hs2qmjlGB7AARU5lzAg6e1juLaMPpAyIUsTZbSAfonhyWvsILyVy9Ikaf
 UL0P4xRLJUTqTWNripYNIKVDs1fkCnmb66tdwjwFwOQF/JlqTX8US3GdBzOlZWW9zYl9qOlRtSG
 +3p3f5xQZSMAoMDbC0A==
X-Proofpoint-GUID: PnU2iWSmgVqmwWYpaYe6Tre8Wf0q1-qo
X-Proofpoint-ORIG-GUID: kNP5PD14_pSgIfF2GX4d6kNYdtL-sRxJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX6cMyU38gIiEM
 6h5HsUXqOaYcxCpSbmLwxfemPuVzFT3ls9DNVWCsA+YjYdHPliad8QjTwy6GvX02mmtCZicv8Ms
 g1ujfdhbp4yGfPsKBT8DmdiKdhs2Yto=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
--------------VzM0ZsxFdhIEkvN4RLTF0wbV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16-07-2026 10:54, Aditya Gupta wrote:
> Thanks for the patches !
>
> On 26/06/17 04:50AM, Saif Abrar wrote:
>> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
>> index 0b556d1bf5..d4f452d7b2 100644
>> --- a/hw/pci-host/pnv_phb.c
>> +++ b/hw/pci-host/pnv_phb.c
>> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>>       pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>>       pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>>       pci_config_set_interrupt_pin(conf, 0);
>> +    pnv_phb4_cfg_core_reset(d);
> nit: phb4 reset in common phb path ? will it affect phb3 too ?


The code checks for phb3 and returns before coming to the phb4 reset.


>
>>   }
>>   
>> <...snip...>
>> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
>> +{
>> +    uint8_t *conf = d->config;
>> +    uint32_t exp_offset = get_exp_offset(d);
>> +
>> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
>> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
>> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
>> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
>> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
>> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
>> +    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
>> +    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
>> +
>> +    pci_set_long(conf + exp_offset, 0x420010);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
>> +                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
>> +                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
>> +    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
>> +                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
>> +                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
>> +    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
>> +                       | PCI_EXP_LNKCAP2_SLS_32_0GB
>> +                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
>> +                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
>> +    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
>> +    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
>> +                                                       | PCI_EXT_CAP_ID_SECPCI);
>> +    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
>> +    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
>> +    for (int i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
>> +        pci_set_long(conf + i, 0x9C38);
>> +    }
>> +
>> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
>> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
>> +    pci_set_long(conf + P16_ECAP, 0x22410026);
>> +    pci_set_long(conf + P32_ECAP, 0x1002A);
>> +    pci_set_long(conf + P32_CAP,  0x103);
>> +}
>> +
>> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
>> +{
>> +    /* Zero all registers initially */
>> +    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
> nit: should we use PNV_PHB4_NUM_REGS here, since we want to set all
> phb->regs to 0 here ?
>
> #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)


We are only setting the PBL registers here.


>
>> +        phb->regs[i >> 3] = 0x0;
>> +    }
>> +
>> +    /* Set specific register values */
>> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
> This reset value is different for PHB4 and PHB5.
>
> The PHB4 spec that i am referring to marks the bits 8:15 as reserved,
> and unimplemented. While PHB5 suggests the reset value of 0x9.
>
> I am okay with considering those bits as implementation defined and let
> qemu set those bits, but maybe it's better to separate it out in
> pnv_phb5.c ?


Implemented separate methods for PHB4 and PHB5, each method setting the 
appropriate reset value.


>
>> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
>> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
> Same 8:31 are reserved bits in PHB4, while not in PHB5.
>
> Maybe separating out PHB5 from PHB4 helps in such cases.


Same separation of methods for PHB4 and PHB5.


>
>> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
>> +}
>> +
>> <...snip...>
>> +static void phb5_tests(void)
>> +{
>> +    QTestState *qts = NULL;
>> +
>> +    qts = qtest_initf("-machine powernv10 -accel tcg");
>> +
>> +    /* Check reset value of a register */
>> +    phb5_reset_test(qts);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>>   /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>>   static void phb_version_test(const void *data)
>>   {
>> @@ -59,7 +83,7 @@ static void phb_version_test(const void *data)
>>           expected_ver = 0xA4;
>>       } else if (chip->chip_type == PNV_CHIP_POWER10) {
>>           machine = "powernv10";
> This patch is giving an error on compilation now in upstream, due to
> introduction of 'pnv_get_machine_type'. We can use
> 'pnv_get_machine_type' here in the start in place of machine = "powernv8".
> What do you say ?


Now updated with the usage of 'pnv_get_machine_type'.

> Thanks,
> - Aditya G


Thanks,

/Saif

--------------VzM0ZsxFdhIEkvN4RLTF0wbV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 16-07-2026 10:54, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">Thanks for the patches !

On 26/06/17 04:50AM, Saif Abrar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 0b556d1bf5..d4f452d7b2 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
     pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
     pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
     pci_config_set_interrupt_pin(conf, 0);
+    pnv_phb4_cfg_core_reset(d);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
nit: phb4 reset in common phb path ? will it affect phb3 too ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>The code checks for phb3 and returns before coming to the phb4
      reset.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> }
 
&lt;...snip...&gt;
+void pnv_phb4_cfg_core_reset(PCIDevice *d)
+{
+    uint8_t *conf = d-&gt;config;
+    uint32_t exp_offset = get_exp_offset(d);
+
+    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
+    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
+    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
+    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
+    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
+    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
+    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
+    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
+
+    pci_set_long(conf + exp_offset, 0x420010);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
+                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
+                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
+    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
+    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
+                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
+                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
+                       | PCI_EXP_LNKCAP2_SLS_32_0GB
+                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
+                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
+    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
+    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 &lt;&lt; 20) | BIT(16)
+                                                       | PCI_EXT_CAP_ID_SECPCI);
+    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
+    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
+    for (int i = PHB_LMR_CTLSTA_2 ; i &lt;= PHB_LMR_CTLSTA_16 ; i += 4) {
+        pci_set_long(conf + i, 0x9C38);
+    }
+
+    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
+    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
+    pci_set_long(conf + P16_ECAP, 0x22410026);
+    pci_set_long(conf + P32_ECAP, 0x1002A);
+    pci_set_long(conf + P32_CAP,  0x103);
+}
+
+static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
+{
+    /* Zero all registers initially */
+    for (int i = PHB_PBL_CONTROL ; i &lt;= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
nit: should we use PNV_PHB4_NUM_REGS here, since we want to set all
phb-&gt;regs to 0 here ?

#define PNV_PHB4_NUM_REGS          (0x3000 &gt;&gt; 3)</pre>
    </blockquote>
    <p><br>
    </p>
    <p>We are only setting the PBL registers here.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+        phb-&gt;regs[i &gt;&gt; 3] = 0x0;
+    }
+
+    /* Set specific register values */
+    phb-&gt;regs[PHB_PBL_CONTROL       &gt;&gt; 3] = 0xC009000000000000;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This reset value is different for PHB4 and PHB5.

The PHB4 spec that i am referring to marks the bits 8:15 as reserved,
and unimplemented. While PHB5 suggests the reset value of 0x9.

I am okay with considering those bits as implementation defined and let
qemu set those bits, but maybe it's better to separate it out in
pnv_phb5.c ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Implemented separate methods for PHB4 and PHB5, each method
      setting the appropriate reset value.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    phb-&gt;regs[PHB_PBL_TIMEOUT_CTRL  &gt;&gt; 3] = 0x2020000000000000;
+    phb-&gt;regs[PHB_PBL_NPTAG_ENABLE  &gt;&gt; 3] = 0xFFFFFFFF00000000;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Same 8:31 are reserved bits in PHB4, while not in PHB5.

Maybe separating out PHB5 from PHB4 helps in such cases.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Same separation of methods for PHB4 and PHB5.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    phb-&gt;regs[PHB_PBL_SYS_LINK_INIT &gt;&gt; 3] = 0x80088B4642473000;
+}
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&lt;...snip...&gt;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static void phb5_tests(void)
+{
+    QTestState *qts = NULL;
+
+    qts = qtest_initf("-machine powernv10 -accel tcg");
+
+    /* Check reset value of a register */
+    phb5_reset_test(qts);
+
+    qtest_quit(qts);
+}
+
 /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
 static void phb_version_test(const void *data)
 {
@@ -59,7 +83,7 @@ static void phb_version_test(const void *data)
         expected_ver = 0xA4;
     } else if (chip-&gt;chip_type == PNV_CHIP_POWER10) {
         machine = "powernv10";
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This patch is giving an error on compilation now in upstream, due to
introduction of 'pnv_get_machine_type'. We can use
'pnv_get_machine_type' here in the start in place of machine = "powernv8".
What do you say ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Now updated with the usage of '<span
      style="white-space: pre-wrap">pnv_get_machine_type'.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">
Thanks,
- Aditya G</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>/Saif</p>
    <blockquote type="cite"
cite="mid:alfDsZl-d1o75KR2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------VzM0ZsxFdhIEkvN4RLTF0wbV--



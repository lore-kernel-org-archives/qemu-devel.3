Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8935CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkRY-0002Zr-Nv; Wed, 17 Jun 2026 03:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkRJ-0002Yi-6V; Wed, 17 Jun 2026 03:11:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkRH-0005gg-Dv; Wed, 17 Jun 2026 03:11:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLneZb2896466; Wed, 17 Jun 2026 07:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CaiGBp
 ODOkyIrhOXyOWZQ0CbCuSGQ4z7FTNbHI+pZjs=; b=bApyjwVd1iPd0y+senT6Dt
 57Lc0F1FJmmwHU26UrD20RTATORNwqiW0ZT9KBoqSgV+y8OBBIVhyiWcmhp3NQS7
 4LvjfUTgbzyN5idMI4oR+YSjuLuynrdMoSVmJgWl+jdTwPPF4PjotaKIw4eCVe03
 TF3YqQZOhyRC0AWX8IVxsGwUM9NZUaZffIj1PJmWFZ++ruskD7I14u4gs+IgJL5J
 gJb6GbXFT0+b8i6raKXT//y+f21OIUiS7a0zAgDo65XVXPepLFRLfp1Qsb/HT3Ni
 8LqB3VCh4mVby/GLgZb/IXH+ycOk2F9V6CxXaCEa4J+GPFZjo3b4FJi+/Is5KwAg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1pan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:11:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74f4Y032439;
 Wed, 17 Jun 2026 07:11:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudvaa0du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:11:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7Bhr616843466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:11:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A77558060;
 Wed, 17 Jun 2026 07:11:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BD3E58056;
 Wed, 17 Jun 2026 07:11:38 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:11:37 +0000 (GMT)
Message-ID: <b0df3fff-b66e-4b21-be87-fa0621734151@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:41:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] pnv/phb4: Set link speed and width in the DLP
 training control register
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-8-saif.abrar@linux.vnet.ibm.com>
 <af9MP4rWy-CBRI42@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9MP4rWy-CBRI42@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXzCem85iEtZU9
 WQiTzxEDFqilZJ3i0oJDfWakX9rXG745k7LI9l1fn0i15/ChSI67PmU0B42z2TjfWv+Zh5vQq9X
 9AVQfP4vPgndqN+TnWPXNR267hdwOTA=
X-Proofpoint-ORIG-GUID: Ix_9JC7HMiXUbv-JW5cofUELHI_DXDYx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXxcYGWSncZZ9w
 yeDFz+5M9hXYBgtwigcvRjtWVeEEDEYvQhffbbFiRKBx3hgFp9v358ZXpv7a+iym7NdbI9eVOPs
 O3i4HTXH7/KITNCPtWWQlFBWzOr5Dj2eKUZFy8/8aythjM5EAfUNlgSvPqsR7aINadQ/SbD/HKi
 GidWayCZjm5+E6SdzCZWs8U3qx7mLCuK4XgJ7Bb9t3QhmUnYgJ254sODvdReRcWQVS7a/smXr3I
 NFgYS7Mrh195Drv1Cdjbb6BnetbODRFJH7bEkC5SGfEmwOz7SsObvNFmQCh7kQb0Qa6L8RCzNqV
 SAShH67AqIbLtPw8SHQ1H2btKzP+qJRrJ35Cne3FdP/admsa+3NY+LR54erreHnUJnX6tbmS6T7
 IJ5OejwBgSF72ebIYGNB5bboK/++GlqqvtzX8lIjI/HPXWwDmsekQc8LGBunCVd3UqwzCgGnxgO
 x8lp8+o9DtLYWoWzndg==
X-Proofpoint-GUID: mWVUKkwqcn_eGrAVUyu-98hcJXS-yNkG
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3248b2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=Amfb7SO6CHF0qoPeeOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
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


On 09-05-2026 20:32, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> Get the current link-status from PCIE macro.
>> Extract link-speed and link-width from the link-status
>> and set in the DLP training control (PCIE_DLP_TCR) register.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v4: Variables declaration moved to the top of the method pnv_phb4_reg_read().
>> v3: Updates for coding guidelines.
>>
>>   hw/pci-host/pnv_phb4.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index c35f632e64..a6fa578e85 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -900,6 +900,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>>       PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>>       uint32_t exp_base = get_exp_offset(pdev);
>>       uint64_t val;
>> +    uint32_t v, lnkstatus;
>>   
>>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
>>           return pnv_phb4_config_read(phb, off & 0x3, size);
>> @@ -961,10 +962,27 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>>           val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
>>           break;
>>   
>> -    /* Link training always appears trained */
>>       case PHB_PCIE_DLP_TRAIN_CTL:
>> -        /* TODO: Do something sensible with speed ? */
>> +        /* Get the current link-status from PCIE */
>> +        lnkstatus = bswap32(pnv_phb4_rc_config_read(phb,
>> +                                exp_base + PCI_EXP_LNKSTA, 4));
> nit: s/bswap32/be32_to_cpu/ ?


Updated.


>> +
>> +        /* Extract link-speed from the link-status */
>> +        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
>> +
>> +        /* Link training always appears trained */
>>           val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
>> +
>> +        /* Set the current link-speed at the LINK_SPEED position */
>> +        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
>> +
>> +        /*
>> +         * Extract link-width from the link-status,
>> +         * after shifting the required bitfields.
>> +         */
>> +        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
>> +        /* Set the current link-width at the LINK_WIDTH position */
>> +        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
> v is little-endian, while val is supposed to be big-endian, is it correct ?
> if so, should v be converted to big-endian before SETFIELDs ?


In these cases 'v' is a 6 bit number, hence there is no LE/BE consideration.


>
>>           return val;
>>   
>>       /*
> - Aditya G


Thanks,

Saif




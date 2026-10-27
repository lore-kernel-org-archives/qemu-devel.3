Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iVzP934s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdhk-0008Os-Et; Tue, 27 Oct 2026 05:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdhi-0008OT-Uc; Tue, 27 Oct 2026 05:42:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdhh-0001CN-AP; Tue, 27 Oct 2026 05:42:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5iOJK4071610; Tue, 27 Oct 2026 09:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zGe38L
 LDiXOh05RimDsKU0TEF6OwsNZyPIMQWG08+E0=; b=iVzP934sHimYrTcqN1QTnQ
 4bGSzcT/3mqoed2jbCRA/mOZYqgIjs88q9R0GbD1mDwuKRM8t45uD2uW2JPy7cpI
 uX2k4vzvL8COBb5TuECW/auiffnJc9QIjxrSOwpE1sQsNJJ0LgEiBe46rGB6VQ0G
 HSe1cxQe7g5PyJmhpqmcRkv2NDjWZWPgyelH+9V7/jp/Jjz1eUcjmsP762p7hcmu
 pbq+kUex9Fm5qwU7e3IhsrXlj0VTVhHspQIS+NAx9H871983coygxjHhVzA60tHy
 GlYjw6Jox3lwvh3p/8PgrSmP4wadKPjsXYrPGcGoRxYWsY48/Ep06GIkRu8WM+Pw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsxnca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:42:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5npRq3687787; Tue, 27 Oct 2026 09:42:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvj88q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:42:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9gaHH20906626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:42:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27A0D5805D;
 Tue, 27 Oct 2026 09:42:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48D1B58056;
 Tue, 27 Oct 2026 09:42:29 +0000 (GMT)
Received: from [9.43.105.244] (unknown [9.43.105.244])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:42:28 +0000 (GMT)
Message-ID: <c055ab23-3b72-4a05-ab3b-dd52cc8f24dd@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2026 15:12:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-7-saif.abrar@linux.ibm.com>
 <aqVICRVbBpb2nFGg@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <aqVICRVbBpb2nFGg@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX4J9PdDMuKJG+
 K64pw4ELVZxoHErLyt5h699J37if1PvUmuHSpj5AIqsSuRBZCG/5+NLqVsVLy9WvYtrd2Zc2EqD
 VB8JOJNZnes2T9xpeQywC7g0yJVQbcWa26rqwsvSqiYfpxw9I2OPyE/ROC0UaXweLCjv93p8Sb7
 DQQNMT8WUargg75c1RTGd3OX7HllpD85fDDoI4LXvMfJvMri8Vo3HfB0xrVMpOxuLU8urM8VpkX
 2moejhCQXlWy0Agfl4bxmttcCL2uRZMRo+PRFWivl9YS+joSMHGVsgKHX1ST8ZBwr1xPEiSUxpL
 4CdPxdQUrZp/ENsz8dxf/Cp48LmFqoM3mZs7lFRW0Rq+fgiWdEfoL0knzrGi5jTY70EUIasDGPd
 a5jQir5wPB9iTktIGjieuXkpa+QxDwajfKZZIw/SjocuZB19euOp+kbIfz0KC9TjCpG9NdqoDri
 viwBlTYS2UyCFUpcjzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX2oS6BVBSKnn2
 0nom7CycEF4KbBpNuHyEWJWjk8U6CKGfgWlnq0ZFYHoQUC9sdUjZJct6HeyOdEQ91knvVLAAfSY
 WsYedXnSkpWyUPbTzWkDjqYRCcnAOtU=
X-Proofpoint-ORIG-GUID: kYWNvmoivx41sgMV1nf4W_ZYlwPVS319
X-Proofpoint-GUID: 0cr_3GhiO4uVWFEfvkfWyr36MlHrgL5P
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae0720f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=WGIbY7UA8hmLZArvRYIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270036
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Aditya, updated in v7.


Regards,

Saif


On 12-09-2026 18:11, Aditya Gupta wrote:
> On 26/08/31 07:30AM, Saif Abrar wrote:
>> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>>> <...snip...>
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -508,6 +508,34 @@ uint32_t get_exp_offset(PCIDevice *pdev)
>>       return rpc->exp_offset;
>>   }
>>   
>> +/*
>> + * Config-read the link-status register in the PCI-E macro,
>> + * convert to LE and check the link-active bit.
>> + */
>> +static uint32_t is_link_active(PnvPHB4 *phb)
>> +{
>> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
>> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>> +    uint32_t exp_offset = get_exp_offset(pdev);
>> +
>> +    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
>> +                        exp_offset + PCI_EXP_LNKSTA, 4)) &
>> +                        PCI_EXP_LNKSTA_DLLLA);
>> +}
>> +
>> +/*
>> + * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>> + * RC-config space values and masks are LE.
>> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
>> + * Compute new value in LE domain.
>> + * New value computation using sticky-mask is in LE.
>> + * Convert the computed value from LE to BE before writing back.
>> + */
>> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
>> +    (pci_set_word(conf + (a), be16_to_cpu( \
>> +                     (be16_to_cpu(pci_get_word(conf + (a))) & (s)) | \
>> +                     ((v) & ~(s)))))
> this is already defined in a previous patch in pnv_phb4.h
>
> may have somehow gotten added in v6, can remove this
>
> - Aditya G


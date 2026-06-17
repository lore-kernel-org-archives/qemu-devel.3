Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37772CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjfv-0001tY-EW; Wed, 17 Jun 2026 02:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjWc-0006tW-7w; Wed, 17 Jun 2026 02:13:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjWa-0001wb-42; Wed, 17 Jun 2026 02:13:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLn9CK2636783; Wed, 17 Jun 2026 06:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uFPPZT
 4t0yoT/kr0uEe5siPu7p+pRn2dA/bTYV9vUNY=; b=VB8RagWDg9+HWn1jcA6eOe
 VMtOMc0BeCGncXWcY0wmGTDDzc5KymKFLfCmJrzmd9vcAfnGoolfyOmK7+FVbo6d
 kXZZuAzyV1aaB8iJeKFmfjVUSR06iMZaAsX2PG9NeEV2v0Nqwgk7bSusCUbY2slp
 /oahtIbqEUZ9zYXzKPrSWEEti26XS4ag920pfDLPcdtFOO/rj4fAWaPsNwE8IeER
 gR/Zy8Cans6c2jSN1isW7JPynkXcaBFg7AbMGmSWpzkyNMRjRuWUlsc+qdR49T9Z
 K9vst8bT32quw3K6CiaBR0Boa4ZXd6lFl+iE4K7uuD4gBzlrVEHzq8CBZg5P1f4w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx1f5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:13:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H64c5P026949;
 Wed, 17 Jun 2026 06:13:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva1ssb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:13:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6D7uR61473118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:13:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7629758064;
 Wed, 17 Jun 2026 06:13:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E34C5803F;
 Wed, 17 Jun 2026 06:13:03 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:13:03 +0000 (GMT)
Message-ID: <ad6e037f-cd29-4394-b337-e73352740e9b@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:43:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
 <a9e49acd-855a-4506-98d6-edd8cfca8792@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <a9e49acd-855a-4506-98d6-edd8cfca8792@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX4oEe4DAF1tx+
 NRvwGvJXwzBLP5uySJ6DFEcfH49DTJLvkRNUDexcwKcapAxyjTsJyO4AkHy2Nj8IN/nskbYyn1V
 MvEup0bVaXdd6rOFXM7K3E8deQwPWwJOB7oHTEE7GuqbQG1KzvqFJx0w1onUVs6zo5FY6nfdwke
 6C/PvgLf3CRow2kEwrwX/u2Qi6NGFkwaUOhzMNxMlwwiHh02vR2RyqdAdgPY0Wu2yy2MZ6Ejgem
 TB80fsTvx9MXq/FX0MK07jSaQfHSJW8fwaJSGUFcE1XVxQ9Jma5TManQZjKjcQpvr0HhGWYRLDl
 UmbAIEBX0qcpHubVqma3f4yUpdzXMXh7xxCQKuh8ZmadhdbSg9gcgDxe7+qKv6g3Dm5eah0kanZ
 EZWYhKmQdc8ChjI4YLKBmG4yqHTNcnVQkNmHNmgIyyUA73kgROggRToVayp/zG5DIBIxejIW3V8
 Q+mCavMh68XO8cte7hw==
X-Proofpoint-GUID: EeI3UlVcKBdPyKJTyrFLtKL7dIwBKK6K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfXwiMZZwGN+hvD
 yLfbzLRNdFN13jG9cePzUrR6ePZYmWeZZmNwXmNh5wp6JYRkrD/dwMDK2L1bi1BsdMzpclhdeCw
 yC/KnEE4jsiy37iZB7lFqDSubWZUZw4=
X-Proofpoint-ORIG-GUID: SJRAGjoNGfsqXBzZnMVyais2bBTkIXgi
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a323af6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=gKRWrZZBLapbZDKzPI8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170051
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:22:58 -0400
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


On 05-05-2026 19:46, Harsh Prateek Bora wrote:
>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
>> +{
>> +    uint8_t *conf = d->config;
>> +    uint32_t exp_offset = get_exp_offset(d);
>> +
>> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
>> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
>> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
>> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
>> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
>> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
>> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
>
> This duplicate looks like a copy-paste error ?


Duplicate removed.


Thanks,

Saif




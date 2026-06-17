Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38ABCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjgC-0001wO-8W; Wed, 17 Jun 2026 02:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjgA-0001w9-V7; Wed, 17 Jun 2026 02:23:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjg9-0003zl-Jg; Wed, 17 Jun 2026 02:23:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnZMW2637661; Wed, 17 Jun 2026 06:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E2BA46
 Cfv4DKLOYmPNvkWMPuL/42b07mrJLW+v36EEg=; b=Yk9tfXwi1eeIxhDYXojECw
 PEmeu/MLIlOLmIZjkMz/alcZgwRGup3TMb0igvHnjjtbK0j+/0V9yHn8fQBqnOne
 zXS2oNdrJR2jUleQXQaZ+mvjD9KbqhLF4TKM3hm8A4nxXIN+COus+5xFS8LAAucL
 V+BIov/bysSLSMVK3L8NZhlIWsROFKZ8iItg35TD0NtraZP2kMA5boU2j2wJmEDu
 yH7etIOIpzCY8yKTnT5Iuouu0p+nd3o5ajr04v95HJeA3t8c0c4G2hC5A8X1e9ft
 Aa1FVFhvylP+a/CiEgqHha30lscNa32yUgA8WZSQ44BZ7as/BBk42sfYhDeGtzlA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx1g5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:23:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JeKb031669;
 Wed, 17 Jun 2026 06:23:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvahtm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:23:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6N2Fu32965318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:23:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76E6158056;
 Wed, 17 Jun 2026 06:23:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 124D45805A;
 Wed, 17 Jun 2026 06:22:57 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:22:56 +0000 (GMT)
Message-ID: <df71f1ee-0c09-4735-ac0d-6b5c9b7a5c21@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:52:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pnv/phb4: Implement sticky reset logic in PHB4
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
 <af9I8BUI0v1LgK-L@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9I8BUI0v1LgK-L@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX60oFJ80+s6qp
 PgxrYVa/eM29v6vBOyToVMpzuDuZRrAt/SM0q1PIjV/o/Dm6gqtzMBZ3Nkc7q0bUKXwJmCjeMUz
 Nm4a3pILgcKfis0/ZwkIcOVoVnyTUpAygPOXbYmPrdXthnInJV2TdKj2SgDzLMsyE/bDmgf3lWz
 ZDnGfq9I+ettArbCKfj3pnwNEZjQQh7CgEZccTt1RyAHMC9OUeRiNrshA2Lx+YWR8ttZhLU0a2w
 o8WrS2lR81gXHA+ntfJHcDs7x2DDrsQkHIRnXdH21B12DpmQXm9G1rW2f6MFEIqRWNikNPYAxZU
 wAd8p+jdKKs3yBB5CmHFBmkj2EURaNpzH5+CVwS99/+mQk6f8nY+xkVavcZMwO0lIqY4vWtmj0p
 CvKaidWSd4/q4t3JZI7t4+zac2OezY3f5rmhgwW5ZL1heauJ5RhK3a4scMdQb88epQ2Tu+IVhGS
 qWa1PMtf31wNChlH4sg==
X-Proofpoint-GUID: uuFLhCt8LEKwTllt3Uc-JHl9jbRY3lcm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX3IJ6PJa3Pk6L
 KCBmFm9Fxe/36sqq51xmYgOUphleVafDQeCNyavZFwz73vQwnoM1KR9IDTAOxjzjuC7COP1yg3/
 jD+A6b16D//u0ncT2gfHz1kRZiYGxp0=
X-Proofpoint-ORIG-GUID: hXRMhyxK_9b6NlZ25ItEjYY1B0tjAEhi
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a323d48 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=w_ZJ6ZAfCP-zUQxZfWQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
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


On 09-05-2026 20:18, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>> +/*
>> + * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>> + * RC-config space values and masks are LE.
>> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
>> + * Compute new value in LE domain.
>> + * New value computation using sticky-mask is in LE.
>> + * Convert the computed value from LE to BE before writing back.
>> + */
>> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
>> +    (pci_set_word(conf + (a), bswap32( \
>> +                     (bswap32(pci_get_word(conf + (a))) & (s)) | ((v) & ~(s)))))
> should be32_to_cpu be used here instead of bswap32 ?


Using be16_to_cpu now.


> - Aditya G


Thanks,

Saif




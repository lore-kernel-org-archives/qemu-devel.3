Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD1ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rpq-0002Xb-HL; Tue, 30 Sep 2025 00:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v3RpL-0001L2-UJ; Tue, 30 Sep 2025 00:19:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v3RpB-0002AR-BA; Tue, 30 Sep 2025 00:18:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TLb6us005829;
 Tue, 30 Sep 2025 04:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Su4g0T
 lyJUDKkZJdLxW2ozcsh674v+fAzSwIp9Klf7M=; b=B4S/I41hDdBiYt8sgEnVjM
 37fDgtNvb3JKrE9tVgTbtlrlXzrP8o7I6CUx8jXgZKmYcZhO541t8zLMQYw3XR5A
 YrcJOIlBKqbX0UwRkMX00m3befuMHDA8N/QU87R+bPh+3j4kTlpOGoPxDUav4iMf
 BSKopl0GpJDkwr0hARnXXgtf5WEvZhqTpDE5AqUnge2qYag+K7JFohH1QUmWyXya
 efvkY1vfiBDH5oWlKm9mZeqF5ZzccNQQHSoaHO5sxiM0TfJ4zqokAbdlYsuWemrk
 AvhBIAocpMj8e6engksBcPjuiNVWp8lDmjE/YmidgyP7DcAyH70f4qCS0ee2RkFQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e76d6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 04:18:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58U47nIX003810;
 Tue, 30 Sep 2025 04:18:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxsnec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 04:18:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58U4IeWZ66716014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 04:18:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7081458056;
 Tue, 30 Sep 2025 04:18:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6219D58045;
 Tue, 30 Sep 2025 04:18:38 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Sep 2025 04:18:38 +0000 (GMT)
Message-ID: <d14d6716-d8ec-4e8b-b3c6-98649908c5c1@linux.ibm.com>
Date: Tue, 30 Sep 2025 09:48:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 19/27] ppc/spapr: init lrdr-capapcity phys with ram size if
 maxmem not provided
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Gaurav Batra <gbatra@us.ibm.com>, David Christensen <drc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
 <20250928192629.139822-20-harshpb@linux.ibm.com>
 <415738f9-4601-40fe-9bb9-4b9ba106da76@tls.msk.ru>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <415738f9-4601-40fe-9bb9-4b9ba106da76@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xugOXQbZCAYxpM1naiKwVjcAlcX3SHrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXwQjIOZj8jO+E
 M8uklirEmWq7Oidp/Lddly9KD/+1+ldEh/rUoFbyDdcRSEyX3+K0BlZSmioTPu/HwWsnoMbhXhf
 ZXvWS/qbRd/h0aCkvTY7ODJUGsGnKYosVdv/2HljM7SchNY/HpIhcfB9on+WERbkPVzXWclTdO7
 o3i22td/lxLxdmc5JnNo5+h8Seb4qGALowoOMh+CoEo4kuWhhzhyRgWA4tqfRLA71KZDbY2fA92
 HgGPci5JtdjZ8feC8vsJSaQU61uoVTBtVWJLs07+xQmukgZbLdZ2bsRevo3ma8/PAit6bP00DVn
 fuR4wY8lsUPhNwh8273Km7Sb4GPYpZIk5ZLHRB3NnX3IsKISPliIyVwccTC3VYKUCmf37tRglcp
 Fj3HUEeqZNyHKvtlmzW7ylpYqTfe6Q==
X-Proofpoint-GUID: xugOXQbZCAYxpM1naiKwVjcAlcX3SHrG
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68db5a24 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=l0JILTX7bsEjRigKuHsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/30/25 01:06, Michael Tokarev wrote:
> On 9/28/25 22:26, Harsh Prateek Bora wrote:
>> lrdr-capacity contains phys field which communicates the maximum address
>> in bytes and therefore, the most memory that can be allocated to this
>> partition. This is usually populated when maxmem is provided alongwith
>> memory size on qemu command line. However since maxmem is an optional
>> param, this leads to bits being set to 0 in absence of maxmem param.
>> Fix this by initializing the respective bits as per total mem size in
>> such case.
>>
>> Reported-by: Gaurav Batra <gbatra@us.ibm.com>
>> Tested-by: David Christensen <drc@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Link: 
>> https://lore.kernel.org/r/20250506042903.76250-1-harshpb@linux.ibm.com
>> Message-ID: <20250506042903.76250-1-harshpb@linux.ibm.com>
> 
> This feels like a qemu-stable matherial (for 10.0 & 10.1 series).
> Please let me know if it isn't.

Yes, it can be picked for stable releases as well. Thanks.

regards,
Harsh

> 
> Thanks,
> 
> /mjt
> 
>> ---
>>   hw/ppc/spapr.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index eb22333404..82fb23beaa 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -907,6 +907,7 @@ static void spapr_dt_rtas(SpaprMachineState 
>> *spapr, void *fdt)
>>       int rtas;
>>       GString *hypertas = g_string_sized_new(256);
>>       GString *qemu_hypertas = g_string_sized_new(256);
>> +    uint64_t max_device_addr = 0;
>>       uint32_t lrdr_capacity[] = {
>>           0,
>>           0,
>> @@ -917,13 +918,15 @@ static void spapr_dt_rtas(SpaprMachineState 
>> *spapr, void *fdt)
>>       /* Do we have device memory? */
>>       if (MACHINE(spapr)->device_memory) {
>> -        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
>> +        max_device_addr = MACHINE(spapr)->device_memory->base +
>>               memory_region_size(&MACHINE(spapr)->device_memory->mr);
>> -
>> -        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
>> -        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
>> +    } else if (ms->ram_size == ms->maxram_size) {
>> +        max_device_addr = ms->ram_size;
>>       }
>> +    lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
>> +    lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
>> +
>>       _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
>>       /* hypertas */
> 
> 


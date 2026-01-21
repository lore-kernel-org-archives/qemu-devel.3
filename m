Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A0FC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vig4C-0003wa-05; Wed, 21 Jan 2026 16:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vig4A-0003vn-9X; Wed, 21 Jan 2026 16:48:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vig46-0001Fu-CL; Wed, 21 Jan 2026 16:48:40 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LELepj007731;
 Wed, 21 Jan 2026 21:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ySjPrv
 Kai+9G58nLiOZicGerVv5FMwmuup2qCDHufmE=; b=jWIl+8dhX4D+KOZjJu6K+Z
 yiyqmfZ0tjf29YpLie8exzVsh58Jq/+t1l6QZuOtDUIHSS37nxKiuac+qiEj0ntT
 mMntcPpoCK+2YnP0u/yy86N63hNslt+j3NmS1r9iTPeVBZ/KQHVYmLMzlfPYqc7l
 XzMmxEdiOtaYb1UCRPrnw1lob7hrQB0raijg66+0bYKRHm91JjIZ3b/2+ysEOYmf
 1VLCcB7mVQrIzo2ZbJemgIew8YhhRO7wGCFkZZNeKEsrPrQaGJUUfAW/c1CQp5Dt
 DCfIb79HyY2CuE1HznvunCeGudjeqZslKrVP+zcoQA2qK1iDqRu1ALUjgnT/RJ+Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukdj68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 21:48:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60LJ9ArL027285;
 Wed, 21 Jan 2026 21:48:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrn6nsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 21:48:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60LLmY7E20120138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jan 2026 21:48:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37AEB5805D;
 Wed, 21 Jan 2026 21:48:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DD3558059;
 Wed, 21 Jan 2026 21:48:32 +0000 (GMT)
Received: from [9.61.163.161] (unknown [9.61.163.161])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jan 2026 21:48:32 +0000 (GMT)
Message-ID: <0cdc9f9f-f36e-43dc-a263-bacfb788291c@linux.ibm.com>
Date: Wed, 21 Jan 2026 16:48:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/29] pc-bios/s390-ccw: Define memory for IPLB and
 convert IPLB to pointers
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-15-zycai@linux.ibm.com>
 <9d99ee80-8652-4164-819c-add79309c7f1@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <9d99ee80-8652-4164-819c-add79309c7f1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE4MiBTYWx0ZWRfXxyp1KZ+C/+RV
 5P33qfGhiLapkBBtOgvTD6hxQm4dGZbUUk5G0z7p65B0p7tFvE3wD/Jjs1JzLSiP2jndT+kMTtC
 3gGKh4pJWOPvXhqpzFLHv3p5k2iLPTDkUV10irGd/Pw0rshQunui4U2qBd4yUzi6SgtfaXfJSFb
 iBorFATprE56nrtAWIM/vuSs5/JaYtlsNWws389hX2lfO23upkDuww0f7Y9wZjquFdcHJ34EFSZ
 MjVDWXXKGPhfZPCsK49hUYA6fvwQUjuaVOmmQTfkWK6wdOEp+nZdf86KDGy55k0jOvzOSEAw67W
 n1tTO2pp52A5/e1n82OdazByO1wt1wk6EGr2ENVh3nbJ6qnz+NfvuSAPvJ/3xnZVefxkAQe0x0C
 tl9E3/Ete7zjSc81v4hWJWaXUaW4bj0WWFt9wOzt36Nob0idisvt1NmGHyhbova2KDoyt2Pm6qB
 bJWCcSsFrFjHqZqCYDw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=697149b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=tLGVLMkNo7eZAJHqfPIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: av18uN3NMPJAwqXQJcVsrytD0Q_z0ocY
X-Proofpoint-GUID: av18uN3NMPJAwqXQJcVsrytD0Q_z0ocY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210182
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/9/26 1:02 PM, Thomas Huth wrote:
> On 08/12/2025 22.32, Zhuoying Cai wrote:
>> Define a memory space for both IPL Parameter Block (IPLB) and
>> IPL Information Report Block (IIRB) since IIRB is stored immediately
>> following IPLB.
>>
>> Convert IPLB to pointer and it points to the start of the defined memory space.
>> IIRB points to the end of IPLB.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/iplb.h     | 13 +++++++++++--
>>   pc-bios/s390-ccw/jump2ipl.c |  6 +++---
>>   pc-bios/s390-ccw/main.c     | 34 +++++++++++++++++++---------------
>>   pc-bios/s390-ccw/netmain.c  |  8 ++++----
>>   4 files changed, 37 insertions(+), 24 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>> index cc3ecc69e5..a0f58d125c 100644
>> --- a/pc-bios/s390-ccw/iplb.h
>> +++ b/pc-bios/s390-ccw/iplb.h
>> @@ -20,7 +20,7 @@
>>   #include <string.h>
>>   
>>   extern QemuIplParameters qipl;
>> -extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>> +extern IplParameterBlock *iplb;
>>   extern bool have_iplb;
>>   
>>   struct IplInfoReportBlockHeader {
>> @@ -85,6 +85,15 @@ struct IplInfoReportBlock {
>>   };
>>   typedef struct IplInfoReportBlock IplInfoReportBlock;
>>   
>> +struct IplBlocks {
>> +    IplParameterBlock   iplb;
>> +    IplInfoReportBlock  iirb;
>> +};
>> +typedef struct IplBlocks IplBlocks;
>> +
>> +/* extern only allowed in header file */
>> +extern IplBlocks ipl_data __attribute__((__aligned__(PAGE_SIZE)));
> 
> Not sure ... does that __attribute__ have any effects for "extern" declarations?
> 

Thanks for pointing this out. The __attribute__ on an extern declaration
doesn't have any effect. I'll move the __attribute__ on the definition
and drop it from the extern declaration.

>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 76bf743900..c9328f1c51 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -22,7 +22,9 @@
>>   static SubChannelId blk_schid = { .one = 1 };
>>   static char loadparm_str[LOADPARM_LEN + 1];
>>   QemuIplParameters qipl;
>> -IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>> +/* Ensure that IPLB and IIRB are page aligned and sequential in memory */
>> +IplBlocks ipl_data;
> 
> I think you definitely want to have an 
> __attribute__((__aligned__(PAGE_SIZE))) after the ipl_data declaration here!
> 
>   Thomas
> 




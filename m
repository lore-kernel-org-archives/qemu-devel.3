Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B92C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4UG-0007Dn-EL; Fri, 25 Sep 2026 07:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xA4Tx-0007A7-Az; Fri, 25 Sep 2026 07:52:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xA4Tu-0002Ka-Nz; Fri, 25 Sep 2026 07:52:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4a7ZS102472; Fri, 25 Sep 2026 11:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PqLjyR
 YeMAaeseJgLqT5QTpuUJJUWA1CFryBV2t5vx8=; b=UMh/eje02q4ouAiy+VACg8
 9uunn4MZAzxqoYK457mW2VQpgrVmt6EnkeCG+QvdtnHHJTEzEFtUxfm9wiY5OVsn
 rwqcyRtu4xVzPHEw2pIoMMqmOx3LCd74b9QdgFH3UOjktABzSN1y/ZEHxVEhdr9n
 mO+HsOm//kqLyznyutn7eueIvtb4NM7twN1NZjlzOKAgYQ8bUvU0L/fVdb4227l1
 v5fB6tNzyZfj+sKS5rXJEBi+p2FhmqmcApMpxFni+PWaLSuVVUJjDTmuJLw321cP
 erwytUZn7vedXMcDyUhwsBWvtElakhzBKPf3zMVf8U1quWoNdxr+4hzTQXWWv6aA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvnv4m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 11:52:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P9xNJZ3248857; Fri, 25 Sep 2026 11:52:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt3266d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 11:52:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PBpvrZ62194018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 11:51:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 241025805D;
 Fri, 25 Sep 2026 11:52:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99D5458057;
 Fri, 25 Sep 2026 11:52:40 +0000 (GMT)
Received: from [9.61.145.93] (unknown [9.61.145.93])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 11:52:40 +0000 (GMT)
Message-ID: <3b1ab249-2226-4cbe-b333-a681eeccc12e@linux.ibm.com>
Date: Fri, 25 Sep 2026 07:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] s390x/sclp: Reject short headers in PV case
To: Janosch Frank <frankja@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260922201526.2383047-1-farman@linux.ibm.com>
 <20260922201526.2383047-10-farman@linux.ibm.com>
 <84b2133f-a8e2-47d2-8fe7-46c2b92118c5@linux.ibm.com>
 <ea7dd9b0-0ba6-4485-a488-eb5fe9d5a570@linux.ibm.com>
 <dbb9db92-6504-4ca3-8ab3-96140a1bf0f8@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <dbb9db92-6504-4ca3-8ab3-96140a1bf0f8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e4t4f-U1ud9T1-7CWfbBoe6VJoCUblkI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfX6xkSxuM8juBC
 94uhCkBKSQbGyHrgX8md1XYSiq+3heFrWC2yWRZXVArkEO99Y8x3Ar6z4SwFYzxL3PBLNUXoRzf
 WeU1uEKtxCELttWVwgnTpzW/pr7lpVA=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6608b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=T61ntsxnzfGQLWboZoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: e4t4f-U1ud9T1-7CWfbBoe6VJoCUblkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfX5VaZrumlWBtK
 LxMogWDrKaA5ubZACS8djZLEfVPUjbWi8Ti3m9AU6RjZkicDhfa1JvwKzM2YTtIPHO4wIO95PVQ
 GavAfHPTazWTjXwxwSGxhdgKxhA7X2gBpHk+NjqVImZMYOVIh3mYJI9k/8XIBNYBj/bJKfGIYmE
 awSl8l4O85jut8PVafGjqYNpBx9B85TxPHRXkQ+VZubuOz2kEEiEq2iKgpvKzJJpqKwUyNCFFYO
 Pql5XOGSUyYyoSU/tS9MvvzdoJ1sONgjnNwyJVzmdy79La9s3uEeOkutadipPQ/TlqyJyct8Qi9
 ai699HG+nnwOCOCaerYEFkaZNIxovfyFWasS8W/vzSvylUEC7XrnBiLoqyBLh146quFFtV1PDyd
 V40EgdnK3Ko81Ig8POzIc8tzIU3kCiSFp0gdV+WZvZp7MOT55+j3GZwmUU5D5gwhwk5SuvPKVK1
 8tp5ccbE1of0FxEWg0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/25/26 3:58 AM, Janosch Frank wrote:
> On 9/24/26 4:39 PM, Christian Borntraeger wrote:
>>
>>
>> Am 24.09.26 um 16:36 schrieb Janosch Frank:
>>> On 9/22/26 10:15 PM, Eric Farman wrote:
>>>> An invalid length in an SCCB header correctly generates a specification
>>>> exception for the regular (non-PV) codepath that processes an SCLP
>>>> instruction intercept. The PV case doesn't, even though such a thing
>>>> should already be sanitized. Since a short length will cause problems
> 
> ...even though such a thing should already be handled by the UV.
> 
>>>> later down the line with the storage that will be allocated based on
>>>> that size, put up a defensive check and return if it is too short.
>>>>
>>>> Cc: Janosch Frank <frankja@linux.ibm.com>
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided 
>>>> length")
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>> ---
>>>
>>> How would you hit that if the architecture says FW will automatically 
>>> inject a spec exception without exiting to the hypervisor if length < 8?
>>
>> As I said in my review, current UV will sanitize this, so this is just 
>> defence in depth in case
>> there would be an implementation error.
> 
> That got lost in my mailbox overflow.
> 
> Alright, then let's extend the comment and commit description before 
> someone deletes this as dead code.

Works for me. I'll fold the above/below comments in when I apply.

> 
>>
>>>
>>> Did you witness this happening?
>>> Am I missing something?
>>>
>>>>    hw/s390x/sclp.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index d8b655efcc..ad8129a5d8 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, 
>>>> uint64_t sccb, uint32_t code)
>>>>        s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, 
>>>> sizeof(SCCBHeader));
>>>> +    /* Do nothing if the header appears malformed */
> 
> ... We should never end up here due to UV checks but let's be sure.
> 
>>>> +    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
>>>> +        goto out_no_write;
>>>> +    }
>>>> +
>>>>        work_sccb = g_malloc0(be16_to_cpu(header.length));
>>>>        s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
>>>>                             be16_to_cpu(header.length));
>>>> @@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, 
>>>> uint64_t sccb, uint32_t code)
>>>>    out_write:
>>>>        s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
>>>>                              be16_to_cpu(header.length));
>>>> +out_no_write:
>>>>        sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
>>>>        return 0;
>>>>    }
>>>
>>
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DBEC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmPw-0001dA-0V; Tue, 11 Aug 2026 09:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtmPu-0001cr-7O; Tue, 11 Aug 2026 09:21:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtmPs-0006zI-GZ; Tue, 11 Aug 2026 09:21:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BCVdFl2731381; Tue, 11 Aug 2026 13:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pySq8H
 gVbjdSZAETMs2GEJ/6jzNyAsxpPihbJrmxBUg=; b=F9QTlI1KBexdLAh198VRDg
 q3twZ78xiPyWanSgc5thyC3Uqn0Ouy3WoVYa27wyRjTsUtfsfWywUMkGGp4ZlZcj
 Ort2bUZ8TLBbuumjgsZGmeDmDa4qk9cGq898B4gNMuwJZPqbK+f1dzQi0hw5r+oe
 k3TFm12R0xGsbfNKBzld3fhCD0U5iLKNLToogvwScmtOC4X5OUkXj9B+O6R1s7XK
 t5nowtaMzqDM4sTH9SYtD56RLjr5ROiaJAW7pNraeZu/HurGMg98vWNXzFEaAbcq
 E1yJ7oGYf8N5352n8zyXDlnvg0lYnGLQY9Fvq/qfSrLsppAkg3VhSOA/lNLqPhSQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyw218-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 13:21:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BCuI6E021133;
 Tue, 11 Aug 2026 13:21:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0ts5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 13:21:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BDL5XD26804922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 13:21:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C55858069;
 Tue, 11 Aug 2026 13:21:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E11D758065;
 Tue, 11 Aug 2026 13:21:01 +0000 (GMT)
Received: from [9.124.218.109] (unknown [9.124.218.109])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 13:21:01 +0000 (GMT)
Message-ID: <8611cad6-bfc9-4d3d-9fe2-322fdb34e1ca@linux.ibm.com>
Date: Tue, 11 Aug 2026 18:51:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
From: Chinmay Rath <rathc@linux.ibm.com>
To: sesame_h@qq.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com,
 Minhang Zhang <zhangminhang@kylinos.cn>
References: <tencent_8A3172131A5ED2AD86D441389EB32CF67809@qq.com>
 <97953d1c-8777-4e25-9669-16a5e2a47602@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <97953d1c-8777-4e25-9669-16a5e2a47602@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwOSBTYWx0ZWRfX974d9Nw/d3w0
 1gtdpBnqP8ioz1dsxuHKMmCVAsqdi11dBubRLKgUfHPJGmk/NznqjewelDWnQlWXogHSlybDCPq
 icAq5ndWb3PHM6st4FdHvdPTz2YC1kRq1X06y9WedcpendxynVDT037EJe7eQ/ETEkDG2QhETy0
 TJcIce5wVOSwAqRfAAGPlGhub3FTWG61kyVgSpplxlIt3RYBxbQCnA/8Um1RlK6LT9Oz5zSIkmg
 qCn3irxlNGPOlO83kUfPalld5hx9QxBef+CDf3kSD8zUAvc8TlZsjwdBj9QveA0c6ej3OOe3u1F
 c2e73Ld3pg5/72tfRCXtetcGoBXuYgScRUzarbIQWwtnYpzhbmLwgLoWFzSD6p+NLDEMNLDzAh1
 p75/KrAMynzm/VA1Zb7WrjjX0b8vVGVzTYBP5+Jiya4AtNa/4G6ta/PHzf7Fli5uxnrzjv1/+iL
 hWGtOSpVUuyZaaXdnOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwOSBTYWx0ZWRfX9puJ23ie+Ets
 vRvmH5iNGUSssdEWT2CjfIbjWZJ6gy4DA7S18X70/fbfuX1dVIGomaIQvjyuI39NAkmtR04mAJM
 d+GAimNMhV9rmCivWtJD9Wf4l893UuE=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b21c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=dZbOZ2KzAAAA:8
 a=j1eo19963X934_aDWvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: roghYrBnO2aXPOPy07HNQSWuRcfQGoUk
X-Proofpoint-ORIG-GUID: Hg-7u2p1AAnm-rafmZbQVpFraWynWDcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 8/11/26 18:47, Chinmay Rath wrote:
> Hi Minhang,
> Thanks for fixing this. Took me a while to get hold of the docs for 32 
> bit mmu, hence the late response.
>
> On 8/7/26 14:47, sesame_h@qq.com wrote:
>> From: Minhang Zhang <zhangminhang@kylinos.cn>
>>
>> ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
>> corresponding checks for the 32-bit case.  According to the Power ISA,
>> in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
>> HTABMASK (bits 23-31) must consist of a consecutive string of
>> 1-bits starting from the LSB, i.e., be of the form 2^n-1.
>>
>> Add checks to reject invalid HTABMASK values and log a guest error
>> for non-zero reserved bits, following the same pattern used by the
>> existing 64-bit validation.
>>
>> Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
>> ---
>>   target/ppc/mmu_common.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
>> index 2499e61..59e8324 100644
>> --- a/target/ppc/mmu_common.c
>> +++ b/target/ppc/mmu_common.c
>> @@ -57,9 +57,23 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong 
>> value)
>>                        " stored in SDR1", htabsize);
>>               return;
>>           }
>> -    }
>> +    } else
>>   #endif /* defined(TARGET_PPC64) */
>> -    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
>> +    {
>> +        target_ulong htabmask = value & SDR_32_HTABMASK;
>> +        if (value & 0x007F0000UL) {
> From what I see in the programming manual, shouldn't the bits of this 
> flag be the other way around : 0x0000FE00 ?
"bits of this mask", is what I meant. Not "flag", my bad.
> Nevertheless, it would be better to form the mask by ORing the 
> SDR_32_HTABORG and SDR_32_HTABMASK fields from mmu-hash32.h, instead 
> of hardcoding it; the way it is already done for 64 bits in the same 
> function.
>
> Regards,
> Chinmay
>> + qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "Invalid SDR1: reserved bits 0x" 
>> TARGET_FMT_lx
>> +                          " set\n", value & 0x007F0000UL);
>> +            value &= ~0x007F0000UL;
>> +        }
>> +        if ((htabmask & (htabmask + 1)) != 0) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "Invalid HTABMASK 0x" TARGET_FMT_lx
>> +                          " in SDR1 (must be of form 2^n-1)\n", 
>> htabmask);
>> +            return;
>> +        }
>> +    }
>>       env->spr[SPR_SDR1] = value;
>>   }


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F55D3EE65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viuWu-0000PF-N2; Thu, 22 Jan 2026 08:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1viuWZ-0000MQ-7Q
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:14:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1viuWX-0003cs-33
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:14:58 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCxhQV021363;
 Thu, 22 Jan 2026 13:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=49S9cI
 bU95i7YtyrqFfsmozSG41Pw8ggN//tIiR6jBo=; b=XESIXW4YdRZ1u0sxcyodaL
 Z43yq1Re+PLSzLa+B8yK4iFy8xbnC+eq37Oco2uxPe/h93oQxjdeZ01IU0BQWp9L
 K4iYHGzeyUSS50buTpbxOVAJ4eWmIXB4Tn8hgdsk3re6dvMapDsfj8pOWoa/OEZj
 /iREYvZp/qXU+B93PboATKCsaGF7mTqkG0ADrn0C4Nuct07xUKlUhcWTtTep99eA
 u763+bxrIeRIjj0wxWDXB9vxweBwsOzewIc+84s+OpUw4Ewyj+fXVX3miAF83xoh
 ZPyVc9cmDqkcWgyrHTR7HOR+NrB7ULRgtCWlS57vitL3+vLMA/GaUfLoSBr6dfuQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612crrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 13:14:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MAFJG0016627;
 Thu, 22 Jan 2026 13:14:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4yaf2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jan 2026 13:14:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60MDEowo37421400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jan 2026 13:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FA7A2004B;
 Thu, 22 Jan 2026 13:14:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B14A62004D;
 Thu, 22 Jan 2026 13:14:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.153.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jan 2026 13:14:49 +0000 (GMT)
Message-ID: <956b1abe-009e-4f39-8549-425c02be47ea@linux.ibm.com>
Date: Thu, 22 Jan 2026 14:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/s390x: Implement DIVIDE TO INTEGER
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-devel@nongnu.org
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-3-iii@linux.ibm.com>
 <64d55baf-ab07-4870-8f2d-d9cf3b68c4f6@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <64d55baf-ab07-4870-8f2d-d9cf3b68c4f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VYrgpny1jTGSs-9A29eEvfyao9UqJFLl
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=697222cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iQxaVk6170P_nYVoegwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VYrgpny1jTGSs-9A29eEvfyao9UqJFLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NSBTYWx0ZWRfXxAw2Ta7ESx/H
 EsDrQS59SWcKZ/phIpyRIu2wKxZT0HmbANLnJ/HOVC2Jg5y3RZS7sfznG4zgAMGbYlMZaA9ct3Q
 /l916p88+eDX+Mj2cFGw/g5Cmyf+kMqN0ShW0gM49cesY6p46f+ZzjmNJ1pnfN+aupR61v8ejiX
 ZCx/p7i4YWgvrSobo72d8cyqwkjhUwDnFZ1Hpz7Qrg5eZ7j6TYfjsj7RX508XSa9IQ1kkcS6ztW
 M7wTmO+CyC9AWzK23EU+dL23MHMAef6cbfz3R8MU3kD3rAhlIvQKvweUw9RLAT2TSeB/pzVm1Gy
 HnYwytty0+vYL0s07pgZsG/vqxioz3IxVMZ9PJ1r9I+3yCTWDDPONtPRekvFljCwnVN1w3cwaka
 329h3t0g9m48iAM5keK7K6sknjS2IaDizGFbl7sFOg8yNkrOG6rDkQTm6+Dpk3F6a05b22eF7eq
 6xo6v/hqGe47Kyc9S8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220095
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

On 1/22/26 02:04, Richard Henderson wrote:
> On 1/22/26 09:12, Ilya Leoshkevich wrote:
>> +static bool float128_is_int(float128 x)
>> +{
>> +    return extract64(x.high, 0, 48) == 0 && x.low == 0;
>> +}
>
> This isn't testing for integer, it's testing for 1.0eNN,
> i.e. a power of two.

Whoops. Not sure what I was thinking here.


>> +        /* Compute precise quotient 
>> */                                         \
>> +        a128 = floatN ## _to_float128(a, 
>> &env->fpu_status);                    \
>> +        b128 = floatN ## _to_float128(b, 
>> &env->fpu_status);                    \
>> +        q128 = float128_div(a128, b128, 
>> &env->fpu_status);                     \
>> + \
>> +        /* Final or partial case? 
>> */                                           \
>> +        is_q128_smallish = float128_get_exp(q128) < 
>> p;                         \
>> +        is_final = is_q128_smallish || 
>> float128_is_int(q128);                  \
>
> The language from the manual,
>
> # If the precise quotient is not an integer and the two
> # integers closest to this precise quotient cannot both
> # be represented exactly in the precision of the quotient ...
>
> does not appear to be what you are computing here.
> Certainly none of this relates to "precision of the quotient".

I was rather following the tables, I think they are more precise w.r.t. 
what needs to be checked.

float128_is_int(q128) was supposed to replace the r=0 check, but it's 
probably unnecessary here altogether, because if the division result is 
precise, it doesn't matter which way we round. And I'm explicitly 
checking for r=0 in other places.


> I would imagine that all of this would be easier to accomplish if you 
> did this in fpu/ with FloatParts instead of continually swapping in 
> and out of float128.

That sounds good, I think I will also be able to reuse pick_nan and 
simplify exponent manipulations then. I will give it a try.


> r~ 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4BDEB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpug9-00024k-U2; Tue, 10 Feb 2026 15:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpug8-00024U-Ey; Tue, 10 Feb 2026 15:49:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vpug6-00067C-JA; Tue, 10 Feb 2026 15:49:48 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AA748g247099; Tue, 10 Feb 2026 20:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R7NrY/
 YZVWL2rcwAUKnV+9oAtUb1PPOmbjw8g5oj2xY=; b=Xsve+GIyUtWEYdGDnRY7HZ
 FvmRPJh6N/7YKw+8An2NdBimheyrlCAV7fqlBkciLA66EFzXfsMsuefDBO61ZslQ
 3ToZXOTKRJCFrNa1h+TTublEojTINCdOBJO8QT7nznTTElZl3PTpce09uEI9lerD
 fykb1EROkr8RQSNDEKK9g5gwFbnz/51cD9sv97Sm6bzExSs+Zbq2B1izqOtTO04F
 M5OWQW//GI/TUp9tnzGDGqDd6GFXjTnWrPWCxp6gWM3RMayu+BkDLCVRX6xOR/Zl
 JiQ/JLMbTpFYAjCVDRa64dZWZ7yMYo+jSSRe/zUgIkbydzkP/3y9Je6KNRK3X95A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uv262-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 20:49:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AJACe9019246;
 Tue, 10 Feb 2026 20:49:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk2wg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 20:49:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AKncR930212748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 20:49:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A68EB20043;
 Tue, 10 Feb 2026 20:49:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3092320040;
 Tue, 10 Feb 2026 20:49:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.60.229])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 20:49:38 +0000 (GMT)
Message-ID: <0932b116-560e-4afc-a379-4478eec9c89c@linux.ibm.com>
Date: Tue, 10 Feb 2026 21:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] target/s390x: Implement DIVIDE TO INTEGER
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260204121026.645382-1-iii@linux.ibm.com>
 <627c19b8-54d8-4616-bc87-99b8d0de43a6@redhat.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <627c19b8-54d8-4616-bc87-99b8d0de43a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3MiBTYWx0ZWRfX0nxh/rT0HHoF
 SsAqcz9ZbIERI7r6Wsz65s9N/IJOIlfc7yAoF4PSHFs3h1n7qy+C83nuHf+16cHtfmRkTzCJO/S
 At8RFqiIXyYkgvYxAjeSgc+imRQNKkVgfzEPbG7wzDqtugyKMDYa/zsACxdjyh8mo12KyiTRxR4
 J20V+8jBVPxvQuoRfG8cAni86HICO8RXn7GlGdK7gkpZKsFY3j2YK9gkGmy4BSiNKqKXOPCyjVX
 G5hjV/TtiWaSHJGa5qGmmh3jwDV03t8hGC9yWjVzTQNtIVqqDG2MvGFNcfrdso6rnvV+BmZe98v
 6sKp/aaHIofrX3yNUZ+hfvboLriocuQIt2H3JNOo2qI92/l7z6BmPICX7FmMV1i8wyZLe/6HdY5
 r7GkqRouNTVrEy/A97cUjQw4HjrpfbwiTyaGVXQAc0iV/a4nOdxDVieyIl5RiuDkqKxDVYZa+2O
 wLt2BiS0AkIlFC6kg6g==
X-Proofpoint-ORIG-GUID: lQyPUGlLYrHeUaekzIglh1CYx3hjHRtd
X-Proofpoint-GUID: lQyPUGlLYrHeUaekzIglh1CYx3hjHRtd
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698b99e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=eD6F2Rh3CjCF0Esbhl8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100172
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 2/10/26 14:27, Thomas Huth wrote:
> On 04/02/2026 13.07, Ilya Leoshkevich wrote:
>> v3: 
>> https://lore.kernel.org/qemu-devel/20260129190902.196262-1-iii@linux.ibm.com/
>> v3 -> v4: Use parts_round_to_int_normal() (Richard).
>>            Drop saved_flags.
>>            Collect R-bs (Thomas, Richard).
>>
>> v2: 
>> https://lore.kernel.org/qemu-devel/20260127153736.62730-1-iii@linux.ibm.com/
>> v2 -> v3: Use FloatParts64 (Richard).
>>            Improve "smallish" comment (Richard).
>>            Use parts_muladd_scalbn (Richard).
>>            Get rid of manual precision rounding (Richard).
>>            New patch: parts_round_to_int_normal() improvement.
>>            New 64-bit testcase for a fuzzer finding on one of the
>>            intermediate versions. I have to admit I did not put down and
>>            then forgot what exactly it was about, but it must be
>>            interesting, so I decided to keep it.
>>
>> v1: 
>> https://lore.kernel.org/qemu-devel/20260121222116.713325-1-iii@linux.ibm.com/
>> v1 -> v2: Move the implementatation to fpu/ and rewrite using
>>            FloatParts (Richard). I can't say I particularly like the way
>>            it looks, but at least most macros are gone and it survives
>>            fuzzing.
>>            Explain why we need -O0 for the test (Alex).
>>            New patch: s390_get_bfp_rounding_mode().
>>            Add a few comments with calculation examples to the test.
>>
>> Hi,
>>
>> This series implements DIVIDE TO INTEGER instruction, which is
>> required to run LuaJIT.
>>
>> Patch 1 is a debugging helper, patch 2 is a small refactoring, patch 3
>> is an improvement for an FPU rounding helper, patch 4 is the
>> implementation.
>>
>> Since the instruction is quite complex, I've extensively tested it
>> using a libFuzzer-based harness [1] that compares emulation with native
>> execution at ~15k exec/s. The tests (patch 5) use data generated
>> this way.
>>
>> Best regards,
>> Ilya
>>
>> [1] https://gitlab.com/iii-i/qemu/-/tags/iii/wip/fuzz-tcg/v2
>>
>> Ilya Leoshkevich (5):
>>    target/s390x: Dump Floating-Point-Control Register
>>    target/s390x: Extract s390_get_bfp_rounding_mode()
>>    fpu: Restrict parts_round_to_int_normal to target precision
>>    target/s390x: Implement DIVIDE TO INTEGER
>>    tests/tcg/s390x: Test DIVIDE TO INTEGER
>>
>>   fpu/softfloat-parts.c.inc           |   7 +-
>>   fpu/softfloat.c                     | 142 +++++++++++++++
>
>  Hi Ilya,
>
> I'm sorry, but this seems to trigger a failure in the CI (when 
> undefined behaviour sanitizers are enabled):
>
>  https://gitlab.com/thuth/qemu/-/jobs/13055886506
>
> Could you please have a look?
>
>  Thanks,
>   Thomas
>

Thanks for the report!

Apparently I should not have removed "& 63" in 3/5.

For FloatParts64 it's a no-op.

For FloatParts128 it's a no-op, unless rounding is in the low word, and 
that's what the sanitizer has flagged.

For example, if N == 128, exp == 128, frac_size == 126, the value is 
already an integer (exp >= frac_size), but we still want to zero out the 
last bit.

So frac_lsb needs to be DECOMPOSED_IMPLICIT_BIT >> (126 & 63).

"& 63" converts the true bit offset to the bit offset within frac_lo.

I will restore it.



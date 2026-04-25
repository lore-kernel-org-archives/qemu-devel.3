Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1E6FF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 11:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGbK2-0002zu-RQ; Sat, 25 Apr 2026 07:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wGbJm-0002z9-33; Sat, 25 Apr 2026 07:37:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wGbJj-0003A1-QE; Sat, 25 Apr 2026 07:37:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P9vtxN2911456; Sat, 25 Apr 2026 11:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pjTvNP
 if4KgmL+OkOT7lk8Yh4hQL082IyZ4H5HIUJFU=; b=ePAQg5/tC7IGLSqnPeRKO3
 Q8IWydvDr9MncKTYWI8Eg+Wp60GHLRJ7c5iMhYqGeHaG+FUTCNALm7dFcYQxJGBe
 fg19w8f37OqOzH2c/JnQagsKiARuR4Xxz+BInJzFUbPl4VLG4ygffybsErMYYIcC
 ub2i9kthh+K01PxhPEOK00WstE4iNfU363UR2+mnx4crDKTP/i+QUA3LvSupZLi4
 9tVwgtqhN3KlG/pLt818lkhvUCPKSkQnNEqAKurlWtSlq6+IJIwxn3mGuuH/Wj2x
 AupTCgUbVj6PF45oU1W5D+f1j2QRKAeX3SY8mFvEUOSAaoJGbBmHaKe+qt9jcQDg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9qs5ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Apr 2026 11:36:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63PBO6kw006542;
 Sat, 25 Apr 2026 11:36:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4drmabh8mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Apr 2026 11:36:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63PBagQV41615618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Apr 2026 11:36:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC4DF20043;
 Sat, 25 Apr 2026 11:36:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5219E20040;
 Sat, 25 Apr 2026 11:36:42 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.136.63])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 25 Apr 2026 11:36:42 +0000 (GMT)
Message-ID: <ebef14ea-106f-431a-940b-354cd14a28b6@linux.ibm.com>
Date: Sat, 25 Apr 2026 13:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: Leverage 128-bit vector type in V{L,
 ST}L opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20260424104325.81484-1-philmd@linaro.org>
 <56bfecd4-6169-4512-b019-2c9d6367525e@linux.ibm.com>
 <fccd4e70-0e0e-468e-a11a-cc120c81e4bd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <fccd4e70-0e0e-468e-a11a-cc120c81e4bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2T-XlAE-V-rE_t3H0MG3MCzSys2oLuh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDExMyBTYWx0ZWRfX37lXEggRR+6b
 SvmeqZzyRsDJB0vFaspqrQK4l6bYiorg3ysOTQl70LEiEBfjyFWHYMNImamZEsEQQGDKb7AwZOD
 jrXvP109c7aSmfPnNQR9AkBhyx7/0i9RQqsBVmrkng/Scd2fWmgyM9MqNJl8LcqvbW683ISnBUe
 cGiaggaLB9oYLRvpwt3rrLbT4bamWE29kA8jZyIK/VT0YKRdfUl/tIi+12y8takvP66V066EjdJ
 LE9/eGir7dReXhbWOWje54+mPTsis53kdCXI9CXBVqLdr97FdEDZyhQ9rIr/tNs+o7i53nLyevV
 H7oH4Nt0xWEbZ3UmGxSXYplI0Ag7z3/WOfDJEWyExYDTbmB3XjjfPgY/SmOH32B00I8QlSr0yhm
 5gEPO48Mo7lyAX4duxhouCMzxE4ae88nkNb0vihvvgM6T3COuxmF/tKvOuQiTXRzFIU7QyUziet
 b7bccylPZ9gTBxtnH8Q==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69eca750 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=gbpRu0Ca7s765whaVOgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2T-XlAE-V-rE_t3H0MG3MCzSys2oLuh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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


On 4/25/26 11:09, Philippe Mathieu-Daudé wrote:
> On 25/4/26 00:05, Ilya Leoshkevich wrote:
>>
>> On 4/24/26 11:43, Philippe Mathieu-Daudé wrote:
>>> The access is unaligned (MO_UNALN), we can easily replace the 2
>>> consecutive 64-bit calls by a single 128-bit one.
>>> Considering atomicity of the new 128-bit access, the both opcodes
>>> VLL (Vector Load with Length) and VSTL (Vector STore with Length)
>>> access byte granularity, so use MO_ATOM_NONE.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> Based-on: <20260423135035.50126-1-philmd@linaro.org>
>>>
>>> v3:
>>> - do not increase addr (Ilya)
>>> - MO_ATOM_NONE (Richard)
>>> ---
>>>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>>>   target/s390x/tcg/vec_helper.c | 17 ++++++-----------
>>>   2 files changed, 18 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/s390x/tcg/vec.h b/target/s390x/tcg/vec.h
>>> index 8d095efcfc6..34413f7e029 100644
>>> --- a/target/s390x/tcg/vec.h
>>> +++ b/target/s390x/tcg/vec.h
>>> @@ -13,8 +13,10 @@
>>>   #define S390X_VEC_H
>>>   #include "tcg/tcg.h"
>>> +#include "qemu/int128.h"
>>>   typedef union S390Vector {
>>> +    Int128 quadword;
>>>       uint64_t doubleword[2];
>>>       uint32_t word[4];
>>>       uint16_t halfword[8];
>>> @@ -72,6 +74,11 @@ static inline uint64_t 
>>> s390_vec_read_element64(const S390Vector *v, uint8_t enr)
>>>       return v->doubleword[enr];
>>>   }
>>> +static inline Int128 s390_vec_read_element128(const S390Vector *v)
>>> +{
>>> +    return v->quadword;
>>> +}
>>> +
>>>   static inline uint64_t s390_vec_read_element(const S390Vector *v, 
>>> uint8_t enr,
>>>                                                uint8_t es)
>>>   {
>>> @@ -117,6 +124,11 @@ static inline void 
>>> s390_vec_write_element64(S390Vector *v, uint8_t enr,
>>>       v->doubleword[enr] = data;
>>>   }
>>> +static inline void s390_vec_write_element128(S390Vector *v, Int128 
>>> data)
>>> +{
>>> +    v->quadword = data;
>>> +}
>>> +
>>>   static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
>>>                                             uint8_t es, uint64_t data)
>>>   {
>>> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/ 
>>> vec_helper.c
>>> index 98eecd9fde6..a86819f61b6 100644
>>> --- a/target/s390x/tcg/vec_helper.c
>>> +++ b/target/s390x/tcg/vec_helper.c
>>> @@ -48,14 +48,11 @@ void HELPER(vll)(CPUS390XState *env, void *v1, 
>>> uint64_t addr, uint64_t bytes)
>>>       MemOpIdx oi;
>>>       if (likely(bytes >= 16)) {
>>> -        uint64_t t0, t1;
>>> +        Int128 t;
>>> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>>> -        t0 = cpu_ldq_mmu(env, addr, oi, ra);
>>> -        addr = wrap_address(env, addr + 8);
>>> -        t1 = cpu_ldq_mmu(env, addr, oi, ra);
>>> -        s390_vec_write_element64(v1, 0, t0);
>>> -        s390_vec_write_element64(v1, 1, t1);
>>> +        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | 
>>> MO_BE, mmu_idx);
>>> +        t = cpu_ld16_mmu(env, addr, oi, ra);
>>> +        s390_vec_write_element128(v1, t);
>>>       } else {
>>>           S390Vector tmp = {};
>>> @@ -206,10 +203,8 @@ void HELPER(vstl)(CPUS390XState *env, const 
>>> void *v1, uint64_t addr,
>>>       probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>>>       if (likely(bytes >= 16)) {
>>> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>>> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, 
>>> ra);
>>> -        addr = wrap_address(env, addr + 8);
>>> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, 
>>> ra);
>>> +        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | 
>>> MO_BE, mmu_idx);
>>> +        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
>>>       } else {
>>>           oi = make_memop_idx(MO_8, mmu_idx);
>>
>>
>> In general LGTM, but I just tried this on top of 
>> 20260423135035.50126-1- philmd@linaro.org and I'm consistently getting:
>>
>>
>> make[2]: *** [Makefile:236: run-precise-smc-softmmu] Error 1
>>
>>
>> The test uses VSTL, so it's definitely related.
>
> Is this on a big-endian host? (Asking because this is the single
> configuration I didn't tested)


No, that's my x86_64 laptop.

Configure flags: '--target-list=s390x-linux-user,s390x-softmmu' 
'--disable-docs'



$ git log -1
commit 2fc3bdf329c54489438408161ebc907a6fa62329 (HEAD)
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Fri Apr 24 12:43:25 2026 +0200

     target/s390x: Leverage 128-bit vector type in V{L, ST}L opcodes


$ uname -a && make -j24 && make -j24 check-tcg ; echo $?
Linux heavy 6.19.10-100.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 25 
17:18:37 UTC 2026 x86_64 GNU/Linux

[...]

make[2]: *** [Makefile:236: run-precise-smc-softmmu] Error 1


$ git revert HEAD

$ uname -a && make -j24 && make -j24 check-tcg ; echo $?
[...]

0



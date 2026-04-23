Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B01FC035F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwBR-0004RP-U9; Thu, 23 Apr 2026 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFwBH-0004Qj-Fk; Thu, 23 Apr 2026 11:41:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFwBF-0004bd-Fv; Thu, 23 Apr 2026 11:41:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N6UOda3514977; Thu, 23 Apr 2026 15:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=z8XXMi
 t4NNbD+5Sh1l3oirBzG+cZBXiYSSAnflZfxZo=; b=hfEtPCkKTtcdhmn0Kn5vxJ
 ocKs1BLZAs7EL1ke8+BYWOmvfLYdO+ypSgTiXlT4tYTfwpIL4hY1eUkpmWsh8kzR
 +xjp+BlJk/ySYreaLm/0a75FORNxEqhhrhuG4AGGvlYJiOwPQbArtgiVwxmq2TA4
 yXZI4N1yNmJ/EjYO+EFvs5yna1dBiX4QkPTfwFc/p0pN3RgEp0mjqGTJmsTqipqo
 eD9qxL7Eq9bX+xRbxQ2HEQsZAkn7n5CUG+bN+hOB8vLmkogevGSG2aZvNLpcyTep
 g0Lod8GYuiQaAl2/eQUT8gHWP7iSYaG4H54ykfjlAUHSH4/qWroVmo5uUW/N8EAA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu29fgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:41:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NFZSqX031959;
 Thu, 23 Apr 2026 15:41:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyf6ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NFfKkV25100652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:41:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31F712004D;
 Thu, 23 Apr 2026 15:41:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCDED20043;
 Thu, 23 Apr 2026 15:41:19 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:41:19 +0000 (GMT)
Message-ID: <986c02ec-4e43-41c9-b520-7c5a41ca4109@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: Leverage 128-bit vector type in VLL /
 VSTL opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20260423141538.51583-1-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423141538.51583-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MyBTYWx0ZWRfX+kyfrB/jsv/S
 ZwtoQLXz/sDTfG+NHxG8QkcB7YPnXLT/6sVb7ZlHjrzi+VMUXel9/TaKIA3QauZIlt8YnUJoHgg
 5F3WN2Tba8DD/9P6tiM/bR2kroHiYe+HdyijY8sk3ixWjRa1YteCzo0V2qTa+DSiE10BEXFBAP4
 BiYkEaOpyV/y3P4o79ajfgCW277IoGDtkmrm0DhZ1VG3cnlbO3eIG2iZDAufaJVLXO2IY++A134
 sfg/5n61pLgU7S5jjAh8dDwzzMpeNIB5V8SJ1uW0wmAH/L0CmhSpJbKYm7CkFGcHiORzF1P+Gbw
 rxAgl1ORp7lQAO9G55aF7h+nVWlRiPV7ERozxTtYqjeFw82jg8v2sgTi2TIiuCUKegPvSD5ks7F
 /Thswvsfc5WMPUdIlyC/z95pvgc4H1zI/XxAj3I7Pe8I8rD/2xzfqX/jO0eykLSihTKswl4iBhq
 d8F/PyK1f4iUpUuERtg==
X-Proofpoint-ORIG-GUID: E2ICGwY0wyS8sPlYn5krDIolSMgnlJ-u
X-Proofpoint-GUID: E2ICGwY0wyS8sPlYn5krDIolSMgnlJ-u
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea3da5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=aKWiiJWHmIpsBlU-QCkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230153
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


On 4/23/26 15:15, Philippe Mathieu-Daudé wrote:
> The access is unaligned, we can easily replace the 2
> consecutive 64-bit calls by a single 128-bit one.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20260423135035.50126-1-philmd@linaro.org>
> ---
>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>   target/s390x/tcg/vec_helper.c | 19 ++++++++-----------
>   2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/target/s390x/tcg/vec.h b/target/s390x/tcg/vec.h
> index 8d095efcfc6..34413f7e029 100644
> --- a/target/s390x/tcg/vec.h
> +++ b/target/s390x/tcg/vec.h
> @@ -13,8 +13,10 @@
>   #define S390X_VEC_H
>   
>   #include "tcg/tcg.h"
> +#include "qemu/int128.h"
>   
>   typedef union S390Vector {
> +    Int128 quadword;
>       uint64_t doubleword[2];
>       uint32_t word[4];
>       uint16_t halfword[8];
> @@ -72,6 +74,11 @@ static inline uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr)
>       return v->doubleword[enr];
>   }
>   
> +static inline Int128 s390_vec_read_element128(const S390Vector *v)
> +{
> +    return v->quadword;
> +}
> +
>   static inline uint64_t s390_vec_read_element(const S390Vector *v, uint8_t enr,
>                                                uint8_t es)
>   {
> @@ -117,6 +124,11 @@ static inline void s390_vec_write_element64(S390Vector *v, uint8_t enr,
>       v->doubleword[enr] = data;
>   }
>   
> +static inline void s390_vec_write_element128(S390Vector *v, Int128 data)
> +{
> +    v->quadword = data;
> +}
> +
>   static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
>                                             uint8_t es, uint64_t data)
>   {
> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
> index 98eecd9fde6..feb99f51c78 100644
> --- a/target/s390x/tcg/vec_helper.c
> +++ b/target/s390x/tcg/vec_helper.c
> @@ -48,14 +48,12 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
>       MemOpIdx oi;
>   
>       if (likely(bytes >= 16)) {
> -        uint64_t t0, t1;
> +        Int128 t;
>   
> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
> -        t0 = cpu_ldq_mmu(env, addr, oi, ra);
> -        addr = wrap_address(env, addr + 8);
> -        t1 = cpu_ldq_mmu(env, addr, oi, ra);
> -        s390_vec_write_element64(v1, 0, t0);
> -        s390_vec_write_element64(v1, 1, t1);
> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
> +        addr = wrap_address(env, addr + 16);

I don't think we need to increment the address before loading from it.

We used to have +8, because it's the offset of the 2nd half.

> +        t = cpu_ld16_mmu(env, addr, oi, ra);
> +        s390_vec_write_element128(v1, t);
>       } else {
>           S390Vector tmp = {};
>   
> @@ -206,10 +204,9 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
>       probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>   
>       if (likely(bytes >= 16)) {
> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
> -        addr = wrap_address(env, addr + 8);
> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
> +        addr = wrap_address(env, addr + 16);

Same.

> +        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
>       } else {
>           oi = make_memop_idx(MO_8, mmu_idx);
>   


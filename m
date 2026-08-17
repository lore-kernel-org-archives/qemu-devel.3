Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE28C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvypS-0000JM-26; Mon, 17 Aug 2026 11:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvypQ-0000J8-7J; Mon, 17 Aug 2026 11:00:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvypO-0005NS-DI; Mon, 17 Aug 2026 11:00:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HCWAHE1442520; Mon, 17 Aug 2026 15:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IKQciY
 rla5Ea0uXA8c1UP5ZgqwXFKBbn67hUafFOzGU=; b=JQajeBvbmFdb4LyTHc7RB+
 ASZSW3kg2JPN8FSZqFrAry8Wecom4LGQOF6/bpRJF87qpOrLjORF5m8TbYuRWIha
 lDDO0j8xuYeCMfUTUfGqBWvWAQpGSuYk7pyjU+vqMhobDdn4zaq6NcmlBsQKHgJ8
 GUM7vo+kThxXbXOJeIH4uV+pR4mvZBAUG+91kTYH3Db58hIL3CEagnPf+f4Qkurd
 Rt9FnLHXxoUdZYCte0NsNS7ZFq7EWmoL2UsNf+bELem3xdlpqcL5fb6iO/4BkeUh
 NEwyolbZWH6qPbwiIebUOW8O+eNUNz/JDw/dirWQpEcSNPeIj6TRnz3vgXRgJDGQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt2f56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:00:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HEuPcX023814;
 Mon, 17 Aug 2026 15:00:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng6996-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:00:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HF0WlH31392414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:00:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D73B420043;
 Mon, 17 Aug 2026 15:00:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5AC2004B;
 Mon, 17 Aug 2026 15:00:32 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:00:32 +0000 (GMT)
Message-ID: <145b0ed2-8b3b-48d5-97a7-a5addcdf6481@linux.ibm.com>
Date: Mon, 17 Aug 2026 17:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/19] target/s390x: Support AES ECB for cpacf km
 instruction
To: freude@linux.ibm.com
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
 <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
 <192e2ce59d17947e5556dc54e3b3c781@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <192e2ce59d17947e5556dc54e3b3c781@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a832216 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=rjDp5FNg0uedgkTvRfYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX9HkS7lSz/ddd
 Oh3GbI3ZMyMvJyzJyMUQQE9ouw73D9wn2+WGFCxzGDyinDvrEsEXgRQks8y6FI6P/cso69QTk1P
 rSnApBAx6PukbXxhaadkcPk6a/BzsLo=
X-Proofpoint-GUID: 2qfFGNif23F_dWGLRqtHGX4OjCRPlWbk
X-Proofpoint-ORIG-GUID: 2qfFGNif23F_dWGLRqtHGX4OjCRPlWbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfXz3nGyRtvpmtA
 4Jb+jePxuY9shvqK4aqZApKpjaQxNzC1zAxpeQtFtPUt7OB8gaGuqjpGva8qvOioGAlREQOZkpe
 L35jgvPuW0e2a/GNgsR3FsvzAygZnCV+IHRxLqa8OigYaD1H8PMMFcG0/Ggrlwn20xeEt1SwuxO
 DKlYhKIdogTMCkO4qvIR38M+SkHnuar7G5ZETqHKLF+MgTxe9st2pDbkfbgtPAB/3Xz/Cegcm2O
 3SnzUh2+Wqig9n5GPJi7oQ0QCoynkdigVrBaSkmhXn1jTRSA57/NEJy8SOWJEtuV97GmjAbqETD
 343seJTaa9ZCI1z1t3hUuC599nU23cSuv0oBxTG2D+/+Zej0GLfZdJxje5pTl2D8EwAO7jFYClQ
 ff0KI4lcJ7GYmnWNe2BsZaLJ9CVt/XgrIzVbFOhxogdapkEQy3kSWhXuckj5DFBjva8pNHmYsww
 l6Ifvu/I9wzEkNVkr6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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



On 8/17/26 16:23, Harald Freudenberger wrote:
> On 2026-08-17 11:17, Ilya Leoshkevich wrote:
>> On 8/6/26 17:12, Harald Freudenberger wrote:
>>> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
>>> and CPACF_KM_AES_256 for the cpacf km instruction.
>>>
>>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>   target/s390x/gen-features.c      |   3 +
>>>   target/s390x/tcg/cpacf.h         |   6 ++
>>>   target/s390x/tcg/cpacf_aes.c     | 107 +++++++++++++++++++++++++++++++
>>>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>>>   target/s390x/tcg/meson.build     |   1 +
>>>   5 files changed, 141 insertions(+)
>>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>>
>> [...]
>>
>>> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>>> +{
>>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>> +    uint64_t len = *src_len_reg, done = 0;
>>> +    int i, keysize, addr_reg_size = 64;
>>> +    uint8_t key[32];
>>> +    AES_KEY exkey;
>>> +
>>> +    g_assert(type == S390_FEAT_TYPE_KM);
>>> +    switch (fc) {
>>> +    case CPACF_KM_AES_128:
>>> +        keysize = 16;
>>> +        break;
>>> +    case CPACF_KM_AES_192:
>>> +        keysize = 24;
>>> +        break;
>>> +    case CPACF_KM_AES_256:
>>> +        keysize = 32;
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>>> +        len = (uint32_t)len;
>>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>>> +    }
>>
>> Just noticed something, here and in all other patches. POp says:
>>
>>
>> In the 24-bit addressing mode, the contents of bit
>> positions 40-63 of general registers R1 and R2 consti-
>> tute the addresses of the first and second operands,
>> respectively, and the contents of bit positions 0-39
>> are ignored; bits 40-63 of the updated addresses
>> replace the corresponding bits in general registers R1
>> and R2, carries out of bit position 40 of the updated
>> address are ignored, and the contents of bit positions
>> 32-39 of general registers R1 and R 2 are set to zeros.
>>
>>
>> Seems like we are not zeroing out bits 32-39?
>>
> 
> Do we support 24 bit mode? Isn't that ditched some years ago?
> At least we definitely do not support s390 kernel in 24 bit mode.
> Maybe userspace is valid.

No, userspace doesn't support it either.
So neither qemu-user nor qemu-system + Linux will need it.
Some weird non-Linux setup might, I'm not sure if we want to go out of
our way to support them. I think we should either drop it or
implement it correctly.

[...]


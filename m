Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F6wfGBr2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKdHcI5f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKeTl-0007GH-6u; Sat, 24 Oct 2026 12:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKeTj-0007Fn-Af
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:20:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKeTh-00019D-GL
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:20:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF05e62450734
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cUBguUvf9t5D9sMezVSs+aK1PbeS//Hx+G7t5izZdso=; b=F6wfGBr2ywUxv7XY
 9c3aEk4kcTOnWv8bABs/DkeWK2hSfw9o5MNeS9CDP3DrL8wXHeUtgONab411aSfJ
 56simPjgp0Mh08JFzqkt7DsYM/xUzzpcfU4d6dn/jcpSmcdkAd266i3V9Ceo9LKt
 ZsdcAJWxURhqWw1EBlPcEmIWVXTpoCi6tt3Jh4zv0unMp1VPcBXzwDDC/5CicKJ6
 B4eEGrZ3LWGXzdBRovKPTU7y31K0BSWWhju3oJmcyRkHkbdPYwA6UuLG1NHQ6MNI
 xL6wR2ZTgd604JRkAqEIjOpMTXNfK/9O0yRtnQYEO6A7L/bb4HYWNrmiLIdgJnWX
 Kb8svQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xhch6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:20:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso377644285a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792858813; x=1793463613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUBguUvf9t5D9sMezVSs+aK1PbeS//Hx+G7t5izZdso=;
 b=WKdHcI5fBDeTwxaM/BhCwloqPihnYUX4lC1DhRUYqnx6ZV3gUAbvxlGbqy31FAH3ds
 9fbAz+6liqAk3GBAZhJYvgkkTCFAKeOS4UQIR637w0mLHGgSow2ghIY8MZiAp2l0acuE
 Ja53JMKpmyFRR3W8Bx8Nia+RnmwSLUfzjaDRP3NMJ+CuKUredszB7rstmMWWy5VDOCNr
 c+2tqDRWBf2PZcsOJpj3k2qcM6tn22tQYTTDTeyDbpYu70DQqoiTvY3Kn+b1YqodGiEx
 IyVeWnVaiwjkmOY6MPhR4FsykQVopoRd9AwaBC94AaVi77odeIuce7iaceiEBYjJMDnf
 FKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792858813; x=1793463613;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUBguUvf9t5D9sMezVSs+aK1PbeS//Hx+G7t5izZdso=;
 b=Cfljlygm7KpbA2SUIJzYnC3kF0Kn0SreohxODnSCPkvBaNxH7vY8/TZ++Elfs7bnNI
 Hg9rRQrwI/bxCnMWm6lVe6RHsxhGTVFauZ/uDiIF+tFLz7NnFnNvyGw+Ila4NMkp3wFN
 cTMvaNk9UytAeDg8Qq3/hgNiwoF5T9/WfAZcw5OHi1edfj5Q1iQBcQ1zc2OVWrdMvEg4
 45NuIcbIU/eZmDpAebUZycCf48YISp/ShfKVlBawX0GkOtCsjzTC24eDMun5TIrsKFcg
 +VtnzBK1dwhu82jgK+UGyQKhsbhtpwX4RVcETGKm7qxZW8Pe7fwxbq9bZQjJsQ66Xggk
 /HAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByr9zT9shzK4Gz3H3lgPGFHss/dINrZRnk6tVXOahVeLQQ2j0hmanu4JCK92LOs0YnTN5f0uzCOWSuv@nongnu.org
X-Gm-Message-State: AFq9FYLF3AQZRg5ty6m1kW366G1ZtPmrUU1Upw2ey/reZlnma5a94CN1
 l9iqrG6x+08YwJXbaguXOWWFmSSv6tXqi3gEAjSXFgIfYFh2tpjLkQbd+SfxkSLZwQXgJu0/Xfv
 /kPZZBORjuamD4XVvtSiOB5IwktSfYlaufPfh1w8ku2kwNTFqdnmY3hxD0w==
X-Gm-Gg: AYBFou2kxN90zv0I2yrBIYX1yzrQZh1nHTWko/R5ViWAy4lnE6zoCu5PGzVuhOb6Cp8
 oMpBh7OGCCstEyfBSpmOCxQPyiQzbPfuGML0Xh0bTgnh4FbEKjob6/9UCxerzXgJpSz4DFVSad7
 rSYZv3AQZ13eb8SHaWGIvuR/RIZGShBry8Rvelnv4yvxB2vfUzCkSheyITxajFAtVjSVOEP2WZg
 COd5rB5GrDKa7r1fL14cP5FXZGS4ft2YEY0Lai4vATz9TsiR4P0A3qk6h03b2lyU84z6ZpxM2nY
 MHjXCRFUIMcbOMTZkl+7OWudEAe3kP3rUNaFNQPNEGRMSp6CnJmSBO4MTGx44OXbMeBgirV7kf9
 CY5tPvjGsK+FhvgCadXgzr8/FwWcIDPA2Hw==
X-Received: by 2002:a05:620a:8390:b0:93b:be6d:4f3e with SMTP id
 af79cd13be357-940ef913ca6mr390779085a.25.1792858812837; 
 Sat, 24 Oct 2026 09:20:12 -0700 (PDT)
X-Received: by 2002:a05:620a:8390:b0:93b:be6d:4f3e with SMTP id
 af79cd13be357-940ef913ca6mr390776385a.25.1792858812375; 
 Sat, 24 Oct 2026 09:20:12 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm120348295e9.0.2026.10.24.09.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 09:20:11 -0700 (PDT)
Message-ID: <bab62a66-6380-4ab5-93b1-c9d287d69068@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 18:20:10 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] hw/timer: add TriCore System Timer Module (STM)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Saravanan Sekar <saravanan@linumiz.com>,
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>,
 Christoph Seitz <christoph.seitz@infineon.com>,
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
 <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-5-c722e4ca5661@linumiz.com>
 <52174128-738d-470a-91e3-f3182b67bd55@oss.qualcomm.com>
In-Reply-To: <52174128-738d-470a-91e3-f3182b67bd55@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tAuoWp1u-9JlTQN12iiS_wqwDqvC_YZ3
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adcdabd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bUQKSiCPAAAA:8 a=vU9dKmh3AAAA:8 a=LvI82zEhTVW9_sGVEvIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=-fHZXUhsFbuwFN3fwQAr:22
 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX5bQkgRTDH53S
 NwvpJSSbyCvYsVE0DP6qXUkzCA/UzE3vbzIfsdeiIjdsI5bPx/buR8BRqzTOxbQAQCbsN6REAtz
 pTWIEf5NWkY8/9nh1XQcGg3nWfeRU9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXy8tuV15ndeqQ
 b0eAfBiEY6ei4w9XMrAtA3U0aaiKQuD5dOOEZ3WxHQbKKahk2Dn2jS6Kv6K5IYefgEGt12D14+M
 /rSXk7q2WUNVcxV5Ti2EqGHPV836v5sWSYpNQmTJ898fnO64jR2ShAKVUizSanmjdYMPfcxIeS8
 lRP8EF3U8eLDG/ra5jc05v9KQHD9HtDoy6j7fsU9lALkPMdpnldd/pGceZ3v6ndrhotPlOIp6Fn
 bYQlkyMHzNrmjAjEtLC6p4N+jVdRT80cDRU/teKrSVC1choJuEbfByr3ucwNpm44UXCShLC7gEx
 6mAmmeDb0p7Vpph+NnvgyGcxVNcA3OQi3IOPX1nlQM50H2ciVdXD6Z99+2uSbaO0lr0qgQHyQ+/
 quJ73Q7a740vxzgk0Kr0xdGDsLBk1TOSEAQYkCHT1zKSPJ6Ae6ifFAJz62+Vd5u1o54gTn48OYO
 08Q7uJjm0EpGlEGPvLw==
X-Proofpoint-ORIG-GUID: tAuoWp1u-9JlTQN12iiS_wqwDqvC_YZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/10/26 13:17, Philippe Mathieu-DaudÃ© wrote:
> On 23/10/26 22:11, Parthiban Nallathambi wrote:
>> Free-running 64-bit counter with compare match interrupt.
>> TIM0..TIM6 give shifted views of the counter, CMP0 fires
>> when the masked counter matches the programmed value.
>>
>> Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>> ---
>>   MAINTAINERS                    |   2 +
>>   hw/timer/Kconfig               |   3 +
>>   hw/timer/meson.build           |   1 +
>>   hw/timer/tricore_stm.c         | 365 +++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   include/hw/timer/tricore_stm.h |  34 ++++
>>   5 files changed, 405 insertions(+)


>> +static void tricore_stm_write(void *opaque, hwaddr offset,
>> +                              uint64_t value, unsigned size)
>> +{
>> +    TriCoreSTMState *s = TRICORE_STM(opaque);
>> +    hwaddr reg_addr = offset >> 2;
>> +
>> +    switch (reg_addr) {
>> +    case R_CLC:
>> +    case R_ID:
>> +    case R_TIM0:
>> +    case R_TIM1:
>> +    case R_TIM2:
>> +    case R_TIM3:
>> +    case R_TIM4:
>> +    case R_TIM5:
>> +    case R_TIM6:
>> +    case R_CAP:
>> +        s->regs[reg_addr] = value;
> 
> Aren't these read-only?
> 
>> +        break;
>> +    case R_CMP0:
>> +        s->regs[reg_addr] = value;
>> +        tricore_stm_tim_update(s);
>> +        tricore_stm_timer_update(s);
>> +        break;
>> +    case R_CMP1:
>> +    case R_ICR:
>> +        s->regs[reg_addr] = value;
>> +        tricore_stm_timer_update(s);
>> +        break;
>> +    case R_CMCON:
>> +        s->regs[reg_addr] = value;
>> +        tricore_stm_tim_update(s);
>> +        tricore_stm_timer_update(s);
>> +        break;
>> +    case R_ISCR:
>> +        if (value & MASK_ISCR_CMP0IRR) {
>> +            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP0IR);
>> +        }
>> +        if (value & MASK_ISCR_CMP1IRR) {
>> +            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP1IR);
>> +        }
>> +        if (value & MASK_ISCR_CMP0IRS) {
>> +            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
>> +        }
>> +        if (value & MASK_ISCR_CMP1IRS) {
>> +            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP1IR);
>> +        }

Unless when MMIO regions set lockless_io, their handlers run with the
BQL taken, so no need for qatomics.

>> +        tricore_stm_timer_update(s);
>> +        break;
>> +    case R_TIM0SV:
>> +    case R_CAPSV:
>  > +    case R_OCS:> +    case R_KRSTCLR:
>> +    case R_KRST1:
>> +    case R_KRST0:
>> +    case R_ACCEN1:
>> +    case R_ACCEN0:
>> +        s->regs[reg_addr] = value;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "tricore_stm: write to unknown register 0x%"
>> +                      HWADDR_PRIx "\n", offset);
>> +        break;
>> +    }
>> +}

>> +static const MemoryRegionOps tricore_stm_ops = {
>> +    .read = tricore_stm_read,
>> +    .write = tricore_stm_write,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void tricore_stm_timer_hit(void *opaque)
>> +{
>> +    TriCoreSTMState *s = TRICORE_STM(opaque);
>> +
>> +    qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);

The QEMU_CLOCK_VIRTUAL timer runs from the main loop (with the BQL held)
so no need for qatomic.

>> +
>> +    if (s->regs[R_ICR] & MASK_ICR_CMP0EN) {
>> +        qemu_irq_pulse(s->irq);
> 
> I'm confused with the CMP1. If no need to model it, we should
> mention it and log the accesses as UNIMPLEMENTED.
> 
>> +    }
>> +
>> +    tricore_stm_tim_update(s);
>> +    tricore_stm_timer_update(s);
>> +}


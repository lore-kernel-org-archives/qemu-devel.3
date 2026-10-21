Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g6Nnb9d3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ay/7BMTy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKc3-0008OP-N7; Tue, 20 Oct 2026 20:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJKc0-0008NR-RM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:55:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJKby-0008EJ-Jk
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:55:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L0Qqia3191333
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qhoLc7di3chqVu/u82BxKdC5GQST6/rD70P+nOQUhso=; b=g6Nnb9d3bAFBSIwR
 adbD5QT9l9UfzMHHGm+WUyQDopHr71kcHYswYaxR8d4k8yaRCePV4+6ja8G+ZnlU
 7RTQvj7lLuF8LCz2hxn2S+n2KDzjmKZyTuI39Wxnx4K5Q7xMbEB6hTj8DlXVZVky
 LUFGe/99CJjkhuEmWChV1aEnc0LR7s21JnsJADlkSrZ9iCAOQJZQzin1gJyBhGPO
 EFNc+rB1RSVOtsN0wYu86rKUzWJsYzgkKtuZVDtpd+gXnggiWReV7kFk87S3iQ9G
 OzdoMVJNBt5Zxc8hBzM7nMv3bAo9SNJ9y6IvxdXmMOVEE8YscPt5gDnpdi7ItjXZ
 rWNCVg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r0c35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:55:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so50181585a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792544119; x=1793148919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qhoLc7di3chqVu/u82BxKdC5GQST6/rD70P+nOQUhso=;
 b=Ay/7BMTy1iOsuIqARkhGweBgbTD6rFhjPX2CwFl+sN9AvN9WAUEKe+fFbl+uV7T/gI
 S7I9Ul/uH4YqjoX+TE8VK/o1/CjDgj6fQ/T8Bm62js/S4wWjk2qa1oBKBMn/C4h0t+vY
 ZEzgGyPEY/NO0tibms9xh0Z/5Wdi1ByAfsUaBbISmJZk+ntaBD8VLAF7VDldcslpSsHA
 eRMcAH4F6yAEkA0HIJuvHlx48ml3/pjPYUhyT79vm3jvLQeO4T3BUqX765XLjhMec/V5
 XkMlBbpauDpA+f7iXQRkngSBbH3rbyo7bHfUAJoKLr2RuBZ6vW57CWCe+jO1J9BYgYMA
 tbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792544119; x=1793148919;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qhoLc7di3chqVu/u82BxKdC5GQST6/rD70P+nOQUhso=;
 b=Lji7/ZABTXE/VaOXvbHiJuHTPwU24Wh5hbWBw5IGXLlhOg4wHEZT9wxaX8C2/FIqLZ
 WrH7tZS0ETAlnxIOx481zeJe6VyGo+iY+NM7f9x3rAlDB19+OeZkNT6xk6WUapNRheNQ
 FnGi/PhlJL9OrfBEiBZVcu+56EzjohVNObDNBb4SDPKbUtWauKIJJFeflXvxXT+9pDeH
 9gvRGdcQwDH/MzqiweD6vRfjthAMEoYmn8ad4cWTHTwRYBhxXMWf/1FOOw+VEUNcrk5I
 FUdLxN9Is3Fr4Pf3H9uZ1ezd/y5WlTX/T2j4OjLc+cNaiPfyHWo1+NCj11GErE57nkQQ
 jLZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9BbEJax9QLxpKjx44VPW/BOvKJHyOueapEDwrDtNZqzu2ZjyL6W5/Ska467G95nRxOt1J/gzJEBPa@nongnu.org
X-Gm-Message-State: AFq9FYIVrC8gaw/0Q+F6a3Vk0eFejQGY7qMc53+gDIWLRegGPlf4egc6
 K0s8v1Q3Y7X95O+e+U57S5gyXLGM7ZsPt//o7i01PX3QEccYp2l6bhTC0+W2XYClkHtCFJBzPsX
 qFaGcOgZJFQBnKXKOSU5bv+653TUvJlhUjzO3KLMap17vP+MAIBHzovwppw==
X-Gm-Gg: AYBFou3KdXhnwcLrJ5nBj26vP2qrHDjqfLQMx1q5MqteusFC8kG7jZylRWoWsaU/dOR
 9oOLKaNHq1On6U3TmqNcOCx8P9do8EGrNUBrGMv+JX7Jnsi9XsBCSOGhTMfGc0frbGsTf4AxHGw
 oa5HM72TQbv+1aB52iOpqHYRNWRVaw9SOOVtCkbGcdbMriQ04rwiOa/ckZac8cAsJdkbxlZUiKb
 d0Z/vVHceD+JTR6PF0g9P2+xsZ0r23oPIK9caZJ6gBBevAExImPEi8JESnelPAZ9mvk0xy/Yk4p
 yQ2I/DNZRnSHvq141CnwZhA5bg6xqIpnoXpgiI8srZFbXwyd1UEPLGbkN4itHz+P3zCUyAiiJoN
 jfujzEp2vmGlbsb/GuOUY5SVJ5pHpMiSQMw==
X-Received: by 2002:a05:620a:4147:b0:93e:618f:8127 with SMTP id
 af79cd13be357-93f4c45172dmr634873685a.8.1792544119100; 
 Tue, 20 Oct 2026 17:55:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4147:b0:93e:618f:8127 with SMTP id
 af79cd13be357-93f4c45172dmr634870785a.8.1792544118591; 
 Tue, 20 Oct 2026 17:55:18 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm21701225e9.0.2026.10.20.17.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 17:55:17 -0700 (PDT)
Message-ID: <f122a975-7f6c-48c3-9748-2a42026aa210@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 02:55:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] target/alpha: Register CPUClass::exception_name()
 handler
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-4-philmd@oss.qualcomm.com>
 <d994b82d-391e-4d5d-ad6c-faa3a1a2fe8b@oss.qualcomm.com>
 <4adf8178-fb5d-4d45-982f-43e30be3c801@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4adf8178-fb5d-4d45-982f-43e30be3c801@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad80d77 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=M-HrepKPW0E-unTsW-YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: hKnmHnwReaty2cpdpg7Mt_-TjR2jzCJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMyBTYWx0ZWRfX5tp9So/5+KYu
 XwXWUj4jrpMtv6xp1Uu9d4jUoRaOTxjOK8rUbwZtRdMHyApzUaOYO5yn24URa2ab00xp4Tqr6d/
 8gYEmFbKblupL1dDwnXNMhKoV0h3Hn4itqx+G4qcUvjwEqthMdj3xyUod9nSJ2kOiaoG9Le9n4W
 m/l/6cf0gn/syqxzq+bRntqI3XnD2wSBLTKMcnvWBASgytqpBNfIXxleLNxz2YiClN10C4ZUb85
 q1aEpGfL77jO6q8q14KKIw2dJVD/ocZnFAcwaJkb0br4E5bbxUiyJRWIncjpBpbh+ocLw9kYXRU
 uHZilZhlRSvy3LzP9Posny04UvKgpnN4d/6S7vkZos39CirGK6/NrvcL2mR16krZpJsibJT7zuG
 HpwjyVOWDDELixRjY+EAsxsVdW5m5+9M2N5qxr2iYyyOPMbGHGrtxf7+KUy7o64lNUW7UxeGjZ8
 x6z8hxn57jipmqFkTnQ==
X-Proofpoint-GUID: hKnmHnwReaty2cpdpg7Mt_-TjR2jzCJy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMyBTYWx0ZWRfXyj54wTOETf9s
 BVevDknz7AQtkP87DXWzYs4etOdWuZIYB7CQ5Q8cVvJuu0f7EEhZ7uG+IyIudOJvwbKnvzbV+wJ
 3eiflAal1bSsILPYXEVk0OeAw4geYHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210003
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

On 20/10/26 21:15, Pierrick Bouvier wrote:
> On 10/20/2026 12:05 PM, Pierrick Bouvier wrote:
>> On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
>>> Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
>>> and register it as the CPUClass::exception_name() handler, so
>>> the common exception logging can resolve Alpha exception codes
>>> to names.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   target/alpha/cpu.h    |  1 +
>>>   target/alpha/cpu.c    |  1 +
>>>   target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
>>>   3 files changed, 48 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
>>> index 378bd96d941..8f780502476 100644
>>> --- a/target/alpha/cpu.h
>>> +++ b/target/alpha/cpu.h
>>> @@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
>>>   bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>>>   hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>>>   #endif /* !CONFIG_USER_ONLY */
>>> +const char *alpha_exception_name(int exception);
>>>   void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>>>   int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>>   int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>>> index 12e86021663..f9936315fa2 100644
>>> --- a/target/alpha/cpu.c
>>> +++ b/target/alpha/cpu.c
>>> @@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
>>>                                       &acc->parent_realize);
>>>   
>>>       cc->class_by_name = alpha_cpu_class_by_name;
>>> +    cc->exception_name = alpha_exception_name;
>>>       cc->dump_state = alpha_cpu_dump_state;
>>>       cc->set_pc = alpha_cpu_set_pc;
>>>       cc->get_pc = alpha_cpu_get_pc;
>>> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>>> index c3614ecafda..cedb0006892 100644
>>> --- a/target/alpha/helper.c
>>> +++ b/target/alpha/helper.c
>>> @@ -35,6 +35,51 @@
>>>   #define CONVERT_BIT(X, SRC, DST) \
>>>       (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
>>>   
>>> +const char *alpha_exception_name(int excp)
>>> +{
>>> +    const char *name;
>>> +
>>> +    switch (excp) {
>>> +    case EXCP_RESET:
>>> +        name = "reset";
>>> +        break;
>>> +    case EXCP_MCHK:
>>> +        name = "mchk";
>>> +        break;
>>> +    case EXCP_SMP_INTERRUPT:
>>> +        name = "smp_interrupt";
>>> +        break;
>>> +    case EXCP_CLK_INTERRUPT:
>>> +        name = "clk_interrupt";
>>> +        break;
>>> +    case EXCP_DEV_INTERRUPT:
>>> +        name = "dev_interrupt";
>>> +        break;
>>> +    case EXCP_MMFAULT:
>>> +        name = "mmfault";
>>> +        break;
>>> +    case EXCP_UNALIGN:
>>> +        name = "unalign";
>>> +        break;
>>> +    case EXCP_OPCDEC:
>>> +        name = "opcdec";
>>> +        break;
>>> +    case EXCP_ARITH:
>>> +        name = "arith";
>>> +        break;
>>> +    case EXCP_FEN:
>>> +        name = "fen";
>>> +        break;
>>> +    case EXCP_CALL_PAL:
>>> +        name = "call_pal";
>>> +        break;
>>> +    default:
>>> +        name = "<unknown>";
>>> +        break;
>>> +    }
>>> +    return name;
>>> +}
>>> +
>>>   uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
>>>   {
>>>       return (uint64_t)env->fpcr << 32;
>>> @@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>>>   
>>>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>>>           static int count;
>>> -        const char *name = "<unknown>";
>>> +        const char *name = alpha_exception_name(i);
>>>   
>>> -        switch (i) {
>>> -        case EXCP_RESET:
>>> -            name = "reset";
>>> -            break;
>>> -        case EXCP_MCHK:
>>> -            name = "mchk";
>>> -            break;
>>> -        case EXCP_SMP_INTERRUPT:
>>> -            name = "smp_interrupt";
>>> -            break;
>>> -        case EXCP_CLK_INTERRUPT:
>>> -            name = "clk_interrupt";
>>> -            break;
>>> -        case EXCP_DEV_INTERRUPT:
>>> -            name = "dev_interrupt";
>>> -            break;
>>> -        case EXCP_MMFAULT:
>>> -            name = "mmfault";
>>> -            break;
>>> -        case EXCP_UNALIGN:
>>> -            name = "unalign";
>>> -            break;
>>> -        case EXCP_OPCDEC:
>>> -            name = "opcdec";
>>> -            break;
>>> -        case EXCP_ARITH:
>>> -            name = "arith";
>>> -            break;
>>> -        case EXCP_FEN:
>>> -            name = "fen";
>>> -            break;
>>> -        case EXCP_CALL_PAL:
>>> -            name = "call_pal";
>>> -            break;
>>> -        }
>>>           qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
>>>                    PRIx64 " sp=%016" PRIx64 "\n",
>>>                    ++count, name, env->error_code, cs->cpu_index,
>>
>> Any reason alpha can't have it's static table like others?
>>
> 
> For rx, it makes sense since exception index list is sparse, but for
> alpha it's not. For consistency with the rest of the series, it would be
> nice to have this under a table.

I tried to keep the refactor to code movement, keeping each subsystem
maintainer style. If these patches are correct, might I address your
review requests as cleanup patches on top?


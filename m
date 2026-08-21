Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F64C5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRX5-0002vh-M9; Fri, 21 Aug 2026 11:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxRX2-0002tc-Qg
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:51:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxRX0-0006Aj-Oz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 11:51:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LFm5Yl2743890
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 15:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cfP8MJxy40HOTEywgI/VTTe7IZzMoEsu0wp5QrPzZIg=; b=aAqIGITBgNEuEPtA
 MEcaGPVD9xW9+8tsjeJkcPRie/ypzUyiPBMPfoAgaivMx+caMHcHnigubScTNXzm
 lYHeVpgcShad/Bqfx4e8gW1EqFBWBUidZg9FLwcFSBK27y0avISToupvm4k7tI7o
 XHUjdoVeDxmpaZWTM1Aj6rxPSVxeCfgSx1epaBuvmVaAunFPyZB58CPV4ySUvC1v
 ZU4RBHziS1OaCkX6/yqph6DAO4MbQZbRED9Ac2NJjrxmAHrE45vw5oXnuGRygg6G
 FRjZc6bV9yG/q5MdKL7o6TykvrA/+3BhW9oAxQoho2gtunS9INzH8b08AMGHpYk1
 BXUeaw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdnacjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 15:51:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07f25de2so8549171cf.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787327504; x=1787932304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfP8MJxy40HOTEywgI/VTTe7IZzMoEsu0wp5QrPzZIg=;
 b=hNDN28+3tYNoKjumcj6phGahWhv7i4RFMn+tB037pBeAM8IwcFW9J2xiZLVNkyzG6s
 Aq5LGVAi/TfbhxRIrOt02+INgJGt1dM8QCCGGSpr0Y3pY6EqNNpslhJ6R8pasGgT58OQ
 AQ4v6neUcyxeA0bPWdn/HxOy838GaB8zZcAoYlHGE5JPKf/+04Z1JrKTvOFYqTCxu8Zr
 zQdyl9hTOSQKgcCg1vMlvKU4GSbax9RkUxvUVUqvYowINpQkWjxa+KuUxm8Wt/meWPsC
 Rp7uU8ha9fdq+2qiIPF7pRidF+LTYB18S6eAaoaQwnxABx5D2yVf9eKW7LxKsoytmsGn
 W3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327504; x=1787932304;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfP8MJxy40HOTEywgI/VTTe7IZzMoEsu0wp5QrPzZIg=;
 b=YAMwXzXenKoutorelRdZ64XPTrEdzAq3mVvi3Ds7ChMSjk+h3toDL4I6neQmCm4aRV
 kDHkdyPEqsl7SX4XHBdO7XKLdSnBHVuBKTpAjZZy9bRo9vDgZjynZOMY6vKp0m6JGLmK
 V5dt8Jw8YBfrtIMRxgAFDY0nN4gI4NIppYW0S38WIxlGw6iR3HdD3KC1w9LJe9TGLO5B
 zcyPD0Oi/x906kgXzV05o+AO00e/NpexTCwJx35CLv4c25dB/slyqAPSX4dkLGs/XeDl
 4TxVuXJQy6AKhyIpOnmD3RHfVPgZQ0l4utn2n0WtfeecxWptTZ6QwRhLDSU2l1B/I8m1
 e/4g==
X-Gm-Message-State: AOJu0YylLuKof492XgQKSXCYMcAeOcBev0pqD5yUIAWutYe7MzRTLVtS
 g61/5aHM98sYjoVJbE19Di4lLZ7R772z16H/dm9cempGj2RGUTcNpQHg1p/0Zvsm6obERTXW6Cg
 Y0BVGbl2OxaCJxUuZQJ3Fh8uCit6YcjJ+0+CGR+nDCqNXkBOnWHS7oqwyEYoQjc4HJ+kB
X-Gm-Gg: AR+sD10IYtScme0SaW/tCiiqlPdf6jzSIt1jJ02zqqsZ8OX0SbP1cnbE9F1JQAHbjAB
 fYxShSR7lWDerIQdSLtmajNcMalQ3S0l3Lh91Dz3wkuj5eY9cv7zZ5rjAutqxP5SoYDDlvafip3
 VRPZre/PoeagCy7haHhOhJGmioTNvuB/HzY5StGDXxPDWTX5B8z06ju/mYyFd0E0jCJaqXus7Sb
 uNMYzh1eTctnzvWXHAA1FhW8ltz1KiCWBXLmoxoTtPvCLKLt/2YyygmE35+dTjl16N1XPCklpb5
 akYaJYil/YUq/3Y/IqXOr/xSj8vaQogncfGkBLAv2R0HCG9VQX7RyCdMEh7QkH4dkzTB6i1jzMq
 UY0AqQQwYRdUYdfnIP+ch1NY=
X-Received: by 2002:a05:622a:481a:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52df5a5167amr66445901cf.31.1787327504274; 
 Fri, 21 Aug 2026 08:51:44 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:51c:805:1be3 with SMTP id
 d75a77b69052e-52df5a5167amr66445431cf.31.1787327503811; 
 Fri, 21 Aug 2026 08:51:43 -0700 (PDT)
Received: from [10.111.143.150] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90d3046sm32881335e9.1.2026.08.21.08.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 08:51:43 -0700 (PDT)
Message-ID: <22188776-edeb-44e6-b79d-0b877292221d@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 17:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] cpus: Add const-qualified CPU environment
 accessors
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
 <20260821104950.32108-3-philmd@oss.qualcomm.com>
 <3c9fe944-2b51-412c-bd30-26bf013cff46@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3c9fe944-2b51-412c-bd30-26bf013cff46@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfXy5sZ/yrNXg2N
 Wuou3R02nykLrN9Pvt6iVct1dIRiA9Getp2Gpve6aVaqTv/YJwE5GZrnMq+vQPDvMSWPf3UtU7E
 y2vX5RdzeQqX6GuP45xySGxJTI2UeKCwt+PKilqQ3PWSDCUoE2gS3R96oQUdRv4gKoN6WDmDlv5
 6BOgMLyL+EP00qEfSGM4LNG6f1RMkmTCbr/Q3g4pOK2vDyUnKITbxjjp2Vk8VOaEkKF2sER7ZAa
 wK5DZodORBQQQjTNXZp0R68NXBV/L7ElJPTSebZsZp/NMJ9yAwppd9To2vn5OWCDmO/xVHJ3lA4
 Ekm3D9LREK8HpO/CD3adZshIF2x6u5La9hy6lomWzgWNbIZnotDylK4nd34/xteYOwwRRZBLZ1z
 LqFUoreNV2a3YQ3iXV+Eg9Qz6L240m4y+OiiXwhcegVANa3rCq5LSgBP63zj5U00EPO5xWHnx2p
 7WACJKvWnAyGfQZ9/0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyMyBTYWx0ZWRfX8trqVMkh1JkX
 90EBT94QbzvPPK7/Hvlo47GpAaYqZ1UytycSQoFiK/zL4EfjzzlJ7VVSC0e2ZvGN89wL72dGM3A
 Mf+ddCg+4ebW90PSX8yMYbOvrmH4tzY=
X-Proofpoint-ORIG-GUID: 5GfHfRRyGEJxnGJ09oaXvU5wXOsRVNS4
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a887411 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=dE4Oo_SCXb6TKsHij4QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5GfHfRRyGEJxnGJ09oaXvU5wXOsRVNS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-08-21 13:33, Philippe Mathieu-Daudé wrote:
> On 21/8/26 12:49, Philippe Mathieu-DaudÃ© wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Use _Generic() controlling-expression to add the const-qualified
>> variants of cpu_env(), env_cpu() and env_archcpu(). This allows to
>> safely access CPU architecture state when it should not be modified.
>>
>> Alias env_cpu_const() which is still used.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> Following checkpatch.pl errors ignored:
>>
>>    ERROR: spaces required around that ':' (ctx:VxE)
>>    #46: FILE: include/exec/cpu-common.h:89:
>>    +            CPUArchState: \
>>                             ^
>>    ERROR: spaces required around that ':' (ctx:VxE)
>>    #62: FILE: include/exec/cpu-common.h:101:
>>    +            CPUArchState: \
>>                             ^
>>    ERROR: spaces required around that ':' (ctx:VxE)
>>    #90: FILE: include/hw/core/cpu.h:605:
>>    +        CPUState: \
>>                     ^
>>    total: 3 errors, 0 warnings, 64 lines checked
>> ---
>>   include/exec/cpu-common.h | 30 +++++++++++-------------------
>>   include/hw/core/cpu.h     | 17 ++++++++++++-----
>>   2 files changed, 23 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index 6594f7fa1be..bffef677607 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const 
>> CPUState *cpu)
>>    *
>>    * Return the ArchCPU associated with the environment.
>>    */
>> -static inline ArchCPU *env_archcpu(CPUArchState *env)
>> -{
>> -    return (void *)env - sizeof(CPUState);
>> -}
>> -
>> -/**
>> - * env_cpu_const(env)
>> - * @env: The architecture environment
>> - *
>> - * Return the CPUState associated with the environment.
>> - */
>> -static inline const CPUState *env_cpu_const(const CPUArchState *env)
>> -{
>> -    return (void *)env - sizeof(CPUState);
>> -}
>> +#define env_archcpu(env) _Generic(*(env), \
>> +            CPUArchState: \
>> +                (ArchCPU *)((void *)env - sizeof(CPUState)), \
>> +            const CPUArchState: \
>> +                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
> I was testing with a C17-ready compiler. Apparently C11 is ambiguous in
> how it treats qualifiers inside _Generic:
> 
> ../../target/arm/internals.h:1777:25: warning: due to lvalue conversion 
> of the controlling expression, association of type 'const CPUArchState' 
> (aka 'const struct CPUArchState') will never be selected because it is 
> qualified [-Wunreachable-code-generic-assoc]
>   1777 |     const ARMCPU *cpu = env_archcpu(env);
>        |                         ^
> include/exec/cpu-common.h:91:19: note: expanded from macro 'env_archcpu'
>     91 |             const CPUArchState: \
>        |                   ^
> 
> Using typeof() makes it happier:
> 
> -- >8 --
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index d67d008236f..e3a5e40899f 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -87,6 +87,6 @@ static inline bool cpu_loop_exit_requested(const 
> CPUState *cpu)
>    */
> -#define env_archcpu(env) _Generic(*(env), \
> -            CPUArchState: \
> +#define env_archcpu(env) _Generic(typeof(*env), \
> +            typeof(CPUArchState): \
>                   (ArchCPU *)((void *)env - sizeof(CPUState)), \
> -            const CPUArchState: \
> +            typeof(const CPUArchState): \
>                   (const ArchCPU *)((const void *)env - sizeof(CPUState)))
> @@ -99,6 +99,6 @@ static inline bool cpu_loop_exit_requested(const 
> CPUState *cpu)
>    */
> -#define env_cpu(env) _Generic(*(env), \
> -            CPUArchState: \
> +#define env_cpu(env) _Generic(typeof(*env), \
> +            typeof(CPUArchState): \
>                   (CPUState *)((void *)env - sizeof(CPUState)), \
> -            const CPUArchState: \
> +            typeof(const CPUArchState): \
>                   (const CPUState *)((const void *)env - sizeof(CPUState)))
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 372485a2e54..ee522e1e705 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -602,7 +602,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
>    */
> -#define cpu_env(cpu) _Generic(*(cpu), \
> +#define cpu_env(cpu) _Generic(typeof(*cpu), \
>           /* We validate that CPUArchState follows CPUState in cpu- 
> target.c */ \
> -        CPUState: \
> +        typeof(CPUState): \
>               (CPUArchState *)(cpu + 1), \
> -        const CPUState: \
> +        typeof(const CPUState): \
>               (const CPUArchState *)(cpu + 1))
> ---

No, this now fails distinctly on Ubuntu 24.04:

In file included from ../accel/tcg/tcg-runtime.c:26:
../accel/tcg/tcg-runtime.c: In function ‘helper_exit_atomic’:
/home/runner/work/qemu/qemu/include/exec/cpu-common.h:100:31: error: 
expected expression before ‘typeof’
   100 | #define env_cpu(env) _Generic(typeof(*env), \
       |                               ^~~~~~
../accel/tcg/tcg-runtime.c:135:26: note: in expansion of macro ‘env_cpu’
   135 |     cpu_loop_exit_atomic(env_cpu(env), GETPC());
       |                          ^~~~~~~

I'm a bit clueless. In case you want to have a look, the
series is available here:
https://github.com/qualcomm/qemu/commits/refs/heads/philmd/cpu_has_work_const/

Thanks,

Phil.


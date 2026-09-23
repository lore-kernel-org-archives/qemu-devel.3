Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3857C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9F7W-0001gi-Hj; Wed, 23 Sep 2026 01:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9F7U-0001gV-Uz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:02:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9F7S-0002b3-HS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 01:02:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N3iT1Y1590649
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYUoPA/iYn/cxetANqeGhQdKiQ0JxWjhU3lH1TfBDIY=; b=E3EuQrQFYe3IKCRz
 umzmoeFqLivJR8kWBjRInLC4KJLNzkDGSwLt4qfrAVAUERQQykS208TijxBD1eww
 gKhXm7QsDZm0puqRAneonH54A5aYu/YQIfig/2GlS1uup+/wbgXRfUtnMNCEISAy
 y5faFshlpXTTQ1XXdBlsfuFkqTx6TrcKkWNGHxDbRIQXVKOq4r9Fh6A3wIHxVb2D
 3zDGeWVMSiDe3P4kMSr/LVJkXUwVkQjuBTKy5scjCmJr6cqhJfDT2zxigOJ7cMTP
 VXA8VN920v5p+lHu68O9FVaaVur/0OBHTAodJ3zaeB4zGk9VrDC6wd4AfARDm/HJ
 CHNO+Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurntcg6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:02:08 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c683ca769dso300625e0c.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790139727; x=1790744527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYUoPA/iYn/cxetANqeGhQdKiQ0JxWjhU3lH1TfBDIY=;
 b=B/TEgaBlA1ba0CHBQDAKYn4C3EV/yZyORBTztm73CtOzw/MzMILTP+WsDsc+Y16n3c
 rXIszO+hRDskn700T2nrJDp1hD7OKEwG0QsVjXoOnQk698AWfVuQNqX/geQ18kLwqNBp
 0gbgDHH1Sz+MFI4JzZkwQSVf0IMvh68S54NZkd54HPckOA+4AroSHGMV7gLorBeL4Yd3
 n7DZqxZHtaLtjoH/UHDq4Tagie0s0ZUvBoUx7CkKuDCPnnwPZqLAZ1byFh5YvUQMI9Jn
 80ABDkK7FHQksKsUIY4oUpdd328fjhHmnls1BSE0zQkaEt5swNcHjrKvVHvYigDrkx7J
 8uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139727; x=1790744527;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYUoPA/iYn/cxetANqeGhQdKiQ0JxWjhU3lH1TfBDIY=;
 b=bVbFoxq98ksYmoI/pUPHchSB9GYE8PG4ygY8payqyhtZaRnJF76FlhGXoqCS9YZPO/
 wirzDI8J/XwrImSeliEM4mCNBTQSBpOZOH6VX7rPMDMjRB5ZyYeLhbrnMdAjbsC9t6OK
 owlDuSzHMK6OopQd8IEfbXKdI3qGnUGJc3UzETuPL0I59OMO9xNHZ/CKLjIZJVdrN0vu
 URLuPXUBbGoeTYand2FqPHLIkC4LXKBezNJfYdlVmsLorC3rnV2fsW23UPqwNGZR0wHf
 QMltv8fLOo2DIJZQDSCbaNv/PtQjkKQRUBYGWp2wGhr+6UFrhCWTVCMFrxWraR2yZWLA
 hoSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxg00M3AzU2cXWcqAeDAyY2oe1B3XQ5ebmnvqhh2dv6aFDHoO7cnLpm2Nk87Y9/2F+m0/iRQr/gUTkq@nongnu.org
X-Gm-Message-State: AFuF++ltLONbVFx5v8x1jUXzqYXwqt88puOrNuVqEjEI4nTnDL99l+CY
 V4Fr9ThWbqXJALodVnTLjkGkO/mkOjSQo7YWaNePIo+0yIe84v7RYNOpoQmxFMtYf3ZcOHJuQke
 AZqdCPU+x6w5MK/+l8BssyEbwmQ7trP7xtclEQv4rqkJOdXyDFAtcmqox4g==
X-Gm-Gg: AYBFou3lgHqXqfXvLHknmTEukIK/tonZYfZLbPMfmNvsDaC55H9pIh82c6oq9tNPBSv
 Wt6QwOJAw7OJ/Gyni3rzgthd0qmNqJIHUmVS1YDUXYRZvNcrVeMNi10GttYQAPx/x7xc/qffc0W
 950wczdYDaG2dwzdirAMMwKeWDKRGmlj7CiFGbHAPgZtKcwExieZh8OHYkDDxGkBohGYuLrRhPT
 N49BEL+TnbFqAKxn2od09BrQaRKBq8wjMocGGLJFVuu4qkMOECaWBFw2nqSkqwopNc2Rq/2MCoQ
 7YjacnwDEbQ0ojj7xbnXBryQPvh1KadqImLx/g8VkDnnxloXbxObh+EIgd5xFiD/qzaaxnzrEJ9
 uCewgcY17/cA9xzOFTYNiGuxAtS1Lk4yK7Q==
X-Received: by 2002:a05:6102:5e93:b0:7a1:f951:f307 with SMTP id
 ada2fe7eead31-7ac1e25c9d8mr1502280137.26.1790139726655; 
 Tue, 22 Sep 2026 22:02:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5e93:b0:7a1:f951:f307 with SMTP id
 ada2fe7eead31-7ac1e25c9d8mr1502265137.26.1790139726233; 
 Tue, 22 Sep 2026 22:02:06 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde17dab9sm56522215e9.2.2026.09.22.22.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:02:05 -0700 (PDT)
Message-ID: <99d63fd6-ad8a-48de-9774-ae66f469ea77@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] target/hexagon: share HVX contexts among CPUs
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260915145541.4038637-1-brian.cain@oss.qualcomm.com>
 <20260915145541.4038637-6-brian.cain@oss.qualcomm.com>
 <88356789-fd7c-4641-a1ac-5291a5fe34de@oss.qualcomm.com>
 <b109667c-e31f-4126-981e-c7bc1c8629aa@oss.qualcomm.com>
 <9f65087d-f8f4-469f-a099-9fbb48a12158@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9f65087d-f8f4-469f-a099-9fbb48a12158@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -Aya5ex-m6nC0dNFMiFLwb0eXm4U8Rl8
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab35d50 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=SxmuFclaZAZUrVmpomMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfXzs20g+tROS6C
 XgOgy/2wGNcm673nAZGFAQqqSvhJfLPnLzPv6NPMsU3B9LYv9e0WVZvNpTTTtA1KjGVoMufVdye
 BnHG4qMoeRtht05r77mEvlMIdmvwdeEvZDt9WpxRhfjrXyW1QEhE8LGiMGoDwUzqJ5hNx/WjApH
 gjPvbq+2QRBb5NRZoMKQFHda5wX0G3bqCD33E9z3aPuboaMEu8EdDfIIvRna9SORw6ypDlcCu81
 +uUVpf980AjPgQzpkV1x/F9O7weP9XaGObqNo8/nFzc5xpIjhYWjkT5EXgXHaj9+qdwSSdfm/GY
 nqb0qUlnHJbMiFBbe7jYMjCQsIx97YM0X9zw7RdIQ30oVxD4dQU1LJV1Iu8CiaqI6VOQztphuKq
 EiQJivZ2+p2/AIy8Iy/xA9E9ja0oXlgClejMskX7fRWfhSUHDxWvVsZJUrDDdcFreo+WNgIAJJj
 mpYURT1vXFAJMbTmDHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxOSBTYWx0ZWRfX2/QsZ2NtaeL7
 FgG8dxDR2TEVKjQWgc9rxTGz6dO7p1gaLIaFSjvCijhPiJDiIOV6oru0vthiBxmewvc39iHHrLm
 EfcHYO/i3Qw6rKgxmOsOVSZrsZXzOtg=
X-Proofpoint-GUID: -Aya5ex-m6nC0dNFMiFLwb0eXm4U8Rl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/9/26 03:40, Brian Cain wrote:
> 
> On 9/22/2026 1:43 PM, Brian Cain wrote:
>>
>> On 9/21/2026 6:59 AM, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 15/9/26 16:55, Brian Cain wrote:
>>>> The HVX register file belongs to an extension context, not a 
>>>> hardware thread.
>>>> Model each system-emulation context as a QOM device, link the 
>>>> contexts to
>>>> each vCPU, and use SSR:XA to select the active context.
>>>>
>>>> Keep one embedded context per linux-user CPU.  Carry the selected 
>>>> register-file
>>>> base with HVX operands so translated code can address the selected 
>>>> context
>>>> at run time.
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>   include/hw/hexagon/hexagon.h             |   1 +
>>>>   include/hw/hexagon/hexagon_hvx_context.h |  27 +
>>>>   target/hexagon/cpu.h                     |  25 +-
>>>>   target/hexagon/cpu_helper.h              |   1 +
>>>>   target/hexagon/gen_tcg_hvx.h             | 608 ++++++++++++ 
>>>> +----------
>>>>   target/hexagon/genptr.h                  |   8 +
>>>>   target/hexagon/mmvec/macros.h            |  14 +-
>>>>   target/hexagon/translate.h               |  11 +-
>>>>   hw/hexagon/hex-subsys.c                  |  36 ++
>>>>   hw/hexagon/hexagon_hvx_context.c         |  84 ++++
>>>>   target/hexagon/cpu.c                     |  30 +-
>>>>   target/hexagon/cpu_helper.c              |  82 +++
>>>>   target/hexagon/gdbstub.c                 |  16 +-
>>>>   target/hexagon/genptr.c                  | 102 ++--
>>>>   target/hexagon/machine.c                 |  12 +
>>>>   target/hexagon/op_helper.c               |  37 +-
>>>>   target/hexagon/translate.c               |  60 ++-
>>>>   hw/hexagon/meson.build                   |   1 +
>>>>   target/hexagon/hex_common.py             | 179 ++++---
>>>>   19 files changed, 886 insertions(+), 448 deletions(-)
>>>>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>>>>   create mode 100644 hw/hexagon/hexagon_hvx_context.c
>>>
>>>
>>>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>>>> index 97f689fda22..df4c0182247 100644
>>>> --- a/target/hexagon/cpu.h
>>>> +++ b/target/hexagon/cpu.h
>>>> @@ -29,6 +29,7 @@
>>>>     typedef struct HexagonTLBState HexagonTLBState;
>>>>   typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>>>> +typedef struct HexagonHVXContextState HexagonHVXContextState;
>>>>     #include "cpu-qom.h"
>>>>   #include "exec/cpu-common.h"
>>>> @@ -49,6 +50,7 @@ typedef struct HexagonGlobalRegState 
>>>> HexagonGlobalRegState;
>>>>   #define REG_WRITES_MAX 32
>>>>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>>>>   #define VSTORES_MAX 2
>>>
>>> Could this simplify #ifdef'ry maintenance in source?
>>>
>>>   #ifdef CONFIG_USER_ONLY
>>>   #define HVX_CONTEXTS_MAX 1
>>>   #else
>>>
>>>> +#define HVX_CONTEXTS_MAX 8
>>>
>>>   #endif
>>>
>> Okay, good idea - I'll give it a go. 
> 
> 
> Hmmm - making that change and making both modes have a 
> "HexagonHVXContext *hvx" would work but then we'd need to add some 
> ifdef'd magic to cpu_copy() so that we get one context bound to each 
> thread.  That sounds like it's not a net win.

Unfortunate. Something bugs me in this patch but it is too
big to review and Richard already reviewed it, so no objection.

To reduce the changes size we can introduce hex_hvx() and
HEX_HVX_OFFSET() as a NO-OP first step with most of the
code churn:

   static inline CPUHexagonState *hex_hvx(CPUHexagonState *env)
   {
       return env;
   }

   #define HEX_HVX_OFFSET(member) offsetof(CPUHexagonState, member)

See for example 4a5d2c649da ("target/loongarch: Add macro CSR_OFFSET
and CPU_CSR_OFFSET") and around commits.

This will help us to review the more complex rest of the changes
when looking back at the commit in the future ;) Normally if you
do the split you can keep Richard R-b tag.

> 
>>
>>>>   #define MAX_TLB_ENTRIES 1024
>>>>   #define THREADS_MAX 16
>>>>   @@ -120,6 +122,11 @@ typedef struct {
>>>>   /* Maximum number of vector temps in a packet */
>>>>   #define VECTOR_TEMPS_MAX            4
>>>>   +typedef struct HexagonHVXContext {
>>>> +    MMVector VRegs[NUM_VREGS];
>>>> +    MMQReg QRegs[NUM_QREGS];
>>>> +} QEMU_ALIGNED(16) HexagonHVXContext;
>>>> +
>>>>   typedef struct CPUArchState {
>>>>       target_ulong gpr[TOTAL_PER_THREAD_REGS];
>>>>       target_ulong pred[NUM_PREGS];
>>>> @@ -159,11 +166,15 @@ typedef struct CPUArchState {
>>>>       target_ulong llsc_val;
>>>>       uint64_t     llsc_val_i64;
>>>>   -    MMVector VRegs[NUM_VREGS] QEMU_ALIGNED(16);
>>>> +#ifdef CONFIG_USER_ONLY
>>>> +    HexagonHVXContext hvx_ctx;
>>>> +#else
>>>> +    HexagonHVXContext *hvx;
>>>> +#endif
>>>> +
>>>>       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>>>       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>>>>   -    MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>>>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>>>>         /* Temporaries used within instructions */
>>>> @@ -196,6 +207,7 @@ struct ArchCPU {
>>>>       CPUHexagonState env;
>>>>       HexagonCPUConfig cfg;
>>>>   #ifndef CONFIG_USER_ONLY
>>>> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
>>>>       HexagonTLBState *tlb;
>>>>       uint32_t boot_addr;
>>>>       HexagonGlobalRegState *globalregs;
>>>> @@ -204,6 +216,15 @@ struct ArchCPU {
>>>>   #endif
>>>>   };
>>>>   +static inline HexagonHVXContext *hex_hvx(CPUHexagonState *env)
>>>> +{
>>>> +#ifdef CONFIG_USER_ONLY
>>>> +    return &env->hvx_ctx;
>>>> +#else
>>>> +    return env->hvx;
>>>> +#endif
>>>> +}
>>>
> 



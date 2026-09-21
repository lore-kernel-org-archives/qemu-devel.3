Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF0FC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cgh-0003ol-A4; Mon, 21 Sep 2026 07:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cge-0003od-Ka
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:59:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8cgZ-0004bN-9q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:59:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAdojZ1217422
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DHDXcBUpXAxgVKgpwBJUhJQlGLqQTDvI2jAj+8JejPA=; b=Cel4mYu0qPKXuvVI
 PxoRJ6rvr6W+dRmAJD0Zl8JhH/7L627y6hMmi3hUiBS0MHcC7iPEfQEZ9xSKqaiJ
 b3HjWa/b0GUXW2JvTTPZ67EfsnpjB+ZKYqbtikbkt5BsDr9hG/ZBfbyKqpMCosRr
 LQm1+SPlPCG4tPcLZB8dtMH/xmiejP0FHJ2sfGa/hVT5hI+w+lqV5rMOTh1IoJWY
 +yG3ZSnEFH53kO5d4Q8aIRB3DSxFtKd4aQwlF5tzTh5yw1HiOxDq21vFOiGRn9yM
 +o1ui2rM/JgxMhboWh2plbVrOfvHgqyM6vyj/Zi4tY8PS8t3tKIWN3bSeYVinh3y
 nJL6zw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0119435-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:59:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939d6c515deso611167185a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789991982; x=1790596782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DHDXcBUpXAxgVKgpwBJUhJQlGLqQTDvI2jAj+8JejPA=;
 b=MXy7ddpOhJ3cpT7QaH+NM7qUOe9c1gC+BJi+Gs10f8N8ZRt789kTFTCY08AWFRjblC
 YZtWppzTwIDhLU1yM7c4LqVc5ay/Qro/IfjrbnMdRUlBxwCBXMY6wRI9qlRR6WzLL+pm
 VbMuLhe8fZmbfzvfPhQNrAcX5AJarBxZlu24VU8iLd+cafF4RTL5EQXPzc9hcpFO9r4N
 maqhDI4T9BeYRtk5b6jYTw/u4I1jDD8jABp4VfdKz//p7Au1GUU4p6Eq+mSf6A6rAt2p
 8xAhBBzqbcx1nIn0YyXa57txiS7jl8R1H143TdiKcJupuS3fH3vKOTatCWP5UqXBx2d2
 s+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789991982; x=1790596782;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DHDXcBUpXAxgVKgpwBJUhJQlGLqQTDvI2jAj+8JejPA=;
 b=k36+MdxcFLym4X52QKWF+QVD9IfKnm3Jejx6TDBZc7iAb54Czz+JlzvXle87j+OxXe
 g2U8Ec3MdkZ8DIuew2CY6wVX49qk2c/fO5kmo889ycz/B8s4/M2PVl4okvakmhSfvIxf
 IRA86l4ag2k7kjn8YnbVWrKDS2vvla3578qHO4uqAklWZb2+ssWrgLGcVNIHIi5rNLTN
 z1RCDHVBQjp5BJbvRvXr8S1jJlAgldafhahvx8OxGyKKcsPrpsV0suXHPDIBEWxfQIO4
 xCQLNoGvW9VDQj1S1kgL0yzcZM09h97XY3fKLieoWEEoO4kMpf1W6Mq010MTnVarT2UT
 AB+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNJgw76fawPvHbaJsTw/OHBqxcDDqeYgedqXwqeb1iIdzVJShsXh2I776ohvnQ6pwF1HvHfa7YZO5l@nongnu.org
X-Gm-Message-State: AFuF++l2IsKviNBtVf9MKcs1mzTNhEr76XIyMwE0SAEv1Nb4FMDQlheM
 AHAk9c6IG5oflhgX7PuTxKsY1KbljR0IkciiU7fFMTF60Oz7SYkC8ZYlwVgpXs4DAhBWpbZ/8Zg
 mVZiPw48wW2reumeAHGi3S2NVyh61ZNpBpawwLJMGP7fTVMiJvFhrDf6EbA==
X-Gm-Gg: AYBFou1zWd3S1G6jhwjFpA0I3wXc95orz9kq/9PZC6MNSTpWvIzuBQZrmVz2ncCM7Ux
 461Ir0EcDWf0p4jl2RhwpTurvMy8TxTjf9FvvQFdo6NYf/HJaftSlaHWEVKSd6Du7xvDkYYHBJM
 +aSdjXqkL7Ibk+n5ubjIwk41wKMitSDD1KfSrzKbPOmULTjQp+EVSUDYvTt8IBzmZU58szM6uV+
 Y58Hu5tUQQhGTPX6rTAc25NMX3IAFDWr9HeEAq1IDVzU3blXK3GeAmzbExuHEujZ+njp1GaO3Nr
 yEOkYhiF8pu6eC7wMXTE8UJUmfrmWvLpjNR358knjg4yjfYZKt7i7rFwl8dgBLaw3Xz33rDWqKE
 3lXlgr1dLnmaMZ9HETxWnGHbaWIZ31JRTtw==
X-Received: by 2002:a05:620a:280f:b0:93b:e9d2:5ece with SMTP id
 af79cd13be357-93c15e412a9mr21693085a.39.1789991982616; 
 Mon, 21 Sep 2026 04:59:42 -0700 (PDT)
X-Received: by 2002:a05:620a:280f:b0:93b:e9d2:5ece with SMTP id
 af79cd13be357-93c15e412a9mr21689985a.39.1789991982114; 
 Mon, 21 Sep 2026 04:59:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd07bba7sm218446985e9.9.2026.09.21.04.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 04:59:41 -0700 (PDT)
Message-ID: <88356789-fd7c-4641-a1ac-5291a5fe34de@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:59:40 +0200
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260915145541.4038637-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0yP90-y_7zf2UoRoJSOZBtRbF2SEjDY4
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab11c2f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_qz1DOpRYyKskNyfRE4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX3gHDLi2UsQPB
 Db5PDUXw82/y5+r6aRJJ5q1BmcNuihTnFuTmd/i8l+Yt6y8Lsnfhxqbt7guKzRy8oDBiGXbfDb1
 WXbD6XB+CTkHp7jj/5ZAA2BR4d9pVQk7Pvja6+RAi3aydO1sAazKVllHCwZ0UQ43lAWEzh1Axoa
 Cmq6IEAWeI2ryWBIc9QlD3IgcdTu4ze1Gf/0NxCJ86EJ96VsLk6c8oX/25z3q25bhKdeKqnFzeW
 0N8vLxR5/nRpAq1YaHzjJIKOr+jHZxXSjHdGQ9oA305O5OBwajHhXw5snwjVHFzQNT3KdQ+eN15
 U25X9+WHtVlGkdmNxNJgexdCSdifHVdP8lfYj/nrHCwtQmMi1wowcAh36VsQ1T3/50vTIIKGeaP
 W7Fhm6JmAWO+h5INUc3+9RWwMLMeVRinjIcRr2v46E3Uaz+uwQmhsaVNxlgnPc77xH6/zyOmFPi
 Vm498kSpGJPVjtdvz6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX9wOUUITDl3R4
 EfLUYiAh2O3BN3eY0dTzwoi4QrjyZPFQy4SuXAKceaLrtekXmlP2C4DjHewzdvSO7caSVKZSw6/
 rd+gBQldzOGtVaLrkEUwf+biDb5AySU=
X-Proofpoint-ORIG-GUID: 0yP90-y_7zf2UoRoJSOZBtRbF2SEjDY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210174
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 15/9/26 16:55, Brian Cain wrote:
> The HVX register file belongs to an extension context, not a hardware thread.
> Model each system-emulation context as a QOM device, link the contexts to
> each vCPU, and use SSR:XA to select the active context.
> 
> Keep one embedded context per linux-user CPU.  Carry the selected register-file
> base with HVX operands so translated code can address the selected context
> at run time.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon.h             |   1 +
>   include/hw/hexagon/hexagon_hvx_context.h |  27 +
>   target/hexagon/cpu.h                     |  25 +-
>   target/hexagon/cpu_helper.h              |   1 +
>   target/hexagon/gen_tcg_hvx.h             | 608 +++++++++++++----------
>   target/hexagon/genptr.h                  |   8 +
>   target/hexagon/mmvec/macros.h            |  14 +-
>   target/hexagon/translate.h               |  11 +-
>   hw/hexagon/hex-subsys.c                  |  36 ++
>   hw/hexagon/hexagon_hvx_context.c         |  84 ++++
>   target/hexagon/cpu.c                     |  30 +-
>   target/hexagon/cpu_helper.c              |  82 +++
>   target/hexagon/gdbstub.c                 |  16 +-
>   target/hexagon/genptr.c                  | 102 ++--
>   target/hexagon/machine.c                 |  12 +
>   target/hexagon/op_helper.c               |  37 +-
>   target/hexagon/translate.c               |  60 ++-
>   hw/hexagon/meson.build                   |   1 +
>   target/hexagon/hex_common.py             | 179 ++++---
>   19 files changed, 886 insertions(+), 448 deletions(-)
>   create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>   create mode 100644 hw/hexagon/hexagon_hvx_context.c


> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 97f689fda22..df4c0182247 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -29,6 +29,7 @@
>   
>   typedef struct HexagonTLBState HexagonTLBState;
>   typedef struct HexagonGlobalRegState HexagonGlobalRegState;
> +typedef struct HexagonHVXContextState HexagonHVXContextState;
>   
>   #include "cpu-qom.h"
>   #include "exec/cpu-common.h"
> @@ -49,6 +50,7 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>   #define REG_WRITES_MAX 32
>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>   #define VSTORES_MAX 2

Could this simplify #ifdef'ry maintenance in source?

   #ifdef CONFIG_USER_ONLY
   #define HVX_CONTEXTS_MAX 1
   #else

> +#define HVX_CONTEXTS_MAX 8

   #endif

>   #define MAX_TLB_ENTRIES 1024
>   #define THREADS_MAX 16
>   
> @@ -120,6 +122,11 @@ typedef struct {
>   /* Maximum number of vector temps in a packet */
>   #define VECTOR_TEMPS_MAX            4
>   
> +typedef struct HexagonHVXContext {
> +    MMVector VRegs[NUM_VREGS];
> +    MMQReg QRegs[NUM_QREGS];
> +} QEMU_ALIGNED(16) HexagonHVXContext;
> +
>   typedef struct CPUArchState {
>       target_ulong gpr[TOTAL_PER_THREAD_REGS];
>       target_ulong pred[NUM_PREGS];
> @@ -159,11 +166,15 @@ typedef struct CPUArchState {
>       target_ulong llsc_val;
>       uint64_t     llsc_val_i64;
>   
> -    MMVector VRegs[NUM_VREGS] QEMU_ALIGNED(16);
> +#ifdef CONFIG_USER_ONLY
> +    HexagonHVXContext hvx_ctx;
> +#else
> +    HexagonHVXContext *hvx;
> +#endif
> +
>       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
>   
> -    MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
>   
>       /* Temporaries used within instructions */
> @@ -196,6 +207,7 @@ struct ArchCPU {
>       CPUHexagonState env;
>       HexagonCPUConfig cfg;
>   #ifndef CONFIG_USER_ONLY
> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
>       HexagonTLBState *tlb;
>       uint32_t boot_addr;
>       HexagonGlobalRegState *globalregs;
> @@ -204,6 +216,15 @@ struct ArchCPU {
>   #endif
>   };
>   
> +static inline HexagonHVXContext *hex_hvx(CPUHexagonState *env)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return &env->hvx_ctx;
> +#else
> +    return env->hvx;
> +#endif
> +}



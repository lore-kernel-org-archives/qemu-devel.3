Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118BECA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJ6q-0004ht-98; Thu, 01 Oct 2026 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCJ6Y-0004gy-1k
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:53:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xCJ6V-0005Xe-4x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:53:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Dwr2V2008492
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 15:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y0z9kMt+MOeCbUbci/hZcD75nQl/AriPQU/2ISYYsBY=; b=IfUQe7r0Jp3qE73v
 6HY/bvIGUC2fNjo6Jew7dnIIa/Q5DsjcgjgYsqWmmd9Ll2c9swkYyOD4oNDYAWte
 8cEDfKL7xp31GVkcQYCunpdRztSCbTSRcYIPtGEWM8LQ1mo+ZXa6Uw0wNihNoMv2
 MeXb9AeljlgxgwDrBw1xmzjhWgG0m35pg1ZTrfmeNs5dLvsNXSINbj+EkorSnxht
 iLZ61Lj/gaNdqQWRHP1mMhjX93d/D7uGaxYlJ/WW9PY0R2I3bWtoKyK7rQwoZTBe
 B/sqv6v54cCBazqF0VrfmnjvmzBDmhjns1D31T2rA4LgxieDlUv45vT4lK3cMfNB
 HU2SWA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvq8hxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:53:48 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7c02e1df088so49795137.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790870027; x=1791474827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y0z9kMt+MOeCbUbci/hZcD75nQl/AriPQU/2ISYYsBY=;
 b=cWeDTSkAul/1vNdocINXGDTrI0U9ykg74JO4NkYpfsIYgCKAITRRAlpXVnlVgfJHeq
 9vhXE7X/RWFdkNnl8FVJlgLWGTMbJgHyWC9YZUzObVek0Jz2t9sisG2bzvsIAzH51GDJ
 6LF+2QJb/ZFxoB6KmFwUITIbRoYWorFkMgeiCNXT7+jyPKSCat2D8Vff6n4JC/r7e1vg
 XSpMETYrQabf/IUsJJP2ds0KdbsyY5D97z08D3xXWAg8G0K2/2aZl4ddCJpG4mw0tR25
 doAJ7gi0aoep0D7QRTTkwMcZaxSz+2E9Y3Y0TttjKXxAstbXW4W/urhT36PBWjT6l/Io
 sP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870027; x=1791474827;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0z9kMt+MOeCbUbci/hZcD75nQl/AriPQU/2ISYYsBY=;
 b=lBNQua5UxdRwbePjfkIJ7ikGKbULzmgMKNRhQ3B1OShOvLzVsO3cU6P3PvNnyUeTce
 qcntDvHYp23XMmwsI9s4IZZbAoiJcQ5jjeOGch5L29C6a7qyCMScjTFxjAWNYZR1t7sF
 +b4FLOhcgMoaXe+2+psLtcVJCsIB0QewFSQ8oI2yNBinPpYwZ7Ojc+Yn3YA7v/56++oy
 4mStAn1iq2h4Y0ElO7faJXz+BN6oBjBnZzGFEwuZU63nV9R+u+dLPasBgavdjXj9OgIT
 DVQRpJw2Z3+loVwA3pWc29jUfhJuGc1dd3Qy2usaqQJCEyK7nycEpYZGpRRD/p/PprrW
 o9tg==
X-Gm-Message-State: AFq9FYJHI1XG2ezH26iKBwU+k61SN42vfL7/bvPr/EG3NMdYuHqoxfyf
 +n9Jn0uT4wTlgN2UG6umc3n/KBzjVAXV5zIRftJENlB8BE8G2N1UoVg/bmnucL+oEeKtfa+BsdL
 Yw/8fzLRdBKBugP474Bz/m7tUl90oibCHn/0GyFITRYqss0iQguNmgRUeBqbrbOe3+EVn
X-Gm-Gg: AYBFou0iIS6Zmra2nn/TEWk8h7xsAtFnUWZ4s87Bk/GrjhTuClx/fa/1VWU609w9jJJ
 c96j5uvYooTdmMA44q02CSFeiqLOxWIJDxYr1fQ2xwQL3Oxrr2mFOrXGBWxjk1fjYYcadH2ragG
 JdCprlWCn+ZEwyHiHz9c6zSHaLFHcx0qQgts8XGze4kH1WZJnZpCYBmwHv8yzKjCu9W1xxX5KVe
 inGoKRjGWArs+jQRMAcVKd64zeEjuZoezEOZIChMmxSdskijwjfhtW0xpXqA/Y4ndyZewRyOqeJ
 oIPY3JmyMsQsr5AYi++nWghQu8Qy+0+2mN2JrfZvvKAGkpX/cCFXyzwxoLprIfmZghn8+N5BYAh
 Y3v6PWuKD3I6pK0l8uBea5hIewBgfoKJdkw==
X-Received: by 2002:a05:6102:4488:b0:7a1:f7d2:e832 with SMTP id
 ada2fe7eead31-7be730a383amr1268674137.18.1790870026998; 
 Thu, 01 Oct 2026 08:53:46 -0700 (PDT)
X-Received: by 2002:a05:6102:4488:b0:7a1:f7d2:e832 with SMTP id
 ada2fe7eead31-7be730a383amr1268660137.18.1790870026370; 
 Thu, 01 Oct 2026 08:53:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b10d948d1sm1751610f8f.4.2026.10.01.08.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 08:53:45 -0700 (PDT)
Message-ID: <80ced4bc-202b-4223-866f-62a68edff48f@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 17:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/21] target/microblaze: prefix helper conflicting
 with other arch
Content-Language: en-US
To: luoyonggang@gmail.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
 <20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_XCgvZLZL8xpRcyw9b_vNXA3w8fmnbd0X4q_-8wjtoxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE_XCgvZLZL8xpRcyw9b_vNXA3w8fmnbd0X4q_-8wjtoxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MyBTYWx0ZWRfXyvULlKnfax8a
 TA+I2IoWumNTduP/LU7po8CvbRxMfFx+KXKTIYampR2M/V7azOwCC90PBzMNAs47Cx4fXkWkP44
 l0gAQiPHhXyu8WITYT2GhSWXf3ninQBdP/BaOYLSjRP/CLwDfG9sYrPEjFPoOhmlfF91sKHIgcQ
 6INO7k8z6whgLoMUOO+sjhK0nf3gOFKBrx5d8T1UQsFa0PoRvl2GjpC5+t41NSMuv91hi62b84q
 sLuDH22kpy9pB1M4qOllXd9fdwrhN3n9l25XUCsMP+DoFXiFs/a8PPFfjI2q8/3t3qMLXK52nDU
 n428OvGz17VRzrGc9TYHRH86wvtUizh9NH1AlcqIqKNFawgXqZv01Gu7cEfWkhXDG6UPJEcET0M
 T7y7uCJgt22QPAQzj008yPgWwnOezvTq4ZI4JD7jeW1kDDS88qu/kJLgzDMBUYNn73G+NxAlWPy
 ziKEgtjydWvm/LIAArg==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abe820c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HhcS3YDnCsCj6G8ZmPcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: jWZJ3XUlYZQhUPCcf9R-zYJHom4vlKXW
X-Proofpoint-ORIG-GUID: jWZJ3XUlYZQhUPCcf9R-zYJHom4vlKXW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MyBTYWx0ZWRfX6SdTYh/uWnB5
 xu9yOqyZWWt7ImEcf0V1r9vlkrxXLKE+IvW1zTeLRfF0j01E0UlgVX5fRRfjrDpbDkKr0GeeFLp
 jN56KXJ44vP35Q88/7vDX9uuHRRoH60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010063
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

On 1/10/26 13:41, Yonggang Luo wrote:
> Hi Pierrick
> I have prepared:
> 
> Subject: [PATCH v2 4/6] tcg: namespace target helper symbols for combined builds
> at
> https://lore.kernel.org/qemu-devel/20260930073935.712-5-luoyonggang@gmail.com/
> 
> to deal with these issues in a generic way.

Thanks for proposing a generic way to rename helpers! Let's see
what Richard (the maintainer of this area) think about it first.

> 
> The idea is comes from Philippe at
> 
> https://lore.kernel.org/qemu-devel/816d8db4-ef58-4eab-be12-6d239300ffe4@oss.qualcomm.com/
> 
> That would help us to avoid these renames. do not have to be such way,
> but it's a option.
> 
> On Wed, Sep 30, 2026 at 10:04 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/microblaze/helper.h    | 10 +++++-----
>>   target/microblaze/op_helper.c | 10 +++++-----
>>   target/microblaze/translate.c | 10 +++++-----
>>   3 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
>> index 1429c1727ef..63a94ac4bbc 100644
>> --- a/target/microblaze/helper.h
>> +++ b/target/microblaze/helper.h
>> @@ -1,15 +1,15 @@
>> -DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
>> +DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
>>
>>   DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
>>
>> -DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
>> +DEF_HELPER_FLAGS_3(microblaze_fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
>> -DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
>> -DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
>> +DEF_HELPER_FLAGS_3(microblaze_fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
>> +DEF_HELPER_FLAGS_3(microblaze_fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
>>   DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
>> -DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
>> +DEF_HELPER_FLAGS_2(microblaze_fsqrt, TCG_CALL_NO_WG, i32, env, i32)
>>
>>   DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
>>   DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
>> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
>> index 3da0c68da39..c169312e954 100644
>> --- a/target/microblaze/op_helper.c
>> +++ b/target/microblaze/op_helper.c
>> @@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
>>       return 0xdead0000 | id;
>>   }
>>
>> -void helper_raise_exception(CPUMBState *env, uint32_t index)
>> +void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
>>   {
>>       CPUState *cs = env_cpu(env);
>>
>> @@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
>>       }
>>   }
>>
>> -uint32_t helper_fadd(CPUMBState *env, uint32_t a, uint32_t b)
>> +uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
>>   {
>>       CPU_FloatU fd, fa, fb;
>>       int flags;
>> @@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
>>       return fd.l;
>>   }
>>
>> -uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
>> +uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
>>   {
>>       CPU_FloatU fd, fa, fb;
>>       int flags;
>> @@ -198,7 +198,7 @@ uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
>>       return fd.l;
>>   }
>>
>> -uint32_t helper_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
>> +uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
>>   {
>>       CPU_FloatU fd, fa, fb;
>>       int flags;
>> @@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
>>       return r;
>>   }
>>
>> -uint32_t helper_fsqrt(CPUMBState *env, uint32_t a)
>> +uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
>>   {
>>       CPU_FloatU fd, fa;
>>       int flags;
>> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
>> index 8b219afb5dd..16794059a22 100644
>> --- a/target/microblaze/translate.c
>> +++ b/target/microblaze/translate.c
>> @@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
>>
>>   static void gen_raise_exception(DisasContext *dc, uint32_t index)
>>   {
>> -    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
>> +    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
>>       dc->base.is_jmp = DISAS_NORETURN;
>>   }
>>
>> @@ -421,10 +421,10 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
>>   DO_TYPEA(cmp, false, gen_cmp)
>>   DO_TYPEA(cmpu, false, gen_cmpu)
>>
>> -ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
>> +ENV_WRAPPER3(gen_fadd, gen_helper_microblaze_fadd)
>>   ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
>> -ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
>> -ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
>> +ENV_WRAPPER3(gen_fmul, gen_helper_microblaze_fmul)
>> +ENV_WRAPPER3(gen_fdiv, gen_helper_microblaze_fdiv)
>>   ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
>>   ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
>>   ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
>> @@ -447,7 +447,7 @@ DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
>>
>>   ENV_WRAPPER2(gen_flt, gen_helper_flt)
>>   ENV_WRAPPER2(gen_fint, gen_helper_fint)
>> -ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
>> +ENV_WRAPPER2(gen_fsqrt, gen_helper_microblaze_fsqrt)
>>
>>   DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
>>   DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
>> --
>> 2.43.0
>>
>>
> 
> 



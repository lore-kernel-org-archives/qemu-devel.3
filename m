Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2409606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B0St17dR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=REv2d9Ww
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKA6D-0002M8-Sa; Fri, 23 Oct 2026 03:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKA6C-0002Ls-GJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 03:54:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKA6A-0002nj-8Y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 03:54:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FPkI1048714
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dZOSBMkopycj45bnSGg75CzKfcLNCuen8gKpgJHP5ZI=; b=B0St17dR0sRFEPkY
 Z4Rd5LCT+trFmJX1dTNyjOyfaox6bBKpEUv2G8rw1YeY/KvZxtMNxkbNoD0DQIZf
 GNOEubGSZ8wT2QEPPmYIuCfjDiyM/6U8IHaKTgZ+ZfjLRrv/k8m2uyTJ9d/XEmvN
 9x+d7Ua6ZYHs7mTJVM6fShZCyGWb5pikhaLL9vEo4/Zh0fnPd3C/oEvYd9kti0St
 WEUEcd3IM7xL0er1ptOhp3SaxePXCfgTnWZH8Rn3DVi8AODP5sM+hAHoeTGSW6VW
 Rh+zw7zp57rMXfY5jsv41Z3JzvFTuF/Mn8hlymbDnk355TCwVP2OIDK6kFCfo3tq
 TSrGUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbjmkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:53:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso74431885a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792742035; x=1793346835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dZOSBMkopycj45bnSGg75CzKfcLNCuen8gKpgJHP5ZI=;
 b=REv2d9WwpVte9NnXSB7WZ0/SMX9iUiNP4cc9l9bX8ehxjjiTwKC/lElfnEfm+w+KKV
 HhJK5mBUSii8GFqdfnLobl0LgCZNGhIwjiyqUVmoSOO+lWR3vOuhkFWj7n3kVkAdYYI/
 CxEm6CHbyh7LbBVIortLPJco/ASNM+9FMSa3YFPMUJoXKFbgFYQC/VyTRd0KVbZNenoh
 BCVq7seTRXnui/Q0RoAWOnODP76CPL6Fu/GeKeWxK0G73/H2ecHqCnmfiYHoH6Q9H4sJ
 qSBtEnxu36H9B4j7b2l2tYUlSzdNiiihMDGvIOnSC745LcDvWU2MhW0Rdhbh2HNIDv9g
 dylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792742035; x=1793346835;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dZOSBMkopycj45bnSGg75CzKfcLNCuen8gKpgJHP5ZI=;
 b=bjDAIj0TRbxMJv64/L1soOGhiB+8KEgPflpzXrC+XgVfAIGIHJGQktL+/visApI2g4
 onbWe0UIRAaAktRO2w69aVGGlsZ8QVtvkwcHK/gzQQziL5Yuh2hoxZNk1c4fVyZrKFQW
 LJImz34qaE4rC1kyEojX4/0FJTUfH+J2frh5AGWDBnIPmu48zadqFx+nhzhjBGkI3mAv
 ujbgtSEM1wVuxZ8EzNGwGufDc6VunUHDAr+xysKeHUjcyn8YS8kOFFcklJ80gfLPuDr/
 jidGA3Bj1qjRAHqYirDGIVu8a2Rcw1Uaov9sKv+nkILyS+h3+CPn1hr8K8UE4oFbsVjq
 kM8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByucd3CulmZoIiaUoGnmb0CJgL2WNFpQvjYKgRuril0G3q/qiA/7NRp0p/6O02hDUAh2Z4eH0SeMUCB@nongnu.org
X-Gm-Message-State: AFq9FYKtNnz2TKlgYXW9331f8TLGQ4yGaB3587T/vO1TXJUwZu6E0+Vo
 58qxg06yQ0SR8TP/IWYAt7Wvi+RbnOCsffIpvAePviQDcdlESrSEJ9gBsLj6ntM7sJZxmk3VVFV
 r/MOPrm7DRn8A+iUmVTCYtrpv2CqHUGZvmnLUgW4Ldudel+GVnJ6+hXEbwg==
X-Gm-Gg: AYBFou00rq81MRexdqgECCQj3PLMgtMxkyoilqxsdvgPsT0LG/LloJbCV86QRjzLCqp
 6KgqFc9HJZHerOuDD+xkDPo+XS6HrnlPw2qVpQ9M/46KCJ6mYxk4OgBYuTvpXlkB3zeAK7ZYUKV
 vkR+Hb6MTUEVK9sE5+tWzc67lOZ4KFtd063HRerYBKp9zLiAhPh54onqroBm8lYUXeAeZw2pvxb
 eX/KStzQsfLDVpVAhnWMvlhRSv6s5eAXuNhVSK8Z+bZ8djv0er5+L3qdwU+7ZSho7SQhLs9Z+X5
 LpJj2ebCP962l0rj0lIp0ZaUu/HzdD1/BSD93loGgl1+VfviNjBUuIYTVQ+O8h+9FMamjYzG91a
 sA4lhxwuDc69xZcuzGQt8N5NAeasLVolapQ==
X-Received: by 2002:a05:620a:1999:b0:939:ff11:5328 with SMTP id
 af79cd13be357-93f6f908fbdmr288375785a.24.1792742035323; 
 Fri, 23 Oct 2026 00:53:55 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:939:ff11:5328 with SMTP id
 af79cd13be357-93f6f908fbdmr288372985a.24.1792742034718; 
 Fri, 23 Oct 2026 00:53:54 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053b8asm3134568f8f.42.2026.10.23.00.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 00:53:53 -0700 (PDT)
Message-ID: <8299629b-7033-485c-8204-521e14e2f1d8@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 09:53:52 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261022130657.6449-1-anjo@rev.ng>
 <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
In-Reply-To: <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMSBTYWx0ZWRfX1T1TBpd6miHa
 z97OmOwpxFmA/kZZ/EhJI9PItaxrh9bTn7dmFiCofQ7a2aR6KSphFYCOmOymukUGWP4sV8d/o5W
 rAt6z9i7ugD+ZMT2lyQYId0CCfAkneQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMSBTYWx0ZWRfX8FL9zm2YZ3HS
 8bcBWGfraoVQYpzwiU2viuwzceHB/wte4tM4+kZWlrLcGqu3QSpoH7NErHafsGFKjraYl96yL3o
 9gJmLxS8YfNzg8u466BykP5JXFTvYGWKdjuHUnPZeok66MMoQQxsYAc1JaG9HECi4P5tnMtZ/N4
 m6DNN8c7HT0A4fa7VWMKwpvqULncay4GxTVlRzTdEwvUUvygf9cVbGmsamJ2HQL3JyPviUnjJwo
 RByshbZxisP/4aha/s1alut/3eN54FSopmPUTY0OuD2f/EFtZKmAZSRtkkLj6UPsAFlp34ha6RI
 BXq5YehwVBMVdouaUHHUTruPdHbm7E1v6N4oBslYgiM0gRJ6gpd4WalLrH7KWDfaaLnkkuaHTzE
 Xs4pgbmJYSs8Nw+vfWWZVECspZRDC3xA3C8cX+xK798oHDd+Qfo87ZWaX424+BDE2XkYPb4n1ml
 mGWB0RRU6cs6Edwmdyg==
X-Proofpoint-ORIG-GUID: WMirSwoKyPs_COd3r3oIiIfZ7x0DN5MO
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6adb1294 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=7ftFQlNOMX_Y_0ZeWucA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: WMirSwoKyPs_COd3r3oIiIfZ7x0DN5MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230031
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 09:37, Philippe Mathieu-DaudÃ© wrote:
> On 22/10/26 15:06, Anton Johansson via qemu development wrote:
>> mstatus and mstatus_hs are uint64_t but accessed through
>>
>>    tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
>>
>> which on a big-endian host running riscv32 incorrectly accesses the
>> top 32 bits rather than the lower bits.
> 
>    mstatus and mstatus_hs are uint64_t, but mark_fs_dirty() and
>    mark_vs_dirty() update them with tcg_gen_[ld|st]_tl().
>    On big-endian hosts with 32-bit target_ulong, this modifies
>    the upper half instead of the lower one, so the FS/VS dirty
>    bits are never set. Use 64-bit accesses instead.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 284d697c74e ("target/riscv: Merge m/vsstatus and m/vsstatush into 
> one uint64_t unit")
> Fixes: 8e1ee1fb571 ("target/riscv: rvv-1.0: add translation-time vector 
> context status")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
>> Widen the operations to 64 bit so the lower bits are modified.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
>> index ede9c2563f..79b0f444ef 100644
>> --- a/target/riscv/tcg/translate.c
>> +++ b/target/riscv/tcg/translate.c
>> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, 
>> int rs1, TCGv offs)
>>    */
>>   static void mark_fs_dirty(DisasContext *ctx)
>>   {
>> -    TCGv tmp;
>> +    TCGv_i64 tmp;
>>       if (!has_ext(ctx, RVF)) {
>>           return;
>> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>>           /* Remember the state change for the rest of the TB. */
>>           ctx->mstatus_fs = EXT_STATUS_DIRTY;
>> -        tmp = tcg_temp_new();
>> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>> +        tmp = tcg_temp_new_i64();
>> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>>           if (ctx->virt_enabled) {
>> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>> mstatus_hs));
>> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
>> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, 
>> mstatus_hs));
>> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>> mstatus_hs));
>> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
>> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, 
>> mstatus_hs));
>>           }
>>       }
>>   }
> 
> Wondering about being safe (or catching other bad uses)
> 
> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
> #define TCG_ENV_SIZE_(f)    sizeof_field(CPUArchState, f)
> 
> #define tcg_gen_ld_env_tl(ret, f)                               \
>      do {                                                        \
>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) !=                   \
>                            sizeof(target_ulong));                \
>          tcg_gen_ld_tl(ret, tcg_env, TCG_ENV_OFS_(f));           \
>      } while (0)
> 
> #define tcg_gen_ld_env_i64(ret, f)                              \
>      do {                                                        \
>          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) != 8);               \
>          tcg_gen_ld_i64(ret, tcg_env, TCG_ENV_OFS_(f));          \
>      } while (0)
> 
> or even using _Generic:
> 
> #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
> #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
> 
> #define tcg_gen_st_env_i32(arg, f)                              \
>      _Generic(TCG_ENV_FIELD_(f),                                 \
>               bool:     tcg_gen_st8_i32,                         \
>               uint8_t:  tcg_gen_st8_i32,                         \
>               int8_t:   tcg_gen_st8_i32,                         \
>               uint16_t: tcg_gen_st16_i32,                        \
>               int16_t:  tcg_gen_st16_i32,                        \
>               uint32_t: tcg_gen_st_i32,                          \
>               int32_t:  tcg_gen_st_i32)                          \
>          (arg, tcg_env, TCG_ENV_OFS_(f))
> 
> #define tcg_gen_st_env_i64(arg, f)                              \
>      _Generic(TCG_ENV_FIELD_(f),                                 \
>               uint64_t: tcg_gen_st_i64,                          \
>               int64_t:  tcg_gen_st_i64)                          \
>          (arg, tcg_env, TCG_ENV_OFS_(f))
> 
> #if TARGET_LONG_BITS == 32
> # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i32
> # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
> #else
> # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i64
> # define tcg_gen_st_env_tl  tcg_gen_st_env_i64
> #endif

I added that to "tcg/tcg-op-env.h".

> 
> Then replacing (a cheap replacement that can be done with coccinelle
> spatch):

-- >8 --
@@
expression R;
identifier F;
symbol tcg_env;
type T;
@@
(
- tcg_gen_ld_tl(R, tcg_env, offsetof(T, F))
+ tcg_gen_ld_env_tl(R, F)
|
- tcg_gen_st_tl(R, tcg_env, offsetof(T, F))
+ tcg_gen_st_env_tl(R, F)
)

@@
expression R;
identifier F;
symbol tcg_env;
identifier T;
@@
(
- tcg_gen_ld_tl(R, tcg_env, offsetof(T, F))
+ tcg_gen_ld_env_tl(R, F)
|
- tcg_gen_st_tl(R, tcg_env, offsetof(T, F))
+ tcg_gen_st_env_tl(R, F)
)
---

Converting i386:

-- >8 --
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dd417cb5341..abdf9b61ad1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -25,2 +25,3 @@
  #include "tcg/tcg-op.h"
+#include "tcg/tcg-op-env.h"
  #include "tcg/tcg-op-gvec.h"
@@ -706,5 +707,5 @@ static void gen_set_eflags(DisasContext *s, 
target_ulong mask)

-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_ld_env_tl(t, eflags);
      tcg_gen_ori_tl(t, t, mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_st_env_tl(t, eflags);
  }
@@ -715,5 +716,5 @@ static void gen_reset_eflags(DisasContext *s, 
target_ulong mask)

-    tcg_gen_ld_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_ld_env_tl(t, eflags);
      tcg_gen_andi_tl(t, t, ~mask);
-    tcg_gen_st_tl(t, tcg_env, offsetof(CPUX86State, eflags));
+    tcg_gen_st_env_tl(t, eflags);
  }
@@ -2447,4 +2448,3 @@ static void gen_x87(DisasContext *s, 
X86DecodedInsn *decode)
                               offsetof(CPUX86State, fpds));
-            tcg_gen_st_tl(last_addr, tcg_env,
-                          offsetof(CPUX86State, fpdp));
+            tcg_gen_st_env_tl(last_addr, fpdp);
          }
@@ -2756,4 +2756,3 @@ static void gen_x87(DisasContext *s, 
X86DecodedInsn *decode)
                           offsetof(CPUX86State, fpcs));
-        tcg_gen_st_tl(eip_cur_tl(s),
-                      tcg_env, offsetof(CPUX86State, fpip));
+        tcg_gen_st_env_tl(eip_cur_tl(s), fpip);
      }
@@ -3200,6 +3199,4 @@ static void gen_multi0F(DisasContext *s, 
X86DecodedInsn *decode)
                      tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
-                    tcg_gen_ld_tl(cpu_seg_base[R_GS], tcg_env,
-                                  offsetof(CPUX86State, kernelgsbase));
-                    tcg_gen_st_tl(s->T0, tcg_env,
-                                  offsetof(CPUX86State, kernelgsbase));
+                    tcg_gen_ld_env_tl(cpu_seg_base[R_GS], kernelgsbase);
+                    tcg_gen_st_env_tl(s->T0, kernelgsbase);
                  }
---

triggers:

../target/i386/tcg/translate.c:2449:13: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
  2449 |             tcg_gen_st_env_tl(last_addr, fpdp);
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:65:29: note: 
expanded from macro 'tcg_gen_st_env_tl'
    65 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
       |                             ^
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:47:14: note: 
expanded from macro 'tcg_gen_st_env_i32'
    47 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:16:29: note: 
expanded from macro 'TCG_ENV_FIELD_'
    16 | #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~
../target/i386/tcg/translate.c:2757:9: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
  2757 |         tcg_gen_st_env_tl(eip_cur_tl(s), fpip);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:65:29: note: 
expanded from macro 'tcg_gen_st_env_tl'
    65 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
       |                             ^
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:47:14: note: 
expanded from macro 'tcg_gen_st_env_i32'
    47 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
/Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:16:29: note: 
expanded from macro 'TCG_ENV_FIELD_'
    16 | #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

Both CPUX86State::fpip/fpdp fields are uint64_t, so the same class of
bug on big-endian hosts.

FAILED: [code=1] libqemu-i386-softmmu.a.p/target_i386_tcg_translate.c.o



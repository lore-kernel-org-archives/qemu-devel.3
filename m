Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322D1CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzXJ-0000S1-FQ; Tue, 23 Jun 2026 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbzXH-0000RW-Ea
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:43:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbzXF-0000yd-GK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:43:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBXsNQ3668900
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i7DPPuFl4ODusIQXB36pqSHZwTBVXE1kLjVym/Btkdc=; b=h+ZBGkgPzKwN3QSL
 c+0GE/z/BkbcJx2+tOyjY6GQVStrDYvDCz0GtbuD7d67Nd4F8Jx2R41TjvgzMhfn
 WYv4F2pnK1qmCXLPac74ZQLX6Cc9NEMPurJpIIi3YMkLkpUhRCtXdrMbItt2+91A
 J6dESjF26DO3rvqvee3ugLqDt3dsxm+Q75B6i6Sf3gNnmvxMQKgkdln3Y55R4P5f
 +q6pz0YfY7+VdfO7ADHY2M9QbJhyv/Hrf3S0vgCdqARs+kFbHSjqzmwSNL8jSr/W
 620wj3KGBXeM5hH6wEmdg7U/XN7b0RKk0+e1EEOvlDIXef06jLj97Lr3ldbEnnyr
 Kmf1Rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppygt0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:43:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517e054fe07so131373141cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782214998; x=1782819798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7DPPuFl4ODusIQXB36pqSHZwTBVXE1kLjVym/Btkdc=;
 b=TR6j1JP65UJDsRsYvHOv3xuRr8WSGvpeYFDrjI7LFZFKySROWbf+vnrhgMogZL4AL1
 +nv2A5ue/URPusXjm8gEzuRUZ1xonhn7Hj39H9W1h0KhgL8ekrrdq0ZM9b2toKK0pHbv
 h8rtVGg3wOpUUKwlR/5blvK5skS2r11WN0ymIpxj625hGy0unaif7cUWn92eSYnszkvD
 Fb21huW9uKoNbAxhSAb0BgGb7ZReLy7cjLpfLANgqX2qRNQCbtweoREUJcDFmLWOG+m4
 pmek0WFgftB0BYnMRvxv470PTuAEXqDOEMRLjawUsvp8e+kYngIZTdefP/1XkEQzSGgY
 ZurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782214998; x=1782819798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7DPPuFl4ODusIQXB36pqSHZwTBVXE1kLjVym/Btkdc=;
 b=eiL5JTtnVf57cl3ZA3MFAaqwXyekB5dti7GyDt8/I0GHNgsr5gfewUy4HWiWxzzEDY
 TqEqybzr2Vn6ZbuaflRcCArYzMTt6tofVdo19bNmsXPWRSDsDmCHnGglC5/E9W83pUq8
 PLDxp8TGcCMthwyMGzQ5ZRtQzduX1bIkxfZggrCqatYM5XqoKG9VLml7l7VTdgx/IdxJ
 M7M8mq7Gq1y9iq71KVaQaXJevjsiVyCoBF6eElhnLhTfKDXTNHfGex7P7U0Goy2X91S2
 gj20mbDL1ic3C9w8B/kMMoUUb13w1NCwm9ld5OfZTu9i1NwYRR5mxzocZt1psVAfcNSS
 5iMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eRfUELK8LwSfVidOaAY1m/b+rX1IUO4gaS6a3338cXm2il6zYGi1xFHY66nMsSMfYkNonfx05s8SC@nongnu.org
X-Gm-Message-State: AOJu0YysfceHZWU/E5miuqiLDqOYWxUNDIDDc0khzDKIekcg8+3Il8du
 nWOWunSx5qw4dc5ZMi9dt2nJAyyQ/vSFLZRTcCfeZ8xDvVakv9K5x0c9THJT8Zw5RNaZ1di68PZ
 2LeHXIck7J2yW3lFymLLftMx+7KKA0rhpssi+Ba2SNpjIkr6U/9TYdmeUaQ==
X-Gm-Gg: AfdE7ckvGyHyYcWVbqfO7DUC9wBNDJto3dilSIv3YEIPdKSW1ueMLx4gZXtGnkU8kJB
 RNbijz7jHdhw6yb1ZG2Lyzh4+tu5/xpqpck03auzAV+KLEs488ntkeuk4dCC4s2+4oAE2ZXEgVL
 N9TE0up4v6uTwATZRw7E/1SF2nrQVsSle/U/ZVkag6nqCYZRxnDunelTeTBazNy34CKmzTKWUjQ
 NP9Mc+miekuvbu9f9NLax5I9KFQhf9ZFc3jFSCDUD4BmSNaUivxUdT3HoRzTFTQQOVdj6KSWDbH
 wYuGxN8uH8o4gO0yFcJjEMRMSTAZXAD1bSFPU3HV77zl2439BZoTU5lOD/GHBwbI/Dk/vq4srE+
 /hNZLU3/Rvh50BYdwepCImx6RCv3ovk6fqxeQ2IF3KH9V
X-Received: by 2002:ac8:5cd2:0:b0:517:9407:5c35 with SMTP id
 d75a77b69052e-51a56257cc1mr27599761cf.47.1782214996023; 
 Tue, 23 Jun 2026 04:43:16 -0700 (PDT)
X-Received: by 2002:ac8:5cd2:0:b0:517:9407:5c35 with SMTP id
 d75a77b69052e-51a56257cc1mr27597381cf.47.1782214992810; 
 Tue, 23 Jun 2026 04:43:12 -0700 (PDT)
Received: from [192.168.15.10] ([187.35.50.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a514b5128sm21156581cf.6.2026.06.23.04.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 04:43:12 -0700 (PDT)
Message-ID: <eb05e157-a661-455a-a7aa-4f2e37d51033@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 08:43:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] target/tcg: Rename set_rounding_mode() helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260623110209.26861-1-philmd@oss.qualcomm.com>
 <20260623110209.26861-5-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623110209.26861-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5NiBTYWx0ZWRfXwiCaEGLxDfcP
 dtQIMZRKqW0MczTSwPsx0J+QOAsygJ3xBzha78bh+q0IaovfU/8NP1q+KhLKc2w6maTCMyn8AMr
 2tud+wVrDrBxivMZ+Q5ctLL+eDjRAVPa8MAGTZjebI16xck/eE9Gmtn2kNNWcNGyUn0uev6qVQ+
 sJZUf8DjmGNwIcSMmVBCDTmbveluFczT6qfeEggDcdENhoimwagFgTFurw88fFNIiBXV3kZKpv2
 FgPhPKzIrms3ZuRvzzsZmdHH4asOH1r/YnZP7gc2izLbHUEVhNKbMrDozp6PrqmxpRZ9HnBBrn8
 VZw0wRsa/vCi7Mi8i2DHzTLQyfP4ckwsh03KPRid1hTEjdxwmMUutS/dofg/+BpKNN+htoSD/vB
 2YqI5MCrXrDBbNGMVO/VCJakKt3FevRQxmUbmYV/ByBqSNQtm43s7GdqpizEy7aENvM9WLxQ/I3
 wxaygTkA99c0zIR0ltg==
X-Proofpoint-GUID: B6fFIW_aCqxF5gX5snKflrz9BKYW37Kk
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a7156 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4zNbLBpji/9weHA2+kqC8A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=anpdLP3TX50KqTV9x4gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5NiBTYWx0ZWRfX9OrsSVD6Jj0U
 /snfG4n0bN3RWkF4WwkFtxAgfbZSPAZPWSx6TUSrlOu0C9EiFgkmbeeMBKAMARiXEbwBeOtZAlT
 Q17Ye5T6tc3pbW0xeoBOXElQfNbJiEY=
X-Proofpoint-ORIG-GUID: B6fFIW_aCqxF5gX5snKflrz9BKYW37Kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230096
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/23/2026 8:02 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> In order to avoid symbol name clash when building
> a single binary, rename TCG helpers prefixing with
> the target name.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> ---
>   target/loongarch/tcg/helper.h                    | 2 +-
>   target/riscv/helper.h                            | 2 +-
>   target/loongarch/tcg/fpu_helper.c                | 2 +-
>   target/riscv/fpu_helper.c                        | 2 +-
>   target/riscv/translate.c                         | 2 +-
>   target/loongarch/tcg/insn_trans/trans_fmov.c.inc | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 35b055eb3bc..154e70c0191 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -91,7 +91,7 @@ DEF_HELPER_2(ftint_w_d, i64, env, i64)
>   DEF_HELPER_2(frint_s, i64, env, i64)
>   DEF_HELPER_2(frint_d, i64, env, i64)
>   
> -DEF_HELPER_FLAGS_1(set_rounding_mode, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(loongarch_set_rounding_mode, TCG_CALL_NO_RWG, void, env)
>   
>   DEF_HELPER_1(rdtime_d, i64, env)
>   
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 542b7c264fc..6f46e0d91d4 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -2,7 +2,7 @@
>   DEF_HELPER_2(raise_exception, noreturn, env, i32)
>   
>   /* Floating Point - rounding mode */
> -DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
> +DEF_HELPER_FLAGS_2(riscv_set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
>   DEF_HELPER_FLAGS_2(set_rounding_mode_chkfrm, TCG_CALL_NO_WG, void, env, i32)
>   
>   /* Floating Point - fused */
> diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
> index fc9c64c20a8..265f608cddd 100644
> --- a/target/loongarch/tcg/fpu_helper.c
> +++ b/target/loongarch/tcg/fpu_helper.c
> @@ -878,7 +878,7 @@ uint64_t helper_ftint_w_d(CPULoongArchState *env, uint64_t fj)
>       return fd;
>   }
>   
> -void helper_set_rounding_mode(CPULoongArchState *env)
> +void helper_loongarch_set_rounding_mode(CPULoongArchState *env)
>   {
>       set_float_rounding_mode(ieee_rm[(env->fcsr0 >> FCSR0_RM) & 0x3],
>                               &env->fp_status);
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index db1475271b6..88261b223cc 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -66,7 +66,7 @@ void riscv_cpu_check_fflags(CPURISCVState *env,
>                               FloatExceptionFlags pre_fflag) {}
>   #endif
>   
> -void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
> +void helper_riscv_set_rounding_mode(CPURISCVState *env, uint32_t rm)
>   {
>       FloatRoundMode softrm;
>   
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9684dbe7528..d5c3366fd94 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -759,7 +759,7 @@ static void gen_set_rm(DisasContext *ctx, uint8_t rm)
>   
>       /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
>       decode_save_opc(ctx, 0);
> -    gen_helper_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
> +    gen_helper_riscv_set_rounding_mode(tcg_env, tcg_constant_i32(rm));
>   }
>   
>   static void gen_set_rm_chkfrm(DisasContext *ctx, uint8_t rm)
> diff --git a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
> index 5cbd9d3f347..c4c4c2000f7 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fmov.c.inc
> @@ -112,7 +112,7 @@ static bool trans_movgr2fcsr(DisasContext *ctx, arg_movgr2fcsr *a)
>        * Note that FCSR3 is exactly the rounding mode field.
>        */
>       if (mask & FCSR0_M3) {
> -        gen_helper_set_rounding_mode(tcg_env);
> +        gen_helper_loongarch_set_rounding_mode(tcg_env);
>       }
>       return true;
>   }



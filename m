Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE73F99377
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsCw-0000Jd-GX; Thu, 23 Apr 2026 07:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFsCv-0000J0-8e
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:26:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFsCq-0001kV-Q5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:26:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8u2ZQ366223
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tFtei8dTDAGZ/8Vww0MDA74IwUnMDAFK3hh9owBJ6BU=; b=EGnTMLrefsQ5DWnS
 F5uAmXEz018X21y/BT0G55mrdasSVxW/4y9upa6etj7RlG1dg6OVO1/OZ8fjGf7y
 DY773V+rxceiTToEpVbgepCwatIVC5E0gVL8Q5wLUdKymlqv3zdUSSWsQmKSgYBK
 vsZfvX39Xa4vXdt555EZeWc2yjgKiu8DM9jbfcNqY/Y0lzg59VoOowDlamNIMQWQ
 xBCIcUl65ia6vYfRPv4gv6NmlA3bAzPBE4XzBpkIa5YISOeGoIBWxQMpXh8iiJ4c
 DKZriJiczKQ6ruCL/7JURl0sf5CnnEdOX68ZdkbkobFCqdUU9XmQ1yQm/d2J1xSJ
 Nmlcjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35rb6m0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:26:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e575a50bcso59891581cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776943610; x=1777548410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFtei8dTDAGZ/8Vww0MDA74IwUnMDAFK3hh9owBJ6BU=;
 b=IObpKttfuIelfvqbPpzPBa52w8t7EZFLwjEVd0PhxtLxYia7ToWSGXDHAAZSrnbWy0
 8Te46VHK22rY5AQ0p2du2SlInd5ECD4cDUFL+1CUWN26Plfj/WicR3TaMkduipV6MsmM
 ZsT4I+ZNrTrjUbfl4Ub3B0mhPJHlp6FZrfdNpXBcavWBOR+t9yC99wIFC1zsts1Kyx7d
 x7CtErC99vm70yLNvSLnNhAhW7mD9mYLvTaqU1XzmG2dM+GIhr6pVcdKWX/N0ZeKqrqq
 0JJ45FRt8hUDrUABbMXKK0+rpw2ExziJtpct+sOH0cbkzoZPvmSpmCB25upjyY/+b4UY
 SgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776943610; x=1777548410;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFtei8dTDAGZ/8Vww0MDA74IwUnMDAFK3hh9owBJ6BU=;
 b=lxYTlJ+64V88at8Zqv5+C7WSbz0yoT5bg3bW4hxSu7oc8YCaNMkn6OIKqE1U3X6Nap
 PFAxfjyukdX1jj8lBYmH1nrTcvkGVzOQ+sfyavTAXG9tyUTcz33sdiiCycf2sbBorA64
 WgXU1SvnKIGLydNydQEr67PBTi2rpp5s3EOU1dmaqv3r8HBWvkEsSgr8V/nCqETbAcfJ
 CJpn9fb5GhLYqtwAIYbKNMhn9VsK873kLriW+mkpXdxLnYYw5xixTBfvDArz0m5fSTLF
 X6xHWtSTffcpYtxhvuF8HGe5NP3127UhuPmb0HsSvF1/ygc/kMfScWhAhvO2dSgbBQjd
 oKyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dO8J10nbQLuIbqLX0wwv4reu5vvl/JpDSKnnRRQXS0+Ysz2E6zdYYjNy/OWuVIKdOpYycqQCutquU@nongnu.org
X-Gm-Message-State: AOJu0YyPTOrNTsD4GyB/lM32UWEq9HItko6Ha83gCEOSKwKcai9PzWRi
 s+q7/RWC1r7jho/jWoFVRAMHKNGb7N3gjd7z1REsLZ/Pw3E962C4nt35amTXGlWg2TUKEsfiyr3
 8/cKZtgAgtlUmzTU4N4ZI0CpVBVhd8zVS4HErGC4rlrnS9E3dD20PkVvNug==
X-Gm-Gg: AeBDiev6EXSukcXbMpb1o3DICGNke3SlV9RL2dCkx7bSjP9lAaFCbvR6Wksik9N7PlH
 gvMg7nzOBWpS5x31T7D0n0ipAz++kGfjIc38XMGzaEQJ8AzPMCOFF2vdzHqDnLHp7PjZ6I/c62X
 iYwswSuv3zj3Pp4ckAsqgN0DeoewB0tkh9GryTPNYt67Ywk+jLRLEgf0wv7qD4DjTQwQKXVb0Vj
 xnVfhFENmVQmeEiwvSNSCPfZXcXCI38U95STl8wNVWFhQucTZZVftDRXw7PXouJE5RHXL6Z5wn8
 9Vo3VMaWjT5Jyg2fGLlShvWgPhBE+IlC2KQZ+KrLLsS7xxub5l7Vj2xhM7N8b/nvDHxyXqCKydB
 tqFdu8GjxiJqcT9OXIjd4ZfDDKyb7uRBfGf1UxKxmDiinVwYTUZRTv2kubtWRyy+uZB1k
X-Received: by 2002:a05:622a:1493:b0:50d:9e36:f961 with SMTP id
 d75a77b69052e-50e36834d02mr379141131cf.20.1776943609786; 
 Thu, 23 Apr 2026 04:26:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1493:b0:50d:9e36:f961 with SMTP id
 d75a77b69052e-50e36834d02mr379140581cf.20.1776943609194; 
 Thu, 23 Apr 2026 04:26:49 -0700 (PDT)
Received: from [192.168.15.12] ([179.118.208.147])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e40aab60dsm148342441cf.18.2026.04.23.04.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:26:48 -0700 (PDT)
Message-ID: <b014ecf6-9a63-40d0-b368-ec3977dd69d8@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 08:26:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Remove unused tcg_gen_vec_*_tl() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260423101904.36131-1-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423101904.36131-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDExMyBTYWx0ZWRfX52ojSXO36pjg
 OfzN1DRE/ZVpu18HeiGzv5CB7iAbrHdwfJYqv5ja7+yzjsD9Yuo0qi2rXgOf/musQy9FvsBWKJT
 ICW3PbnzIEVBpnPxBanblmgmcV1U1tSgexvsocedC/S7XSxVHx9KYHyQJAIvtnNs9gbe+ITiGUp
 xJxkpXuRENKUbrWKrJNT8+BxOOO1astHqvXM4k/X2pJiKq9XE6EUBFciLnnVjzCFzCFyTP6wTIJ
 bQV0m2gR0GSjx0yMu7n0/bcwSzHWAnCdxdUMIntivWNmdGg2gRSoohfQeq2wBiWOfJomRH27lMm
 5/bjTEclbm74c/0HcM+M3k25UB3KajuCEtQ/Wb+/pjKxQnuofGb8fNhiYfCde+pZ3g6qMzrohKz
 k07jNLO197YtQnsxqC91NXU4GfpYFhxm7jnw0uCQZtua9UVtxask94NTmZDzOQUqaqSh1fJP0Ed
 ko2MJOxRT5tmxe//OaA==
X-Proofpoint-ORIG-GUID: _VbmLHe_p-NR8tNx43lmRdfgyzHQQ14p
X-Proofpoint-GUID: _VbmLHe_p-NR8tNx43lmRdfgyzHQQ14p
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69ea01fa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=TkFQdvD96oRUceFd3B6Mgg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8
 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=69wJf7TsAAAA:8 a=4L11XYJztzJlIAJmmhEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 4/23/2026 7:19 AM, Philippe Mathieu-Daudé wrote:
> No code uses the tcg_gen_vec_*_tl() API. Better to
> remove it now, since to compile as translation unit
> files once we need to avoid target_ulong uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Now this file only defines tcg_gen_gvec_dup_tl(), which
> is used only once in target/riscv/insn_trans/trans_rvv.c.inc:
> 
> 2156 static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
> 2157 {
> 2158     if (require_rvv(s) &&
> 2159         vext_check_isa_ill(s) &&
> 2160         /* vmv.v.x has rs2 = 0 and vm = 1 */
> 2161         vext_check_ss(s, a->rd, 0, 1)) {
> 2162         TCGv s1;
> 2163
> 2164         s1 = get_gpr(s, a->rs1, EXT_SIGN);
> 2165
> 2166         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
> 2167             if (get_xl(s) == MXL_RV32 && s->sew == MO_64) {
> 2168                 TCGv_i64 s1_i64 = tcg_temp_new_i64();
> 2169                 tcg_gen_ext_tl_i64(s1_i64, s1);
> 2170                 tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
> 2171                                      MAXSZ(s), MAXSZ(s), s1_i64);
> 2172             } else {
> 2173                 tcg_gen_gvec_dup_tl(s->sew, vreg_ofs(s, a->rd),
>                       ^^^^^^^^^^^^^^^^^^^
> 2174                                     MAXSZ(s), MAXSZ(s), s1);
> 2175             }
> 2176         } else {
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Chao Liu <chao.liu.zevorn@gmail.com>
> Cc: qemu-riscv@nongnu.org
> ---
>   include/tcg/tcg-op-gvec.h | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
> index b0a81ad4bf4..d82ba6dfaac 100644
> --- a/include/tcg/tcg-op-gvec.h
> +++ b/include/tcg/tcg-op-gvec.h
> @@ -16,32 +16,8 @@
>   
>   #if TARGET_LONG_BITS == 64
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
> -#define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
> -#define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
> -#define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i64
> -#define tcg_gen_vec_sub16_tl tcg_gen_vec_sub16_i64
> -#define tcg_gen_vec_add32_tl tcg_gen_vec_add32_i64
> -#define tcg_gen_vec_sub32_tl tcg_gen_vec_sub32_i64
> -#define tcg_gen_vec_shl8i_tl tcg_gen_vec_shl8i_i64
> -#define tcg_gen_vec_shr8i_tl tcg_gen_vec_shr8i_i64
> -#define tcg_gen_vec_sar8i_tl tcg_gen_vec_sar8i_i64
> -#define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
> -#define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
> -#define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
>   #elif TARGET_LONG_BITS == 32
>   #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
> -#define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
> -#define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
> -#define tcg_gen_vec_add16_tl tcg_gen_vec_add16_i32
> -#define tcg_gen_vec_sub16_tl tcg_gen_vec_sub16_i32
> -#define tcg_gen_vec_add32_tl tcg_gen_add_i32
> -#define tcg_gen_vec_sub32_tl tcg_gen_sub_i32
> -#define tcg_gen_vec_shl8i_tl tcg_gen_vec_shl8i_i32
> -#define tcg_gen_vec_shr8i_tl tcg_gen_vec_shr8i_i32
> -#define tcg_gen_vec_sar8i_tl tcg_gen_vec_sar8i_i32
> -#define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
> -#define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
> -#define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
>   #else
>   # error
>   #endif



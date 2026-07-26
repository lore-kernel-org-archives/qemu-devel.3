Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B48C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 19:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo4aQ-0007Yi-89; Sun, 26 Jul 2026 15:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wo4a5-0007Wm-2s
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:32:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wo4a2-0004b8-9u
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 15:32:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66QH7Klg1211748
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SxXjLS0c0shKI4Zw13I8z0U2Tu7kInLW6O7FQlstPJU=; b=RhK7p1lD/tui5hur
 8w2ArJ+3d09Q+TP6xky+KbVWUbcNa+m18Yx9BdnyM4GrSoQjV2QsjXck42//udNV
 Iyqo8alAn0T2Yj+VS+iVpYoQyI5YSRmmO4eXgJF2f49hcKeZfokk1pVCIe7Nvw4A
 pEshM2GNvvwwZ44rIk3gnd1c63+iN81GdofWpaMkmxBX4YiAuu+x7E95R/XBtJMF
 8OJzyndkRjlerCpYSP58uRerhgUDiQvtvJha+tCfGluTyQkqLbS0MMtLn7+Key4G
 rapDQVzHzA9FI2kzbTeFfrpCmC43bSI2WDq6QXRUbcxmSo9lHGyZeniP8dZ8pK5m
 UgiyyQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmmfgupph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:32:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso24365191cf.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785094326; x=1785699126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SxXjLS0c0shKI4Zw13I8z0U2Tu7kInLW6O7FQlstPJU=;
 b=WtYurVpsYJlzrr9zUyTF1PMLaNC9+hiCrHwCE2diXJYMnnHG32zpW/184SbHChVqN2
 s2wQVcy5IYPPFmYnXNgOCuHpOFOT5iwptwaV3vfZ5gLDnJARa3O9ICRLmsXvCFRVHFNn
 UQGF/Grq5F9FDCLUQ3nfqN8yCkCp0CrOQQ5MxheOBD3AL9misqcg1cMTn58YeSxSQR5I
 vyDLKUsSVvfck/xfwa0St5hCFyBgtk589LxLD7LrQsE0gHjnsCCXtNMoA8Dmf5co+4xr
 shT+Gg5MNntbr7Eb1jhtqnufg5E9S9jtAwPnJy5v3QrzwADzng1vjRVF1Ukk4FZS9lpU
 4C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785094326; x=1785699126;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SxXjLS0c0shKI4Zw13I8z0U2Tu7kInLW6O7FQlstPJU=;
 b=fK1kLmjwAU0iPSxCltHP5Es4O+H162ZiFROcq+njMdIcbJ6LH6I4htZuxkZjP1yarS
 poxAOeERldO8+Y+up1E8vM1uBcEURn54cwL2jwHRidRwNJ4K32wtGgEl9mcWFfNILCBy
 6haxObvMBTAmrBu2ZxtbIm+CYmFhEZimt84GW4Q2L5x3KO2Hv8LwMEDiGLrCaUfc27Z9
 LSFMZr8oCj65WuX2Nh3VNz7hSPYT0VGGMGv9KO+UQ5ULrwOvwfEm9pN6et+k3cUfi97A
 fZ5s8F6tGvNCTeaJqQtunpsfEieRtX2eCgzfe9mcaI77m7BrqcZMQ5g8wRZpXksCpcHW
 uQJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP6UyyujOT7R55Jd8akXdf4gwPs+bmSIrUVZUPIabCp6cNFMfdE/wuZoalyzxQLufnhIqKM+TxUArt@nongnu.org
X-Gm-Message-State: AOJu0YxxU5PuWxLHrPNZ0KY4jOc9YiIpFotTHYcDxzhoczChCL3gMJOC
 Dz6h/bJPY8FN7NXiz+Yp4VQS623VP14s9UNj8eNDNen7KosMjiqFNAb2kPoy/7Lg4L8q2JneqQH
 1pn8+/zU16deM5rk0494mwAuc+bsa+MkAGWJFw7ZV4YcgIl/bM6WXPf525A==
X-Gm-Gg: AR+sD12+F1hwwNvhOrWoTUk1L1G8UmK0qWOwomOGqDJ706MjTzTYsxrUdVebmA7o4Vy
 flMuPp19jfNVKDYAmW3benUMlOyav1inc6l2Og/rr6JOaSxA+ak2fxHoq0szQP47RFOuYYqX5Vv
 5Vn53eGJWuW3SYrbgScF98SFWrEx5pjSHkqjteNQENKCaOAyJryDj1I2Veyzp08HvC5SqmoV9J7
 TtAPID1LFAx7ZM/WXZoeIYJAkhfqGnTuEB/RTNDjOCAesOSohESJQxhEhDm8ph6LZbHioYW/Dey
 UREfBiaxyQG7BkKOOmBfC3DGG2NTlDS9qFsCAp6SvZ8ppi2s1IE/Qp8qABXZ2KfUGLFacM5cxi+
 LPxURbHvsHrivwEkjFvHLbKFID8qd6eaYiZN1Dg==
X-Received: by 2002:ac8:5845:0:b0:517:642c:8196 with SMTP id
 d75a77b69052e-529a8314fb1mr63438911cf.12.1785094326517; 
 Sun, 26 Jul 2026 12:32:06 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:517:642c:8196 with SMTP id
 d75a77b69052e-529a8314fb1mr63438641cf.12.1785094325996; 
 Sun, 26 Jul 2026 12:32:05 -0700 (PDT)
Received: from [192.168.68.104] ([191.202.238.134])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529a29cf785sm39141471cf.21.2026.07.26.12.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 12:32:04 -0700 (PDT)
Message-ID: <d3dcfa41-de71-4c3e-a26e-38369aa48823@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 16:32:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] target/riscv: Add packed SIMD extension state
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <8b602c084875d5d5517958ffa3a25651c0bb41c1.1784280142.git.xiaoou@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8b602c084875d5d5517958ffa3a25651c0bb41c1.1784280142.git.xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WKYeMz8IMXxZWRZG_QTjk9GEB83Mq_aT
X-Proofpoint-ORIG-GUID: WKYeMz8IMXxZWRZG_QTjk9GEB83Mq_aT
X-Authority-Analysis: v=2.4 cv=GdYnWwXL c=1 sm=1 tr=0 ts=6a6660b7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=krItrnN2KmZux9Htc+7Wjw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rYItFhDN6sEr30t9ZrQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE5NyBTYWx0ZWRfXySHRZ206RdGp
 0ockZqHBCdAoWxnTFwfwP7YVf3pBWdEw3dkuz5XjAa8tdIf0/AgY8L/RYg91y7S+5G3bQ+2Xyp2
 CWC03fp2PO5G1liWHxpTIzi/OgXaq5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE5NyBTYWx0ZWRfX6JEeB5N3ZL+F
 2YUtj68zojsQFThKDi5/WbG8+8i0nH62t+OkE+AAtMibwltoxiSfUsorctNcmYi8oBleYJ5yMoZ
 0225Rc+95k7gg+03M3XEdTELYh6vBoNmWLME7AJEJpklCorQ0PPgLXxfxPYy1lf2PeWROXROZWH
 rO7vA9Sjmh0DUa60eRC6fUsVXKW950r4CZKDjdrJ84AphnmkTeSgs/+PWpG5C93kAFjXsdXPha3
 hI8hFeZs0K53jqqBOwMQ3dISc6t+y8aoSk1iaN3elz0kKjTcyLmGUlGZSrSKrNsAGPJgvbHbKjU
 qoeuiYPMOgxD+lKhcHtew2zxafSnMY304LGcbyoKxxI08Meb3hOd7cVRwCIHusU8w+OuZzl6LzW
 ejx/S/CyluNcA/TLHBbu7ngmyCHk2WRTDPwD5xl62pTMrHk+5Q3Pcs5BlwGXwnX9K+hecM5k6Pa
 O8x5q0kd/PqfH2kc30w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260197
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



On 7/17/2026 7:06 AM, Molly Chen wrote:
> Model vxsat with separate Vector/Zve and P-only control paths.  When
> Zve* is present, vxsat follows mstatus.VS/vsstatus.VS; when P is
> implemented without Zve*, stateen0.VXSAT controls access instead.
> 
> Record the P-only stateen result in TB flags so cached translations
> preserve both instruction legality and the illegal-vs-virtual exception
> class.
> 
> Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
> 
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c         |  5 ++--
>   target/riscv/cpu.h         |  8 +++++++
>   target/riscv/cpu_bits.h    |  2 ++
>   target/riscv/machine.c     | 19 +++++++++++++++
>   target/riscv/tcg/csr.c     | 39 +++++++++++++++++++++++++++++--
>   target/riscv/tcg/tcg-cpu.c | 48 ++++++++++++++++++++++++++++++++++++++
>   6 files changed, 117 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563bf..c9e6c83a491 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -46,7 +46,7 @@
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
> +                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
>   #define RISCV_CPU_MVENDORID 0
>   #define RISCV_CPU_MIMPID 0
>   /*
> @@ -1489,7 +1489,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>       MISA_EXT_INFO(RVH, "h", "Hypervisor"),
>       MISA_EXT_INFO(RVV, "v", "Vector operations"),
>       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)"),
> +    MISA_EXT_INFO(RVP, "x-p", "Packed-SIMD instructions")
>   };
>   
>   static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c9dfa7daff2..75cfb16d846 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -70,6 +70,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVG RV('G')
>   #define RVB RV('B')
>   #define RVX RV('X')
> +#define RVP RV('P')
>   
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
> @@ -742,6 +743,13 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
>   FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
>   FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
> +FIELD(EXT_TB_FLAGS, P_VXSAT_EXCP, 34, 2)
> +
> +enum {
> +    P_VXSAT_EXCP_NONE,
> +    P_VXSAT_EXCP_ILLEGAL,
> +    P_VXSAT_EXCP_VIRTUAL,
> +};
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3f146a43fe4..fa7bf60f4fc 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -355,6 +355,8 @@
>   #define SMSTATEEN0_CS       (1ULL << 0)
>   #define SMSTATEEN0_FCSR     (1ULL << 1)
>   #define SMSTATEEN0_JVT      (1ULL << 2)
> +/* Packed-SIMD draft: enable access to vxsat when misa.V = 0. */
> +#define SMSTATEEN0_VXSAT    (1ULL << 3)
>   #define SMSTATEEN0_CTR      (1ULL << 54)
>   #define SMSTATEEN0_P1P13    (1ULL << 56)
>   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 0ab613a2980..a9cd7e4c1cc 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -158,6 +158,24 @@ static const VMStateDescription vmstate_vector = {
>       }
>   };
>   
> +static bool p_vxsat_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +
> +    return riscv_has_ext(&cpu->env, RVP) && !cpu->cfg.ext_zve32x;
> +}
> +
> +static const VMStateDescription vmstate_p_vxsat = {
> +    .name = "cpu/p-vxsat",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = p_vxsat_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8(env.vxsat, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool pointermasking_needed(void *opaque)
>   {
>       return false;
> @@ -518,6 +536,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_pmp,
>           &vmstate_hyper,
>           &vmstate_vector,
> +        &vmstate_p_vxsat,
>           &vmstate_pointermasking,
>           &vmstate_rv128,
>   #ifdef CONFIG_KVM
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc56..e809997f52e 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -109,6 +109,24 @@ static RISCVException vs(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> +/* vxsat is also architectural state when P is implemented without Zve*. */
> +static RISCVException vxsat(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
> +        return vs(env, csrno);
> +    }
> +
> +    if (riscv_has_ext(env, RVP)) {
> +#if !defined(CONFIG_USER_ONLY)
> +        return smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
> +#else
> +        return RISCV_EXCP_NONE;
> +#endif
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>   static RISCVException ctr(CPURISCVState *env, int csrno)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> @@ -1013,7 +1031,12 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
>                                     target_ulong val, uintptr_t ra)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> -    env->mstatus |= MSTATUS_VS;
> +    if (riscv_cpu_cfg(env)->ext_zve32x) {
> +        env->mstatus |= MSTATUS_VS;
> +        if (env->virt_enabled) {
> +            env->mstatus_hs |= MSTATUS_VS;
> +        }
> +    }
>   #endif
>       env->vxsat = val & BIT(0);
>       return RISCV_EXCP_NONE;
> @@ -3494,6 +3517,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>                                         target_ulong new_val, uintptr_t ra)
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
> +
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -3617,6 +3644,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>   
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
> +
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -3746,6 +3777,10 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = 0;
>   
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        wr_mask |= SMSTATEEN0_VXSAT;
> +    }
> +
>       if (!riscv_has_ext(env, RVF)) {
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
> @@ -5916,7 +5951,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_FCSR]     = { "fcsr",     fs,     read_fcsr,    write_fcsr   },
>       /* Vector CSRs */
>       [CSR_VSTART]   = { "vstart",   vs,     read_vstart,  write_vstart },
> -    [CSR_VXSAT]    = { "vxsat",    vs,     read_vxsat,   write_vxsat  },
> +    [CSR_VXSAT]    = { "vxsat",    vxsat,  read_vxsat,   write_vxsat  },
>       [CSR_VXRM]     = { "vxrm",     vs,     read_vxrm,    write_vxrm   },
>       [CSR_VCSR]     = { "vcsr",     vs,     read_vcsr,    write_vcsr   },
>       [CSR_VL]       = { "vl",       vs,     read_vl                    },
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4af5cd9c731..1665583accf 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -160,6 +160,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       fs = EXT_STATUS_DIRTY;
>       vs = EXT_STATUS_DIRTY;
>   #else
> +    RISCVException p_vxsat_excp;
> +
>       flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
>   
>       flags |= riscv_env_mmu_index(env, 0);
> @@ -182,6 +184,23 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>                ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>       }
>   
> +    /*
> +     * Without Zve*, all P instructions in the OP-32 and OP-IMM-32
> +     * spaces are controlled by stateen0.VXSAT.  Preserve the exception
> +     * class in the TB flags so translated code can distinguish an illegal
> +     * instruction from a virtual-instruction exception.
> +     */
> +    p_vxsat_excp = smstateen_acc_ok(env, 0, SMSTATEEN0_VXSAT);
> +    if (riscv_has_ext(env, RVP) && !riscv_cpu_cfg(env)->ext_zve32x) {
> +        if (p_vxsat_excp == RISCV_EXCP_VIRT_INSTRUCTION_FAULT) {
> +            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
> +                                   P_VXSAT_EXCP_VIRTUAL);
> +        } else if (p_vxsat_excp != RISCV_EXCP_NONE) {
> +            ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, P_VXSAT_EXCP,
> +                                   P_VXSAT_EXCP_ILLEGAL);
> +        }
> +    }
> +
>       if (cpu->cfg.debug && !icount_enabled()) {
>           flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
>       }
> @@ -530,6 +549,28 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
>       }
>   }
>   
> +static void riscv_cpu_validate_p(RISCVCPU *cpu, Error **errp)
> +{
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (!riscv_has_ext(env, RVP)) {
> +        return;
> +    }
> +
> +    if (riscv_cpu_mxl(env) != MXL_RV32 &&
> +        riscv_cpu_mxl(env) != MXL_RV64) {
> +        error_setg(errp, "P extension requires RV32 or RV64");
> +        return;
> +    }
> +
> +    if (!(cpu->cfg.ext_zmmul && cpu->cfg.ext_zba && cpu->cfg.ext_zbb &&
> +          cpu->cfg.ext_zbkb)) {
> +        error_setg(errp, "P extension requires zmmul, zba, zbb and zbkb "
> +                         "extensions");
> +        return;
> +    }
> +}
> +
>   /*
>    * Check consistency between chosen extensions while setting
>    * cpu->cfg accordingly.
> @@ -612,6 +653,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    riscv_cpu_validate_p(cpu, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>       riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> @@ -1414,6 +1461,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>       MISA_CFG(RVV, false),
>       MISA_CFG(RVG, false),
>       MISA_CFG(RVB, false),
> +    MISA_CFG(RVP, false),
>   };
>   
>   /*



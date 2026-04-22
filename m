Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742AF8FA87
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 11:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFW84-00085Q-GM; Wed, 22 Apr 2026 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFW83-00084E-22
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 07:52:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFW80-0005gx-VR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 07:52:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAPVVf3083117
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 11:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UDnkEPs5ef2lkkOX2LfjaiKUh/950FCFZiphMEfvF3E=; b=S0950d8IHZOOfdT5
 8IYSz3uoyv/AJEKwB4fMAddDiU0G70kT60k1o0qlNwX39ns+PhJPbL/inf+/LtgX
 JTNipCVm+vSWEMCc3p/u/RXToKx1HCgDqPpAzjhNOWeWqc0InUyAYhDZjfjn1s3G
 lc71bX693KA96esj3cDwPFa64K0V8VJg6aV38wH4DEZBgPZpzkXbWVTvmy3DUXmK
 Op+eRUamoXusZFdKuZXqRprsZqK8AOBg2MFIm7P5deXmO9Ir0Y7R54WYyrpePRmG
 ZPP06wnPJ8p5h2EvoRn3HF8IXZUOkxsgESssi7BcFi/WgJktWD5gDKfnjSWdpain
 22PfBw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmkb74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 11:52:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb3403e99so57635731cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 04:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776858740; x=1777463540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDnkEPs5ef2lkkOX2LfjaiKUh/950FCFZiphMEfvF3E=;
 b=Ot85HlsBdNInFG4ydlc01xPSF8gik/r3A7PrDyOZ20FKgttu8zgy70athpgRlVTusF
 KW+VYISKEEuwff6wdBgFg0boLDhL8LPNELJ9KKJXu7K5OQQCUsoHqFBIxD/c9cTirZyM
 tGNpFljWx3srmomqIwKdUMWew4DYwrONPvo6ZSnjoWxsDoudhsqgXEvuNJZhEy8Bm+6y
 H+7rulfoJ5YAMoL6JXTap1x7hzRIHMW5GcssbyEota5G+tk1wlsumdNpPznu5f87RNln
 LHu8W6pYYJVp4V5RPv+oCjyjaMyWGlDnLOuCUj8ycssNWsrfyZs2XhpEfcjCRHcC3BVI
 +l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776858740; x=1777463540;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDnkEPs5ef2lkkOX2LfjaiKUh/950FCFZiphMEfvF3E=;
 b=YYxQbMmoyHZRLl7H6elJlPttJ4M9Q5BewaWafd1wDLY69nJPDgtvdv/M/5iW3y4AuH
 gU/7pAisepV2VwMHcX29FlnKeP0Qc/I9dvVCKkj3lKrtG7K3vmTsvPWB6llqFHz/GtEQ
 px3AIiPMkQMYp6Rfesvvj3nhJgUilEfafoekJmo9Y898Pevm9rDJv1cP7uvaILjzXcTb
 vSnYAoSlXIvuuZ8hmruBmCdDRBgYZ4TtWbcx0bK+LxBDFvOn1AcO8wI4zUhmdqg0dDWQ
 Q2QbxSPvOdWKRDqgC1V8ucRH8S00jQrr2SR1ogWKmYFmhuTi7cgD95OS7/sZlJDNd25o
 5+6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X11slbO9lyN4da+zB9hikI+IZGnDbbj9+29Bt7N7w+QKgDhWnKEXB8G4/B69zdwdZz8i2v9asw2sb@nongnu.org
X-Gm-Message-State: AOJu0YwaxfC6+p1VkX7oS3vZfo+4tCSLEPr/q1ZE8cMwFR54okLEmne1
 +PhqUidY6ok+YbKgY4tm0sSwTlQD/HYLStlwYybMCUZgjrtY269+LdY5tAbXc5J9+B/peg5wPcO
 zCFk3IHQDKyhRxVHoAAlOK8QX1EOadmawhdZdnWLJrf/G5Tp+zlYdmfsPcA==
X-Gm-Gg: AeBDiesuU5ze2xgwZ+8Y7EAdrEH/BObvTziZ4wznX94jBLE1QIOqZ6p5Cv/MFkUxqE/
 C7w3kZxjV7THIuq+XRWummYlLsMtEvDmPHTe1ZUshEFviQ+cNiEzeCYNwTNZtniRcYwnhIh8WjL
 RPtb9xScTDp7d9P6qwOWe3efgQzjuqWVoQAB/MPjYP96689bG7srjnjvriv/HDxIxBMwsAUt6Z0
 eABohqCSozNJ5xft4I1nS/I3x+SroapctDX8h9ksPi816CyN3Cik5bzvii/ZR8Fs9kxYwotMbWE
 pxgqn+MfMzNcSDA+aSJPXPkUCNpuilwQeKJIJcvOPJrTGSJUdDYdbDXlNPyOQKCB4SNPba+wowr
 2tTKK7991O118LH0T0xEbezoXq7IDaWiB7JPwnqoPa4dmstUvBq4O0w2jDPIcdSJwSicDSA==
X-Received: by 2002:a05:622a:4d47:b0:50b:a9d3:2e20 with SMTP id
 d75a77b69052e-50e36c65b22mr338492651cf.49.1776858739935; 
 Wed, 22 Apr 2026 04:52:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4d47:b0:50b:a9d3:2e20 with SMTP id
 d75a77b69052e-50e36c65b22mr338492141cf.49.1776858739421; 
 Wed, 22 Apr 2026 04:52:19 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e61c191basm81751681cf.16.2026.04.22.04.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 04:52:18 -0700 (PDT)
Message-ID: <336c0c4b-af67-4cb8-91f3-704348124f55@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 08:52:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/riscv: rvp: Add option defines and
 dependency check for packed simd extension
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-2-xiaoou@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260417104652.17857-2-xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mJqxElH_YfhA2e0YBAgdty0xKDchprsd
X-Proofpoint-ORIG-GUID: mJqxElH_YfhA2e0YBAgdty0xKDchprsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExNCBTYWx0ZWRfX64OMJjjbNEnA
 dgwqxa420gN9Trnk+z22Ja6hnO92cluVc2rt6UckrTgnapQELCSqaCy4RblJoowd3TExtlouxSq
 5grn4Zp9ehaN2TLyrC+i2y+f9ApxNjjGl8WKAFTFj7sElPK9XKmeNJ8ufZER10skAZLNAx1rMby
 j8XMyVaK426E4/Nv3r14T3pCOL4VrNswS3gCrqKbY0u+/mDmmpdzaTvAR/57tau55tK7Fp1eUNj
 nBR2Wq1RqmgPtnTD5t60AfAhNzqvSNZs52a3TtQxWiw/EmfZOIhadhxmG50yhDahABmeCwrkA97
 11SNWIMXUSGrHTOuY+s9uPOju5x8BCR0euRgNzDdeWkQS0V82OGSGMVFuAL7xYNT8Qu7d8RxK3X
 oJ93BkVyYaq9TL36Nf7tWE6fzao9kNhWf2AsQWqqZ2p6ND844U4mWZku8GHmf0Nh6s0Ety0M/kU
 RE7ASGJQCOrKQRGY54Q==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8b675 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=AjF4YrJ7RAsneCX4kmAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 4/17/2026 7:46 AM, Molly Chen wrote:
> Co-Authored by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-Authored by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-Authored by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
> 
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>   target/riscv/cpu.c         |  5 +++--
>   target/riscv/cpu.h         |  1 +
>   target/riscv/tcg/tcg-cpu.c | 16 ++++++++++++++++
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 72c6f4f0f1..c630faa892 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -41,7 +41,7 @@
>   /* RISC-V CPU definitions */
>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVG, RVB, 0};
> +                              RVC, RVS, RVU, RVH, RVG, RVB, RVP, 0};
>   
>   /*
>    * From vector_helper.c
> @@ -1172,7 +1172,8 @@ static const MISAExtInfo misa_ext_info_arr[] = {
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
> index 4c0676ed53..e08f57d282 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVH RV('H')
>   #define RVG RV('G')
>   #define RVB RV('B')
> +#define RVP RV('P')
>   
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f7808895..4545ae721c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -601,6 +601,11 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
>       }
>   }
>   
> +static void riscv_cpu_validate_p(RISCVCPU *cpu)
> +{
> +    /* Enable sub-extensions here. Do nothing for now. */
> +}

To enable sub-extensions/dependencies we have implicit/implied rules
(e.g. RVA_IMPLIED in target/riscv/cpu.c).  I believe we should also use
this logic here when the time comes.

Usually we use 'validate' functions to assert if the preconditions are met, so
basically what you ended up doing down there:


 > +    if (riscv_has_ext(env, RVP) &&
 > +        !(cpu->cfg.ext_zba && cpu->cfg.ext_zbb && cpu->cfg.ext_zbkb)) {
 > +        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
 > +        return;
 > +    }
 > +


I believe this piece of code should be put in riscv_cpu_validate_p().


The rest LGTM.  Thanks,
Daniel

> +
>   /*
>    * Check consistency between chosen extensions while setting
>    * cpu->cfg accordingly.
> @@ -619,6 +624,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           riscv_cpu_validate_b(cpu);
>       }
>   
> +    if (riscv_has_ext(env, RVP)) {
> +        riscv_cpu_validate_p(cpu);
> +    }
> +
>       if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
>           error_setg(errp,
>                      "I and E extensions are incompatible");
> @@ -683,6 +692,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (riscv_has_ext(env, RVP) &&
> +        !(cpu->cfg.ext_zba && cpu->cfg.ext_zbb && cpu->cfg.ext_zbkb)) {
> +        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
> +        return;
> +    }
> +
>       riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> @@ -1413,6 +1428,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>       MISA_CFG(RVV, false),
>       MISA_CFG(RVG, false),
>       MISA_CFG(RVB, false),
> +    MISA_CFG(RVP, false),
>   };
>   
>   /*



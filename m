Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F684C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5JO-0007wK-6a; Thu, 06 Aug 2026 17:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5JM-0007vt-VD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:07:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws5JL-0002lL-87
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:07:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L0rQU2760700
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHXy1pbc1PNHLG3fSiVtqkHVOq7fkZnX4vegx0USJe4=; b=DZPW3Bb4KxJlOrjL
 75agRDsnxr1MewzvrYZQSCndI9kKyXDWege0Xqmvu6zSk+I/K2e3mFP3suwbnFYs
 gaYXJWBYYT5djGn8XUpVer8s/LElb/yRvkxbxSUGrdgKEdhqJ2JiBXmOQ8dpPzc3
 2DFvHe9fPu5OT+2Y2IGXCaaIF3sqy5gLdIi/2uER3+ke6thZmHsAUQke/3MdgUbF
 3OaqR1n7Hil9YL13vPuSbsloGDi4/eIiKCF0KOKN54dv1xUuFTF9MPUPsEszvJ3L
 A2y4HjLBDt3NCU9mzVY6n+G8p/nmu2USCn0lTt5fhphe4OZob4wCimgZmSVthYLQ
 T+5UOg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jgr1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:07:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494cce712so328469685a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786050448; x=1786655248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uHXy1pbc1PNHLG3fSiVtqkHVOq7fkZnX4vegx0USJe4=;
 b=JkK0pTnZI78d7r+pWmq17whKdFiNWP42Wkm0AQp2RnckhCzlOafLfcGLsHVFCyMNJK
 YEvmF3fhCFpHAmmTuUuQtC8TfGH8598efuAyKChAIfScJuz+qQSCs+h/bHl9Lh13IHdl
 QiODSU2rI5rvgVMKJ7TTReVMiv4AJJC7JKKmoGswbmwhFWIlmrc54dq2bhwVv7joprzM
 n2pG7YLTNVpk6oXf9q9m4SyxBvWHVLV06DN4O7pybv7Pdw2Fbli1xf/RSm5ByLVX7+0U
 EdgkwrP60DXnDpQojSOOSHZsteGcYB5KtbcNn61o4ypQu30paeZUVbqpff8AJCcVFP1x
 K9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050448; x=1786655248;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHXy1pbc1PNHLG3fSiVtqkHVOq7fkZnX4vegx0USJe4=;
 b=IjlIMsP3fb+wyc40dh5Q65PHfO15ezEsN9+ywArVxDjCrA+5koQpMZ+6leVkNuy5kf
 xpiWuzw6Ohw+k7BpWFzY/L1idBXNieHlBFVeZIC4Ell/gyNvRURD3S+GKkR+d3kRGCTp
 2Huz6mpiownpODpoEAMA2x5mOq94cJmdfdNKFevp+s9Tx0YkllFLkEIrG0amGbXy9BgY
 qN8jlSKnWxzzJ0TmdC4vMIYUrWUZcCkFSbAHaFmjL4hh8v8qME9NNF/Lz4ZcS3jpG5xH
 9Gd7VnvMdsDx7g1C8K2d/mSyO8xRKFiq8gLLpEEqreb4mVEArQeGxP76z/YypAn44Fvc
 ey3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbKTJuN4Q/BZN6Y5cBZ9eCw2/Ja3VdDbvp7RcTiKwYgVHCIH6dIdnmuj+IvDZtxL/zqmFFbZ1o/MRD@nongnu.org
X-Gm-Message-State: AOJu0YyC/s3YPyXZAxizdLrOm/I/cIM8iC6FOa736guuGp0TIscm/5sy
 LWzWXmtIQsAAZ6P97f+agfENLBk2+Tuo7pP0JeIoKUO0VvrVbdPn5B3Q+fZXV9nbcbyvJXQZaJA
 zRckjGQSbvFI5VkHtPNn0MpxVBR+OQF+rT5l0uHXU/nCWZZCJSEOPf8DO9g==
X-Gm-Gg: AR+sD10dtpznTZ/2G6GhNEJTglDU7syomlBEnYacD+Sz7HnHVi2G1LT0KyeP/ig0Ve7
 IY7Ai/5l49bDdsrRTQWdYv1mQ4B40RmS0QcrBDBHGE3DCuch/zhM+YeFAS2mzu599rhsKCx5y5J
 aDouIVraqLtkHCjvAwg7Z4NOyufeXgpuS4TrXnlkTyGr0pUAg3ymCA4A84cEPnAetl+zhQDbFZL
 W9Sb/+0d9wjSBmXt3GnePaI0QgMOGdhLHe0lLif8Y33VefGHdM3/Fx9t4CAYCifkntfP3WsEX0j
 JONPOXr0HWw4qwamujJBZHaCkcCC2QUULVeZNTkQVqLnoY3HOsmZkF6ISEGOr8nyKlXWtxwbkP4
 +nQ2ZfPPSCEzFTIA6FSCdEGbvOBYebQCPMSkf
X-Received: by 2002:a05:620a:29c2:b0:92e:f101:5dd6 with SMTP id
 af79cd13be357-93648fc72bdmr1462650085a.6.1786050447705; 
 Thu, 06 Aug 2026 14:07:27 -0700 (PDT)
X-Received: by 2002:a05:620a:29c2:b0:92e:f101:5dd6 with SMTP id
 af79cd13be357-93648fc72bdmr1462644985a.6.1786050447221; 
 Thu, 06 Aug 2026 14:07:27 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a59552esm503660985a.42.2026.08.06.14.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 14:07:26 -0700 (PDT)
Message-ID: <0a052a0c-ab06-410a-a163-4ca6e8b7211f@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 18:07:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/riscv: Add SiFive custom int8 matmul extension
 implied rules
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260721122034.1567146-1-max.chou@sifive.com>
 <20260721122034.1567146-3-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260721122034.1567146-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX5PCtpyuujmAo
 Yie975iyVeaTJ8UXXDUGZYXGbhZVkAR4gVyOhnFj49faUOQWnakH+5+xSsBoR95zyaWtPbISj29
 0rP+N3bJAUAGVB8sfc3JGV5qJX/3kHbVP2qmDQNDq5r+DECtq0JM4uW7MHhmzFzpNXb/4DYD+C3
 1peNsgPa0j9DHTAwgI0sYaHScM/POYd/PeBjzsnsWxAHYvNcTJjzyK9I60M1LziANuhT2OQOZL6
 dE6N8KJztvU8SJyt9gU+Vf2yMsb5Res7Tu/BhqBw05Jems/Hh9q4I05+7S/Us11Cv4Luqe0HAxK
 opPzd2oKNKkp+wZuQmp0iAtvyKMD+pbLx/jYXTXO4KXf7fPDNSFcr2kn5AG+xcjBjPk2sJSif1Z
 C18lA1uqi+IcB2RsUezH/lUQwHwnGjoUICXprpD79ZQhbQIu/XFlR2DODsWoUWHWFYUXgYpbgwz
 HU8hTodfmkUqbmtNynw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX+bdL5BRVCl0I
 MzqSzxAzrKNKnlRicUW2m9xwPjnLU5us7Y5PN88B3P+5WXo0bdh87ly7Cpw3hKwxp86T3EVst3C
 LkJL7uoB7dz99/vl18lVE4bYVqmQEbg=
X-Proofpoint-ORIG-GUID: Q1bUreOYl3dB_vfqHm73RlhUotctU3_Y
X-Proofpoint-GUID: Q1bUreOYl3dB_vfqHm73RlhUotctU3_Y
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a74f791 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=QtYS9pm54BT3p82qaUkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 7/21/2026 9:20 AM, Max Chou wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add SiFive custom int8 matmul extension implied rules to enable the
> implied extensions of SiFive custom int8 matmul extension recursively.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/cpu.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e643d7c7af..70baa054f9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2811,6 +2811,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
> @@ -2832,6 +2850,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
>       &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
>       &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
> +    &XSFVQMACCDOD_IMPLIED, &XSFVQMACCQOQ_IMPLIED,

Not related to this patch but I wonder if we should put one rule per line
in this array.  Every once in a while we have to add a rule that is
in a line that already has a lot of stuff, then we need to change multiple
lines to accommodate the new rule.


As for the patch:



Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>





>       NULL
>   };
>   



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A44CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGJu-0007Fb-7u; Wed, 13 May 2026 16:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGJs-0007FT-Pm
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:36:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGJp-0008Va-RZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:36:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF9Edc4159821
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uPVmSh7v8Zu7hFIKSC8vY4vHdXdGPSoTg6+UasKT8Do=; b=Zc83Db4Cem665or4
 x4fcf5f3CM9K7cH4E65dy4vcYkeCiv0UkPvdTt4uRKUI3Dtxq4VJLzm254a2EmFV
 RBTdtmQQW+wY+TnYxHOTwIa7M/CXbf1XJeveToFF9+bW/H4ZnyBXfKa4BeAaOiO2
 MPpejaGRw727Onm13sXuTT5aJuua/nDccebiSXa54hkzstLRlpV1oRBno4YYqb6y
 d90p9qBzebkcNgcKqOlIgFHbeF8kB75pmLds6mf6YQLR6FM/D4elQB0Vd/TVzHDm
 hZBfdoWneiotnMQLBNBJIJ+H3mF09DfFZ7tAFLfiCoe95lWdXuzRXR9QWm6rdga2
 FWw2ng==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91tu27-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:36:36 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-63308aa427fso2246003137.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778704595; x=1779309395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uPVmSh7v8Zu7hFIKSC8vY4vHdXdGPSoTg6+UasKT8Do=;
 b=SKm7vWgxrkTMLI1HUETW+gW35ib9BCKk/sFHKIq0/eGDlAUfVh3jxaFzX6Iveyqcj+
 SFR3b9Xr4fl4D3Xk0gn7OK8q15Xp7hnxi1WikAqrlBmD/j4vSM/1OPvU/Jum5czOoq6k
 Dfw8Gr4ode+VAkhJ1A9plZ4T3jFDFw/j2pZEUuTQHEL/mEOVmL4iQbikxlh5g/g9Iufr
 bxrfclfv52qdI3TK9O7gU2uMlb9QcYE+lMDC8WGVsCkBqM/Hfr+XbAIDC20VQgpRvynz
 cDQkK43sGiUHKRutSkfu98SVpwFOkMQJUeClSOFb+OcUU1dXXMDh6jj4b3A2cmqgAQtH
 pPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704595; x=1779309395;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPVmSh7v8Zu7hFIKSC8vY4vHdXdGPSoTg6+UasKT8Do=;
 b=nDI9JAPqNU7if72oelJJXrCQ0SmmSvZH9CZVNgpIf05LBpomP7ZXwj5RoPToIaUV4Y
 SiRhNFQC041sAV0VNdtUbMSeMwqUM8z7L6ThC0eoGQccd0PqktiJXoNtR1wW40x7bRU3
 q2s8Or2ClcWleMcKZyPQG1bKFvZ7M3f3uipuPArfZoNBlEZsHUXogj2h2OQh8hpr+orA
 RRaHi2hq0E0fHHcxpCsGXkx/+TLkGO4Y/ONmIBoTQslx9k1SUk6actgaoyVX/CLTFJEa
 VCQzGmXmEeCrdU32B5OBhDPHP4/ohF+ZTM5Vk3Z82P+5uKvLH+eZ4heI79RkXoF71sQF
 8L1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hgWUe7gzsIaJjNQMSwv4wnZSj/imQ9H2YBhe+q/6c1lXlezhGF74wmmckndx4nZVeiM8P+92w39Jg@nongnu.org
X-Gm-Message-State: AOJu0Yw+FF1calsZtLJqtPNSFvfblwWOl2Ykeyn8lHtlepie/dYTXUUy
 NRpYyDoYvvLh1c3aWZq3BITwgBXep4JAshpI8TbwKeRvm1LNm/e3DHO8olNEtIyUrCmGNWFSOie
 1MAQux+z35vQk53JMyf/jphqrdD7UiBHZNVMvyCsvniVKNNY9jPB6uQXMqQ==
X-Gm-Gg: Acq92OE21V54mXradZ2H6rtj7gbRlMDwMGsHB3QCWjGsHG/ep1tSmmstcgu0ky8FauE
 bN8WTQURDKyADr8XD1QUsu4sQs6OAxlImAZm+XWDrf2B3gZqdukTkzylDfsuSVTmbP+UevmaHiH
 PeUXPDpC/Z8FOw7HzrQghs8kY7GpRhTWASO6o8usybMWec+UCRJSEIth5KTDewJOlQ3CWjYjq0N
 TGTIQAHYsLGMxyLIGQm+6fhg3d5gK8V+Ub19ZLVOdnTpgMajigdgPDQ/+C+EopQ0ggf9NYEEn2O
 Ho2kEQ4udR4UKspoZlCC/DnIVB3NpEkpG2IVGeH+NJlOtN9R6G28Pb6tpdBpf6QUWSzDjZmY9Na
 Wwbepqzh26hEuR7wSbQ3QhUlN3xI5U5E7FVZrhDPUzbCwVRFDPS4lC9/Gpzk=
X-Received: by 2002:a05:6102:1610:b0:631:8665:350f with SMTP id
 ada2fe7eead31-637723b5e50mr3037226137.13.1778704590201; 
 Wed, 13 May 2026 13:36:30 -0700 (PDT)
X-Received: by 2002:a05:6102:1610:b0:631:8665:350f with SMTP id
 ada2fe7eead31-637723b5e50mr3037210137.13.1778704589803; 
 Wed, 13 May 2026 13:36:29 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90b2dc42csm5458546d6.26.2026.05.13.13.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 13:36:29 -0700 (PDT)
Message-ID: <48512f5f-dc2b-407b-8338-07ff23fe95e1@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:36:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix FSC SV32 capability check
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260511080904.3049446-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511080904.3049446-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Sl6tDJTmL1uJWK8f2KAMQ6kp2q1rA__U
X-Proofpoint-GUID: Sl6tDJTmL1uJWK8f2KAMQ6kp2q1rA__U
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a04e0d4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=5tghbzQ9oMU--FvhtGgA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwMyBTYWx0ZWRfX5v/lSVxsqnwQ
 k34afRM5zb7E458CfVyc0WN3avPnqMGSn6niFKfwv6ZumUmMtV7/XcAE44X+KcTcyiiaBUQGaII
 dexTb+5EDIr9NKylFsFgak/dPe0Nt12dSJsGUsfg6zhVxzPAHur6j9gFIFKFhnRqjywYZ83zPTF
 5cFQwUYJoeUMV47CqG3cyjBMEtBxx2Ny4GBSIG9utOF96+4jW9kI1VXxVxdhrFAjmXCkUHuydqQ
 mlGlvs1/Yiz+nJX34+1uTBPTxhbaGLg11YyQJH/qK+FTq0fyAu6WQGH2J0sB0PogGO/u9jZ7LKz
 aHzcr8syESGiH/jD0Ru6men92VwKr0yPuZe8q0rzG+NwjC/AsIpw1kQU8njz6rDbaPK0xwCCHVQ
 YmrYVppjSGnGpyqGnT9D9+LtfgAcZs9QV636bgPo5ci6Y524RjwYrQLAecc3Ts4RiOeBEp4fpGd
 G5czhjOii7MxPGxbZ0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130203
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



On 5/11/2026 5:09 AM, Zishun Yi wrote:
> Fix a mode-to-capability comparison error in
> riscv_iommu_validate_device_ctx.  The code was comparing fsc_mode (a
> value) against a capability bitmask, making the SV32 support check
> ineffective.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-iommu/pr-694/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 7ba32405522b..ba6090e1078c 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -777,7 +777,7 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
>           }
>   
>           if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
> -            if (fsc_mode == RISCV_IOMMU_CAP_SV32 &&
> +            if (fsc_mode == RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 &&
>                   !(s->cap & RISCV_IOMMU_CAP_SV32)) {
>                   return false;
>               }



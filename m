Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC0FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINlN-00030J-OY; Thu, 30 Apr 2026 05:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wINlG-0002zn-2p
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:32:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wINlD-0001Fr-24
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:32:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U44a9g2099612
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Drad9XVNnm7TfuJHSO3F7Fij3ILLW+4ti5jgoE31Gnc=; b=h239VdkdEJaWPghE
 jO9svjeHJ2ovw9YKuPgpO9dzPkcat3XwZeSGKhkOxwhh7PMJr41rqN1WiM5R6WXv
 ylMVMxmFnGTYvNoAggvr+uDqgNh8yjUsxACsX6XiwVFj2yVulZwcXtoaQk+Pon6A
 e1xgG018bzTEFUEtafP8sd1JFOHZANWfDmSrj+VPSRB8izN6ieHMth9X+fUQiqLF
 3uSFXYtFBHM8Wgl0Pq3yc0QhHkpaDjUQCvgEbgy0ougZWF6ST+pwAv6Gfp9ij/Qq
 +EdXIIqvtHJSwKzmlyBwSGxg4MDgLzlknlELZ1ZVRXGn13tO8LR60wi03g9GAZ4G
 IjCn7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr4149n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:32:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so3102387eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777541558; x=1778146358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Drad9XVNnm7TfuJHSO3F7Fij3ILLW+4ti5jgoE31Gnc=;
 b=GRdCXrdJmfxo0NMhtisk67sHgJh0BdVdWPru5qwFtv9znqaienfQyX+i9YQTwHoIxN
 I2oQTfomRS0VyYUqjTZt1tJ7YbVTYAjcbKLaqogJK9l1KipF36Gf0Vs8TdOGCmlkCKB+
 tG6UyDe7Opvvf7cm/OQaGYJl/wp0+wgDn3IRWhfcWjRx9eVohT68tymBEB4VtD+ICUnZ
 e5t/0q3wqUkNpj5IpDjT1Les0AsI3r7GOSXCgtv+Za3Ks+sfnYxWySKlmBNJTMk8Bzes
 gNqDYhkz7PLU98bCBZRm0kY+/SVMAkW7etxqFF92DEHuzfQQD+UoENKAZ8i8jZLTw6I5
 6dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541558; x=1778146358;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Drad9XVNnm7TfuJHSO3F7Fij3ILLW+4ti5jgoE31Gnc=;
 b=IpDv+4ce1GuSIWMZWpjyt8OQkXrYJ/9dPBUIehNa4EQ9NFryyiqsm8qfLcP1UCJSqB
 7ifwL0FPXTxyyp7TmL6mrl6zVUHvdwF93+bwvjcfX5Qk+XtNnsk8+DepkcmC5Q7dUunN
 NUvuToGqjKRaVy89uIWTiUCpbbbz0rAeS+Na3ySUrEZ3wqLHxGIj9fCS3nJglpIanXtZ
 KdxQadyV307ErMC7NkHyrwKEC1HVZp2OH07sVA7wQxdYmm0PFRRK5O7kZbiVPAw3gGn3
 vMuF/dZsZM9ODkkGKC0/oBExXr9BSLEkgOfjgncJXPgc+IbO2NDGQFnLyyFmmXWkWmLr
 bekA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eapGPReQY5YJdq3oQjG3mVghixl/C/aoKols3t/fOXRC5QLYFg9lLpiRB+Ffc5Av6rjGwrdSwOopi@nongnu.org
X-Gm-Message-State: AOJu0YwgEOEleZDmCEa/b2uvINJwb5qJ+4C3jl+nE3oR5KHMPTGM77Z/
 Fp9yZLkA+s8A9wZfysKc+iWXDhkrsNQAZD2tXPUNy6cCilUP8z7Ra8TJ6VP6ljB/sFdGz+r9vJz
 p3bly7Zy1FUfcPv5+CvfZCVrw0qI/w4AqC5SYdxFOht+Q5OTEuA43W3a9fg==
X-Gm-Gg: AeBDieufQogKU7zrp/WfS8xb9VRwOqu+j/0XXpUhIsaRAQxI01T17scuqZimrY3gxbw
 wcv3gfnn+uhxQtSXoYCgHi3EZipKJo3Dy4i+Nc4cA52iR7XbRiyouiScN4KT5WcENiL5AYHskLE
 KiEh5Ijna2ZxBznpJs8iuXmCulx6DmQITj/yOHWewhRz6ZYbkhtK6q7d0a2ojTOe1b24rRmMh5s
 XZ39UjEyKvrzsbsRlpC9zlHazdFFLkD17dJyYiuKddau/DDxqnrffWnf/qhadFS5zgg9fyPo1qF
 viWIyZGfdyksxw+M4YgwFADZDDbtymCQQWVcivIh6YNEk1uWan8lXIZKWXf4mXXfF311s/nxiFu
 R5MEIP3Balr8TV6uxksGWLVE8LAs5tsauwnlQnDKhpXyH2yEih41Lf/tn81I2jiR57xsnSA==
X-Received: by 2002:a05:7301:5f84:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2ed3ba0c69amr948201eec.3.1777541557677; 
 Thu, 30 Apr 2026 02:32:37 -0700 (PDT)
X-Received: by 2002:a05:7301:5f84:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2ed3ba0c69amr948173eec.3.1777541557032; 
 Thu, 30 Apr 2026 02:32:37 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0d218dsm5833492eec.27.2026.04.30.02.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:32:36 -0700 (PDT)
Message-ID: <44bde277-c357-4507-9456-7cc8f6dcdbdb@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 06:32:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] target/riscv: Enable SMMPT extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260408140635.42546-7-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f321b6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xvfqbYfxAAAA:20 a=SRrdq9N9AAAA:8 a=bDdBU3oEAAAA:8 a=HmrKbZhTWPqaYERuRHMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5NCBTYWx0ZWRfX7vDRkTgbA2CV
 EejpYz7ULQdR6WS1lo0hiLYRhiP9p0vmOVGYkZ8MykiNVuh6CxH7k6ap2KGq82/nCKgWYe7SFyB
 mDvl8rH4P0AScNhUUwWlXAlrvWB6xXTBRY94dZbGBuHRA6h/1DnGWpofaBM10ByjBmgOBnVZDfk
 Lmj/tb9NJ4hRtMJ4QDG/pjnIHdfyPAdqiTob7KFq3lphoRstDd9H3bDXMiGT/dpQhzVxQo0MFG7
 L/iZ9Eae6Ld0lUdyhV0Z/9TXpUcVinD0M/vJxro/eQGssXxYxAm+MvM86/jE/qcou4S/NVU2enh
 0sUHINTKWaa88hftbo3gEg/v+JyfKSXL9PobNhwKHCZNUruFRKV7UHVOdtc+R+LL9cFfB/Co+5x
 mqNHhQhx5e9YlWKG+AE4AK/WqtRUNOw1Wja1Bb/Mvw12VPIOIblcDqEyQP8vLK2ljqwD8zbiZ51
 we9XNsiGs1is+HaYi3A==
X-Proofpoint-GUID: NSZ7qauFX_37fArCEm4XF9BYgoTleM6G
X-Proofpoint-ORIG-GUID: NSZ7qauFX_37fArCEm4XF9BYgoTleM6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300094
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

Hi Zhiwei,


It was brought to my attention that, as per spec 0.49, smmpt is dependent
on smsdid.  In other words, using our current implicit rules framework,
enabling smmpt would also enable smsdid.  I checked myself, and on
doc version 0.49, start of Chapter 4:

https://github.com/riscv/riscv-smmtt/releases/tag/v0.49

"The following MPT extensions are defined:

• Smmpt34 - Page-based 34-bit memory protection system (RV32 only)
• Smmpt43 - Page-based 43-bit memory protection system (RV64 only)
• Smmpt52 - Page-based 52-bit memory protection system (RV64 only)
• Smmpt64 - Page-based 64-bit memory protection system (RV64 only)

These MPT extensions depend on Smsdid. "


Given that a v6 is going to happen anyway might as well change this patch
to add this implicit rule too.


Cheers,
Daniel


On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cb4ccd001d..1e49465eeb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -225,8 +225,10 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> +    ISA_EXT_DATA_ENTRY(smmpt, PRIV_VERSION_1_13_0, ext_smmpt),
>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
> +    ISA_EXT_DATA_ENTRY(smsdid, PRIV_VERSION_1_13_0, ext_smsdid),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> @@ -1379,6 +1381,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
>   
>   /* These are experimental so mark with 'x-' */
>   const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
> +    MULTI_EXT_CFG_BOOL("x-smmpt", ext_smmpt, false),
> +    MULTI_EXT_CFG_BOOL("x-smsdid", ext_smsdid, false),
>       MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
>   
>       { },



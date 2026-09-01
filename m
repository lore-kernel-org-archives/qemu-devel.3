Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB9C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uqa-00080Q-QY; Tue, 01 Sep 2026 16:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1UqZ-000809-RI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:12:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1UqY-0000kr-BZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:12:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681Hgg5N3390622
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZL8Ji64kRnxHQZQLPiQcUUROn50LboarMw4PDxjQs9Y=; b=gDSyOhtMZQ2tjFrl
 HNaCkWnFsj0tc9n6H0MyISGAufrIqVk0+C5hgJDNe7cmUxP1fDLwRcVoVGCZfUGZ
 GLnlHO4omPkDaguZBRQtpN0qKI8K3L8lYD8LYP/exnSWxtkmgLSTOKD3wBkrWODV
 GN55bIhVRQv+0gsAWDWMFUj/EGeIrahb6O5EMUzCW+RcQrOR4ibDqIJVZkj/AxXg
 aLcUu6KXyyR8wHk18JWcM1OB4fFyXQY1E7BDiMu9FbQOw7VfvC+bgHZSMrSXG7Kf
 n1b8GiGhBTPjKyt/hn5DsX2u4ai9xzPUYOJq2hnx0+odC3u9POVDvJX09NNbc4nJ
 s0re6g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w0jtc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:12:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ef13b61bcso79106885a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788293561; x=1788898361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZL8Ji64kRnxHQZQLPiQcUUROn50LboarMw4PDxjQs9Y=;
 b=Sae8AEq8n20rORl8a28MYSIobvrnNyt3aefpE93sfiVwmUgsxdC8h5lSNnneg2hPxT
 ZIC3rQvgUvehPSO86fWeiAmh7IrTg+vX37C06nVFihHum/k9xlEiy7+IlJOdcvSlZrlE
 RF2QkfUHNfCTq0Nq1LA3sgL4JCDOdd3dnMfo/hAzUYqoPWNAnE6OrvOAA5TZf5r9qO+T
 p5PiPvCU0l7Oru1FTo3hHVc/wVt7giL+7KfheOpXJ6+yefmrLNdCsvpXAtlmHgDXcM2k
 mgC99ORS2O6FMeyxz+hqt33RXtnx66+0RSMTzcAbTsS1tXqFNY04+WxGUEUj3NSFsMfa
 VfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788293561; x=1788898361;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZL8Ji64kRnxHQZQLPiQcUUROn50LboarMw4PDxjQs9Y=;
 b=DqNJAiFFVjl+pC0jZNfQ6eKNu2gEf3fs7SjqGXwPpTUBcR9qa3OecdUGbr2hvqzxDp
 Dq/p9gTYChYhYRRVK6rJdxkCGWlSIbIgZV7WwXbdFS/zDfmUlSo4c002APiiYZ5DPzmD
 V6rNyFdhZnUuldEbL95FsTTYEKzZ17Qi3xKAUgsM4//cUXYpCvvOEqkPfMKm4gdwQ2I2
 MJI+ca/WV8qcLJNLdTQPCpqfrrXa9PA0EvUA55ZoppGkvcoX7H6eAL85vZG1koJQ4izY
 KwI7eSzacp1bwbxgqar8wxDzPOpPrXG/1djUExxc5jr4BQtTVWbLhyMJWtxtL/32aLQr
 Hb/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV8rwD07ay8YpLk6u68eQHzCJcSPTKQUIwpXBQzgEtPhm87GS1AT2LHoisORUaTUaXKnus9ACEowVr@nongnu.org
X-Gm-Message-State: AFuF++m8yIirD6GK98HvOT24QeHIYhASNdluE/npBvJjgjHKocPgpdlC
 g+L37r4IWoNefl4dqnzr8cwEF6nFDetFYWEPDS3GAdpWAHPM/8yu2QVD69Ayrcu5LrTSojdFJkr
 toBgHYFCR5r6RdiYVXqCoTMUYfQ9F6L4fUBYEDcNG1Jpowx4O63ewJxAA2w==
X-Gm-Gg: AR+sD10AeELcenb9Ou78x9sS3zJaWACknMG6F8eKVIV4+nZKvCL0h6rpF3MZ+R9SNnC
 fHIw015AxlarDdZkyDws8ttJkc0f7jJ4xwv1QMb+VLrTp8VNQyX73k+GqunTikl8lpktPVWxcHu
 1A+K+YQPI3syy+ciPWnv17xabT9apLH4iu8i0H4bhduArR7C/Ry6qu2WLsXKg6tHd1TD8HRfKf0
 B04XGfQ6cjGaKYEdXbHJwwdP2S94veokbU2FfmYY4lNvtONm7lbdbqJv+0A24WUccUOornXANIm
 jq42bBwgoazOMOrNa9Ziu7UxzuSmrkarIVwMmlZOP58PL8m0boeBiibUonTK32bLOIeYP3jUUF0
 6zLaPoUEvOSsLN2hX1ifQxJ9kTynHLsUHH8cc
X-Received: by 2002:a05:620a:294a:b0:92c:103d:63dd with SMTP id
 af79cd13be357-9395ec72930mr138668785a.39.1788293560720; 
 Tue, 01 Sep 2026 13:12:40 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:92c:103d:63dd with SMTP id
 af79cd13be357-9395ec72930mr138661885a.39.1788293560226; 
 Tue, 01 Sep 2026 13:12:40 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9f0f8adesm1363346d6.42.2026.09.01.13.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 13:12:39 -0700 (PDT)
Message-ID: <cfcd834c-5d33-4ca6-8d77-737d03437c20@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:12:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv/kvm: Preserve VCSR across migration
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org
References: <20260831074106.1798671-1-xb@ultrarisc.com>
 <20260831074106.1798671-4-xb@ultrarisc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831074106.1798671-4-xb@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9lTRw0ig_rFqt0WJ6Sdn3vEMP9jojj9w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NyBTYWx0ZWRfXxqXGDcCY2b9V
 D0sCMHWPBJUqtCFNVQ5bZHj+EI//SwczyDMEXlo+GikmXzfmoRnlVZvuKlmBWKD8LUGgCJdW3Z3
 XNe9nNSfmr9SLzbN5XqNviHOdVCzw8U=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a9731b9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=69wJf7TsAAAA:8 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=_yrhSRU8EesBMVaPoN0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: 9lTRw0ig_rFqt0WJ6Sdn3vEMP9jojj9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NyBTYWx0ZWRfX4RajYNW1lqjc
 VPrA7gydzis4swZNXs25HXHgt566W4zdExCtgOX4xLQG2Ez2fJ3S5U0pNzHyw/QsmQJcZvw/lwu
 Z5gW4lDRFjJxA+QJz8QNH+r+jbePlvNTsmZTPEAMaj5ecHb6XLp5dMkvZ2fft6cJJtqOUg8Wcxh
 bwXnjdMslsbsnAF6VwmI7JEdZ01j4eBjMLtUSedv8DVfgQ+E4vPVQUsml0XBerhSJmHIhkXSs1s
 rxWbMHe11FvxEp460AYwQI2TooWg2JrPe9CrjAqCZk598yKplX88hQBO0gRSr93J/xhAxNC/F7h
 3xvDp3SyPhgCsEGw66I7ald/XRabaV5I4OuM+1q+uf8HzdzRzO+W73pkxgNV/cBYX8AVWqw0c3A
 YcofNORkIfqigNPoGJ7P3qHgfzTu3J8yfr0ZhalOfKIa2KYpbyn5mxCw6ynFPmQmVysq9Q6RaCE
 JhElGv1HGT0gibhf7Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010177
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



On 8/31/2026 4:41 AM, Xie Bo wrote:
> The vector state sync handles vstart, vl and vtype, but leaves vcsr
> behind.  vxrm and vxsat in the migration stream are therefore stale,
> and the destination does not restore the values held by KVM.
> 
> Read vcsr when collecting vector state and split it into vxrm and
> vxsat.  Rebuild it from those fields when writing vector state back.
> 
> Fixes: 3ca78c0689d5 ("target/riscv/kvm: add RVV and Vector CSR regs")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 1993bd446b..45ad5e1525 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -910,6 +910,13 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
>       }
>       env->vtype = reg;
>   
> +    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    env->vxrm = (reg & VCSR_VXRM) >> VCSR_VXRM_SHIFT;
> +    env->vxsat = (reg & VCSR_VXSAT) >> VCSR_VXSAT_SHIFT;
> +
>       if (kvm_v_vlenb.supported) {
>           ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);
>           if (ret) {
> @@ -966,6 +973,13 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
>           return ret;
>       }
>   
> +    reg = (env->vxrm << VCSR_VXRM_SHIFT) |
> +          (env->vxsat << VCSR_VXSAT_SHIFT);
> +    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vcsr), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (kvm_v_vlenb.supported) {
>           reg = cpu->cfg.vlenb;
>           ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(vlenb), &reg);



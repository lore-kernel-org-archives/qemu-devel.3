Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937F1C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UqM-0007w2-CK; Tue, 01 Sep 2026 16:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1UqL-0007vh-6z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:12:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1UqJ-0000gZ-97
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:12:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681Hg8Ku2110229
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4JoCsTHmoHObHZTGLVJZe/MRPe/Bv1TWjJnRdCT3ZTw=; b=p8xbxJnsMnwDiX0+
 DhVk+6sBQxDl+5PiBXOgeTqk8uv8E2KHD1nlN5jEP5YaMDIAwCudXw2O1J2mCbgr
 ZwXQkxC+3v+TSYmqOyO12hHuv+d8TCz5nHqxFXHyPaLIbRbWL47NP3HSUdGpUrIH
 4YyWg63wcAAZNtG9sCBA0TYbDGFBIKSD5beIID7mJa19AqXDpIooY6rfYQa5Cv3p
 4dAFfD1WWtFtKCyPF8mi0XwYp2bXeQY6v/ZKUoCmdgemrRAGJAllc+3Fp/BtYvq7
 kVPnrTnXJo0UINkZA5oT+hl7ycsFV4iORFVM+7N5nsabEhfsfRQDezkbjpGY3IOl
 YYCkfA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cgkr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:12:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9382f9430deso66781685a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788293543; x=1788898343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4JoCsTHmoHObHZTGLVJZe/MRPe/Bv1TWjJnRdCT3ZTw=;
 b=N1FfAWxZ1RzTnIZ77QtLzqsJdQKeI2HCZhLuPyw78dYZ7Yg7ZgNuv8QW5DTQuhUP3E
 zTUvqD2tt2lAVxDtN+6vxtmOLwM3tGXfNmNDFhy6vlt371y2gl2TOSOxmQlVVYo0oLwR
 wFVKAsJ60OZh9nuVuYKVnv3CHk01Q4PqX0nxqla2lhRC5mD0c4/8kOdi9k+LyWjoDZ5n
 +33gFYrfH24jdjgeV5tZ9aoXxd7czYYv9x0lDiw+WSZP9vfvyc9UbYT0xvtqPxAtlAU5
 DDsSep2EzuHVLfyWxAFJ117Ye/pwt2fJXBOcsLXz/X19L7hy26YoxBwIJk7daaKASWnq
 53TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788293543; x=1788898343;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4JoCsTHmoHObHZTGLVJZe/MRPe/Bv1TWjJnRdCT3ZTw=;
 b=gPde+Ya+5uh5YoYoqPpQDYoIW3gmUSJiRBsUod0iLr3746eE7rDXduPboRTlncGRyx
 O5WZjbJVclzhppx0sXncncyHsARMUyRKs/4iQ1tvwn81ruLI/l9sq4AXVDYhZnnEGQkS
 nEixdSTZCsfgUYsM5Yp5a3oSNAl7Ur+f6tCSvsk9scZ5gnCE7ZSafFDQbkRtC67D3uJV
 7aPHAj7dhaKUf3EPRvbcIjsi/pNvD3uEA5GR/uJy2VPq/Sc3GHgWP+C4QXvpgsuA3Up0
 t/S4m8yLzTrMXY7VupkdkTAPVCm9Oegw1CoAEHq0oabQtkVp9ROtWNbL6+qAvI8QTJjw
 FdHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RomTE7RWYGhvQahbLU8XV7nOQISxMvfgCUxOzPXujZTq1JOtoo11a0oRg/U67KnLn1S7SJkH0XzHR2f@nongnu.org
X-Gm-Message-State: AFuF++m7PIi4egNBucbucIFQeVs58Yxlb9Qe00W38yaTMIFkj8PyXvw1
 vRCgMhKxfiQbdwvxBWXu/6pNLV3LZhb+uPiWafu7khyhQCICj8P92zElL5e3L9KxINoOgHhE7vN
 BSqxFAJJc+hRt8n+/JuaSLGhJjiA5GqGjBb036ASUkeA+yoi6BuAkO7qgtw==
X-Gm-Gg: AR+sD13Dj1OlE585h/raTkBMTHhlfVE1wtI/YPPgwiQ5RSpa9gIsAR8EpbFW+4HODII
 4vwq875lSjZKElcxR70xadsdap3nG8v4fkVJSBAvi7uEa/FiYubTCoXQKodaB43hm27mpT5UeYa
 ftRvtSwQ7tsjAJVDgwnv1nY4bOdDcWF51VcIcyx6CrmFkrjiloUeN5o/QOZ98XTd9iXTaYVhfDC
 yons32bSS45Yj0LH8CeyUDoauafjeQ3tKkIBO+eTFutHrJXW/mRbZix0g9fHsVCTLyjrE9bLAGM
 swayyFxpnSRs2P3GAqpPIFvJ1J4KlIwKt2GraP1TkmbAZa6cMli4HVrA6iHc/hRYp8aYxiKjgcv
 E0UtY4p+f5hUp0b/1Z6bYHciHJxE7VLUByHJl
X-Received: by 2002:a05:620a:4402:b0:939:1acd:7d9 with SMTP id
 af79cd13be357-9391acd0d2fmr3029382085a.4.1788293543118; 
 Tue, 01 Sep 2026 13:12:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4402:b0:939:1acd:7d9 with SMTP id
 af79cd13be357-9391acd0d2fmr3029375685a.4.1788293542640; 
 Tue, 01 Sep 2026 13:12:22 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f35ac8esm22430485a.24.2026.09.01.13.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 13:12:21 -0700 (PDT)
Message-ID: <f15b3ca9-93a2-459b-af8d-b1b807ea7125@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:12:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv/kvm: Preserve FCSR across migration
To: Xie Bo <xb@ultrarisc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org
References: <20260831074106.1798671-1-xb@ultrarisc.com>
 <20260831074106.1798671-2-xb@ultrarisc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831074106.1798671-2-xb@ultrarisc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a9731a8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Lx1EvxgrAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=j1xfHPjNzk49QQBWLo4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=ZFi1QaP_tuf8dODdgmj-:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 5fjEcz6DHnY6-98a_iV_J1aU708t6gAZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NyBTYWx0ZWRfXzXVrZQbPt6Ye
 tkVKHvJHiJh08BFaP/xUcfHDdzW04aBkXCfAG1SJaQrvFihp5AaXFM91A5QQPcegV5i23msbw/Z
 vD8L/mWJ4ZW5XsK+ZYkxUz8XYOtkFDs=
X-Proofpoint-GUID: 5fjEcz6DHnY6-98a_iV_J1aU708t6gAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NyBTYWx0ZWRfX8WU0WEuj5rvK
 V+5JDalXI2z31UYZl/HcsEtc8mpJ54TLxwvCGmWEkw0gKIUoHPt1Tjk0fNYJ1Fl03xYaxyZhItC
 xvK4JDJK1CvtD3JDSBroGwR5M9qhbXGRujovavIs5orotNA1uxIrtoZyqXSySIoGgFIfQAv83cq
 qkLH3/gsuv9JWTdCajZgIUXdZVrpYh9hmvLQZDm/MOlAKxVdzstCh7THPvq3LuEuTs/NsgSAO6H
 4y0fHOr0rsuI4FAteCOKSn4PFtB1gelwQJIHxN/liT1fFAIe+1OJDUTd9R1tJ5lDW25A4N4DHZq
 rCRC//1OL3TNo+byfmga3ibaTAqtUw8DJTi31hJPKQMe3Yffoos/nitoXQrPlbJpGGyuiplQT7X
 4AYdHT1DDaLAJijVGSobTXAgI6FFw2drrdTc1DzoxhiPd3fQjJ5/F9jD3xp0sfm8EhobWdzXqlB
 IpA4OCy89HKtfekkOyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010177
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



On 8/31/2026 4:41 AM, Xie Bo wrote:
> kvm_riscv_get_regs_fp() and kvm_riscv_put_regs_fp() handle f0-f31
> but not FCSR.  KVM exposes FCSR as a separate 32-bit register in both
> the F and D register groups, so frm and fflags are lost after migration.
> 
> Read and write FCSR together with the FP registers and save it in a
> KVM-only subsection.  Older streams do not contain the subsection; in
> that case the destination keeps its reset value.
> 
> Fixes: 937f0b45120b ("target/riscv: Implement kvm_arch_get_registers")
> Fixes: 9997cc1e19d1 ("target/riscv: Implement kvm_arch_put_registers")
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> Cc: qemu-stable@nongnu.org
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.h         |  3 +++
>   target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++----
>   target/riscv/machine.c     | 27 +++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 718b66487a..a5ec69c3cc 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -532,6 +532,9 @@ struct CPUArchState {
>       hwaddr fdt_addr;
>   
>   #ifdef CONFIG_KVM
> +    /* KVM floating-point state */
> +    uint32_t kvm_fcsr;
> +
>       /* kvm timer */
>       bool kvm_timer_dirty;
>       uint64_t kvm_timer_time;
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 68e1501b21..c8ccd9124e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -111,6 +111,14 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>   
>   #define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
>   
> +#define RISCV_FP_F_FCSR_REG \
> +    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, \
> +                         KVM_REG_RISCV_FP_F_REG(fcsr))
> +
> +#define RISCV_FP_D_FCSR_REG \
> +    KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_D, \
> +                         KVM_REG_RISCV_FP_D_REG(fcsr))
> +
>   #define RISCV_VECTOR_CSR_REG(name) \
>       KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_VECTOR, \
>                              KVM_REG_RISCV_VECTOR_CSR_REG(name))
> @@ -743,7 +751,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
>               }
>               env->fpr[i] = reg;
>           }
> -        return ret;
> +        return kvm_get_one_reg(cs, RISCV_FP_D_FCSR_REG,
> +                               &env->kvm_fcsr);
>       }
>   
>       if (riscv_has_ext(env, RVF)) {
> @@ -755,7 +764,8 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
>               }
>               env->fpr[i] = reg;
>           }
> -        return ret;
> +        return kvm_get_one_reg(cs, RISCV_FP_F_FCSR_REG,
> +                               &env->kvm_fcsr);
>       }
>   
>       return ret;
> @@ -776,7 +786,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
>                   return ret;
>               }
>           }
> -        return ret;
> +        return kvm_set_one_reg(cs, RISCV_FP_D_FCSR_REG,
> +                               &env->kvm_fcsr);
>       }
>   
>       if (riscv_has_ext(env, RVF)) {
> @@ -788,7 +799,8 @@ static int kvm_riscv_put_regs_fp(CPUState *cs)
>                   return ret;
>               }
>           }
> -        return ret;
> +        return kvm_set_one_reg(cs, RISCV_FP_F_FCSR_REG,
> +                               &env->kvm_fcsr);
>       }
>   
>       return ret;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 31c49ca3e6..2685338901 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -198,6 +198,32 @@ static const VMStateDescription vmstate_rv128 = {
>   };
>   
>   #ifdef CONFIG_KVM
> +static bool kvm_fcsr_needed(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPURISCVState *env = &cpu->env;
> +
> +    return kvm_enabled() &&
> +           (riscv_has_ext(env, RVF) || riscv_has_ext(env, RVD));
> +}
> +
> +static int kvm_fcsr_post_load(void *opaque, int version_id)
> +{
> +    return kvm_enabled() ? 0 : -ENOTSUP;
> +}
> +
> +static const VMStateDescription vmstate_kvm_fcsr = {
> +    .name = "cpu/kvm-fcsr",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_fcsr_needed,
> +    .post_load = kvm_fcsr_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(env.kvm_fcsr, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static bool kvmtimer_needed(void *opaque)
>   {
>       return kvm_enabled();
> @@ -565,6 +591,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           &vmstate_pointermasking,
>           &vmstate_rv128,
>   #ifdef CONFIG_KVM
> +        &vmstate_kvm_fcsr,
>           &vmstate_kvmtimer,
>           &vmstate_kvm_mp_state,
>   #endif



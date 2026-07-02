Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E29C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfH1i-0004Ww-35; Thu, 02 Jul 2026 09:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfH1b-0004NR-8L
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:00:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfH1Z-000283-6h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:00:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662Ck4o5506397
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ib4PafLJbHbmGiIIQi/bZ2GIC0iW338D6j2BGWMIRlI=; b=RwvRqhdxwUS3W0qs
 lxm2ZvModLOQZOLoPDnMp1X8ucH3myrhrgAYr2t5h6LQcRLKLY8NiUmdWoj2Ypx1
 s3fIcEmFL+YExC7hl2oxivirYiIcVoT2AUznNAgXORDz1hQE1E3dVrgxkMKml2JC
 5od9P0A9HybR7Av2+ndrkx9m5Qvwtkwpkvk0JKiJazAImQR1HZtZrHSPDHC5s1En
 tQRdGMvsvNK/hIxTB/to0MNeTTYS1vTqx+92yJ2BuaBsdLSgLlXrfKCWPGnvOnG0
 SmLKFGx2sV+CZthjYgrEpzb16yHl/n4eBBpJjbVuU7JkOL+zUPYl/kKBIK9iY7+g
 9LXEfg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwrx3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:00:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so185905485a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782997210; x=1783602010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ib4PafLJbHbmGiIIQi/bZ2GIC0iW338D6j2BGWMIRlI=;
 b=gp9W5vYOdkilz3mFf6Qw7MiEY0dlWfjRQjfOJY/z+GT448uo0rL7/df9mAGekseahC
 oHzR8l0qfqk4vEPgh14JKCigsKz9E3ldFhWzA50J8ds/WMrncD2Bvk4op9Pmq+Imoklo
 miLX2nD2lH7unL5QQuaZoApBxw9UCzSu+KYjRPEe3lUF/n1xdQO+BT6rxcpt7SbgxvC6
 HV2RiH3HdSrgC2OH2uf4M25f26ECgqPLLAoqCV8T6B3LSHhprMKIz9/yj95tY4wyvAzl
 wssPHlB3U1rDewZWUqfDfZp2LmnkCFRBwS48bLI7ZP+v9xGyoPDn1QAicxVhJPNjX5pg
 DaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997210; x=1783602010;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ib4PafLJbHbmGiIIQi/bZ2GIC0iW338D6j2BGWMIRlI=;
 b=Rv22SIXpXgp1u/FgLDa+LknIx5lmkfFtDP4IK0LdUaRE4k00/J/IcyivdqFy76Tt7K
 YpNvmgMzr8zSK93BP3NqiNiAtCt5OU969SUcUwe02K4JK6ps7lnRFPwRE+v41vOZIYVM
 n/SrU5kSzm/C9eyZ8SxoyN2e/nsKoLJgnlYp0L4tY1K5wbzafqjnF67FgwgVybmPYc+D
 lVSCqywWMs+odKOt1l3621FM7Kap0M2jCUa1ljz6qsclc3iJ1yD3rSHpObGiGblgm9WP
 bMYIBTl+mPtW/whFMBWYV1V/+T5/Cn8PBK73vy2jPWiNQNcVGTmvgYFtHNby45alkGIN
 kTEA==
X-Gm-Message-State: AOJu0YyCKSY9L6EO1iV4f83xtkEL3TELAuRwqVeZhMtMkfDaOk/CS/Qp
 q8iiyxhsLPfmZv/5R2fAaRWhxRHJPqFc2OhSWUXZ6cU2OdkGNuLA26h7mrHkt8PY2z3HBpekr7P
 Y9ACpNJeHMSabh2ejLjX1qoqx087o6PYDW1yLOp+oXciM/HHK5QgQbkBJKwpinCgqXg==
X-Gm-Gg: AfdE7cmCZ3iHFU+4hcUOmlmCkUBe5VIl/l0g6H6ofLOBeTnosFDUVHxELMwh11pbPdr
 oucIFidtfIr/sW1Tof6IhBPW3tSR5IKxlGwBAxcZTNTZxOVazjWZjYNpfg9yWMJ0cO2TwZTcK9K
 vdzi4lgUT5O6PJANy1ghjbbzkA2XeP8XyBZoP0+Knt8m1LNOIuT7UnG7ej4h1wu3buiSwOiXFbe
 EEz9l9s6aTDqROo4DAAfSLrP61oXqI0kay6YmlD1TlF/KsxubnY8UDO/k2IiRBW81ACna67Pjg0
 GnlT1nmY9CxdBqM1qCDSGzfPCIYzPsziI3QD7bKYITLFRQuHGJzR/6y+g73shXxD1cWB7CFSbXh
 KEmw8mdNUMI6luxX35es48VBCorJErd2ShW6BBr1U28f8Db6yqPkmP7q/15TYPw==
X-Received: by 2002:a05:620a:a090:b0:92e:81c8:3629 with SMTP id
 af79cd13be357-92e81c83723mr239968485a.4.1782997210036; 
 Thu, 02 Jul 2026 06:00:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a090:b0:92e:81c8:3629 with SMTP id
 af79cd13be357-92e81c83723mr239958485a.4.1782997209361; 
 Thu, 02 Jul 2026 06:00:09 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm8465760f8f.7.2026.07.02.06.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:00:08 -0700 (PDT)
Message-ID: <695e34f0-09d2-4fe2-a88a-a63da6568730@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-6-philmd@oss.qualcomm.com>
In-Reply-To: <20260630220100.1289-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ugQip_i-l-4VklhbQ0a0p3mKsAN98yv8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzNiBTYWx0ZWRfXzqIqwtEw1rSv
 JYPK1C98ReniWzeLlzVpBQlKJ44hFCVgf2s7VFSXzdgkEUeBVIe2nZcqpxDyzTh0zHy0/HXWuks
 ifs+EsF6uVrNyLI8pp/t7jAtOv7og1YPiUjuzluSieTPxtKaJMg/6JKMe6I0dwUZI/4gJJK3MsG
 7MbkMYaO8+jnHb2N9RIM9d7aLdiIKEa4l4RWVI/JKsbQlY87vIg84cKREcDVTgo3LQJ+gPEpoFC
 3zFzTzj0tHdKUEAI2Kuf8XN8Jgh+y850pgA/38KrYRvcpu5d69zHeXD68u/bKo5ovY0Lu5jzq4J
 5bozh+r4SWWh/oWLqiZ137twTUK0ucEp4ndfWQ+cVeE5+IkDKAQ7LQiSEOgbCF9OVAEp029EohX
 VGS+LB4YR53Pik1SI9QAwlDY5g99Id6GghuRTg5JVoaTex6VUXUNUcbsr4hVNFrE8DKIxSGGoOv
 TleE8UX9faKdMAc9Omw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzNiBTYWx0ZWRfX2fCYMheSsqff
 wOyogTWr8ghrsX9pNesPX5Ns9DWP09m3MZsmAQK6y2E4mWpMv9JVoGF2/9bDjLfU+34KG2r6Yb3
 hjnCkQ/iMWo8HAq1UDkVI+CSmLXhXeE=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a4660db cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=sz7aHG5tzZAooGLXeZcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ugQip_i-l-4VklhbQ0a0p3mKsAN98yv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Cc'ing Magnus.

On 1/7/26 00:00, Philippe Mathieu-DaudÃ© wrote:
> No need for accel-specific @dirty field when we have
> a generic one in CPUState. (Other accelerators already
> did that in commits 6f13a0ada01..36ab216b81d).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/system/mshv_int.h   |  1 -
>   accel/mshv/mshv-all.c       | 18 +++++++++---------
>   target/i386/mshv/mshv-cpu.c |  6 +++---
>   3 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index ba3073888ac..b91c4d661a3 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -43,7 +43,6 @@ typedef struct MshvHvCallArgs {
>   
>   struct AccelCPUState {
>       int cpufd;
> -    bool dirty;
>       MshvHvCallArgs hvcall_args;
>   };
>   
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 9452504ac28..1959baf6672 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -531,7 +531,7 @@ static int mshv_init_vcpu(CPUState *cpu)
>       }
>   
>       mshv_arch_init_vcpu(cpu);
> -    cpu->accel->dirty = true;
> +    cpu->vcpu_dirty = true;
>   
>       return 0;
>   }
> @@ -617,7 +617,7 @@ static int mshv_cpu_exec(CPUState *cpu)
>       cpu_exec_start(cpu);
>   
>       do {
> -        if (cpu->accel->dirty) {
> +        if (cpu->vcpu_dirty) {
>               ret = mshv_arch_store_vcpu_state(cpu);
>               if (ret) {
>                   error_report("Failed to put registers after init: %s",
> @@ -625,7 +625,7 @@ static int mshv_cpu_exec(CPUState *cpu)
>                   ret = -1;
>                   break;
>               }
> -            cpu->accel->dirty = false;
> +            cpu->vcpu_dirty = false;
>           }
>   
>           ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
> @@ -746,7 +746,7 @@ static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
>           abort();
>       }
>   
> -    cpu->accel->dirty = false;
> +    cpu->vcpu_dirty = false;
>   }
>   
>   static void mshv_cpu_synchronize_post_init(CPUState *cpu)
> @@ -763,13 +763,13 @@ static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
>           cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
>           vm_stop(RUN_STATE_INTERNAL_ERROR);
>       }
> -    cpu->accel->dirty = false;
> +    cpu->vcpu_dirty = false;
>   }
>   
>   static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
>                                                  run_on_cpu_data arg)
>   {
> -    cpu->accel->dirty = true;
> +    cpu->vcpu_dirty = true;
>   }
>   
>   static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
> @@ -779,7 +779,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
>   
>   static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
>   {
> -    if (!cpu->accel->dirty) {
> +    if (!cpu->vcpu_dirty) {
>           int ret = mshv_arch_load_vcpu_state(cpu);
>           if (ret < 0) {
>               error_report("Failed to load registers for vcpu %d",
> @@ -789,13 +789,13 @@ static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
>               vm_stop(RUN_STATE_INTERNAL_ERROR);
>           }
>   
> -        cpu->accel->dirty = true;
> +        cpu->vcpu_dirty = true;
>       }
>   }
>   
>   static void mshv_cpu_synchronize(CPUState *cpu)
>   {
> -    if (!cpu->accel->dirty) {
> +    if (!cpu->vcpu_dirty) {
>           run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
>       }
>   }
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 126ca40b481..1c433c408c8 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1692,7 +1692,7 @@ static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
>       return ret;
>   }
>   
> -static int handle_pio_non_str(const CPUState *cpu,
> +static int handle_pio_non_str(CPUState *cpu,
>                                 hv_x64_io_port_intercept_message *info)
>   {
>       size_t len = info->access_info.access_size;
> @@ -1748,7 +1748,7 @@ static int handle_pio_non_str(const CPUState *cpu,
>           return -1;
>       }
>   
> -    cpu->accel->dirty = false;
> +    cpu->vcpu_dirty = false;
>   
>       return 0;
>   }
> @@ -1909,7 +1909,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
>           return -1;
>       }
>   
> -    cpu->accel->dirty = false;
> +    cpu->vcpu_dirty = false;
>   
>       return 0;
>   }



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0658CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDBh-0003dD-La; Thu, 01 Oct 2026 05:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCDBe-0003cW-V0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:34:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xCDBb-0002RB-MZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:34:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xtsT1661232
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 09:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDhyweDgm4uV4zqSF981mMWgw38ZRJjlbHP65gAzV8w=; b=lFfwtL/YQM+tTWyz
 7nCXCsNmMtvTxEGhLHyDMwwI1KLrXzB1PbWFurx7ajUUYqis3RuwmjJZZV6mKYvO
 7fQvK88haJKMgZkpsZ63Rc1YSdXOzuCOp4HuuU2sdE9uuYzOYl2rn6xa3drgPccR
 1cowqfg7nLRw19vXoGLHvk94XwJytCIRj/SnhRL7ctzFvn+4FGNrtFzZdMl3wOz5
 Kh5QRdn8lS4Np6Gp9ANVx2kd6WIWV9kkU9iilOqMmA114lQ1QsO3EtNNBZCLnC3t
 dO8Te1h+B8X2hNBeQsWUq6RuXytBrj2VovcfsH1R6a72WqV9oRT7ZlBZuLGtZMfZ
 2JpEnw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pkm59-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:34:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5338f659170so5875881cf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790847281; x=1791452081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QDhyweDgm4uV4zqSF981mMWgw38ZRJjlbHP65gAzV8w=;
 b=DLL4iUavZ8S34ufQs9FON+Hg3ISAUt6j+qo120/zgcqNQqT5u40OfI0wjNIMfVnaOY
 55nqw+Fx8Y6m1ICSKTxo+binI+A/VzKVUdYaO15ND8B44bMh+zRq5QHAF7FqDoWmOLyK
 fXooopN6RRFOp4sdgiVj4DIsY1oN75N2TIGUjRdUmF5LKTXsNo0Cx7V7W0hDOe5G/AC0
 LYUvcdsILinoHRsp8ZbhvzJ7oycDarjLkTGakFeFc6i7MFtde9z+NGfW/5a13M4tyVWO
 Is7EqK2xsHU+Ss//lMM1u7yWUbV1U8bl4RF3/GfZkbEgjWkhC3H7sMrC+ZXH0y1SPnkT
 Q4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847281; x=1791452081;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDhyweDgm4uV4zqSF981mMWgw38ZRJjlbHP65gAzV8w=;
 b=NstutT6nQH5iQoS7gTnVLC1Qk54qQ6F3rBt5SBsDpNkYzLuiwZ60w3fjKjLxTAeRj8
 k2jdfHO3+jkZUoyu0XhvPwLuIUyDcTs5EZIfekwBv9aOE2cGz0Kbvh7vozqIIgy3ITdn
 FvOeGJgkx4xm26DZlSKSWghY7GRdYZxmJEuMElbhSc6KQ0Shc+vzGzAPfCmZrvF+FQ/M
 E3KYhgrN7N2MYW2Ce3XamsnwLcsHsZ9ivFjFCZdLT5w6jJZahLqZoxLCzpRqTflZ2eDz
 N9Ix3BZHG3mpFjOhxhPRQ4ZT+z8sDPMwL+mnDKSX1u7w7CCVhUYzJMybTd6gX8dAim7t
 em+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTuo4Rq8e1oYkduC+nG9bdRq2W16BK0AOnfWoxYVbPAivYS9KEZBXyueZqCkAVpNCcxJO4K8xz2xcH@nongnu.org
X-Gm-Message-State: AFuF++mXYsv6kdzhI7L0zU1MtGkzd4YDaoOa3oUFGl4KWHEgTD37hUDd
 KOMTUqng6MwsHeYX5Ebr8BgUuHHKdz2/C5/tQZEyIzdJVKAnLSkQcWIFzJGkHIwwpYGNb9H/XJ/
 FF9174g8IXfivfqquABWxYYP7ltMdwKUA6Vmc555w6ij3Gzr3ieuRvNNyUA==
X-Gm-Gg: AYBFou0njd67CXYJ74YDAZUVaS3GNXblCL/BGMzycNJfpRO1MIbwcemtuinbR436PlE
 cIbF2vnjnmvPYitxyM1sd+f935wBZCu5KDDArC/M3Bt6Hm+wi+XR5MLQ8VNz0w2cpK2DJY56/sd
 /xULmYWZUg9wgeB7n60Ep2X3OfhAjFWtPkCjp7YBbqzIpxefrPo282hIkyyH0SH0eo8MOMrkzCZ
 rpah3s2DvKcidoiGoDlxxmJjQxyfQvCSvRvH9OSKx+twjXuR4LCc0kz1O1VjToTfGImMKHXoTEI
 yveKewpQJJB2DowfnagopBJREAq/40aL986T3DHyInoWXxG+XWEzxRbMS32gJujbF4KqBUC93LV
 Ew2x3JKFaAx+MpoJjjMi92zg3AHwvXXZJqw==
X-Received: by 2002:ac8:5a51:0:b0:533:228a:1cd2 with SMTP id
 d75a77b69052e-53374258184mr79897391cf.15.1790847280641; 
 Thu, 01 Oct 2026 02:34:40 -0700 (PDT)
X-Received: by 2002:ac8:5a51:0:b0:533:228a:1cd2 with SMTP id
 d75a77b69052e-53374258184mr79896921cf.15.1790847279990; 
 Thu, 01 Oct 2026 02:34:39 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53385f7c74asm16242471cf.1.2026.10.01.02.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 02:34:39 -0700 (PDT)
Message-ID: <2bc44463-2a86-4e49-bac1-6286a0cdc9c2@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 06:34:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Reset vCPU on VM reset via
 MP_STATE_INIT_RECEIVED
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EpE9PsGtp7-vjxNZ2iovAcLW37MVCLjo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfXxp2zKUvuFqyY
 AgLYruPbsMv0MrLn2VILByE0s+D4N5X7CSKOwY18kb79Wtnr4eI/rVroH6NYMw/H3SJE3KHcLkM
 p1qp4F1ULcHO65cZTlLJVpDlcBmk7Z4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX3cHtaPn2VKVS
 VE2PiAd4tz12vEsOe9MILeRUHYHJovqA9UZU+/N4EWQYqk3fX4uH9UjLuTtvrjCogR4Jm6XbY8U
 65UrCLtitskDfj9qyDNBW/IBEJ+n8fWKHjM4vCJRHPExvEHJq7VYeipKo7ol3/ZsKpOMb/zZUk9
 ScfcIl+P2aOuIsRUUdksJFyioVOx9iV1vUbMm4bLXb+L93abfq5I2foKfsWDV2ZLMHKg6EJeFej
 GT33MJ9Up9rCwUncm6AAfMHF/YLxPym7KKTzYdxtm8k3a7OLsq3/ZYJkv0ih65KcOC/9NQC6zuS
 d67HgPHAxkd6h96qmZREDIEtiewGbbXAGu5s17Hgy6tBfJAwbonp5r9mqGuzXePLFoOjkdztFCT
 pewrdv0K86Wp2gpfyzbaEjv8dE67Wzqd8vUwy39FBgJQQt9aMLsmDtd+D/S7+ypbe7qVZK17Xpi
 MegWkj+ie7AQcUwwEhw==
X-Proofpoint-GUID: EpE9PsGtp7-vjxNZ2iovAcLW37MVCLjo
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe2931 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=jbqyKmyYbxlRs/MVMa3Ccg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=S796rhnvKvYWZhZiP70A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/30/2026 6:39 AM, Wang Yechao wrote:
> When a VM reset is requested, KVM needs to reset the register state of
> the vCPUs. Without this, stale KVM-internal vCPU state (such as the SBI
> STA shared memory address) is preserved across the reset, which can
> cause KVM to keep writing steal-time data to an address that now belongs
> to firmware code, corrupting it.
> 
> Add support for the KVM_CAP_RISCV_MP_STATE_RESET capability. When
> enabled, QEMU resets the vCPU by setting MP_STATE_INIT_RECEIVED through
> the KVM_SET_MP_STATE ioctl during the KVM_PUT_RESET_STATE phase of
> kvm_arch_put_registers(). KVM performs the register reset while
> preserving the original MP_STATE, so no state restoration is needed on
> the QEMU side.
> 
> This reset path is reached both when the guest initiates an SBI system
> reset and when userspace (e.g. the QEMU monitor) requests a VM reset,
> covering both reboot scenarios.
> 
> The capability is optional and only activated if the host kernel
> advertises KVM_CAP_RISCV_MP_STATE_RESET, ensuring backward compatibility
> with older kernels.
> 
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 68e1501b21..30cea19dea 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
>   }
>   
>   static bool cap_has_mp_state;
> +static bool mp_state_reset;
>   
>   #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
>                                            type | idx)
> @@ -1405,10 +1406,31 @@ static int kvm_riscv_put_mp_state(CPUState *cs)
>       return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
>   }
>   
> +static int kvm_riscv_mp_state_init_received(CPUState *cs)
> +{
> +    struct kvm_mp_state mp_state = {
> +        .mp_state = KVM_MP_STATE_INIT_RECEIVED,
> +    };
> +
> +    if (!cap_has_mp_state || !mp_state_reset) {
> +        return 0;
> +    }
> +
> +    /* Let KVM resets the VCPU, The original MP_STATE is preserved*/
> +    return kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
> +}
> +
>   int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>   {
>       int ret = 0;
>   
> +    if (KVM_PUT_RESET_STATE == level) {
> +        ret = kvm_riscv_mp_state_init_received(cs);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>       ret = kvm_riscv_put_regs_core(cs);
>       if (ret) {
>           return ret;
> @@ -1585,6 +1607,11 @@ int kvm_arch_get_default_type(MachineState *ms)
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
> +
> +    if (cap_has_mp_state) {
> +        mp_state_reset = !kvm_vm_enable_cap(s, KVM_CAP_RISCV_MP_STATE_RESET, 0);
> +    }
> +
>       return 0;
>   }
>   



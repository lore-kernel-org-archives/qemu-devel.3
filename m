Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B2CF45DB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 02:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfUCT-0005gR-9b; Mon, 12 Jan 2026 21:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vfUCL-0005fG-L8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 21:31:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vfUCG-0002Qs-TW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 21:31:57 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxWcKNrmVp2S0IAA--.26162S3;
 Tue, 13 Jan 2026 10:31:41 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx+8GIrmVp+HIcAA--.56728S3;
 Tue, 13 Jan 2026 10:31:39 +0800 (CST)
Subject: Re: [PATCH v3 3/4] target/loongarch: Add host CPU model in kvm mode
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260112080721.3319572-1-maobibo@loongson.cn>
 <20260112080721.3319572-4-maobibo@loongson.cn>
 <55ef7d7a-ddef-4171-a5bb-b73d1a1632ff@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <555717ef-4ec0-0a28-d7f4-3f2cdf4c5f81@loongson.cn>
Date: Tue, 13 Jan 2026 10:29:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <55ef7d7a-ddef-4171-a5bb-b73d1a1632ff@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+8GIrmVp+HIcAA--.56728S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4fur1DGr4rKryDGw1xWFX_yoW5XFWkpr
 1kJrWUJryUJrn5Jr1UtryUXFy5Zr1UJ3Wqqr48XF15AFsrAr1jgF4UWrsFgr1UJr48Jr1U
 Ar1UXrsxZrsrJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.348,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/13 上午5:45, Richard Henderson wrote:
> On 1/12/26 19:07, Bibo Mao wrote:
>> +#if defined(CONFIG_KVM)
>> +static int read_cpuinfo(const char *field, char *value, int len)
>> +{
>> +    FILE *f;
>> +    int ret = -1;
>> +    int field_len = strlen(field);
>> +    char line[512];
>> +
>> +    f = fopen("/proc/cpuinfo", "r");
>> +    if (!f) {
>> +        return -1;
>> +    }
>> +
>> +    do {
>> +        if (!fgets(line, sizeof(line), f)) {
>> +            break;
>> +        }
>> +        if (!strncmp(line, field, field_len)) {
>> +            strncpy(value, line, len);
>> +            ret = 0;
>> +            break;
>> +        }
>> +    } while (*line);
>> +
>> +    fclose(f);
>> +
>> +    return ret;
>> +}
>> +
>> +static uint64_t get_host_cpu_model(void)
>> +{
>> +    char line[512];
>> +    char *ns;
>> +    static uint64_t cpuid;
>> +
>> +    if (cpuid) {
>> +        return cpuid;
>> +    }
>> +
>> +    if (read_cpuinfo("Model Name", line, sizeof(line))) {
>> +        return 0;
>> +    }
>> +
>> +    ns = strchr(line, ':');
>> +    if (!ns) {
>> +        return 0;
>> +    }
>> +
>> +    ns = strstr(ns, "Loongson-");
>> +    if (!ns) {
>> +        return 0;
>> +    }
>> +
>> +    ns += strlen("Loongson-");
>> +    memccpy((void *)&cpuid, ns, 0, 8);
>> +    return cpuid;
>> +}
>> +
>> +static uint32_t get_host_cpucfg(int number)
>> +{
>> +    unsigned int data = 0;
>> +
>> +#ifdef __loongarch__
>> +    asm volatile("cpucfg %[val], %[reg]"
>> +                 : [val] "=r" (data)
>> +                 : [reg] "r" (number)
>> +                 : "memory");
>> +#endif
>> +
>> +    return data;
>> +}
> Are you sure you should be bypassing KVM for this?  Other targets start 
> a scratch vcpu and then read the values via KVM_GET_ONE_REG.
Feature detection instruction CPUCFG can be executed in user mode, 
similar with CPUID on X86, on ARM platform instruction MRS can only used 
in privileged mode.

On LoongArch platform, it is both OK to detect host CPU features by 
CPUCFG instruction or KVM_GET_DEVICE_ATTR ioctl command method.
     struct kvm_device_attr attr = {
         .group = KVM_LOONGARCH_VCPU_CPUCFG,
         .attr = 2,
         .addr = (uint64_t)&val,
     };

     CPULoongArchState *env = cpu_env(cs);
     ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
     if (!ret) {
         kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
     }

Regards
Bibo Mao
> 
> I'm not sure how much trap-and-emulate support LoongArch has for such ID 
> registers.
> 
> 
> r~



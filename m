Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194D8EE369C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYyJ-0002tI-8o; Thu, 12 Feb 2026 10:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYyG-0002iN-Mh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:51:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYyE-0006B1-R3
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:51:12 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43621bf67ceso4304f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911469; x=1771516269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S6DdUmC0yDgG8PTtWksYKxgeG5Jhbp3uDT3klUdQR4A=;
 b=m4w3UsWpc1IyTibmX99p/mJOXtsA2NmpYO4J0iclRR3jggwDcJ2ltpsE4jnCcKB+Ra
 5PLhtV5RMGCbR/nIsw3EyVMaTKYFbQN8zF3n4rrA7U78Yq20rKJfLdAhup/ZmI+9CEfD
 4Y316sWL78Q76hYyPSouUwyYfDGILXZkt4RnOMRlah46f+dTYUs0fVPtoqUcS+GzKGmS
 hwEIoZJu+Y3ACpE3yC/vLpVNuDMx5Wiyaz07yJBo4MZRauG8VvcbXSdJSRgWgre4nomp
 Am0c/aon5hJ1WZhAPm8KEVPxG+5MR3Y+v3LRMe44vLlQsjf/OmDiy2ON/QDP2DWBVLmN
 G1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911469; x=1771516269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6DdUmC0yDgG8PTtWksYKxgeG5Jhbp3uDT3klUdQR4A=;
 b=dU7T3bxFm39J62QPzNlerpJVBWnh/n9soWXKqrMR1gGP4jlXEXBCpqC07/cqIEWovg
 L7jkOd9QsM7V0yhlL1CLQRDWUiiWh/V3eoCe0yCpt/3wjGrbDnkjUID6Gzja/jW7Pg67
 mzd40NeLCPapAqPmIfEVQ4uDzUFDiDdE7EDFcnvnplb637dQyS7V96q/Zg0BdIA1iVsX
 A6ZnI0IqrJnjVSPPJYQJty5mArdSe2o5VW0VOPqEzTmlGK319x/p44/uNiqolbYx7b33
 mMckXk0KeusFkt7AcRH5bMXX/wyV3yWjtANTtTC+Alsj4KKhvStonArDwkAj3/dCjPY7
 IcKA==
X-Gm-Message-State: AOJu0Yz5F3/Twy1twE9MMhZ4tw/5ysVmi5Gw/vqAv5/fMJj/uv6pw0HC
 hKZTjnr8uWSAk+OmRsndGmJm8PBbJn1q7N13eA5K+Ih/Tsyti0OK5otKE+niJvP/TJwMalSy/sY
 dUsYRgnk=
X-Gm-Gg: AZuq6aJrOXLOKegiWu7fu5xqNZ2VBbPAsxoUqFFFdkDY/lcCy76itWkOLsZ/O+Edoel
 bbulJMFaa9ENLEDSJYaP+A1OT+L6WY8edWAqe+yTQpLQ9IgTjHAVyQChd52gqWmPGZDayJ7sCK9
 AlPAGfYnVQRt2O44EWSxAN6GU4en/9UeMJfFFb2uJ0ThS9bYidSk6jZ2zVOltYIpMbQuR6HMMIY
 yi3MgorwCePrW53hQDambJgnSIgHYCI7bNdSy5EueljyKr9gBSt9w2iUf9EczMLpH1m1TMQglTW
 lD2M/QzntRHgegRcnBnDoA/GB1msPOLfKBy3cMbuScEBFK85qMbdDrfz2PfU0GW0lsueqo6vqGi
 4+sn3AGR6lg5z8VuOKFRt5YvrdHnN5d7k1xLePehCI8kR7lD1b/k0wRIGxLN+oVexx3TxDSvxEy
 mKOgaXlOq0qrwURIwJnOtBCh5sbIAltR/9H+JqO69Dsvq355i0kfVYkeS52ZguPa+X4A==
X-Received: by 2002:a05:6000:2307:b0:437:7168:af4f with SMTP id
 ffacd0b85a97d-4378aa14dcemr6584168f8f.27.1770911468906; 
 Thu, 12 Feb 2026 07:51:08 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e3b829sm12879014f8f.27.2026.02.12.07.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:51:08 -0800 (PST)
Message-ID: <16c45b70-23cd-4522-8ece-1c268fb72a73@linaro.org>
Date: Thu, 12 Feb 2026 16:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
Content-Language: en-US
To: qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
 <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
 <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
 <0eb5bcf9-bc2e-46c6-9f54-1514039557e0@ventanamicro.com>
 <37e6fecd-948a-4840-9189-918d44c0be72@linaro.org>
 <c2b0fb25-8b17-4a69-a128-2f8cc9bbba76@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c2b0fb25-8b17-4a69-a128-2f8cc9bbba76@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Daniel,

On 4/6/25 12:54, Daniel Henrique Barboza wrote:
> 
> 
> On 6/4/25 6:38 AM, Philippe Mathieu-Daudé wrote:
>> (+Marc-André and Paolo who I forgot to Cc first)
>>
>> On 4/6/25 11:17, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 6/4/25 4:32 AM, Philippe Mathieu-Daudé wrote:
>>>> On 3/6/25 20:04, Daniel Henrique Barboza wrote:
>>>>>
>>>>>
>>>>> On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Daniel,
>>>>>>
>>>>>> (now merged as commit a6b53378f537)
>>>>>>
>>>>>> On 25/4/24 17:50, Daniel Henrique Barboza wrote:
>>>>>>> SBI defines a Debug Console extension "DBCN" that will, in time, 
>>>>>>> replace
>>>>>>> the legacy console putchar and getchar SBI extensions.
>>>>>>>
>>>>>>> The appeal of the DBCN extension is that it allows multiple bytes 
>>>>>>> to be
>>>>>>> read/written in the SBI console in a single SBI call.
>>>>>>>
>>>>>>> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
>>>>>>> module to userspace. But this will only happens if the KVM module
>>>>>>> actually supports this SBI extension and we activate it.
>>>>>>>
>>>>>>> We'll check for DBCN support during init time, checking if get- 
>>>>>>> reg- list
>>>>>>> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable 
>>>>>>> it via
>>>>>>> kvm_set_one_reg() during kvm_arch_init_vcpu().
>>>>>>>
>>>>>>> Finally, change kvm_riscv_handle_sbi() to handle the incoming 
>>>>>>> calls for
>>>>>>> SBI_EXT_DBCN, reading and writing as required.
>>>>>>>
>>>>>>> A simple KVM guest with 'earlycon=sbi', running in an emulated 
>>>>>>> RISC-V
>>>>>>> host, takes around 20 seconds to boot without using DBCN. With this
>>>>>>> patch we're taking around 14 seconds to boot due to the speed-up 
>>>>>>> in the
>>>>>>> terminal output.  There's no change in boot time if the guest isn't
>>>>>>> using earlycon.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>>>>> ---
>>>>>>>   target/riscv/kvm/kvm-cpu.c         | 111 ++++++++++++++++++++++ 
>>>>>>> ++ +++++
>>>>>>>   target/riscv/sbi_ecall_interface.h |  17 +++++
>>>>>>>   2 files changed, 128 insertions(+)
>>>>>>
>>>>>>
>>>>>>> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct 
>>>>>>> kvm_run *run)
>>>>>>> +{
>>>>>>> +    g_autofree uint8_t *buf = NULL;
>>>>>>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>>>>>>> +    target_ulong num_bytes;
>>>>>>> +    uint64_t addr;
>>>>>>> +    unsigned char ch;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    switch (run->riscv_sbi.function_id) {
>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_READ:
>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
>>>>>>> +        num_bytes = run->riscv_sbi.args[0];
>>>>>>> +
>>>>>>> +        if (num_bytes == 0) {
>>>>>>> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>>> +            run->riscv_sbi.ret[1] = 0;
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        addr = run->riscv_sbi.args[1];
>>>>>>> +
>>>>>>> +        /*
>>>>>>> +         * Handle the case where a 32 bit CPU is running in a
>>>>>>> +         * 64 bit addressing env.
>>>>>>> +         */
>>>>>>> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
>>>>>>> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        buf = g_malloc0(num_bytes);
>>>>>>> +
>>>>>>> +        if (run->riscv_sbi.function_id == 
>>>>>>> SBI_EXT_DBCN_CONSOLE_READ) {
>>>>>>> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, 
>>>>>>> num_bytes);


Still following up on that patch :) Do we have one SBI debug console
per system / soc / cluster / hart? Instead of calling serial_hd(0)
each time we should set it once when realizing the vcpu IMO. If it is
per hart we would add this property:

   DEFINE_PROP_CHR("sbi-chardev", RISCVCPU, sbi_console),

WDYT?

>>>>>>> +            if (ret < 0) {
>>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error 
>>>>>>> when "
>>>>>>> +                             "reading chardev");
>>>>>>> +                exit(1);
>>>>>>> +            }
>>>>>>> +
>>>>>>> +            cpu_physical_memory_write(addr, buf, ret);
>>>>>>> +        } else {
>>>>>>> +            cpu_physical_memory_read(addr, buf, num_bytes);
>>>>>>> +
>>>>>>> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, 
>>>>>>> num_bytes);
>>>>>>> +            if (ret < 0) {
>>>>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error 
>>>>>>> when "
>>>>>>> +                             "writing chardev");
>>>>>>> +                exit(1);
>>>>>>> +            }
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>>>>> +        run->riscv_sbi.ret[1] = ret;
>>>>>>> +        break;
>>>>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
>>>>>>> +        ch = run->riscv_sbi.args[0];
>>>>>>> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
>>>>>>> +
>>>>>>> +        if (ret < 0) {
>>>>>>> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error 
>>>>>>> when "
>>>>>>> +                         "writing chardev");
>>>>>>> +            exit(1);
>>>>>>> +        }


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3462CC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkFU-00004q-VL; Wed, 04 Jun 2025 05:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMkFU-0008WH-89
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:17:28 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMkFR-0005oj-VD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:17:28 -0400
Received: by mail-ua1-x943.google.com with SMTP id
 a1e0cc1a2514c-87ded9c6eb4so569431241.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749028644; x=1749633444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcGOpse+45eqXstSFyZXs2NTldKwpQLkrRotxXyIqVU=;
 b=Cjpobot4BcGhTO6OfHo6T2qybyb2qJgluuM35b+jWbRjIpdEVGlkorq3USiSkdtT75
 l1yYnsbGj8/qcN0P9LIicKbXnSmwhwkAWeIg/YGyyIVvKc5fyEa/1Ev28iXi0hclllGb
 KbIcAdIeMcWJ2sUod3p2uMCqeJ9VWArGXX1It6/PGtRQ2OWSweXC/mDdWX5al42ktTKP
 roq0JpcU4xDaZJC6RPE2CWx2XrpxvjIgxSdDhjvhXdpM/q1FJ6zkYLo7+cI1q0ZCOMG3
 RW40PUpyzZ1juKYDENFfVa16IoPOvgARW0Qw5MOFLKSkv16WQ5KVzZSUz4x4bhpk5bFU
 KI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749028644; x=1749633444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcGOpse+45eqXstSFyZXs2NTldKwpQLkrRotxXyIqVU=;
 b=DH9DUulp/V1wlv5EFsm3eNU8tfuHqXMftAU5GWTDqN6XUEnUT3B9G9W2hIynsP9xjs
 8Gov7bs2erhfX99dOxuJ0zqoCbSxUYWA1NM0V/YGV/3sJpHvVMdvxa7xMAKpZG41nctW
 y+HXU+ZIj1La1St1yP3pchPYRAV1onkTX+0tAXls1gh9H32jr9VubuYK2KfRfnrjPQiz
 prGoVR93euM6tQN/O6ETKbwrfXA5fQEdHdY2MpQACGb4yBTokt2aFDFMrrqpAdAQ2eu1
 SAg/MOyewdxUbFGZmp6BKRwtUBwmeHjjPZ1DSR5ulbwj2N05D7rtbJmhZOnApGQjn9CB
 C+vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC2tMyx32wp6/hbWJJpO2A8VKW7o5JUvJpabgo9BsxcA6XzZgztILy/8fPeurhTuByYGf3hLI6C1Ui@nongnu.org
X-Gm-Message-State: AOJu0Yx1Yn3saQfqUdP4X9avEqWf7TskgmnYLEeVqxwY/7jE9asfo+wS
 npRMFTAqX+hgA84LG93Z0kkhVvaFV0r2KQl5mdmd0yKYGCCuNacCZ183sfBeSohO+AE=
X-Gm-Gg: ASbGncuRGBhqewchmV7IXRGaRCFj+wNqhDMU71eK6WRefIRg1idHW+OBxNjlLSpLfH0
 nWWTLDmee7rFhRN+OtIB6Lzh6fjLujJk5oBrH+MtpEvI5MEtu5numrd5cPWG+mDrnq4MNBcqEwj
 kgCmYy/guFiiq9FSwukELB8MFUDZZ8YjKKXP6pFARIvH/7UhKOy+PELMc0D1WVmLKdixOIJYxHn
 HwNnXxLSLdLJoSoEsvm/smnVc/dn3SdY7sloMisfPg6Q72Wkvz7z7XrvfpMvK+eUiS4F689U+lN
 t9DMFutfL8Carx6i54E+5wyBYiGCPo5docuuDYm9pGYvrplkvsyMjVcSxrcgPqCZoFY=
X-Google-Smtp-Source: AGHT+IGjNyVY4TPhdMZxpijEyx7mVZ/4ucqEPEFRxgINW0Wbgr8CfSH35kyTAyJlhoy/++MTjTq4Iw==
X-Received: by 2002:a05:6102:4585:b0:4e5:8d83:c50e with SMTP id
 ada2fe7eead31-4e73616269fmr3661538137.10.1749028644362; 
 Wed, 04 Jun 2025 02:17:24 -0700 (PDT)
Received: from [192.168.68.110] ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87ea779c389sm398113241.1.2025.06.04.02.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:17:23 -0700 (PDT)
Message-ID: <0eb5bcf9-bc2e-46c6-9f54-1514039557e0@ventanamicro.com>
Date: Wed, 4 Jun 2025 06:17:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: implement SBI debug console (DBCN) calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240425155012.581366-1-dbarboza@ventanamicro.com>
 <eb6bd3d7-c66b-4300-9573-c29830a3aff4@linaro.org>
 <102e2e67-4c4d-4912-a892-20f5136f241a@ventanamicro.com>
 <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <47327da2-be3c-4aaa-ab3d-36e8d0c25185@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x943.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/4/25 4:32 AM, Philippe Mathieu-Daudé wrote:
> On 3/6/25 20:04, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/3/25 10:19 AM, Philippe Mathieu-Daudé wrote:
>>> Hi Daniel,
>>>
>>> (now merged as commit a6b53378f537)
>>>
>>> On 25/4/24 17:50, Daniel Henrique Barboza wrote:
>>>> SBI defines a Debug Console extension "DBCN" that will, in time, replace
>>>> the legacy console putchar and getchar SBI extensions.
>>>>
>>>> The appeal of the DBCN extension is that it allows multiple bytes to be
>>>> read/written in the SBI console in a single SBI call.
>>>>
>>>> As far as KVM goes, the DBCN calls are forwarded by an in-kernel KVM
>>>> module to userspace. But this will only happens if the KVM module
>>>> actually supports this SBI extension and we activate it.
>>>>
>>>> We'll check for DBCN support during init time, checking if get-reg-list
>>>> is advertising KVM_RISCV_SBI_EXT_DBCN. In that case, we'll enable it via
>>>> kvm_set_one_reg() during kvm_arch_init_vcpu().
>>>>
>>>> Finally, change kvm_riscv_handle_sbi() to handle the incoming calls for
>>>> SBI_EXT_DBCN, reading and writing as required.
>>>>
>>>> A simple KVM guest with 'earlycon=sbi', running in an emulated RISC-V
>>>> host, takes around 20 seconds to boot without using DBCN. With this
>>>> patch we're taking around 14 seconds to boot due to the speed-up in the
>>>> terminal output.  There's no change in boot time if the guest isn't
>>>> using earlycon.
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> ---
>>>>   target/riscv/kvm/kvm-cpu.c         | 111 +++++++++++++++++++++++++++++
>>>>   target/riscv/sbi_ecall_interface.h |  17 +++++
>>>>   2 files changed, 128 insertions(+)
>>>
>>>
>>>> +static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
>>>> +{
>>>> +    g_autofree uint8_t *buf = NULL;
>>>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>>>> +    target_ulong num_bytes;
>>>> +    uint64_t addr;
>>>> +    unsigned char ch;
>>>> +    int ret;
>>>> +
>>>> +    switch (run->riscv_sbi.function_id) {
>>>> +    case SBI_EXT_DBCN_CONSOLE_READ:
>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE:
>>>> +        num_bytes = run->riscv_sbi.args[0];
>>>> +
>>>> +        if (num_bytes == 0) {
>>>> +            run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>> +            run->riscv_sbi.ret[1] = 0;
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        addr = run->riscv_sbi.args[1];
>>>> +
>>>> +        /*
>>>> +         * Handle the case where a 32 bit CPU is running in a
>>>> +         * 64 bit addressing env.
>>>> +         */
>>>> +        if (riscv_cpu_mxl(&cpu->env) == MXL_RV32) {
>>>> +            addr |= (uint64_t)run->riscv_sbi.args[2] << 32;
>>>> +        }
>>>> +
>>>> +        buf = g_malloc0(num_bytes);
>>>> +
>>>> +        if (run->riscv_sbi.function_id == SBI_EXT_DBCN_CONSOLE_READ) {
>>>> +            ret = qemu_chr_fe_read_all(serial_hd(0)->be, buf, num_bytes);
>>>> +            if (ret < 0) {
>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_READ: error when "
>>>> +                             "reading chardev");
>>>> +                exit(1);
>>>> +            }
>>>> +
>>>> +            cpu_physical_memory_write(addr, buf, ret);
>>>> +        } else {
>>>> +            cpu_physical_memory_read(addr, buf, num_bytes);
>>>> +
>>>> +            ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
>>>> +            if (ret < 0) {
>>>> +                error_report("SBI_EXT_DBCN_CONSOLE_WRITE: error when "
>>>> +                             "writing chardev");
>>>> +                exit(1);
>>>> +            }
>>>> +        }
>>>> +
>>>> +        run->riscv_sbi.ret[0] = SBI_SUCCESS;
>>>> +        run->riscv_sbi.ret[1] = ret;
>>>> +        break;
>>>> +    case SBI_EXT_DBCN_CONSOLE_WRITE_BYTE:
>>>> +        ch = run->riscv_sbi.args[0];
>>>> +        ret = qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
>>>> +
>>>> +        if (ret < 0) {
>>>> +            error_report("SBI_EXT_DBCN_CONSOLE_WRITE_BYTE: error when "
>>>> +                         "writing chardev");
>>>> +            exit(1);
>>>> +        }
>>>
>>> We are ignoring partial writes (non-blocking call returning 0 byte
>>> written), is that expected? If so, is it OK to add a comment we can
>>> safely discard not-yet-written DBCN_CONSOLE_WRITE_BYTE?
>>
>> Not sure what you meant. IIUC qemu_chr_fe_write() returns the number
>> of bytes consumed, 0 if no chardev is found, and -1 on error.
> 
> I'm trying to address an issue Peter reported with qemu_chr_fe_write():
> https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/
> 
> Basically upon introduction in commit cd18720a294 in 2013
> ("char: introduce a blocking version of qemu_chr_fe_write") the API
> contract was "Returns: the number of bytes consumed" which could be 0,
> so some frontends return 0 for "wrote no bytes".
> 
> Later in 2016 in commit fa394ed6257 ("char: make some qemu_chr_fe
> skip if no driver") the API documentation was changed:
> 
> - * Returns: the number of bytes consumed
> + * Returns: the number of bytes consumed (0 if no assicated CharDriver)
> 
> After this commit, some frontends started to handle '<=0' as error,
> while 0 is not an error.

I think I got the gist of it, thanks.

For this particular console call the spec says:

"This is a blocking SBI call and it will only return after writing the specified
byte to the debug console. It will also return, with SBI_ERR_FAILED, if there are
I/O errors."


So I think it pairs well with the blocking version qemu_chr_fe_write_all()
instead. I can do this change and get out of your way in changing the callers
of qemu_chr_fe_write().

But I still have questions, hehe. This blocking version has the following
doc:

"(...) Unlike @qemu_chr_fe_write, this function will block if the back end
cannot consume all of the data attempted to be written. This function is
thread-safe.

Returns: the number of bytes consumed (0 if no associated Chardev)
or -1 on error."

Do we have plans to change this API like we're doing with the non-blocking
version? Because being a blocking call that promises "block until all bytes
are written", and I have len  > 0, I don't expect a ret = 0 to be interpret
as "no bytes were written".  I am ok with ret = 0 being 'no associated chardev'
and not handling it as an error (for now at least) but I would like to confirm
that qemu_chr_fe_write_all() will not interpret ret = 0 as a zero byte write.
In other words, if for some reason other than "no chardev present" we ended up
with zero bytes written I would like a ret < 0 return.


Thanks,

Daniel



> 
>> Are you
>> saying that we should do a loop when there's no chardev found (ret = 0)
>> and wait a certain time until there's one available?
>>
>>
>> In fact, seeing how SBI_EXT_DBCN_CONSOLE_WRITE is written, I wonder if
>> we could use qemu_chr_fe_write_all() in this case too.
> 
> This is certainly simpler.
> 
> Regards,
> 
> Phil.



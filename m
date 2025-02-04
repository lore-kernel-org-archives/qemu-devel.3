Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQgS-0006a1-UC; Tue, 04 Feb 2025 16:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQgQ-0006Zl-Fv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:42:14 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQgN-0004et-O6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:42:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5391309f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738705330; x=1739310130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZtrmxI+dzrnlUCEhdyFN2n0Egq/YQEmfV68vcs9k33Q=;
 b=MT7+D2kjo1SPXiYBwrd1O8dMQS7vGjaPCtmXF38njSLcbOvg/vK7BttnWp4iN1Yrgj
 SXsOJMdukJ+ya/AwCT/fIgsGJQMxFB2ZkPHiAO3vZlbES0VZE1kuJQTFBh2sagQfk8di
 IwP6Ia+33Bjxrlh79Tyj4cdo9dNVUzXXtt+3dMKpi0qyKFXEss1q1v0sfHINeBlH9lw/
 26Juy4rqBkTzqJw5899F73vz4JEe3s4+FWbh7+5fgeIzohCkYBTRWwHmXGEThfssIWc8
 ul0D4RiGiCFtzch0x70WcCEvjk3sb0G4NNjikPjbZ0QrNDadqrNiHHvhPHKgn+3ckuWG
 DMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738705330; x=1739310130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtrmxI+dzrnlUCEhdyFN2n0Egq/YQEmfV68vcs9k33Q=;
 b=JP14uj3JX+rh+wYCqm+ac7Za/QGBh8ONK6jVu9st+pw3CT9KeCI07bWHYLKKpqsWyP
 nLnlRB1n7D3H9GpS8zTfTFBf3ySKstH0HZa8ayne79SFa5Va+mshsdprM6A27qbu247F
 2MqWYRylnUa2an43XlTLIOjCqzYS4YAK6tQLuHgAr5tmtTzmX2rkbSZJUAot+XRdIb7J
 As1VeOMHWLbd0KU0kmTSmgfAs//FxfA1yiOWYO6uGHsrUugSzU3JnX6dOCajQ1BwGSMk
 3ksHHoFPvnHeflIf5+P5Py6KKkrRBv1xEZkTuo0pwPyuYlt6nKrthVAEeVpS/5shiFnw
 NBZg==
X-Gm-Message-State: AOJu0Yx5udF05TXcuVGM9z9LxuXGOx6ENMNQxOdhAj/O8/bY2fD67GVG
 SUIZR0XFhIup02ewgPa20InG93TKtLrc84PTvf702cGAiZwQkzFu4v5sHA7lDig=
X-Gm-Gg: ASbGncsCtGixLfCOVNJuboKRkuYX/tu1qy76I+URl/Q1wAStfQzs7kO8GsHos4kHVVP
 doAWk+Yp3lqnMvjWAi+Yn3iuaCXsFsWF+Wayj619FUVx5cep7yhL/acj0xJzLXCS9UMoXYX7AN9
 zkagiEsSc2rswO0vypqKTkDH9yA5LH9FQOCPkSTC0+/ov32DMKgRMb29/4cXD0FB+5mELMoRprx
 IxP47Ktf5BcGCyG3LsBnNaJm/js/7xDfno4CoLA0DPlAYoDEDQxuk+arPFpgpPZwA5rNB67Opb+
 ukoqhs4eNUr2oc019fZ6OaOYolkLT6ZOX9JcvrQ74JyeVJNZjAvgQyNsV2w=
X-Google-Smtp-Source: AGHT+IEh3Wx0xk/i+JnDxhdnkFk5ZawlnhdIzKw5wZwQNxkYil8Pw59GDGYjKFF3G8yQI7thS+VF2A==
X-Received: by 2002:a5d:6c6d:0:b0:38c:5dcb:313a with SMTP id
 ffacd0b85a97d-38db48b45edmr215025f8f.5.1738705330177; 
 Tue, 04 Feb 2025 13:42:10 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38db463c4d7sm348653f8f.18.2025.02.04.13.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:42:09 -0800 (PST)
Message-ID: <d6888fe3-740d-4d8a-a27b-cd5968722b81@linaro.org>
Date: Tue, 4 Feb 2025 22:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Sam Price <thesamprice@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 alistair@alistair23.me, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
 <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
 <CAKmqyKNeks-12czF7sWP7gr_t=WU9g309_y5Xk58iFBiVcAijg@mail.gmail.com>
 <CAEekfLYFsdzgRiscqJ4NsvpMsOaLrj_6QbjH-0f42mdggXbyDQ@mail.gmail.com>
 <CAKmqyKPa2OnCvDPd8WqvyFWN3f9bsngSpF2io4ObJPoCTsx+dQ@mail.gmail.com>
 <CAEekfLZgVN2m9qUKygds88FgNtLqE-YgzL7R6jG9AYTSh0Nrog@mail.gmail.com>
 <CAKmqyKMwojdOo7cQdjd5A+EqGv1YGqRQUUY_WXOYO_9m76WH2g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKMwojdOo7cQdjd5A+EqGv1YGqRQUUY_WXOYO_9m76WH2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Cc'ing Alex/Pierrick

On 31/1/25 01:27, Alistair Francis wrote:
> On Fri, Jan 10, 2025 at 3:33 PM Sam Price <thesamprice@gmail.com> wrote:
>>
>> Yes that is true a boot loader will do more than just set registers.
>> Ill rework the text a bit on the next update.
>> In my case i need to set the r5 register that specifies the memory
>> location to the device tree.
> 
> Should that be done in the machine instead? It seems tricky to expect
> users to set this register
> 
>> I also use the device loader to load in a elf file to ram, and the
>> device-loader to load in the device tree to the location specified by
>> the r5 register
>>
>> I could add a gdb call that would return an array of string mappings
>> to integers.
>> If the machine doesn't implement the function/  leaves it as null
>> pointer then you wouldn't get the cli support.
>> Not sure where you would document all the machine register names /
>> numbers at though.
>> This might be too much though?
> 
> We probably don't need to document the register names
> 
> Alistair
> 
>> I left the door somewhat open on this via the NAME_NUMBER format.
>>
>> There was some checking logic where if data is supplied then it forces
>> a check for data-len.
>> I could relax that check if you supply the reg.name field.
>>
>> I am unsure how to determine the machine register size.
>> I assumed the max register size on any machine would be 8 bytes, this
>> might be wrong.
>> the gdb call seems to just pass in the full 8 bytes, but I didn't dig
>> into it for all machines.
>>
>> Ill look at this a bit more and try to configure the git email.
>> I also need to set up a docker container to build /test latest.
>> I have been building / testing on an old ubuntu machine.
>> (To test this I need to run it on qemu-xilinx).
>> My workplace has us on ubuntu 20.
>>
>> So it might be a while before I have another version up.
>>
>> Thanks,
>> Sam
>>
>> On Thu, Jan 9, 2025 at 7:34 PM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Wed, Jan 8, 2025 at 12:28 PM Sam Price <thesamprice@gmail.com> wrote:
>>>>
>>>> I made the changes, and added documentation.
>>>> https://gitlab.com/thesamprice/qemu/-/compare/master...loader?from_project_id=11167699
>>>>
>>>> I left it as [PREFIX]<RegNumber>
>>>>
>>>> I can switch this to just RegNumber if desired.
>>>>
>>>> I am still struggling with the email format sorry.
>>>> ---
>>>> docs/system/generic-loader.rst | 98 ++++++++++++++++++++++++++++++++
>>>> hw/core/generic-loader.c | 46 +++++++++++----
>>>> include/hw/core/generic-loader.h | 7 +++
>>>> 3 files changed, 139 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
>>>> index 4f9fb005f1..71d4aaa097 100644
>>>> --- a/docs/system/generic-loader.rst
>>>> +++ b/docs/system/generic-loader.rst
>>>> @@ -117,4 +117,102 @@ future the internal state 'set_pc' (which exists
>>>> in the generic loader
>>>> now) should be exposed to the user so that they can choose if the PC
>>>> is set or not.
>>>> +Loading Data into Registers
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +The `loader` device allows the initialization of CPU registers from the command
>>>> +line. This feature is particularly useful for setting up the processor state
>>>> +before starting an executable. By configuring registers prior to execution, the
>>>> +`loader` can mimic the state that a bootloader would leave the processor in
>>>> +before transferring control to an ELF file or another executable.
>>>
>>> This isn't really true though. A bootloader generally will set more
>>> than the GP registers. A boot loader will configure devices and
>>> perhaps initalise memory.
>>>
>>>> +
>>>> +The syntax for loading data into registers is as follows::
>>>> +
>>>> + -device loader,reg=<reg>,data=<data>,data-len=<data-len>
>>>> +
>>>> +**Parameters:**
>>>> +
>>>> +``<reg>``
>>>> + The target register to set. Format must pass the following regex
>>>> + ``[a-zA-Z]+[0-9]+``. The numeric part corresponds to the processor's GDB \
>>>> + register index. For general-purpose registers, this is typically the
>>>> + number in the register's name (e.g., ``r5`` translates to ``5``).
>>>> + Special-purpose registers have specific IDs defined in their processor's
>>>> + `gdbstub.c` file. Note that these IDs vary between processors.
>>>> +
>>>> +``<data>``
>>>> + The value to load into the specified register. The data must not exceed 8
>>>> + bytes in size.
>>>
>>> Why 8 bytes?
>>>
>>>> +
>>>> +``<data-len>``
>>>> + The length of the data in bytes. This parameter is mandatory when using
>>>> + the ``data`` argument.
>>>
>>> Do we need data-len? Why not just use the register size
>>>
>>>> +
>>>> +**Examples:**
>>>> +
>>>> +Set a general-purpose register
>>>> +""""""""""""""""""""""""""""""
>>>> +
>>>> +To set register ``r5`` to ``0xc0001000`` (4 bytes) on CPU 0::
>>>> +
>>>> + -device loader,reg=r5,data=0xc0001000,data-len=4
>>>> +
>>>> +Set a special register
>>>> +""""""""""""""""""""""
>>>> +
>>>> +To set the Program Counter (PC, register ``32``) to ``0x80000000`` on CPU 0::
>>>> +
>>>> + -device loader,reg=pc32,data=0x80000000,data-len=4
>>>> +
>>>> +You must look in your processor's `gdbstub.c` file to special register to index
>>>> +mappings.
>>>
>>> That isn't really helpful for users, but I don't have a better idea
>>>
>>>> +
>>>> +**Special Registers:**
>>>> +
>>>> +Special registers are defined in the processor's ``gdbstub.c`` file
>>>> with numeric IDs.
>>>> +Examples from the MicroBlaze processor at one point looked like. include::
>>>> +
>>>> + enum {
>>>> + GDB_PC = 32 + 0,
>>>> + GDB_MSR = 32 + 1,
>>>> + GDB_EAR = 32 + 2,
>>>> + GDB_ESR = 32 + 3,
>>>> + GDB_FSR = 32 + 4,
>>>> + GDB_BTR = 32 + 5,
>>>> + GDB_PVR0 = 32 + 6,
>>>> + GDB_PVR11 = 32 + 17,
>>>> + GDB_EDR = 32 + 18,
>>>> + GDB_SLR = 32 + 25,
>>>> + GDB_SHR = 32 + 26,
>>>> + };
>>>> +
>>>> +For example, to set the Machine State Register (``GDB_MSR``) on a MicroBlaze
>>>> +processor::
>>>> +
>>>> + -device loader,reg=MSR33,data=0x00000001,data-len=4
>>>> +
>>>> +**Register Loading Notes:**
>>>> +
>>>> +1. **Processor-Specific IDs**:
>>>> + The numeric IDs for registers vary between processors. Always refer to the
>>>> + `gdbstub.c` file for the target processor to identify the correct register
>>>> + mappings.
>>>> +
>>>> +2. **Pre-Execution State**:
>>>> + This capability is ideal for initializing a simulated environment to match
>>>> + the state expected by an ELF file. For example, you can configure stack
>>>> + pointers, machine state registers, and program counters to prepare the
>>>> + processor to run a bootstrapped application.
>>>> +
>>>> +3. **Validation**:
>>>> + Register numbers are validated by the `gdb_write_register` function. Ensure
>>>> + the specified register is supported by the target architecture.
>>>> +
>>>> +4. **Endianess**:
>>>> + The `data` value is written using the processor's native endian format.
>>>> +
>>>> +By using the `loader` device to initialize registers, you can simulate
>>>> +realistic execution environments, enabling detailed testing and debugging
>>>> +of embedded software, including bootloaders interactions and operating
>>>> +system kernels.
>>>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>>>> index ea8628b892..9408ecd150 100644
>>>> --- a/hw/core/generic-loader.c
>>>> +++ b/hw/core/generic-loader.c
>>>> @@ -55,6 +55,14 @@ static void generic_loader_reset(void *opaque)
>>>> }
>>>> }
>>>> + if(s->reg.name) {
>>>> + CPUClass *cc = CPU_GET_CLASS(s->cpu);
>>>> + int bytes_written = cc->gdb_write_register(s->cpu, (uint8_t*)
>>>> &s->reg.value, s->reg.num);
>>>> + if(bytes_written != s->reg.data_len) {
>>>> + printf("Error setting register %d to value %lX expected to write %d,
>>>> but wrote %d\n", s->reg.num, s->reg.value, s->reg.data_len,
>>>> bytes_written);
>>>
>>> The line wrapping is muddled up here. Can you please send it with git
>>> send-email. Do some sends against yourself to make sure it works.
>>>
>>> You mentioned gmail in an earlier thread I think, did you follow the
>>> instructions: https://git-scm.com/docs/git-send-email#_use_gmail_as_the_smtp_server
>>>
>>> Alistair
>>
>>
>>
>> --
>> Sincerely,
>>
>> Sam Price
> 



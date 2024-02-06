Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87734C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 11:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXJjW-0005Xc-1A; Tue, 06 Feb 2024 06:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rXJjS-0005X1-Nb
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:35:19 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rXJjQ-00012J-Ni
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:35:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so43977725ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707219315; x=1707824115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=viOxfD0JcNPJSOpjzRoxX1cSnRwbLRV5nd1z0L0MWGE=;
 b=cxbGo1EyBfmYWD5Vj7kvSuCzxviNXWcK4IQp1QNOQIN/LzzoZi0sb9uPAHzncDx8rv
 nn4vUrkpqtTdNpEQD9BGl7cQ8bncuXwjWsZC56RX8hx7zNhgDsO4MfPMmEKHn8o2nmL+
 KmaJ7M32nTvSf9FV+9LazMQ2OXKVZ3+4kAfT1Q+Jtrw3pSi3rWW/WVGPpQiBjhHxqYQR
 t0ipeBcY5WEfy8dLarqQaEULWTtWZ3XUEWDykiEPlVuf0xny8TOfvVvxtdA3taLlg7Kq
 kiax63WF36hEd8GHtA0MHrxI3Q8sBVurcVbrUOEc+EDlDUm2b4mKwHEmo1nUQBNVPgbk
 wAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707219315; x=1707824115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=viOxfD0JcNPJSOpjzRoxX1cSnRwbLRV5nd1z0L0MWGE=;
 b=s2GAfOaXDrjt2l/8IxyRSEZTlyCHy6pU5qrh48r7C3DfWFlVm7S39u38FAHRuLegLm
 1jrKoR6CKfsbwWhvtPrCEv+QrqWUgf2IzvSIQL3LLnle/tVXrvxw0e8a7iXexgOsqvLc
 Oc7sZhuJ8HmNfbGwbKVf5ZSoooHdhUW/gSGgf4sx83siudLfkiFVjpvqbdsGTmuh7+UW
 i4+Qhg/9ARxA+QDXAksy0xBFoJiMCta3cUZ1R7VS1cqMiLMITmJCCH7ZrtCGqZU5FQLk
 A5mRPbdZ1CuhPneUKSo+EgQGHJlq+ZgO5Hlq9b5DZNjmzNKU/offdBDY3Z/R6wSFYsiJ
 ExyA==
X-Gm-Message-State: AOJu0Yycx8nyWnVS5S7DZJGNY+9p2Yqdh1wVmvsOwKXYE5W2zUWOp4rq
 XRB9QQGhyI6aFJ9jIFWXh00InsfFL7dHx057fUJwKWLzaKMsY7TxWlZlhm0bHi8=
X-Google-Smtp-Source: AGHT+IEVYidMT2gA1ZsliW7LUxCyOWXEPh+dRSU5aLlrSpJdP4WrWewqnjmGmDIhpgBZv6GLdvF43A==
X-Received: by 2002:a17:902:c101:b0:1d9:464b:688d with SMTP id
 1-20020a170902c10100b001d9464b688dmr1109570pli.25.1707219315071; 
 Tue, 06 Feb 2024 03:35:15 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX+/Q+NvWODeGevEeqnhvR9l4GYZKs5pBtsIjpxkKMBbgaDmL/7BccgQdMi/Us6aTbWoapCsgQABp/X2XLuLQvUHCxQfM6Dr/nLDFw5fcgZAiaAAC9TS6xhJdQUz4VRvhmCbjFRdnwPrUYSOFuyqlpMzQUSIBzwtlAIo9eYycMlwtaCF9OJJoKYW8yXx/y8suiuIpcEs3gNvN+SlPjV9moOUa3hYhH6IEGxrpS39VnRhckPJzGjj/bDTypg2WwEMiRG
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d08b00b001d8dbb867b1sm1645643plv.179.2024.02.06.03.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 03:35:14 -0800 (PST)
Message-ID: <e170e285-9e53-4e73-9179-4c40854177e5@ventanamicro.com>
Date: Tue, 6 Feb 2024 08:35:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: riscv: Allow large kernels to boot by moving the
 initrd further way in RAM
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205070040.367541-1-alexghiti@rivosinc.com>
 <624964b1-d0e7-42b2-b4c2-690107882d01@ventanamicro.com>
 <CAHVXubicir4xetoFxmESNW=jjM7gUrkwwaeLyEiSGrB7m1nyTQ@mail.gmail.com>
 <CAHVXubixZe9RfCow7t6Xq4T+62sj7-AGKmwG2K8JZUD2TfFmkA@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHVXubixZe9RfCow7t6Xq4T+62sj7-AGKmwG2K8JZUD2TfFmkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/6/24 06:41, Alexandre Ghiti wrote:
> Hi Daniel,
> 
> On Mon, Feb 5, 2024 at 2:36 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>
>> Hi Daniel,
>>
>> On Mon, Feb 5, 2024 at 1:17 PM Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>>
>>>
>>> On 2/5/24 04:00, Alexandre Ghiti wrote:
>>>> Currently, the initrd is placed at 128MB, which overlaps with the kernel
>>>> when it is large (for example syzbot kernels are). From the kernel side,
>>>> there is no reason we could not push the initrd further away in memory
>>>> to accomodate large kernels, so move the initrd at 512MB when possible.
>>>
>>> typo: accommodate
>>>
>>>>
>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>> ---
>>>
>>> Patch looks good - just tested with an Ubuntu guest and nothing bad happened.
>>>
>>> But I wonder ... what if there's an even bigger kernel we have to deal with?
>>> Move initrd even further away to fit it in?
>>>
>>> Instead of making assumptions about where initrd starts, we could grab the kernel
>>> size loaded in the board and use it as a reference. This would be done by storing
>>> the return of load_elf_ram_sym/load_uimage_as/load_image_targphys_as from
>>> riscv_load_kernel() an passing as argument to riscv_load_initrd().
> 
> So this does not work because the size returned by
> load_image_targphys_as() does not take into account the size of the
> BSS sections (and I guess other NOBITS sections) and then we end up
> loading the initrd there. I'm a bit surprised though because arm64
> does just that https://elixir.bootlin.com/qemu/latest/source/hw/arm/boot.c#L1034.
> I also tried using the highaddr parameter, but that gives the same
> result. We could parse the Image header (a PE header) to get the
> "Virtual Size" of the .data section, but I did not find any PE header
> parser in qemu, so that would be overkill?
> 
> Any idea?


hmm that's unfortunate. The size retrieval in these cases might have to do with
missing information from the image header, and we can't control that because we're
not generating the images. It would be better if they return '0' in these cases
(then we could special case them in the math), but if it's a non-zero return then
there's not much we can do.

If we can't reliably get the kernel size in RAM then I believe your patch is going
to make it do (until we want to load an even bigger kernel hehe). Can you please
document these findings (i.e. we can't retrieve the kernel size reliably) in the
commit msg?


Thanks,

Daniel

> 
> Thanks,
> 
> Alex
> 
>>>
>>> initrd start would then be:
>>>
>>>       start = kernel_entry + MIN(mem_size / 2, kernel_size);
>>>
>>> However, I believe we would like to keep the existing 128Mb minimum initrd start,
>>> even if the kernel is smaller than 128Mb, to avoid breaking existing configs that
>>> might be making this assumption. initrd start would then become:
>>>
>>>
>>>       start = kernel_entry + MIN(mem_size / 2, MAX(kernel_size, 128 * MiB));
>>
>> Great, I agree with you, thanks for the pointers. I'll just align the
>> size on a 2MB boundary to make sure the kernel mapping (which in the
>> case of Linux uses PMD) does not overlap with the initrd.
>>
>> I'll get back soon with a v2.
>>
>> Thanks again,
>>
>> Alex
>>
>>>
>>>
>>>
>>> Thanks,
>>>
>>>
>>>
>>> Daniel
>>>
>>>
>>>>    hw/riscv/boot.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>>>> index 0ffca05189..9a367af2fa 100644
>>>> --- a/hw/riscv/boot.c
>>>> +++ b/hw/riscv/boot.c
>>>> @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
>>>>         * kernel is uncompressed it will not clobber the initrd. However
>>>>         * on boards without much RAM we must ensure that we still leave
>>>>         * enough room for a decent sized initrd, and on boards with large
>>>> -     * amounts of RAM we must avoid the initrd being so far up in RAM
>>>> -     * that it is outside lowmem and inaccessible to the kernel.
>>>> -     * So for boards with less  than 256MB of RAM we put the initrd
>>>> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
>>>> -     * the initrd at 128MB.
>>>> +     * amounts of RAM, we put the initrd at 512MB to allow large kernels
>>>> +     * to boot.
>>>> +     * So for boards with less than 1GB of RAM we put the initrd
>>>> +     * halfway into RAM, and for boards with 1GB of RAM or more we put
>>>> +     * the initrd at 512MB.
>>>>         */
>>>> -    start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
>>>> +    start = kernel_entry + MIN(mem_size / 2, 512 * MiB);
>>>>
>>>>        size = load_ramdisk(filename, start, mem_size - start);
>>>>        if (size == -1) {


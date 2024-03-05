Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6417C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLsA-00012f-Rm; Mon, 04 Mar 2024 22:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhLs9-000127-00
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:53:45 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhLs7-0001nj-43
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:53:44 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so1769225b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 19:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709610821; x=1710215621;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gdPZHn1gXlpg+Qa2vDPaWb+1cjtTzWMu1eA9/qbgk38=;
 b=djw6xDugT3gMH29KbKl1ruunwLFP/CJTYvM6BRTcBHuiYOpyCB/BCcj060ASwQcmJI
 GStqdc5DdIpHuKnOqnZ0z60YoiXEAFgknXSqUdTIb+vzQ/n5KAsfxlIgvLiR9VXCJmaj
 146p/zIIcWfeKqq4GY2OmrPti7pAAztJSS15SmUXmL7DP4NYGEonXVcCHiYJJrb6sgpD
 16KL01ikwQc3LQKCAPMe24Vh4+8RcEggDMycy9T4BA1Rxp/2osgO/VENRR50xUKOxtg5
 /pqa+HRp3qTg0x25yuHL/Jg0p1g5Hs5eSGKr7jLeTQ4LIJAhQkrnW6gMrAFRkUMWcCAd
 J3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709610821; x=1710215621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gdPZHn1gXlpg+Qa2vDPaWb+1cjtTzWMu1eA9/qbgk38=;
 b=s4n9oLKKzYStc1B8Vid2Sy2j7Ri/lGEwUvl5UzG406QMahDAtgSEZoBK7setzXGMCf
 wJOsCQqq5nBFIpoIUv6AHj4xIpxPsNqf+26f+OkMBMM0ePcqgtgsw2muG7pOl/4ZdbhL
 NfcLkDUBHulzUEQInaDrekOmU0CLzSsh5yAGsssWy9wPQs3v73RIs1t1DIUmANsDESvw
 2jqwLtpn+xXQ8uTeAH4DpGN8HEnuBCIwdFhyP5lTKPneLE/vJvWMWCR+fMQJCHc0J+rw
 6XhKqF6JstR8QvWOMSpRI97Cy5W83cKpeLeEtv99EWqHXyB7FJfxmPBlcQxhSUYz2IoY
 53wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEydAm6J45JvDGzF3Wf76VvbkzM7J92viwCjrg9A11xsDBjC7/WEzB4t6bPIrSOXVmh6MKFEB7r2RMACcXOp3tFEtTJhk=
X-Gm-Message-State: AOJu0YyLE8RoPrb0KPwEIWFc6g6h43diz39q3nnjRm3pP0d/edglhTiz
 jWu6fzWrbATmShE54nEQSfyMdEZEyYUxGgFQUqtGxuVjqCV6zHIyV/3Esn7NSq4mJNzYtobZjqv
 S
X-Google-Smtp-Source: AGHT+IFqP4qJxTwrrZ863abB5oBvXs+qB4UvEcz3VUKRbS708LQsnBOkO7TER+nbhS5S0mja09xvQA==
X-Received: by 2002:a05:6a21:9998:b0:1a1:3bba:6f48 with SMTP id
 ve24-20020a056a21999800b001a13bba6f48mr1019182pzb.18.1709610821289; 
 Mon, 04 Mar 2024 19:53:41 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 ei30-20020a056a0080de00b006e5359e621csm7980032pfb.182.2024.03.04.19.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 19:53:40 -0800 (PST)
Message-ID: <b48e9a1f-7db4-4f92-bfbf-591c53f252df@daynix.com>
Date: Tue, 5 Mar 2024 12:53:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] contrib/elf2dmp: Ensure segment fits in file
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-3-bea6649fe3e6@daynix.com>
 <CAFEAcA9Nr=rgzFP+L3UhL2AtEGBO0Mf=9iYKWJM=mRPFSwTBig@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9Nr=rgzFP+L3UhL2AtEGBO0Mf=9iYKWJM=mRPFSwTBig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/05 2:52, Peter Maydell wrote:
> On Sun, 3 Mar 2024 at 10:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> This makes elf2dmp more robust against corrupted inputs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   contrib/elf2dmp/addrspace.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
>> index 980a7aa5f8fb..d546a400dfda 100644
>> --- a/contrib/elf2dmp/addrspace.c
>> +++ b/contrib/elf2dmp/addrspace.c
>> @@ -88,11 +88,12 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
>>       ps->block = g_new(struct pa_block, ps->block_nr);
>>
>>       for (i = 0; i < phdr_nr; i++) {
>> -        if (phdr[i].p_type == PT_LOAD) {
>> +        if (phdr[i].p_type == PT_LOAD && phdr[i].p_offset < qemu_elf->size) {
>>               ps->block[block_i] = (struct pa_block) {
>>                   .addr = (uint8_t *)qemu_elf->map + phdr[i].p_offset,
>>                   .paddr = phdr[i].p_paddr,
>> -                .size = phdr[i].p_filesz,
>> +                .size = MIN(phdr[i].p_filesz,
>> +                            qemu_elf->size - phdr[i].p_offset),
> 
> Shouldn't "p_filesz is smaller than the actual amount of data in the
> file" be a failure condition? In include/hw/elf_ops.h we treat it
> that way:
> 
>              mem_size = ph->p_memsz; /* Size of the ROM */
>              file_size = ph->p_filesz; /* Size of the allocated data */
>              data_offset = ph->p_offset; /* Offset where the data is located */
> 
>              if (file_size > 0) {
>                  if (g_mapped_file_get_length(mapped_file) <
>                      file_size + data_offset) {
>                      goto fail;
>                  }
>                  [etc]
> 
> Like that code, we could then only check if p_offset + p_filesz is off
> the end of the file, rather than checking p_offset separately.
> 
>>               };
>>               pa_block_align(&ps->block[block_i]);
>>               block_i = ps->block[block_i].size ? (block_i + 1) : block_i;
> 
> thanks
> -- PMM

I'm making this permissive for corrupted dumps since they may still 
include valuable information.

It is different from include/hw/elf_ops.h, which is presumably used to 
load executables rather than dumps. Loading a corrupted executable does 
nothing good.

Regards,
Akihiko Odaki


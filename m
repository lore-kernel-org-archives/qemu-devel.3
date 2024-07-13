Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C49C3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 12:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sScIo-0002Dj-Mr; Sat, 13 Jul 2024 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sScIk-0002Cu-MB
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:56:35 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sScIi-0005Y3-4y
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:56:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb4fa1bb34so18036605ad.0
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720875390; x=1721480190;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhOFHdH2tff67j+PQ2H/Da3Ax2hSybZT1/cn+EHKRUI=;
 b=TCE20HVN+/IAJvVtnB9p94XjllIdbNHhlYDzoPtwUOKRkwBVZkb9LDU/lTTOA7n5Wl
 IRBEE++pSZQXphjB4e+EzuSXDGpRQDsJwzUu08Bxb9w0meIl4MHPELEQ5eKo9rrUP2PV
 BdaqudJt6074WjCIlwVXKyIlTQkCdrnAy/Fa2INmeCdV6dpCB7Nx+vw/2RzcAMabvxwz
 kZw1yCkI7HG4iNR2DlzME9Ikufa2e3bfip8GQSjza5TsL/seFfUy5giZLmY8Tp9gftNI
 V89Q7mZkT6ft45k3oe39GVew/A4jwiygtF/FQPZHbeKNcmCrsSbxZPuRXvxSyJwptUaP
 XCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720875390; x=1721480190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhOFHdH2tff67j+PQ2H/Da3Ax2hSybZT1/cn+EHKRUI=;
 b=jb/xdPyqc/IZr+Z/QbIMkaohxvJWZnMvvWl5cGocDgm7G/WQn4yqvncLT1SqWqYWyl
 DYN1Ryp4AslcBQ+lEY+MY2hOVWE0FGTsbQzKP46Oiuf8pYOlXQeryP20saGC9DyHJIs7
 X58qZsZSMcEZwYZmjEZ/uG538nW2D722LCvw+V3+/Byfbomp5dxfKvukE/VkcE92B/R3
 IJcxGrsTirkoKtT8ZovXtT9gn33i14LG9V8emL7X67zAZvNdKrHRDG0+PhEINeqK2zA+
 A5iILNYC6bJcnx4I0dyDtVSh0s8JnW1P+N1E6gyAxvno42Lkx8ISTHlMd9TWAqPxWlZE
 l0UQ==
X-Gm-Message-State: AOJu0YwdY1QwM3KWyufgj5FhmPSTRZW9oRdTdJ9EF8h0f2bDG3ZnbdIe
 niABBdoU9liz0C4DuRViwVrw37Vjq1h5s6okLUDB6g/CCSRZTFVR0qLFKtbCTIw=
X-Google-Smtp-Source: AGHT+IHunMQ7DGY0kmwK6bUzdt0qoFNr1sfkeVTBE2A9+oTuNpL/9QJwqQ9vCHbN0Ww/AZcZAh1TCA==
X-Received: by 2002:a17:903:11ce:b0:1f9:c1f0:7150 with SMTP id
 d9443c01a7336-1fbb6cd18acmr106950285ad.8.1720875390047; 
 Sat, 13 Jul 2024 05:56:30 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bbbf9c4sm9850955ad.98.2024.07.13.05.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 05:56:29 -0700 (PDT)
Message-ID: <6294e1ee-ccf6-46ad-98b1-2279c74ec2a9@daynix.com>
Date: Sat, 13 Jul 2024 21:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 junjiehua <halouworls@gmail.com>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <ZpAQ01k2JhOtSeRI@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZpAQ01k2JhOtSeRI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/12 2:05, Daniel P. Berrangé wrote:
> On Mon, Jul 08, 2024 at 07:25:20PM +0800, junjiehua wrote:
>> when building elf2dump with x86_64-w64-mingw32-gcc, fwrite is imported from
>> msvcrt.dll. However, the implementation of msvcrt.dll!fwrite is buggy:
>> it enters an infinite loop when the size of a single write exceeds 4GB.
>> This patch addresses the issue by splitting large physical memory
>> blocks into smaller chunks.
>>
>> Signed-off-by: junjiehua <junjiehua@tencent.com>
>> ---
>>   contrib/elf2dmp/main.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>> index d046a72ae6..1994553d95 100644
>> --- a/contrib/elf2dmp/main.c
>> +++ b/contrib/elf2dmp/main.c
>> @@ -23,6 +23,8 @@
>>   #define INITIAL_MXCSR   0x1f80
>>   #define MAX_NUMBER_OF_RUNS  42
>>   
>> +#define MAX_CHUNK_SIZE (128 * 1024 * 1024)
>> +
>>   typedef struct idt_desc {
>>       uint16_t offset1;   /* offset bits 0..15 */
>>       uint16_t selector;
>> @@ -434,13 +436,22 @@ static bool write_dump(struct pa_space *ps,
>>   
>>       for (i = 0; i < ps->block_nr; i++) {
>>           struct pa_block *b = &ps->block[i];
>> +        size_t offset = 0;
>> +        size_t chunk_size;
>>   
>>           printf("Writing block #%zu/%zu of %"PRIu64" bytes to file...\n", i,
>>                   ps->block_nr, b->size);
>> -        if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
>> -            eprintf("Failed to write block\n");
>> -            fclose(dmp_file);
>> -            return false;
>> +
>> +        while (offset < b->size) {
>> +            chunk_size = (b->size - offset > MAX_CHUNK_SIZE)
>> +                         ? MAX_CHUNK_SIZE
>> +                         : (b->size - offset);
>> +            if (fwrite(b->addr + offset, chunk_size, 1, dmp_file) != 1) {
>> +                eprintf("Failed to write block\n");
>> +                fclose(dmp_file);
>> +                return false;
>> +            }
>> +            offset += chunk_size;
>>           }
>>       }
> 
> When reading the original ELF file, we don't actually fread() it,
> instead we mmap it, using GMappedFile on Windows. Rather than
> working around fwrite() bugs, we could do the same for writing
> and create a mapped file and just memcpy the data across.

It is a bit more complicated to map a file for writing as we need to 
allocate the file size beforehand. We will also need to extract the 
logic in QEMU_Elf_map(), which also adds another complexity.

Regards,
Akihiko Odaki


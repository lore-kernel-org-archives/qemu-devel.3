Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BDBC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRocu-0007EL-6a; Thu, 11 Jul 2024 03:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sRocr-0007Do-BP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:54:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sRocn-0002eh-Ee
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:53:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fbcf71d543so3701355ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720684434; x=1721289234;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byThjqDgFIG3gK9df40m8+jafyXUC6QVNZt62X4vqyY=;
 b=ZhgxT/91jKO8bQs5lxk4cbTaYJoUeHYtrHovVYmkhs/gEE1h1JdtBp29PM+ZIDTCKU
 4kPTQuPvh2LKw8jNjnh1XZL5UUWrf64OYvbamRmz/4tp3wFsxrNDjy3mbNDqUYxAlQ3W
 4iP2BLlUfFXy6u7hNxhGcsdkNUAL64kx8DFBU8wZH6DW9IV5MmcELVY/ehlbgdKBQCzy
 DSJTwIJ2MdaRUlrp6xr6S3pzcUJA7XtJG8fyoxRO2955m06N/m8bhPZ4WxB00BQ/cxMs
 G/er+jjVRUJmOMOBm7jNE57LFYIYqEZaTHrLEcD4DtatavEyCp3Rq8jbffvZHzijv2az
 O08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720684434; x=1721289234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byThjqDgFIG3gK9df40m8+jafyXUC6QVNZt62X4vqyY=;
 b=Kuqp3gjfNL6XlreMiLABfbGrNW6splMnZrGUFnfy6j7lbUyZZysOzS9L6rSj6L8FFW
 IYscstNoLumFowWQkB9nU9haNPHQhUdw26VpgIC/5BXYRm2Nq2GshlIGX8wL6ybitOgQ
 Ir4dGIyRLgIEs5H9WyaG1QDuw5sSMUb8IDFi6ZnOw2cK6/84H0ph0DjU+5nbeI1nFPCu
 mispwxzziLlsiLlN18wu9zOOLgAwmPrrVjqmy12WsCiLVOAOsTOwR0RkinXEiYkpFNCM
 Ha0MDkty5kb4Qx5+GjTdinUOnfh9Y41H4NtIdbBUlWit/rHKGPRTUsX8pMCljhlrm626
 oosQ==
X-Gm-Message-State: AOJu0YwWdQnOD95YPUzyTJXt06fkFC4EKryLWzjB81agipoPmVVIdvQ2
 0xjsMffXhNs3aZV8pOwOyTysoydsZZJbGGkMaS3VArPXJcvwP2IO4toJdoWqVZk=
X-Google-Smtp-Source: AGHT+IHE26sVqWHI05BC0B1zDItSsF60oGjCVGexOoVp5vOzAe04XacMzsxRsY4LOgfynKWyqWOw5Q==
X-Received: by 2002:a17:90a:3006:b0:2c7:bade:25be with SMTP id
 98e67ed59e1d1-2ca35c295d1mr6489268a91.14.1720684433798; 
 Thu, 11 Jul 2024 00:53:53 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ca3c74eb5dsm2602516a91.0.2024.07.11.00.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 00:53:53 -0700 (PDT)
Message-ID: <399b661a-9bf4-4f97-be9b-f3d633b8b665@daynix.com>
Date: Thu, 11 Jul 2024 16:53:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: hellord <halouworls@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
 <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

On 2024/07/10 17:02, hellord wrote:
> 
>     On Tue, Jul 9, 2024 at 10:39 PM Peter Maydell
>     <peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>> wrote:
> 
> 
>     > +#define MAX_CHUNK_SIZE (128 * 1024 * 1024)
> 
>     I think we could add a comment here, something like:
> 
>     /*
>       * Maximum size to fwrite() to the output file at once;
>       * the MSVCRT runtime will not correctly handle fwrite()
>       * of more than 4GB at once.
>       */
> 
>     That will act as a reminder about why we do it.
> 
> 
> Thanks, I agree.
> 
>     (Does the library fwrite fail for > 4GB, or for >= 4GB ?
>     Your commit message says the former, so I've gone with that,
>     but if it's an "overflows 32 bit variable" kind of bug then
>     4GB exactly probably also doesn't work.)
> 
> 
> 
> It fails for > 4GB.
> The msvcrt.dll!fwrite(buff, (4G+0x1000), 1, file)  works as following:
> (based on assembly, not the original source, irrelevant parts have been 
> omitted)
> 
> size_t fwrite(const void* buff, size_t element_size, size_t 
> element_count, FILE* file_p)
> {
>      size_t size_t_total_size = element_size * element_count;
>      size_t size_t_remain_size = size_t_total_size;
> 
>      unsigned int u32_written_bytes;
>      unsigned int buf_size;
> 
>      /* The register used is r12d but not r12.
>       * So I suspect that Microsoft wrote it as an unsigned int type
>       * (or msvc compiler bug? seems unlikely)
>       */
>      unsigned int u32_chunk_size;
> 
>      while (true) {
> 
>          if ((file_p->flags & 0x10C) != 0) {
>              buf_size = file_p->buf_size;
>          }
>          else {
>              // Always reaches here on the first fwrite() after fopen().
>              buf_size = 4096;  // mov     r15d, 1000h
>          }
> 
>          if (size_t_remain_size > buf_size) {
> 
>              u32_chunk_size = size_t_remain_size;
> 
>              if (buf_size) {
> 
>                  // div ... ;  sub r12d,edx;   size_t stored into r12d , 
> lost high 32 bits
>                  // u32_chunk_size = 0x100000FFF - 0x100000FFF % 0x1000
>                  //                            = 0x100000FFF - 0xFFF
>                  //                            = 0x1 0000 0000
>                  //                            = (u32) 0x1 0000 0000
>                  //                            = 0
>                  u32_chunk_size = size_t_remain_size - 
> (size_t_remain_size % buf_size);
>              }
> 
>              //call _write() with zero size, returns 0
>              u32_written_bytes = __write(file_p, data_buff, u32_chunk_size);
> 
>              // They didn't check if __write() returns 0.
>              if (u32_written_bytes == -1 || u32_written_bytes < 
> u32_chunk_size) {
>                  return (size_t_total_size - size_t_remain_size) / 
> element_size;
>              }
> 
>              //size_t_remain_size -= 0
>              size_t_remain_size -= u32_written_bytes;
>              buff += u32_written_bytes;
> 
>              //size_t_remain_size will never decrease to zero, then 
> while(true) loop forever.
>              if (size_t_remain_size == 0) {
>                  return element_count;
>              }
>              // ...
>          }
>          else {
>              // ...
>          }
>      }
>      // ...
> }
> 
> note:
> 1. The path of buggy msvcrt.dll is c:\windows\system32\msvcrt.dll( 
> mingw64 links to it );
> 2. fwrite implementation in another msvc library which is called 
> ucrtbase.dll is correct(msvc links to it by default).

I don't object to this change but you should use ucrt whenever possible. 
I'm not confident that elf2dmp and other QEMU binaries would work well 
with mvcrt.

I even would like to force users to use ucrt and call setlocale(LC_ALL, 
".UTF8") to fix text encoding, but I haven't done that yet because 
Fedora, which cross-compiles QEMU for CI, still uses msvcrt.

Regards,
Akihiko Odaki


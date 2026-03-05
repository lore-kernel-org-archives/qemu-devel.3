Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A66F3D319
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBCF-0002qG-8t; Thu, 05 Mar 2026 11:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBC9-0002pw-S4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:01 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBC2-0002Lm-65
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:04:56 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso72732541cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772726692; x=1773331492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Y51B/ZeGHdME2N/CH5tG+xlUmteu24vX1jk/dHPA9U=;
 b=JkBNcgB34uqFP9SeCpQwQF1W9O5HVFOeZ/HLFvBHzYbVn9D7plUEr9XmtuamBJLfn7
 Z6OXtLtCAEuhoNupJ9jaAYC9V4XVLn6Itm77bf5DpA6Ok4NMZxYw8amSDQbX/MjIlOUL
 WKuQv2QagN22EVgWA21enV89msNO72XmSD3DZ7LsIAecfgGEpU6lVgGVYyHYkFOXQT1N
 KfccdllcBEfR/BqIpTDHos6mLFMCnjBtKara12du/5xaptyb0WxA7OaPXl8zM3GiD8pm
 C10euIkBuImlKzZ19xufD8SSxN62EVWzIRUe3OliqQV1nB9Vbf7DTkNkVEoqZyXc2pjy
 BLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726692; x=1773331492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Y51B/ZeGHdME2N/CH5tG+xlUmteu24vX1jk/dHPA9U=;
 b=dgz/BjLmPBIfM+qinqHYpJ9SEwasT/397XmLg2om4mVf/+dXAAuBU0QrBu7sjIz+cO
 jXHmNKxrlRPXIioSXFiViCjBB77t49ME7VMiL0unZwZNQwlLCPQmd+cxAjWrxB5JosHz
 wgYsODBUhUf30oOIOJ+k4M5A/ypcsQlfsQfewEdkPQXwIFzfJrhvUfQB8gN2a+V74+Xq
 EQAqbtgbWUWsW3jwo9maToofGhtEZpuQidxSSbOkLPaord0B6gfmTFLK+M/UpYm5mUYa
 YRJj5JZZQkG4waCqOP9nx+iTKOvOafH2KPo7si4hElRu66sb0p4kQEk5+tbhGW3OPndD
 WfHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Yi5vC/XTHQdJeKmWAdFS5a5lznkyGIUuAgneO9cy8fRAllIoS9oPWkM6xNSkXpy6J9PwamIKQriD@nongnu.org
X-Gm-Message-State: AOJu0YwJIGJuI0xnBYdplImtNjMLqvlJMvGxGAGZxoMP17WJj3KyvvwT
 iLzrlfNBuH27O6PEZZUm699jIJ0dGC5QSDXgEvP57aymmUXpmkKmZ6smFW2iAQLcSrM=
X-Gm-Gg: ATEYQzwOREYc/ZXzvOkCTCTPpFohwpTu0aaHdWFP1iyiYpHFOW7IDusEyneqDQehWOk
 KU/52Lsr6vy6knd1twFjuKVIj4YvrnDnJXgRpOkaBKZdcxq1MMf7fVc9LV5mCXcpJvDv8HAU+Yi
 gHSONT2xmaGq4XhE62wjx5Xmbsl2GvDmRoaPVKhyDwX9IGLo3DedaThC5/IB3ETRRBalgopvoxO
 Lv+tuiHuHzSkwXT9bc5y6A3SBsNeAN4N665AAnFWsvCSIOLngc7cWyQGSniGIrOVa2QKXwyntvF
 deef4F3QqubVkN5R/r0dD1d71t7ZABXbZosJIAuWzkSLXt+3W1Zqb72k/FO/YhSu5y712of8Q0P
 6mdTqOputjePB2vPStO0wdmL9J9aCsXtdb5Sj2VynjQPHRDiTZoDCUEiFisfUwqSE+a5+R/7peR
 qpme1+fANSR3MbrDGGrsskwJWixgoNMMD/kd/BhIsaJbf2gHQpa4bSMu7MIPI1MSAceXa/
X-Received: by 2002:a05:622a:15d5:b0:502:a268:9de0 with SMTP id
 d75a77b69052e-508db23cf67mr78751921cf.11.1772726691442; 
 Thu, 05 Mar 2026 08:04:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744aef9e0sm172791431cf.30.2026.03.05.08.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:04:50 -0800 (PST)
Message-ID: <1212e1d6-2144-407a-bd62-8a85f2d5f285@linaro.org>
Date: Thu, 5 Mar 2026 08:04:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/plugins/tcg/mem: Don't access unaligned memory
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260305120104.1254578-1-peter.maydell@linaro.org>
 <CAFEAcA_kSC9mV-mX0EEZ4+oQomMb5rvpV7ocmauAJVBT4O-Mxw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA_kSC9mV-mX0EEZ4+oQomMb5rvpV7ocmauAJVBT4O-Mxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/5/26 6:42 AM, Peter Maydell wrote:
> On Thu, 5 Mar 2026 at 12:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> In commit eb3f69cac62670 we removed the dependency of this
>> mem plugin on the QEMU headers, but in doing that we introduced
>> undefined behaviour when the plugin accesses unaligned memory.
>> This shows up if you build with the gcc or clang address
>> sanitizer and run 'make check-tcg', in numerous warnings like:
> 
> This should read "with the gcc or clang undefined behaviour
> sanitizer", which then lines up with what the error message
> below reports itself as:
> 
>>
>> ../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned address 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which requires 2 byte alignment
>> 0x7f1f300354b1: note: pointer points here
>>   00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 14 15 16 17  18 19 1a 1b 1c
>>                ^
>> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/plugins/mem.c:167:27
> 
> Specifically, I see this with
>    '../../configure' '--cc=clang' '--cxx=clang++' '--enable-ubsan'
> 
> Here's a specific failure;
> 
> timeout -s KILL --foreground 120
> /home/pm215/qemu/build/clang/qemu-system-aarch64 -monitor none
> -display none -chardev file,path=run-plugin-memory-with-libmem.s
> o.out,id=output -plugin ../plugins/libmem.so,region-summary=true -d
> plugin -D memory-with-libmem.so.pout -M virt -cpu max -display none
> -semihosting-config enabl
> e=on,target=native,chardev=output -kernel memory
> ../../tests/tcg/plugins/mem.c:167:27: runtime error: load of
> misaligned address 0x754e340357c1 for type 'uint16_t' (aka 'unsigned
> short'), which requires 2 byte
> alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:167:27
> ../../tests/tcg/plugins/mem.c:179:27: runtime error: load of
> misaligned address 0x754e340357c1 for type 'uint32_t' (aka 'unsigned
> int'), which requires 4 byte alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:179:27
> ../../tests/tcg/plugins/mem.c:191:27: runtime error: load of
> misaligned address 0x754e340357c1 for type 'uint64_t' (aka 'unsigned
> long'), which requires 8 byte alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:191:27
> ../../tests/tcg/plugins/mem.c:165:13: runtime error: store to
> misaligned address 0x754e340357c1 for type 'uint16_t' (aka 'unsigned
> short'), which requires 2 byte alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:165:13
> ../../tests/tcg/plugins/mem.c:177:13: runtime error: store to
> misaligned address 0x754e340357c1 for type 'uint32_t' (aka 'unsigned
> int'), which requires 4 byte alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:177:13
> ../../tests/tcg/plugins/mem.c:189:13: runtime error: store to
> misaligned address 0x754e340357c1 for type 'uint64_t' (aka 'unsigned
> long'), which requires 8 byte alignment
> 0x754e340357c1: note: pointer points here
>   00 00 00  00 00 00 00 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12
> 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../../tests/tcg/plugins/mem.c:189:13
> 
> Similar with i386 and x86-64 targets.
> 
> -- PMM

Thanks for fixing it Peter.
It would be nice to run this in CI by default one day.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


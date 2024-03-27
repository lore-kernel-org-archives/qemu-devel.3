Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A91C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSc7-0003m9-2n; Wed, 27 Mar 2024 08:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSc3-0003lt-TU
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:42:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpSc2-0002fP-85
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:42:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-341730bfc46so4791760f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711543356; x=1712148156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chSx5axAgn5Qg4owIBlL92174SxjzvS1I44U6r5a/V8=;
 b=NAVa8yXEnFwGnJR4Xwehix1v4qLtqTUkUS4WxAvo2EIRlwj8M15zpBK4d6j2ppIt9B
 K73jeRfYSZmHywWbpZwGifPxFkmSJh2MBjKwMbh72UaOKwe1lfAeeCvjEZ8BhwqBVN2m
 PRNUO+/x2EQPagoZ94EpCWGbTa02ryUD1on0kL1aeZXJxGMg3t048LhS9TSUqDRizeKe
 wEOqb82w7cmqqvxOW0EtiSDk4gdi8VsNgLSi+Dm70XXlZlcH/Lez3QR1O71zqEGkYjdu
 TH8ihMfP5p3oFo1QBwbHtNpNoHkf2dZqgvcUFoR9/I886AZ4LaL83hdlfuf7CnuEEbIp
 uhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711543356; x=1712148156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chSx5axAgn5Qg4owIBlL92174SxjzvS1I44U6r5a/V8=;
 b=HjWvf0lIPAZRhhWAvu1LxHBchzmgUcCdYORcCOyA4IZ4loKW31PAyWIMjSrqkn8i/e
 SJf0pV4RrwBEuIAMnm3MewFSMIY61bMQvfhvvFoqnLlvyi+8v+bKA68leFjUdk2tluB3
 knSUnHGpaLEojE9d8qEY18jrGZu2nD86GpdZTDl7Aen4wMNEDGrP78QE6PI7m+2jziYb
 4FK4yD5gchvT5/yNH0ITwWUFQHqRJI72QaXkvdSg/xjpRS8PHXmcr3uC9whfLpdp80Ox
 fxUuIBIlJtCRljUyTvv7GiPzZccodC0cHxUOoFi+OtYhpupY6vhkCesseVh7AUCwjGQk
 OdcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU8bu0QVLLaixrSHTpCwBMWfUaapADnsXKGsiX4Shn618pGkIMpq5RUcB99gdu+wOHG0825+CwLvR3C7rN+tOGRGZTkHI=
X-Gm-Message-State: AOJu0YzTUy7gagkDBWMkOULBZ/E0RgxauUM21g3NW1CuStiZ+0xKprZt
 V6qKbZnwvXNSjnneQ+09trYST7Jq+fWL95KZsawwHbNZp4Z5f9/rKQ1uAI1wZY4=
X-Google-Smtp-Source: AGHT+IEMcpyxoASchiBITLFI5EA+SvOC/6QcD1R387aFxVF0KZDdU5u343LB2wCxGubXGwTSIoPyrg==
X-Received: by 2002:adf:ef12:0:b0:33e:76f1:3e3d with SMTP id
 e18-20020adfef12000000b0033e76f13e3dmr4047578wro.51.1711543356381; 
 Wed, 27 Mar 2024 05:42:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a5d4891000000b00341e5f487casm456287wrq.46.2024.03.27.05.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 05:42:35 -0700 (PDT)
Message-ID: <5ceb0f8d-ef37-4b34-bcce-f4948d1b73ef@linaro.org>
Date: Wed, 27 Mar 2024 13:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 4/4] meson: Enable -Wstatic-in-inline
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240326171009.26696-1-philmd@linaro.org>
 <20240326171009.26696-5-philmd@linaro.org>
 <8cf13d4d-0b1a-487a-8a7c-1aea4cb107c5@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8cf13d4d-0b1a-487a-8a7c-1aea4cb107c5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/3/24 10:26, Paolo Bonzini wrote:
> On 3/26/24 18:10, Philippe Mathieu-Daudé wrote:
>> Compilers are clever enough to inline code when necessary.
>>
>> The only case we accept an inline function is static in
>> header (we use C, not C++).
>>
>> Add the -Wstatic-in-inline CPPFLAG to prevent public and
>> inline function to be added in the code base.
> 
> No problem with the first three patches, but -Wstatic-in-inline is not
> warning for non-static inline functions.  The warning is enabled by
> default by GCC (which has no way to disable it even) and by clang
> outside headers:
> 
> f.h:
> static int y;
> 
> inline int f()
> {
>      return y;
> }
> 
> f.c:
> #include "f.h"
> 
> int main()
> {
> }
> 
> $ clang f.c
> ./f.h:5:12: warning: static variable 'y' is used in an inline function 
> with external linkage [-Wstatic-in-inline]
> 
> $ gcc f.c
> f.h:5:12: warning: ‘y’ is static but used in inline function ‘f’ which 
> is not static
> 
> The actual effect of this patch is to enable the warning on clang *even
> outside headers* (clang only enables the warning in headers by default
> because, if a static variable belongs to the main source file, it has a
> single definition anyway unlike if it's defined in an included file).

IIUC your comment, you are worried about system headers declaring
non-static inline functions?

> 
> For now I'm queuing patches 1-3 only.
> 
> Paolo
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20240313184954.42513-5-philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meson.build b/meson.build
>> index c9c3217ba4..f400f7d36c 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -591,6 +591,7 @@ warn_flags = [
>>     '-Wold-style-definition',
>>     '-Wredundant-decls',
>>     '-Wshadow=local',
>> +  '-Wstatic-in-inline',
>>     '-Wstrict-prototypes',
>>     '-Wtype-limits',
>>     '-Wundef',
> 



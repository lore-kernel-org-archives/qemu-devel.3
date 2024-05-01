Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27D8C25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2A3L-0006Y8-Ti; Wed, 01 May 2024 09:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2A3K-0006Xc-LY
 for qemu-devel@nongnu.org; Wed, 01 May 2024 09:31:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2A3J-0004qE-1j
 for qemu-devel@nongnu.org; Wed, 01 May 2024 09:31:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1eb66b6953cso35563995ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714570275; x=1715175075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QqFQKN6gcDzvpiA+iYvFCKRYrtNFXhNlj/lbTNaUQIw=;
 b=kyNlpxwyXT2v2vhe2fjcSFf/ibukMpMmG0fsoP69FqaPmTZdmAvBlv/8n2zo/JNcY1
 I0VYb+T8U3YCsvrbPobYP7zmO9GUYuCl2IycdQ4eMc3f1Bfq3/j5SpWXTwHVMd7imoqF
 /a9xN1qFBaW41n7XSOxaL8N/W4VW4II1uwn3GmyYiPdac2l9W44d8YD6HHXGxsoMSIQc
 gnVVI+frxw+dsvFuGHpEzdSTyt2hGK2qnO8OdTOg9A+aNbJlA2yCpeTEFhECiIHOqQaj
 kd6qF1i20+Q3I5QfoJl9kxbMJVEsJsZxLQq9JO3Kp+9rvpgnhht+M7ou3DFlLV9TIhYA
 LYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714570275; x=1715175075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QqFQKN6gcDzvpiA+iYvFCKRYrtNFXhNlj/lbTNaUQIw=;
 b=U2pVBgitoQXCHxoHxNyEE4WQEkpp1siIqaorYSAP28u1xippcS4VqfEkiv39KCZM1r
 apFC4tQ9uUb26SG3N0weybtVe6uBdyCWSh2q4PHQsTN7F2fA799InbuuyOiFsTVxdwZt
 J/7ddooN4gFC1U9V3sdN2+NYfyZKj7aDsDuRVaOxEj1+iL1R4s1hPj+n57toC92RatH7
 ysnMBt+MYt0+JUTnsrxnWAEcghHtMNFZ9tbIGVXbFkm0QNjjoJjTQH6o4HFFh7CQ+Qmc
 hCQGCxY3UE/ngxeE1mxpt+bpLpNSAZtLlMEm3dMjVs6SV09bArsUJDS3BmF5sN3UY616
 R77w==
X-Gm-Message-State: AOJu0YwB121pceydM7fG2DhNmi79vt0q1ZOvPE6se13PgkjFGb24vFLX
 dr4bTk5EQ/hDyiziN1YdFGqWF4AduC3OnAlSZR/7jo+6eEZfLpqqbl4GpH4IlRcDI5F8xF8u2o5
 n
X-Google-Smtp-Source: AGHT+IEdBRnflDvVvozNd2gsNvcFNk2gMbga8RFZW8pl1ZIuevizI3r4b9HuT1jk4CPnatQxvnZ/Og==
X-Received: by 2002:a17:902:f547:b0:1e4:3386:349f with SMTP id
 h7-20020a170902f54700b001e43386349fmr2812535plf.51.1714570275073; 
 Wed, 01 May 2024 06:31:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a170903111000b001e2a479954dsm24148852plh.181.2024.05.01.06.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 06:31:14 -0700 (PDT)
Message-ID: <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
Date: Wed, 1 May 2024 06:31:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 5/1/24 05:18, Dario Binacchi wrote:
> Hello Richard,
> 
> On Tue, Apr 30, 2024 at 8:15 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/30/24 09:47, Dario Binacchi wrote:
>>> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is not
>>> always provided by the libc (uClibc). The patch disables its compilation
>>> in case the header is not available.
>>
>> Since uclibc has had fenv.h since 2008, are you sure this isn't simply a case of a corrupt
>> installation?
> 
>>
>>
>> r~
> 
> It's not an issue of corrupted installation but rather of compilation:

Installation of your cross-compiler or buildroot, I mean.

> 
> ../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or directory
>     15 | #include <fenv.h>
>        |          ^~~~~~~~
> compilation terminated.

Yes, yes.  However, <fenv.h> is present in uclibc-ng, and has been since 2008.
So *why* is fenv.h not present?


r~


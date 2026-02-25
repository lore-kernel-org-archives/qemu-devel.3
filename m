Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB90FFD3774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIJN-0001s6-Mo; Wed, 25 Feb 2026 12:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIJM-0001r4-Jo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:04:32 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvIJK-0005Wv-4M
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:04:31 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so2458815a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772039068; x=1772643868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IDQncYvTe1hfWYzs24nQr9jeT6wwIfSVjc7tiIOU2f0=;
 b=RLRieQNpWzPoHGxMGCj3vanyoJuPR9iVpDAj7HbdyihP8+9iWhvpwv5G1LP0IZ4iZU
 7aIWFEaiMlphK6K82mpuIDYDZbg20dH90liPlfV0De9WO4EqwASj9ciVnmVprqhimVif
 uI0l4oaEpA88gnu3Vx6VwaHxIZye3V1+sPUIFIu3qEwVElYqcIKmnec3LCQOBixGz0+o
 7lAmsFjvj5uT9U3a8z3fAFikc29igUGm/UaxXr05cjdHu/C8u6UtwEhTSyd6qrjoIiNb
 jrEEF263BwR09fXfU9SGW3Nxy9dnOARSsGwuBJRYiZqWbNT/GNX2Zlxvf6Hlh1taaImy
 89cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772039068; x=1772643868;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDQncYvTe1hfWYzs24nQr9jeT6wwIfSVjc7tiIOU2f0=;
 b=r8mWWKhm/r0S0RXPWrFVQNFbvjfjdpHIdVapiZUxXY0zfPyA6joZQgfqcBzSgrvT63
 4+u4eIOG9tDXLUJSh4gHi3Wbav8dU9+kZMgKV5hsT17BQ+WatNpcIdiXSbvkS7Igasw5
 4/RPZ1w2JwkBTZQnyCNllk3pS4mbXx5iljMPYJEozj0aYaJn/bvG/3dcsrS9cPJNBkg/
 7ddeRikm+v8YCYLByXDtM+Ht2eeLoEo0B+De81Wivs4/fhhbIEPFBHcZ8aT1reD54VSs
 H0KghGHEbonj22SjmMw4abBcIXxbzzMNWKtICW31TcqzioGtqFmOD2ADeACvi0F1TMVc
 9UHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj9k1KUZ7zA7lsLTd5oSRJ6v7ASj+qj0clCafTXEgtLr4yg2E/Jo4kGgvvkCJ1Y4seeQ8AMk6kwTOR@nongnu.org
X-Gm-Message-State: AOJu0Ywn+Qe8cDrc7UaYqNhxH0lqttsAaCEiMaTqCPTtVIgZDGuMgu9o
 vwthVYt0yH1LrWU4uySiK6/Iw9DsVW3gWcq5xRy9+BYjXZiNfAFKkHa5ESGUbBf43Y0=
X-Gm-Gg: ATEYQzwQ3L/y4t2xkK1GoUqmy2CuJt8IpejfvOne8naoA4XR3yPWrK0Ik1pz8Ra66Ui
 STLFhOwN0xOfs0iezsUkHtMP0IxfGwjAu7qx5y0YfVyhDUk6aQnVlEbDkZTEukNxCB+djL8XmnZ
 RnafnAgfk6P/fmF1uT51+KrHADQLa61y36pjTI6UKNUTDTVKdTvBn+FDz5itrTYBAmylm9VWrpU
 GhNJRntZgYlzQbXTW6xC4KuzjywA5LqUv7fi8XjWDQQkMd74Q6DMQIOIEOSAVmgAtCBvn8S1FWo
 mnsBBN/FuKKlaLjw1G2XmxZFeAbDZCB9isiKOi8CYKsx+BWNbV8vAbLyw0Bt+y3nFSg3E6TDVWn
 gBK4jV634aCw5rSvKNoX7x4yD70ZMcOlqPR5zBHdWxrcB3LvXaAWPO6vsUxK0E3O3Azs6NxelDB
 hhqVv8MH+wW0+3AphGgu5KjHLrWODfWs4c3xhihmUXBwwHgXiE469qRch/XZm0JunW4soC
X-Received: by 2002:a05:6a21:1309:b0:394:f972:43ca with SMTP id
 adf61e73a8af0-395ad20cff5mr926149637.54.1772039067786; 
 Wed, 25 Feb 2026 09:04:27 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e189sm144377395ad.57.2026.02.25.09.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:04:27 -0800 (PST)
Message-ID: <6484080a-4570-478c-ab48-dce2ca054f1a@linaro.org>
Date: Wed, 25 Feb 2026 09:04:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <7615cede-426b-4547-8878-c57ec08e8ba1@linaro.org>
 <a3233b9f-0200-4e76-83a0-9c9852a85348@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <a3233b9f-0200-4e76-83a0-9c9852a85348@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 2/25/26 6:58 AM, Florian Hofhammer wrote:
> On 24/02/2026 21:24, Pierrick Bouvier wrote:
>> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>>> The test executes a non-existent syscall, which the syscall plugin
>>> intercepts and redirects to a clean exit.
>>> Due to architecture-specific quirks, the architecture-specific Makefiles
>>> require setting specific compiler and linker flags in some cases.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>    tests/tcg/arm/Makefile.target                 |  6 +++++
>>>    tests/tcg/hexagon/Makefile.target             |  7 +++++
>>>    tests/tcg/mips/Makefile.target                |  6 ++++-
>>>    tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>>    tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>>    tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>>    tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>>    .../{ => plugin}/check-plugin-output.sh       |  0
>>>    .../{ => plugin}/test-plugin-mem-access.c     |  0
>>>    .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>>>    tests/tcg/plugins/syscall.c                   |  6 +++++
>>>    tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>>    12 files changed, 131 insertions(+), 3 deletions(-)
>>>    create mode 100644 tests/tcg/mips64/Makefile.target
>>>    create mode 100644 tests/tcg/mips64el/Makefile.target
>>>    create mode 100644 tests/tcg/mipsel/Makefile.target
>>>    rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
>>>    rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
>>>    create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
>>>    create mode 100644 tests/tcg/sparc64/Makefile.target
>>>
>>> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
>>> index 5d17c1706e..d08138f17b 100644
>>> --- a/tests/tcg/mips/Makefile.target
>>> +++ b/tests/tcg/mips/Makefile.target
>>> @@ -9,11 +9,15 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
>>>    VPATH         += $(MIPS_SRC)
>>>      # hello-mips is 32 bit only
>>> -ifeq ($(findstring 64,$(TARGET_NAME)),)
>>>    MIPS_TESTS=hello-mips
>>>      TESTS += $(MIPS_TESTS)
>>>      hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
>>>    hello-mips: LDFLAGS+=-nostdlib
>>> +
>>> +ifeq ($(CONFIG_PLUGIN),y)
>>> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
>>> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
>>> +    $(call skip-test, $<, "qemu-mips does not execute invalid syscalls")
>>
>> I ran into this while pulling syscall filter API recently, and found 4096 as syscall number, which seems to make all architectures happy.
>>
>> See 948ffdd79b78702239aace2d32d4f581913299b3 for more details.
> 
> Please correct me if I'm wrong, but is this really sane? The comment in
> the referenced commit says that 4096 isn't used in any ISA, but on the
> MIPS O32 ABI, syscall numbers start at 4000. 4096 therefore corresponds
> to getpriority, which would be shadowed by using this syscall number.

I would definitely not recommend using this value in a general purpose 
plugin to implement "hypercalls", it would not be sane.

That said, for the current limited test context where we now this 
syscall is not called, I would say it's ok. And if it should get broken 
in the future, we would catch it and could find another magic number.
Of course, if you have a better idea of syscall number, I would be very 
happy to follow another rationale, as mine was mostly try and error. :)

Regards,
Pierrick


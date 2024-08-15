Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebpo-0005Os-8V; Thu, 15 Aug 2024 10:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sebpm-0005Ib-O4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:52:14 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sebpi-0000eS-IT
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:52:14 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so15952311fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733527; x=1724338327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Form3l+Y9Es8kJTAeBAesEFa2D4OSAQ1T21kXvuuHII=;
 b=gBI/gUuBlqBTk4457rLBx3gVA8loU+sQsQg5+P40k3P+Whm7USS63AGavVUxl5ufd5
 wHBJbP7jhpAXsgJjtkEPhGMT6hCcipQCkYdBr7g3bS6mzoBBQ3nBwq6yINhhdu52kjCs
 kCQTmEAZ7n/YXyQf+h0v6/Dq8brse1yMPc9lVBBqskzYgbhlRD0JcGQLb2ueI10yX6K9
 WVq+xYbbB2vLzaL27JVbhzz1ugV0QCggH76q/FAJypcUoBC9XdaFclM8oymyMDz4LM1O
 +UWPZWk+aJSEg7l0Zg77Nm6b494VXNZhKl7X6e02PMtbPRjFjzAynsRMQBYGhsRtXNmR
 mxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733527; x=1724338327;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Form3l+Y9Es8kJTAeBAesEFa2D4OSAQ1T21kXvuuHII=;
 b=bMnwXblOplMDSGo053XIlxbrSBiUw0P5xefb8q33DdwYwowsBZPAJE4VnU+8S3ijTR
 Y7XnWcPEJbm7gBziH75CjAvKshIN7Ur/bSNUGa4sh0u5UE0VC1FiBgA4H3+Of1vKFYzq
 ckWqSCxmFdXPkryN1hEO9YVCwRZfaiNG4kLc3Bk70ZLAiT1Lv5nHuK7LXD4aiMN6JjPI
 mI/UL7wgkyUFM2bh50dzuZK2BhyoJjHTcNKvdFgltqjdCViXSXZdzS2WI8eeb0hLOOoG
 D+mBV5Yn41+KMrrnOuE/hN1L4HL86HNoBikVxKvEKjMzyHj7quo+Yj+TS9A1y/gyYZcM
 Sdig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV80SV2zyH6BzES2clSL6H6Ozzmwa/jXqm88tY/z5tc4XDs9q7nbvPqc8vh3Rp47hqB945gnLR8OkyHn5+ZKmRwFpRHA8o=
X-Gm-Message-State: AOJu0Yy4Wy7ag+flhkgU7qq8TzBuzJ2R+tR05HYmdljkuEnikTWr9F7Z
 rIkLz2jFxv2VUxdZG4dZGB0jjbPJjXIMPnwDs79S1PdDNGhdR6ugCNyoQjoBhpU=
X-Google-Smtp-Source: AGHT+IEPXQ+DX/0lApDeGM66C4oRZWsZ5dhhyURys8hul+nlJXTwp8dBKZ7MVald++CxDLA3pR5SzQ==
X-Received: by 2002:a2e:bd86:0:b0:2ef:2c3c:512a with SMTP id
 38308e7fff4ca-2f3aa300b4cmr65909951fa.42.1723733527225; 
 Thu, 15 Aug 2024 07:52:07 -0700 (PDT)
Received: from meli-email.org (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c73e6sm114588666b.11.2024.08.15.07.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:52:06 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:50:35 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
User-Agent: meli 0.8.7
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
 <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
In-Reply-To: <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
Message-ID: <i9lat.di1u9m6k136b@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22b.google.com
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

On Thu, 15 Aug 2024 17:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Hi Manos,
>
>On 15/8/24 13:42, Manos Pitsidianakis wrote:
>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>> provides some declaration macros for symbols visible to the rest of
>> QEMU.
>> 
>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   MAINTAINERS                       |   6 ++
>>   rust/meson.build                  |   9 +++
>>   rust/qemu-api/.gitignore          |   2 +
>>   rust/qemu-api/Cargo.lock          |   7 +++
>>   rust/qemu-api/Cargo.toml          |  23 +++++++
>>   rust/qemu-api/README.md           |  17 +++++
>>   rust/qemu-api/build.rs            |  13 ++++
>>   rust/qemu-api/meson.build         |  17 +++++
>>   rust/qemu-api/rustfmt.toml        |   1 +
>>   rust/qemu-api/src/bindings.rs     |   7 +++
>>   rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>>   rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
>>   rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
>>   rust/rustfmt.toml                 |   7 +++
>>   15 files changed, 493 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5464cb2b03..56a88048d2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3348,6 +3348,12 @@ F: hw/core/register.c
>>   F: include/hw/register.h
>>   F: include/hw/registerfields.h
>>   
>> +Rust
>> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> +S: Maintained
>> +F: rust/qemu-api
>> +F: rust/rustfmt.toml
>
>Few lines in docs/devel/rust.rst would be welcomed,

In another patch. There's so much to do!

>
>> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
>> new file mode 100644
>> index 0000000000..51260cbe42
>> --- /dev/null
>> +++ b/rust/qemu-api/Cargo.toml
>> @@ -0,0 +1,23 @@
>> +[package]
>> +name = "qemu_api"
>> +version = "0.1.0"
>> +edition = "2021"
>
>> +license = "GPL-2.0 OR GPL-3.0-or-later"
>
>in particular explaining the license choice.
>
>Should all rust code use it?

It's an OR, so all rust code can use GPL-2.0 like the rest of QEMU.


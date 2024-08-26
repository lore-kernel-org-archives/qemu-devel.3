Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F7C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siSvh-00014R-Tu; Mon, 26 Aug 2024 02:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siSve-00013i-T3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:10:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siSvc-0005HN-Rr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:10:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5bede548f7cso4647837a12.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724652610; x=1725257410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=U/J0J/5mMIT8nKZa8fCoD8G6cJEsJPbE/3yXjuH4oUQ=;
 b=x9cBXWjMrlQKYUuai3nEl2okA4uk4hRl8Q8UN4yJRedBwnZyiQVE63rGRlxmUwH7Ov
 apZM44IkVbHLfCQg5sTPh2yO14BFmi7Ooqmc2GvMkSIgD0kn63SmodUxx2eaC3qr7GK1
 mSMyCBOBETA4PwYLrEp7UZfPZx5ejujCH6qO+lECfsrU+3tgvgrPakrbDdxkPBmB7ECl
 e6OwAsmrU+SO3NEgTxEaywf548npjj7yTlbcNyAF8ndzMKK6vDV2EaVd71TPxGCHrUcD
 CIzU8Fg2JDj/fJYHvBDc0XTsvhsNLw0hr5V/2gghRWwnGJk3mioDcijrZsKN0O+15rko
 00Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724652610; x=1725257410;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U/J0J/5mMIT8nKZa8fCoD8G6cJEsJPbE/3yXjuH4oUQ=;
 b=eXr92Y0ShHjYcN1Ktz+0Xedgs6x9jDi3UBPNd5MnxLjeZX7fPKqqf6Cw/VBZ6og5k7
 ipVASZBfbyNyOOpwfp/fm0SOTGNp5XJhosBq8mOvMoIYSZnuC0YsLEl+kboDvsDojtGY
 dT8u0ItK8seVTCR21sQ4um1rl9aKqkwG9O4xmEgZvwYXvCjODjSw7Cf8XOseZvHXf86I
 oFXYoN7sj+Sh9fe5KmqP17TJAHQ+fXJ6sOHa7TKXOUhIuyqJTEIMiVtz3WO+FZRhNcyE
 MSv1QjujluwqwNHJn5piTGy7qOEBwqMl6mzZSrv3ViBL5+hCLuz7Id864Kha1NlrnAY0
 ATfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNRd4ZJ5PnkeC0wwjVDl4cmxnbiofD2Q3jj7Qtz0iO33A9SylcV99GePhtaP5z7ab4nkXgPg+knEY4@nongnu.org
X-Gm-Message-State: AOJu0YxH/06HajCn2AFuVN+RIwpe2ByR7I/W3H8Ye/iXHzYX6TD5Npq9
 KRu1bbY5mlw0iCX54FDgwuO2eCTjwlv8jgODzwmW4CQFyy7bamlTApTNHSUdCL4=
X-Google-Smtp-Source: AGHT+IE8hDVVNFRhQhvoTYQ5C8RRKvjKTe8DPv8LPR/JdgVlmNVRgPnivswh1au0YLLchYuphEmK7A==
X-Received: by 2002:a05:6402:5189:b0:5be:fe42:a31 with SMTP id
 4fb4d7f45d1cf-5c08916a030mr6069502a12.15.1724652609762; 
 Sun, 25 Aug 2024 23:10:09 -0700 (PDT)
Received: from meli-email.org (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a3ca4d2sm5209483a12.36.2024.08.25.23.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 23:10:09 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:02:37 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Junjie Mao <junjie.mao@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 7/8] rust: add utility procedural macro crate
User-Agent: meli 0.8.7
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-7-b9f5746bdaf3@linaro.org>
 <b715130d-2673-4f3d-8189-4f2bda528fbf@intel.com>
In-Reply-To: <b715130d-2673-4f3d-8189-4f2bda528fbf@intel.com>
Message-ID: <itagv.nihkv71gz0hp@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS_A=0.1 autolearn=ham autolearn_force=no
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

Hello Junjie,

On Mon, 26 Aug 2024 08:15, Junjie Mao <junjie.mao@intel.com> wrote:
>On 8/23/2024 4:11 PM, Manos Pitsidianakis wrote:
>> This commit adds a helper crate library, qemu-api-macros for derive (and
>> other procedural) macros to be used along qemu-api.
>> 
>> It needs to be a separate library because in Rust, procedural macros, or
>> macros that can generate arbitrary code, need to be special separate
>> compilation units.
>> 
>> Only one macro is introduced in this patch, #[derive(Object)]. It
>> generates a constructor to register a QOM TypeInfo on init and it must
>> be used on types that implement qemu_api::definitions::ObjectImpl trait.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   MAINTAINERS                            |   1 +
>>   rust/meson.build                       |   1 +
>>   rust/qemu-api-macros/Cargo.lock        |  47 +++++++
>>   rust/qemu-api-macros/Cargo.toml        |  25 ++++
>>   rust/qemu-api-macros/README.md         |   1 +
>>   rust/qemu-api-macros/meson.build       |  25 ++++
>>   rust/qemu-api-macros/src/cstr/mod.rs   |  55 ++++++++
>>   rust/qemu-api-macros/src/cstr/parse.rs | 225 +++++++++++++++++++++++++++++++++
>
>Since Rust 1.77.0 C-string literals are stabilized [1]. I don't think we need to 
>include this cstr crate as we require Rust >= 1.80.0.


Many thanks! I got the qemu-api-macros from my git stash, I tried to 
bundle cstr in a previous version before we had proper meson 
dependencies and I hadn't raised the Rust version. So I just forgot to 
remove these files (they are not even declared in lib.rs). Oops 🤦.

>
>[1] https://crates.io/crates/cstr
>
>>   rust/qemu-api-macros/src/lib.rs        |  43 +++++++
>>   rust/qemu-api/meson.build              |   3 +
>>   10 files changed, 426 insertions(+)
>> 
>[snip]
>> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
>> index 85838d31b4..a0802ad858 100644
>> --- a/rust/qemu-api/meson.build
>> +++ b/rust/qemu-api/meson.build
>> @@ -13,6 +13,9 @@ _qemu_api_rs = static_library(
>>     rust_args: [
>>       '--cfg', 'MESON',
>>     ],
>> +  dependencies: [
>> +    qemu_api_macros,
>> +  ],
>>   )
>>   
>>   qemu_api = declare_dependency(
>> 
>
>qemu-api does not use macros provided by qemu-api-macros, but the later 
>generates code that uses types defined by the former. So to me qemu-api-macros 
>should depend on qemu-api, not vice versa.

It does generate code but it does not use those types, serde_derive for 
example does not depend on serde but serde depends on serde_derive 
(because it re-exports the macros in its API):

https://crates.io/crates/serde_derive/1.0.209/dependencies
https://crates.io/crates/serde/1.0.209/dependencies

Manos


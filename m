Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA22C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seb2w-0003A8-2B; Thu, 15 Aug 2024 10:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seb2l-00036W-Eu
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:01:38 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seb2h-0000JW-3k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:01:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso125503166b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723730487; x=1724335287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DxCdAIn5y4gTzTjhyb9YR7k4aqTjKY2yApmrude/dg=;
 b=oRseeJsxx5hAnIX7a7RajU+29hcS4rrbEbh1BBDzxxRQlQ1QdhBxSbSaNUslVVhqoG
 Nyln4HFHPN27//GLnsKKGUkz/ydHI41jco9aoyo86dq3pFwYrFw5mTnJkIHZbqxnvSiZ
 gp98yCDYNG9umv8AO2O/CmZfuGG1cUmUI4tk4zIbc8MVMcM1K+kLu9bxGoO02Lfl9sGU
 1N3U19AJsEZOWfYqSVZ92MWGWSQ1sY+QZ9w0ThH1JjSTU/wbQmTjHgAQMiLWA7sxT/j0
 2FGZPQ7TkJTa4matNlx/jKPPKvZBAJzfkMT81LSMw3UwcbsSd5RUZNztP+94HwMBwZnn
 3Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723730487; x=1724335287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8DxCdAIn5y4gTzTjhyb9YR7k4aqTjKY2yApmrude/dg=;
 b=d1QYag2NmvQvabUSss9SIBz8pU5BKLHsVcstjjUiWHklPtsbC+d4WJjJ8UQ29urZxr
 uLjq4BiIB+8cNrF8YveTiVGO8acgzwHq6NghAp+lhbeoBi0IuOWL+BmoWdmPK1m7NO4S
 Ii4qR7sSTwc22JfTKuRciTybfpV8MU0186FdkFa1wBkU3ArpZH0ICwoOXPtNHIcGqFeM
 ca0+lSTFR0mlgmPcZ3qPfUiQ3H/vVaZ4hQBKrcsIhgWQYZpHUyW80HMro9wUAsk0K7XW
 UppQDqB2yOgT8LdlVvWU2GyJuqkrh9Wq3++jh/bfYAWYVN3va2cUEYK+vFbLqHRZiCZB
 NrZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq3TPmrGwLFPVLRnULnhUmHAAeyi/wXHXBNiw43xtCLfTuKrIXQF+MVzBOyf9CM0sh9Soisox/rvefZVeW1jDcjIl/+Po=
X-Gm-Message-State: AOJu0YzZ6p/q1yEyzrrlKxaW5M3W+QM6hDrZzIGeOVT3aqOvD8bg/wor
 wL2DFX+LyHulVEoq1A9uGW5QIKx0gh7hSUy8s+bn57LdJPKbwoo/A/KiPpBBxNg=
X-Google-Smtp-Source: AGHT+IG+VRgNNZ0HwlyxiqMHy9WFgWzm7ORf95ag1U2KeV1i6XvltyF075I/Y4XWGWZ5tkxdq4pdzA==
X-Received: by 2002:a17:907:f769:b0:a7d:340e:43a4 with SMTP id
 a640c23a62f3a-a8366d474c1mr444370466b.31.1723730486912; 
 Thu, 15 Aug 2024 07:01:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838cf2b7sm107233066b.55.2024.08.15.07.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 07:01:26 -0700 (PDT)
Message-ID: <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
Date: Thu, 15 Aug 2024 16:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Manos,

On 15/8/24 13:42, Manos Pitsidianakis wrote:
> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.
> 
> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   MAINTAINERS                       |   6 ++
>   rust/meson.build                  |   9 +++
>   rust/qemu-api/.gitignore          |   2 +
>   rust/qemu-api/Cargo.lock          |   7 +++
>   rust/qemu-api/Cargo.toml          |  23 +++++++
>   rust/qemu-api/README.md           |  17 +++++
>   rust/qemu-api/build.rs            |  13 ++++
>   rust/qemu-api/meson.build         |  17 +++++
>   rust/qemu-api/rustfmt.toml        |   1 +
>   rust/qemu-api/src/bindings.rs     |   7 +++
>   rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>   rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
>   rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
>   rust/rustfmt.toml                 |   7 +++
>   15 files changed, 493 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5464cb2b03..56a88048d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3348,6 +3348,12 @@ F: hw/core/register.c
>   F: include/hw/register.h
>   F: include/hw/registerfields.h
>   
> +Rust
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Maintained
> +F: rust/qemu-api
> +F: rust/rustfmt.toml

Few lines in docs/devel/rust.rst would be welcomed,

> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
> new file mode 100644
> index 0000000000..51260cbe42
> --- /dev/null
> +++ b/rust/qemu-api/Cargo.toml
> @@ -0,0 +1,23 @@
> +[package]
> +name = "qemu_api"
> +version = "0.1.0"
> +edition = "2021"

> +license = "GPL-2.0 OR GPL-3.0-or-later"

in particular explaining the license choice.

Should all rust code use it?

Thanks,

Phil.


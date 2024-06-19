Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEEAC27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJnxU-0001Lc-F9; Wed, 19 Jun 2024 01:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJnxS-0001LI-5V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:34:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJnxO-0007Ps-4q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:34:09 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso4258318b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 22:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718775244; x=1719380044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/MTxxEp0N4+fC+mq3wmPNYfLu0PEEsgXoGWnCIY71c=;
 b=Ncv3hLYb+qMIqWg5v3FzdJk87IPL1ElHff6rFUSC9grVyafCeE+caOWbq63NdNDm9V
 B82yHkb/lrOT3ttv+075FH4vn6O7tOUbY/gGOgHnaYqS63pWfuDA4Xt/6YEXis14JIct
 Q1lLSljfrniUOHhjHM1fP0ipG65a65Zs3ffCLCaFs369oiXSYiTm0ZDgthuGwnEP70lZ
 /nmH+ETKhPCDqNqaZ2AIMS8h0ClUXCUxf+X3pN0/v1HGLYd+9jwxDW5Ua5Juo/FgJr0H
 jAu6Gxh+ymoj8ci0rIk4PuhZXLQJCcKD0eB5knIiEV1M5eAX90SpEXb4iWQCl/vGkLki
 HfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718775244; x=1719380044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/MTxxEp0N4+fC+mq3wmPNYfLu0PEEsgXoGWnCIY71c=;
 b=wiQXNGpI5rv8jzYuuZAf/xeznoxVD6Y5MYrGUiJ5wPUT1W0ag5FL7qu3bDH/gv8za1
 USQ5GIl+E2cgIacHSIRP+uouXqm151V15KkhhAqS5GDAtaAdEmghR/Yd8wDTM2xvzmuO
 2wQDc2e6uNb6pBpnbJMEB/DMHHtk8mlAQJE4N9WkQ20gpFpUc9MBbMRXhXww2Rt+e/1e
 F2iUBcSiEy84PL4TiiGnEedPo4fq8gxLfTh3Co/WRn0FqwCgnWrEG+ZoTkdTuuwA+oBF
 neqAKRWIdJbp5/8Jp1o/DXusB/0KBll5B72J/TIOD5EyyHHF0GRKqly2NGBJijSyL79H
 Yp6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpL+AcqM7KKfMJXjjVCdF9JI70gW7aNrAdMzFt8mj9GUOVPEVpIO0+T5NEPSmoTDR+mnlJOFjCHd/O1xsFLg+9wa/TVac=
X-Gm-Message-State: AOJu0YwKNxgA4JOVP5I9+CHDRwSvwDj9MBNJ77ClAjKdnImNVhzC3QuD
 H8CS+xR+oKWqzMlnLmd3bOaqOeW9WptwX+xom6KCG5i2iNHKul1s9gBA5+VCg6w=
X-Google-Smtp-Source: AGHT+IGRrJG25weEmsweO1f5/MPkdAdZXKHA7ykPxAzdEjkBW3GG+olU4cf9+ATGtJmhOEAQlM+UPw==
X-Received: by 2002:a05:6a20:491e:b0:1b4:772d:2885 with SMTP id
 adf61e73a8af0-1bcbb45643emr1530092637.3.1718775243810; 
 Tue, 18 Jun 2024 22:34:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ed9e6a0bsm6247805b3a.6.2024.06.18.22.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 22:34:03 -0700 (PDT)
Message-ID: <0841ddd2-d962-4f1d-a818-be9a1ec4d9bf@linaro.org>
Date: Tue, 18 Jun 2024 22:34:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/11/24 03:33, Manos Pitsidianakis wrote:
> This commit adds a re-implementation of hw/char/pl011.c in Rust.
> 
> It uses generated Rust bindings (produced by `ninja
> aarch64-softmmu-generated.rs`) to
> register itself as a QOM type/class.
> 
> How to build:
> 
> 1. Make sure rust, cargo and bindgen (cargo install bindgen-cli) are
>     installed

Ah hah.  Nevermind my previous question -- cargo install produces bindgen v0.69.4, quite a 
bit newer than the ubuntu 22.04 packaged version.  I have progressed a bit.

Please bear with me as I attempt to learn Rust in the process of reviewing this.  I 
promise no bikesheding and only to ask silly questions.


>   rust/pl011/.cargo/config.toml  |   2 +
>   rust/pl011/.gitignore          |   2 +
>   rust/pl011/Cargo.lock          | 120 +++++++
>   rust/pl011/Cargo.toml          |  66 ++++
>   rust/pl011/README.md           |  42 +++
>   rust/pl011/build.rs            |  44 +++
>   rust/pl011/deny.toml           |  57 ++++
>   rust/pl011/meson.build         |   7 +
>   rust/pl011/rustfmt.toml        |   1 +

First silly question: how much of this is boiler plate that gets moved the moment that the 
second rust subdirectory is added?


> diff --git a/rust/pl011/.cargo/config.toml b/rust/pl011/.cargo/config.toml
> new file mode 100644
> index 0000000000..241210ffa7
> --- /dev/null
> +++ b/rust/pl011/.cargo/config.toml
> @@ -0,0 +1,2 @@
> +[build]
> +rustflags = ["-Crelocation-model=pic", "-Ctarget-feature=+crt-static"]

It seems certain that this is not specific to pl011, and will be commot to other rust 
subdirectories.  Or, given the .cargo directory name, is this generated by cargo and 
committed by mistake?


> diff --git a/rust/pl011/.gitignore b/rust/pl011/.gitignore
> new file mode 100644
> index 0000000000..28a02c847f
> --- /dev/null
> +++ b/rust/pl011/.gitignore
> @@ -0,0 +1,2 @@
> +target
> +src/generated.rs.inc

Is this a symptom of generating files into the source directory and not build directory?


> diff --git a/rust/pl011/Cargo.lock b/rust/pl011/Cargo.lock
> new file mode 100644
> index 0000000000..d0fa46f9f5
> --- /dev/null
> +++ b/rust/pl011/Cargo.lock
> @@ -0,0 +1,120 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.

Second silly question: does this really need to be committed to the repository? It 
*appears* to be specific to the host+os-version of the build.  It is certainly very 
specific about versions and checksums...


> diff --git a/rust/pl011/Cargo.toml b/rust/pl011/Cargo.toml
> new file mode 100644
> index 0000000000..db74f2b59f
> --- /dev/null
> +++ b/rust/pl011/Cargo.toml
> @@ -0,0 +1,66 @@
> +[package]
> +name = "pl011"
> +version = "0.1.0"
> +edition = "2021"
> +authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
> +license = "GPL-2.0 OR GPL-3.0-or-later"
> +readme = "README.md"
> +homepage = "https://www.qemu.org"
> +description = "pl011 device model for QEMU"
> +repository = "https://gitlab.com/epilys/rust-for-qemu"
> +resolver = "2"
> +publish = false
> +keywords = []
> +categories = []
> +
> +[lib]
> +crate-type = ["staticlib"]
> +
> +# bilge deps included here to include them with docs
> +[dependencies]
> +arbitrary-int = { version = "1.2.7" }
> +bilge = { version = "0.2.0" }
> +bilge-impl = { version = "0.2.0" }

Likewise.

> diff --git a/rust/pl011/deny.toml b/rust/pl011/deny.toml
> new file mode 100644
> index 0000000000..3992380509
> --- /dev/null
> +++ b/rust/pl011/deny.toml
> @@ -0,0 +1,57 @@
> +# cargo-deny configuration file
> +
> +[graph]
> +targets = [
> +    "aarch64-unknown-linux-gnu",
> +    "x86_64-unknown-linux-gnu",
> +    "x86_64-apple-darwin",
> +    "aarch64-apple-darwin",
> +    "x86_64-pc-windows-gnu",
> +    "aarch64-pc-windows-gnullvm",
> +]

Very much likewise.
Since aarch64-pc-windows-gnullvm is not a host that qemu supports, if this is not 
auto-generated, I am confused.

> diff --git a/rust/pl011/rustfmt.toml b/rust/pl011/rustfmt.toml
> new file mode 120000
> index 0000000000..39f97b043b
> --- /dev/null
> +++ b/rust/pl011/rustfmt.toml
> @@ -0,0 +1 @@
> +../rustfmt.toml
> \ No newline at end of file

Newline.  Also, third silly question: is there a way we can avoid replicating this within 
every rust subdirectory?  E.g. some search path option within one of the build tools?


> +++ b/rust/pl011/src/definitions.rs
> +++ b/rust/pl011/src/device.rs
> +++ b/rust/pl011/src/device_class.rs
> +++ b/rust/pl011/src/lib.rs
> +++ b/rust/pl011/src/memory_ops.rs

Eek! Actual Rust! Skipping until I am better educated.


> diff --git a/rust/pl011/src/generated.rs b/rust/pl011/src/generated.rs
> new file mode 100644
> index 0000000000..670e7b541d
> --- /dev/null
> +++ b/rust/pl011/src/generated.rs
> @@ -0,0 +1,5 @@
> +#[cfg(MESON_GENERATED_RS)]
> +include!(concat!(env!("OUT_DIR"), "/generated.rs"));
> +
> +#[cfg(not(MESON_GENERATED_RS))]
> +include!("generated.rs.inc");

Is this indicative of Rust not being prepared to separate source and build directories? 
I'm surprised there would have to be a file in the source to direct the compiler to look 
for a file in the build.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16728C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHcq8-00052D-N9; Thu, 13 Jun 2024 01:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHcq7-000522-OJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:17:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHcq3-0003y7-NB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:17:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso5311905e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718255850; x=1718860650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K8SgNh1nDkEGD8LRgiuvMKUwRwWKuQzAh0qghPT0lbs=;
 b=fb/a0sWATWsoUaDB9qFXxOIJWjqppuXdgks1hqy+QtomVdiOp4XDgjlZaAgH510h/8
 hrZ4eWT/WQ14I8Pv9xs8ZM525HEWc3fEqhs4RhPU5QmJvlk2NPwyEvkfQjYIHq5upkXQ
 UzNOUotInRtTxGHm+hxVHgCZOePuJdgS6SI4uZqfZYgdyHW3yVdze8LR2LamB15twzEe
 ca2SXaTQuYzhRJIqXXQl9xgaWjyEkEG8O5ufy1ljlUxa7+It2utDg2RyiF2utRHl1XTo
 frlDkrLU1d1FQgZSVOsVDP6A22HsKfpjmjKehRmwk2CeJGPGx54I+nS2eq11r66Nni/i
 W0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718255850; x=1718860650;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8SgNh1nDkEGD8LRgiuvMKUwRwWKuQzAh0qghPT0lbs=;
 b=a/OBb8Z8KhgOSN2Cd1VuhfokwG74uPEUuJPxVP83AjhXI0xKT3hE59oaTYHicaMOam
 FJGEprmygEWl3nGt8Ex8iqnWrPVMsBOZhW6c4zOVPJ8kYbi4BKIxJPRSO6Ob7kbfYvZe
 mQZIlKngt7HC7Ip+dGuDWrXEU417RSaejDp9YBaf0ot5P0Vke2RXpSMknbrGh0v8bNEx
 SIork9Kg7cZzh4h1V2vhcl5leD1pFlmrrkEqoLlIeUuJdkgvrGngpc+3/+gvX8OGqejQ
 fTWAnWUi82umebUP1/EB4ITieKgKkk/tPRAY49BYqL/IuzAoPFCD0aBXi2VRn71/hmpp
 cBwA==
X-Gm-Message-State: AOJu0Yyikd0tPAlnQhFgCzDq1KbcUWSEnyentWZsiu4aji5Mmvqscq5a
 6lw99q7F2eCYVQSbUIXRVi4V9RbBFHzuIDWsxmuuYNZavf+L/MU4bEjNm96Bl9U=
X-Google-Smtp-Source: AGHT+IFTqOFbZeRaYD7oKUiA9Kv2gAvnTWzUOY5OpzsIiCG9ABWbR/BG1xQj+0pnxdLHgnKgtc+Mow==
X-Received: by 2002:a05:600c:4f4a:b0:421:1dde:cb5a with SMTP id
 5b1f17b1804b1-422865c302cmr32139415e9.35.1718255849650; 
 Wed, 12 Jun 2024 22:17:29 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422d0be1424sm14244815e9.12.2024.06.12.22.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:17:29 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:13:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 0/5] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <ZmleLH1dQvPqPBAY@redhat.com>
In-Reply-To: <ZmleLH1dQvPqPBAY@redhat.com>
Message-ID: <f06p3.rb3vk3rb2kt4@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

Good morning Daniel,

On Wed, 12 Jun 2024 11:37, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jun 11, 2024 at 01:33:29PM +0300, Manos Pitsidianakis wrote:
>
>> 
>>  .gitignore                     |   2 +
>>  .gitlab-ci.d/buildtest.yml     |  64 ++--
>>  MAINTAINERS                    |  13 +
>>  configure                      |  12 +
>>  hw/arm/virt.c                  |   4 +
>>  meson.build                    | 102 ++++++
>>  meson_options.txt              |   4 +
>>  rust/meson.build               |  93 ++++++
>>  rust/pl011/.cargo/config.toml  |   2 +
>>  rust/pl011/.gitignore          |   2 +
>>  rust/pl011/Cargo.lock          | 120 +++++++
>>  rust/pl011/Cargo.toml          |  66 ++++
>>  rust/pl011/README.md           |  42 +++
>>  rust/pl011/build.rs            |  44 +++
>>  rust/pl011/deny.toml           |  57 ++++
>>  rust/pl011/meson.build         |   7 +
>>  rust/pl011/rustfmt.toml        |   1 +
>>  rust/pl011/src/definitions.rs  |  95 ++++++
>>  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
>>  rust/pl011/src/device_class.rs |  95 ++++++
>>  rust/pl011/src/generated.rs    |   5 +
>>  rust/pl011/src/lib.rs          | 581 +++++++++++++++++++++++++++++++++
>>  rust/pl011/src/memory_ops.rs   |  38 +++
>>  rust/rustfmt.toml              |   7 +
>>  rust/wrapper.h                 |  39 +++
>>  scripts/cargo_wrapper.py       | 221 +++++++++++++
>>  scripts/meson-buildoptions.sh  |   6 +
>
>Given the priority of getting the build system correct, what's missing
>here is updates/integration into our standard GitLab CI pipeline. If
>that can be shown to be working, that'll give alot more confidence in
>the overall solution.
>
>Ideally this should not require anything more than updating the docker
>container definitions to add in the rust toolchain, plus the appropriate
>std library build for the given target - we cross compiler for every
>arch we officially care about.
>
>Most of our dockerfiles these days are managed by lcitool, and it has
>nearly sufficient support for cross compiling with the rust std library.
>So to start with, this series should modify tests/lcitool/projects/qemu.yml
>to add
>
>  - rust
>  - rust-std
>
>to the package list, and run 'make lcitool-refresh' to re-create the
>dockerfiles - see the docs/devel/testing.rst for more info about
>lcitool if needed.
>
>Assuming these 2 rust packages are in the container, I would then
>expect QEMU to just "do the right thing" when building this rust
>code. If it does not, then that's a sign of gaps that need closing.
>
>Getting rid of the need to use --rust-target-triple will be the
>immediate gap that needs fixing, as CI just passes --cross-prefix
>for cross-builds and expects everything to be set from that.
>
>The main gap we have is that for Windows I need to update lcitool
>to pull in the mingw std lib target for rust, which I something I
>missed when adding rust cross compiler support.
>


Thanks very much for the pointers! I will start dealing with this in the 
next RFC version.

Re: the target triple, I agree 100%. In fact it wasn't my addition, I 
kept it from the previous rust RFC patchset that was posted on the list 
some years ago. It should be possible to construct the triplets 
ourselves and let the user override if they want to as mentioned in 
another email.

The rust project has official Docker images, do you think it's something 
we could use or is it unnecessary? 

https://github.com/rust-lang/docker-rust

Thanks,
Manos


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04F6C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGz4J-0002a3-1X; Tue, 11 Jun 2024 06:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGz4H-0002Zd-Pq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:49:33 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGz4C-0005Px-TM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:49:33 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52c94cf4c9bso600426e87.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102966; x=1718707766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1iP0WhUUbO/bGNe9r3XVFJuPSweaJh7OI/Swnx6vQe0=;
 b=hAi6w9N1vuT5vW/TmwqKJ+tPWaloAHLinLhG2X9wrrPvKXYjqDQ0itZipRd+DsjGRr
 xbjn08LqHWJ+WmGtIR7fUhQsAIrQ2QVeCmxM/S/tgCzjwqchm2+Nt2/cdeWF3wI4bA6r
 mv4O5TimKzfCJ7YDg/eWubJ16QdzeA4gtdDLZE36iCLI4ZMgm5JdNatDMgD4OAXEqxL2
 KfZp9PV/Yv6Nb4ZAtujXwuSmRjRrDxwPJfdh8iYpFdSXSN/6kNJx7SatUdi2yxDlBb46
 Tp732VGjFgUEXLwi5Ga5wEV2tErlP9SN0qSb7LqqFdm59HvHxHQQcSvA/wzU+7u33JrD
 9gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102966; x=1718707766;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1iP0WhUUbO/bGNe9r3XVFJuPSweaJh7OI/Swnx6vQe0=;
 b=AssNntQHk3aQuxyObGxlqUAZs2jxZ9Jcr1wsI4QRobF9/GHenZl28GgKJieLgTUX3v
 hvVQAlHiqxjhOkNcS79bLO/aJRlzqhJ9niqWFvpRK1Vk3b3r+B+kUadBnW20BOvlGaU9
 pJp4sk0jwBUZTKarw4d2kXj9G8w9uV7T7Tp7UgPE0OLS7eWHRA4U8Jzw9R+NM/Dlza36
 Tb9dn3v3dgK18blornzME5DRs/YEn/y42FMSHrNq9+zRlZPNxAAvnGZsuIEjfwA4bstq
 eZVCofzK00HIpuw2ucIy2OT1IewJoX/EPoZUjcky3uXxFA3YKKxt00MAq0/5h/VzYHas
 QHTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKM8Ts48Ibzws0jMvmTpEJUalFOU98ImS32qFfWekaPO9LH25ywRscVxaYHwbhZPzT3UjbXWOTAvniMXHV/UMx31UE/s=
X-Gm-Message-State: AOJu0YzPP2VOIFLuwppfd778syRNcq72MowePXItQefpxa0kq05o5eSH
 UMLL6bj8rTRaNu/jM+Ykeb4Gu0si3mMn9VhG7tAVYEGNSGS3Abfy2Hqato+lb1Y=
X-Google-Smtp-Source: AGHT+IHQJCzTqICqQzWh+ppWAQi1kyZ82nqykYwZKzX3IHK4f4yrxGxW981NLA8WfuQ4EucCNaVqBA==
X-Received: by 2002:ac2:4c0a:0:b0:52c:80d7:ed31 with SMTP id
 2adb3069b0e04-52c80d7ee07mr5937143e87.25.1718102965571; 
 Tue, 11 Jun 2024 03:49:25 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4217c59be82sm112857095e9.0.2024.06.11.03.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:49:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:41:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgJVGMx81aHjg5f@redhat.com> <ZmgcrSYHwA0Z8Asq@intel.com>
In-Reply-To: <ZmgcrSYHwA0Z8Asq@intel.com>
Message-ID: <ewwqb.egyl58j8s5u@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
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

On Tue, 11 Jun 2024 12:45, Zhao Liu <zhao1.liu@intel.com> wrote:
>On Tue, Jun 11, 2024 at 09:22:44AM +0100, Daniel P. Berrangé wrote:
>> On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
>> > Hello everyone,
>> > 
>> > This is an early draft of my work on implementing a very simple device, 
>> > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c 
>> > and is used in hw/arm/virt.c).
>> 
>> looking at the diffstat:
>> 
>> >  .gitignore                     |   2 +
>> >  .gitlab-ci.d/buildtest.yml     |  64 ++--
>> >  configure                      |  12 +
>> >  hw/arm/virt.c                  |   2 +-
>> >  meson.build                    |  99 ++++++
>> >  meson_options.txt              |   4 +
>> >  rust/meson.build               |  93 ++++++
>> >  rust/pl011/.cargo/config.toml  |   2 +
>> >  rust/pl011/.gitignore          |   2 +
>> >  rust/pl011/Cargo.lock          | 120 +++++++
>> >  rust/pl011/Cargo.toml          |  26 ++
>> >  rust/pl011/README.md           |  42 +++
>> >  rust/pl011/build.rs            |  44 +++
>> >  rust/pl011/meson.build         |   7 +
>> >  rust/pl011/rustfmt.toml        |  10 +
>> >  rust/pl011/src/definitions.rs  |  95 ++++++
>> >  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
>> >  rust/pl011/src/device_class.rs |  95 ++++++
>> >  rust/pl011/src/generated.rs    |   5 +
>> >  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
>> >  rust/pl011/src/memory_ops.rs   |  38 +++
>> 
>> My thought is that if we're going to start implementing devices
>> or other parts of QEMU, in Rust, then I do not want to see it
>> placed in a completely separate directory sub-tree.
>> 
>> In this example, I would expect to have hw/arm/pl011.rs, or hw/arm/pl011/*.rs
>> so that the device is part of the normal Arm hardware directory structure 
>> and maintainer assignments.
>
>It has its advantages. Otherwise, as the number of Rust implementations
>grows, the same mirror directory as QEMU will have to be rebuilt again
>in the Rust directory.

Offtopic for this RFC but:

It'd also mean that each crate would have its own subdir in the tree. In 
the future free-standing .rs files like in the kernel would be nice to 
have.

For those who are not familiar with Cargo, a cargo library is a single 
compilation unit. You cannot have interspersed .rs files and compile 
with cargo as one does generally. You'd have to generate the rustc 
commands for building.

>
>Further, putting C implementations in the same directory, there is again
>the question of why it needs to be duplicated :-) . This topic is
>probably also beyond the scope of this RFC, but it's nice to have a Rust
>example to start with.

pl011 was suggested by Peter as a very simple device to model. The 
duplication is not meant to replace the C version for now or at the 
foreseeable future. It's more of a reference implementation.

>
>Currently, pl011 exclusively occupies a cargo as a package. In the
>future, will other Rust implementations utilize the workspace mechanism
>to act as a second package in the same cargo? Or will new cargo be created
>again?

What do you mean by "new cargo"? I didn't catch that :(

A workspace would make sense if we have "general" crate libraries that 
hardware crates depend on.

>
>Under a unified Rust directory, using a workspace to manage multiple
>packages looks as if it would be easier to maintain. Decentralized to an
>existing directory, they're all separate cargos, and external dependencies
>tend to become fragmented?

Hmm potentially yes, but that's a "what if" scenario. Let's worry about 
that bridge when we cross it!



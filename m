Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0A7C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 20:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGlkF-0002B9-38; Mon, 10 Jun 2024 16:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGlkC-0002Ax-Ux
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:35:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGlk8-0000vI-B3
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:35:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so20127115e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718051750; x=1718656550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TmNX8j2XQ2TklmpybtCU2661aY+wFBjO8Kbml4e1Fz0=;
 b=k466zb/oOwbfOerGoq4QjEhlbd47fLV795RAMitetg8kxMJSkfCZVSi///oWieglnG
 rUgttkAjFbIew6E+vE6HoRb7QnQBicwOPTjOdVB8D0gKzvsNW7Jl3e9eWpBy+m54KuEl
 UZIbZpc7nA6AH8RrpINLv2DZx17M36YtJcW+b8qnMkFtbQBDUFdidptn47YyHPijNO8L
 80yW70KIZPs9LK0V1MsYCUftPhQZQjNCWsrt48ILOw1648H/PV/Cj+SFlPJx2253UaKZ
 EY4qy3KqoAWdEJ0Ho9+nWGDYUz7GqplB9TrkQ0Yv1D/bAN7I8anDHOPIVzdI7IKOBZnp
 mNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718051750; x=1718656550;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TmNX8j2XQ2TklmpybtCU2661aY+wFBjO8Kbml4e1Fz0=;
 b=KZBDKtNdb38uUhU52Xan7ShhAjkICp/toyiddbinA0jRvADlKUiG0JgOZx+l08sw43
 LXdc61wqG1R3ZG2RsPzMkwrxbDYzYPSNx/AssI1AMmKilm4BYBjNS+Wb6Beq+YoQZsNf
 W5RV07or9GaruBlx1NH9tQkQNhfFZoqvQQtz52pwki+QF+TCrj4yGR3Qm+00HJZlT+qd
 YHCcgfXDK62wKKf/1V+5htNWrgpcQWyc+SZ1Ft0cRqrpqGovlr+6ZvRV1ves/GSdyabx
 paNq30LUmnaj4VYHVscvNfBmBmVTACL57oWANr9nQ234FRdSdk3/6noF2/vLYkReixuF
 ilZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiCBkG0abye+SLT7FYf1cteOYbcU5dSniDwe1++E3d3+qKmFK2T4LPjVreFYjoj0joaIHN4g7bfv3caF+9WU595bcifWo=
X-Gm-Message-State: AOJu0Yw/wFhl26b2f6rGAfuykytqBLuhZXu0dhofMggQhdNHTJ1s7+pm
 pmcHHaYjLnyjbz6Xu7J3PD97lrnFfGhsTXR/+vwbinvuQJ2D5RJs4c3br67sD3g=
X-Google-Smtp-Source: AGHT+IHdqsV283UqWWw2Je+8QukIHudEVBMSlFXRNc1aqpDqncyqkVGIMUo0r4Xh4URLzlEQUSsCfQ==
X-Received: by 2002:a05:600c:1ca1:b0:422:1def:e1ac with SMTP id
 5b1f17b1804b1-4223c92834emr5849695e9.20.1718051750045; 
 Mon, 10 Jun 2024 13:35:50 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1d74b065sm5642212f8f.84.2024.06.10.13.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 13:35:49 -0700 (PDT)
Date: Mon, 10 Jun 2024 23:29:36 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
In-Reply-To: <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
Message-ID: <evt7n.ggoypj31l14q@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>Hello Manos,
>
>On 6/10/24 11:22, Manos Pitsidianakis wrote:
>> Hello everyone,
>> 
>> This is an early draft of my work on implementing a very simple device,
>> in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
>> and is used in hw/arm/virt.c).
>> 
>> The device is functional, with copied logic from the C code but with
>> effort not to make a direct C to Rust translation. In other words, do
>> not write Rust as a C developer would.
>> 
>> That goal is not complete but a best-effort case. To give a specific
>> example, register values are typed but interrupt bit flags are not (but
>> could be). I will leave such minutiae for later iterations.
>> 
>> By the way, the wiki page for Rust was revived to keep track of all
>> current series on the mailing list https://wiki.qemu.org/RustInQemu
>> 
>> a #qemu-rust IRC channel was also created for rust-specific discussion
>> that might flood #qemu
>> 
>
>Excellent work, and thanks for posting this RFC!
>
>IMHO, having patches 2 and 5 splitted is a bit confusing, and exposing 
>(temporarily) the generated.rs file in patches is not a good move.
>Any reason you kept it this way?

That was my first approach, I will rework it on the second version. The 
generated code should not exist in committed code at all.

It was initally tricky setting up the dependency orders correctly, so I 
first committed it and then made it a dependency.

>
>Maybe it could be better if build.rs file was *not* needed for new 
>devices/folders, and could be abstracted as a detail of the python 
>wrapper script instead of something that should be committed.


That'd mean you cannot work on the rust files with a LanguageServer, you 
cannot run cargo build or cargo check or cargo clippy, etc. That's why I 
left the alternative choice of including a manually generated bindings 
file (generated.rs.inc)

>
>Having a simple rust/pl011/meson.build is nice and good taste!
>
>> ------------------------------------------------------------------------
>> A request: keep comments to Rust in relation to the QEMU project and no
>> debates on the merits of the language itself. These are valid concerns,
>> but it'd be better if they were on separate mailing list threads.
>> ------------------------------------------------------------------------
>> 
>> Table of contents: [TOC]
>> 
>> - How can I try it? [howcanItryit]
>> - What are the most important points to focus on, at this point?
>>    [whatarethemostimportant]
>>    - What are the issues with not using the compiler, rustc, directly?
>>      [whataretheissueswith]
>>      1. Tooling
>>      2. Rust dependencies
>> 
>>    - Should QEMU use third-party dependencies? [shouldqemuusethirdparty]
>>    - Should QEMU provide wrapping Rust APIs over QEMU internals?
>>      [qemuprovidewrappingrustapis]
>>    - Will QEMU now depend on Rust and thus not build on my XYZ platform?
>>      [qemudependonrustnotbuildonxyz]
>> - How is the compilation structured? [howisthecompilationstructured]
>> - The generated.rs rust file includes a bunch of junk definitions?
>>    [generatedrsincludesjunk]
>> - The staticlib artifact contains a bunch of mangled .o objects?
>>    [staticlibmangledobjects]
>> 
>> How can I try it?
>> =================
>> [howcanItryit] Back to [TOC]
>> 
>> Hopefully applying this patches (or checking out `master` branch from
>> https://gitlab.com/epilys/rust-for-qemu/ current commit
>> de81929e0e9d470deac2c6b449b7a5183325e7ee )
>> 
>> Tag for this RFC is rust-pl011-rfc-v1
>> 
>> Rustdoc documentation is hosted on
>> 
>> https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.gitlab.io/pl011/index.html
>> 
>> If `cargo` and `bindgen` is installed in your system, you should be able
>> to build qemu-system-aarch64 with configure flag --enable-rust and
>> launch an arm virt VM. One of the patches hardcodes the default UART of
>> the machine to the Rust one, so if something goes wrong you will see it
>> upon launching qemu-system-aarch64.
>> 
>> To confirm it is there for sure, run e.g. info qom-tree on the monitor
>> and look for x-pl011-rust.
>> 
>> 
>> What are the most important points to focus on, at this point?
>> ==============================================================
>> [whatarethemostimportant] Back to [TOC]
>> 
>> In my opinion, integration of the go-to Rust build system (Cargo and
>> crates.io) with the build system we use in QEMU. This is "easily" done
>> in some definition of the word with a python wrapper script.
>> 
>> What are the issues with not using the compiler, rustc, directly?
>> -----------------------------------------------------------------
>> [whataretheissueswith] Back to [TOC]
>> 
>> 1. Tooling
>>     Mostly writing up the build-sys tooling to do so. Ideally we'd
>>     compile everything without cargo but rustc directly.
>> 
>>     If we decide we need Rust's `std` library support, we could
>>     investigate whether building it from scratch is a good solution. This
>>     will only build the bits we need in our devices.
>>  > 2. Rust dependencies
>>     We could go without them completely. I chose deliberately to include
>>     one dependency in my UART implementation, `bilge`[0], because it has
>>     an elegant way of representing typed bitfields for the UART's
>>     registers.
>> 
>> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>>       Crates.io page: https://crates.io/crates/bilge
>>       Repository: https://github.com/hecatia-elegua/bilge
>> 
>> Should QEMU use third-party dependencies?
>> -----------------------------------------
>> [shouldqemuusethirdparty] Back to [TOC]
>> 
>> In my personal opinion, if we need a dependency we need a strong
>> argument for it. A dependency needs a trusted upstream source, a QEMU
>> maintainer to make sure it us up-to-date in QEMU etc.
>> 
>> We already fetch some projects with meson subprojects, so this is not a
>> new reality. Cargo allows you to define "locked" dependencies which is
>> the same as only fetching specific commits by SHA. No suspicious
>> tarballs, and no disappearing dependencies a la left-pad in npm.
>>
>
>As a complement to this, and for other readers, in more than having a 
>lock file (fixing version you use), cargo crates system is designed to 
>be immutable (see: https://crates.io/policies), and it means there is a 
>strong guarantee that a published package will stay there, to the 
>opposite of npm, pypi, or most of other similar systems.
>
>"Crate deletion by their owners is not possible to keep the registry as 
>immutable as possible."
>
>I believe this is a *key* feature of Rust ecosystem and should be 
>emphasized regarding the policy for Rust dependencies to come.
>
>> However, I believe it's worth considering vendoring every dependency by
>> default, if they prove to be few, for the sake of having a local QEMU
>> git clone buildable without network access.
>>
>
>I would not be in favor to vendor all dependencies. Beyond the "offline 
>build" scenario, it has only downsides.
>
>Sure, we should really debate before introducing a new dependency, but 
>the technical difficulty to mirror its sources and dependencies should 
>not be an argument for or against it.
>
>What will happen the day we want to introduce something bigger than a 
>simple dependency? (let's say "serde" for instance)


Yes, vendor-the-world is a different topic than vendor e.g. two crates 
such as the dependencies I'm using here.

>
>> Should QEMU provide wrapping Rust APIs over QEMU internals?
>> -----------------------------------------------------------
>> [qemuprovidewrappingrustapis] Back to [TOC]
>> 
>> My personal opinion is no, with the reasoning being that QEMU internals
>> are not documented or stable. However I do not see why creating stable
>> opt-in interfaces is bad. It just needs someone to volunteer to maintain
>> it and ensure there are no breakages through versions.
>> 
>> Will QEMU now depend on Rust and thus not build on my XYZ platform?
>> -------------------------------------------------------------------
>> [qemudependonrustnotbuildonxyz] Back to [TOC]
>> 
>> No, worry about this in some years if this experiment takes off. Rust
>> has broad platform support and is present in most distro package
>> managers. In the future we might have gcc support for it as well.
>> 
>> For now, Rust will have an experimental status, and will be aimed to
>> those who wish to try it. I leave it to the project leaders to make
>> proper decisions and statements on this if necessary.
>> 
>> 
>> How is the compilation structured?
>> ==================================
>> [howisthecompilationstructured] Back to [TOC]
>> 
>> First, a meson target that runs `bindgen` on a bunch of header files
>> (defined in `rust/wrapper.h`) is created as a target and as a dependency
>> for any rust hardware device that needs it. You can see the generated
>> bindings by running
>> 
>>    ninja generated.rs
>> 
>> inside your build directory.
>> 
>> The devices are defined as dictionaries in rust/meson.build because they
>> depend on the bindgen dependency, which is available much later in the
>> meson process (when the static qemu lib and target emulator executables
>> are defined).
>> 
>> A cargo wrapper python script under scripts/ exists to build the crate
>> library, by providing the path to the generated.rs bindings via the
>> environment. Then, the qemu-system-aarch64 binary links against the
>> staticlib archive (i.e. libpl011.a)
>> 
>> The generated.rs rust file includes a bunch of junk definitions?
>> ================================================================
>> [generatedrsincludesjunk] Back to [TOC]
>> 
>> Yes, bindgen allows you to block certain types and identifiers from
>> being generated but they are simply too many. I have trimmed some of the
>> fat but vast improvements can be made.
>> 
>> The staticlib artifact contains a bunch of mangled .o objects?
>> ==============================================================
>> [staticlibmangledobjects] Back to [TOC]
>> 
>> Yes, until we compile without the `std` module library or we compile it
>> manually instead of linking it, we will have some junk in it.
>> 
>
>Besides the size aspect, which potential advantage would there be to 
>switch to no_std?
>We don't build a bare metal or kernel binary here, so why introduce this 
>restriction willingly?

We'll see that as we progress. Might enable more platform support, for 
example. I have no definite answers here. Also, I know binary bloat is a 
big complaint from people with dislike of Rust, so I pre-emptively 
addressed it.


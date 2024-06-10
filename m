Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ED7C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGmik-0001hx-7s; Mon, 10 Jun 2024 17:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sGmii-0001hb-8O
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 17:38:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sGmid-0004wi-B1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 17:38:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70417a6c328so2660328b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718055501; x=1718660301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tqAEkvcMHSfvDqnem+4tbbiOjzUYO+0yvdMVh/brM8Y=;
 b=Cs+kLn6cQGCd7vmbOP67S9O4jCzr1CnvhEO3Muazd2jPlPsNeApu2MHTmc4hIvnIZh
 9lymN09+YxlYQSOA58ZXKnFTLqh1r6pHsxik9xWqDuJKGGI6B5KHuY40ExCj7cAnibD/
 iAmsxPsD3MFEc3U/R9LiRseYTxC0l7VdwwHvmYEL4X6zLumyy8tl9hONZEy6brYFHYFb
 OrbWT12Iso90/Fw1mBcxvKphQmEs8t9d7w0Ju6YRaz4fs125FnxKkTO3l06rHo7wRV1w
 RyI1/njdowoKRVcNqpIba3pHTRh3AAb5tfr5a1i08V+0xj6kAL3yZ/OLDUD8t4cKeBgm
 xjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718055501; x=1718660301;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqAEkvcMHSfvDqnem+4tbbiOjzUYO+0yvdMVh/brM8Y=;
 b=gqjD60d2nU44xlT2pod+h36PiGf4BReEanHgmOxoTo8wFI5kFvYJ70K3/CIBnnwQnN
 vG6V60f05RrzAB82v4gJBQ0iRDYTT+sCIYg4X4flM9OIeVsa2TWGxpefrcPGHrDftEsS
 hFmKT57gt0hjQIPo4RpVt7zQg9FQ9V7Z6sXYgenKMzHngFV48dHRiZl1s5DrfsghV+y8
 BV+dYAdJWmgufCPJWCEK2nM8H0hrOZNhNOun+oPaRlLnY9R3udypAYmwrDHO4YkqKIwu
 DAtL4d1gWdcy2FR2Nrz7o7x3uq6ZJc2hwetJVzVBweKPd+kXnyLMAdUiLMz0oQIhgblA
 wdwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgPiaxvAcyMAy7qMv5/k6lHa1BZA6m3djfIiq7ZpeO+owciwF6bKG6sZTvWFa0vBO/zqAreRroYc+Gxgg8jBuOUlpdN/s=
X-Gm-Message-State: AOJu0YzQ+RcMbH7ihA208Yg7xRVamhaSxdF18IzG73T9KN4xQCBnAbrq
 c0EmJhcgeAI3Sn8brXOZH97wZ27gw7N9i/w0ezIp5l/Ow7IrLWSpND2HtZV3FN4=
X-Google-Smtp-Source: AGHT+IFNj/YvPnM9xMgIM33HkZaI3Owvix19l8wLwW6JUSb38gwHEOYCRgqbpZlMXJqVVgf7Uz7Azg==
X-Received: by 2002:a05:6a20:d49a:b0:1b7:4adb:1dcc with SMTP id
 adf61e73a8af0-1b74adb1eaemr2925338637.60.1718055501392; 
 Mon, 10 Jun 2024 14:38:21 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50beb6sm7405998b3a.176.2024.06.10.14.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 14:38:20 -0700 (PDT)
Message-ID: <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org>
Date: Mon, 10 Jun 2024 14:38:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <evt7n.ggoypj31l14q@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/10/24 13:29, Manos Pitsidianakis wrote:
> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> Hello Manos,
>>
>> On 6/10/24 11:22, Manos Pitsidianakis wrote:
>>> Hello everyone,
>>>
>>> This is an early draft of my work on implementing a very simple device,
>>> in this case the ARM PL011 (which in C code resides in hw/char/pl011.c
>>> and is used in hw/arm/virt.c).
>>>
>>> The device is functional, with copied logic from the C code but with
>>> effort not to make a direct C to Rust translation. In other words, do
>>> not write Rust as a C developer would.
>>>
>>> That goal is not complete but a best-effort case. To give a specific
>>> example, register values are typed but interrupt bit flags are not (but
>>> could be). I will leave such minutiae for later iterations.
>>>
>>> By the way, the wiki page for Rust was revived to keep track of all
>>> current series on the mailing list https://wiki.qemu.org/RustInQemu
>>>
>>> a #qemu-rust IRC channel was also created for rust-specific discussion
>>> that might flood #qemu
>>>
>>
>> Excellent work, and thanks for posting this RFC!
>>
>> IMHO, having patches 2 and 5 splitted is a bit confusing, and exposing
>> (temporarily) the generated.rs file in patches is not a good move.
>> Any reason you kept it this way?
> 
> That was my first approach, I will rework it on the second version. The
> generated code should not exist in committed code at all.
> 
> It was initally tricky setting up the dependency orders correctly, so I
> first committed it and then made it a dependency.
> 
>>
>> Maybe it could be better if build.rs file was *not* needed for new
>> devices/folders, and could be abstracted as a detail of the python
>> wrapper script instead of something that should be committed.
> 
> 
> That'd mean you cannot work on the rust files with a LanguageServer, you
> cannot run cargo build or cargo check or cargo clippy, etc. That's why I
> left the alternative choice of including a manually generated bindings
> file (generated.rs.inc)
> 

Maybe I missed something, but it seems like it just checks/copies the 
generated.rs file where it's expected. Definitely something that could 
be done as part of the rust build.

Having to run the build before getting completion does not seem to be a 
huge compromise.

>>
>> Having a simple rust/pl011/meson.build is nice and good taste!
>>
>>> ------------------------------------------------------------------------
>>> A request: keep comments to Rust in relation to the QEMU project and no
>>> debates on the merits of the language itself. These are valid concerns,
>>> but it'd be better if they were on separate mailing list threads.
>>> ------------------------------------------------------------------------
>>>
>>> Table of contents: [TOC]
>>>
>>> - How can I try it? [howcanItryit]
>>> - What are the most important points to focus on, at this point?
>>>     [whatarethemostimportant]
>>>     - What are the issues with not using the compiler, rustc, directly?
>>>       [whataretheissueswith]
>>>       1. Tooling
>>>       2. Rust dependencies
>>>
>>>     - Should QEMU use third-party dependencies? [shouldqemuusethirdparty]
>>>     - Should QEMU provide wrapping Rust APIs over QEMU internals?
>>>       [qemuprovidewrappingrustapis]
>>>     - Will QEMU now depend on Rust and thus not build on my XYZ platform?
>>>       [qemudependonrustnotbuildonxyz]
>>> - How is the compilation structured? [howisthecompilationstructured]
>>> - The generated.rs rust file includes a bunch of junk definitions?
>>>     [generatedrsincludesjunk]
>>> - The staticlib artifact contains a bunch of mangled .o objects?
>>>     [staticlibmangledobjects]
>>>
>>> How can I try it?
>>> =================
>>> [howcanItryit] Back to [TOC]
>>>
>>> Hopefully applying this patches (or checking out `master` branch from
>>> https://gitlab.com/epilys/rust-for-qemu/ current commit
>>> de81929e0e9d470deac2c6b449b7a5183325e7ee )
>>>
>>> Tag for this RFC is rust-pl011-rfc-v1
>>>
>>> Rustdoc documentation is hosted on
>>>
>>> https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.gitlab.io/pl011/index.html
>>>
>>> If `cargo` and `bindgen` is installed in your system, you should be able
>>> to build qemu-system-aarch64 with configure flag --enable-rust and
>>> launch an arm virt VM. One of the patches hardcodes the default UART of
>>> the machine to the Rust one, so if something goes wrong you will see it
>>> upon launching qemu-system-aarch64.
>>>
>>> To confirm it is there for sure, run e.g. info qom-tree on the monitor
>>> and look for x-pl011-rust.
>>>
>>>
>>> What are the most important points to focus on, at this point?
>>> ==============================================================
>>> [whatarethemostimportant] Back to [TOC]
>>>
>>> In my opinion, integration of the go-to Rust build system (Cargo and
>>> crates.io) with the build system we use in QEMU. This is "easily" done
>>> in some definition of the word with a python wrapper script.
>>>
>>> What are the issues with not using the compiler, rustc, directly?
>>> -----------------------------------------------------------------
>>> [whataretheissueswith] Back to [TOC]
>>>
>>> 1. Tooling
>>>      Mostly writing up the build-sys tooling to do so. Ideally we'd
>>>      compile everything without cargo but rustc directly.
>>>
>>>      If we decide we need Rust's `std` library support, we could
>>>      investigate whether building it from scratch is a good solution. This
>>>      will only build the bits we need in our devices.
>>>   > 2. Rust dependencies
>>>      We could go without them completely. I chose deliberately to include
>>>      one dependency in my UART implementation, `bilge`[0], because it has
>>>      an elegant way of representing typed bitfields for the UART's
>>>      registers.
>>>
>>> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>>>        Crates.io page: https://crates.io/crates/bilge
>>>        Repository: https://github.com/hecatia-elegua/bilge
>>>
>>> Should QEMU use third-party dependencies?
>>> -----------------------------------------
>>> [shouldqemuusethirdparty] Back to [TOC]
>>>
>>> In my personal opinion, if we need a dependency we need a strong
>>> argument for it. A dependency needs a trusted upstream source, a QEMU
>>> maintainer to make sure it us up-to-date in QEMU etc.
>>>
>>> We already fetch some projects with meson subprojects, so this is not a
>>> new reality. Cargo allows you to define "locked" dependencies which is
>>> the same as only fetching specific commits by SHA. No suspicious
>>> tarballs, and no disappearing dependencies a la left-pad in npm.
>>>
>>
>> As a complement to this, and for other readers, in more than having a
>> lock file (fixing version you use), cargo crates system is designed to
>> be immutable (see: https://crates.io/policies), and it means there is a
>> strong guarantee that a published package will stay there, to the
>> opposite of npm, pypi, or most of other similar systems.
>>
>> "Crate deletion by their owners is not possible to keep the registry as
>> immutable as possible."
>>
>> I believe this is a *key* feature of Rust ecosystem and should be
>> emphasized regarding the policy for Rust dependencies to come.
>>
>>> However, I believe it's worth considering vendoring every dependency by
>>> default, if they prove to be few, for the sake of having a local QEMU
>>> git clone buildable without network access.
>>>
>>
>> I would not be in favor to vendor all dependencies. Beyond the "offline
>> build" scenario, it has only downsides.
>>
>> Sure, we should really debate before introducing a new dependency, but
>> the technical difficulty to mirror its sources and dependencies should
>> not be an argument for or against it.
>>
>> What will happen the day we want to introduce something bigger than a
>> simple dependency? (let's say "serde" for instance)
> 
> 
> Yes, vendor-the-world is a different topic than vendor e.g. two crates
> such as the dependencies I'm using here.
>

If there must be a discussion about dependencies, it's probably better 
to consider the "worse" case to take a decison about vendoring this or not.

>>
>>> Should QEMU provide wrapping Rust APIs over QEMU internals?
>>> -----------------------------------------------------------
>>> [qemuprovidewrappingrustapis] Back to [TOC]
>>>
>>> My personal opinion is no, with the reasoning being that QEMU internals
>>> are not documented or stable. However I do not see why creating stable
>>> opt-in interfaces is bad. It just needs someone to volunteer to maintain
>>> it and ensure there are no breakages through versions.
>>>
>>> Will QEMU now depend on Rust and thus not build on my XYZ platform?
>>> -------------------------------------------------------------------
>>> [qemudependonrustnotbuildonxyz] Back to [TOC]
>>>
>>> No, worry about this in some years if this experiment takes off. Rust
>>> has broad platform support and is present in most distro package
>>> managers. In the future we might have gcc support for it as well.
>>>
>>> For now, Rust will have an experimental status, and will be aimed to
>>> those who wish to try it. I leave it to the project leaders to make
>>> proper decisions and statements on this if necessary.
>>>
>>>
>>> How is the compilation structured?
>>> ==================================
>>> [howisthecompilationstructured] Back to [TOC]
>>>
>>> First, a meson target that runs `bindgen` on a bunch of header files
>>> (defined in `rust/wrapper.h`) is created as a target and as a dependency
>>> for any rust hardware device that needs it. You can see the generated
>>> bindings by running
>>>
>>>     ninja generated.rs
>>>
>>> inside your build directory.
>>>
>>> The devices are defined as dictionaries in rust/meson.build because they
>>> depend on the bindgen dependency, which is available much later in the
>>> meson process (when the static qemu lib and target emulator executables
>>> are defined).
>>>
>>> A cargo wrapper python script under scripts/ exists to build the crate
>>> library, by providing the path to the generated.rs bindings via the
>>> environment. Then, the qemu-system-aarch64 binary links against the
>>> staticlib archive (i.e. libpl011.a)
>>>
>>> The generated.rs rust file includes a bunch of junk definitions?
>>> ================================================================
>>> [generatedrsincludesjunk] Back to [TOC]
>>>
>>> Yes, bindgen allows you to block certain types and identifiers from
>>> being generated but they are simply too many. I have trimmed some of the
>>> fat but vast improvements can be made.
>>>
>>> The staticlib artifact contains a bunch of mangled .o objects?
>>> ==============================================================
>>> [staticlibmangledobjects] Back to [TOC]
>>>
>>> Yes, until we compile without the `std` module library or we compile it
>>> manually instead of linking it, we will have some junk in it.
>>>
>>
>> Besides the size aspect, which potential advantage would there be to
>> switch to no_std?
>> We don't build a bare metal or kernel binary here, so why introduce this
>> restriction willingly?
> 
> We'll see that as we progress. Might enable more platform support, for
> example. I have no definite answers here. Also, I know binary bloat is a
> big complaint from people with dislike of Rust, so I pre-emptively
> addressed it.

I understand.
Stripping rust binary does a big difference in size, including for 
release builds.
I hope we'll explore other options than using no_std if binary size 
should become a decisive criteria.


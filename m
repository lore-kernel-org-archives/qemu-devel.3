Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47450C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBkO-0001Dp-3s; Tue, 09 Jul 2024 10:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRBkM-00014q-6P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:23:10 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRBkK-00022G-Em
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:23:09 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso655185466b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534986; x=1721139786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYqIMsfZx/0JNYEcxcKEC1Ac34cUnomUF4aA0EU25E4=;
 b=WsS4NWKr0cvKTr4L0pqpxnzln1Daob2NyllTSuaRMpapbzgqOiztEn4eyqyHpumVEx
 Y+YuQ2aQaXqJjPaKCcLt+GRU40hwsb8eKCv4DZUp4z8lTF3lBcddig1PZV6MSp3vjWtZ
 gZQreAolsTIIrjsYvrqB5+gqSzfkOATZuQApqWLW4/YMSEeVaNRMy0KcrRkc+TgFJoIm
 plLEWS+ruB1psBoFbUrrBh1Slq1qB7QzmfItAcicQkG/NfskfC6TTxRXsRyIpxEG4Vde
 1oCAaeAlwptme5Oc3GAarIeNybgO/Wi31W4VmTieyUbcC6/IH4Zqfhf0K0WbPnpJZ1lS
 JZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534986; x=1721139786;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYqIMsfZx/0JNYEcxcKEC1Ac34cUnomUF4aA0EU25E4=;
 b=rOde5RJIDweD9U3eknqE+ORzOK1Jpq646jGaM0002O9L8S8JbwlAHvll18CHXxXdXX
 osSv3WO7mRUZiFMRMBk91b67UhniRP5wOm5Lf8sy70LOKjggEblFKmoqlLZBPRVRYUp5
 YzBIAdLjqgTHqDoHRUCPdnHZWpTeBYSVhA6CUtcV0wNJbSpvXbFo2neFahwiviczKqRX
 t9K+mhrz95qOLIvKDdU/7soI+YIcOyFlbt1wnFrlEZgG4jP7cwAwxmJ21O0yK0PRy5Yy
 WF2xfgcFo7ZU7H4GBlFJrbmaROzWlva1T0cDxd75IFndXUVktNo0+apveKjwmaweHVh+
 GdYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZI0Fc8nTzfd1VkCtrGPpCgbnkkfL5k9U6Q22NAPyJToNBxB7E0OYMmjGo3TvQxgGZ+ts3H8jm7+94JmgkMcyYJ/ZwNU0=
X-Gm-Message-State: AOJu0YxcW+A7ci0cnttpYd8jNnUpbLQ7VfRu7/+vSIIwwO3cV6xU9xD3
 eDK0T8+S8lqWtTJOYj8kQFYJT7iZ6d9/X+2H3n9FiIMRqPAWIQeRIdcKVWHX4q0=
X-Google-Smtp-Source: AGHT+IEX6EzV1SeSeXwZXZ9K8TvTDY3fe+GK6MttoADGpJz1CqOd8BhprEj+3jtTY4lTpRXK51YpYw==
X-Received: by 2002:a17:906:fcc4:b0:a77:d8c9:ae23 with SMTP id
 a640c23a62f3a-a780b882839mr203443366b.59.1720534985536; 
 Tue, 09 Jul 2024 07:23:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6bcc75sm81102966b.33.2024.07.09.07.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 07:23:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 420F35F8D7;
 Tue,  9 Jul 2024 15:23:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-devel@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,  John Snow
 <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
In-Reply-To: <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
 (Paolo Bonzini's message of "Tue, 9 Jul 2024 14:28:38 +0200")
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
Date: Tue, 09 Jul 2024 15:23:04 +0100
Message-ID: <87a5iqskzb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Tue, Jul 9, 2024 at 2:09=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>>  * what is the actual baseline requirement? We definitely want
>>    to support "using rustup on an older system" (should be no
>>    problem) and "current distro building QEMU using the distro's
>>    rust", I assume. It would certainly be nice to have "building
>>    QEMU on the older-but-still-in-our-support-list distro releases
>>    with that distro's rust", but this probably implies not just
>>    a minimum rust version but also a limited set of crates.
>
> I don't think limiting ourselves to the set of crates in the distro is
> feasible. It's not the way the language works, for example I tried
> checking if the "cstr" crate exists and I didn't find it in Debian.
>
> We can define a known-good set of versions:
> * either via Cargo.lock (i.e. recording the versions and downloading
> them) or by including sources in the tree
> * at any time in qemu.git, at branching time (three times a year), or
> on every release
>
> (That's six possibilities overall).
>
>>    I think (but forget the details) that some of what we've done
>>    with Python where we accept that the older-but-still-supported
>>    distro will end up taking the "download at build time" path
>>    in the build system might apply also for Rust.
>
> Yes, and --without-download may be changed to the "--frozen" flag of carg=
o.
>
>>  * what, on the Rust side, is the version requirement? Presumably
>>    there's some features that are pretty much "we really need
>>    this and can't do without it" and some which are "this would
>>    be pretty awkward not to have but if we have to we can implement
>>    some kind of fallback/alternative with a TODO note to come
>>    back and clean up when our baseline moves forwards".
>
> Here are the stopping points that I found over the last couple weeks:
>
> 1.56.0: 2021 edition
> 1.59.0: const CStr::from_bytes_with_nul_unchecked (needed by cstr
> crate, see below)
> 1.64.0: std::ffi::c_char
> 1.65.0: Generic Associated Types
> 1.74.0: Clippy can be configured in Cargo.toml
> 1.77.0: C string literals, offset_of!
>
> I think 1.59.0 is pretty much the lower bound. Not having offset_of!
> will be a bit painful, but it can be worked around (and pretty much
> has to be, because 1.77.0 is really new).
>
> As far as I understand, Debian bullseye has 1.63.0 these days and it's
> the oldest platform we have.

I was going to say Bookworm has now superseded Bullseye which will reach
its release + 3 year support point in August. However the version you
mention in the Bookworm one!

>
> Paolo
>
>> At that point we have more information to figure out what
>> if any tradeoff we want to make.
>>
>> thanks
>> -- PMM
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


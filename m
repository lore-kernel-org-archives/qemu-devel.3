Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59920C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxpw-0006As-FY; Tue, 11 Jun 2024 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxpu-00068Y-RX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:30:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxps-0007qi-ND
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:30:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a52dfd081so991110a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718098235; x=1718703035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AbcuUhK3LaL0JvHiBlPX7mdsWHxijm/AB7JI39XtzRM=;
 b=pRyyNw7K+WGjRF2JvDiMJ2QQTeUED+4HOB4qrN3fs8DwHOU+z5mHkLPIqNEJLht2S/
 Ka1DBCzlVQy2FlbbOIp3F/gwzf5Orl5C49ebOvg0RCbXExEwogMVNm1rhz77LJFbUFTP
 NFa8FAZYILFokM8cqk6xafLNYlpeKwNe+g/nV9FsRfLs9HOXkO1Bxr5v5s2FbT7CXQsN
 hkOYZt8Fhg0nOqu6Umokga5oRoQzloSFV8Q1VmONHJOSbk8Tn8mSIzHaNpoZ8hlgSDrX
 MSyFjaSnaHWM2bHjcMOP9R2lo8wpzSpdzAAdHzJ8SoppY56EgpF0+QhUHwxh5q57q28n
 jz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098235; x=1718703035;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbcuUhK3LaL0JvHiBlPX7mdsWHxijm/AB7JI39XtzRM=;
 b=hYkVd7Y73cKkHmiYTmwYLJSeMrqVf23X1tAshAjXX37NMVke5xZuWRf4saAi7gVTQp
 TLjveJkFom3AV2zPve4jLChUCNpmgcV205WFZY5VLID4Be/0lQgzCGb7ZwBgxAKDR8Ap
 3FOfN95/DfWKEqeg0IBloKgvaFR2bpYLdy4sm7QQjyOOgpUCWNwGQ0MdaISj0VJzBlSz
 WlE9fvdqtmEb1dvhCJsUkCcin9AQF5xXi6bzCPfjqXGpxOBbdJgulGrMi354ei3KqBKh
 vYQ8UXbeLYOpqk9nAzGnFNvMXvj6LV4Jz6VgvpVfu18U2R3oqARS6Gan0CHFypIhShk5
 gPIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS/yikCSUVR1dBYWN+133qi3HPo5+42YYZrqhCSvtodc9K6uW35RfWsEn6f3y4JeX82cPsMIcmmUUoWbw8P3trIhxrhGA=
X-Gm-Message-State: AOJu0Yx4jXApg7G3+yPe+sD0IouWNoiUsS8WfjkLZy2gxWGBbjHs9g5B
 RF3z276ZeduUM4UPBKt/hyMW7tLeK3L7J+5toLzfmK3mZOq0wGjkIM4zz60QXbk=
X-Google-Smtp-Source: AGHT+IEy2rcJefxKoB28N+t5SJINbIKN6BVs8Alk6Bg/oWVosz6ceWXvSZEEnedJWEdlBFdwQId+/A==
X-Received: by 2002:a17:906:bc4e:b0:a6f:20ed:8b3d with SMTP id
 a640c23a62f3a-a6f20ed8c4cmr334263566b.33.1718098234737; 
 Tue, 11 Jun 2024 02:30:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1c99d8f1sm272401966b.175.2024.06.11.02.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:30:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C1B45F898;
 Tue, 11 Jun 2024 10:30:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
In-Reply-To: <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 10 Jun 2024 16:47:33 -0400")
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
 <evsu7.aus3yo6r56i@linaro.org>
 <CAJSP0QWLe6yPDE3rPztx=oS0g+vKT9W3GykrNU0EQZcaW06sog@mail.gmail.com>
Date: Tue, 11 Jun 2024 10:30:33 +0100
Message-ID: <87jzivzv0m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, 10 Jun 2024 at 16:27, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
>>
>> On Mon, 10 Jun 2024 22:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
<snip>
>> >>
>> >> 1. Tooling
>> >>    Mostly writing up the build-sys tooling to do so. Ideally we'd
>> >>    compile everything without cargo but rustc directly.
>> >
>> >Why would that be ideal?
>>
>> It remove the indirection level of meson<->cargo<->rustc. I don't have a
>> concrete idea on how to tackle this, but if cargo ends up not strictly
>> necessary, I don't see why we cannot use one build system.
>
> The convenience of being able to use cargo dependencies without
> special QEMU meson build system effort seems worth the overhead of
> meson<->cargo<->rustc to me. There is a blog post that explores using
> cargo crates using meson's wrap dependencies here, and it seems like
> extra work:
> https://coaxion.net/blog/2023/04/building-a-gstreamer-plugin-in-rust-with=
-meson-instead-of-cargo/
>
> It's possible to use just meson today, but I don't think it's
> practical when using cargo dependencies.

I did find the wrap approach very useful in giving a useful checkout
with --download that I can edit and tweak but is still integrated into
the build. This is helpful when working with very new libraries that
haven't been widely packaged yet. Distro's can choose or not choose to
use --download as they wish.

<snip>
>> >
>> >Do you mean vendoring by committing them to qemu.git or just the
>> >practice of running `cargo vendor` locally for users who decide they
>> >want to keep a copy of the dependencies?
>>
>>
>> Committing, with an option to opt-out. They are generally not big in
>> size. I am not of strong opinion on this one, I'm very open to
>> alternatives.

I think we generally host stuff we explicitly need in separate mirrors
or even a little light forking (testfloat does this).

> Fedora and Debian want Rust applications to use distro-packaged
> crates. No vendoring and no crates.io online access. It's a bit of a
> pain because Rust developers need to make sure their code works with
> whatever version of crates Fedora and Debian provide.
>
> The `cargo vendor` command makes it easy for anyone wishing to collect
> the required dependencies for offline builds (something I've used for
> CentOS builds where vendoring is allowed).
>
> I suggest not vendoring packages in qemu.git. Users can still run
> `cargo vendor` for easy offline builds.
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


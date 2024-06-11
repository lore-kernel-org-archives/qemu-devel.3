Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A8FC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0yC-0007W6-PE; Tue, 11 Jun 2024 08:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH0y8-0007Vm-Iu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:51:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH0y5-0004Cm-16
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:51:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421b9068274so19426035e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718110275; x=1718715075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tw/5KdhMBbRru/oKBEe3J2+edD9U0x9EiCxNfJDr2HM=;
 b=F10X3q0HMw94gAzLYVZ3qehZQ4S2GVL6K6MzrAlH9zzYpA4XiVcdBF4TIYFePMG8yW
 WmPCbwig/jGBq0EaOXlITBaGivTznvMMIcmVS/F+Vw6uugd45smeTAZ0xUFgOr3+XckW
 dGQSmnBZhT2vADOflfQNyPf29m+tT5nQ8vtsZ4u+bxlFH/ygikx2FTXERNM9kOg+0wJG
 TDAyItdNzDmC90Ak5ICmX3S1u0VfgydickYUYm8x/rb9pZbyWLH7L/7zeUZzW8MFkvdP
 zxTVUvtvUJs1BEW/JdwJOi356amz3LSXc27v8AW0Y41bIWFxNtW5ICptfTmVxa+1pSPz
 JOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718110275; x=1718715075;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tw/5KdhMBbRru/oKBEe3J2+edD9U0x9EiCxNfJDr2HM=;
 b=Q/kTh5m9gZkaX4FIZbhX0QwsKzKeisd/dTeY7X60E/wKIppRn0P3MI5SvtFi3fVqpI
 KxdQlkNlAljKEz3/pkPpWfur5VMhHUQ7FQVZllnvW+e9GJGuxMVi7bwhGUcj3rdrlK4f
 lUnQ+T56VHw80ETApoXrHdxyx421mKM3eoERAOT/oP0q+ClKPz4NfFvBZ9Tf0EejpKVf
 bRbxdGNYu/cBRtyQtDyUBPhS84in9ZDzGRC4c7bGe65k64d0rKZUSCnGlC2cNa2sJ9uV
 JT7ddPMR4TGCSKCjxnRRslHaqhdqP++g8Bi9O81bvNazdILev2ZsBvRI2qdxuoFgYdWp
 PyTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYStgwjYrUVmTslCz8w7gTGHr4ItTgS0hMer0OZQ6zNVWk983NMIApWdMolpzsC7e1QaHzc2w0NiabyrUaaG9WBbZuPB0=
X-Gm-Message-State: AOJu0Yxp75x1ittUXBUGYSULszV0tllh9Vvq7L0G8siUDt8uSqNYz38I
 nVHofyhrd9eZN2RRbVLU9boTQv98lJuDEtt7PddiGohR/Atbl3TmdpfY9TKtMdc=
X-Google-Smtp-Source: AGHT+IGHnPs6meaooEd4uWR7QEq0gK5+iEi3aOLxWRavsnbrtLMtU8LHh89TfAhPQYBuEYJw1G930w==
X-Received: by 2002:a05:600c:4750:b0:422:35:d19d with SMTP id
 5b1f17b1804b1-4220035d5d7mr40812325e9.36.1718110275282; 
 Tue, 11 Jun 2024 05:51:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421c9d24b6csm74429785e9.30.2024.06.11.05.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:51:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC3E35F898;
 Tue, 11 Jun 2024 13:51:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
In-Reply-To: <Zmgwcwcs-HbHpVf-@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 11 Jun 2024 12:09:39 +0100")
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgtfgqOOKeipIDd@redhat.com>
 <ewxal.5kz7id1gqls@linaro.org> <Zmgwcwcs-HbHpVf-@redhat.com>
Date: Tue, 11 Jun 2024 13:51:13 +0100
Message-ID: <875xufzlq6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jun 11, 2024 at 01:58:10PM +0300, Manos Pitsidianakis wrote:
>> On Tue, 11 Jun 2024 13:57, "Daniel P. Berrang=C3=A9" <berrange@redhat.co=
m> wrote:
>> > On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>> > > On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro=
.org> wrote:
>> > > > Hello Manos,
>> > > > > On 6/10/24 11:22, Manos Pitsidianakis wrote:
>> > > > > Hello everyone,
>> > > > > > > This is an early draft of my work on implementing a very
>> > > simple device,
>> > > > > in this case the ARM PL011 (which in C code resides in hw/char/p=
l011.c
>> > > > > and is used in hw/arm/virt.c).
>> > > > > > > The device is functional, with copied logic from the C code
>> > > but with
>> > > > > effort not to make a direct C to Rust translation. In other word=
s, do
>> > > > > not write Rust as a C developer would.
>> > > > > > > That goal is not complete but a best-effort case. To give a
>> > > specific
>> > > > > example, register values are typed but interrupt bit flags are n=
ot (but
>> > > > > could be). I will leave such minutiae for later iterations.
>> >=20
>> > snip
>> >=20
>> > > > Maybe it could be better if build.rs file was *not* needed for new
>> > > > devices/folders, and could be abstracted as a detail of the python
>> > > > wrapper script instead of something that should be committed.
>> > >=20
>> > >=20
>> > > That'd mean you cannot work on the rust files with a LanguageServer,=
 you
>> > > cannot run cargo build or cargo check or cargo clippy, etc. That's w=
hy I
>> > > left the alternative choice of including a manually generated bindin=
gs file
>> > > (generated.rs.inc)
>> >=20
>> > I would not expect QEMU developers to be running 'cargo <anything>'
>> > directly at all.
>> >=20
>> > QEMU's build system is 'meson' + 'ninja' with a 'configure' + 'make'
>> > convenience facade.
>> >=20
>> > Any use of 'cargo' would be an internal impl detail of meson rules
>> > for building rust code, and developers should still exclusively work
>> > with 'make' or 'ninja' to run builds & tests.
>>=20
>> No, that's not true. If I wrote the pl011 device with this workflow I'd =
just
>> waste time using meson. Part of the development is making sure the libra=
ry
>> type checks, compiles, using cargo to run style formatting, to check for
>> lints, perhaps run tests. Doing this only through meson is an unnecessary
>> complication.
>
> I don't see why it should waste time, when we ultimately end up calling
> the same underlying tools. We need to have a consistent experiance for
> developers working on QEMU, not have to use different tools for different
> parts of QEMU depending on whether a piece of code happens to be rust
> or C.

For example if I wanted to run rust-based unit tests (which I think
potentially offer an easier solution than qtest) I would expect that to
be done from the normal make/ninja targets.

>
>> To compile and run QEMU with a rust component, sure, you'd use meson.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


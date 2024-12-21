Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FAE7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP4tv-00012b-EA; Sat, 21 Dec 2024 14:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tP4tu-00012M-8S
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:12:34 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tP4ts-00075A-94
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:12:33 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso513319166b.2
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734808350; x=1735413150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u9qwtsXNo/JnvYxqV3MY2CeWlrbvpxo+1Tlwe+hBxk=;
 b=CNO8JVDwvRSPypwOm0jDwA6E2TWar5V59uDbqLk0SfI3J6/J8yydaKGXoAl6G59Cxx
 b/u2Z8aPTExfrV/A5V78XOZCc3nRAOzq4MvMYV7NquTFL9SOznmTUNAVbuDwzxQo4WM8
 jI5IN2YlZyWrQhB0THvojTpCpSbZpW7PkaO4omyKkfVqvgJokcgZjWa5Kt+qreE7lHSi
 aZhTTLzaTwampVJio4h1lYEAmyqyqDpPqpTKmJJlbHZQIEJtLWkXvLLv+Sz6ue5RpFjN
 FGDIYtJn+87DiKgpfHoD4HdT+KoPbbrXejpQgRBnlOCssvMg2ddVOf5sDDz/dX0TNxOW
 Zszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808350; x=1735413150;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7u9qwtsXNo/JnvYxqV3MY2CeWlrbvpxo+1Tlwe+hBxk=;
 b=WjBvZKSUE0rkHyB9kl1GIgRIzygoJTf8IUhEAJ4c5bTOB3haPqXz9MmOgKEONWUCBE
 UEqGvlifTjmr7qMjJzBX2h8RKSJCFz5ujm3npGrUTK4x4HMjQAoSLX0grDLYr4ktq8Oy
 73X6MpIDFnhKTRHsBbx2EUqzovZvH50+7I6yF4sbiH6wgn3ZlPGIlwyh9eLV+IAOAgZS
 1D5oCurpV+DUaQZa/5FR1+soLt9KA99MubRBsfGmfdGvQwJk79/FhGH1KQMSo2RMKz2/
 DvnnjPb2vQexaHQbs54r1Xd+c9AYDE6ehPoxcEjbWojRcu1AUkL1RiwcysqOt2CL+uj+
 W4ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCK+FCToS6SpgVt8NHOB5EVaezNlFJZqdu8rd50fKB0qKlhdGueOOXaeX0zbrrmiCdIdDjqMIm0Z3W@nongnu.org
X-Gm-Message-State: AOJu0YyFNIRgp/O//P42YwRHmKtfMFuNJaEYmluttJbSmnUsnVWpJXBc
 NCDa2GcCFxtjJl4UOiUDidYJj40xPG6OcDr/h8VGLmoJUoeDmI4A
X-Gm-Gg: ASbGncvJgMvlXTfZqufKhPMGq+v8AL+UNEPmYfzihsGtB4RW8FkRbXin8+W5Mk9PkEC
 xoN2N4QpAdWfhmIrIj+j3f0iB3gO24zTJtvBfbPOZ7V/4DM2d+csGwLVpPqxA+1ta7nfDOA3J4c
 83jYJ02gCRZMHskrQk71OOnDqPRSAcPaH7pkm8OQ0KE5wT1IrWA3WDxAocXmJRFz+1F3rMLWavu
 b5Uvvklu1z49/rkWRVdubKezYQZe8SHwW2C07O7Fx2fOop4py1ztkQ3r7ZjFDt0UsyohR1V2reH
 Aw1X7B9LXA8C6P3KRySa1JWusl1H
X-Google-Smtp-Source: AGHT+IE7RtayVfunI0SDwN8qe5ZhKl7E//HdCqyZcWCmCVFrQFtRj1xLDJr6JbPjHo7DqZ+rDOT8xg==
X-Received: by 2002:a17:907:60d5:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-aac33415e24mr620255466b.14.1734808349664; 
 Sat, 21 Dec 2024 11:12:29 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-221-009.78.54.pool.telefonica.de.
 [78.54.221.9]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89617bsm307483166b.76.2024.12.21.11.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:12:29 -0800 (PST)
Date: Sat, 21 Dec 2024 18:49:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 12/40] rust: build integration test for the qemu_api crate
In-Reply-To: <1132197a-17ab-4b70-ad70-c6a033e18647@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <20241104172721.180255-13-pbonzini@redhat.com>
 <A90FCF2F-C8D9-49B7-A881-B0F849AC11A0@gmail.com>
 <05747238-adac-4be1-b516-358a04aca803@redhat.com>
 <1132197a-17ab-4b70-ad70-c6a033e18647@redhat.com>
Message-ID: <5C20A676-F66F-40A7-ACD3-BEFAD3F43A75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 20=2E Dezember 2024 10:42:09 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>
>
>On Thu, Dec 19, 2024 at 12:22=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=
=2Ecom> wrote:
>>=20
>> On 12/19/24 10:53, Bernhard Beschow wrote:
>> >
>> >
>> > Am 4=2E November 2024 17:26:51 UTC schrieb Paolo Bonzini <pbonzini@re=
dhat=2Ecom>:
>> >> Adjust the integration test to compile with a subset of QEMU object
>> >> files, and make it actually create an object of the class it defines=
=2E
>> >>
>> >> Follow the Rust filesystem conventions, where tests go in tests/ if
>> >> they use the library in the same way any other code would=2E
>> >>
>> >> Reviewed-by: Junjie Mao <junjie=2Emao@hotmail=2Ecom>
>> >> Reviewed-by: Kevin Wolf <kwolf@redhat=2Ecom>
>> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>> >> ---
>> >> meson=2Ebuild                  | 10 ++++-
>> >> rust/qemu-api/meson=2Ebuild    | 26 ++++++++++--
>> >> rust/qemu-api/src/lib=2Ers     |  3 --
>> >> rust/qemu-api/src/tests=2Ers   | 49 ----------------------
>> >> rust/qemu-api/tests/tests=2Ers | 78 ++++++++++++++++++++++++++++++++=
++++
>> >> 5 files changed, 110 insertions(+), 56 deletions(-)
>> >> delete mode 100644 rust/qemu-api/src/tests=2Ers
>> >> create mode 100644 rust/qemu-api/tests/tests=2Ers
>> >
>> > When `--enable-modules` is passed to configure, this patch results in=
 numerous undefined symbols=2E
>>=20
>> Thanks for the report=2E=2E=2E This doesn't seem easy to fix without ad=
ding
>> more hacks on top, but I'll try to do it right=2E
>
>Which might very well be doing it in Meson=2E  One needs to teach Meson
>to add --start-group/--end-group options for rustc just like Meson does
>for the C compiler; or alternatively to support "objects: =2E=2E=2E" for
>Rust executables=2E
>
>For example, with https://github=2Ecom/mesonbuild/meson/pull/14026, the f=
ix
>is simply this:
>
>diff --git a/rust/qemu-api/meson=2Ebuild b/rust/qemu-api/meson=2Ebuild
>index 9425ba7100c=2E=2E0c08d2e51f5 100644
>--- a/rust/qemu-api/meson=2Ebuild
>+++ b/rust/qemu-api/meson=2Ebuild
>@@ -59,7 +59,8 @@ test('rust-qemu-api-integration',
>         rust_args: ['--test'],
>         install: false,
>         dependencies: [qemu_api, qemu_api_macros],
>-        link_whole: [rust_qemu_api_objs, libqemuutil]),
>+        link_with: libqemuutil,
>+        link_whole: [rust_qemu_api_objs]),
>     args: [
>         '--test', '--test-threads', '1',
>         '--format', 'pretty',
>
>Until then, --enable-modules is broken together with Rust=2E

Thanks for figuring this out! Your latest patches really motivated me to t=
ry out the Rust support=2E I especially liked the patch leveraging GATs for=
 storing metadata inside the type system which seems like idiomatic Rust to=
 me=2E Great work!

Best regards,
Bernhard

>
>Paolo
>


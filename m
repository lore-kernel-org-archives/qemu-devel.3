Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80358606A6D0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jNnbG2AC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUU9C-0005lF-GA; Fri, 20 Nov 2026 14:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUU9A-0005kq-BM
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:19:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUU97-0000kS-MR
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:19:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso892848f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795202380; x=1795807180; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ICVxdXPot9CJCxdxgy2S6ECrV9GF/v3y+P+NUPzqWXw=;
 b=jNnbG2AC501uIE9pa8vH840bVGEB5xhZMmj7VJH46lZYtel4hbfwjR+zjlb5VDjA9l
 mixfw1Iw36/iJ2evG6NgBuZIHgjZx0wf9Jybkevv3J+w9iPc4bJtHQ81TB7sARkeTj6B
 ND3lXdE0w3BjTInRtStEEuWPLZxGoMCFGClhXnUJRvWfxryWw0QtN8NhIvdQH20kRSzT
 jBaU5v9AcaEn2dRFSQfMkUwUrP+4B/jyIGnR8EYXKlbs/CVH03wGHw/0hSR6ZwOlXNtC
 R+r9nWHLUzdhrWp4ItSO55K9QifATcEX3sGzvhuFXvebDFDNP7n6tzpjinD7xdPVZBkX
 1Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202380; x=1795807180;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICVxdXPot9CJCxdxgy2S6ECrV9GF/v3y+P+NUPzqWXw=;
 b=2ggAcpIdgau0etsKkH7OhE3XK4k4zsJmLiN/li0VtZFKslv1bZWgZFeb2OkkpWX328
 d2es/KWQWQgP0nRGoQ6bznGJTJif6QDEjHHQH4SshJqUDsmHGvb1NpOM4bBwJTGv6u2L
 5g2HgdCp547kKtUIRsVdyv5Yug+boY33h9Zapc+YNUcjIcHXMnk0J2Z5dLnMb6EPQHJs
 qvlvNshh5egGfuQmtObEYtsemQKEC4j1wcGoaytWu5WMWCcjBbKslYQSlliO9UTnGSxJ
 bzeXvUSzqXkxL4mfowacoGgMO8LEVYXqcjkPrqe8ICyCD46j8hXsKklYo8e4c1mIAylr
 L3+w==
X-Gm-Message-State: APuU4Z8wUxDFIMDlGFtEaIrpMFwLvjkRi2+BL0QuxbUGo8hwx90MBLve
 rCMLQ1gY0oOywC7/T3E0sqvpKfyruaI/9mV59g20MR79KjM3C+WWHDb0habNpkm2UtpOPonEerC
 PrNC+
X-Gm-Gg: AZFdTZftdlBJzzi3DhGiM7FXDFAkJahHTzkp0hPLURPuHjCDGNwPLlNY+dUAi4PbNqP
 52VqBxkjcRzqy/+yTzi9EZT9p6oVAeEdoII8Nmv2tTBKFdbif7AP0QBofOo2vqsLvUqC76d6zHE
 zrjUAvDNQ/iZ7jBT+wfLWIW2pUoGPtbtFXDSUMoInmK0CUbGTYRA778VS27gZjdLNZiiirYW0g4
 39jK0CBgozJxY6P41VYWZ5L4eMaH70PXJwRCxMOASKifcrXaInbRBRHUKtXcuI2rHOceHuoD/3q
 oFFQzx4UjblB8dmPVapPkJvuf7fZpBMkVkKJrGiJJCA4YbQK8RDVWmDqKZnfeKBkjOuEqDqWdAy
 qrFO4ZlZ5LBK1CqXRPMJ5G3lB4yCDDS972jkg5+/kHEB6YwPFunlT5GtMO5/LZaX4Jd46ZQ6MV6
 iwnfCwyB7ruQGfFtRavsvjxzZsAkOQSbhJszaC652txvIw0iprOxfZwEURFLxJuWlL9OCUMigzx
 WwL8iLh8fiigvNw9cb2jN96NscVTLbI1Wc8efYjhBCNZ4ZGd+nZWRID0DlkOZxNONj7rW/DjuUI
 BjhKVrw3bFET0lvU1LoeZ11xj095
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id
 ffacd0b85a97d-4aa545e244fmr15638960f8f.7.1795202379763; 
 Fri, 20 Nov 2026 11:19:39 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm7459537f8f.6.2026.11.20.11.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:19:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 168655F7FE;
 Fri, 20 Nov 2026 19:19:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: update Daniel's entries to be consistent
In-Reply-To: <20261120182200.789086-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 20 Nov 2026 18:22:00 +0000")
References: <20261120182200.789086-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 19:19:37 +0000
Message-ID: <87se0v48fq.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> When testing my get_maintainers.py I was shocked to see:
>
>   =E2=9E=9C  ./scripts/get_maintainer.py --list-absent-maintainers-since =
"2 years ago"
>   Maintainer              Last Seen   Email(s)                        Sub=
systems
>   -----------------------------------------------------------------------=
-------
>   ...
>   Daniel P. Berrange      2024-06-10  berrange@redhat.com             QOM=
, QDev, Seccomp, Cryptography, Buffers, I/O Channels, User authorization, S=
ockets, File monitor, Functional testing framework, Build system architectu=
re, Meson, GIT submodules
>
> Which is of course incorrect but tripped up by the fact we have been
> utf-8 clean for some time. There are some entries that are correct so
> fix up the rest in solidarity with my fellow utf-8 using hackers ;-)

You can ignore this as I have found more, I'll include in the series I'm
about to send ;-)

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e2bd501f18e..031183706a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3748,7 +3748,7 @@ T: git https://github.com/kostyanf14/qemu.git qga-w=
in32
>=20=20
>  QOM
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Supported
>  F: docs/devel/qom.rst
>  F: include/qom/
> @@ -3763,7 +3763,7 @@ F: tests/qtest/qom-test.c
>=20=20
>  QDev
>  M: Paolo Bonzini <pbonzini@redhat.com>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Supported
>  F: docs/qdev-device-use.txt
>  F: hw/core/qdev*
> @@ -3996,14 +3996,14 @@ F: tests/qtest/dbus*
>  F: scripts/xml-preprocess*
>=20=20
>  Seccomp
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: system/qemu-seccomp.c
>  F: include/system/seccomp.h
>  F: tests/unit/test-seccomp.c
>=20=20
>  Cryptography
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Maintained
>  F: crypto/
>  F: include/crypto/
> @@ -4024,20 +4024,20 @@ F: include/qemu/coroutine*
>  F: tests/unit/test-coroutine.c
>=20=20
>  Buffers
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: util/buffer.c
>  F: include/qemu/buffer.h
>=20=20
>  I/O Channels
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Maintained
>  F: io/
>  F: include/io/
>  F: tests/unit/test-io-*
>=20=20
>  User authorization
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Maintained
>  F: authz/
>  F: qapi/authz.json
> @@ -4045,14 +4045,14 @@ F: include/authz/
>  F: tests/unit/test-authz-*
>=20=20
>  Sockets
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Maintained
>  F: include/qemu/sockets.h
>  F: util/qemu-sockets.c
>  F: qapi/sockets.json
>=20=20
>  File monitor
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: util/filemonitor*.c
>  F: include/qemu/filemonitor.h
> @@ -4190,7 +4190,7 @@ F: docs/specs/fsi.rst
>  F: tests/qtest/aspeed_fsi-test.c
>=20=20
>  Firmware schema specifications
> -R: Daniel P. Berrange <berrange@redhat.com>
> +R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  R: Kashyap Chamarthy <kchamart@redhat.com>
>  S: Orphan
>  F: docs/interop/firmware.json
> @@ -4691,7 +4691,7 @@ F: tests/vm/freebsd
>  Functional testing framework
>  M: Thomas Huth <th.huth+qemu@posteo.eu>
>  R: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/testing/functional.rst
>  F: scripts/clean_functional_cache.py
> @@ -4723,7 +4723,7 @@ F: .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml
>  Documentation
>  -------------
>  Build system architecture
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: docs/devel/build-system.rst
>=20=20
> @@ -4753,7 +4753,7 @@ Build System
>  Meson
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  R: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +R: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Maintained
>  F: meson.build
> @@ -4785,7 +4785,7 @@ F: hw/*/Kconfig*
>  F: target/*/Kconfig*
>=20=20
>  GIT submodules
> -M: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>  S: Odd Fixes
>  F: scripts/git-submodule.sh

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F7C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetue-0000dT-PA; Thu, 24 Jul 2025 07:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetuc-0000W0-Ez
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:14:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetua-0004vM-OP
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:14:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so1895693a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355694; x=1753960494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Drum6qJTdpgtrrmdh/2Ucfswie7lSiFugC5lvWpzULY=;
 b=RXV9xEoaHemIUfXwARP8q3MOntlhbzqe93GwZcHNq3JYVIn4eQeEMO1uY1erzamYs7
 ElO33PP0rCKLL8GwUYG69/gKpXh37/LlakH+4mIhC0UJoyTdV+ORM9vlzQftymVONM2V
 Gp4ZX2Hsvv4DAxg8+x6ee+W/4DCETzOqr/+GWIqKYYDM33D58qXn4k117vbXbFI2IXEY
 VuzHH4hug57MsMhpv95egkeBULdn4MkQEAs3fiB1JCr0/ekNmHICLwvnxhn3HlXknclF
 TRUCQcoMie7I3HTq6hqnsq92dYh/shZs2dwLYgAc83mqiG4UbjDrLFdgeZBhNzD9i1Ja
 wNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355694; x=1753960494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Drum6qJTdpgtrrmdh/2Ucfswie7lSiFugC5lvWpzULY=;
 b=gdQnSRs/kghp19yWw2PxQ/9r84V1XAzDyNvzbR0ja6Je7P3n+JYtgfX204EUH/ySXk
 RUB4F+LkRi3k0ii9uFYEJM6UhJ490AtIq+YzTCTfR4EEagRZQoxnwJsFrXHc2ZX++HMk
 5L7LSgKvJZ59KmqdyEGDnEzAfOU2biDF03oVpTddEyHj2SebkyMy/nx1gB20fldDU5E8
 AFg4RIKIxmgCh5MyhoxlfyJrftgX7L+XLcrjqIReltuIvMJGTqMYF7Z8c6eaL20Z5yi1
 wwPdsfGuFUgwuNmmQvFztUQFmdJUWIWZgOEZbUIpyiU0l0xHmH0J24O9EcQiQ9cQ8Ur3
 nelA==
X-Gm-Message-State: AOJu0YxqvjKOq0QdbRwhitBl8YEqK2aF4ScE2qmBC1g4MSQrQW8lUWBA
 9fpjsN+HtDHkj/U7D7Z0bWLMDeujU3mqFMECdWZ2oStwhyIb43PizAb+Xoel48iiF5Ue0gNV/ee
 MfFhtHZSyPXhbV3bmThkMCmtg71IvkEHhC54FxkZloQ==
X-Gm-Gg: ASbGncuxVlOR5gujoOrb8k2z7K0L3jBuREo67tIFKeWyYMALB/XbB/LsHLa6dReVyee
 dRGNMkVwewPwYYBVOY1Hf6YogPmIxhdHvUxfIaXDz+VZup0NUdPrqIIZwre/HEh6Hbu2RGE7TBR
 0aZ5nkGbc1x8wwMT8diI5GXQNDznK1le+oBIWTjesS53oZ3nP7RBN/TDBcwDeVK2DfH6MOZDUGT
 MfBlA==
X-Google-Smtp-Source: AGHT+IF/7vAOGy920bNbpZutkcvA/EE+QW5IylWdaQp+Yf86WnXmzJydO8ZsURD+M53ciVEnV2bXFUInEq5tm1D7s08=
X-Received: by 2002:a05:6402:51c8:b0:605:878:3553 with SMTP id
 4fb4d7f45d1cf-6149b586a40mr5937269a12.16.1753355694467; Thu, 24 Jul 2025
 04:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-8-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-8-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:14:27 +0300
X-Gm-Features: Ac12FXzgO0qHuNOK9zohX0h-kqAsSikmVjz1ys77lD_ooFlOT05ozR8BVt_uTkk
Message-ID: <CAAjaMXZXLM6+A8T7UvF5MxZZ9QJ=pGM_Hyd0fQnGr2neWoB7tA@mail.gmail.com>
Subject: Re: [PATCH for 10.1 07/13] tests/tcg: skip libsyscall.so on softmmu
 tests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> It isn't testing anything and just expanding the runtime of testing.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index af68f11664f..3d96182a7b9 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -155,6 +155,12 @@ VPATH+=3D$(PLUGIN_LIB)
>  # For example, libpatch.so only needs to run against the arch-specific p=
atch
>  # target test, so we explicitly run it in the arch-specific Makefile.
>  DISABLE_PLUGINS=3Dlibpatch.so
> +
> +# Likewise don't bother with the syscall plugin for softmmu
> +ifneq ($(filter %-softmmu, $(TARGET)),)
> +DISABLE_PLUGINS +=3D libsyscall.so
> +endif
> +
>  PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
>         $(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))=
)
>
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


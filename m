Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E79C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRYY-00054t-Fa; Mon, 10 Feb 2025 06:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1thRYW-00054Q-3M
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:02:25 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1thRYU-0008Hl-CR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:02:23 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f4a4fbb35so52011885ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739185340; x=1739790140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fiz6axiSFPIspdOvXfoo+eDbAMVu0wYsqw1pk0MX0bA=;
 b=U8bz7E5hIrquHxff0QLG6pYjyTbj8KbXGSUaiE2BtuYOVoywyWKT/DSCEyKQH7fccm
 EoG9e4Q9R6sUMj4czCg3nNNWcpgrdm9wrdoJLVvqVSsrRGedEXAgRi7CrX0aEjAXhxaG
 H2E3DSgotRs5zLP6tYicKIFLucXm4lWbO6GM3QT4Vv44cCbTGuWxTC+LMEUTvtacYJpv
 jWQAFL/bW6YICNumjxFvim4mEPbuKyHGcv6R2XV4GzxbO39jKpf4mm1VIRt/LpWKkaEk
 AaQl4iZi+ZONxsHovhYt+LxMT5y27HsrnpR28BJwjUKTxd0E5IyqJP1knF8ve1nBppq5
 yJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185340; x=1739790140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fiz6axiSFPIspdOvXfoo+eDbAMVu0wYsqw1pk0MX0bA=;
 b=wD9Z81tpq7K7muKTfvuOXdCDKzPxuRWhcgRGOFSIPrrvrO0TFZqm0rpqVHz8UPUSyb
 h5UXDmLMsp0/5yscgRLApVGQ82qCpPJ9+j7rGms8vtfCFlgdFcxWsToaqotxmPe3Pi/Y
 1VneHa1hj79n8Dq6co6H1JrPMRAxa7FBRRlUgm4DAk5nwW7YipXxZ4cav6XINc4fx3KM
 O2EHRGWBECMqePoah63VB6fmT7QmHzgRjBfN5WwQOYE2YDDHWmh8tcI2uoFus8bApqv8
 8hVAWAMQpoZlG6H0DrZ6OAQayeu+h5ct9/Ex8wOIxaVfEeyPJGHt9lhznCJV2fAQeH7X
 fWjg==
X-Gm-Message-State: AOJu0Yx3kAw8fWk5D9noVbdH94+ZvwCeDXg+ncDiIJVQMUs/oMhx2lW2
 zKQcK5FCC96f/oqyC6iTz4nSmKqotlT2PYCAxDYcodICJU6aHnOZZ+f4W9npBsiJgWP7thZuAUn
 A7tzDeAkfn8mU0d47nOU3oCkyjyM=
X-Gm-Gg: ASbGnct/ix/xOZYqwQ00qqKTE15d8fYMrNfxPVgYYcC7KPkbLlqFfPYZg+B4/1tXeaV
 V1h/z0HsbtPvCp3ZBu19ufaOCKsd7w7yigNlC8ntAB0Aa6Pt+9HSx2g9XytJ6Wpr6r4AsY+l7Ka
 get7si5eZHoKx7RXb7B4vR/e0Nx64K
X-Google-Smtp-Source: AGHT+IGAVOPwjopteDVzDyZpMQYTH/eHNy/RwmTzM2AnNtlAkICRdbCyqMxEI3hcRdn9UASPMyeLXMUFdKLL0Pbecq4=
X-Received: by 2002:a17:902:fc84:b0:21f:81cf:454a with SMTP id
 d9443c01a7336-21f81cf4676mr88162855ad.22.1739185340094; Mon, 10 Feb 2025
 03:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20250210102604.34284-1-philmd@linaro.org>
 <20250210102604.34284-4-philmd@linaro.org>
In-Reply-To: <20250210102604.34284-4-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 10 Feb 2025 03:02:09 -0800
X-Gm-Features: AWEUYZnMMj_Uv5BxArIcWqv5Q9sPj7MyMiac8wcOpOPaSqg7Qm2V6NLsvBWD8dI
Message-ID: <CAMo8BfJd1LkBqZpEsDjCKpZLJBC4xK3f8-79rs4Yp52z8YpODQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] target/xtensa: Finalize config in
 xtensa_register_core()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 10, 2025 at 2:26=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Only modify XtensaConfig within xtensa_register_core(),
> when the class is registered, not when it is initialized.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/helper.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 2978c471c1f..c4735989714 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, v=
oid *data)
>  {
>      CPUClass *cc =3D CPU_CLASS(oc);
>      XtensaCPUClass *xcc =3D XTENSA_CPU_CLASS(oc);
> -    XtensaConfig *config =3D data;
> +    const XtensaConfig *config =3D data;
>
> -    xtensa_finalize_config(config);

It was here to only do potentially expensive finalization once for the
actually used core, but I guess there's nothing that expensive there.

>      xcc->config =3D config;
>
>      /*
> @@ -189,12 +188,15 @@ static void xtensa_core_class_init(ObjectClass *oc,=
 void *data)
>
>  void xtensa_register_core(XtensaConfigList *node)
>  {
> +    XtensaConfig *config =3D g_memdup2(node->config, sizeof(config));

The structures pointed to by the node->config are not const, I'm not sure
why the pointer is const. I'd say that rather than making a copy here the
XtensaConfigList should lose the const qualifier in the config definition.

>      TypeInfo type =3D {
>          .parent =3D TYPE_XTENSA_CPU,
>          .class_init =3D xtensa_core_class_init,
> -        .class_data =3D (void *)node->config,
> +        .class_data =3D config,
>      };
>
> +    xtensa_finalize_config(config);
> +
>      node->next =3D xtensa_cores;
>      xtensa_cores =3D node;
>      type.name =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->conf=
ig->name);

--=20
Thanks.
-- Max


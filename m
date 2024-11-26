Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE3D65559
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG3B8-0007RM-J7; Tue, 26 Nov 2024 16:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG36w-0002J2-EN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:28:42 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tG36u-0004s9-Mc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:28:42 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so378457a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732656519; x=1733261319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eu/52GZcECNuZxxjAb33YtGkeMmnYt1bCtM/EN0TjVk=;
 b=f8H11EZfbZOus2Jl+8hum9H9D7tjTWvk3WsrRI+0JNSFdLg8di/154T1U6GpyeFMSE
 4VXZBKaiw0fZUz4kBdU8C3SjhRLa/uQn2+XwVv/eFewCrAaOhQMjcDsNQFx99/J+gzvp
 m4N8I2LeeGCPzleHserTx3bwzQEBClZtHM66jHm0HXUjtBSWvOLdH/pHg2X3VEYge8WT
 RBD3idj16N2rYphAwndMZesBH9taN7Z4vgO0nnwwkMoBXvoXZlr5EfWAXqQA/1rMlqVR
 KQRQr+c8Qo183KRcn6HnqM82CFGNIgbXXS/lqVFHB2njmSvPc84GMr+XhxNfFV2KSIRg
 +0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732656519; x=1733261319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eu/52GZcECNuZxxjAb33YtGkeMmnYt1bCtM/EN0TjVk=;
 b=jeyqr2STya/i1sjnReUNoQCgqt8nYhWkEKqu1I/5k1gwYCEMF6zZ7br1E2tC0WQVEi
 cRpsJdm+pHIa3xBfTIAtgkSifZXfe1vDcF4xCNUNs9IM2d2POIKE0ff4zwBuAa0A1GEw
 1T5xAaB3aTuB+RKSJsU7Sqc+tlIREQjuKp7sw3WlNk9bjqmnaOUvgJ/TmNmLl5/7gg5Y
 dfIqdYbGDZQT2PvuVOsNk8BzhXZeYmEwlY1zGlxhfRNF69TFPihVzmKbj162CT5ecN3f
 O+w3uROx09ymctybcAZS4NhuznbWJ1kXfsOfGXDnlD+PYxFAPWamMQ419/fKYuZxPDL/
 /Spg==
X-Gm-Message-State: AOJu0Yw5sjolPM95a4MWh7cvik6QOgbJSRsR//+6GfSn8ep9Imb/jeuA
 rsrFgxsUCzucFP4biCHaflKa2sw+pjNBr+xJfAqEDq6ayJVM5duEG/h8ex7nJ4RrO6Mvd/uFYuI
 fmlE3gWkwLB5ytHAy+iWyXK6QlPrhet1ak9wmSQ==
X-Gm-Gg: ASbGncuzAiMLkziTR8aLLrXAjdtPvRzzyEa1I5+HhtqMaRZujNWXJLr1sCHKvZGYRPV
 TC1zYGhzxSD04yBow/Ga7tvyQes+Zjj/P
X-Google-Smtp-Source: AGHT+IHswj/gVRg7l3/Tf7MB111fi5cKRTe/iRORjs9h0ll51mhUUsLon6fEKcuFjMpu7JmF8nY277Xq1tPE4ZfjJ7o=
X-Received: by 2002:aa7:d417:0:b0:5d0:8357:9f8f with SMTP id
 4fb4d7f45d1cf-5d083579fd9mr38203a12.8.1732656518804; Tue, 26 Nov 2024
 13:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20241126211736.122285-3-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 21:28:27 +0000
Message-ID: <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 26 Nov 2024 at 21:18, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/devel/style.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b500798..13cb1ef626b 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -416,6 +416,16 @@ definitions instead of typedefs in headers and function prototypes; this
>  avoids problems with duplicated typedefs and reduces the need to include
>  headers from other headers.
>
> +Bitfields
> +---------
> +
> +C bitfields can be a cause of non-portability issues, especially under windows
> +where `MSVC has a different way to layout them than gcc

"to lay them out"

> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_.

We should mention also that the layout is different on big and
little endian hosts.

> +For this reason, we disallow usage of bitfields in packed structures.

maybe add "and in any structures which are supposed to exactly
match a specific layout in guest memory" ?

> +For general usage, using bitfields should be proven to add significant benefits
> +regarding memory usage or usability.

Maybe phrase this as

 We also suggest avoiding bitfields even in structures where
 the exact layout does not matter, unless you can show that
 they provide a significant memory usage or usability benefit.

?

> +
>  Reserved namespaces in C and POSIX
>  ----------------------------------
>
> --
> 2.39.5

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB780CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FZ3-000637-Oh; Fri, 10 Oct 2025 12:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7FZ1-00061f-OT
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:01:51 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7FYi-0006Rs-Dq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:01:51 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63b960a0a2bso2598646d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760112089; x=1760716889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/zrwMqwnGoIBMwOTdIl9Y6UlOgW0fzMIZl0yJFBeZg=;
 b=kVnUqzwEWw6oyIWIKz57zSAGnEaW3IvsHYfBW8aTxuOCkItshdI8TzLuoLFsRXfVTO
 QQuxXtWMTfmfdO5Xncza9rLa15oAm5CsZ3fLPeSjEabKGTse+5tg1XyxyBY51E6CeONG
 LiZ0AF92LqFHpp74LpmXhNjcw25dSp1gZEg9OiqlBkPm+LYkFtq7PsZR95ozjkzlOw4W
 LavY2gR8rysuPCCwXQs81ksNGW+7zhbOglhRPfJ+dmaQ1S9xr+2BmZ7dwvmJkBYaSQd0
 TFZ6Zv+TBAkW3z2iiN5J7xvQskrUCHxqN1vqzqB0d5RoFrc5f8as79Kqay+lPf8dXeYq
 YZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112089; x=1760716889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/zrwMqwnGoIBMwOTdIl9Y6UlOgW0fzMIZl0yJFBeZg=;
 b=mtTVnaolXK1fD0DRUO9k6tE8x7BUlIatVSRnf8LmFfP+ZEgLFzRoFNoTyL9Wtip9rr
 0KoKqBPi74LMUU41nibcAcKUJ7wPqr7aCc6XQ6asTvT1pKSKxDQYaihm5b/Wi5OesIpt
 uISZ+TRXFcjcLyv+yOtD/06ZoV7WYBW+5wKQXpghm/oBhOQyWXkSf5YTBmrczQrW3kWU
 dgQrg1eYAIZDJZEncEvCNawuE1ZU4fGdhtHIojuI/C9v8HCDrBqrDxZT1ZEV6xfqFz8N
 QyphrEse2U0uybS4IuG81Ceq7o0CrW0dAI8ae6KPG1gbgfCbCXxVQWAMBj6IpWT3+9x7
 r6yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6u9L21H7F10b1yKyU8wvSfDO6bGimgDOw7gIDDcqyDS8M/Hd1JSSOf+DSzMOQAQIm8KnqIt1Gj6cB@nongnu.org
X-Gm-Message-State: AOJu0YzYr/P4pE3InUFx6sqHowkRhT4nP3Yi1ccf5GPLqFMHhY6S22aE
 HiaKP7ILIw8+K33ShvpNeuGr7CS9b4a6oSsSd1iOMni13ipPC6iopKrZswtJ5AIXDZN270OhPN2
 lAaVveWPVSPdX4N9uUnV2LnI3VnCW86ttgLbv1XnO5w==
X-Gm-Gg: ASbGncsFX9nECu2WpFLFW4hCgXF/6c5KPbVoe43IYgrX5Ra5ledCUjaQwzlglXTFUhs
 zZ0GZIFPIu1GdHP6qt/1v9BP1fKXaEH7A9sT6qB6+OsfgxWvBPvtXWSFmp6Tscjt7xwCUlEt9x3
 buVm/w1mrrnXLqSJ0DyXdGd5cDhS7Z/5HNpccV0XMzxZ/BxKxP9xSYAb9d4R0sU95qnwDr9fR5X
 IfYPSAbCq6B8Je6zm0JtR6luWcNxwE=
X-Google-Smtp-Source: AGHT+IHeqMSrWwUaz2rExiFGqKxJ2V5iIAhzCXVvP+r/KSmEFgKAdvWAWUaOfOOoSjd0QztR6/+Z809gm8bQaWPNgSQ=
X-Received: by 2002:a53:cec2:0:b0:62a:b545:54b6 with SMTP id
 956f58d0204a3-63ccb8f2f76mr8689088d50.35.1760112088920; Fri, 10 Oct 2025
 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251008191716.3005164-1-daan.j.demeyer@gmail.com>
 <CAFEAcA-iQkqxR5jPtGC1EAtcH4FYD5y71x6RFSWC3vP05krScw@mail.gmail.com>
 <87sefrvuq5.fsf@draig.linaro.org>
 <CAFEAcA_hv0fMyJ7WQks8SA5Af7xVvTo3gjKNM4QBFCMWAH=2DA@mail.gmail.com>
In-Reply-To: <CAFEAcA_hv0fMyJ7WQks8SA5Af7xVvTo3gjKNM4QBFCMWAH=2DA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Oct 2025 17:01:17 +0100
X-Gm-Features: AS18NWCqm1KODDwsvTP6S4yqeX7WnaDCiPH0IfYnESN5oZ9lO1tHqQk8rvVBkXY
Message-ID: <CAFEAcA_-dT6Gf0VDczU-OYt3wi-bXLYeLD54Aipb7jah8-XwJA@mail.gmail.com>
Subject: Re: [PATCH] Add support for zboot images compressed with zstd
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 10 Oct 2025 at 13:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Fri, 10 Oct 2025 at 12:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Wed, 8 Oct 2025 at 20:17, Daan De Meyer <daan.j.demeyer@gmail.com>=
 wrote:
> > >> +    } else {
> > >> +        fprintf(stderr,
> > >> +                "unable to handle EFI zboot image with \"%.*s\" com=
pression\n",
> > >> +                (int)sizeof(header->compression_type) - 1,
> > >> +                header->compression_type);
> > >> +        return -1;
> > >
> > > Moving the "unrecognized compression type" error path down to
> > > here means that we have moved it below the g_malloc() of the
> > > data buffer, so we now need to g_free() to avoid a leak.
> >
> > Could we not declare:
> >
> >       g_autofree uint8_t *data =3D NULL;
> >
> > and drop the cleanup?
>
> You could, if you wanted to, convert the file to g_autofree, yes.

Whoops -- I meant "convert the function" here; I wasn't
trying to suggest doing the whole file (which is probably
a bad idea).

-- PMM


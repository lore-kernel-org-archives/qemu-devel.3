Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCCD0E6DE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 13:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNsst-0003Dg-0X; Tue, 25 Nov 2025 08:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNssa-00036F-1c
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:14:51 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNssX-0008GD-8T
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:14:46 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-787da30c53dso53153967b3.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 05:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764076483; x=1764681283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9om/1IZBTQDAM8LTU3fsdFTbV0qam63CKxUQl5PdHwI=;
 b=iDF7X5lGCNVmwJFz05FIYw0cZG3JwbE9kzc8jJYZcctMa4MZXppX/KkA2vKWbzXyU5
 W1rlb8XwsrQoTlfwwD4fCAMlr2qZ65Es/uh+joAmazaHlrPHrnysKZD4ZkkD281Ldffz
 /GVMDvm2RRcdDnltvMxw4L4nCNB+qU8kzVs+QMgkAocpmHsf+cFYyatbL5cZT6gj/DUS
 BZsxA0Xdc3xcXSygEoDAufhcs+Wjn961mocSqE+sl3ctg5BUhGJdSFq6zuEcIIDa3jA+
 3zVKS0ODi4mULbE25Y5L68zu5gjQcvFKQWlpK2C36kyTn28z9CuNMV9l+UZY0sg4YEFJ
 SMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764076483; x=1764681283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9om/1IZBTQDAM8LTU3fsdFTbV0qam63CKxUQl5PdHwI=;
 b=KFGrv7PliL9PI0f8P/K9aH4bJ1cX8f5581rtWvG9EG9Vu8nofA2vP4M+Mhg+HeQLL8
 Twf018hnWSvdSG/BiyenBe83UhbWotr4Xw6MYbPAWb2sTgPyCp6gQUnZbCS2hfuM+ZO7
 uQ4h8THLa0OCV9Ll8t6uuF6zyvlsmTIoL5OID/eV5IHWHaTK6uyGTRVJAMvl6iaa9qp8
 XKM8dj2GOSD0d8biAl7AYhRkzdnaMMGxa5t0kdt+lFxitERPV/SBcBjRCCWXqRPiUl50
 s2TaU8IPZq1MKcwePzZ66hxmoqfoOgoaE3B0JTr2MaCHfWxFHlNj2Zh6Dgl6bHvC63Lg
 CvDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCQGBPj80mVKcmm19/3E0jtoEtAD8iPmJ5U/xsqKf1OntdDdWLH1cjgLPlM91/86Poz88Zxe+wnqjn@nongnu.org
X-Gm-Message-State: AOJu0YxiHdUat7qd19Wx4AqRaVa4/jHfg3/5QdH7ec4xfAZzyObEX1A7
 lGXHhHeOrMWe5lJVicY8lxM4Ye+28JUjMQRElpN3260VoGn3l/G4YghJ4C0+DzTL2c+3WfeUu+l
 nDJktDp4+Dp9MSxpsusCncVfegIA4odOIcno5R9wr2dTkNNcHVQn7uhs=
X-Gm-Gg: ASbGncv6QJbvtIyVf4W1IGUIPJou7W1aZa7doqQ5RWYS7QubvOaApsDaKvaWf21JOf1
 +IkKUojgfXhImzQzWTqZPv4S0ayI5Hp3UlKC2t649pboMe65zRVg180m6td4CYfCvUlBiOjNnyo
 GSc2B4BwqVwC+Qqb4Wc2VwspvVmgy6GRydnlJGK1uftL8Vkx2+hFygcUxP8jzeKLu2GIPdZQ5DC
 kvrBCmbmPC9GOME6WBIKTEPX6KYI7G4scQAS+20xQTetHG+vM1bwEJuRQ==
X-Google-Smtp-Source: AGHT+IFuWdAwyWUQzQxs+OckcqcWQOnaVakQ2FdvgOlYcVO+TVH1xKJM6yCmrec4nZqIXwqkzlXYxjdHyXCKGQLodL4=
X-Received: by 2002:a05:690c:c18:b0:786:98d8:c1c7 with SMTP id
 00721157ae682-78a8b4916e3mr125614077b3.18.1764076482998; Tue, 25 Nov 2025
 05:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20251125103859.1449760-1-Moritz.Haase@bmw.de>
 <aSWe0_oaclL83ovL@redhat.com>
In-Reply-To: <aSWe0_oaclL83ovL@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Nov 2025 13:14:23 +0000
X-Gm-Features: AWmQ_blKuwUiLKr4kfY06eyNf4NH614mfRiYkFowUpjaBj21HjatRUsH0qJ7jlU
Message-ID: <CAFEAcA9M4jpWnUuPuz8AxnSuPn2go3yL5eKBdzNd6UawXTaD8Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user: add option to intercept execve() syscalls
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Moritz Haase <Moritz.Haase@bmw.de>, qemu-devel@nongnu.org,
 petrosagg@resin.io, 
 nghiant2710@gmail.com, forumi0721@gmail.com, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 25 Nov 2025 at 12:20, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Nov 25, 2025 at 11:38:59AM +0100, Moritz Haase wrote:
> > +        if (i_arg) {
> > +            new_argv =3D g_alloca(sizeof(void *));
> > +            new_argv[0] =3D i_arg;
>
> FYI, use of g_alloca() is no longer permitted in QEMU code.
>
> I thought we blocked that with -Walloca, but it seems we do not.
> We ought to fix that gap.

We don't because we haven't yet eradicated all existing uses
of alloca type functions. We did that for the system emulation
code, but didn't find a way to add the -Walloca warning only
for the non-linux-user code:

https://lore.kernel.org/qemu-devel/20250901132626.28639-1-philmd@linaro.org=
/

There are still a handful of alloca() calls in linux-user/
and bsd-user/ which ideally we would convert but which haven't
been very high priority to clean up (because a linux user
guest can scribble all over QEMU memory anyway if it likes,
so being able to overrun the stack by passing a large value
into an alloca size doesn't let it do anything it couldn't
do by other means).

thanks
-- PMM


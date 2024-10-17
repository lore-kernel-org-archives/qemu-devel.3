Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4201BD37491
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Qtx-0004Wz-8H; Thu, 17 Oct 2024 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Qtv-0004We-2d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:50:51 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Qtt-0007ln-KA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 09:50:50 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb49510250so9916631fa.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729173047; x=1729777847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zYk6tB+YibjJ9nXCG2r36SrD1pGwrQpBNG6tqoH5d4=;
 b=icShNMJKTDGR4LeHbtlfCARh4jk9lN3IcUnT8InrZ6VtjacUxE6FjlEAG3a+csXul1
 ffCKKd/Z+93p3ebukvhuu0jtGMu242d0ekeb3OtrU3Uhkgn5VcMK0lpCf69M+yZSkRmh
 K8H4eDeZlFh9bwUL2LAKO6eqErS/t8M3J7NvrzqE/+MI+rCwdUbuheS0sOS5gbQnrJKe
 y7FypQStvS9kIi8+KLpLtf7zvJLrOEM6ED7ttklmZjNDziELyMO1fwGNUyrgf62oKfpb
 5RJ00702csSMayI28+E1GXWhwFiiNmJl5IcYJrHkqvN8otrvi+14x9dN+3K6fFLmfX9e
 fLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729173047; x=1729777847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zYk6tB+YibjJ9nXCG2r36SrD1pGwrQpBNG6tqoH5d4=;
 b=MDz7sCq31C2UbxQ7zYTTUA7oH2QDUxgFOB1heFlfwlcth6NRxTpVbawU9EIV250uRe
 smlPs8OWxnah+frBzzMbMXJt7Vw7t1OqTXEJaopx58SenH+YohXTq1Ha4MhiAvnxW0DY
 Om6MMoawh5SGm7LD+c9MfXaZevhBZauSsRtnsTrjB5MqocQ2krWBD0tY9iujOpEQSb9K
 tc9c0d3zjkI/fKErBnMlvAgbQnme8flw5CIg8N1AihxVQHwpvCEnZqU8sCVFFAYTGDWa
 fwe5OzQ1gIKs1nuunqqwwmnFXcqTjvYidGN4REqHf7blCvmjlHc+4QI+QOTpl/cEhkEO
 iG4A==
X-Gm-Message-State: AOJu0YwFRJb6LEr1NpqXIfMf8oWXUXvvtv4i958DSUa1VBHQ8I+HHwbq
 PTjmvUfXmcnuKpsK2vutLtcROlG6tOdBCsLKsN79Xo+1mHbiS0w6gX6m3zdZWu+AvpRLR26oQaR
 NutAnteUxAKRYsAUBxrHSwM/IL6XMWxMJ
X-Google-Smtp-Source: AGHT+IHIyHzRc07N740cjDuLIJ+1IH7/q+rNA+8TsL7PqME96hnZTDTlN2Rb58osovKcQHeKlaJqoXWm4INGuFHPocQ=
X-Received: by 2002:a2e:b88d:0:b0:2fb:5a7e:5046 with SMTP id
 38308e7fff4ca-2fb5a7e5310mr60924871fa.9.1729173047172; Thu, 17 Oct 2024
 06:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-8-r.peniaev@gmail.com>
 <CAMxuvaz9_7JBGqsJHZO0zuvrdO20oDef2v=6TSy345byzkm1Tw@mail.gmail.com>
In-Reply-To: <CAMxuvaz9_7JBGqsJHZO0zuvrdO20oDef2v=6TSy345byzkm1Tw@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 17 Oct 2024 15:48:39 +0200
Message-ID: <CACZ9PQVYD8zen8KAOJ-+BebWRKSFwmFn42h2uDofog1LkrcHog@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] tests/unit/test-char: add unit test for the
 `mux-be` multiplexer
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x233.google.com
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

Hi Marc-Andr=C3=A9,

On Wed, Oct 16, 2024 at 1:36=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Wed, Oct 16, 2024 at 2:28=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
> > The test is trivial: several backends, 1 `mux-be`, 1 frontend
> > do the buffer write and read. Pipe is used for EAGAIN verification.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  tests/unit/test-char.c | 306 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 304 insertions(+), 2 deletions(-)
>
> please fix the few leaks (found with --enable-asan)

Did not know about this option. Should be easy, thanks.

--
Roman


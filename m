Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB7C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trd2C-00081k-Tj; Mon, 10 Mar 2025 09:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trd2A-00080z-SC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:19:06 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trd29-0005jK-0W
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:19:06 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e62d132a6a7so2951109276.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741612744; x=1742217544; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArgtExDxcbtwFpD5mwnsk3FsHZ3wX7yn1nOl+Lc2Qqo=;
 b=YZ1Y566BO6mPs82iGbWiVPgF51vdUR1IkKlwJ6sl4bBgmabVU8UG/djMD6dCrGx9NR
 47318pWBkpEElnCLZxOU5qEyCZQdUJXFPJ8A2HCAqioDBAsIlLDBbKq3aUZN7hN9M8vC
 Xeo2uheXVbq80pXrZOyD5riVXqZZELXOWmv/lk9lf75jdn+T11W+0LgCjaT9xmuY6z2B
 tzqum9CVrU/zeHjr8q2EqJvW5wJmz55X91ZnrPJTpuuWnWlETcRuqujLhyCRtvxV/bxl
 8JAwBQzs+vJjixO3rGkTQ/rdIsoEOp9Pa71sTnt5J+MS127YcO9gJp8Ukp3SiC05OIOt
 OWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741612744; x=1742217544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArgtExDxcbtwFpD5mwnsk3FsHZ3wX7yn1nOl+Lc2Qqo=;
 b=Koxqdk1e0OxM7+Bwe0DVsa07wfRDJdvg+QCdDJwTht332fZG1MJw5OOzG/QF8V7Ug2
 rAEJ+6napLKdvsjF92EGTO88Dcyz3wYpKO3OBmyyTBpGMGR5qSI6WIYsMjWAC6LcvvXU
 zUao13GLv2xl8WETHGX1/3vT7CxtQTCdcbS0k9JrlxuleuNIV75BFI23hzgczLA3QTzw
 QJxzJY4OmYR+wxlmlZFCDNr5dT9iJmrRT5Z5ytq2qMKnKTHT7uHKOy0ol2OidWDVTo/c
 7ZmpR5OflIQcbJDQdJ0wVQO/eQMoVy0GvcdnuS/Tnb1Tilsd+l6ZT8I76JlcQzRT9vK9
 760g==
X-Gm-Message-State: AOJu0YzUcW9WKix+vwb7mu2Y8s6jGwibQW1dFz3Qm/CUJEKYyxy9IlrO
 RZon3zTT77OCm2yf2RtzVsDY277pEnhNMhlHC6lG77dQ5Wvf266IU7eYl9APJMJJkoVWRuUxheu
 o3Io0EKRLF2XPYos7ZJ0QQKBCGXOcJG4eqOonMg==
X-Gm-Gg: ASbGncuXWazerNMFN0Oup96GZgJuhifxM+6l5NA5b5Sfs0NvxyJZoF/2jtxPKfLJlMx
 r8FGrJEa2wD+DESV3f3542IOjTC1uXGrfJfvOvVvYJ+O+jrUu1rgJ/RqR+o1/yxcfOe4+KLT8AI
 LATuXD+Vjxu1nDxFyhH43f7FbZDVI=
X-Google-Smtp-Source: AGHT+IE+O+n/3q7oQbzX0TFCIeQQRE9Ns6X7fMw44EqqoEfk+Vm5gi1Vr3yE/XiCXWhjMnVxk7PmYRkUZfkkt3vgz+0=
X-Received: by 2002:a05:6902:e0e:b0:e60:9821:3a with SMTP id
 3f1490d57ef6-e635c101784mr18328853276.6.1741612743734; Mon, 10 Mar 2025
 06:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250310102950.3752908-1-peter.maydell@linaro.org>
 <4842ddd6-acae-457d-8310-d2463773ee1b@linaro.org>
In-Reply-To: <4842ddd6-acae-457d-8310-d2463773ee1b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 13:18:52 +0000
X-Gm-Features: AQ5f1JrQ4zg4u5lf-v8rjFn8XOkS47NSNpC6KsitYhV5RGySlVy_M9Z6lKHCACw
Message-ID: <CAFEAcA8-AMhHuZXxQHWmkOcWpT0j97Z_s_dtowC-S1f7WzhttA@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Mon, 10 Mar 2025 at 13:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/3/25 11:29, Peter Maydell wrote:
> > We want to capture potential Rust backtraces on panics in our test
> > logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=3D1 in
> > the add_test_setup environments, so that all our tests get run with
> > this environment variable set.
> >
> > This makes the setting of that variable in the gitlab CI template
> > redundant, so we can remove it.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   meson.build                         | 9 ++++++---
> >   .gitlab-ci.d/buildtest-template.yml | 1 -
> >   2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 8b9fda4d95e..2f373dc675f 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=3D1.5.0',
> >
> >   meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> >
> > -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_defau=
lt: true)
> > -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLO=
W=3D1', 'SPEED=3Dslow'])
> > -add_test_setup('thorough', env: ['G_TEST_SLOW=3D1', 'SPEED=3Dthorough'=
])
> > +add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_defau=
lt: true,
> > +              env: ['RUST_BACKTRACE=3D1'])
> > +add_test_setup('slow', exclude_suites: ['thorough'],
> > +               env: ['G_TEST_SLOW=3D1', 'SPEED=3Dslow', 'RUST_BACKTRAC=
E=3D1'])
> > +add_test_setup('thorough',
> > +               env: ['G_TEST_SLOW=3D1', 'SPEED=3Dthorough', 'RUST_BACK=
TRACE=3D1'])
>
> Nitpicking, we can keep sorted:
>
>           env: ['G_TEST_SLOW=3D1', 'RUST_BACKTRACE=3D1', 'SPEED=3Dthoroug=
h'])

That splits up the two envariables that are controlling the
"run the slow tests" behaviour, though...

-- PMM


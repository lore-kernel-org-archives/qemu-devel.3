Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76777C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trh9v-0006vl-5W; Mon, 10 Mar 2025 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trh9t-0006uW-JD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:21 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trh9r-0005Qx-Bg
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:43:21 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so3486506276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741628598; x=1742233398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IF+oovqe+WcZkHsHVi04CN1ojH3XhM5U3Prbu+HPN0o=;
 b=GMBASTSEc5hKbp53+UOsQJmmkkaj7ImnMAAekcfXEhh/uYrUEjgvOKyRCp5w5ixxnu
 54MPt9/uCbQwuczGVcsQuQLjCwMesY6ddlSJPcJkQYLY3O1jjZ1MoMJYhDf0Fvh8FQq7
 /u1/wsdQ5KRbySL3GPtgTcr6Qm7DEkjrv/5G2I+azH+YM0tzl0cAD9KwfBmz0ucB7397
 H22wHP/pQEtQRBjLIMvP1UwUwUw2icrAzgqz6hdvMQH2f+nhhWig2zgqeal8/cfe8w9j
 a8zB6RijYDBdJwSOJub1TpYdBrrobZWcxv/iM8rl8S5Oy6IMKWfERnJaDmC18vDHbTxC
 MyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741628598; x=1742233398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IF+oovqe+WcZkHsHVi04CN1ojH3XhM5U3Prbu+HPN0o=;
 b=QJ9rD3r5iXjYrzT+koduCA+5zLLvmBFXjd1yyzJbmSOOP5xsgHkSl1zLGw0WKbjXMb
 2g/onnTYvi80Y3st0KIavxi4ith6b7N7P16/ZCq4179B0a5XSErVJL7QqUj5pAWo7tRO
 aN+sb/cQr3E3ozF2ZlQ6KnE4r9J233SRBYhG7MPnw4LL8M3EFmUWsDj8Q3uHQ4GKfITl
 O04IOHrZY0C/+FQoJ14Ky98mJMdx98I44qQGYOOYecCqOJvFg3Bwr37zfpl8KcdLksoz
 Rh87xJ0mkCPK8rUygSsiuopXbQ+L+EnIuCjwIuLX+eMkv3NhYryr7P9wtbYZmyQX4PLK
 qC1w==
X-Gm-Message-State: AOJu0YyubXloBEjOQXsRroyIvjtzVIxyXgmIQiNNaGCntEFCw213y2e/
 EXUxul0UapYANV9Agkw1kIZdC7xb6QWz2NdN3uTYIPHhLHpS/1mkSuqSxQ1BHw61DQzwNSqkwNg
 0/RqBUbd+qWQo2CpBd5ccawWsF1Fp7uWVg/VqfA==
X-Gm-Gg: ASbGncsHDHaeFU+XeOQ4yRCKeSeAsfgfz8CsPR4SoSCvYQ7U5JLPeYeVRNdv48BneEY
 UDwA85pLfwkTICbhG+Q1cbXJy7ptasZXYS3vUbSpiv61WtdIreMsjcQMFYrcbZjd2RWUEkOqZQ0
 gCWSZ1AfxyFbGD2wgrPFWj2vPiJzM=
X-Google-Smtp-Source: AGHT+IF6mBPGsqbmidpXjQJ8DlVJBDXamm0dEKQOQdN+WEHCCzFD4qcNQIkbsXmH0pXmmYwNNtA/mf7Ha/lWeUG0dUk=
X-Received: by 2002:a05:6902:e0f:b0:e5d:cdc6:7acf with SMTP id
 3f1490d57ef6-e635c1d7c51mr16444264276.31.1741628598044; Mon, 10 Mar 2025
 10:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250310102950.3752908-1-peter.maydell@linaro.org>
 <4842ddd6-acae-457d-8310-d2463773ee1b@linaro.org>
 <CAFEAcA8-AMhHuZXxQHWmkOcWpT0j97Z_s_dtowC-S1f7WzhttA@mail.gmail.com>
 <2619b843-1938-438f-8c48-e8b188777f31@linaro.org>
In-Reply-To: <2619b843-1938-438f-8c48-e8b188777f31@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 17:43:06 +0000
X-Gm-Features: AQ5f1JpbhisbfeINJrM5tw-3wi4IxW-lGbU3YFEAw0l5Re-PbjeAvDcIeMOZ4tk
Message-ID: <CAFEAcA9RUjYiHOB-At=zJe4yFtCHoDk+2fsc7s8mn9AoySw-7A@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Mon, 10 Mar 2025 at 17:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/3/25 14:18, Peter Maydell wrote:
> > On Mon, 10 Mar 2025 at 13:15, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> On 10/3/25 11:29, Peter Maydell wrote:
> >>> We want to capture potential Rust backtraces on panics in our test
> >>> logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=3D1 i=
n
> >>> the add_test_setup environments, so that all our tests get run with
> >>> this environment variable set.
> >>>
> >>> This makes the setting of that variable in the gitlab CI template
> >>> redundant, so we can remove it.
> >>>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>>    meson.build                         | 9 ++++++---
> >>>    .gitlab-ci.d/buildtest-template.yml | 1 -
> >>>    2 files changed, 6 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/meson.build b/meson.build
> >>> index 8b9fda4d95e..2f373dc675f 100644
> >>> --- a/meson.build
> >>> +++ b/meson.build
> >>> @@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=3D1.5.0',
> >>>
> >>>    meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root()=
 })
> >>>
> >>> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_def=
ault: true)
> >>> -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_S=
LOW=3D1', 'SPEED=3Dslow'])
> >>> -add_test_setup('thorough', env: ['G_TEST_SLOW=3D1', 'SPEED=3Dthoroug=
h'])
> >>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_def=
ault: true,
> >>> +              env: ['RUST_BACKTRACE=3D1'])
> >>> +add_test_setup('slow', exclude_suites: ['thorough'],
> >>> +               env: ['G_TEST_SLOW=3D1', 'SPEED=3Dslow', 'RUST_BACKTR=
ACE=3D1'])
> >>> +add_test_setup('thorough',
> >>> +               env: ['G_TEST_SLOW=3D1', 'SPEED=3Dthorough', 'RUST_BA=
CKTRACE=3D1'])
> >>
> >> Nitpicking, we can keep sorted:
> >>
> >>            env: ['G_TEST_SLOW=3D1', 'RUST_BACKTRACE=3D1', 'SPEED=3Dtho=
rough'])
> >
> > That splits up the two envariables that are controlling the
> > "run the slow tests" behaviour, though...
>
> I meant:
>
> add_test_setup('slow', exclude_suites: ['thorough'],
>                 env: ['G_TEST_SLOW=3D1', 'RUST_BACKTRACE=3D1', 'SPEED=3Ds=
low'])
> add_test_setup('thorough',
>                 env: ['G_TEST_SLOW=3D1', 'RUST_BACKTRACE=3D1',
> 'SPEED=3Dthorough'])

Yes, and that splits up the G_TEST_SLOW=3D1 from the SPEED=3Dwhatever
by putting the RUST_BACKTRACE=3D1 in the middle...

-- PMM


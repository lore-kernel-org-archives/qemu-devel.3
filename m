Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA3CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9cX-0002Z4-JP; Mon, 04 Mar 2024 09:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9cU-0002W5-JV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:48:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9cS-0007C5-Q7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:48:46 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so6301355a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709563723; x=1710168523; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVQ6XsZulfExPgKIBMdqV61wTuYfQlGkP6JW60NKR10=;
 b=mwl4cgZJb6HqF3NqY8LhEaVWsGAwIoQvs6fESrQ8YRt01v6kKN6OSsN0MKuDCl/0/8
 MXXz/ESaaE5Yd3pFi35eCMhAZxcb+2du8L0EpycaGExH3QGrhsVpmKw2p5wGNRV4MKpg
 083pg+0BfU7kYkvouTKFUwG4KmEgR26XwTOe19dtPKJnkseKi+4O2e1KUwYDgkeJXi8E
 U6jPqt0+lvS2vZL1BafRgWLknY7fVbMLUG3pedCM5e6PuwiztIGZgqkx8u2H08MFuNXF
 /0fcP633MYPdHfDuuHM5UsNLzoO07k4814J6ZOjZImEdubFx6LKPja+yR7Si5sPZ1Qg9
 rKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563723; x=1710168523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVQ6XsZulfExPgKIBMdqV61wTuYfQlGkP6JW60NKR10=;
 b=hoauj9zxW410NZEjTgeRBZexIAlPW5Dxh2+0y1QBOeYOQ3FvABWYMyD/UBjp3Pn6Qe
 quwsPtzQk+IBjSnhfI4cWGGWlssihqpE7q7ytZDvNzhVnxEY7kr7PjAGdVTee4gMQW2a
 XPjwBx47+zt52uxPcpo+sqf+PbS2XnfF9zQ+vz6z7STAao1F2DmNAX2hnJ4ZmeBE+yLH
 BDQUYveYuXU/JV6YXPb5U+7aCjvrAvQglEIeafRb3tIDB+/kaWK/KAbYhnVRw5Wuy+0b
 nCnLT2cc4T0UUUxMTd/RQHySftCy0M4XHWfn/IypV+wOs/PJ0PP5HfKgJzgmTnjGy4U7
 JYTQ==
X-Gm-Message-State: AOJu0YzYZ6CLaSWKtbi1FrF6qRiHsUzJ3GoSPxYPCfvw30ZgDFYZMchX
 2VaHDiipqv9A6j6wqYtRx0WxxV3PcYejuR/vulNox/kIZoqIXLf6Yibd+zKNLC8l8cUI0J496Km
 no5vUsEOeoV+A13e50hGgihNLeSuMn+hXY5UeHQ==
X-Google-Smtp-Source: AGHT+IHg+Jco6wQvvjRITkAR4QNJDQMeYZgHX2qOsfvZAIynw7VPQa/5moWCC44/na2kY4JfFisPtjHQpGyOWVvuesY=
X-Received: by 2002:a05:6402:1e86:b0:565:3aa7:565f with SMTP id
 f6-20020a0564021e8600b005653aa7565fmr5832510edf.8.1709563722855; Mon, 04 Mar
 2024 06:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20240304144456.3825935-1-berrange@redhat.com>
 <20240304144456.3825935-2-berrange@redhat.com>
In-Reply-To: <20240304144456.3825935-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 14:48:31 +0000
Message-ID: <CAFEAcA-OqzmWt+QP43POFDN5y4HNRS_hb2vCGbiYGd7EV--fAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] meson: detect broken clang 17 with
 -fzero-call-used-regs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 14:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Clang 17 will segv if given  -fzero-call-used-regs and optimization
> is enabled. Since upstream hasn't triaged the bug, distros are
> increasingly shipping with broken Clang.
>
> https://github.com/llvm/llvm-project/issues/75168
> https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D277474
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0ef1654e86..762798f2ee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -555,17 +555,24 @@ endif
>  # Check further flags that make QEMU more robust against malicious parti=
es
>
>  hardening_flags =3D [
> -    # Zero out registers used during a function call
> -    # upon its return. This makes it harder to assemble
> -    # ROP gadgets into something usable
> -    '-fzero-call-used-regs=3Dused-gpr',
> -
>      # Initialize all stack variables to zero. This makes
>      # it harder to take advantage of uninitialized stack
>      # data to drive exploits
>      '-ftrivial-auto-var-init=3Dzero',
>  ]
>
> +# Zero out registers used during a function call
> +# upon its return. This makes it harder to assemble
> +# ROP gadgets into something usable
> +#
> +# NB: CLang 17 is broken and SEGVs

"Clang"

> +# https://github.com/llvm/llvm-project/issues/75168
> +if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.=
cb(); }',
> +               name: '-fzero-call-used-regs=3Dused-gpr',
> +               args: ['-O2', '-fzero-call-used-regs=3Dused-gpr'])
> +    hardening_flags +=3D '-fzero-call-used-regs=3Dused-gpr'
> +endif
> +
>  qemu_common_flags +=3D cc.get_supported_arguments(hardening_flags)
>
>  add_global_arguments(qemu_common_flags, native: false, language: all_lan=
guages)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

The stable releases don't have the use of -fzero-call-used-regs,
so we don't need to backport this.

thanks
-- PMM


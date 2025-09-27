Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86485CAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 05:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2NZh-0003Xf-U1; Sat, 27 Sep 2025 01:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1v2NZe-0003XU-IP
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 01:34:22 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1v2NZU-00059N-VH
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 01:34:21 -0400
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso17550415e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 22:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758951245; x=1759556045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQw1HQLiAUIcQevW+ISkK6hoClWnnH/xtqE5+O9YJYw=;
 b=H0Qa5fwfm1XUz0jpK9tzHgf3M9tu8yXwDGLQfFHhojyhyVnzRZpmParkmznBsy4lwb
 jvRqx2PQqAfStNvmxkhkaIXNJF21z/UE/Lk8SVJ1Hm+BnDlws6syBlLrEgdFHoF+30Ar
 4VCbDvAqHxGzy0WeV7i+wkREpiGzoDtiuoLyt+gAWL8UlOnKhtCYP7CiL46uEnpNoAqz
 T+4S7sMVJBbVGN0uCtQsa9RBCxJQHZUd3J7HWKTjOmbs2oikOU2OmOCA5poqjdUc7ACW
 lsvbj9dE3zuMoOxxF2cQW6RCs0JKDoAzIuPxY9MhA2u1gdqlj9m0IXv6q5cMfHWyzbE6
 UVVg==
X-Gm-Message-State: AOJu0Yw+gYp36qgdHXrkkvGMTRL8UmE1DzeW5pm6Ev1z9a0fYcjhGUZM
 AqDTtemlz6FB+4sDTP28KMbnkZoBHtGu3f09OiDxb1X2vvUbGNrMQ4LtHmLoPy9CSxh+X0lf9hu
 CxkJCGHZC0pCX+gKMSfjPlJDygcslmjQ=
X-Gm-Gg: ASbGncsreFbLGur3WMNhcSIPEnHzr3256iig9VOPDCAIbQgrvMs2OhxuEAa3peg11id
 vlFUbGH28IgGAONFGDeaBZ/DVvUrTSA6/zu2+97LcSp7jCpVelE3jV/qQAD0zrEuyETGXA8jw4s
 YPUeSV9qNHPEb3fgIyQ4gwV3eycMpPbeXJxJCEsHzA+Gv/jWnNI5PWSlsrQq3fbm4I6ND3c/BIO
 L0YL1CSMa8F8gIfDzODHpJT4rR9uUf1hJyvL+aEN4vaXqMuzMbnj1Ro0fXh0daPlKtlSd/7xGkl
 vkUPm8El2ZReqZWIjM1vEd/QkIEvkgyCqdZJWU4hWK4rREhP+PsXYFQooIrV
X-Google-Smtp-Source: AGHT+IE3OVdl30LRE1M8K3cmETepwxN8HWvABwkDs+EoTh9+N2+3VXRudkZT4x+8znSjyr/bCFVciSkkhCNBoULDcTU=
X-Received: by 2002:a05:600c:1c15:b0:46e:3956:6810 with SMTP id
 5b1f17b1804b1-46e39566c90mr73792165e9.18.1758951244721; Fri, 26 Sep 2025
 22:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240620234633.74447-1-syq@debian.org>
 <alpine.DEB.2.21.2406210124020.43454@angie.orcam.me.uk>
 <CAKcpw6Vc9QkHWGxJmJwipaqEnGJZsPof7k25i9e1trtCTDVc=A@mail.gmail.com>
 <alpine.DEB.2.21.2406211258060.43454@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2406211258060.43454@angie.orcam.me.uk>
From: YunQiang Su <syq@debian.org>
Date: Sat, 27 Sep 2025 13:33:51 +0800
X-Gm-Features: AS18NWC9lydFrF8pB-CXXCaERQ8zETKSeWEXE-n-YN-w3IKa8rSObLb3plztxao
Message-ID: <CAKcpw6WgSkJVwv4oU53-qUS2AGD=SEfpVumQmeYC7zWK0Ja4kA@mail.gmail.com>
Subject: Re: [PATCH] mips: pass code of conditional trap
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.53; envelope-from=wzssyqa@gmail.com;
 helo=mail-wm1-f53.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Maciej W. Rozycki <macro@orcam.me.uk> =E4=BA=8E2024=E5=B9=B46=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=94 20:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 21 Jun 2024, YunQiang Su wrote:
>
> > >  I haven't touched this stuff for ages, but AFAICT the code is alread=
y
> > > passed where applicable via the environment for `do_tr_or_bp' to hand=
le,
> > > so I can't understand why your change is needed.
> > >
> >
> > The error_code in env is always zero, as we need to set it here.
>
>  There is code to set it there already, so when submitting a fix you need
> to investigate why it doesn't work and describe in the change description=
.
>
> > >  What problem are you trying to solve?
> > >
> >
> > See the talk in GCC mailing list about testsuite/ubsan/overflow-div-3.c
> > Qemu emits SIGTRAP instead of SIGFPE, due to it didn't initialize the
> > code of conditional trap to env.
>
>  Self-contained information about the reproducer needs to be included in
> the change description.  A general statement such as "this and that does
> not work" or referring to another mailing list is not sufficient.
>

I am trying to fix the problem like this
gcc/testsuite/gcc.c-torture/execute/20101011-1.c

void
sigfpe (int signum __attribute__ ((unused)))
{
  exit (0);
}

int
main ()
{
#if DO_TEST
  signal (SIGFPE, sigfpe);
  k =3D i / j;
  abort ();
#else
  exit (0);
#endif
}



>   Maciej


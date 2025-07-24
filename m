Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ABFC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevOb-0003XO-00; Thu, 24 Jul 2025 08:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevOY-0003U7-5F
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:49:58 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevOU-0002kg-Kx
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:49:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c93c23b08so1908620a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753361391; x=1753966191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wJNLqq2LDogzup7pgWXPhaSfx649M6al2H+cUKBOq8=;
 b=YWPahPPi4A/WwQMiIeaqspUpsUNGV7ZBljGO/jralaHZ+ZwLLzEv1q1VN+HIFt7ETv
 1zc12+4WhwTpgnaDRHBB6waMUvwxje8T9lcqYr7MBcAQ+l2sz0KKeGI+9owR4BmgmYH1
 qreOC9LAGoxZb6y13I7szy2Gu2AYE8tx0cAB8hizNxSuQj6XEZ4pfs/rL/80HF+3nUXS
 FJmoHJ0hx35uljiKepLtAq/aJtzlX07LNbY4KES/0bEtixSaILaySmLz7QHXWFgGINqM
 ESLL/e4xwVH+NsaCa8Jl26TjIQ4MuqPeOKX4hRsjl78lLu6rftz2EObPamEH5gba56zQ
 pFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361391; x=1753966191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wJNLqq2LDogzup7pgWXPhaSfx649M6al2H+cUKBOq8=;
 b=His2yDnUUJJLFD0JHslU2xEPlpFqiQpTnjRZCIg0brd4WPirQ2E3nXC1vemKyWKAF8
 PqKthzDDkAnuv2fEKi3mrtOqRafjz8bBOHLpktuDtRNcm5ROKPwawf/IW0e/DGQeJsTo
 e2Wj9vjQGv2wSHTt/f60qwHOsUOphyU2GBVOI1mPSZR7lViitnZ+UklWI+j5WLiWdeRj
 E1iBP1efXHTrUBjli77ZOoqPGMcrJ3WkIlEs3ddUEHosnCQYN2DrQEQRitr2geZJyAfc
 DlE1Nb2Ax+IxCfIfejVtzq6LYFf9lLx+3yi77u89FxZQQXN2kdoV0P0nxpnvUfe619zl
 JVog==
X-Gm-Message-State: AOJu0Yx3faY17/7SZKzbIedsZoy99nKaqx+R3Az3u6zXc/BF+YFl4tWL
 sPULbLABmpsCQK7dFZeEgs2nCWk5H3s7MvIt/pe4W8ODjEwKbz09vzrfukvA+t991Oma+U/v6re
 Tj4Msyt9FIGFY5zaRfElWbcIOtDGWtrq+rrAdXv4sxw==
X-Gm-Gg: ASbGncvsI2gkDoM81KO13FBOC7Ia70fwHndEgSJsb/DuFeF/PJZlgB1bbIeTHe0t05h
 aAxDDf6/BP3Q9hTKNuEzr/JmlSYBwFdRD21bH3sdlp3l+/uqGTCxzj43hXOd3mptQiAhzu5vdB+
 SR/dukfJC1LMnLYC/VrsN1Fis3IjRNzcS4EO7ky7guEigbHtiHA4uANMmZGzGxY4sooMDSmF8of
 VumEw==
X-Google-Smtp-Source: AGHT+IFZTvA7FegGRIUcfpzXcBDcjH5q1RN9dW/YFBZy8BB054HFA3w9aQ8Gkglx5acaSWvr0VgfqKMaDb29GigiBAI=
X-Received: by 2002:a05:6402:510f:b0:614:d585:35b3 with SMTP id
 4fb4d7f45d1cf-614d5853a8cmr1223941a12.1.1753361390812; Thu, 24 Jul 2025
 05:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-14-alex.bennee@linaro.org>
 <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
 <875xfhvk98.fsf@draig.linaro.org>
In-Reply-To: <875xfhvk98.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 15:49:24 +0300
X-Gm-Features: Ac12FXwz1J5ZxE1nzdNcT1a8ZM08rDYvaROeMxuNsKDn6pAqHMsB08On1g2Tc6o
Message-ID: <CAAjaMXaUefn-3tYXgV5itg_=rg4_hwqRAugO_nHHM7RD3v1Nsw@mail.gmail.com>
Subject: Re: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection
 for all-test-cross
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, Jul 24, 2025 at 3:36=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >>
> >> When building on non-x86 we get a bunch but not all of the compilers.
> >> Handle this in the Dockerfile by probing the arch and expanding the
> >> list available.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++--------=
-
> >>  1 file changed, 17 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/t=
ests/docker/dockerfiles/debian-all-test-cross.docker
> >> index 5aa43749ebe..16a83241270 100644
> >> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> >> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> >> @@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >>          bison \
> >>          ccache \
> >>          clang  \
> >> +        dpkg-dev \
> >>          flex \
> >> +        gcc \
> >>          git \
> >>          libclang-rt-dev \
> >>          ninja-build \
> >> @@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >>          python3-venv \
> >>          python3-wheel
> >>
> >> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >> -        apt install -y --no-install-recommends \
> >> -        gcc-aarch64-linux-gnu \
> >> +# All the generally available compilers
> >> +ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
> >>          libc6-dev-arm64-cross \
> >>          gcc-arm-linux-gnueabihf \
> >>          libc6-dev-armhf-cross \
> >> -        gcc-hppa-linux-gnu \
> >> -        libc6-dev-hppa-cross \
> >> -        gcc-m68k-linux-gnu \
> >> -        libc6-dev-m68k-cross \
> >>          gcc-mips-linux-gnu \
> >>          libc6-dev-mips-cross \
> >>          gcc-mips64-linux-gnuabi64 \
> >> @@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >>          libc6-dev-mips64el-cross \
> >>          gcc-mipsel-linux-gnu \
> >>          libc6-dev-mipsel-cross \
> >> -        gcc-powerpc-linux-gnu \
> >> -        libc6-dev-powerpc-cross \
> >> -        gcc-powerpc64-linux-gnu \
> >> -        libc6-dev-ppc64-cross \
> >>          gcc-powerpc64le-linux-gnu \
> >>          libc6-dev-ppc64el-cross \
> >>          gcc-riscv64-linux-gnu \
> >>          libc6-dev-riscv64-cross \
> >>          gcc-s390x-linux-gnu \
> >> -        libc6-dev-s390x-cross \
> >> -        gcc-sparc64-linux-gnu \
> >> -        libc6-dev-sparc64-cross && \
> >> +        libc6-dev-s390x-cross
> >> +
> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D=
"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D=
"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D=
"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; fi
> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D=
"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; fi
> >> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D=
"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; fi
> >> +
> >> +RUN echo "compilers: ${AVAILABLE_COMPILERS}"
> >
> > Nitpick, each `RUN` command will create a new cached layer for the
> > container build. It makes more sense to fold them in a single `RUN`
> > step to avoid unnecessary layers. Does not make a big difference so
> > feel free to ignore.
>
> I did try to figure out how to do a multi-line shell with an env
> expansion but wasn't able to get the escaping right. If you can suggest
> the right runes please do ;-)

Like this?

RUN if dpkg-architecture -e amd64; then \
  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS}
gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
  fi && \
  echo "compilers: ${AVAILABLE_COMPILERS}"


>
> >
> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >
> >> +
> >> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >> +        apt install -y --no-install-recommends \
> >> +        ${AVAILABLE_COMPILERS} && \
> >>          dpkg-query --showformat '${Package}_${Version}_${Architecture=
}\n' --show > /packages.txt
> >>
> >>
> >> --
> >> 2.47.2
> >>
> >>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32CFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueu9W-0000BI-3x; Thu, 24 Jul 2025 07:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueu9N-00089P-Gg
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:30:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueu9L-0003MU-7B
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:30:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c4f796446so1511409a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753356609; x=1753961409; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLsNCLAgQY25GsAUu49EVCWatsso57MaoWS8EpJ/U3Y=;
 b=TJI1Au7zO1567gMct1y4s5WFOd/XJvfRFRvBl4SFOUQPCoNv5WguvBQTY3mmUivrJ+
 nRkOOnZP3kSIBLUgxmfvdEpd4/1tMdKEDhfMQYXwkwn6eYbIsFImevRgdMwhXPmZYlg4
 vCP5p+IK3OgFju+of3+bqrtFqAaMh31SBbH49rHYBrCq2EP16kMJzSYMmM4+EdIF83oh
 C1tDnqaZJrWmMtA63Om6dV/qw1eNC417yNdNXGeoQHRC5Zm0vBlWHPLIvJuJgC+2QEV0
 Ivr1ON1gL1rSqBhvGBl+zBEyP7B4VjQ8TsYnu+ecIPotXyXZG3cZSIl9z2+WRzYlkVgd
 uugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753356609; x=1753961409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLsNCLAgQY25GsAUu49EVCWatsso57MaoWS8EpJ/U3Y=;
 b=gSVi/X8r/AA0JTSKN7Jkf8J0eACLrXpiuHtQsCpJ8xPhANnNBWAsCK/bf2Jc4/96hB
 L0Meqim032N/cRJhVFVMPU0CwWd+nuez87FUKo4CAnnkGQxmgCzCZt8cAQN4bQEdzOj9
 1wr1TzBAZJcX9ofgqcNlQSP9SftvZ3BnpjveKpnzCDAbsLTcS34LQiWtXqI4e+6ZMiTW
 B0vVL8JgTYfUz3iHJ4QmP9+pOhzMqyZwLjw2u8U2bCKIrvJCTihpA5KaSNKnq0gUHBTk
 zVbGeNR6hp9RsPcN3ccQJqT1YCHJLswIDkasvy7f5ijdtxwQjwy/PF9QpxZ9xEXuBB93
 zWkQ==
X-Gm-Message-State: AOJu0YxmljNo+1JU/w+YtIGUDJMvhbz762zROF/b4v0FlJ3oKwEP6zDR
 56SCupFZwZJgbsLhbJ0qopbW7BS2qabKy7ANVACqu5Xow5VWrTwHN+YFDmne43sQfoa7fPDAqZR
 C1aMBUx0NaSFiBuyAhll89gxGgjezuyfU2H+sQHMJGQ==
X-Gm-Gg: ASbGncuNtmewW66iFM4Rk0c2V+5R0hBxCme9qc5pmlzxyCtB82nauA3NJauV0FsXv9A
 wr9bitIvIn392krUhhwzhKk/4r4BnrNl+t9J0hIlvMZ4TV6yFRmSVOA+yRMWADbDl9WYC1Qr4MW
 5aPMfwu5n+cNUgZLnOEoELQNF4uEuPVpOca4SjPz4bXs0tM/hSGINBU887eu7dnimn4W1C4RNq4
 6iAfiEBLocm30MB
X-Google-Smtp-Source: AGHT+IG9M7JG3+egYJEUNgJnjmD3VnU0cF/HaWeex+0iBmRYnIxgoZD+N7u38A+ut0GSEQdQnY6i7E/fv/B/j0K4REc=
X-Received: by 2002:a05:6402:90c:b0:612:dff3:2ffb with SMTP id
 4fb4d7f45d1cf-6149b427029mr5723871a12.11.1753356608758; Thu, 24 Jul 2025
 04:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-14-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-14-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:29:42 +0300
X-Gm-Features: Ac12FXz3_xjyMlWLZv1NSiN_dVw_b3zHyllUzeiXq1abD3FpGwkiGCq5bqRfTQU
Message-ID: <CAAjaMXau4GyWidMNdYXgnMQTrv0mhVuCamDtaMLLJPeEDgyOQQ@mail.gmail.com>
Subject: Re: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection
 for all-test-cross
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> When building on non-x86 we get a bunch but not all of the compilers.
> Handle this in the Dockerfile by probing the arch and expanding the
> list available.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++---------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/test=
s/docker/dockerfiles/debian-all-test-cross.docker
> index 5aa43749ebe..16a83241270 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          bison \
>          ccache \
>          clang  \
> +        dpkg-dev \
>          flex \
> +        gcc \
>          git \
>          libclang-rt-dev \
>          ninja-build \
> @@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          python3-venv \
>          python3-wheel
>
> -RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> -        apt install -y --no-install-recommends \
> -        gcc-aarch64-linux-gnu \
> +# All the generally available compilers
> +ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>          libc6-dev-arm64-cross \
>          gcc-arm-linux-gnueabihf \
>          libc6-dev-armhf-cross \
> -        gcc-hppa-linux-gnu \
> -        libc6-dev-hppa-cross \
> -        gcc-m68k-linux-gnu \
> -        libc6-dev-m68k-cross \
>          gcc-mips-linux-gnu \
>          libc6-dev-mips-cross \
>          gcc-mips64-linux-gnuabi64 \
> @@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          libc6-dev-mips64el-cross \
>          gcc-mipsel-linux-gnu \
>          libc6-dev-mipsel-cross \
> -        gcc-powerpc-linux-gnu \
> -        libc6-dev-powerpc-cross \
> -        gcc-powerpc64-linux-gnu \
> -        libc6-dev-ppc64-cross \
>          gcc-powerpc64le-linux-gnu \
>          libc6-dev-ppc64el-cross \
>          gcc-riscv64-linux-gnu \
>          libc6-dev-riscv64-cross \
>          gcc-s390x-linux-gnu \
> -        libc6-dev-s390x-cross \
> -        gcc-sparc64-linux-gnu \
> -        libc6-dev-sparc64-cross && \
> +        libc6-dev-s390x-cross
> +
> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"${=
AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"${=
AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"${=
AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; fi
> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"${=
AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; fi
> +RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS=3D"${=
AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; fi
> +
> +RUN echo "compilers: ${AVAILABLE_COMPILERS}"

Nitpick, each `RUN` command will create a new cached layer for the
container build. It makes more sense to fold them in a single `RUN`
step to avoid unnecessary layers. Does not make a big difference so
feel free to ignore.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> +
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +        apt install -y --no-install-recommends \
> +        ${AVAILABLE_COMPILERS} && \
>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\n=
' --show > /packages.txt
>
>
> --
> 2.47.2
>
>


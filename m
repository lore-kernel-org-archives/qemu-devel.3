Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E2EC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnpM-0004re-EP; Mon, 20 Jul 2026 09:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlnp3-0004ms-HO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:14:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlnp0-0000Ig-JG
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:14:17 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso525878f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553252; x=1785158052; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pRzc0lLJsyjzPxnSjGxv25ty/rOLGErROsR8TEY29Ww=;
 b=pFwpILgmoXkji6BUAR36uaLTW/WplvmyX0F7yPILd8hc1Huvi9c4D3kQ6qte1xLzE0
 CG6TZoK1aECSHkzVUxUt4oXCayW83PYOn41w78HHCjKU0BldLIJK9FlCbS5EfJaY4A/O
 ToQW26FwNTndxY8EVV+xaafdnJ6ulBwc/9p1KPAnr7suWV9kyH4OKaiZhDgYV5oEIz+w
 5Fig5pDBs9Kq1gd4jcDyRJseZLc93PYP6zktexvXHNa2n1GkjKk0D0lc8cWAlsGEhURh
 KaAXVOzFCRBXN5NMzsSi4w2zrDU2/fFB1XNXFra5Q21CTGl9dw5jaHJsON/Ea4+NIEmI
 HJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553252; x=1785158052;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pRzc0lLJsyjzPxnSjGxv25ty/rOLGErROsR8TEY29Ww=;
 b=V6QSbf+IAhN8h7otcOZo1vEMEeaPgLrFZKzUpodCvUbEf5DJ1364H/1MGFFQuwVNvW
 EPF9H0Sk77oyZIM5VwAbBdlrAxbPyV731kZCPVCFcUICmFRZQwFOkLzjQnsYqEUOksKr
 ESYkABjbT/p8NzvWZhPRdtL1be59mGrTH/PzdrLXBR6YheE6gWh26AO+zS+QaZvcdxLZ
 aVcl3/Cd56RupoYlkMwHi+XDHf/vviTko+9ivcsGZoS8SHz/EVaB3QoLIMPwFi/2Iu8z
 yeDx9047GURhIFLNqu0a1Q1cx/HiiMQfRosOegy8nwcFTCQ8DD+yoAFmonATblmhWAst
 O5Ig==
X-Gm-Message-State: AOJu0YwvJ0Z5oOXeW5mR6iHhC+0TAt9Zn2gA5gq5o2m0FOmq6X7QqCpF
 nHWag4KdZvi3/FumgaV32+FVerZ79GVcc32aXx6btPRpDYNaidptfTEt/EMYI9xa0a0=
X-Gm-Gg: AR+sD13s+r+5qLFYZ2JYZ6Oog/1JwamCp9veFQVcDI1A6uEWcqBcLaWYisL9o0ivhJO
 4sSo3VYuzNlqsz4xU4c4wNkQ5nOqw2ABy+Fg6qF9L/ELGzNLsHitihYqKxOj/+ifGhMJHD1GZ5O
 au9vcVaCVRLIFn+2Z+399ciMC0vnhpQzveJKDxUjiN4bueg6PuYpFSkmTVYKDmiCJrx2FdLy9fA
 fpMDizwW9WjmyKPtisX5QyWDi3ThCFjBOrJfh9FxJ2Qpex9bnu+lLA0LPktGl4kTyAvP9FT+xHr
 TZNLvehjhebOokfphFIyfZoehQXhTCk9wQ1g8Aw9HvFocS9pAJcFCZvx6cqdcyW+CKkQC/BcpYO
 b1DfTJukZY12LJjMKj94lcEYu80rRx1dotmW5E8RyTm5g4Je0knTt0qW2IAMYBFn+BeUjEh9RzW
 MqkNh7aDqf9rZa
X-Received: by 2002:a05:6000:71a:b0:47f:2de3:b34d with SMTP id
 ffacd0b85a97d-47f6233498bmr16254009f8f.46.1784553251734; 
 Mon, 20 Jul 2026 06:14:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm34084150f8f.11.2026.07.20.06.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:14:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B3935F911;
 Mon, 20 Jul 2026 14:14:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
In-Reply-To: <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Fri, 10 Jul 2026 14:43:41 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Mon, 20 Jul 2026 14:14:09 +0100
Message-ID: <87wlupst0e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Those options were useful a few years ago, before containers were
> available as an alternative for missing cross compilers. Simplify the
> workflow by removing those options and maintaining only the container
> based approach.

I'm confused here - I thought we wanted to keep local cross compilers
and provide containers as the fallback. Otherwise it will be very
difficult to test against newer compilers without having to rebuild the
containers.

Currently the MacOS build relies on local compilers built via brew.

>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  configure | 473 ------------------------------------------------------
>  1 file changed, 473 deletions(-)
>
> diff --git a/configure b/configure
> index d8bc10060e1..e442cf84676 100755
> --- a/configure
> +++ b/configure
> @@ -228,14 +228,6 @@ for opt do
>    ;;
>    --extra-ldflags=3D*) EXTRA_LDFLAGS=3D"$EXTRA_LDFLAGS $optarg"
>    ;;
> -  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO=
 option"
> -  ;;
> -  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-cflags-}; cc_arch=3D${=
cc_arch%%=3D*}
> -                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"
> -  ;;
> -  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
> -                eval "cross_cc_${cc_arch}=3D\$optarg"
> -  ;;
>    --cross-prefix-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-pr=
efix-FOO option"
>    ;;
>    --cross-prefix-*) cc_arch=3D${opt#--cross-prefix-}; cc_arch=3D${cc_arc=
h%%=3D*}
> @@ -636,8 +628,6 @@ for opt do
>    ;;
>    --extra-ldflags=3D*)
>    ;;
> -  --cross-cc-*)
> -  ;;
>    --cross-prefix-*)
>    ;;
>    --enable-docs) docs=3Denabled
> @@ -854,8 +844,6 @@ Advanced options (experts only):
>    --extra-cxxflags=3DCXXFLAGS append extra C++ compiler flags CXXFLAGS
>    --extra-objcflags=3DOBJCFLAGS append extra Objective C compiler flags =
OBJCFLAGS
>    --extra-ldflags=3DLDFLAGS  append extra linker flags LDFLAGS
> -  --cross-cc-ARCH=3DCC       use compiler when building ARCH guest test =
cases
> -  --cross-cc-cflags-ARCH=3D  use compiler flags when building ARCH guest=
 tests
>    --cross-prefix-ARCH=3DPREFIX cross compiler prefix when building ARCH =
guest test cases
>    --python=3DPYTHON          use specified python [$python]
>    --ninja=3DNINJA            use specified ninja [$ninja]
> @@ -1288,366 +1276,6 @@ EOF
>    fi
>  fi
>=20=20
> -##########################################
> -# functions to probe cross compilers
> -
> -runc=3D"no"
> -if test $use_containers =3D "yes" && (has "docker" || has "podman"); then
> -    runc=3D$($python "$source_path"/tests/docker/docker.py --engine "$co=
ntainer_engine" probe)
> -    if test "$runc" !=3D "no"; then
> -        docker_py=3D"$python $source_path/tests/docker/docker.py --engin=
e $container_engine"
> -    fi
> -fi
> -
> -# cross compilers defaults, can be overridden with --cross-cc-ARCH
> -: ${cross_prefix_aarch64=3D"aarch64-linux-gnu-"}
> -: ${cross_prefix_aarch64_be=3D"$cross_prefix_aarch64"}
> -: ${cross_prefix_alpha=3D"alpha-linux-gnu-"}
> -: ${cross_prefix_arm=3D"arm-linux-gnueabihf-"}
> -: ${cross_prefix_armeb=3D"$cross_prefix_arm"}
> -: ${cross_prefix_hexagon=3D"hexagon-unknown-linux-musl-"}
> -: ${cross_prefix_loongarch64=3D"loongarch64-unknown-linux-gnu-"}
> -: ${cross_prefix_hppa=3D"hppa-linux-gnu-"}
> -: ${cross_prefix_i386=3D"i686-linux-gnu-"}
> -: ${cross_prefix_m68k=3D"m68k-linux-gnu-"}
> -: ${cross_prefix_microblaze=3D"microblaze-linux-musl-"}
> -: ${cross_prefix_mips64el=3D"mips64el-linux-gnuabi64-"}
> -: ${cross_prefix_mips64=3D"mips64-linux-gnuabi64-"}
> -: ${cross_prefix_mipsel=3D"mipsel-linux-gnu-"}
> -: ${cross_prefix_mips=3D"mips-linux-gnu-"}
> -: ${cross_prefix_ppc=3D"powerpc-linux-gnu-"}
> -: ${cross_prefix_ppc64=3D"powerpc64-linux-gnu-"}
> -: ${cross_prefix_ppc64le=3D"$cross_prefix_ppc64"}
> -: ${cross_prefix_riscv64=3D"riscv64-linux-gnu-"}
> -: ${cross_prefix_s390x=3D"s390x-linux-gnu-"}
> -: ${cross_prefix_sh4=3D"sh4-linux-gnu-"}
> -: ${cross_prefix_sparc64=3D"sparc64-linux-gnu-"}
> -: ${cross_prefix_sparc=3D"$cross_prefix_sparc64"}
> -: ${cross_prefix_tricore=3D"tricore-"}
> -: ${cross_prefix_x86_64=3D"x86_64-linux-gnu-"}
> -
> -: ${cross_cc_aarch64_be=3D"$cross_cc_aarch64"}
> -: ${cross_cc_cflags_aarch64_be=3D"-mbig-endian"}
> -: ${cross_cc_armeb=3D"$cross_cc_arm"}
> -: ${cross_cc_cflags_armeb=3D"-mbig-endian"}
> -: ${cross_cc_hexagon=3D"hexagon-unknown-linux-musl-clang"}
> -: ${cross_cc_cflags_hexagon=3D"-mv73 -O2 -static"}
> -: ${cross_cc_cflags_i386=3D"-m32"}
> -: ${cross_cc_cflags_ppc=3D"-m32 -mbig-endian"}
> -: ${cross_cc_cflags_ppc64=3D"-m64 -mbig-endian"}
> -: ${cross_cc_ppc64le=3D"$cross_cc_ppc64"}
> -: ${cross_cc_cflags_ppc64le=3D"-m64 -mlittle-endian"}
> -: ${cross_cc_cflags_sparc64=3D"-m64 -mcpu=3Dultrasparc"}
> -: ${cross_cc_sparc=3D"$cross_cc_sparc64"}
> -: ${cross_cc_cflags_sparc=3D"-m32 -mcpu=3Dsupersparc"}
> -: ${cross_cc_cflags_x86_64=3D"-m64 -mcx16"}
> -
> -compute_target_variable() {
> -  eval "$2=3D"
> -  if eval test -n "\"\${cross_prefix_$1}\""; then
> -    if eval has "\"\${cross_prefix_$1}\$3\""; then
> -      eval "$2=3D\"\${cross_prefix_$1}\$3\""
> -    fi
> -  fi
> -}
> -
> -have_target() {
> -  for i; do
> -    case " $target_list " in
> -      *" $i "*) return 0;;
> -      *) ;;
> -    esac
> -  done
> -  return 1
> -}
> -
> -# probe_target_compiler TARGET
> -#
> -# Look for a compiler for the given target, either native or cross.
> -# Set variables target_* if a compiler is found, and container_cross_*
> -# if a Docker-based cross-compiler image is known for the target.
> -# Set got_cross_cc to yes/no depending on whether a non-container-based
> -# compiler was found.
> -#
> -# If TARGET is a user-mode emulation target, also set build_static to
> -# "y" if static linking is possible.
> -#
> -probe_target_compiler() {
> -  # reset all output variables
> -  got_cross_cc=3Dno
> -  container_image=3D
> -  container_hosts=3D
> -  container_cross_prefix=3D
> -  container_cross_cc=3D
> -  container_cross_ar=3D
> -  container_cross_as=3D
> -  container_cross_ld=3D
> -  container_cross_nm=3D
> -  container_cross_objcopy=3D
> -  container_cross_ranlib=3D
> -  container_cross_strip=3D
> -
> -  target_arch=3D${1%%-*}
> -  case $target_arch in
> -    aarch64) container_hosts=3D"x86_64 aarch64" ;;
> -    aarch64_be) container_hosts=3D"x86_64 aarch64" ;;
> -    alpha) container_hosts=3Dx86_64 ;;
> -    arm) container_hosts=3D"x86_64 aarch64" ;;
> -    hexagon) container_hosts=3Dx86_64 ;;
> -    hppa) container_hosts=3Dx86_64 ;;
> -    i386) container_hosts=3Dx86_64 ;;
> -    loongarch64) container_hosts=3Dx86_64 ;;
> -    m68k) container_hosts=3Dx86_64 ;;
> -    microblaze) container_hosts=3Dx86_64 ;;
> -    mips64el) container_hosts=3Dx86_64 ;;
> -    mips64) container_hosts=3Dx86_64 ;;
> -    mipsel) container_hosts=3Dx86_64 ;;
> -    mips) container_hosts=3Dx86_64 ;;
> -    ppc) container_hosts=3Dx86_64 ;;
> -    ppc64|ppc64le) container_hosts=3Dx86_64 ;;
> -    riscv64) container_hosts=3Dx86_64 ;;
> -    s390x) container_hosts=3Dx86_64 ;;
> -    sh4) container_hosts=3Dx86_64 ;;
> -    sparc64) container_hosts=3Dx86_64 ;;
> -    tricore) container_hosts=3Dx86_64 ;;
> -    x86_64) container_hosts=3D"aarch64 ppc64le x86_64" ;;
> -    xtensa*) container_hosts=3Dx86_64 ;;
> -  esac
> -
> -  for host in $container_hosts; do
> -    test "$runc" !=3D no || continue
> -    test "$host" =3D "$cpu" || continue
> -    case $target_arch in
> -      # debian-all-test-cross architectures
> -
> -      aarch64_be)
> -        container_image=3Ddebian-all-test-cross
> -        container_cross_prefix=3Daarch64-linux-gnu-
> -        ;;
> -      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
> -        container_image=3Ddebian-all-test-cross
> -        ;;
> -      mips64)
> -        container_image=3Ddebian-all-test-cross
> -        container_cross_prefix=3Dmips64-linux-gnuabi64-
> -        ;;
> -      ppc|ppc64|ppc64le)
> -        container_image=3Ddebian-all-test-cross
> -        container_cross_prefix=3Dpowerpc${target_arch#ppc}-linux-gnu-
> -        ;;
> -
> -      # architectures with individual containers
> -
> -      aarch64)
> -        # We don't have any bigendian build tools so we only use this fo=
r AArch64
> -        container_image=3Ddebian-arm64-cross
> -        ;;
> -      arm)
> -        # We don't have any bigendian build tools so we only use this fo=
r ARM
> -        container_image=3Ddebian-armhf-cross
> -        container_cross_prefix=3Darm-linux-gnueabihf-
> -        ;;
> -      hexagon)
> -        container_cross_prefix=3Dhexagon-unknown-linux-musl-
> -        container_cross_cc=3D${container_cross_prefix}clang
> -        ;;
> -      i386)
> -        container_image=3Ddebian-i686-cross
> -        container_cross_prefix=3Di686-linux-gnu-
> -        ;;
> -      loongarch64)
> -        container_image=3Ddebian-loongarch-cross
> -        container_cross_prefix=3Dloongarch64-unknown-linux-gnu-
> -        ;;
> -      microblaze)
> -        container_cross_prefix=3Dmicroblaze-linux-musl-
> -        ;;
> -      mips64el)
> -        container_image=3Ddebian-all-test-cross
> -        container_cross_prefix=3Dmips64el-linux-gnuabi64-
> -        ;;
> -      tricore)
> -        container_image=3Ddebian-tricore-cross
> -        container_cross_prefix=3Dtricore-
> -        ;;
> -      x86_64)
> -        container_image=3Ddebian-amd64-cross
> -        ;;
> -      xtensa*)
> -        container_image=3Ddebian-xtensa-cross
> -
> -        # default to the dc232b cpu
> -        container_cross_prefix=3D/opt/2020.07/xtensa-dc232b-elf/bin/xten=
sa-dc232b-elf-
> -        ;;
> -    esac
> -    # Debian and GNU architecture names usually match
> -    : ${container_image:=3Ddebian-$target_arch-cross}
> -    : ${container_cross_prefix:=3D$target_arch-linux-gnu-}
> -    : ${container_cross_cc:=3D${container_cross_prefix}gcc}
> -    : ${container_cross_ar:=3D${container_cross_prefix}ar}
> -    : ${container_cross_as:=3D${container_cross_prefix}as}
> -    : ${container_cross_ld:=3D${container_cross_prefix}ld}
> -    : ${container_cross_nm:=3D${container_cross_prefix}nm}
> -    : ${container_cross_objcopy:=3D${container_cross_prefix}objcopy}
> -    : ${container_cross_ranlib:=3D${container_cross_prefix}ranlib}
> -    : ${container_cross_strip:=3D${container_cross_prefix}strip}
> -  done
> -
> -  try=3Dcross
> -  # For softmmu/roms also look for a bi-endian or multilib-enabled host =
compiler
> -  if [ "${1%softmmu}" !=3D "$1" ] || test "$target_arch" =3D "$cpu"; then
> -      case "$target_arch:$cpu" in
> -        aarch64_be:aarch64 | \
> -        armeb:arm | \
> -        i386:x86_64 | \
> -        ppc*:ppc64 | \
> -        sparc:sparc64 | \
> -        "$cpu:$cpu")
> -        try=3D'native cross' ;;
> -      esac
> -  fi
> -  eval "target_cflags=3D\${cross_cc_cflags_$target_arch}"
> -  for thistry in $try; do
> -    case $thistry in
> -    native)
> -      target_cc=3D$cc
> -      target_ccas=3D$ccas
> -      target_ar=3D$ar
> -      target_as=3D$as
> -      target_ld=3D$ld
> -      target_nm=3D$nm
> -      target_objcopy=3D$objcopy
> -      target_ranlib=3D$ranlib
> -      target_strip=3D$strip
> -      ;;
> -    cross)
> -      target_cc=3D
> -      if eval test -n "\"\${cross_cc_$target_arch}\""; then
> -        if eval has "\"\${cross_cc_$target_arch}\""; then
> -          eval "target_cc=3D\"\${cross_cc_$target_arch}\""
> -        fi
> -      else
> -        compute_target_variable $target_arch target_cc gcc
> -      fi
> -      target_ccas=3D$target_cc
> -      compute_target_variable $target_arch target_ar ar
> -      compute_target_variable $target_arch target_as as
> -      compute_target_variable $target_arch target_ld ld
> -      compute_target_variable $target_arch target_nm nm
> -      compute_target_variable $target_arch target_objcopy objcopy
> -      compute_target_variable $target_arch target_ranlib ranlib
> -      compute_target_variable $target_arch target_strip strip
> -      ;;
> -    esac
> -
> -    if test -n "$target_cc"; then
> -      case $target_arch in
> -        i386|x86_64)
> -          if $target_cc --version | grep -qi "clang"; then
> -            continue
> -          fi
> -          ;;
> -      esac
> -    elif test -n "$target_as" && test -n "$target_ld"; then
> -      # Special handling for assembler only targets
> -      case $target in
> -        tricore-softmmu)
> -          build_static=3D
> -          got_cross_cc=3Dyes
> -          break
> -          ;;
> -        *)
> -          continue
> -          ;;
> -      esac
> -    else
> -      continue
> -    fi
> -
> -    write_c_skeleton
> -    case $1 in
> -      *-softmmu)
> -        if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
> -          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMP=
DIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
> -          got_cross_cc=3Dyes
> -          break
> -        fi
> -        ;;
> -      *)
> -        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC -stati=
c ; then
> -          build_static=3Dy
> -          got_cross_cc=3Dyes
> -          break
> -        fi
> -        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC ; then
> -          build_static=3D
> -          got_cross_cc=3Dyes
> -          break
> -        fi
> -        ;;
> -    esac
> -  done
> -  if test $got_cross_cc !=3D yes; then
> -    build_static=3D
> -    target_cc=3D
> -    target_ccas=3D
> -    target_ar=3D
> -    target_as=3D
> -    target_ld=3D
> -    target_nm=3D
> -    target_objcopy=3D
> -    target_ranlib=3D
> -    target_strip=3D
> -  fi
> -  test -n "$target_cc"
> -}
> -
> -write_target_makefile() {
> -  echo "PYTHON=3D$python"
> -  echo "EXTRA_CFLAGS=3D$target_cflags"
> -  if test -z "$target_cc" && test -z "$target_as"; then
> -    test -z "$container_image" && error_exit "Internal error: could not =
find cross compiler for $1?"
> -    echo "$1: docker-image-$container_image" >> Makefile.prereqs
> -    if test -n "$container_cross_cc"; then
> -      echo "CC=3D$docker_py cc --cc $container_cross_cc -i qemu/$contain=
er_image -s $source_path --"
> -      echo "CCAS=3D$docker_py cc --cc $container_cross_cc -i qemu/$conta=
iner_image -s $source_path --"
> -    fi
> -    echo "AR=3D$docker_py cc --cc $container_cross_ar -i qemu/$container=
_image -s $source_path --"
> -    echo "AS=3D$docker_py cc --cc $container_cross_as -i qemu/$container=
_image -s $source_path --"
> -    echo "LD=3D$docker_py cc --cc $container_cross_ld -i qemu/$container=
_image -s $source_path --"
> -    echo "NM=3D$docker_py cc --cc $container_cross_nm -i qemu/$container=
_image -s $source_path --"
> -    echo "OBJCOPY=3D$docker_py cc --cc $container_cross_objcopy -i qemu/=
$container_image -s $source_path --"
> -    echo "RANLIB=3D$docker_py cc --cc $container_cross_ranlib -i qemu/$c=
ontainer_image -s $source_path --"
> -    echo "STRIP=3D$docker_py cc --cc $container_cross_strip -i qemu/$con=
tainer_image -s $source_path --"
> -  else
> -    if test -n "$target_cc"; then
> -      echo "CC=3D$target_cc"
> -      echo "CCAS=3D$target_ccas"
> -    fi
> -    if test -n "$target_ar"; then
> -      echo "AR=3D$target_ar"
> -    fi
> -    if test -n "$target_as"; then
> -      echo "AS=3D$target_as"
> -    fi
> -    if test -n "$target_ld"; then
> -      echo "LD=3D$target_ld"
> -    fi
> -    if test -n "$target_nm"; then
> -      echo "NM=3D$target_nm"
> -    fi
> -    if test -n "$target_objcopy"; then
> -      echo "OBJCOPY=3D$target_objcopy"
> -    fi
> -    if test -n "$target_ranlib"; then
> -      echo "RANLIB=3D$target_ranlib"
> -    fi
> -    if test -n "$target_strip"; then
> -      echo "STRIP=3D$target_strip"
> -    fi
> -  fi
> -}
> -
>  #######################################
>  # cross-compiled firmware targets
>=20=20
> @@ -1681,48 +1309,6 @@ fi
>=20=20
>  echo "# Automatically generated by configure - do not modify" > Makefile=
.prereqs
>=20=20
> -# Mac OS X ships with a broken assembler
> -if have_target i386-softmmu x86_64-softmmu && \
> -        test "$host_os" !=3D "darwin" && test "$host_os" !=3D "sunos" &&=
 \
> -        test "$host_os" !=3D "haiku" && \
> -        probe_target_compiler i386-softmmu; then
> -    subdirs=3D"$subdirs pc-bios/optionrom"
> -    config_mak=3Dpc-bios/optionrom/config.mak
> -    echo "# Automatically generated by configure - do not modify" > $con=
fig_mak
> -    echo "TOPSRC_DIR=3D$source_path" >> $config_mak
> -    write_target_makefile >> $config_mak
> -fi
> -
> -if have_target ppc-softmmu ppc64-softmmu && \
> -        probe_target_compiler ppc-softmmu; then
> -    subdirs=3D"$subdirs pc-bios/vof"
> -    config_mak=3Dpc-bios/vof/config.mak
> -    echo "# Automatically generated by configure - do not modify" > $con=
fig_mak
> -    echo "SRC_DIR=3D$source_path/pc-bios/vof" >> $config_mak
> -    write_target_makefile >> $config_mak
> -fi
> -
> -# Only build s390-ccw bios if the compiler has -march=3Dz900 or -march=
=3Dz10
> -# (which is the lowest architecture level that Clang supports)
> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
> -    GIT=3Dgit "$source_path/scripts/git-submodule.sh" "$git_submodules_a=
ction" roms/SLOF >> config.log 2>&1; then
> -  write_c_skeleton
> -  do_compiler "$target_cc" $target_cc_cflags -march=3Dz900 -o $TMPO -c $=
TMPC
> -  has_z900=3D$?
> -  if [ $has_z900 =3D 0 ] || do_compiler "$target_cc" $target_cc_cflags -=
march=3Dz10 -msoft-float -Werror -o $TMPO -c $TMPC; then
> -    if [ $has_z900 !=3D 0 ]; then
> -      echo "WARNING: Your compiler does not support the z900!"
> -      echo "         The s390-ccw bios will only work with guest CPUs >=
=3D z10."
> -    fi
> -    subdirs=3D"$subdirs pc-bios/s390-ccw"
> -    config_mak=3Dpc-bios/s390-ccw/config-host.mak
> -    echo "# Automatically generated by configure - do not modify" > $con=
fig_mak
> -    echo "SRC_PATH=3D$source_path/pc-bios/s390-ccw" >> $config_mak
> -    echo "GIT_SUBMODULES_ACTION=3D$git_submodules_action" >> $config_mak
> -    write_target_makefile >> $config_mak
> -  fi
> -fi
> -
>  #######################################
>  # generate config-host.mak
>=20=20
> @@ -1763,65 +1349,6 @@ if test "$plugins" =3D "yes" ; then
>  fi
>  echo "PYTHON=3D$python" >> tests/tcg/$config_host_mak
>=20=20
> -tcg_tests_with_compilers=3D
> -for target in $target_list; do
> -  arch=3D${target%%-*}
> -
> -  case $target in
> -    xtensa*-linux-user)
> -      # the toolchain is not complete with headers, only build system te=
sts
> -      continue
> -      ;;
> -    *-softmmu)
> -      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || =
continue
> -      qemu=3D"qemu-system-$arch"
> -      ;;
> -    *-linux-user|*-bsd-user)
> -      qemu=3D"qemu-$arch"
> -      ;;
> -  esac
> -
> -  if probe_target_compiler $target || test -n "$container_image"; then
> -      test -n "$container_image" && build_static=3Dy
> -      mkdir -p "tests/tcg/$target"
> -      config_target_mak=3Dtests/tcg/$target/config-target.mak
> -      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target=
/Makefile"
> -      echo "# Automatically generated by configure - do not modify" > "$=
config_target_mak"
> -      echo "TARGET_NAME=3D$arch" >> "$config_target_mak"
> -      echo "TARGET=3D$target" >> "$config_target_mak"
> -      write_target_makefile "build-tcg-tests-$target" >> "$config_target=
_mak"
> -      echo "BUILD_STATIC=3D$build_static" >> "$config_target_mak"
> -      echo "QEMU=3D$PWD/$qemu" >> "$config_target_mak"
> -
> -      # will GDB work with these binaries?
> -      if test "${gdb_arches#*$arch}" !=3D "$gdb_arches"; then
> -          echo "GDB=3D$gdb_bin" >> $config_target_mak
> -      fi
> -
> -      if test "${gdb_arches#*$arch}" !=3D "$gdb_arches" && version_ge $g=
db_version 14.1; then
> -          echo "GDB_HAS_SME_TILES=3Dy" >> $config_target_mak
> -      else
> -          echo "GDB_HAS_SME_TILES=3Dn" >> $config_target_mak
> -      fi
> -
> -      if test "${gdb_arches#*aarch64}" !=3D "$gdb_arches" && version_ge =
$gdb_version 15.1; then
> -          echo "GDB_HAS_MTE=3Dy" >> $config_target_mak
> -      fi
> -
> -      if test "${gdb_arches#*aarch64}" !=3D "$gdb_arches" && version_ge =
$gdb_version 16.0; then
> -          # GDB has to support MTE in baremetal to allow debugging MTE i=
n QEMU system mode
> -          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=3Dy" >> $config_target_mak
> -      fi
> -
> -      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
> -      tcg_tests_with_compilers=3D"$tcg_tests_with_compilers $target"
> -  fi
> -done
> -
> -if test "$tcg" =3D "enabled"; then
> -    echo "TCG_TESTS_WITH_COMPILERS=3D$tcg_tests_with_compilers" >> $conf=
ig_host_mak
> -fi
> -
>  if test "$skip_meson" =3D no; then
>    cross=3D"config-meson.cross.new"
>    meson_quote() {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13F6C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtH-0005Ut-6P; Fri, 04 Sep 2026 09:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtD-0005T3-Sx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Tt9-0008GK-ED
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso15744385e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528205; x=1789133005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=seDNgLd0sJSB6WOuJJHDNE5SSJgLBO7WRGK6WSPxe20=;
 b=bsYKgC9Xt0HCN/Y4dGWccyudyorBYVLGkvlhjC/ElFasXs5lWaaYbTGF7/lo3bn34Q
 BHc1X+oa8evDznwWcixtzLXsoRmFw5MJcBe0W9XSktJZbMEDKnvDime7nte+OPTu6g+/
 C3NqDx6DYwEMcybHP1QN5quHr4Gptb6bMBGRYzrYIrKVJmqNcDMiOSoaXngOdd7wu8Iw
 5R1U+BKcEcCGx/TKsf12cuwbIeTOj75bSrmg5qKspFNIaAL8BYrV6OD80yjMrH4/ZVQ/
 Du9W+CPhLVUH2Hu2bsB5SnAy6muNKPC3Mwb6Yu+M1XpXaKDm5t7xa0zLsih3/XOYYfBS
 y1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528205; x=1789133005;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=seDNgLd0sJSB6WOuJJHDNE5SSJgLBO7WRGK6WSPxe20=;
 b=Cmcd7RtKwOL4GIpcrLFZDSERJjILUioe7kMNJuXsQOfqjg982vZ2hKp4wvowW82+A9
 /fQhjkIYuKKyBPK9g/SyPG5Rb+Ry6P+QLfsOJ4Jczj7P3RNiiogIwyhlBkwgzUlqrSD+
 +9/gs2scrRfBNigqyP4BC4HJMzmdaSgmppVZWR+fnXc8OSkzGcdKbb5e3+w6zGv8LkQJ
 RLURMXtX/cghiyv0NLbqY4T060VJwkRQ0CrjdPmv30ZVBMoll0Kx89dspgDAIxyLfWyD
 Xr8UXj9kkX3GFYtRSGf0ITMjXsqUBgB9B9HiEKZonp+tK3dccKJ8wg+svUfhCtbtpJpH
 6JKw==
X-Gm-Message-State: AFuF++l94S9Z2W7JRDjlMXO77AyaX/cvkJbOBS0nE2W3kM6UbYJ88BF/
 hsMKti5Hdz9xZaLqLFRff0EOZgdGHq9RumqE66+J/ZGMlzDzk3LWXo5heky3aJjAWAMz1MyjW1u
 0BrqBfSQ=
X-Gm-Gg: AYBFou2qixsNXAoypuVDMSAVf9psEv7I/rtfeP9kaamJTnrBb5x5FHV7PvHbdw7xSWz
 RlbKPbsC4ZMlf2cxMkneUPz1qG+rDW1wz8Ff6JuDXplg+LcW6o+2dyFfDOq7OkyyUrjcQnGebgY
 BNmuf9z1TObsPYO1XaFSQ5ilv63W672OtOMQB8YNBtExK44B715LGBJkEHHmHcuyT2LR+BozFFT
 OgHZgEOKqXmAW8XpRAemc//lMqMfx5Pb5G5SaNEepCKsf7d0dsxK2dKY0rmsKGrHaWsPouePPBC
 Ib4wFVLWASY+qF9lNp9pZAy8Q/6KLQX0e13BEG7V2SM9jTJ6hHc51OoELW8l77Dh10u2ET7Sw56
 //DZnLYNW7nIgquCh38pSOJY49gu5NK7g7+lAPpeEBSfS/kGk65JUE9dtN/7WTJRUYu5HWnDEou
 6sBayIO0qttOqOgDKYqwDM6Azi0CzWfN7ZFTlUe91qtcm/xWrEdfTT1zGq5Lo3
X-Received: by 2002:a05:600c:8708:b0:49c:fa21:1c7c with SMTP id
 5b1f17b1804b1-49cfa211d48mr37430285e9.17.1788528205244; 
 Fri, 04 Sep 2026 06:23:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm151846605e9.15.2026.09.04.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4009761E2E;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 102/105] configure: remove cross_cc and gdb detection logic
Date: Fri,  4 Sep 2026 13:45:56 +0100
Message-ID: <20260904124604.2207440-103-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We have now implemented the same in meson directly, so no need to keep
it on configure side. Also, we have no more Makefile consumers, so we
don't need to export all those variables anymore.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-103-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index 1973f023b1e..aaa41fe47aa 100755
--- a/configure
+++ b/configure
@@ -1266,366 +1266,6 @@ EOF
   fi
 fi
 
-##########################################
-# functions to probe cross compilers
-
-if test "$container_command" = ""; then
-    container_command=$($python "$source_path"/tests/docker/docker.py probe)
-    test "$container_command" = "no" && container_command=""
-fi
-if test $use_containers = "yes" && test "$container_command" != ""; then
-    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
-fi
-
-# cross compilers defaults, can be overridden with --cross-cc-ARCH
-: ${cross_prefix_aarch64="aarch64-linux-gnu-"}
-: ${cross_prefix_aarch64_be="$cross_prefix_aarch64"}
-: ${cross_prefix_alpha="alpha-linux-gnu-"}
-: ${cross_prefix_arm="arm-linux-gnueabihf-"}
-: ${cross_prefix_armeb="$cross_prefix_arm"}
-: ${cross_prefix_hexagon="hexagon-unknown-linux-musl-"}
-: ${cross_prefix_loongarch64="loongarch64-unknown-linux-gnu-"}
-: ${cross_prefix_hppa="hppa-linux-gnu-"}
-: ${cross_prefix_i386="i686-linux-gnu-"}
-: ${cross_prefix_m68k="m68k-linux-gnu-"}
-: ${cross_prefix_microblaze="microblaze-linux-musl-"}
-: ${cross_prefix_mips64el="mips64el-linux-gnuabi64-"}
-: ${cross_prefix_mips64="mips64-linux-gnuabi64-"}
-: ${cross_prefix_mipsel="mipsel-linux-gnu-"}
-: ${cross_prefix_mips="mips-linux-gnu-"}
-: ${cross_prefix_ppc="powerpc-linux-gnu-"}
-: ${cross_prefix_ppc64="powerpc64-linux-gnu-"}
-: ${cross_prefix_ppc64le="$cross_prefix_ppc64"}
-: ${cross_prefix_riscv64="riscv64-linux-gnu-"}
-: ${cross_prefix_s390x="s390x-linux-gnu-"}
-: ${cross_prefix_sh4="sh4-linux-gnu-"}
-: ${cross_prefix_sparc64="sparc64-linux-gnu-"}
-: ${cross_prefix_sparc="$cross_prefix_sparc64"}
-: ${cross_prefix_tricore="tricore-"}
-: ${cross_prefix_x86_64="x86_64-linux-gnu-"}
-
-: ${cross_cc_aarch64_be="$cross_cc_aarch64"}
-: ${cross_cc_cflags_aarch64_be="-mbig-endian"}
-: ${cross_cc_armeb="$cross_cc_arm"}
-: ${cross_cc_cflags_armeb="-mbig-endian"}
-: ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
-: ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
-: ${cross_cc_cflags_i386="-m32"}
-: ${cross_cc_cflags_ppc="-m32 -mbig-endian"}
-: ${cross_cc_cflags_ppc64="-m64 -mbig-endian"}
-: ${cross_cc_ppc64le="$cross_cc_ppc64"}
-: ${cross_cc_cflags_ppc64le="-m64 -mlittle-endian"}
-: ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
-: ${cross_cc_sparc="$cross_cc_sparc64"}
-: ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
-: ${cross_cc_cflags_x86_64="-m64 -mcx16"}
-
-compute_target_variable() {
-  eval "$2="
-  if eval test -n "\"\${cross_prefix_$1}\""; then
-    if eval has "\"\${cross_prefix_$1}\$3\""; then
-      eval "$2=\"\${cross_prefix_$1}\$3\""
-    fi
-  fi
-}
-
-have_target() {
-  for i; do
-    case " $target_list " in
-      *" $i "*) return 0;;
-      *) ;;
-    esac
-  done
-  return 1
-}
-
-# probe_target_compiler TARGET
-#
-# Look for a compiler for the given target, either native or cross.
-# Set variables target_* if a compiler is found, and container_cross_*
-# if a Docker-based cross-compiler image is known for the target.
-# Set got_cross_cc to yes/no depending on whether a non-container-based
-# compiler was found.
-#
-# If TARGET is a user-mode emulation target, also set build_static to
-# "y" if static linking is possible.
-#
-probe_target_compiler() {
-  # reset all output variables
-  got_cross_cc=no
-  container_image=
-  container_hosts=
-  container_cross_prefix=
-  container_cross_cc=
-  container_cross_ar=
-  container_cross_as=
-  container_cross_ld=
-  container_cross_nm=
-  container_cross_objcopy=
-  container_cross_ranlib=
-  container_cross_strip=
-
-  target_arch=${1%%-*}
-  case $target_arch in
-    aarch64) container_hosts="x86_64 aarch64" ;;
-    aarch64_be) container_hosts="x86_64 aarch64" ;;
-    alpha) container_hosts=x86_64 ;;
-    arm) container_hosts="x86_64 aarch64" ;;
-    hexagon) container_hosts=x86_64 ;;
-    hppa) container_hosts=x86_64 ;;
-    i386) container_hosts=x86_64 ;;
-    loongarch64) container_hosts=x86_64 ;;
-    m68k) container_hosts=x86_64 ;;
-    microblaze) container_hosts=x86_64 ;;
-    mips64el) container_hosts=x86_64 ;;
-    mips64) container_hosts=x86_64 ;;
-    mipsel) container_hosts=x86_64 ;;
-    mips) container_hosts=x86_64 ;;
-    ppc) container_hosts=x86_64 ;;
-    ppc64|ppc64le) container_hosts=x86_64 ;;
-    riscv64) container_hosts=x86_64 ;;
-    s390x) container_hosts=x86_64 ;;
-    sh4) container_hosts=x86_64 ;;
-    sparc64) container_hosts=x86_64 ;;
-    tricore) container_hosts=x86_64 ;;
-    x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
-    xtensa*) container_hosts=x86_64 ;;
-  esac
-
-  for host in $container_hosts; do
-    test "$container_command" != "" || continue
-    test "$host" = "$cpu" || continue
-    case $target_arch in
-      # debian-all-test-cross architectures
-
-      aarch64_be)
-        container_image=debian-all-test-cross
-        container_cross_prefix=aarch64-linux-gnu-
-        ;;
-      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
-        container_image=debian-all-test-cross
-        ;;
-      mips64)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips64-linux-gnuabi64-
-        ;;
-      ppc|ppc64|ppc64le)
-        container_image=debian-all-test-cross
-        container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
-        ;;
-
-      # architectures with individual containers
-
-      aarch64)
-        # We don't have any bigendian build tools so we only use this for AArch64
-        container_image=debian-arm64-cross
-        ;;
-      arm)
-        # We don't have any bigendian build tools so we only use this for ARM
-        container_image=debian-armhf-cross
-        container_cross_prefix=arm-linux-gnueabihf-
-        ;;
-      hexagon)
-        container_cross_prefix=hexagon-unknown-linux-musl-
-        container_cross_cc=${container_cross_prefix}clang
-        ;;
-      i386)
-        container_image=debian-i686-cross
-        container_cross_prefix=i686-linux-gnu-
-        ;;
-      loongarch64)
-        container_image=debian-loongarch-cross
-        container_cross_prefix=loongarch64-unknown-linux-gnu-
-        ;;
-      microblaze)
-        container_cross_prefix=microblaze-linux-musl-
-        ;;
-      mips64el)
-        container_image=debian-all-test-cross
-        container_cross_prefix=mips64el-linux-gnuabi64-
-        ;;
-      tricore)
-        container_image=debian-tricore-cross
-        container_cross_prefix=tricore-
-        ;;
-      x86_64)
-        container_image=debian-amd64-cross
-        ;;
-      xtensa*)
-        container_image=debian-xtensa-cross
-
-        # default to the dc232b cpu
-        container_cross_prefix=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-
-        ;;
-    esac
-    # Debian and GNU architecture names usually match
-    : ${container_image:=debian-$target_arch-cross}
-    : ${container_cross_prefix:=$target_arch-linux-gnu-}
-    : ${container_cross_cc:=${container_cross_prefix}gcc}
-    : ${container_cross_ar:=${container_cross_prefix}ar}
-    : ${container_cross_as:=${container_cross_prefix}as}
-    : ${container_cross_ld:=${container_cross_prefix}ld}
-    : ${container_cross_nm:=${container_cross_prefix}nm}
-    : ${container_cross_objcopy:=${container_cross_prefix}objcopy}
-    : ${container_cross_ranlib:=${container_cross_prefix}ranlib}
-    : ${container_cross_strip:=${container_cross_prefix}strip}
-  done
-
-  try=cross
-  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
-  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
-      case "$target_arch:$cpu" in
-        aarch64_be:aarch64 | \
-        armeb:arm | \
-        i386:x86_64 | \
-        ppc*:ppc64 | \
-        sparc:sparc64 | \
-        "$cpu:$cpu")
-        try='native cross' ;;
-      esac
-  fi
-  eval "target_cflags=\${cross_cc_cflags_$target_arch}"
-  for thistry in $try; do
-    case $thistry in
-    native)
-      target_cc=$cc
-      target_ccas=$ccas
-      target_ar=$ar
-      target_as=$as
-      target_ld=$ld
-      target_nm=$nm
-      target_objcopy=$objcopy
-      target_ranlib=$ranlib
-      target_strip=$strip
-      ;;
-    cross)
-      target_cc=
-      if eval test -n "\"\${cross_cc_$target_arch}\""; then
-        if eval has "\"\${cross_cc_$target_arch}\""; then
-          eval "target_cc=\"\${cross_cc_$target_arch}\""
-        fi
-      else
-        compute_target_variable $target_arch target_cc gcc
-      fi
-      target_ccas=$target_cc
-      compute_target_variable $target_arch target_ar ar
-      compute_target_variable $target_arch target_as as
-      compute_target_variable $target_arch target_ld ld
-      compute_target_variable $target_arch target_nm nm
-      compute_target_variable $target_arch target_objcopy objcopy
-      compute_target_variable $target_arch target_ranlib ranlib
-      compute_target_variable $target_arch target_strip strip
-      ;;
-    esac
-
-    if test -n "$target_cc"; then
-      case $target_arch in
-        i386|x86_64)
-          if $target_cc --version | grep -qi "clang"; then
-            continue
-          fi
-          ;;
-      esac
-    elif test -n "$target_as" && test -n "$target_ld"; then
-      # Special handling for assembler only targets
-      case $target in
-        tricore-softmmu)
-          build_static=
-          got_cross_cc=yes
-          break
-          ;;
-        *)
-          continue
-          ;;
-      esac
-    else
-      continue
-    fi
-
-    write_c_skeleton
-    case $1 in
-      *-softmmu)
-        if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
-          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
-          got_cross_cc=yes
-          break
-        fi
-        ;;
-      *)
-        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC -static ; then
-          build_static=y
-          got_cross_cc=yes
-          break
-        fi
-        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC ; then
-          build_static=
-          got_cross_cc=yes
-          break
-        fi
-        ;;
-    esac
-  done
-  if test $got_cross_cc != yes; then
-    build_static=
-    target_cc=
-    target_ccas=
-    target_ar=
-    target_as=
-    target_ld=
-    target_nm=
-    target_objcopy=
-    target_ranlib=
-    target_strip=
-  fi
-  test -n "$target_cc"
-}
-
-write_target_makefile() {
-  echo "PYTHON=$python"
-  echo "EXTRA_CFLAGS=$target_cflags"
-  if test -z "$target_cc" && test -z "$target_as"; then
-    test -z "$container_image" && error_exit "Internal error: could not find cross compiler for $1?"
-    echo "$1: docker-image-$container_image" >> Makefile.prereqs
-    if test -n "$container_cross_cc"; then
-      echo "CC=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
-      echo "CCAS=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
-    fi
-    echo "AR=$docker_py cc --cc $container_cross_ar -i qemu/$container_image -s $source_path --"
-    echo "AS=$docker_py cc --cc $container_cross_as -i qemu/$container_image -s $source_path --"
-    echo "LD=$docker_py cc --cc $container_cross_ld -i qemu/$container_image -s $source_path --"
-    echo "NM=$docker_py cc --cc $container_cross_nm -i qemu/$container_image -s $source_path --"
-    echo "OBJCOPY=$docker_py cc --cc $container_cross_objcopy -i qemu/$container_image -s $source_path --"
-    echo "RANLIB=$docker_py cc --cc $container_cross_ranlib -i qemu/$container_image -s $source_path --"
-    echo "STRIP=$docker_py cc --cc $container_cross_strip -i qemu/$container_image -s $source_path --"
-  else
-    if test -n "$target_cc"; then
-      echo "CC=$target_cc"
-      echo "CCAS=$target_ccas"
-    fi
-    if test -n "$target_ar"; then
-      echo "AR=$target_ar"
-    fi
-    if test -n "$target_as"; then
-      echo "AS=$target_as"
-    fi
-    if test -n "$target_ld"; then
-      echo "LD=$target_ld"
-    fi
-    if test -n "$target_nm"; then
-      echo "NM=$target_nm"
-    fi
-    if test -n "$target_objcopy"; then
-      echo "OBJCOPY=$target_objcopy"
-    fi
-    if test -n "$target_ranlib"; then
-      echo "RANLIB=$target_ranlib"
-    fi
-    if test -n "$target_strip"; then
-      echo "STRIP=$target_strip"
-    fi
-  fi
-}
-
 #######################################
 # cross-compiled firmware targets
 
@@ -1659,48 +1299,6 @@ fi
 
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
-# Mac OS X ships with a broken assembler
-if have_target i386-softmmu x86_64-softmmu && \
-        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
-        test "$host_os" != "haiku" && \
-        probe_target_compiler i386-softmmu; then
-    subdirs="$subdirs pc-bios/optionrom"
-    config_mak=pc-bios/optionrom/config.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "TOPSRC_DIR=$source_path" >> $config_mak
-    write_target_makefile >> $config_mak
-fi
-
-if have_target ppc-softmmu ppc64-softmmu && \
-        probe_target_compiler ppc-softmmu; then
-    subdirs="$subdirs pc-bios/vof"
-    config_mak=pc-bios/vof/config.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
-    write_target_makefile >> $config_mak
-fi
-
-# Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
-# (which is the lowest architecture level that Clang supports)
-if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
-    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
-  write_c_skeleton
-  do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
-  has_z900=$?
-  if [ $has_z900 = 0 ] || do_compiler "$target_cc" $target_cc_cflags -march=z10 -msoft-float -Werror -o $TMPO -c $TMPC; then
-    if [ $has_z900 != 0 ]; then
-      echo "WARNING: Your compiler does not support the z900!"
-      echo "         The s390-ccw bios will only work with guest CPUs >= z10."
-    fi
-    subdirs="$subdirs pc-bios/s390-ccw"
-    config_mak=pc-bios/s390-ccw/config-host.mak
-    echo "# Automatically generated by configure - do not modify" > $config_mak
-    echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
-    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
-    write_target_makefile >> $config_mak
-  fi
-fi
-
 #######################################
 # generate config-host.mak
 
@@ -1724,65 +1322,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-tcg_tests_with_compilers=
-for target in $target_list; do
-  arch=${target%%-*}
-
-  case $target in
-    xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build system tests
-      continue
-      ;;
-    *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
-      qemu="qemu-system-$arch"
-      ;;
-    *-linux-user|*-bsd-user)
-      qemu="qemu-$arch"
-      ;;
-  esac
-
-  if probe_target_compiler $target || test -n "$container_image"; then
-      test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
-      echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
-      echo "TARGET_NAME=$arch" >> "$config_target_mak"
-      echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
-      echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
-      echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
-
-      # will GDB work with these binaries?
-      if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "GDB=$gdb_bin" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
-          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
-      else
-          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
-          echo "GDB_HAS_MTE=y" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
-          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
-          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
-      fi
-
-      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
-  fi
-done
-
-if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
-fi
-
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
-- 
2.47.3



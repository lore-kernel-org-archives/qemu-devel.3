Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B3C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOw-0007rt-3I; Wed, 16 Sep 2026 04:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOq-0007lF-IS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:53 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOl-0004z8-K8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:52 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso4946595e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548826; x=1790153626; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pz6D5LdjE3kJJTO4sUmd2SawfSM3Mp74GJqeo4tLsQA=;
 b=J4B+S6leX9YfVASObyjZVsxx77qtlN+g/Mwl5qxMGaIc6a1xtLJd+mZcK7Rm7rgDmX
 wN6GSpHKGR2nnlTj63kMwKZfm3U2QxwsdU8qS31Ev0/7IlzFKmiayJ0sPGGXryTY/uxH
 ttUHIUAihMdO17URz/oB3wYqKyEzNN9t3EowR86HxRCReFN2TgffJ3Be9P2XOt+PyOzH
 chNrHS9haCXO3j9AZSUW5fdMVttDFjn2hlqHp/rvY3EMT+zqQhseP/vjl2tF7Au9Rt44
 pf0WMjP4vYoWAEa480MR9pH03FEkDUZ5+KuXwW569KVfBs3tms8F11jSmhjXoNQNd+Ef
 xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548826; x=1790153626;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pz6D5LdjE3kJJTO4sUmd2SawfSM3Mp74GJqeo4tLsQA=;
 b=YdWEDevwTm+y55vhuRUO7JAQzWNXcZdVIZJbqlS/cabSld15IZ7gKyno5eZKAhHFJm
 5akDLKlyPd7O9ACgDmtUY4qzklVCzkrWjDbzQrb9KLBFY1W1ISvl1U34NCxlJINnN+b6
 D+1FwelZhV9tuqv8fFnZtVgyR7Te/oPcIYbRq+hZE7GIy5+wHXgBmvS92hp0dcSjOiGB
 jEIkjNlYB4Qhc7/y7BRFpR2WracdUzSoBoakarJ/MSGKSCHoZjqp6iua1xTdGgv/gqxR
 A2T3BuNWrB4k5YmRzlhCss6xXohPWfgmmM5vAuWC8PX2G/7klcS0N7K5tL4Q/noqFfNZ
 nnxQ==
X-Gm-Message-State: AFuF++lbZSLaJUrFLKFx4QLuJF6LmZHfW16L3pWpaeAg64JqLoMmbAGB
 NRozDyZLXSLQmLPBbka+5hQJ7W0DvzvOHxgVTTbQ5I1Fferm4jENSt/vUUo3UPZM6CA=
X-Gm-Gg: AYBFou2pQIIzYLi5y9AWzYIJ8lzqtdkmhqInDmvavuuahYHIiWhdRj/xtAMXv41G1BJ
 mcQARvTgZZ+L+WhVCU7GeWiSimCkNHDJS1eOqibVdJA0pvKIXD5x5mupe6KceS3M2BDcHRxpqy1
 67wJuDWbppEiuhHsUWlO3fH1DmeXpGxuLhVq9dr/1U6DNShh0hxfN0yJzYCAMvf+Btv48PfgJDI
 IvBHvJonkxYKBVYjyRGW6+29qxQVj05P4SqukJ+CV1ffiz1gGDCU6uxRGCYbYQnf1ysKziO07TL
 EZw6FUHokH1f/H83YECjBiAMYubJr5dEaFtDYsi2yS4sPYuMROTSKUaayIGp46iCH1ntrVvyaVg
 yodNsSYs0YI6+hK8CGSHG+Jd/nzugGFg2Nj39dtWtPSwpvywJKh/mUJoO8ao9fLi07g6gU+soww
 CrhtAPxn6qQxUl8nb8IQKEMSYOhEVtbFqgsm6HfC+N46+Sns9YLE9VCaECVagXGRB+lF+E9U6F5
 26swTvXBQ==
X-Received: by 2002:a05:600c:8b6a:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49eb72f62a1mr16541175e9.13.1789548825894; 
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83dbb0c1sm65232915e9.14.2026.09.16.01.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8484B616E3;
 Wed, 16 Sep 2026 09:53:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 01/17] Revert "configure: remove cross_cc and gdb detection
 logic"
Date: Wed, 16 Sep 2026 09:53:24 +0100
Message-ID: <20260916085341.1692742-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to restore the logic to configure as it's also used by the
firmware builds.

This reverts commit 031f935567ab8abfa4e84682ecea08915ca9656d.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)

diff --git a/configure b/configure
index aaa41fe47aa..1973f023b1e 100755
--- a/configure
+++ b/configure
@@ -1266,6 +1266,366 @@ EOF
   fi
 fi
 
+##########################################
+# functions to probe cross compilers
+
+if test "$container_command" = ""; then
+    container_command=$($python "$source_path"/tests/docker/docker.py probe)
+    test "$container_command" = "no" && container_command=""
+fi
+if test $use_containers = "yes" && test "$container_command" != ""; then
+    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
+fi
+
+# cross compilers defaults, can be overridden with --cross-cc-ARCH
+: ${cross_prefix_aarch64="aarch64-linux-gnu-"}
+: ${cross_prefix_aarch64_be="$cross_prefix_aarch64"}
+: ${cross_prefix_alpha="alpha-linux-gnu-"}
+: ${cross_prefix_arm="arm-linux-gnueabihf-"}
+: ${cross_prefix_armeb="$cross_prefix_arm"}
+: ${cross_prefix_hexagon="hexagon-unknown-linux-musl-"}
+: ${cross_prefix_loongarch64="loongarch64-unknown-linux-gnu-"}
+: ${cross_prefix_hppa="hppa-linux-gnu-"}
+: ${cross_prefix_i386="i686-linux-gnu-"}
+: ${cross_prefix_m68k="m68k-linux-gnu-"}
+: ${cross_prefix_microblaze="microblaze-linux-musl-"}
+: ${cross_prefix_mips64el="mips64el-linux-gnuabi64-"}
+: ${cross_prefix_mips64="mips64-linux-gnuabi64-"}
+: ${cross_prefix_mipsel="mipsel-linux-gnu-"}
+: ${cross_prefix_mips="mips-linux-gnu-"}
+: ${cross_prefix_ppc="powerpc-linux-gnu-"}
+: ${cross_prefix_ppc64="powerpc64-linux-gnu-"}
+: ${cross_prefix_ppc64le="$cross_prefix_ppc64"}
+: ${cross_prefix_riscv64="riscv64-linux-gnu-"}
+: ${cross_prefix_s390x="s390x-linux-gnu-"}
+: ${cross_prefix_sh4="sh4-linux-gnu-"}
+: ${cross_prefix_sparc64="sparc64-linux-gnu-"}
+: ${cross_prefix_sparc="$cross_prefix_sparc64"}
+: ${cross_prefix_tricore="tricore-"}
+: ${cross_prefix_x86_64="x86_64-linux-gnu-"}
+
+: ${cross_cc_aarch64_be="$cross_cc_aarch64"}
+: ${cross_cc_cflags_aarch64_be="-mbig-endian"}
+: ${cross_cc_armeb="$cross_cc_arm"}
+: ${cross_cc_cflags_armeb="-mbig-endian"}
+: ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
+: ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
+: ${cross_cc_cflags_i386="-m32"}
+: ${cross_cc_cflags_ppc="-m32 -mbig-endian"}
+: ${cross_cc_cflags_ppc64="-m64 -mbig-endian"}
+: ${cross_cc_ppc64le="$cross_cc_ppc64"}
+: ${cross_cc_cflags_ppc64le="-m64 -mlittle-endian"}
+: ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
+: ${cross_cc_sparc="$cross_cc_sparc64"}
+: ${cross_cc_cflags_sparc="-m32 -mcpu=supersparc"}
+: ${cross_cc_cflags_x86_64="-m64 -mcx16"}
+
+compute_target_variable() {
+  eval "$2="
+  if eval test -n "\"\${cross_prefix_$1}\""; then
+    if eval has "\"\${cross_prefix_$1}\$3\""; then
+      eval "$2=\"\${cross_prefix_$1}\$3\""
+    fi
+  fi
+}
+
+have_target() {
+  for i; do
+    case " $target_list " in
+      *" $i "*) return 0;;
+      *) ;;
+    esac
+  done
+  return 1
+}
+
+# probe_target_compiler TARGET
+#
+# Look for a compiler for the given target, either native or cross.
+# Set variables target_* if a compiler is found, and container_cross_*
+# if a Docker-based cross-compiler image is known for the target.
+# Set got_cross_cc to yes/no depending on whether a non-container-based
+# compiler was found.
+#
+# If TARGET is a user-mode emulation target, also set build_static to
+# "y" if static linking is possible.
+#
+probe_target_compiler() {
+  # reset all output variables
+  got_cross_cc=no
+  container_image=
+  container_hosts=
+  container_cross_prefix=
+  container_cross_cc=
+  container_cross_ar=
+  container_cross_as=
+  container_cross_ld=
+  container_cross_nm=
+  container_cross_objcopy=
+  container_cross_ranlib=
+  container_cross_strip=
+
+  target_arch=${1%%-*}
+  case $target_arch in
+    aarch64) container_hosts="x86_64 aarch64" ;;
+    aarch64_be) container_hosts="x86_64 aarch64" ;;
+    alpha) container_hosts=x86_64 ;;
+    arm) container_hosts="x86_64 aarch64" ;;
+    hexagon) container_hosts=x86_64 ;;
+    hppa) container_hosts=x86_64 ;;
+    i386) container_hosts=x86_64 ;;
+    loongarch64) container_hosts=x86_64 ;;
+    m68k) container_hosts=x86_64 ;;
+    microblaze) container_hosts=x86_64 ;;
+    mips64el) container_hosts=x86_64 ;;
+    mips64) container_hosts=x86_64 ;;
+    mipsel) container_hosts=x86_64 ;;
+    mips) container_hosts=x86_64 ;;
+    ppc) container_hosts=x86_64 ;;
+    ppc64|ppc64le) container_hosts=x86_64 ;;
+    riscv64) container_hosts=x86_64 ;;
+    s390x) container_hosts=x86_64 ;;
+    sh4) container_hosts=x86_64 ;;
+    sparc64) container_hosts=x86_64 ;;
+    tricore) container_hosts=x86_64 ;;
+    x86_64) container_hosts="aarch64 ppc64le x86_64" ;;
+    xtensa*) container_hosts=x86_64 ;;
+  esac
+
+  for host in $container_hosts; do
+    test "$container_command" != "" || continue
+    test "$host" = "$cpu" || continue
+    case $target_arch in
+      # debian-all-test-cross architectures
+
+      aarch64_be)
+        container_image=debian-all-test-cross
+        container_cross_prefix=aarch64-linux-gnu-
+        ;;
+      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
+        container_image=debian-all-test-cross
+        ;;
+      mips64)
+        container_image=debian-all-test-cross
+        container_cross_prefix=mips64-linux-gnuabi64-
+        ;;
+      ppc|ppc64|ppc64le)
+        container_image=debian-all-test-cross
+        container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
+        ;;
+
+      # architectures with individual containers
+
+      aarch64)
+        # We don't have any bigendian build tools so we only use this for AArch64
+        container_image=debian-arm64-cross
+        ;;
+      arm)
+        # We don't have any bigendian build tools so we only use this for ARM
+        container_image=debian-armhf-cross
+        container_cross_prefix=arm-linux-gnueabihf-
+        ;;
+      hexagon)
+        container_cross_prefix=hexagon-unknown-linux-musl-
+        container_cross_cc=${container_cross_prefix}clang
+        ;;
+      i386)
+        container_image=debian-i686-cross
+        container_cross_prefix=i686-linux-gnu-
+        ;;
+      loongarch64)
+        container_image=debian-loongarch-cross
+        container_cross_prefix=loongarch64-unknown-linux-gnu-
+        ;;
+      microblaze)
+        container_cross_prefix=microblaze-linux-musl-
+        ;;
+      mips64el)
+        container_image=debian-all-test-cross
+        container_cross_prefix=mips64el-linux-gnuabi64-
+        ;;
+      tricore)
+        container_image=debian-tricore-cross
+        container_cross_prefix=tricore-
+        ;;
+      x86_64)
+        container_image=debian-amd64-cross
+        ;;
+      xtensa*)
+        container_image=debian-xtensa-cross
+
+        # default to the dc232b cpu
+        container_cross_prefix=/opt/2020.07/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-
+        ;;
+    esac
+    # Debian and GNU architecture names usually match
+    : ${container_image:=debian-$target_arch-cross}
+    : ${container_cross_prefix:=$target_arch-linux-gnu-}
+    : ${container_cross_cc:=${container_cross_prefix}gcc}
+    : ${container_cross_ar:=${container_cross_prefix}ar}
+    : ${container_cross_as:=${container_cross_prefix}as}
+    : ${container_cross_ld:=${container_cross_prefix}ld}
+    : ${container_cross_nm:=${container_cross_prefix}nm}
+    : ${container_cross_objcopy:=${container_cross_prefix}objcopy}
+    : ${container_cross_ranlib:=${container_cross_prefix}ranlib}
+    : ${container_cross_strip:=${container_cross_prefix}strip}
+  done
+
+  try=cross
+  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
+  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
+      case "$target_arch:$cpu" in
+        aarch64_be:aarch64 | \
+        armeb:arm | \
+        i386:x86_64 | \
+        ppc*:ppc64 | \
+        sparc:sparc64 | \
+        "$cpu:$cpu")
+        try='native cross' ;;
+      esac
+  fi
+  eval "target_cflags=\${cross_cc_cflags_$target_arch}"
+  for thistry in $try; do
+    case $thistry in
+    native)
+      target_cc=$cc
+      target_ccas=$ccas
+      target_ar=$ar
+      target_as=$as
+      target_ld=$ld
+      target_nm=$nm
+      target_objcopy=$objcopy
+      target_ranlib=$ranlib
+      target_strip=$strip
+      ;;
+    cross)
+      target_cc=
+      if eval test -n "\"\${cross_cc_$target_arch}\""; then
+        if eval has "\"\${cross_cc_$target_arch}\""; then
+          eval "target_cc=\"\${cross_cc_$target_arch}\""
+        fi
+      else
+        compute_target_variable $target_arch target_cc gcc
+      fi
+      target_ccas=$target_cc
+      compute_target_variable $target_arch target_ar ar
+      compute_target_variable $target_arch target_as as
+      compute_target_variable $target_arch target_ld ld
+      compute_target_variable $target_arch target_nm nm
+      compute_target_variable $target_arch target_objcopy objcopy
+      compute_target_variable $target_arch target_ranlib ranlib
+      compute_target_variable $target_arch target_strip strip
+      ;;
+    esac
+
+    if test -n "$target_cc"; then
+      case $target_arch in
+        i386|x86_64)
+          if $target_cc --version | grep -qi "clang"; then
+            continue
+          fi
+          ;;
+      esac
+    elif test -n "$target_as" && test -n "$target_ld"; then
+      # Special handling for assembler only targets
+      case $target in
+        tricore-softmmu)
+          build_static=
+          got_cross_cc=yes
+          break
+          ;;
+        *)
+          continue
+          ;;
+      esac
+    else
+      continue
+    fi
+
+    write_c_skeleton
+    case $1 in
+      *-softmmu)
+        if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
+          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
+          got_cross_cc=yes
+          break
+        fi
+        ;;
+      *)
+        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC -static ; then
+          build_static=y
+          got_cross_cc=yes
+          break
+        fi
+        if do_compiler "$target_cc" $target_cflags -o $TMPE $TMPC ; then
+          build_static=
+          got_cross_cc=yes
+          break
+        fi
+        ;;
+    esac
+  done
+  if test $got_cross_cc != yes; then
+    build_static=
+    target_cc=
+    target_ccas=
+    target_ar=
+    target_as=
+    target_ld=
+    target_nm=
+    target_objcopy=
+    target_ranlib=
+    target_strip=
+  fi
+  test -n "$target_cc"
+}
+
+write_target_makefile() {
+  echo "PYTHON=$python"
+  echo "EXTRA_CFLAGS=$target_cflags"
+  if test -z "$target_cc" && test -z "$target_as"; then
+    test -z "$container_image" && error_exit "Internal error: could not find cross compiler for $1?"
+    echo "$1: docker-image-$container_image" >> Makefile.prereqs
+    if test -n "$container_cross_cc"; then
+      echo "CC=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
+      echo "CCAS=$docker_py cc --cc $container_cross_cc -i qemu/$container_image -s $source_path --"
+    fi
+    echo "AR=$docker_py cc --cc $container_cross_ar -i qemu/$container_image -s $source_path --"
+    echo "AS=$docker_py cc --cc $container_cross_as -i qemu/$container_image -s $source_path --"
+    echo "LD=$docker_py cc --cc $container_cross_ld -i qemu/$container_image -s $source_path --"
+    echo "NM=$docker_py cc --cc $container_cross_nm -i qemu/$container_image -s $source_path --"
+    echo "OBJCOPY=$docker_py cc --cc $container_cross_objcopy -i qemu/$container_image -s $source_path --"
+    echo "RANLIB=$docker_py cc --cc $container_cross_ranlib -i qemu/$container_image -s $source_path --"
+    echo "STRIP=$docker_py cc --cc $container_cross_strip -i qemu/$container_image -s $source_path --"
+  else
+    if test -n "$target_cc"; then
+      echo "CC=$target_cc"
+      echo "CCAS=$target_ccas"
+    fi
+    if test -n "$target_ar"; then
+      echo "AR=$target_ar"
+    fi
+    if test -n "$target_as"; then
+      echo "AS=$target_as"
+    fi
+    if test -n "$target_ld"; then
+      echo "LD=$target_ld"
+    fi
+    if test -n "$target_nm"; then
+      echo "NM=$target_nm"
+    fi
+    if test -n "$target_objcopy"; then
+      echo "OBJCOPY=$target_objcopy"
+    fi
+    if test -n "$target_ranlib"; then
+      echo "RANLIB=$target_ranlib"
+    fi
+    if test -n "$target_strip"; then
+      echo "STRIP=$target_strip"
+    fi
+  fi
+}
+
 #######################################
 # cross-compiled firmware targets
 
@@ -1299,6 +1659,48 @@ fi
 
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
+# Mac OS X ships with a broken assembler
+if have_target i386-softmmu x86_64-softmmu && \
+        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
+        test "$host_os" != "haiku" && \
+        probe_target_compiler i386-softmmu; then
+    subdirs="$subdirs pc-bios/optionrom"
+    config_mak=pc-bios/optionrom/config.mak
+    echo "# Automatically generated by configure - do not modify" > $config_mak
+    echo "TOPSRC_DIR=$source_path" >> $config_mak
+    write_target_makefile >> $config_mak
+fi
+
+if have_target ppc-softmmu ppc64-softmmu && \
+        probe_target_compiler ppc-softmmu; then
+    subdirs="$subdirs pc-bios/vof"
+    config_mak=pc-bios/vof/config.mak
+    echo "# Automatically generated by configure - do not modify" > $config_mak
+    echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
+    write_target_makefile >> $config_mak
+fi
+
+# Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
+# (which is the lowest architecture level that Clang supports)
+if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
+    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
+  write_c_skeleton
+  do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
+  has_z900=$?
+  if [ $has_z900 = 0 ] || do_compiler "$target_cc" $target_cc_cflags -march=z10 -msoft-float -Werror -o $TMPO -c $TMPC; then
+    if [ $has_z900 != 0 ]; then
+      echo "WARNING: Your compiler does not support the z900!"
+      echo "         The s390-ccw bios will only work with guest CPUs >= z10."
+    fi
+    subdirs="$subdirs pc-bios/s390-ccw"
+    config_mak=pc-bios/s390-ccw/config-host.mak
+    echo "# Automatically generated by configure - do not modify" > $config_mak
+    echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
+    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
+    write_target_makefile >> $config_mak
+  fi
+fi
+
 #######################################
 # generate config-host.mak
 
@@ -1322,6 +1724,65 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
+tcg_tests_with_compilers=
+for target in $target_list; do
+  arch=${target%%-*}
+
+  case $target in
+    xtensa*-linux-user)
+      # the toolchain is not complete with headers, only build system tests
+      continue
+      ;;
+    *-softmmu)
+      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
+      qemu="qemu-system-$arch"
+      ;;
+    *-linux-user|*-bsd-user)
+      qemu="qemu-$arch"
+      ;;
+  esac
+
+  if probe_target_compiler $target || test -n "$container_image"; then
+      test -n "$container_image" && build_static=y
+      mkdir -p "tests/tcg/$target"
+      config_target_mak=tests/tcg/$target/config-target.mak
+      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+      echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
+      echo "TARGET_NAME=$arch" >> "$config_target_mak"
+      echo "TARGET=$target" >> "$config_target_mak"
+      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
+      echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
+      echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
+
+      # will GDB work with these binaries?
+      if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
+          echo "GDB=$gdb_bin" >> $config_target_mak
+      fi
+
+      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
+          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
+      else
+          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
+      fi
+
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
+          echo "GDB_HAS_MTE=y" >> $config_target_mak
+      fi
+
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
+          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
+          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
+      fi
+
+      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
+      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
+  fi
+done
+
+if test "$tcg" = "enabled"; then
+    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
+fi
+
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
-- 
2.47.3



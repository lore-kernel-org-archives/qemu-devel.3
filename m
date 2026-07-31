Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A775AC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplj7-0001sz-QT; Fri, 31 Jul 2026 07:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wplj6-0001rw-50
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:48:32 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wplj3-0000EB-Tm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3qb8ShKJQvf0BhpvbBvZYqyOKKIdUeR7z5hZBFvT7eE=; b=TG0VSiE2zMuKMNc
 iEcVjzFDqg5dCnhCqZdsiJwuam8LYMVIm6sqTSPJvT3CBFw4JjV75LmDKn5oabH/zaHt1oFh2MeJx
 IELEprXSKs4z6c7g1wRanvap2FBUBI7UvAXPvUI9hE7fyuclf7dpYht5mmbwS1M0gOX1h5bPpBWrO
 ZU=;
Date: Fri, 31 Jul 2026 13:48:15 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>,
 brian.cain@oss.qualcomm.com
Cc: Anton Johansson <anjo@rev.ng>, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com
Subject: Re: [PATCH v2 40/50] test: helper-to-tcg docker tests
Message-ID: <20260731134815.051bc8e7@spawn>
In-Reply-To: <20260730031025.12926-41-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-41-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:10:14 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> Adds a docker container with LLVM versions 15-21 and a docker test for
> building helper-to-tcg and running end-to-end tests along with running
> check-tcg, for testing targets such as Hexagon.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> --
> NOTE: Last I checked I had some troubles with C++17 support within the
> container, was a while ago though.

Maybe that was the clang 15 + -std=c++14 I reported on the other thread?

> ---
>  tests/docker/dockerfiles/debian-llvm.docker | 38 +++++++++++++++++++
>  tests/docker/test-helper-to-tcg             | 41 +++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-llvm.docker
>  create mode 100755 tests/docker/test-helper-to-tcg
> 
> diff --git a/tests/docker/dockerfiles/debian-llvm.docker b/tests/docker/dockerfiles/debian-llvm.docker
> new file mode 100644
> index 0000000000..7bfc084a34
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-llvm.docker
> @@ -0,0 +1,38 @@
> +FROM docker.io/library/debian:11-slim

Debian 11 uses an old glibc (2.31) that prevents me from building QEMU.

Specifically, I get an error about missing `MADV_POPULATE_READ` and
`MADV_POPULATE_WRITE`.

I suggest to switch to Debian 12, for which llvm.sh provides all the
versions we're interested in *and* is compatible with the hexagon
toolchain.

All other `.docker`s use Debian 13, but apt.llvm.org only provide 21
and 22 for it.

There's an entry for older version but Packages is empty:

    https://apt.llvm.org/trixie/dists/llvm-toolchain-trixie-15/main/binary-amd64/Packages

> +
> +RUN apt update && \
> +    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
> +    DEBIAN_FRONTEND=noninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        bison \
> +        ca-certificates \
> +        flex \
> +        gawk \
> +        libmpc-dev \
> +        libmpfr-dev \
> +        libglib2.0-dev \
> +        libpixman-1-dev \
> +        make \
> +        ninja-build \
> +        rsync \
> +        pkgconf \
> +        wget \
> +        lsb-release \
> +        software-properties-common \
> +        gnupg \
> +        meson \
> +        python3-pip \
> +        python3-setuptools \
> +        python3-venv \
> +        python3-wheel

I had to add bzip2 and libfdt-dev.

> +
> +RUN /usr/bin/pip3 install tomli

Python 3.11 (in Debian 12) has tomllib in the standard library and this
line should be no longer necessary.

> +
> +RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh
> +RUN ./llvm.sh 15 all
> +RUN ./llvm.sh 16 all
> +RUN ./llvm.sh 17 all
> +RUN ./llvm.sh 18 all
> +RUN ./llvm.sh 19 all
> +RUN ./llvm.sh 20 all
> +RUN ./llvm.sh 21 all

I suggest to limit building QEMU for the Hexagon target:

DEF_TARGET_LIST=hexagon-linux-user

Otherwise, I get a build error on the ARM target with clang 15:

../../src/hw/arm/fsl-imx8mp.c:684:56: error: initializer element is not a compile-time constant
                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN1].addr,
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

I guess this is temporary, given that clang 15 is supported AFAIU.

I also suggest to install the Hexagon toolchain, so we can actually
test Hexagon.

    ENV TOOLCHAIN_RELEASE=22.1.8
    ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}________/hexagon-debs-${TOOLCHAIN_RELEASE}________.tar.gz
    RUN ./llvm.sh 22 && \
        mkdir -p /tmp/hexagon-debs && \
        wget -qO- "$TOOLCHAIN_URL" | tar -xzC /tmp/hexagon-debs && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/hexagon-debs/*.deb && \
        rm -rf /tmp/hexagon-debs

I tested all the containers from 15 to 21 and the toolchain is
correctly picked up and tests pass (except for `test_max_temps`,
reported in another thread).

Eventually we'll also want to use helper-to-tcg for xqciu RISC-V
extensions, but even then, I think Hexagon is going to be the target
exercising the most features of helper-to-tcg, so it's worth to throw
it against the whole range of versions of LLVM we want to support.

Brian: I don't remember what's the status of the Hexagon toolchain, but
being able to use the upstream LLVM for check-tcg would be nice.
Can you remind me if anything major is missing there?

> diff --git a/tests/docker/test-helper-to-tcg b/tests/docker/test-helper-to-tcg
> new file mode 100755
> index 0000000000..0c27040d60
> --- /dev/null
> +++ b/tests/docker/test-helper-to-tcg
> @@ -0,0 +1,41 @@
> +#!/bin/bash -e
> +
> +TEST_COMMAND=""
> +TARGET_LIST=""
> +

I think you need to `. common.rc` and...

> +cd "$BUILD_DIR"
> +
> +# Checks helper-to-tcg builds and passes unit tests
> +# for targetted LLVM versions.  Run meson from QEMU source so helper-to-tcg tests can find
> +# `tcg-global-mappings.h`.
> +for version in {15..21}; do
> +    llvm_config=llvm-config-${version}
> +    build_dir="${BUILD_DIR}/build-helper-to-tcg-${version}"
> +    cxx=$(${llvm_config} --bindir)/clang++
> +    [ ! -d ${build_dir} ] && mkdir ${build_dir}
> +    CXX=${cxx} meson setup ${build_dir} ${QEMU_SRC}/subprojects/helper-to-tcg -Dllvm_config_path=${llvm_config}
> +    meson compile -C ${build_dir}
> +    meson test -C ${build_dir} --suite 'helper-to-tcg:helper-to-tcg'
> +done
> +
> +# Runs check-tcg for all LLVM versions
> +llvm_config_main=llvm-config-15
> +bin_main=$(${llvm_config_main} --bindir)
> +cc_main=${bin_main}/clang
> +cxx_main=${bin_main}/clang++
> +for version in {15..21}; do
> +    llvm_config=llvm-config-${version}
> +    build_dir=build-qemu-${version}
> +    bin=$(${llvm_config} --bindir)
> +    cxx=${bin}/clang++
> +    cc=${bin}/clang
> +    [ ! -d ${build_dir} ] && mkdir ${build_dir}
> +
> +    pushd ${build_dir}
> +
> +    TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
> +    build_qemu "--cc=${cc_main} --cxx=${cxx_main} -Dhelper-to-tcg:llvm_config_path=${llvm_config} --enable-debug-tcg"
> +    check_tcg

...

check_qemu check-tcg

> +
> +    popd
> +done
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs


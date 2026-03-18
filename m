Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE55AFCD0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mfs-0007N1-PQ; Wed, 18 Mar 2026 04:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2mfr-0007Mh-2w
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2mfo-000363-A1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773824077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZAryt0OcXFg8q15MeYVBcx5tf7fxEPwp4g7/YQBivk=;
 b=UVT2o1KZK5LbaY7XfULEpf/NnFEyE/G5i8ZBOmOwXmlEHi0Xi4J4zAwg4SgkzAIuWeHUeN
 3C/wGtY+PZtClsWRj+BA3mShWvjB8tW217BbkaFe/uZ2dyRTJEb7/5O37LQFLKx7wV5xyJ
 yNmsBjMO4zn61D1h98M2C53ngmRAXMw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-fP1rjXO_NvO3IkdZvtVVwA-1; Wed,
 18 Mar 2026 04:54:34 -0400
X-MC-Unique: fP1rjXO_NvO3IkdZvtVVwA-1
X-Mimecast-MFC-AGG-ID: fP1rjXO_NvO3IkdZvtVVwA_1773824073
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1231219560A2; Wed, 18 Mar 2026 08:54:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A5E030001A1; Wed, 18 Mar 2026 08:54:31 +0000 (UTC)
Date: Wed, 18 Mar 2026 08:54:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust: suggest passing --locked to "cargo install"
Message-ID: <abpnzhK1pfTst2se@redhat.com>
References: <20260318082113.1127992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318082113.1127992-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 18, 2026 at 09:21:13AM +0100, Paolo Bonzini wrote:
> Without the option, cargo will try using the latest version of the
> dependencies of bindgen-cli. While it will obviously respect the
> constraints in Cargo.toml, old versions of Cargo do not have
> version-constrained resolution and will choke on dependencies
> that need Rust 2024.

Ah ha, the  "--do-what-I-thought-should-be-the-default"
option :-)

> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/build-platforms.rst                      | 2 +-
>  meson.build                                         | 2 +-
>  tests/docker/dockerfiles/fedora-rust-nightly.docker | 2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker          | 2 +-
>  tests/lcitool/refresh                               | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index 6e3088d524a..3d23dfbd779 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -114,7 +114,7 @@ Rust build dependencies
>    bindgen tool, which is too big to package and distribute.  The minimum
>    supported version of bindgen is 0.60.x.  For distributions that do not
>    include bindgen or have an older version, it is recommended to install
> -  a newer version using ``cargo install bindgen-cli``.
> +  a newer version using ``cargo install --locked bindgen-cli``.
>  
>    QEMU requires Rust 1.83.0.  This is available on all supported platforms
>    except for the ``mips64el`` architecture on Debian bookworm.  For all other
> diff --git a/meson.build b/meson.build
> index d016482db1b..62fab727f4e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,7 +114,7 @@ if have_rust
>    bindgen = find_program('bindgen', required: get_option('rust'))
>    if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
>      if get_option('rust').enabled()
> -      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
> +      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install --locked bindgen-cli"')
>      else
>        if bindgen.found()
>          warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
> diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
> index 043b42a0a9b..38381ef8f59 100644
> --- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
> +++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
> @@ -179,7 +179,7 @@ RUN set -eux && \
>    test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
>    test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
>  ENV PATH=$CARGO_HOME/bin:$PATH
> -RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
> +RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli
>  RUN $CARGO --list
>  # As a final step configure the user (if env is defined)
>  ARG USER
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
> index 23b33d6ad44..44e763f571a 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -162,7 +162,7 @@ ENV CARGO_HOME=/usr/local/cargo
>  ENV PATH=$CARGO_HOME/bin:$PATH
>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
> -RUN cargo install bindgen-cli
> +RUN cargo install --locked bindgen-cli
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 259e6ea0729..79a280feab4 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -147,7 +147,7 @@ fedora_rustup_nightly_extras = [
>      '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
>      '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
>      'ENV PATH=$CARGO_HOME/bin:$PATH\n',
> -    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
> +    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli\n',
>      'RUN $CARGO --list\n',
>  ]
>  
> @@ -158,7 +158,7 @@ ubuntu2204_rust_extras = [
>      'ENV PATH=$CARGO_HOME/bin:$PATH\n',
>      "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
>      "  apt install -y --no-install-recommends cargo\n",
> -    'RUN cargo install bindgen-cli\n',
> +    'RUN cargo install --locked bindgen-cli\n',
>  ]
>  
>  debian_all_test_cross_compilers = [
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



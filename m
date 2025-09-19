Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E0CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcL5-0004Gd-RK; Fri, 19 Sep 2025 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzcL2-0004Au-BB
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzcKz-00033l-2h
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758293025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2eUrbl2CNcU7EWNsYhpj5rRuqDsf4h3Kh6lxAWf8Kps=;
 b=gkgc+xLFJtoQc+bRGWGK5BhsBFbaBc70wReDolenswSoljVmXhhUvAniQAW6xBCfZLv6Wc
 eF/zAAezvcD58HG/UzH1wEaeZCVpR56j2e8D8jNhOY1nmI7H39wKSJQBDjz/KgOp9B5dvF
 cJRi7uZ1DWmi8hMhHOR+WdIdNgjeSaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-ytG-QL7yNrujjbCnSvumQA-1; Fri,
 19 Sep 2025 10:43:42 -0400
X-MC-Unique: ytG-QL7yNrujjbCnSvumQA-1
X-Mimecast-MFC-AGG-ID: ytG-QL7yNrujjbCnSvumQA_1758293020
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BBBF18004D8; Fri, 19 Sep 2025 14:43:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DBFC1956048; Fri, 19 Sep 2025 14:43:36 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:43:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 22/24] WIP: tests/docker: add rust to
 debian-legacy-test-cross
Message-ID: <aM1sFQgWDAKCgUNO@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919133320.240145-23-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 19, 2025 at 05:33:16PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Unfortunately, debian 11 has bindgen version 0.55...
> 
> Should we install it with cargo install bindgen-cli?

Debian 11 is not a supported platform for QEMU anymore. We only
support at most 2 releases, which means 12 & 13 now. So this
dockerfile is overdue removal and/or update.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml                               | 2 +-
>  tests/docker/dockerfiles/debian-legacy-test-cross.docker | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 94d646c5a7..efaa72f288 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -389,7 +389,7 @@ build-legacy:
>    variables:
>      IMAGE: debian-legacy-test-cross
>      TARGETS: alpha-linux-user alpha-softmmu sh4-linux-user mips-linux-user mips-softmmu mipsel-linux-user mipsel-softmmu mips64-linux-user mips64-softmmu
> -    CONFIGURE_ARGS: --disable-tools
> +    CONFIGURE_ARGS: --disable-tools --enable-rust
>      MAKE_CHECK_ARGS: check-tcg
>  
>  build-user-hexagon:
> diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> index 8c922b47f5..0014e59127 100644
> --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> @@ -25,6 +25,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>  RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          apt install -y --no-install-recommends \
>          bison \
> +        cargo \
>          ccache \
>          clang  \
>          flex \
> @@ -41,9 +42,12 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>          python3-pip \
>          python3-setuptools \
>          python3-venv \
> -        python3-wheel && \
> +        python3-wheel \
> +        rustc-web \
> +        && \
>          dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
>  
> +RUN cargo install bindgen-cli
>  RUN /usr/bin/pip3 install tomli
>  
>  ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



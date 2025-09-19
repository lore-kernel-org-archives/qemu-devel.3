Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5F0CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcH0-0000xw-FI; Fri, 19 Sep 2025 10:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzcGp-0000uH-Nq
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzcGe-0001cH-Gf
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758292753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlW8IL3Apli5mgvlgoKb8V/SKRCSWozqN9z8VV8qmEU=;
 b=L9ah1rSt0NU/SuMBpyhQTTJr7ULsTf8QOiOiGAZyfGodP6914VhCO7eCWNxJPQ/Sky8zdL
 lZoaXmGlwAiO2XhX7q0+7TkSmUPb16w3LxOc2lSyg9sGBFa75uoMp/q32lzh2Gsj1ILHYB
 iF1uj9y0gCHZwZIH0LDYNY/bpHhdgyU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-lgss4asAPh-_55jKJyRtRQ-1; Fri,
 19 Sep 2025 10:39:11 -0400
X-MC-Unique: lgss4asAPh-_55jKJyRtRQ-1
X-Mimecast-MFC-AGG-ID: lgss4asAPh-_55jKJyRtRQ_1758292749
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D96A195608E; Fri, 19 Sep 2025 14:39:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3C1D30002C5; Fri, 19 Sep 2025 14:39:05 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:39:02 +0100
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
Subject: Re: [PATCH 18/24] tests/lcitool: enable rust & refresh
Message-ID: <aM1rBhUKkW9jMVh-@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-19-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919133320.240145-19-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 19, 2025 at 05:33:12PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Enable Rust on various distro images: alpine, centos, debian, fedora,
> opensuse.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/dockerfiles/alpine.docker             |  2 ++
>  tests/docker/dockerfiles/centos9.docker            |  2 ++
>  tests/docker/dockerfiles/debian-amd64-cross.docker |  2 ++
>  tests/docker/dockerfiles/debian-arm64-cross.docker |  2 ++
>  tests/docker/dockerfiles/debian-armhf-cross.docker |  2 ++
>  tests/docker/dockerfiles/debian-i686-cross.docker  |  2 ++
>  .../docker/dockerfiles/debian-ppc64el-cross.docker |  2 ++
>  .../docker/dockerfiles/debian-riscv64-cross.docker |  2 ++
>  tests/docker/dockerfiles/debian-s390x-cross.docker |  2 ++
>  tests/docker/dockerfiles/debian.docker             |  2 ++
>  .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
>  tests/docker/dockerfiles/fedora.docker             |  2 ++
>  tests/docker/dockerfiles/opensuse-leap.docker      |  2 ++
>  tests/lcitool/refresh                              | 14 +++++++++++---
>  14 files changed, 37 insertions(+), 3 deletions(-)

snip

> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
> index d71dbc30c7..2b6d7efd94 100644
> --- a/tests/docker/dockerfiles/opensuse-leap.docker
> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> @@ -148,3 +148,5 @@ ARG USER
>  ARG UID
>  RUN if [ "${USER}" ]; then \
>    id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
> +
> +ENV ENABLE_RUST 1
> \ No newline at end of file
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 649568c5c2..c585baa89c 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -63,7 +63,8 @@ add_user_mapping = [
>      "  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi\n"
>  ]
>  
> -def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
> +def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
> +                        enable_rust=True):
>      filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
>      cmd = lcitool_cmd + ["dockerfile"]
>      if cross is not None:
> @@ -75,6 +76,8 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
>      else:
>          trailer = "\n".join(add_user_mapping)
>  
> +    if enable_rust:
> +        trailer += "\nENV ENABLE_RUST 1"

Needs a trailing newline to remove all the

 "\ No newline at end of file"

warnings which will result in excessive diff context on subsequent
additions.

>      generate(filename, cmd, trailer)
>  
>  
> @@ -180,7 +183,9 @@ try:
>      generate_dockerfile("fedora", "fedora-41")
>      generate_dockerfile("opensuse-leap", "opensuse-leap-15")
>      generate_dockerfile("ubuntu2204", "ubuntu-2204",
> -                        trailer="".join(ubuntu2204_rust_extras))
> +                        trailer="".join(ubuntu2204_rust_extras),
> +                        # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
> +                        enable_rust=False)
>  
>      #
>      # Non-fatal Rust-enabled build
> @@ -237,7 +242,10 @@ try:
>                          project='qemu,qemu-win-installer',
>                          cross="mingw64",
>                          trailer=cross_build("x86_64-w64-mingw32-",
> -                                            "x86_64-softmmu"))
> +                                            "x86_64-softmmu"),
> +                        # linking with rust is buggy:
> +                        # https://github.com/mesonbuild/meson/pull/14991
> +                        enable_rust=False)
>  
>      #
>      # Cirrus packages lists for GitLab
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



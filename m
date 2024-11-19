Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33704D6204A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKTa-0005ma-S7; Tue, 19 Nov 2024 04:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKTZ-0005mG-TF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKTX-0001JK-Iz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732008286;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C3gwaomAu+tL1E6Bh4HokGA+GddCUiSyw2gVDjjrx+M=;
 b=HvWUpeToMmhzhUtDWHpoYo0e/Bm6xmfQsQzTacNLM49A93i+kjL88AfIhgToszKHfqAUaK
 nbTjLfYOY8VmBH1e3hIWyNTTKmpM5I7iT0FbiSiDvm6c0KHg54aFTuo0jJJ2kdpY27M22O
 9BSsG5h2fevmz8XcpSMqSp4kjxKFXLg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-txZ-ifVkMUuEh5ryLgZP5g-1; Tue,
 19 Nov 2024 04:24:42 -0500
X-MC-Unique: txZ-ifVkMUuEh5ryLgZP5g-1
X-Mimecast-MFC-AGG-ID: txZ-ifVkMUuEh5ryLgZP5g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7393119541A0; Tue, 19 Nov 2024 09:24:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3C311956086; Tue, 19 Nov 2024 09:24:29 +0000 (UTC)
Date: Tue, 19 Nov 2024 09:24:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/7] docs/devel: add information on how to setup build
 environments
Message-ID: <ZzxZRwXAIlMt6SNA@redhat.com>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-5-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118172357.475281-5-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 18, 2024 at 09:23:54AM -0800, Pierrick Bouvier wrote:
> MacOS and Linux are straightforward, but Windows needs a bit more
> details.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/about/build-platforms.rst   |   4 +-
>  docs/devel/build-environment.rst | 114 +++++++++++++++++++++++++++++++
>  docs/devel/index-build.rst       |   1 +
>  3 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/build-environment.rst
> 
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index 6102f00aec0..c1ea53db834 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -29,6 +29,9 @@ The `Repology`_ site is a useful resource to identify
>  currently shipped versions of software in various operating systems,
>  though it does not cover all distros listed below.
>  
> +You can find how to install build dependencies for different systems on the
> +:ref:`setup-build-env` page.
> +
>  Supported host architectures
>  ----------------------------
>  
> @@ -130,7 +133,6 @@ Optional build dependencies
>    cross compilation using ``docker`` or ``podman``, or to use pre-built
>    binaries distributed with QEMU.
>  
> -
>  Windows
>  -------
>  
> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
> new file mode 100644
> index 00000000000..d9a66f5fcc6
> --- /dev/null
> +++ b/docs/devel/build-environment.rst
> @@ -0,0 +1,114 @@
> +
> +.. _setup-build-env:
> +
> +Setup build environment
> +=======================
> +
> +QEMU uses a lot of dependencies on the host system. glib2 is used everywhere in
> +the code base, and most of the other dependencies are optional.
> +
> +We present here simple instructions to enable native builds on most popular
> +systems.
> +
> +You can find additional instructions on `QEMU wiki <https://wiki.qemu.org/>`_:
> +
> +- `Linux <https://wiki.qemu.org/Hosts/Linux>`_
> +- `MacOS <https://wiki.qemu.org/Hosts/Mac>`_
> +- `Windows <https://wiki.qemu.org/Hosts/W32>`_
> +- `BSD <https://wiki.qemu.org/Hosts/BSD>`_


We generally suffer from having information spread over multiple sources,
giving us the burden of keeping the different places consistent, which we
pretty consistently fail at.

It is a good think to add build env docs to qemu.git where we actually
have oversight / review to catch mistakes. If we do this though, IMHO,
we should be deleting the wiki pages and making them into 302 redirects
to our new in-tree docs.

> +
> +Linux
> +-----
> +
> +Fedora
> +++++++
> +
> +::
> +
> +    sudo dnf update && sudo dnf builddep qemu
> +
> +Debian/Ubuntu
> ++++++++++++++
> +
> +You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
> +Then, use apt to install dependencies:
> +
> +::
> +
> +    sudo apt update && sudo apt build-dep qemu
> +
> +MacOS
> +-----
> +
> +You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
> +install dependencies:
> +
> +::
> +
> +    brew update && brew install $(brew deps --include-build qemu)


The downside in recommending the 'build dep' approach is that it misses
out on deps that have been newly introduced in qemu.git, since whatever
old version of QEMU the distros are shipping.  It also misses deps for
any features the distro vendor has decided to exclude.

Can we put a caveat describing this limitation at the top, so that users
have pointer if things don't quite go the way we expected.

> +
> +Windows
> +-------
> +
> +You first need to install `MSYS2 <https://www.msys2.org/>`_.
> +MSYS2 offers `different environments <https://www.msys2.org/docs/environments/>`_.
> +x86_64 environments are based on GCC, while aarch64 is based on Clang.
> +
> +We recommend to use MINGW64 for windows-x86_64 and CLANGARM64 for windows-aarch64
> +(only available on windows-aarch64 hosts).

Does CLANGARM64 really work with QEMU ?   We go out of our way to actively
block the use of CLang for Windows because of its lack of support for
'gcc_struct' attributes, so I would have expected it to fail

> +
> +Then, you can open a windows shell, and enter msys2 env using:
> +
> +::
> +
> +    c:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64
> +    # Replace -ucrt64 by -clangarm64 or -ucrt64 for other environments.
> +
> +MSYS2 package manager does not offer a built-in way to install build
> +dependencies. You can start with this list of packages using pacman:
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



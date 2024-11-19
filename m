Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F29D6204F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKZ5-0007TP-5X; Tue, 19 Nov 2024 04:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKZ4-0007T6-8A
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDKZ0-0002Uj-GS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732008624;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pbrFuRvlSoBrax+dNrdrJ+i1Nm/UCsWKgPqZajRJrd0=;
 b=YjpB0sZd2DwkbQHh2QN8BI1oJjs/6oPnEdOSyoz6rLVs7ucxqFQc16kW/b8ypQyIsdTXWH
 iwIubhIY5FJVvGSfy4IX7Sxc3msEkEmK7VY6nurjK8dqBMWv/ukhwWLU7dDF439xgn2VLp
 5YRxdvXoF6QxPUuTF3knZgu1iSfJJCM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-P4sedATyOqGyw-LItvtS2A-1; Tue,
 19 Nov 2024 04:30:21 -0500
X-MC-Unique: P4sedATyOqGyw-LItvtS2A-1
X-Mimecast-MFC-AGG-ID: P4sedATyOqGyw-LItvtS2A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F34319540F0; Tue, 19 Nov 2024 09:30:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344341956054; Tue, 19 Nov 2024 09:30:00 +0000 (UTC)
Date: Tue, 19 Nov 2024 09:29:52 +0000
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
Subject: Re: [PATCH 7/7] docs: add a how to section
Message-ID: <ZzxakHNsVA9cKIyA@redhat.com>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-8-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118172357.475281-8-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 18, 2024 at 09:23:57AM -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  docs/devel/build-system.rst |   2 +
>  docs/how-to/index.rst       | 146 ++++++++++++++++++++++++++++++++++++
>  docs/index.rst              |   1 +
>  3 files changed, 149 insertions(+)
>  create mode 100644 docs/how-to/index.rst
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index d42045a2325..db444787e37 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -1,3 +1,5 @@
> +.. _build:
> +
>  ==================================
>  The QEMU build system architecture
>  ==================================
> diff --git a/docs/how-to/index.rst b/docs/how-to/index.rst
> new file mode 100644
> index 00000000000..3a9d4d777df
> --- /dev/null
> +++ b/docs/how-to/index.rst
> @@ -0,0 +1,146 @@
> +.. _how-to:
> +
> +------
> +How to
> +------
> +
> +This section of the manual will give you some commands to do various tasks with
> +QEMU. It does not intend to be complete, but to be simple.
> +
> +Build
> +-----
> +
> +First you need setup your `build environment <setup-build-env>`.
> +
> +Then, you can build QEMU using:
> +
> +::
> +
> +    git clone https://gitlab.com/qemu-project/qemu
> +    cd qemu
> +    ./configure
> +    ninja -C build
> +    # all binaries are in ./build
> +
> +By default, QEMU build is optimized. You may want to switch to debug builds
> +instead (non optimized, and with more runtime checks enabled):
> +
> +::
> +
> +    ./configure --enable-debug
> +
> +It's recommended to use sanitizers to catch issues when developing your change.
> +
> +::
> +
> +    ./configure --enable-asan --enable-ubsan
> +    # Of course, you can combine debug and sanitizers if needed
> +
> +You can find more information on `build page <build>`.
> +
> +Test
> +----
> +
> +QEMU has a lot of tests, mainly in 4 categories:
> +
> +::
> +
> +    # run tests related to TCG. They are based on Makefiles.
> +    make check-tcg
> +    # run system tests, running a full VM, with avocado framework
> +    make check-avocado
> +    # run functional tests, running a full VM, integrated with Meson
> +    make check-functional
> +    # run all other tests, integrated with Meson
> +    make check
> +
> +You can find more information on `testing page<testing>`.
> +
> +Use QEMU
> +--------
> +
> +To create a 20 gigabytes disk image usable with qemu-system:
> +
> +::
> +
> +    qemu-img create system.img 20g
> +
> +To run an x86_64 system emulated, with 4 cpus, 8G of memory and an install iso:
> +
> +::
> +
> +    qemu-system-x86_64 -smp 4 -m 8G system.img -cdrom install.iso
> +
> +To boot directly a Linux Kernel:
> +
> +::
> +
> +    qemu-system-x86_64 -kernel bzImage -hda system.img -append "root=/dev/hda"
> +
> +To boot an aarch64 system emulated, you need to specify a UEFI and associated
> +pflash. Once started, you can switch to Serial output by clicking on View ->
> +Serial0.
> +
> +::
> +
> +    # UEFI can be obtained from debian package qemu-efi-aarch64.
> +    # First, we need to copy a file to save UEFI variables:
> +    # cp /usr/share/AAVMF/AAVMF_VARS.fd .
> +    qemu-system-aarch64 \
> +        -m 8G \
> +        -smp 4 \
> +        -M virt \
> +        -cpu max \
> +        -device virtio-blk-pci,drive=root \
> +        -drive if=none,id=root,file=system.img \
> +        -drive if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd \
> +        -drive if=pflash,file=AAVMF_VARS.fd \
> +        -cdrom install.iso
> +
> +To run git using QEMU user-mode:
> +
> +::
> +
> +    qemu-x86_64 /usr/bin/git --version
> +
> +Contribute
> +----------
> +
> +We recommend using `git-publish <https://github.com/stefanha/git-publish>`_ for
> +contributing. You need to configure `git send-email
> +<https://git-send-email.io/>`_ first.
> +
> +::
> +
> +    git checkout -b my_feature
> +    ... # edit, build, test
> +    # When ready to send the series...
> +
> +    # Add upstream QEMU repo as a remote.
> +    git remote add upstream https://gitlab.com/qemu-project/qemu
> +    # Fetch all new content.
> +    git fetch -a upstream
> +
> +    # Rebase your branch on top of upstream master, and include a signoff.
> +    git rebase -i upstream/master --signoff
> +    # Check your patches are correct.
> +    ./scripts/checkpatch.pl $(git merge-base upstream/master HEAD)..HEAD
> +
> +    # Send your series, you'll be given a chance to edit cover letter for it.
> +    git-publish
> +
> +    # After review, and other changes, you can send a v2 simply by using:
> +    git-publish
> +
> +If you need to apply locally an existing series, you can use `b4
> +<https://github.com/mricon/b4>`_ (installable via pip) to retrieve it:
> +
> +::
> +
> +    b4 shazam <series_msg_id>
> +    # message id is an identifier present in email sent.
> +    # when using patchwork, it is the last part of a series url (2024...):
> +    # https://patchew.org/QEMU/20241118021820.4928-1-joel@jms.id.au/
> +
> +More complete information is available on our `Submit a patch page
> +<submitting-a-patch>`.

I'm far from convinced any of the above content is a good idea, given
it is duplicating stuff we've already got elsewhere in our manual.
This gives us the extra burden of ensuring different parts of the
manual are consistent in what they're recommending which is something
we are historically bad at doing.

I think there is scope for having a "how-tos" section, but this particular
choices of examples are not the best place to kick it off with IMHO. Also,
for the sake of scalability, I'd suggest that each "how to" is a standalone
file in the how-tos/ sub-directory, otherwise the index.rst will quickly
become enourmous.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



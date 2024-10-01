Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98693CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveQT-0005kL-LZ; Tue, 01 Oct 2024 11:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svePH-0005HW-7N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svePC-0000GD-Nx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727794992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ozg+9H69CW8zxfLN1XtIHJHS4SgnyDJGlARN5pQmn6k=;
 b=g9K+GTdFgZGVa/Zd5lWXIpx7r/Fwq7gLJze0tsAxxiKTCGePelzqX13+NpLHNJFApLUwww
 0l7Ksn/K/MvTxgquJ77BSivy+Nb+Xw0VQx5sxbR06IfDEg6F8FoP0xEC3ZSdWMisDJ2SUU
 1dRZa474g7hRHIf0zJSARHMVatRJiIE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-gTzEzQAsOcCe-mcPXQHFxg-1; Tue,
 01 Oct 2024 04:38:33 -0400
X-MC-Unique: gTzEzQAsOcCe-mcPXQHFxg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF4FC19626EA; Tue,  1 Oct 2024 08:38:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58F4B19560AA; Tue,  1 Oct 2024 08:38:31 +0000 (UTC)
Date: Tue, 1 Oct 2024 09:38:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: Minimum sphinx version?
Message-ID: <Zvu08x58Wx0CAHcM@redhat.com>
References: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Mon, Sep 30, 2024 at 01:16:42PM -0400, John Snow wrote:
> Hi, following up from my KVM forum talk (
> https://www.youtube.com/watch?v=GGbz3WwvqLw ) I wanted to ask about what
> version of Sphinx we could use as a minimum version to help ease the burden
> of modernizing our QMP docs without a long backwards compatibility tail
> (and hundreds of lines of compatibility goop to make it happen.)
> 
> First, some necessary background on the current state of our Python
> environment and build system:
> 
> Paolo and I worked on a Python virtual environment tied to the QEMU build
> system (python/scripts/mkvenv.py) which performs various setup actions
> necessary to instantiate python *stuff* to ensure the build works and is
> always using the correct, configured Python interpreter.
> 
> Currently, configure will invoke mkvenv in such a fashion that it prefers
> any local packages you have installed: notably, meson, sphinx, and
> sphinx-rtd-theme if you already have them installed from your distro's
> repository will be used *if they use the version of python you specified to
> configure* (or they match the version that configure guessed if you didn't
> specify one.)
> 
> For meson, if you don't meet the minimum version, we will install a version
> for you from our vendored whl files in the repository/tarball.
> 
> For sphinx, if you don't meet the minimum version and you have specified
> --enable-docs, we'll install a version from the internet, from PyPI. If you
> did not specify --enable-docs, we disable docs.
> 
> We did it this way because:
> - It's *really fast* if you already have the dependencies you need
> - meson is easy to vendor as a .whl because it's pure python, has *zero*
> dependencies, and it's absolutely required for the build.
> - docs are not *required* to build QEMU
> - We went out of our way to ensure that QEMU could be built in an offline,
> isolated environment on all of our supported platforms.
> 
> That being said:
> 
> The current reality is that Sphinx 3.4.3 is our minimum because RHEL 9
> offers that as the distro package and I have not dared bump our version
> beyond that for fear of disrupting our ability to build docs on RHEL 9
> without internet.
> 
> What I'd like to ask is: How adamant are we that we can build docs on older
> platforms? Do we consider it part of our platform promise? Can we bump
> Sphinx to a slightly newer version at the expense of offline doc builds for
> RHEL 9?

As you say, with meson, if the distro does not provide a new enough
version, then we pull a suitable version into the venv, overriding
what the distro provides.

IMHO that has set a precedent for /any/ python component we need during
build.

To put it another way....

The distro build platform matrix rules *only* apply to python runtime,
not to python modules. We will bump the min version of python modules
as suits QEMU, without being held back by distro versions.

With this POV, there is nothing special about sphinx.

If we want to bump min sphinx to get a newer version, then we should
just do it.

The only important bit is that our tool for populating the venv must
"do the right thing" detecting that the distro version is too old,
and downloading newer sphinx automatically, so users don't suddenly
loose docs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



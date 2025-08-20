Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28321CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofyd-0002ak-G1; Wed, 20 Aug 2025 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uofyZ-0002ZV-BT
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uofyW-0000XQ-3f
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755685402;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZcLPlTV+Sb7mNLGkb4kxXry/6Iho3cQnuYGyjSpANK8=;
 b=a3D8RPYJbWGi4Dm+ps6t6L62GIh2uH0BP3ukPZdG4kjySfNf6GCTGYvLhzP65Fd0JvqaO9
 qibInFfHdTeWTBpZLkEwqfK25RP3VzINTIrOimtWq6mm/xY5Oyn8Z9nAjbbdHda+O+9bim
 0IEIs6rktjMkafyu0cyRbaT2kqNzUWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-wTRb5ocSM1291Hs4Admpjg-1; Wed,
 20 Aug 2025 06:23:16 -0400
X-MC-Unique: wTRb5ocSM1291Hs4Admpjg-1
X-Mimecast-MFC-AGG-ID: wTRb5ocSM1291Hs4Admpjg_1755685394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A21B0195608E; Wed, 20 Aug 2025 10:23:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0779A19560B0; Wed, 20 Aug 2025 10:23:08 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:23:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Subject: Re: [PATCH] meson: set test programs to not build by default
Message-ID: <aKWiCBbEKwn5zLRz@redhat.com>
References: <20250819154940.2137965-1-eschwartz@gentoo.org>
 <aKSmyWRB_Gi3kru_@redhat.com>
 <eda4ade9-ba07-4e6e-adf8-e308a9ec3435@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eda4ade9-ba07-4e6e-adf8-e308a9ec3435@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 20, 2025 at 01:12:35AM -0400, Eli Schwartz wrote:
> But your proposal runs counter to existing code already in qemu's build
> system, i.e. the comment I've updated. So I don't think it's entirely
> fair to raise an objection to my patch at all -- better you should raise
> a meta-discussion about this to discuss changing the existing
> build_by_defaults.

The comment in tests/functional/meson.build is a special case rule
that isn't building anything. Rather that precache logic is using a
custom target to download several GB of disk images needed by tests,
such that the tests themselves won't hit a timeout downloading images
on first run. That use of  "build_by_default: false" would be fine.

> > If we want the ability to opt-out of building tests by default
> > so reduce build time, IMHO that should be behind a 'configure'
> > flag / meson_options.txt setting.
> 
> 
> There is anyways no point in this being a meson_options.txt setting and
> complexifying all test programs via conditionals. As explained in my
> link, you can have Makefile itself read a configure option and run:

AFAICT, it shouldn't be more complex than anything else we're doing
with meson option handling. eg instead of hardcoding 'false', do
something like:

  build_by_default: get_option('tests')

where the option defaults to 'true'.

> Either way it is definitely of interest to users running a build +
> install of a tagged release, to skip building tests they won't run. e.g.
> many linux distros make the test phase of packaging be optional.

FWIW, I would really strongly suggest to *always* run QEMU's tests
from release tarball, and most especially for distro packaging.
There are just way too many moving parts in our 3rd party deps to
be confident everything in QEMU works correctly without having run
the tests.

> Automake works the same way -- tests can be excluded from `make && make
> install`, but get built on demand by `make check`.

When we still used automake in libvirt, we overrode that behaviuor to
always build tests, as it was causing too frequent problems with
contributors overlooking that a patch had broken test compile.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



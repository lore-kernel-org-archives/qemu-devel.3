Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49407E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV9B-0006yD-4R; Wed, 08 Jan 2025 07:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVV7b-0005YE-I9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVV7X-0003ZR-SI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736339108;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gqVZzgik8Bk7eQm+AQ1VG9aZQQSD8gkmNvlNcw7ZOs=;
 b=S100ooYfTkXWqBZhD4M2hAuXyQmW57bJD/2p6AI1UPOPYWGuis2ho/4K7ngyZ/ne1HlB7n
 6jGLI5DM6u8/9pFzuiK6ebXfKiT7Q3naOGexAQMi6vovUUG7ICN386RmBPzDYZyL2zvlf1
 RFas/XwDk4/RAOdVxDoHx5gOwZIZKJ4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-bq136JTuOo2LfRZqazGGIQ-1; Wed,
 08 Jan 2025 07:25:05 -0500
X-MC-Unique: bq136JTuOo2LfRZqazGGIQ-1
X-Mimecast-MFC-AGG-ID: bq136JTuOo2LfRZqazGGIQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DC3419153C8; Wed,  8 Jan 2025 12:25:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DA95300018D; Wed,  8 Jan 2025 12:24:57 +0000 (UTC)
Date: Wed, 8 Jan 2025 12:24:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 graf@amazon.com, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/21] hw/uefi: add uefi variable service
Message-ID: <Z35ulWfiCNq-cd3Y@redhat.com>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 08, 2025 at 03:53:21PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jan 7, 2025 at 7:34 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > This patch adds a virtual device to qemu which the uefi firmware can use
> > to store variables.  This moves the UEFI variable management from
> > privileged guest code (managing vars in pflash) to the host.  Main
> > advantage is that the need to have privilege separation in the guest
> > goes away.
> >
> > On x86 privileged guest code runs in SMM.  It's supported by kvm, but
> > not liked much by various stakeholders in cloud space due to the
> > complexity SMM emulation brings.
> >
> > On arm privileged guest code runs in el3 (aka secure world).  This is
> > not supported by kvm, which is unlikely to change anytime soon given
> > that even el2 support (nested virt) is being worked on for years and is
> > not yet in mainline.
> >
> > The design idea is to reuse the request serialization protocol edk2 uses
> 
> I suppose this is a stable protocol. (some parts are set by the UEFI
> spec probably)
> 
> There doesn't seem to be a defined way to query either side version or
> capability, I suppose this could be added later assuming an initial
> behaviour/magic etc.
> 
> > for communication between SMM and non-SMM code, so large chunks of the
> > edk2 variable driver stack can be used unmodified.  Only the driver
> > which traps into SMM mode must be replaced by a driver which talks to
> > qemu instead.
> >
> > A edk2 test branch can be found here (build with "-D QEMU_VARS=TRUE").
> > https://github.com/kraxel/edk2/commits/devel/secure-boot-external-vars
> >
> 
> ok, perhaps it would be nice to have some basic unit tests in qemu
> too. Almost none of this new code is exercised by the qemu tests yet.
> 
> > The uefi-vars device re-implements the privileged edk2 protocols
> > (i.e. the code running in SMM mode).
> 
> Typically the kind of new code that I wish would be in Rust. But I
> suppose it is too early yet, and you came to the same conclusion.
> Probably a good candidate for rewrite though!

Perhaps too early for the device impl, but I would have thought
the general var-service code could be done in rust today. It does
not have all that much interaction with other parts of the QEMU
codebase & thus wouldn't be building on the moving target of the
QOM/Device abstractions. It would also be the prime part that
could be shared with coconut-svsm too.

> 
> >
> > v2 changes:
> >  - fully implement authenticated variables.
> >  - various cleanups and fixes.
> >
> > enjoy & take care,
> >   Gerd
> >
> > Gerd Hoffmann (21):
> >   hw/uefi: add include/hw/uefi/var-service-api.h
> >   hw/uefi: add include/hw/uefi/var-service-edk2.h
> >   hw/uefi: add include/hw/uefi/var-service.h
> >   hw/uefi: add var-service-guid.c
> >   hw/uefi: add var-service-utils.c
> >   hw/uefi: add var-service-vars.c
> >   hw/uefi: add var-service-auth.c
> >   hw/uefi: add var-service-policy.c
> >   hw/uefi: add var-service-core.c
> >   hw/uefi: add var-service-pkcs7.c
> >   hw/uefi: add var-service-pkcs7-stub.c
> >   hw/uefi: add var-service-siglist.c
> >   hw/uefi: add var-service-json.c + qapi for NV vars.
> >   hw/uefi: add trace-events
> >   hw/uefi: add UEFI_VARS to Kconfig
> >   hw/uefi: add to meson
> >   hw/uefi: add uefi-vars-sysbus device
> >   hw/uefi: add uefi-vars-isa device
> >   hw/arm: add uefi variable support to virt machine type
> >   docs: add uefi variable service documentation
> >   hw/uefi: add MAINTAINERS entry
> >
> >  include/hw/arm/virt.h              |   2 +
> >  include/hw/uefi/var-service-api.h  |  40 ++
> >  include/hw/uefi/var-service-edk2.h | 227 +++++++++
> >  include/hw/uefi/var-service.h      | 186 ++++++++
> >  hw/arm/virt.c                      |  41 ++
> >  hw/uefi/var-service-auth.c         | 361 ++++++++++++++
> >  hw/uefi/var-service-core.c         | 237 ++++++++++
> >  hw/uefi/var-service-guid.c         |  99 ++++
> >  hw/uefi/var-service-isa.c          |  91 ++++
> >  hw/uefi/var-service-json.c         | 242 ++++++++++
> >  hw/uefi/var-service-pkcs7-stub.c   |  16 +
> >  hw/uefi/var-service-pkcs7.c        | 436 +++++++++++++++++
> >  hw/uefi/var-service-policy.c       | 370 +++++++++++++++
> >  hw/uefi/var-service-siglist.c      | 212 +++++++++
> >  hw/uefi/var-service-sysbus.c       |  90 ++++
> >  hw/uefi/var-service-utils.c        | 241 ++++++++++
> >  hw/uefi/var-service-vars.c         | 725 +++++++++++++++++++++++++++++
> >  MAINTAINERS                        |   6 +
> >  docs/devel/index-internals.rst     |   1 +
> >  docs/devel/uefi-vars.rst           |  66 +++
> >  hw/Kconfig                         |   1 +
> >  hw/meson.build                     |   1 +
> >  hw/uefi/Kconfig                    |   9 +
> >  hw/uefi/LIMITATIONS.md             |   7 +
> >  hw/uefi/meson.build                |  24 +
> >  hw/uefi/trace-events               |  17 +
> >  meson.build                        |   1 +
> >  qapi/meson.build                   |   1 +
> >  qapi/qapi-schema.json              |   1 +
> >  qapi/uefi.json                     |  45 ++
> >  30 files changed, 3796 insertions(+)
> >  create mode 100644 include/hw/uefi/var-service-api.h
> >  create mode 100644 include/hw/uefi/var-service-edk2.h
> >  create mode 100644 include/hw/uefi/var-service.h
> >  create mode 100644 hw/uefi/var-service-auth.c
> >  create mode 100644 hw/uefi/var-service-core.c
> >  create mode 100644 hw/uefi/var-service-guid.c
> >  create mode 100644 hw/uefi/var-service-isa.c
> >  create mode 100644 hw/uefi/var-service-json.c
> >  create mode 100644 hw/uefi/var-service-pkcs7-stub.c
> >  create mode 100644 hw/uefi/var-service-pkcs7.c
> >  create mode 100644 hw/uefi/var-service-policy.c
> >  create mode 100644 hw/uefi/var-service-siglist.c
> >  create mode 100644 hw/uefi/var-service-sysbus.c
> >  create mode 100644 hw/uefi/var-service-utils.c
> >  create mode 100644 hw/uefi/var-service-vars.c
> >  create mode 100644 docs/devel/uefi-vars.rst
> >  create mode 100644 hw/uefi/Kconfig
> >  create mode 100644 hw/uefi/LIMITATIONS.md
> >  create mode 100644 hw/uefi/meson.build
> >  create mode 100644 hw/uefi/trace-events
> >  create mode 100644 qapi/uefi.json
> >
> > --
> > 2.47.1
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54FEC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virhs-0007Jd-Nw; Thu, 22 Jan 2026 05:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1virhr-0007Ib-PF
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1virhp-00080c-AA
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769076864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKR/A796DKj9EUeuDxgzN6wcJ3X4vqvcmKuu7eA6ogk=;
 b=GM9e0JjtQ+WaQL1sErrjLNqoqLoVTFZ7WT13b1UvC3KVjR6cub0zo0u8hEbWTvzWfEDAo1
 6Wfd2WlJwd93lfH/kAZt7EjmDTyVi63Q5CPZy6NTg5cdG+Cv4fKkdKI/qmu4Y+tc5DBR4k
 uISd4U0vwp8Mmzxor0i7fY2H6EURW5Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-IydFDCbeO1mj_eUQ8X7_zw-1; Thu,
 22 Jan 2026 05:14:20 -0500
X-MC-Unique: IydFDCbeO1mj_eUQ8X7_zw-1
X-Mimecast-MFC-AGG-ID: IydFDCbeO1mj_eUQ8X7_zw_1769076858
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBF5818005B7; Thu, 22 Jan 2026 10:14:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0BF518004D8; Thu, 22 Jan 2026 10:14:12 +0000 (UTC)
Date: Thu, 22 Jan 2026 10:14:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aXH4PpkC4AtccsOE@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> Hi Marc-André,
> I haven't seen discussion about the project ideas you posted, so I'll
> try to kick it off here for the mkosi idea here.
> 
> Thomas: Would you like to co-mentor the following project with
> Marc-André? Also, do you have any concerns about the project idea from
> the maintainer perspective?
> 
> === Reproducible Test Image Building with mkosi ===

> This project proposes using mkosi to build minimal, reproducible test
> images directly from distribution packages. mkosi is a tool for
> building clean OS images from distribution packages, with excellent
> support for Fedora and other distributions. It should be able to
> produces deterministic outputs.

Aside from what I mentioned already, the other issue I anticipate
with mkosi is the mismatch between what hardware QEMU needs to be
able to cover, vs what hardware the distros actually support.

Fedora in particular is pretty narrow in its coverage. Debian is
considerably broader.

Neither will support all the QEMU targets, let alone all the
machine types within the target.


While there is value in testing a full blown OS image, IMHO,
for most of what we need it is considerable overkill, and
thus makes functional tests slower than they would otherwise
need to be.

IMHO, our baseline for functional testing images ought to be
a Linux Kconfig recipe used to build a dedicate kernel, plus
a busybox build for the target.

This would let us create either a self contained initrd, or
a tiny root disk, both of which would reliably boot in a
barely more than a second or two, even under TCG.

This would have a number of other benefits

 * Not dependent on distros supporting the given QEMU
   target and machine type. As long as a Linux port
   exists and busybox compiles, we can test it
 
 * Identical test image functionality for every single
   target and machine type. No hodge-podge of different
   3rd party guest OS.

 * Stable forever, with all changes entirely under
   our own control. No distro changes that arbitrarily
   break our CI.

 * Easier to debug when it breaks, since there would
   be a small well defined set of logic running in
   the guest userspace

 * Fairly easy for QEMU to provide the complete and
   corresponding source for any binary images, since
   we've built it all from scratch

 * Tiny & fast downloads of pre-built images.


This would not eliminate the need for testing real OS images,
but would significantly downgrade their importance.

Functional tests could be in three groups - 'quick', as today,
'slow' the smoke tests with our miny kernel+busybox, 'thorough'
the full OS images.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



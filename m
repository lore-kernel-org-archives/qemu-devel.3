Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7673C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YbP-0004mR-HE; Wed, 23 Apr 2025 07:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7Yb0-0004W0-CS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7YaV-0005c6-Cr
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745408888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTZWLpUMj/Sx6OdYKHNGnD+1OZVA1VrS2/VA712v/eQ=;
 b=FiFyDaf8L5J8MzCZ/wNLL2n0hstGJIT6wsS+4hYUGkP/9b1GF3kyjm9BlKqEOrbJtYYmGk
 5tLGkDHa/IJlaxXxeq7arO9CUujxRMg5pN/BAZJgkHPUUV9GZEemN3m5kxTjuE9ESoyUqI
 36zefCSz6BIiIdnEc2YMEt1UYtyHFN8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-Z9ebNZi3OWW1DsmSTgJWJw-1; Wed,
 23 Apr 2025 07:48:06 -0400
X-MC-Unique: Z9ebNZi3OWW1DsmSTgJWJw-1
X-Mimecast-MFC-AGG-ID: Z9ebNZi3OWW1DsmSTgJWJw_1745408885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2DC01956086; Wed, 23 Apr 2025 11:48:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F3DD195608D; Wed, 23 Apr 2025 11:47:58 +0000 (UTC)
Date: Wed, 23 Apr 2025 12:47:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 "Edgar E.Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
Message-ID: <aAjTT6qRwp139RII@redhat.com>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
 <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 23, 2025 at 01:23:28PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Mark,
> 
> On 23/4/25 12:18, Mark Cave-Ayland wrote:
> > On 23/04/2025 11:02, BALATON Zoltan wrote:
> > 
> > > Simple series doing what the subject says.
> > > 
> > > v2:
> > > - Added changes to qemu.nsi (Philippe)
> > > - Changed order of enum to keep it sorted. This changes value of
> > > existing define but the value is not relevant, always used by name.
> > > 
> > > BALATON Zoltan (2):
> > >    system/datadir: Add new type constant for DTB files
> > >    pc-bios: Move device tree files in their own subdir
> > > 
> > >   MAINTAINERS                                |   2 +-
> > >   hw/microblaze/boot.c                       |   2 +-
> > >   hw/ppc/ppc440_bamboo.c                     |   2 +-
> > >   hw/ppc/sam460ex.c                          |   2 +-
> > >   hw/ppc/virtex_ml507.c                      |   2 +-
> > >   include/qemu/datadir.h                     |  11 +++++++---
> > >   pc-bios/{ => dtb}/bamboo.dtb               | Bin
> > >   pc-bios/{ => dtb}/bamboo.dts               |   0
> > >   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
> > >   pc-bios/{ => dtb}/canyonlands.dts          |   0
> > >   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
> > >   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
> > >   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
> > >   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
> > >   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
> > >   pc-bios/meson.build                        |  23 +--------------------
> > >   qemu.nsi                                   |   2 +-
> > >   system/datadir.c                           |   5 ++++-
> > >   18 files changed, 42 insertions(+), 32 deletions(-)
> > >   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
> > >   rename pc-bios/{ => dtb}/bamboo.dts (100%)
> > >   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
> > >   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
> > >   create mode 100644 pc-bios/dtb/meson.build
> > >   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
> > >   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
> > >   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
> > >   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
> > 
> > In previous discussions we've had around what to do with pc-bios, wasn't
> > the consensus that we should aim towards dividing up the directory on a
> > per-target basis? I'm wondering if this is going in right direction, as
> > I can certainly see that a per-target split would be more useful to
> > packagers.
> 
> pc-bios/ is already a mess, packagers usually take it as a whole. This
> series isn't making the current situation worse.
> 
> I don't recall a per-target split discussion, but one moving firmware
> blobs out of tree in a more adapted storage like git-lfs.

Talking about the pc-bios dir in general is a bit of a can of worms
and we never make concrete progress historically :-(

Probably best to split up the problem to some extent.

The device tree files are conceptually quite different from the
3rd party pre-built firmware images, which are diffferent from
the keymaps.

IIUC, device tree files are tied to specific machine types, so
I wonder if they should not simply live alongside their machine
type .c impl file, completely outside of pc-bios ?

eg

  petalogix-ml605.{dts,dtb} live alongside hw/microblaze/petalogix_ml605_mmu.c
  babmboo.{dts,dtb} live alongside ./hw/ppc/ppc440_bamboo.c

For the keymaps it feels like an probable easy win to move them to a
ui/keymaps/ directory instead.

ie in general try to get 'pc-bios' to contain only 3rd party pre-built
binaries, as a first goal. A second goal might be merging pc-bios/
into roms/, and a final goal could be spinning off pre-built ROMs into
a separate release tarball, and/or separate git repos.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



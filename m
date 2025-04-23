Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F5C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cBq-0007CN-UK; Wed, 23 Apr 2025 11:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7cBo-0007By-Qu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7cBm-0004Gy-3P
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745422744;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCdV5LZYYgWNtXt/PTCM6oD+0lYJ92rn9zDLZzXr+Vo=;
 b=RPbK4pAdIkLZTSjSBUAVRsxUoNHbafxpU2oddj9v8gpcRVGTIbvJR6iCIAIp8ZfWpBsqD5
 LkZ+k2fEib88v9y4zMZwN40p0LWjYvAlvvsy2YSGAwLSC42JU07lfZVIElX80ZDEt/+atW
 LqOUyL5+sLzC9zsbWr4cE+WfYxewxps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-iGr2ODp1MHSck9BqudfYWw-1; Wed,
 23 Apr 2025 11:39:01 -0400
X-MC-Unique: iGr2ODp1MHSck9BqudfYWw-1
X-Mimecast-MFC-AGG-ID: iGr2ODp1MHSck9BqudfYWw_1745422739
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A3BD1800370; Wed, 23 Apr 2025 15:38:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77DC519560A3; Wed, 23 Apr 2025 15:38:53 +0000 (UTC)
Date: Wed, 23 Apr 2025 16:38:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 "Edgar E.Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/2] Move device tree files in a subdir in pc-bios
Message-ID: <aAkJinmfMk9sbYuB@redhat.com>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <f3501944-f278-45a8-91a7-0dab5a5416e0@nutanix.com>
 <dc690610-8484-4da0-9233-74d711f263cf@linaro.org>
 <aAjTT6qRwp139RII@redhat.com>
 <fe7faa77-6480-b6cb-fb7e-b0ae17735646@eik.bme.hu>
 <aAjlEd5aSx578AJ0@redhat.com>
 <96a9f5d9-576e-bfe7-6da5-411aaaf745e9@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96a9f5d9-576e-bfe7-6da5-411aaaf745e9@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Wed, Apr 23, 2025 at 04:07:27PM +0200, BALATON Zoltan wrote:
> On Wed, 23 Apr 2025, Daniel P. Berrangé wrote:
> > On Wed, Apr 23, 2025 at 02:54:26PM +0200, BALATON Zoltan wrote:
> > > On Wed, 23 Apr 2025, Daniel P. Berrangé wrote:
> > > > On Wed, Apr 23, 2025 at 01:23:28PM +0200, Philippe Mathieu-Daudé wrote:
> > > > > Hi Mark,
> > > > > 
> > > > > On 23/4/25 12:18, Mark Cave-Ayland wrote:
> > > > > > On 23/04/2025 11:02, BALATON Zoltan wrote:
> > > > > > 
> > > > > > > Simple series doing what the subject says.
> > > > > > > 
> > > > > > > v2:
> > > > > > > - Added changes to qemu.nsi (Philippe)
> > > > > > > - Changed order of enum to keep it sorted. This changes value of
> > > > > > > existing define but the value is not relevant, always used by name.
> > > > > > > 
> > > > > > > BALATON Zoltan (2):
> > > > > > >    system/datadir: Add new type constant for DTB files
> > > > > > >    pc-bios: Move device tree files in their own subdir
> > > > > > > 
> > > > > > >   MAINTAINERS                                |   2 +-
> > > > > > >   hw/microblaze/boot.c                       |   2 +-
> > > > > > >   hw/ppc/ppc440_bamboo.c                     |   2 +-
> > > > > > >   hw/ppc/sam460ex.c                          |   2 +-
> > > > > > >   hw/ppc/virtex_ml507.c                      |   2 +-
> > > > > > >   include/qemu/datadir.h                     |  11 +++++++---
> > > > > > >   pc-bios/{ => dtb}/bamboo.dtb               | Bin
> > > > > > >   pc-bios/{ => dtb}/bamboo.dts               |   0
> > > > > > >   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
> > > > > > >   pc-bios/{ => dtb}/canyonlands.dts          |   0
> > > > > > >   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
> > > > > > >   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
> > > > > > >   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
> > > > > > >   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
> > > > > > >   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
> > > > > > >   pc-bios/meson.build                        |  23 +--------------------
> > > > > > >   qemu.nsi                                   |   2 +-
> > > > > > >   system/datadir.c                           |   5 ++++-
> > > > > > >   18 files changed, 42 insertions(+), 32 deletions(-)
> > > > > > >   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
> > > > > > >   rename pc-bios/{ => dtb}/bamboo.dts (100%)
> > > > > > >   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
> > > > > > >   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
> > > > > > >   create mode 100644 pc-bios/dtb/meson.build
> > > > > > >   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
> > > > > > >   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
> > > > > > >   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
> > > > > > >   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
> > > > > > 
> > > > > > In previous discussions we've had around what to do with pc-bios, wasn't
> > > > > > the consensus that we should aim towards dividing up the directory on a
> > > > > > per-target basis? I'm wondering if this is going in right direction, as
> > > > > > I can certainly see that a per-target split would be more useful to
> > > > > > packagers.
> > > 
> > > One problem is that pc-bios doesn't only contain machine firmware but also
> > > card ROMs which would belong to more targets (or archs) as e.g. PCI cards
> > > work on multiple archs. So it's not trivial to split by target, you'd still
> > > have a lot of files not easily assigned to any target.
> > > 
> > > This series is in preparation for another that will add a dtb for pegasos2
> > > and I did not want to increase the mess and took the opportunity to try to
> > > tidy it a bit. I don't intend to do any major refactoring of the pc-bios
> > > dir, that's out of scope of these patches.
> > > 
> > > > > pc-bios/ is already a mess, packagers usually take it as a whole. This
> > > > > series isn't making the current situation worse.
> > > > > 
> > > > > I don't recall a per-target split discussion, but one moving firmware
> > > > > blobs out of tree in a more adapted storage like git-lfs.
> > > > 
> > > > Talking about the pc-bios dir in general is a bit of a can of worms
> > > > and we never make concrete progress historically :-(
> > > > 
> > > > Probably best to split up the problem to some extent.
> > > > 
> > > > The device tree files are conceptually quite different from the
> > > > 3rd party pre-built firmware images, which are diffferent from
> > > > the keymaps.
> > > > 
> > > > IIUC, device tree files are tied to specific machine types, so
> > > > I wonder if they should not simply live alongside their machine
> > > > type .c impl file, completely outside of pc-bios ?
> > > > 
> > > > eg
> > > > 
> > > >  petalogix-ml605.{dts,dtb} live alongside hw/microblaze/petalogix_ml605_mmu.c
> > > >  babmboo.{dts,dtb} live alongside ./hw/ppc/ppc440_bamboo.c
> > > 
> > > You need the dtbs at run time and the dir where we can look files up is the
> > > pc-bios. So these need to be installed there at the end. We could scatter
> > > them around in the source to put them next their machines but that would
> > > make installation of them more difficult than having it in one dir.
> > > 
> > > > For the keymaps it feels like an probable easy win to move them to a
> > > > ui/keymaps/ directory instead.
> > > 
> > > Currently you can run a git build directly from build dir and it will find
> > > the roms/dtbs/keymaps. You can also run a binary copied elsewhere if you
> > > pass -L path/to/pc-bios. Moving things out of it would break this and may
> > > cause more problems than it would solve.
> > 
> > 
> > This is just describing a limitation of the current resource locating
> > implementation. For running in tree there's no reason why we can't
> > look in a different directory for keymaps/dtbs - we just took the
> > lazy option historically of putting them alongside firmware. That
> > can be fixed.
> 
> Yes but then you would need either two or more options for copied binary to
> point it to different directories for rom/dtb/keymap or make -L take a
> search path and list multiple directories. That's not too convenient for
> users.

I was only refering to changing the source tree location, which QEMU can
auto-detect relative to the binary being executed, and should need to involve
changes to -L.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



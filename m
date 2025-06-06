Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABE7C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTAe-0002J3-En; Fri, 06 Jun 2025 05:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNTAd-0002Iq-9I
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNTAb-0007fY-3s
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749201322;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IU2wsDOaxyt2rOoHHu7jFsXYYaLg/5hN1gbBux97bB4=;
 b=RmFD/TgkmF5eW8DwTh12Sol4Lx5gRlfNDDfqRFhYGXGMkmCidy5IhC9mb1XWyyLJ2gPD5M
 I77GfipFV/XMK9wytnXcXiwqzCw+XgsO2WYQ07aMDJOeCQqNMW6QB9Y2HShM/fh2fFqTfS
 da8SoOOSgumKmUsgxHZCLBOJPkJkPeY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-DmZGGDP0MO2HgzcYVX1sgg-1; Fri,
 06 Jun 2025 05:15:20 -0400
X-MC-Unique: DmZGGDP0MO2HgzcYVX1sgg-1
X-Mimecast-MFC-AGG-ID: DmZGGDP0MO2HgzcYVX1sgg_1749201319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F54D1801BD6; Fri,  6 Jun 2025 09:15:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C447418003FD; Fri,  6 Jun 2025 09:15:15 +0000 (UTC)
Date: Fri, 6 Jun 2025 10:15:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
Message-ID: <aEKxoAw2l3Ki9RhS@redhat.com>
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
 <9b083ae2-3afb-43f4-8929-fc693b581a0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b083ae2-3afb-43f4-8929-fc693b581a0d@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Fri, Jun 06, 2025 at 11:04:34AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/6/25 09:52, Daniel P. Berrangé wrote:
> > On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote:
> > > Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> > > the x86 need the vgabios-ramfb.bin, this can cause that when use the
> > > release package on arm64 it can't find the vgabios-ramfb.bin.
> > > 
> > > Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> > > is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> > > for ramfb, so they don't need to load the romfile.
> > > 
> > > So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
> > > device, because the vfio display also use the ramfb_setup() to load
> > > the vgabios-ramfb.bin file.
> > > 
> > > After have this property, the machine type can set the compatibility to
> > > not load the vgabios-ramfb.bin if the arch doesn't need it.
> > 
> > Can you make this a series, with an additional patch that updates the
> > current in-dev machine types to use this new property, so we're clear
> > about the proposed usage.
> > 
> > > 
> > > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > > ---
> > >   hw/display/ramfb-standalone.c | 4 +++-
> > >   hw/display/ramfb-stubs.c      | 2 +-
> > >   hw/display/ramfb.c            | 6 ++++--
> > >   hw/vfio/display.c             | 4 ++--
> > >   hw/vfio/pci.c                 | 1 +
> > >   hw/vfio/pci.h                 | 1 +
> > >   include/hw/display/ramfb.h    | 2 +-
> > >   7 files changed, 13 insertions(+), 7 deletions(-)
> 
> 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 7f1532fbed..4e4759c954 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
> > >   static const Property vfio_pci_dev_nohotplug_properties[] = {
> > >       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> > > +    DEFINE_PROP_BOOL("use_legacy_x86_rom", VFIOPCIDevice, use_legacy_x86_rom, true),
> > >       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
> > >                               ON_OFF_AUTO_AUTO),
> > >   };
> 
> Alternatively with target-info API:

Don't we need to use the property in order to tie this to the
machine type ? Even if existing non-x86 machines are not using
this ROM, the fact that QEMU loaded it will impact the guest
memory layout which needs to be preserved across migration,
and thus machine type versions.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



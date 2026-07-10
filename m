Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPF-0000ZZ-Lx; Fri, 10 Jul 2026 10:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wiCP3-0000ZH-KY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wiCOy-0004k3-Fs
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783694415;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HD2RRcjG7IqCqk5hKuaGhh/MMTbY+j2VVjcIKkEyZu0=;
 b=LlzsrT/4lqrZuFjWePQubX3s/QeEVPMACNxlHq2XRJ3FyAk4w4ygOQuBuCIJkTROLAM3kn
 Fzmr/sTRSC0WUhBVOIXSd0D/Yn5DzXjYmuCWirPTdLEiOfBDimqJBBfR3K5Q0xq7PBn4s2
 W44POzjZT8j+LBtorhkfUqFXeKhjDgE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-RLTn7fAoPZG3hILclHpspA-1; Fri,
 10 Jul 2026 10:40:11 -0400
X-MC-Unique: RLTn7fAoPZG3hILclHpspA-1
X-Mimecast-MFC-AGG-ID: RLTn7fAoPZG3hILclHpspA_1783694410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C2EA195606F; Fri, 10 Jul 2026 14:40:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D2B6195608E; Fri, 10 Jul 2026 14:40:08 +0000 (UTC)
Date: Fri, 10 Jul 2026 15:40:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <alEEROvr0gbuWCB2@redhat.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <2355649.iZASKD2KPV@weasel> <20260710145149.6e077fdd@imammedo>
 <2055091.yKVeVyVuyW@weasel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2055091.yKVeVyVuyW@weasel>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jul 10, 2026 at 04:31:51PM +0200, Christian Schoenebeck wrote:
> On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote:
> > On Fri, 10 Jul 2026 12:49:06 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
> [...]
> > note: I'm looking from pov of hotpluggable PCI device and generic hotplug
> > infra, only.
> 
> That's okay, but so far I don't see the relevance for this particular 9p 
> device.
>  
> > it's not guest users directly, it's how hotplug flow works for various guest
> > OSes:
> > 
> > 1. host plugs device in (-device or device_add)
> > 2. guest OS get's notified one way or another and does what ever guest side
> >    init needed (incl. mounting share in 9pfs case)
> 
> That's not affected by this patch, right?
> 
> > opposite flow:
> > 1. host does device_del (basically notify guest to remove device)
> > 2. guest OS frees resources and tells qemu to delete device
> > 3. qemu process remove event (which incl. unrealize as part of destroying
> > device)
> 
> And that's not affected by this patch either, right?
> 
> > Of cause guest if free to eject device without signal from host,
> 
> OK, here is the point where we deviate: you are apparently seeing this from a 
> purely theoretical PoV.
> 
> I am facing reality: for several years I'm the only person taking care about 
> this piece of code at all (on a side channel, for free, next to my actual 
> work). And for several months I get AI generated security reports thrown at 
> me, where I have to a) filter legit ones, and b) fix those legit security 
> issues.
> 
> For that reason, I am tightening security wherever I can, to prevent further 
> flood.
> 
> So the question here is: are you concerned about a real-life issue being 
> introduced by disabling hotplugging for 9pfs specifically?
> 
> > (I could imagine: get some file from share once and then guest releases
> > no longer need resource).
> 
> It's a pass-through file system. Ejecting the device does not really free a 
> noteworthy amount of resources.
> 
> > > Looking at the fixed issue (patch 1), my impression was that original 9p
> > > server developers were unaware that guest can actually trigger a device
> > > unrealize via ACPI eject.
> > 
> > I'd say it's a bug, and you are trying to fix it in patch #1
> > 
> > > Most probably because hotplugging is enabled by
> > > default for all devices in QEMU
> > 
> > it is on by default for PCI devices but also heavily depends on used
> > configuration (where/what is plugged).
> 
> Exactly! And I was trying to explain, that for this particular use case 
> (9pfs), I don't see any real-live use-case for allowing a guest to eject the 
> 9p device at runtime.
> 
> So why allowing it? Just for fun?

I don't think it would be usual for a guest to unilaterally "eject"
a 9p device. A host initiated PCI hot-unplug request from QEMU
would ultimately trigger the guest eject code path though. IMHO
host initiated hotplug+unplug is a valid use for any device. For
9p the use is to provide a time limited data share to some workload
in the guest. There are many other ways that can be done too,
USB MTP, or virtiofs, or in guest with SFTP or WebDAV, etc. 


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE68C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjMa-0007jG-L3; Fri, 17 Jul 2026 10:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkjMZ-0007ih-87
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkjMX-00061o-6d
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784297783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEqI7u2d1vz+ptZrxtjRcEXO53QauCJBCGPuLkeYV74=;
 b=RMyJsHj8vwFSquxEwPo32l49oiQ/geaEIFgbsR0B6bn+Z0LP5gTMs+il7KctsETAtQdD8l
 PCSR45L7dAtoRYHwZwFFGFje7jDAYhSVglgjLeQgkTqbvfx6PNrG4tnKpio+My/U66T5SI
 5vKrfxrM1MSBjTdXOOIomiJOr2T4xbw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-t4tgfv2zPU2m2iLdSKj4kg-1; Fri,
 17 Jul 2026 10:16:22 -0400
X-MC-Unique: t4tgfv2zPU2m2iLdSKj4kg-1
X-Mimecast-MFC-AGG-ID: t4tgfv2zPU2m2iLdSKj4kg_1784297781
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A692195D008; Fri, 17 Jul 2026 14:16:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7446C1955D89; Fri, 17 Jul 2026 14:16:18 +0000 (UTC)
Date: Fri, 17 Jul 2026 15:16:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <alo5LiqOfOVx0Yxu@redhat.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <alEEROvr0gbuWCB2@redhat.com> <20260713094935.5eda77f9@imammedo>
 <3767624.R56niFO833@weasel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3767624.R56niFO833@weasel>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 17, 2026 at 04:05:42PM +0200, Christian Schoenebeck wrote:
> On Monday, 13 July 2026 09:49:35 CEST Igor Mammedov wrote:
> > On Fri, 10 Jul 2026 15:40:04 +0100
> > 
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > On Fri, Jul 10, 2026 at 04:31:51PM +0200, Christian Schoenebeck wrote:
> > > > On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote:
> > > > > On Fri, 10 Jul 2026 12:49:06 +0200
> > > > > 
> > > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > > > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
> > > > [...]
> > > > 
> > > > > note: I'm looking from pov of hotpluggable PCI device and generic
> > > > > hotplug
> > > > > infra, only.
> > > > 
> > > > That's okay, but so far I don't see the relevance for this particular 9p
> > > > device.
> > > > 
> > > > > it's not guest users directly, it's how hotplug flow works for various
> > > > > guest OSes:
> > > > > 
> > > > > 1. host plugs device in (-device or device_add)
> > > > > 2. guest OS get's notified one way or another and does what ever guest
> > > > > side
> > > > > 
> > > > >    init needed (incl. mounting share in 9pfs case)
> > > > 
> > > > That's not affected by this patch, right?
> > > > 
> > > > > opposite flow:
> > > > > 1. host does device_del (basically notify guest to remove device)
> > > > > 2. guest OS frees resources and tells qemu to delete device
> > > > > 3. qemu process remove event (which incl. unrealize as part of
> > > > > destroying
> > > > > device)
> > > > 
> > > > And that's not affected by this patch either, right?
> > 
> > the patch would break unplug flow by effectively removing 'eject' knob
> > from guest side, which is part of unplug flow.
> 
> These are two different things: device_del would not be affected by this. 
> 
> 1. Ejecting the device from host side e.g. via QMP would still work.
> 
> vs.
> 
> 2. Ejecting from guest side OTOH would be disabled.
> 
> It is also different from regular block devices where you have convenient ways
> to eject a block device on guest OSes. For a virtio-9p device it is not that
> easy.

Igor can correct me if I'm wrong, but IIUC there's no distinction
to those 2 scenarios from the guest POV.

A "device_del" in QMP does not actually delete a device from the
QEMU POV.  Rather it triggers an ACPI notification to the geust
OS, that the operator wants to unplug the device.  The guest OS
then honours (or not) that by initiating a guest side "eject".
IOW disabling guest initiated eject would break device_del too
AFAIK.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



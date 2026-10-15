Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398BDCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIlR-0003pP-Jh; Thu, 15 Oct 2026 06:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHIhA-0007ZT-R2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHIh6-0004I2-1u
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792060088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7oHPeIhHHfU6pIl6P6bY4huHu94oYT0/9LEjI0NSVNc=;
 b=AbBOFzITeR4FvJvrmzaGTJ+hZo3zwb2kTO/lTuewV4aTc3GSCr85D/wF64K/WeNrX+26S2
 RC5rGT1faF7mwgqtiaMDkyY8o8ua7zxbZYiUCP79P0qot7oIYNkcP+Oo/7XXvkC4l2ThU0
 IIOxEqvCV5SP1ZFNtHgDrufMrQ/aDU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-FOlViITcND-6l45paD8svw-1; Thu,
 15 Oct 2026 10:28:07 +0000
X-MC-Unique: FOlViITcND-6l45paD8svw-1
X-Mimecast-MFC-AGG-ID: FOlViITcND-6l45paD8svw_1792060086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E36A7195605F; Thu, 15 Oct 2026 10:28:05 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D0AA3000738; Thu, 15 Oct 2026 10:28:03 +0000 (UTC)
Date: Thu, 15 Oct 2026 11:28:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] pci id: clarify pci subsystem id usage
Message-ID: <atCqsLfQb3rkKcsP@redhat.com>
References: <20261015081544.40310-1-kraxel@redhat.com>
 <20261015081544.40310-2-kraxel@redhat.com>
 <atCSufyPp8vdreSI@redhat.com>
 <atCmDyLUrH6D0JaS@nucbdw.ghoffman.csb.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atCmDyLUrH6D0JaS@nucbdw.ghoffman.csb.home.kraxel.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Thu, Oct 15, 2026 at 12:20:59PM +0200, Gerd Hoffmann wrote:
> On Thu, Oct 15, 2026 at 09:45:45AM +0100, Daniel P. Berrangé wrote:
> > >  1af4:1100
> > > -  Used as PCI Subsystem ID for existing hardware devices emulated
> > > -  by QEMU.
> > > +  Used as PCI Subsystem ID for existing hardware devices emulated by
> > > +  QEMU, such as the intel chipset devices.  Also used for virtio
> > > +  devices and generic pci class devices (1b36:00xx, see below).
> > 
> > When talking virtio devices, does that include virtio devices
> > implemented outside QEMU via vhostuser, or only in-QEMU virtio
> > devices ?
> 
> For vhost devices the pci config space emulation is still handled by
> qemu.  On a quick check I don't see anything special done for vhost,
> so I expect the same subsystem ID being used.

So IIUC, the QEMU subsystem ID applies to every PCI device exposed
from QEMU, except for VFIO passthrough of host devices.

> 
> Maybe we should extend the vhost protocol to allow overriding the
> subsystem id, so linux kernel / rust-vmm  / ... can have their own
> subsystem ids?

Would be a good idea as a way to distinguish the QEMU impls for
virtio devices, from 3rd party ones accessed via vhostuser.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



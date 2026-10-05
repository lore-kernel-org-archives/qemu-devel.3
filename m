Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A84ECA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDf0e-0002Ce-0z; Mon, 05 Oct 2026 05:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDf0Z-00029w-HR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDf0W-0004vv-TL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791192555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWEaBtZdiYhiKz5AQwLJW7nAdhFU5R4j3oWNHV/QcxM=;
 b=beCl2XsvpbLI/+18Dm9AQSj7neN+iANtlRDiXR6wXEnW8ilmTjK8Cl/4nk0QOPHbDeDvzr
 1L1A6Hn1GPrgSg4gGh3rf4topKz+vnYpM1LWsBwFTYVs8nG/qjciBOSl+C+n1hwc7oWL5z
 Xfel6/6Xcgg780eup2EDvT51kOwvT50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-1ZELo3cIMrCOlbnw_6lU1Q-1; Mon,
 05 Oct 2026 05:29:13 -0400
X-MC-Unique: 1ZELo3cIMrCOlbnw_6lU1Q-1
X-Mimecast-MFC-AGG-ID: 1ZELo3cIMrCOlbnw_6lU1Q_1791192552
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 605A818007E7; Mon,  5 Oct 2026 09:29:12 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7051956087; Mon,  5 Oct 2026 09:29:10 +0000 (UTC)
Date: Mon, 5 Oct 2026 10:29:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 03/28] hw: mark all virtio PCI devices as secure
Message-ID: <asNt4xv7ziocHrwq@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-4-berrange@redhat.com>
 <179096166110.3025252.6768256984831473183.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179096166110.3025252.6768256984831473183.b4-review@b4>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 02, 2026 at 09:21:01PM +0400, marcandre.lureau@redhat.com wrote:
> > These are all intended for use in a virtualization scenario and must
> > provide a security boundary. This can be done for almost all virtio
> > PCI devices by modifying the common type register helper.
> > 
> > The virtio-gpu devices are unusual in not using the common
> > virtio_pci_types_register() method, so need marking directly.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20260911143627.2743803-4-berrange@redhat.com>
> >
> > diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
> > index 4db77cb868db..a8e5e1d96cf3 100644
> > --- a/hw/display/virtio-gpu-pci-rutabaga.c
> > +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> > @@ -34,6 +34,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
> >          .parent = TYPE_VIRTIO_GPU_PCI_BASE,
> >          .instance_size = sizeof(VirtIOGPURutabagaPCI),
> >          .instance_init = virtio_gpu_rutabaga_initfn,
> > +        .secure = true,
> 
> This is unusual, I wonder why it's not using the VirtioPCIDeviceTypeInfo

Yeah, I don't know  the reason for that choice.

> 
> >          .interfaces = (const InterfaceInfo[]) {
> >              { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> >              { },
> > diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
> > index 22659ca196b5..0b0d926a5b95 100644
> > --- a/hw/display/virtio-gpu-pci.c
> > +++ b/hw/display/virtio-gpu-pci.c
> > @@ -75,7 +75,8 @@ static const TypeInfo virtio_gpu_pci_base_info = {
> >      .parent = TYPE_VIRTIO_PCI,
> >      .instance_size = sizeof(VirtIOGPUPCIBase),
> >      .class_init = virtio_gpu_pci_base_class_init,
> > -    .abstract = true
> > +    .abstract = true,
> > +    .secure = true,
> 
> This is a base class, probably doesn't need marking.

Not /yet/.  I have a follow on series to this, not yet  posted,
which will enforce that all parent classes are marked secure,
when any leaf is marked secure.  There will be many more base
classes to add besides this one, which crept in here.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



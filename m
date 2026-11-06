Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD73606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ORnA/dD/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJSo-0007SR-KQ; Fri, 06 Nov 2026 07:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPJSh-0007RB-83
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPJSf-000384-B2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793969667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tuqOHi/DAv3Ntu/X9SueCitZSZrMHUq1vb3bbhm1Nw=;
 b=ORnA/dD/n228aNuI+UOLQTlPqclmDYOE2jXn7GGvVwfMyzkPO/elVuUUKp3Ch1Fpi55NV6
 bAeIDUuDeHHtf+Jzg+0enBhudLHoOjbQdFhMmxqiAlUpfkiLHuwZpe2GlhikGIC+UF+EmT
 CXKAHzp2fLWhkfep1tbnbrzBeSj3br0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-cBcov_5BPUiNGJwKq8qkfg-1; Fri,
 06 Nov 2026 07:54:26 -0500
X-MC-Unique: cBcov_5BPUiNGJwKq8qkfg-1
X-Mimecast-MFC-AGG-ID: cBcov_5BPUiNGJwKq8qkfg_1793969665
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13BB4195604C; Fri,  6 Nov 2026 12:54:25 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D55EA18001DA; Fri,  6 Nov 2026 12:54:21 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:54:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 14/28] hw/pci-host: mark common x86, ppc, arm and s390
 PCI hosts as secure
Message-ID: <au3N-jAL8AqU44xa@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-15-berrange@redhat.com>
 <6d195593-7cf4-40b2-8143-098771967876@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d195593-7cf4-40b2-8143-098771967876@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 01:38:12PM +0100, Thomas Huth wrote:
> On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> > Mark the PCI hosts secure if they are used from machine types
> > that are considered for the virtualization use case.
> > 
> > There is also a special case for the 'remote' type and the
> > Xen passthrough type.
> > 
> > Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Cornelia Huck <cohuck@redhat.com> #s390
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> ...
> > diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> > index 0b556d1bf5c..bc8313d2cd0 100644
> > --- a/hw/pci-host/pnv_phb.c
> > +++ b/hw/pci-host/pnv_phb.c
> > @@ -333,6 +333,7 @@ static const TypeInfo pnv_phb_type_info = {
> >       .parent        = TYPE_PCIE_HOST_BRIDGE,
> >       .instance_size = sizeof(PnvPHB),
> >       .class_init    = pnv_phb_class_init,
> > +    .secure        = true,
> >   };
> >   static const TypeInfo pnv_phb_root_port_info = {
> > @@ -340,6 +341,7 @@ static const TypeInfo pnv_phb_root_port_info = {
> >       .parent        = TYPE_PCIE_ROOT_PORT,
> >       .instance_size = sizeof(PnvPHBRootPort),
> >       .class_init    = pnv_phb_root_port_class_init,
> > +    .secure        = true,
> >   };
> >   static void pnv_phb_register_types(void)
> > diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> > index db061c134e9..abf43e3226d 100644
> > --- a/hw/pci-host/pnv_phb3.c
> > +++ b/hw/pci-host/pnv_phb3.c
> > @@ -910,6 +910,7 @@ static const TypeInfo pnv_phb3_iommu_memory_region_info = {
> >       .parent = TYPE_IOMMU_MEMORY_REGION,
> >       .name = TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
> >       .class_init = pnv_phb3_iommu_memory_region_class_init,
> > +    .secure = true,
> >   };
> >   /*
> > @@ -1123,6 +1124,7 @@ static const TypeInfo pnv_phb3_type_info = {
> >       .instance_size = sizeof(PnvPHB3),
> >       .class_init    = pnv_phb3_class_init,
> >       .instance_init = pnv_phb3_instance_init,
> > +    .secure        = true,
> >   };
> >   static void pnv_phb3_root_bus_get_prop(Object *obj, Visitor *v,
> > @@ -1186,6 +1188,7 @@ static const TypeInfo pnv_phb3_root_bus_info = {
> >       .parent = TYPE_PCIE_BUS,
> >       .instance_size = sizeof(PnvPHB3RootBus),
> >       .class_init = pnv_phb3_root_bus_class_init,
> > +    .secure = true,
> >   };
> >   static void pnv_phb3_register_types(void)
> > diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
> > index 66ba7b79134..5edc0d43eb0 100644
> > --- a/hw/pci-host/pnv_phb3_msi.c
> > +++ b/hw/pci-host/pnv_phb3_msi.c
> > @@ -306,6 +306,7 @@ static const TypeInfo phb3_msi_info = {
> >       .class_init = phb3_msi_class_init,
> >       .class_size = sizeof(ICSStateClass),
> >       .instance_init = phb3_msi_instance_init,
> > +    .secure = true,
> >   };
> >   static void pnv_phb3_msi_register_types(void)
> > diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
> > index 1f7a149580d..687c8325158 100644
> > --- a/hw/pci-host/pnv_phb3_pbcq.c
> > +++ b/hw/pci-host/pnv_phb3_pbcq.c
> > @@ -354,6 +354,7 @@ static const TypeInfo pnv_pbcq_type_info = {
> >       .instance_size = sizeof(PnvPBCQState),
> >       .instance_init = phb3_pbcq_instance_init,
> >       .class_init    = pnv_pbcq_class_init,
> > +    .secure        = true,
> >       .interfaces    = (const InterfaceInfo[]) {
> >           { TYPE_PNV_XSCOM_INTERFACE },
> >           { }
> > diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> > index ac09a0b034d..1a652110f5d 100644
> > --- a/hw/pci-host/pnv_phb4.c
> > +++ b/hw/pci-host/pnv_phb4.c
> > @@ -1388,6 +1388,7 @@ static const TypeInfo pnv_phb4_iommu_memory_region_info = {
> >       .parent = TYPE_IOMMU_MEMORY_REGION,
> >       .name = TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
> >       .class_init = pnv_phb4_iommu_memory_region_class_init,
> > +    .secure = true,
> >   };
> >   /*
> > @@ -1729,13 +1730,13 @@ static const TypeInfo pnv_phb4_type_info = {
> >       .instance_init = pnv_phb4_instance_init,
> >       .instance_size = sizeof(PnvPHB4),
> >       .class_init    = pnv_phb4_class_init,
> > +    .secure        = true,
> >       .interfaces = (const InterfaceInfo[]) {
> >               { TYPE_XIVE_NOTIFIER },
> >               { },
> >       }
> >   };
> > -
> >   static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
> >                                          const char *name,
> >                                          void *opaque, Error **errp)
> > @@ -1797,6 +1798,7 @@ static const TypeInfo pnv_phb4_root_bus_info = {
> >       .parent = TYPE_PCIE_BUS,
> >       .instance_size = sizeof(PnvPHB4RootBus),
> >       .class_init = pnv_phb4_root_bus_class_init,
> > +    .secure = true,
> >   };
> >   static void pnv_phb4_register_types(void)
> > diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> > index ee5cdc3e450..280a15e8df1 100644
> > --- a/hw/pci-host/pnv_phb4_pec.c
> > +++ b/hw/pci-host/pnv_phb4_pec.c
> > @@ -388,6 +388,7 @@ static const TypeInfo pnv_pec_type_info = {
> >       .instance_size = sizeof(PnvPhb4PecState),
> >       .class_init    = pnv_pec_class_init,
> >       .class_size    = sizeof(PnvPhb4PecClass),
> > +    .secure        = true,
> >       .interfaces    = (const InterfaceInfo[]) {
> >           { TYPE_PNV_XSCOM_INTERFACE },
> >           { }
> 
> The changes to the pnv* files are related to the powernv machine - which is
> not covered by the virtualization use case. Please remove these from your
> patch.

Ah, I got misled in my search, as spapr mentions PHB, but its a
different context.


> > diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
> > index 9ea95fac6e6..a58fc39bded 100644
> > --- a/hw/pci-host/remote.c
> > +++ b/hw/pci-host/remote.c
> > @@ -63,6 +63,7 @@ static const TypeInfo remote_pcihost_info = {
> >       .parent = TYPE_PCIE_HOST_BRIDGE,
> >       .instance_size = sizeof(RemotePCIHost),
> >       .class_init = remote_pcihost_class_init,
> > +    .secure = true,
> >   };
> This is part of the "remote" machine, isn't it? I don't think we cover this
> in the virtualization use case, do we? Please remove this, too.

Agreed, a mistake.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



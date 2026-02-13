Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B6EF48EE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqp2P-0003S2-7f; Fri, 13 Feb 2026 04:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqp2M-0003RX-4q
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:00:31 -0500
Received: from smtppost.atos.net ([193.56.114.177] helo=smarthost4.atos.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vqp2G-0004dH-W6
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1770973225; x=1802509225;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Cp9HbbIx4GAS2t0tquqxdBJjBPuICJcmKiWiWANw5rE=;
 b=nqL1RZXmIdm52gE9ZLEzsnlS+aiUkH/UdR7NMRYsm36uprowYj8c4HYp
 HPqVbXmaAdMbedqra88qpXDWYKsCXnG0Wrrbdr5QJek7fvNWCiV+E8eWd
 Xlm5Hy1jUxc39WZnxwme0Cim9WUo0aSRlQKw6wC5nKl+gjZm2c2ioyEza
 dvN7++m02MeU3SlkGKaXtnF/gSz/NziTpXjFzDynWaSnInI5zDyZgyiFX
 eChTfHozQDMRAQs+KxFqF9Y2nujHcaVIklGZG3gl7jLS6HKw6Pp7aGQcy
 PXnqGi/OarvoGPf9o0FsGKXNTaaZ2+aWzlBw0Jo9wZPLKqHJah6RDWGAi w==;
X-CSE-ConnectionGUID: YWPN8QJwRG+sVdrhnQuBdg==
X-CSE-MsgGUID: SXhG+fH4S9q8lUjEgK9DRA==
X-IronPort-AV: E=Sophos;i="6.21,288,1763420400"; d="scan'208";a="826010220"
X-MGA-submission: =?us-ascii?q?MDHr2Itiidogdx3Y66q+MUDJ16cAqRU0gIsfm+?=
 =?us-ascii?q?OhZpJQ7R+urDBZd35hXdvZXb96YlWOZxxM0M9K3piT5dLWhoIV1RScjA?=
 =?us-ascii?q?XXG6vc3y/SzDkyI3AIyX21mgXQx9xXoGKOeuwLRsFj0SC0teasyFAG3L?=
 =?us-ascii?q?cy?=
Received: from smtp1.atos-infogerance.fr ([193.56.241.17])
 by smarthost4.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Feb 2026 10:00:19 +0100
Received: from smtp-hub.atos-infogerance.fr (smtp-hub.atos-infogerance.fr
 [193.56.47.18])
 by smtp1.atos-infogerance.fr (8.15.2/8.15.2) with ESMTPS id 61D90HeV042873
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Fri, 13 Feb 2026 10:00:18 +0100
Received: from rocky.hd2c.dom ([129.181.244.14])
 by smtp-hub.atos-infogerance.fr (envelope-from
 clement.mathieu--drif@eviden.com) (8.15.2/8.15.2) with ESMTP id
 61D90Hur001667; Fri, 13 Feb 2026 10:00:17 +0100
Received: from openbmc (unknown [10.22.85.22])
 by rocky.hd2c.dom (Postfix) with ESMTP id E14C2256CA5;
 Fri, 13 Feb 2026 10:00:17 +0100 (CET)
Received: from [127.0.0.1] (host.containers.internal [10.88.0.1])
 by openbmc (Postfix) with ESMTP id D4D8DC3018EE;
 Fri, 13 Feb 2026 09:00:16 +0000 (UTC)
Message-ID: <ee91038b24246edfd3a208f83e55b95107a94ca8.camel@eviden.com>
Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com"	 <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"	
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com"	 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"	
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L"	 <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Date: Fri, 13 Feb 2026 09:59:55 +0100
In-Reply-To: <IA3PR11MB9136B8106B0070F03CF9C32B9261A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
 <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
 <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <02bb4c9d859caec478e36d3c6cde6561ba3032ca.camel@eviden.com>
 <IA3PR11MB9136315AB6D784819ECF18C89261A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <eaebbfc58b626db6f946615a6e1d4ba13d6c5b84.camel@eviden.com>
 <IA3PR11MB9136B8106B0070F03CF9C32B9261A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=193.56.114.177;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.atos.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On Fri, 2026-02-13 at 08:43 +0000, Duan, Zhenzhong wrote:
>=20
>=20
>=20
> > -----Original Message-----
> > From: Clement Mathieu--Drif <[clement.mathieu--drif@eviden.com](mailto:=
clement.mathieu--drif@eviden.com)>
> > Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property from =
bool to
> > uint8
> >=20
> >=20
> > On Fri, 2026-02-13 at 01:21 +0000, Duan, Zhenzhong wrote:
> >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > > -----Original Message-----
> > > > From: Clement Mathieu--Drif <[clement.mathieu--
> > >=20
> >=20
> > [drif@eviden.com](mailto:drif@eviden.com)](mailto:[clement.mathieu--dri=
f@eviden.com](mailto:clement.mathieu--drif@eviden.com))>
> >=20
> > >=20
> > > > Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid property f=
rom bool
> > >=20
> >=20
> > to
> >=20
> > >=20
> > > > uint8
> > > >=20
> > > >=20
> > > > On Thu, 2026-02-12 at 08:16 +0000, Duan, Zhenzhong wrote:
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Clement Mathieu--Drif <[clement.mathieu--
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > [[drif@eviden.com](mailto:drif@eviden.com)](mailto:[drif@eviden.com=
](mailto:drif@eviden.com))](mailto:[clement.mathieu--
> > >=20
> >=20
> > [drif@eviden.com](mailto:drif@eviden.com)](mailto:[clement.mathieu--dri=
f@eviden.com](mailto:clement.mathieu--drif@eviden.com)))>
> >=20
> > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > > Subject: Re: [RFC PATCH 05/14] intel_iommu: Change pasid proper=
ty from
> > > > >=20
> > > >=20
> > >=20
> >=20
> > bool
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > to
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > > uint8
> > > > > >=20
> > > > > >=20
> > > > > > On Wed, 2026-02-04 at 22:11 -0500, Zhenzhong Duan wrote:
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > 'x-pasid-mode' is a bool property, we need an extra 'pss' pro=
perty to
> > > > > > > represent PASID size supported. Because there is no any devic=
e in QEMU
> > > > > > > supporting pasid capability yet, no guest could use the pasid=
 feature
> > > > > > > until now, 'x-pasid-mode' takes no effect.
> > > > > > >=20
> > > > > > > So instead of an extra 'pss' property we can use a single 'pa=
sid'
> > > > > > > property of uint8 type to represent if pasid is supported and=
 the PASID
> > > > > > > bits size. A value of N > 0 means pasid is supported and N - =
1 is the
> > > > > > > value in PSS field in ECAP register.
> > > > > > >=20
> > > > > > > Signed-off-by: Zhenzhong Duan
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> > >=20
> >=20
> > <[[[[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com)](mailto=
:[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com))](mailto:[zhen
> > [zhong.duan@intel.com](mailto:zhong.duan@intel.com)](mailto:[zhenzhong.=
duan@intel.com](mailto:zhenzhong.duan@intel.com)))](mailto:[zhen
> >=20
> > >=20
> > > >=20
> > >=20
> >=20
> > [[zhong.duan@intel.com](mailto:zhong.duan@intel.com)](mailto:[zhong.dua=
n@intel.com](mailto:zhong.duan@intel.com))](mailto:[zhenzhong.duan
> > @intel.com](mailto:[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@int=
el.com))))>
> >=20
> > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > ---
> > > > > > > =C2=A0hw/i386/intel_iommu_internal.h | 1 -
> > > > > > > =C2=A0include/hw/i386/intel_iommu.h=C2=A0 | 2 +-
> > > > > > > =C2=A0hw/i386/intel_iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > > > > > > =C2=A03 files changed, 3 insertions(+), 4 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/i386/intel_iommu_internal.h
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > b/hw/i386/intel_iommu_internal.h
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > index a2ca79f925..71cb3b662e 100644
> > > > > > > --- a/hw/i386/intel_iommu_internal.h
> > > > > > > +++ b/hw/i386/intel_iommu_internal.h
> > > > > > > @@ -194,7 +194,6 @@
> > > > > > > =C2=A0#define VTD_ECAP_PRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 29)
> > > > > > > =C2=A0#define VTD_ECAP_MHMV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (15ULL << 20)
> > > > > > > =C2=A0#define VTD_ECAP_SRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 31)
> > > > > > > -#define VTD_ECAP_PSS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (7ULL << 35) /* limit: =
MemTxAttrs::pid
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
> > */
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > > =C2=A0#define VTD_ECAP_PASID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 40)
> > > > > > > =C2=A0#define VTD_ECAP_SMTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 43)
> > > > > > > =C2=A0#define VTD_ECAP_SSTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 46)
> > > > > > > diff --git a/include/hw/i386/intel_iommu.h
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > b/include/hw/i386/intel_iommu.h
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > index 6c61fd39c7..5e5779e460 100644
> > > > > > > --- a/include/hw/i386/intel_iommu.h
> > > > > > > +++ b/include/hw/i386/intel_iommu.h
> > > > > > > @@ -315,7 +315,7 @@ struct IntelIOMMUState {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 bool buggy_eim;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Force buggy EIM unless eim=3Doff */
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t aw_bits;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Host/IOVA address width (in bits) */
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 bool dma_drain;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Whether DMA r/w draining enabled */
> > > > > > > -=C2=A0=C2=A0=C2=A0 bool pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* Whether to support PASID */
> > > > > > > +=C2=A0=C2=A0=C2=A0 uint8_t pasid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* PASID supported in bits, 0 if not */
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 bool fs1gp;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* First Stage 1-GByte Page Support */
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 /* Transient Mapping, Reserved(0) si=
nce VTD spec revision 3.2 */
> > > > > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > > > > index e8a6f50a5a..916eb0af5a 100644
> > > > > > > --- a/hw/i386/intel_iommu.c
> > > > > > > +++ b/hw/i386/intel_iommu.c
> > > > > > > @@ -4151,7 +4151,7 @@ static const Property vtd_properties[] =
=3D {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-scalable-mode", =
IntelIOMMUState,
> > > > > >=20
> > > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > > scalable_mode,
> > > >=20
> > > >=20
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > FALSE),
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-flts", IntelIOMM=
UState, fsts, FALSE),
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("snoop-control", In=
telIOMMUState,
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
> > snoop_control,
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > false),
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-pasid-mode", IntelIOM=
MUState, pasid, false),
> > > > > > > +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT8("pasid", IntelIOMMUStat=
e, pasid, 0),
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("dma-drain", IntelI=
OMMUState, dma_drain,
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
> > true),
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("stale-tm", IntelIO=
MMUState, stale_tm, false),
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("fs1gp", IntelIOMMU=
State, fs1gp, true),
> > > > > > > @@ -4981,7 +4981,7 @@ static void vtd_cap_init(IntelIOMMUStat=
e *s)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 if (s->pasid) {
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap |=3D VTD_=
ECAP_PASID | VTD_ECAP_PSS;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ecap =3D VTD_E=
CAP_PASID | deposit64(s->ecap, 35, 5, s->pasid -
> > > > > >=20
> > > > >=20
> > > >=20
> > >=20
> >=20
> > 1);
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > I think this is a bit dangerous, the MemTxAttrs only allow up t=
o 8 bits.
> > > > > > We have a comment next to the definition of VTD_ECAP_PSS about =
this.
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > Could you elaborate what dangerous do you see if s->pasid > 8?
> > > > > MemTxAttrs only allow up to 8bits, then Max PASID Width in emulat=
ed
> > > >=20
> > >=20
> >=20
> > device's
> >=20
> > >=20
> > > >=20
> > > > > PASID capability Register is no more than 8. Emulated device shou=
ld never
> > > >=20
> > >=20
> >=20
> > send
> >=20
> > >=20
> > > >=20
> > > > > a Request-with-pasid with pasid > 255.
> > > > >=20
> > > > > Hard code VTD_ECAP_PSS to 8 bits will make us not able to utilize=
 the full
> > > >=20
> > >=20
> >=20
> > pasid
> >=20
> > >=20
> > > >=20
> > > > > space of passthrough device if it has larger Max PASID Width valu=
e in pasid
> > > >=20
> > > >=20
> > > > capability.
> > > >=20
> > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > The previous approach was to make sure that the kernel never alloca=
tes a too
> > > > large pasid
> > > > by limiting the width in the iommu instead of doint it in the devic=
es. Your patch
> > > > seems to
> > > > reverse the problem. Is it something we are ready to accept?
> > >=20
> > >=20
> > >=20
> > > Not get your concern. Define a hard coded limit looks an overkill.
> > > How you define too large here, larger than MIN(iommu.VTD_ECAP_PSS, de=
vice's
> >=20
> > Max PASID Width)?
> >=20
> > Oh yep, you are righ, my "too large" is not very explicit.
> > I mean too large to be passed from an emulated device, all the way down=
 to the
> > iommu, through MemTxAttrs.
> >=20
> >=20
> > >=20
> > > IIUC, kernel should take MIN(iommu.VTD_ECAP_PSS, device's Max PASID W=
idth)
> >=20
> > as the upper limit
> >=20
> > > of pasid range.
> >=20
> >=20
> > Yes, that's true.
> > Our current implementation makes sure that this MIN is always smaller t=
han what
> > fits in MemTxAttrs.
> > This is always the case as pss is small enough.
> >=20
> > Increasing pss means that it's now up to devices to know that the attrs=
 cannot
> > carry a full-width pasid
> > and expose a lower pasid size to make sure the kernel never allocates a=
n out-of-
> > range pasid.
>=20
>=20
> I see your concern. =20
> Looked into RISC-V emulation series [https://lore.kernel.org/qemu-devel/2=
0241004155721.2154626-4-dbarboza@ventanamicro.com/](https://lore.kernel.org=
/qemu-devel/20241004155721.2154626-4-dbarboza@ventanamicro.com/) =20
> which introduced MemTxAttrs.pid, it looks MemTxAttrs.pid is only used by =
RISC-V, =20
> E.g., only riscv_iommu_memory_region_index() returns attrs.pid and pass i=
t to imrc->translate().
>=20
> For VTD and other vIOMMUs, we create different AddressSpace for different=
 pasid, =20
> When call imrc->translate() callback, it's enough to go ahead with Addres=
sSpace, =20
> we don't pass in pasid through iommu_idx parameter.
>=20
>=20
>=20
> > This a bit more dagerous for device implementors but I don't see any ot=
her way to
> > make accel work without this change. I just wanted to make sure that yo=
u noticed
> > the design shift behind your patch.
>=20
>=20
> I think it's not an issue with VTD as explained above.
>=20
>=20
>=20
> > btw, why do we need to pass the actual value on the command line? Could=
n't we
> > fetch the pss supported by
> > the underlying hardware and use the same value?
>=20
>=20
> Because we can have heterogeneous IOMMUs on host, PSS can be different be=
tween them. =20
> Meanwhile, take migration into consideration, it needs to be configurable=
 by user.

right

Thanks =20
cmd

>=20
> Thanks =20
> Zhenzhong
>=20
>=20
>=20
> > Thanks!
> > cmd
> >=20
> >=20
> > >=20
> > > We also have patch12 to ensure vIOMMU's pasid upper limit not bigger =
than
> >=20
> > host side:
> >=20
> > >=20
> > > @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
> >=20
> > VTDHostIOMMUDevice *vtd_hiod,
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 /* Only do the check when host device support PAS=
IDs */
> > > +=C2=A0=C2=A0=C2=A0 if (caps->max_pasid_log2 && s->pasid > hpasid) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "PASID b=
its size %d > host IOMMU PASID bits size %d",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->pasid, hpasid);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > Thanks
> > > Zhenzhong
> >
>=20


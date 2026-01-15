Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054EDD41174
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLht-0000Wa-Qu; Thu, 15 Jan 2026 06:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vgLh2-0000Mi-ND; Thu, 15 Jan 2026 06:39:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vgLgz-0005vL-FO; Thu, 15 Jan 2026 06:39:12 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsLbL4NpZzJ467k;
 Thu, 15 Jan 2026 19:38:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id CB36940086;
 Thu, 15 Jan 2026 19:38:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 11:38:53 +0000
Date: Thu, 15 Jan 2026 11:38:52 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Message-ID: <20260115113852.00004248@huawei.com>
In-Reply-To: <20260114073338-mutt-send-email-mst@kernel.org>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <20260114114556.0000153c@huawei.com>
 <CH3PR12MB7548C1DABCCCB8CB332B59A0AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260114073338-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 14 Jan 2026 07:35:01 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 14, 2026 at 12:26:29PM +0000, Shameer Kolothum wrote:
> >=20
> >  =20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Sent: 14 January 2026 11:46
> > > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.=
com;
> > > berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
> > > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > > smostafa@google.com; wangzhou1@hisilicon.com;
> > > jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> > > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > > <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> > > Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe exten=
ded
> > > capability at a fixed offset
> > >=20
> > > External email: Use caution opening links or attachments
> > >=20
> > >=20
> > > On Sun, 11 Jan 2026 19:53:19 +0000
> > > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> > >  =20
> > > > Add pcie_insert_capability(), a helper to insert a PCIe extended
> > > > capability into an existing extended capability list at a
> > > > caller-specified offset.
> > > >
> > > > Unlike pcie_add_capability(), which always appends a capability to =
the
> > > > end of the list, this helper preserves the existing list ordering w=
hile
> > > > allowing insertion at an arbitrary offset.
> > > >
> > > > The helper only validates that the insertion does not overwrite an
> > > > existing PCIe extended capability header, since corrupting a header
> > > > would break the extended capability linked list. Validation of over=
laps
> > > > with other configuration space registers or capability-specific
> > > > register blocks is left to the caller.
> > > >
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com> =20
> > > Hi Shameer. =20
> >=20
> > Happy new year!
> >  =20
> > >=20
> > > Random musings inline... Maybe I'm just failing in my spec grep skill=
s.
> > >  =20
> > > > ---
> > > >  hw/pci/pcie.c         | 58 =20
> > > +++++++++++++++++++++++++++++++++++++++++++ =20
> > > >  include/hw/pci/pcie.h |  2 ++
> > > >  2 files changed, 60 insertions(+)
> > > >
> > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > index b302de6419..8568a062a5 100644
> > > > --- a/hw/pci/pcie.c
> > > > +++ b/hw/pci/pcie.c
> > > > @@ -1050,6 +1050,64 @@ static void pcie_ext_cap_set_next(PCIDevice =
=20
> > > *dev, uint16_t pos, uint16_t next) =20
> > > >      pci_set_long(dev->config + pos, header);
> > > >  }
> > > >
> > > > +/*
> > > > + * Insert a PCIe extended capability at a given offset.
> > > > + *
> > > > + * This helper only validates that the insertion does not overwrit=
e an
> > > > + * existing PCIe extended capability header, as corrupting a heade=
r would
> > > > + * break the extended capability linked list.
> > > > + *
> > > > + * The caller must ensure that (offset, size) does not overlap wit=
h other
> > > > + * registers or capability-specific register blocks. Overlaps with
> > > > + * capability-specific registers are not checked and are considere=
d a
> > > > + * user-controlled override.
> > > > + */
> > > > +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8=
_t =20
> > > cap_ver, =20
> > > > +                            uint16_t offset, uint16_t size)
> > > > +{
> > > > +    uint16_t prev =3D 0, next =3D 0;
> > > > +    uint16_t cur =3D pci_get_word(dev->config + PCI_CONFIG_SPACE_S=
IZE);
> > > > +
> > > > +    /* Walk the ext cap list to find insertion point */
> > > > +    while (cur) {
> > > > +        uint32_t hdr =3D pci_get_long(dev->config + cur);
> > > > +        next =3D PCI_EXT_CAP_NEXT(hdr);
> > > > +
> > > > +        /* Check we are not overwriting any existing CAP header ar=
ea */
> > > > +        if (offset >=3D cur && offset < cur + PCI_EXT_CAP_ALIGN) {
> > > > +            return false;
> > > > +        }
> > > > +
> > > > +        prev =3D cur;
> > > > +        cur =3D next;
> > > > +        if (next =3D=3D 0 || next > offset) { =20
> > >=20
> > > So this (sort of) relies on a thing I've never been able to find a cl=
ear
> > > statement of in the PCIe spec.  Does Next Capability Offset have to be
> > > larger than the offset of the current record?  I.e. Can we have
> > > backwards pointers? =20
> >=20
> > That=E2=80=99s right. I also couldn=E2=80=99t find a place in the spec =
that explicitly
> > says the list must be forward only. A device doing a backward walk
> > would be pretty odd, hopefully nothing like that exists in the wild. =20
>=20
> Yes, there's no reason not to have such pointers, with either
> PCIe or classical PCI capability.

I think best we can do here is a comment saying this is 'best effort' attem=
pt
to place it based on many devices using increasing addresses. (I can't claim
to have seen any that don't, but I've only looked a few dozen of my career =
:)

Jonathan



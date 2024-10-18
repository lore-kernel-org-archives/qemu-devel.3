Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A2CD3001C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1phK-000892-8e; Fri, 18 Oct 2024 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t1phI-00088X-EK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:19:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t1phF-00059F-7Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:19:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVVHq2Cs8z67fBs;
 Sat, 19 Oct 2024 00:18:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B4695140680;
 Sat, 19 Oct 2024 00:19:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 18:19:14 +0200
Date: Fri, 18 Oct 2024 17:19:12 +0100
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, Ira Weiny <ira.weiny@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>
Subject: Re: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Message-ID: <20241018171912.00001e44@Huawei.com>
In-Reply-To: <29528327-90d0-5aa7-d756-0a88a396d6f6@amd.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
 <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
 <4085e18e-65bb-4b0e-bb72-f05e69996cbc@nvidia.com>
 <29528327-90d0-5aa7-d756-0a88a396d6f6@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 18 Oct 2024 16:25:58 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 10/18/24 15:49, Zhi Wang wrote:
> > On 17/10/2024 19.57, C=E9dric Le Goater wrote: =20
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> Hello,
> >>
> >> On 5/18/23 04:45, Ira Weiny wrote: =20
> >>> Type 2 devices are not yet a reality.=A0 Developing core kernel suppo=
rt
> >>> is difficult without some test device to model against.
> >>>
> >>> Define a type 2 device 'cxl-accel'.=A0 This device is derived from the
> >>> type 3 device and retains all that functionality for now.
> >>>
> >>> Mock up a couple of accelerator features (Back Invalidate [BI] and
> >>> Unordered IO [UIO]) as examples for the RFC.=A0 These have no
> >>> functionality other than to report the features as present for softwa=
re
> >>> to key off of.
> >>>
> >>> Defining these devices in qemu can be done with the following example:
> >>>
> >>> ...
> >>>  =A0=A0 -device
> >>> cxl-accel,bus=3Dsw0p0,volatile-memdev=3Dcxl-ac-mem5,id=3Dcxl-dev5,sn=
=3D0xCAFE0005
> >>> ...
> >>>
> >>> NOTE: I'm leaving off Michael Tsirkin for now because this is really
> >>> rough and I'm mainly sending it out because it was talked about in the
> >>> CXL community call on 5/16.
> >>>
> >>> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com> =20
> >>
> >> A recent proposal to add support in VFIO for CXL passthrough uses
> >> this emulated device and a sample driver for a proof of concept.
> >> For this effort, it would be very useful to have a QEMU model for
> >> a CXL type2 device, even partially implemented.
> >>
> >> I haven't found any updates of this series. What are the plans for
> >> upstream today ?
> >> =20
> > I was discussing this with Ira and Jonathan in the LPC and CXL discord
> > groups. (Irq and Jonathan, please feel free to correct me) I think we
> > all thought that having the emulated device support in QEMU and a sample
> > CXL type-2 driver in the upstream kernel could be valuable for
> >
> > 1) people who wish to contribute and propose changes, like refactor, and
> > code tweaks related to CXL type-2 support in the kernel. They can
> > validate their patches to check if they break something without a CXL
> > type-2 device.
> >
> > 2) people who wish to contribute on solving problems of CXL type-2
> > generic code, e.g. loading sequences of modules... They can get involved
> > without a real HW.
> >
> > My gut feeling is I can start to work with folks to get it into the
> > mainline together with the sample driver when CXL type-2 support is
> > merged. So people can play with it. =20
>=20
>=20
> I did use an emulated Type2 device for my initial development and I'm=20
> still using it for wider testing. It is basically same than the Type3=20
> with small changes. I think a proper solution should include command=20
> line options for configuring the device with flexibility or maybe=20
> referring to a file with that specific configuration. Note there exist=20
> optional functionalities like HDM decoder, and CXL.cache will need such=20
> a flexibility as well.

In the first instance, I'd just make up a single reasonable configuration.
Later, it may make sense to make it flexible.


>=20
> The RFC contains the driver for such emulated device implemented inside=20
> the tools/testing/cxl directory, although it has changed since then, but=
=20
> happy to share it. It is almost equal to the code inside efx_cxl.c along=
=20
> with the functions/macros for defining the driver.
>=20
> FWIW, although I'm working on Type2 support, I really think qemu could=20
> help for development and testing complex CXL infrastructures, more for=20
> memory expanders aka Type3 than Type2. I know this requires a good=20
> effort but IMO, it will pay off.

I'm definitely not against adding support and Zhi's rough sketch sounds
about right.

>=20
> > 3) people who would like to try on vfio-cxl.
> >
> > What would be nice to include in the patchset V1 in my mind:
> >
> > (Ira and Jonathan and folks please feel free to comment)
> >
> > Must have:
> >    - HDM decoder support (>1 HDM decoder). (which I have done it in my
> > tree, so the CXL core can create a CXL region)
> >
> > Nice to have:
> >    - CXLType2 device system reset handler. As what mentioned in my cover
> > letter, a system reset handler is required to reset the device state.
> > Linux kernel CXL core assumes the HW is pre-configured by FW if it sees
> > CXL.mem is enabled when enumerating the device. So I have to kill QEMU
> > instead of resetting the virtual machine when debugging.
> >
> >    - CXLType2 device in the patch should be derived from PCIDevice
> > (current it is derived from the CXLType3 device, which carries quite
> > some unnecessary stuff to present to the guest)
> >
> >    - Refactor of the current QEMU FWMS code to deliver the guest access
> > to the virtual memory backend to the correct emulated CXL device (which
> > is currently hardcoded to connect to cxl-type3 device in QEMU. Without
> > this, the access to the CXL region from the guest seems problematic but
> > creating CXL region is still fine.)
> >
> > Thanks,
> > Zhi.
> > =20
> >> For vfio-cxl, see :
> >>
> >> * [RFC] vfio: introduce vfio-cxl to support CXL type-2 accelerator
> >> passthrough
> >>   =A0 https://lore.kernel.org/kvm/20240920223446.1908673-1-zhiw@nvidia=
.com
> >> * [RFC] Introduce vfio-cxl to support CXL type-2 device passthrough
> >>   =A0 https://lore.kernel.org/all/20240921071440.1915876-1-zhiw@nvidia=
.com/
> >>
> >>
> >> Thanks,
> >>
> >> C.
> >>
> >>
> >> =20
> >>> ---
> >>> Ira Weiny (5):
> >>>  =A0=A0=A0=A0=A0=A0 hw/cxl: Use define for build bug detection
> >>>  =A0=A0=A0=A0=A0=A0 hw/cxl: Refactor component register initialization
> >>>  =A0=A0=A0=A0=A0=A0 hw/cxl: Derive a CXL accelerator device from Type=
-3
> >>>  =A0=A0=A0=A0=A0=A0 hw/cxl/accel: Add Back-Invalidate decoder capbili=
ty structure
> >>>  =A0=A0=A0=A0=A0=A0 hw/cxl: Add UIO HDM decoder register fields
> >>>
> >>>  =A0 docs/system/devices/cxl.rst=A0=A0=A0 | 11 ++++++
> >>>  =A0 hw/cxl/cxl-component-utils.c=A0=A0 | 80
> >>> +++++++++++++++++++-----------------------
> >>>  =A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 39 ++++=
++++++++++++++++
> >>>  =A0 include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
> >>>  =A0 include/hw/cxl/cxl_device.h=A0=A0=A0 | 16 +++++++++
> >>>  =A0 include/hw/pci/pci_ids.h=A0=A0=A0=A0=A0=A0 |=A0 1 +
> >>>  =A0 6 files changed, 141 insertions(+), 57 deletions(-)
> >>> ---
> >>> base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
> >>> change-id: 20230517-rfc-type2-dev-c2d661a29d96
> >>>
> >>> Best regards, =20



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F11D65C58
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 07:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBUir-0005Wc-LJ; Thu, 14 Nov 2024 02:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tBUio-0005T5-8I; Thu, 14 Nov 2024 02:56:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tBUim-0000gu-Aw; Thu, 14 Nov 2024 02:56:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xpspj1hL5z6J65C;
 Thu, 14 Nov 2024 15:53:33 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F923140257;
 Thu, 14 Nov 2024 15:56:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 08:56:44 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 14 Nov 2024 08:56:44 +0100
To: Nicolin Chen <nicolinc@nvidia.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rK0OI0AgAI473A=
Date: Thu, 14 Nov 2024 07:56:44 +0000
Message-ID: <13d6ed940bd44b3fa46aa9bc11f36bb5@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
In-Reply-To: <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.738, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, November 12, 2024 11:00 PM
> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; nathanc@nvidia.com
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> zhangfei.gao@linaro.org
> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
> nested SMMUv3
>=20
> On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum wrote:
> > Few ToDos to note,
> > 1. At present default-bus-bypass-iommu=3Don should be set when
> >    arm-smmuv3-nested dev is specified. Otherwise you may get an IORT
> >    related boot error.  Requires fixing.
> > 2. Hot adding a device is not working at the moment. Looks like pcihp i=
rq
> issue.
> >    Could be a bug in IORT id mappings.
>=20
> Do we have enough bus number space for each pbx bus in IORT?
>=20
> The bus range is defined by min_/max_bus in hort_host_bridges(),
> where the pci_bus_range() function call might not leave enough
> space in the range for hotplugs IIRC.

Ok. Thanks for the pointer. I will debug that.

> > ./qemu-system-aarch64 -machine virt,gic-version=3D3,default-bus-bypass-
> iommu=3Don \
> > -enable-kvm -cpu host -m 4G -smp cpus=3D8,maxcpus=3D8 \
> > -object iommufd,id=3Diommufd0 \
> > -bios QEMU_EFI.fd \
> > -kernel Image \
> > -device virtio-blk-device,drive=3Dfs \
> > -drive if=3Dnone,file=3Drootfs.qcow2,id=3Dfs \
> > -device pxb-pcie,id=3Dpcie.1,bus_nr=3D8,bus=3Dpcie.0 \
> > -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1,chassis=3D1 \
> > -device arm-smmuv3-nested,id=3Dsmmuv1,pci-bus=3Dpcie.1 \
> > -device vfio-pci,host=3D0000:7d:02.1,bus=3Dpcie.port1,iommufd=3Diommufd=
0 \
> > -device pxb-pcie,id=3Dpcie.2,bus_nr=3D16,bus=3Dpcie.0 \
> > -device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D2 \
> > -device arm-smmuv3-nested,id=3Dsmmuv2,pci-bus=3Dpcie.2 \
> > -device vfio-pci,host=3D0000:75:00.1,bus=3Dpcie.port2,iommufd=3Diommufd=
0 \
> > -append "rdinit=3Dinit console=3DttyAMA0 root=3D/dev/vda2 rw
> earlycon=3Dpl011,0x9000000" \
> > -device virtio-9p-pci,fsdev=3Dp9fs2,mount_tag=3Dp9,bus=3Dpcie.0 \
> > -fsdev local,id=3Dp9fs2,path=3Dp9root,security_model=3Dmapped \
> > -net none \
> > -nographic
> ..
> > With a pci topology like below,
> > [root@localhost ~]# lspci -tv
> > -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
> >  |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
> >  |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
> >  |           \-03.0  Virtio: Virtio filesystem
> >  +-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd. HNS
> Network Controller (Virtual Function)
> >  \-[0000:10]---00.0-[11]----00.0  Huawei Technologies Co., Ltd. HiSilic=
on ZIP
> Engine(Virtual Function)
> > [root@localhost ~]#
> >
> > And if you want to add another HNS VF, it should be added to the same
> SMMUv3
> > as of the first HNS dev,
> >
> > -device pcie-root-port,id=3Dpcie.port3,bus=3Dpcie.1,chassis=3D3 \
> > -device vfio-pci,host=3D0000:7d:02.2,bus=3Dpcie.port3,iommufd=3Diommufd=
0 \
> ..
> > At present Qemu is not doing any extra validation other than the above
> > failure to make sure the user configuration is correct or not. The
> > assumption is libvirt will take care of this.
>=20
> Nathan from NVIDIA side is working on the libvirt. And he already
> did some prototype coding in libvirt that could generate required
> PCI topology. I think he can take this patches for a combined test.

Cool. That's good to know.

Thanks,
SHameer


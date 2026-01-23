Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442B4D7236C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFY9-0004LF-Oy; Fri, 23 Jan 2026 06:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFY4-0004Jf-TV; Fri, 23 Jan 2026 06:41:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vjFY2-0006on-OY; Fri, 23 Jan 2026 06:41:56 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyGGf5T93zHnHMn;
 Fri, 23 Jan 2026 19:41:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 5633340571;
 Fri, 23 Jan 2026 19:41:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 11:41:51 +0000
Date: Fri, 23 Jan 2026 11:41:49 +0000
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Message-ID: <20260123114149.000065c5@huawei.com>
In-Reply-To: <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 23 Jan 2026 08:55:18 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Peter, Richard,
>=20
> On 1/21/26 6:52 PM, Shameer Kolothum wrote:
> > Hi,
> >
> > Changes since v7:
> >  https://lore.kernel.org/qemu-devel/20260111195508.106943-1-skolothumth=
o@nvidia.com/
> >  -Addressed comments and collected R-by and T-by tags. Thanks!.
> >  -Rebased to latest master.
> >  -Reworked PASID support patches (patch #34, #36).
> >
> > I think this series is in good shape now and mature enough for inclusio=
n.
> >
> > Patch organization:
> >
> > 1=E2=80=9328: Enable accelerated SMMUv3 with features aligned to the de=
fault QEMU
> > SMMUv3 implementation, including IORT RMR-based MSI support.
> >
> > 29=E2=80=9331: Add user-configurable options for RIL, ATS, and OAS feat=
ures.
> >
> > 32=E2=80=9337: Add PASID support, including required VFIO changes.
> >
> > Please take a look and let me know your feedback. =20
>=20
> This big series collected R-b's and T-bs for all patches I think. Please
> could you consider pulling it?

I definitely support getting this merged now.

I'm seeing an indent snafu in patch 18 though which either Shameer needs
to tidy up in a v9 or it needs a bit of hand tweaking by the person
queuing this up for a pull request.

Jonathan

>=20
> Thank you in advance
>=20
> Eric
> >
> > Thanks,
> > Shameer
> >
> > A complete branch can be found here,
> > https://github.com/shamiali2008/qemu-master/tree/master-smmuv3-accel-v8=
-dmabuf-v4
> >
> > Testing:
> >  Basic sanity testing was performed on an NVIDIA Grace platform with GPU
> >  device assignment. A CUDA test application was used to validate the SVA
> >  use case. Additional testing and feedback are welcome.
> >
> > Eg: Qemu Cmd line:
> >
> > qemu-system-aarch64 -machine virt,gic-version=3D3,highmem-mmio-size=3D2=
T \
> > -cpu host -smp cpus=3D4 -m size=3D16G,slots=3D2,maxmem=3D66G -nographic=
 \
> > -bios QEMU_EFI.fd -object iommufd,id=3Diommufd0 -enable-kvm \
> > -object memory-backend-ram,size=3D8G,id=3Dm0 \
> > -object memory-backend-ram,size=3D8G,id=3Dm1 \
> > -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 -numa node,memdev=3Dm1,nod=
eid=3D1 \
> > -numa node,nodeid=3D2 -numa node,nodeid=3D3 -numa node,nodeid=3D4 -numa=
 node,nodeid=3D5 \
> > -numa node,nodeid=3D6 -numa node,nodeid=3D7 -numa node,nodeid=3D8 -numa=
 node,nodeid=3D9 \
> > -device pxb-pcie,id=3Dpcie.1,bus_nr=3D1,bus=3Dpcie.0 \
> > -device arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.0,accel=3Don,ats=3D=
on,ril=3Doff,ssidsize=3D20,oas=3D48 \
> > -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1,chassis=3D1,pref64-=
reserve=3D512G,id=3Ddev0 \
> > -device vfio-pci,host=3D0019:06:00.0,rombar=3D0,id=3Ddev0,iommufd=3Diom=
mufd0,bus=3Dpcie.port1,x-vpasid-cap-offset=3D0xff8 \
> > -object acpi-generic-initiator,id=3Dgi0,pci-dev=3Ddev0,node=3D2 \
> > ...
> > -object acpi-generic-initiator,id=3Dgi7,pci-dev=3Ddev0,node=3D9 \
> > -device pxb-pcie,id=3Dpcie.2,bus_nr=3D8,bus=3Dpcie.0 \
> > -device arm-smmuv3,primary-bus=3Dpcie.2,id=3Dsmmuv3.1,accel=3Don,ats=3D=
on,ril=3Doff,ssidsize=3D20,oas=3D48 \
> > -device pcie-root-port,id=3Dpcie.port2,bus=3Dpcie.2,chassis=3D2,pref64-=
reserve=3D512G \
> > -device vfio-pci,host=3D0018:06:00.0,rombar=3D0,id=3Ddev1,iommufd=3Diom=
mufd0,bus=3Dpcie.port2,x-vpasid-cap-offset=3D0xff8 \
> > -device virtio-blk-device,drive=3Dfs \
> > -drive file=3Dimage.qcow2,index=3D0,media=3Ddisk,format=3Dqcow2,if=3Dno=
ne,id=3Dfs \
> > -net none \
> > -nographic
> >
> > Details from RFCv3 Cover letter:
> > -------------------------------
> > https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.ko=
lothum.thodi@huawei.com/
> >
> > This patch series introduces initial support for a user-creatable,
> > accelerated SMMUv3 device (-device arm-smmuv3,accel=3Don) in QEMU.
> >
> > This is based on the user-creatable SMMUv3 device series [0].
> >
> > Why this is needed:
> >
> > On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
> > must be set up in nested translation mode (Stage 1 + Stage 2), with
> > Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the ho=
st.
> >
> > This series introduces an optional accel property for the SMMUv3 device,
> > indicating that the guest will try to leverage host SMMUv3 features for
> > acceleration. By default, enabling accel configures the host SMMUv3 in
> > nested mode to support vfio-pci pass-through.
> >
> > This new accelerated, user-creatable SMMUv3 device lets you:
> >
> >  -Set up a VM with multiple SMMUv3s, each tied to a different physical =
SMMUv3
> >   on the host. Typically, you=E2=80=99d have multiple PCIe PXB root com=
plexes in the
> >   VM (one per virtual NUMA node), and each of them can have its own SMM=
Uv3.
> >   This setup mirrors the host's layout, where each NUMA node has its own
> >   SMMUv3, and helps build VMs that are more aligned with the host's NUMA
> >   topology.
> >
> >  -The host=E2=80=93guest SMMUv3 association results in reduced invalida=
tion broadcasts
> >   and lookups for devices behind different physical SMMUv3s.
> >
> >  -Simplifies handling of host SMMUv3s with differing feature sets.
> >
> >  -Lays the groundwork for additional capabilities like vCMDQ support.
> > -------------------------------
> >
> > Eric Auger (2):
> >   hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
> >   hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
> >     binding
> >
> > Nicolin Chen (4):
> >   backends/iommufd: Introduce iommufd_backend_alloc_viommu
> >   backends/iommufd: Introduce iommufd_backend_alloc_vdev
> >   hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
> >   hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support
> >
> > Shameer Kolothum (31):
> >   hw/arm/smmu-common: Factor out common helper functions and export
> >   hw/arm/smmu-common: Make iommu ops part of SMMUState
> >   hw/arm/smmuv3-accel: Introduce smmuv3 accel device
> >   hw/arm/smmuv3-accel: Initialize shared system address space
> >   hw/pci/pci: Move pci_init_bus_master() after adding device to bus
> >   hw/pci/pci: Add optional supports_address_space() callback
> >   hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
> >   hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
> >     with iommufd
> >   hw/arm/smmuv3: Implement get_viommu_cap() callback
> >   hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
> >   hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
> >   hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA
> >     directly
> >   hw/arm/smmuv3-accel: Implement get_msi_direct_gpa callback
> >   hw/arm/virt: Set msi-gpa property
> >   hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
> >   hw/arm/smmuv3: Initialize ID registers early during realize()
> >   hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
> >   hw/arm/virt: Set PCI preserve_config for accel SMMUv3
> >   tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
> >   tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
> >   hw/arm/smmuv3: Block migration when accel is enabled
> >   hw/arm/smmuv3: Add accel property for SMMUv3 device
> >   hw/arm/smmuv3-accel: Add a property to specify RIL support
> >   hw/arm/smmuv3-accel: Add support for ATS
> >   hw/arm/smmuv3-accel: Add property to specify OAS bits
> >   backends/iommufd: Retrieve PASID width from
> >     iommufd_backend_get_device_info()
> >   backends/iommufd: Add get_pasid_info() callback
> >   hw/pci: Add helper to insert PCIe extended capability at a fixed
> >     offset
> >   hw/pci: Factor out common PASID capability initialization
> >   hw/vfio/pci: Synthesize PASID capability for vfio-pci devices
> >   hw/arm/smmuv3-accel: Make SubstreamID support configurable
> >
> >  backends/iommufd.c                            |  76 +-
> >  backends/trace-events                         |   2 +
> >  hw/arm/Kconfig                                |   5 +
> >  hw/arm/meson.build                            |   3 +-
> >  hw/arm/smmu-common.c                          |  51 +-
> >  hw/arm/smmuv3-accel.c                         | 768 ++++++++++++++++++
> >  hw/arm/smmuv3-accel.h                         |  88 ++
> >  hw/arm/smmuv3-internal.h                      |   1 +
> >  hw/arm/smmuv3.c                               | 227 +++++-
> >  hw/arm/trace-events                           |   6 +
> >  hw/arm/virt-acpi-build.c                      | 127 ++-
> >  hw/arm/virt.c                                 |  39 +-
> >  hw/pci-bridge/pci_expander_bridge.c           |   1 -
> >  hw/pci-host/gpex-acpi.c                       |  29 +-
> >  hw/pci/pci.c                                  |  43 +-
> >  hw/pci/pcie.c                                 |  88 +-
> >  hw/vfio/iommufd.c                             |   6 +-
> >  hw/vfio/pci.c                                 |  75 ++
> >  hw/vfio/pci.h                                 |   1 +
> >  hw/vfio/trace-events                          |   1 +
> >  include/hw/arm/smmu-common.h                  |   7 +
> >  include/hw/arm/smmuv3-common.h                |  27 +-
> >  include/hw/arm/smmuv3.h                       |  10 +
> >  include/hw/arm/virt.h                         |   1 +
> >  include/hw/core/iommu.h                       |   1 +
> >  include/hw/pci-host/gpex.h                    |   1 +
> >  include/hw/pci/pci.h                          |  36 +
> >  include/hw/pci/pci_bridge.h                   |   1 +
> >  include/hw/pci/pcie.h                         |   4 +
> >  include/system/host_iommu_device.h            |  20 +
> >  include/system/iommufd.h                      |  29 +-
> >  target/arm/kvm.c                              |  18 +-
> >  tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
> >  tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
> >  .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
> >  36 files changed, 1692 insertions(+), 100 deletions(-)
> >  create mode 100644 hw/arm/smmuv3-accel.c
> >  create mode 100644 hw/arm/smmuv3-accel.h
> > =20
>=20
>=20



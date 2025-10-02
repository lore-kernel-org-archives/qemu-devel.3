Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07471CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 10:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4G5K-0003vH-KC; Thu, 02 Oct 2025 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v4G5H-0003uL-VL; Thu, 02 Oct 2025 05:58:48 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v4G58-0003yn-4w; Thu, 02 Oct 2025 05:58:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccnHb4WmSz6L4th;
 Thu,  2 Oct 2025 17:56:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 40ED61402FF;
 Thu,  2 Oct 2025 17:58:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 10:58:26 +0100
Date: Thu, 2 Oct 2025 10:58:24 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "Nathan
 Chen" <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
Message-ID: <20251002105824.00005ddd@huawei.com>
In-Reply-To: <CH3PR12MB75485C98CAB78552EC4C1597ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-27-skolothumtho@nvidia.com>
 <20251001145822.00002f7c@huawei.com>
 <CH3PR12MB75485C98CAB78552EC4C1597ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2 Oct 2025 08:03:09 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Sent: 01 October 2025 14:58
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> > berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> > shameerkolothum@gmail.com
> > Subject: Re: [PATCH v4 26/27] vfio: Synthesize vPASID capability to VM
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, 29 Sep 2025 14:36:42 +0100
> > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> >   
> > > From: Yi Liu <yi.l.liu@intel.com>
> > >
> > > If user wants to expose PASID capability in vIOMMU, then VFIO would also
> > > report the PASID cap for this device if the underlying hardware supports
> > > it as well.
> > >
> > > As a start, this chooses to put the vPASID cap in the last 8 bytes of the
> > > vconfig space. This is a choice in the good hope of no conflict with any
> > > existing cap or hidden registers. For the devices that has hidden registers,
> > > user should figure out a proper offset for the vPASID cap. This may require
> > > an option for user to config it. Here we leave it as a future extension.
> > > There are more discussions on the mechanism of finding the proper offset.
> > >
> > >  
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fkvm%2FBN9PR11MB5276318969A212AD0649C7BE8CBE2%4
> > 0BN9PR11MB5276.namprd11.prod.outlook.com%2F&data=05%7C02%7Csk
> > olothumtho%40nvidia.com%7Cfc027ec76e294ee3db4808de00f29861%7C4
> > 3083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63894923913220611
> > 4%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> > uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7
> > C%7C%7C&sdata=Qjerx3fDhLranvJPSoif4z0ue%2FcVgFYvFjroPgCjOQQ%3D&
> > reserved=0  
> > >
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > > ---
> > >  hw/vfio/pci.c      | 31 +++++++++++++++++++++++++++++++
> > >  include/hw/iommu.h |  1 +
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 5b022da19e..f54ebd0111 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -24,6 +24,7 @@
> > >  #include <sys/ioctl.h>
> > >
> > >  #include "hw/hw.h"
> > > +#include "hw/iommu.h"
> > >  #include "hw/pci/msi.h"
> > >  #include "hw/pci/msix.h"
> > >  #include "hw/pci/pci_bridge.h"
> > > @@ -2500,7 +2501,12 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice  
> > *vdev, uint16_t pos)  
> > >
> > >  static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> > >  {
> > > +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> > > +    HostIOMMUDeviceClass *hiodc =  
> > HOST_IOMMU_DEVICE_GET_CLASS(hiod);  
> > >      PCIDevice *pdev = PCI_DEVICE(vdev);
> > > +    uint8_t max_pasid_log2 = 0;
> > > +    bool pasid_cap_added = false;
> > > +    uint64_t hw_caps;
> > >      uint32_t header;
> > >      uint16_t cap_id, next, size;
> > >      uint8_t cap_ver;
> > > @@ -2578,12 +2584,37 @@ static void vfio_add_ext_cap(VFIOPCIDevice  
> > *vdev)  
> > >                  pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> > >              }
> > >              break;
> > > +        case PCI_EXT_CAP_ID_PASID:
> > > +             pasid_cap_added = true;
> > > +             /* fallthrough */
> > >          default:
> > >              pcie_add_capability(pdev, cap_id, cap_ver, next, size);
> > >          }
> > >
> > >      }
> > >
> > > +    /*
> > > +     * If PCI_EXT_CAP_ID_PASID not present, try to get information from the  
> > host
> > 
> > Say why it might or might not be present...
> >   
> > > +     */
> > > +    if (!pasid_cap_added && hiodc->get_pasid) {
> > > +        max_pasid_log2 = hiodc->get_pasid(hiod, &hw_caps);
> > > +    }
> > > +
> > > +    /*
> > > +     * If supported, adds the PASID capability in the end of the PCIE config
> > > +     * space. TODO: Add option for enabling pasid at a safe offset.  
> > 
> > What are you thinking needs doing to make it safe?  If it's at the end and there
> > is space isn't that enough?  
> 
> That is based on this discussion thread (mentioned in commit log as well)
> https://lore.kernel.org/kvm/BN9PR11MB5276318969A212AD0649C7BE8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
> 
> " - Some devices are known to place registers in configuration space,
>    outside of the capability chains, which historically makes it
>    difficult to place a purely virtual capability without potentially
>    masking such hidden registers."

Yuk. I know this is sometimes done to chicken bit certain capabilities.  Some of the
CXL ones only surface in root ports (on one platform anyway) if the link is trained up
as CXL. The registers are there anyway, just the chain pointers that are edited.
Anything truely hidden that is need for operation and in my view they are on
their own!

> 
> However, in this series we're trying to limit the impact by only placing the PASID
> capability for devices that are behind the vIOMMU and where the user has explicitly
> enabled PASID support for vIOMMU.
Make sense.  So this TODO is more of a do it if anyone ever needs it.

Jonathan

> 
> Thanks,
> Shameer 
> 
> 
> >   
> > > +     */
> > > +    if (max_pasid_log2 && (pci_device_get_viommu_flags(pdev) &
> > > +                           VIOMMU_FLAG_PASID_SUPPORTED)) {
> > > +        bool exec_perm = (hw_caps & IOMMU_HW_CAP_PCI_PASID_EXEC) ?  
> > true : false;  
> > > +        bool priv_mod = (hw_caps & IOMMU_HW_CAP_PCI_PASID_PRIV) ?  
> > true : false;  
> > > +
> > > +        pcie_pasid_init(pdev, PCIE_CONFIG_SPACE_SIZE -  
> > PCI_EXT_CAP_PASID_SIZEOF,  
> > > +                        max_pasid_log2, exec_perm, priv_mod);
> > > +        /* PASID capability is fully emulated by QEMU */
> > > +        memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff, 8);
> > > +    }
> > > +
> > >      /* Cleanup chain head ID if necessary */
> > >      if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
> > >          pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);  
> 
> 



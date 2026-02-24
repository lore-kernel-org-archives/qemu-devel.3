Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B91F3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuusU-0003dN-9c; Tue, 24 Feb 2026 11:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuusO-00033G-4l; Tue, 24 Feb 2026 11:03:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuusH-0001pw-QL; Tue, 24 Feb 2026 11:03:07 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL2YR4jGXzJ46bH;
 Wed, 25 Feb 2026 00:02:35 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 728B340572;
 Wed, 25 Feb 2026 00:02:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 16:02:56 +0000
Date: Tue, 24 Feb 2026 16:02:55 +0000
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Message-ID: <20260224160255.000076e6@huawei.com>
In-Reply-To: <CH3PR12MB754814ECFD29951EFB571585AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260219090103.33697-1-skolothumtho@nvidia.com>
 <20260219090103.33697-4-skolothumtho@nvidia.com>
 <20260224142857.00005fb6@huawei.com>
 <CH3PR12MB75483EAD05125D5FD3998474AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260224150154.0000074f@huawei.com>
 <CH3PR12MB754814ECFD29951EFB571585AB74A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

On Tue, 24 Feb 2026 15:18:00 +0000
Shameer Kolothum Thodi <skolothumtho@nvidia.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Sent: 24 February 2026 15:02
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> > <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> > Krishnakant Jaju <kjaju@nvidia.com>
> > Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> > accelerated SMMUv3 devices
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, 24 Feb 2026 14:41:08 +0000
> > Shameer Kolothum Thodi <skolothumtho@nvidia.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > > Sent: 24 February 2026 14:29
> > > > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > > > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > > > eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> > > > <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > > > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > > > <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> > > > Krishnakant Jaju <kjaju@nvidia.com>
> > > > Subject: Re: [PATCH v7 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> > > > accelerated SMMUv3 devices
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Thu, 19 Feb 2026 09:01:01 +0000
> > > > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> > > >  
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > >
> > > > > When the guest enables the Event Queue and a vIOMMU is present,
> > > > > allocate a vEVENTQ object so that host-side events related to the
> > > > > vIOMMU can be received and propagated back to the guest.
> > > > >
> > > > > For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is
> > > > > created before the guest boots. In this case, the vEVENTQ is allocated
> > > > > when the guest writes to SMMU_CR0 and sets EVENTQEN = 1.
> > > > >
> > > > > If no cold-plugged device exists at boot (i.e. no vIOMMU initially),
> > > > > the vEVENTQ is allocated when a vIOMMU is created, i.e. during the
> > > > > first device hot-plug.  
> > > >
> > > > Why do it differently?  
> > >
> > > This is because a vEVENTQ must be associated with a vIOMMU, and
> > > iommufd_backend_alloc_veventq() requires a valid viommu_id.
> > >
> > > A vIOMMU is only created once at least one vfio-pci device is
> > > attached. If the VM boots without any cold-plugged devices, no
> > > vIOMMU exists at that point.
> > >
> > > In that case, the vIOMMU is created during the first device
> > > hot-plug, so we allocate the vEVENTQ at that time instead.
> > >
> > > So, the difference in behaviour simply follows when the vIOMMU
> > > becomes available.
> > >
> > > Hope that is clear now.  
> > Ok.  So maybe this is just a description thing that was confusing me.
> > The key to my mental model is that both conditions must be met. That
> > is SMMU_CR0 has EVENTQEN = 1 set and there is a VFIO device present.
> > They happen in different orders in the two cases?  
> 
> Yes.  And EVENTQEN is set by Guest ARM SMMUv3 driver probe time.
> 
> > 
> > What guarantees we don't get a hotplug event before the guest has
> > set EVENTQEN = 1?  
> 
>  vEVENTQ needs two things:
> 
> 1) The guest must set EVENTQEN=1.
> 2) A vIOMMU must already exist (which happens when a VFIO device is attached).
> 
> EVENTQEN=1 is set by the guest when the SMMUv3 driver probes.
> 
> These two things can happen in either order.
> 
> In the cold-plug case, the vIOMMU already exists before the guest driver
> probes. So when the guest sets EVENTQEN=1 during driver probe, we
> allocate the vEVENTQ at that time.
> 
> In the hot-plug-first case, the first VFIO hotplug creates the vIOMMU,
> possibly before the guest has loaded the SMMUv3 driver. In that case,
> we wait until the guest sets EVENTQEN=1 during driver probe, and then
> allocate the vEVENTQ.
> 
> So we do not depend on ordering. We just check that both conditions
> are true, and allocate when the second one becomes true.

Perfect.  That explanation works for me. If you respin maybe start
the explanation with the full conditions that must be met, then break
down why they occur in different orders in the cold and hotplug
(after we reach a particular point in guest boot) cases.

Jonathan

> 
> Thanks,
> Shameer
> 



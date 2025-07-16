Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC27C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyWh-0005qb-Bm; Wed, 16 Jul 2025 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubyWe-0005l0-Gb; Wed, 16 Jul 2025 05:34:08 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubyWc-0000zd-Ab; Wed, 16 Jul 2025 05:34:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhrSK5kH3z6M4g1;
 Wed, 16 Jul 2025 17:32:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0143714044F;
 Wed, 16 Jul 2025 17:33:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 11:33:48 +0200
Date: Wed, 16 Jul 2025 10:33:46 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <20250716103346.00005ca4@huawei.com>
In-Reply-To: <aHaJYfitACLvupZV@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
 <20250715112941.00005348@huawei.com>
 <aHaJYfitACLvupZV@Asurada-Nvidia>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 15 Jul 2025 10:01:21 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Tue, Jul 15, 2025 at 11:29:41AM +0100, Jonathan Cameron wrote:
> > > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > > +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> > > +                                      s2_hwpt_id, &viommu_id, errp)) {
> > > +        return false;
> > > +    }  
> 
> [...]
> 
> > > +free_abort_hwpt:
> > > +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> > > +free_viommu:
> > > +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> > > +    g_free(viommu);  
> > 
> > No unwinding of iommufd_backened_alloc_viommu?
> > Looks like we just leak it until destruction of the fd. 
> > 
> > Maybe add a comment for those like me who aren't all that familiar with
> > this stuff and see an alloc with no matching free.  
> 
> Those iommufd_backend_free_id calls are the reverts. An iommufd
> object is free-ed using its object id, i.e. the "viommu_id" and
> "abort_hwpt_id" in the lines.

Ah.  I confused IDs and thought this was unwinding the two
iommufd_backend_alloc_hwpt() calls but of course the second one doesn't
need unwinding in the error path as it is the last call so if it fails
nothing to unwind.

So feel free to ignore this comment. 

> 
> Adding comments to every single iommufd_backened_free_id() call
> isn't optimal, IMHO, as that function would be invoked across
> different vIOMMU files and even the vfio/iommufd core files.
> 
> Perhaps QEMU should wrap it up with a helper, E.g.
> 
> static inline void iommufd_backend_free(int iommufd, int obj_id)
> {
> 	iommufd_backend_free_id(iommufd, obj_id);
> }
> 
> if it helps readability?

That would then leave us with iommufd_backend_alloc_hwpt() being
unwound by a direct iommufd_backend_free_id() which is equally
odd - so let's just keep them all being odd.

Jonathan

> 
> Nicolin



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C5CD29DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxyy-0003xj-1M; Wed, 14 Jan 2026 05:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfxyo-0003oW-0h; Wed, 14 Jan 2026 05:19:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfxyl-0002dc-Lq; Wed, 14 Jan 2026 05:19:57 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drhtW2QNMzHnH50;
 Wed, 14 Jan 2026 18:19:31 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 1538A40539;
 Wed, 14 Jan 2026 18:19:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 10:19:50 +0000
Date: Wed, 14 Jan 2026 10:19:49 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <alex@shazbot.org>, <clg@redhat.com>, <cohuck@redhat.com>, <mst@redhat.com>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jgg@nvidia.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v2 3/4] hw/vfio: Add helper to retrieve device feature
Message-ID: <20260114101949.0000669d@huawei.com>
In-Reply-To: <20260113113754.1189-4-skolothumtho@nvidia.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-4-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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

On Tue, 13 Jan 2026 11:37:53 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Add vfio_device_get_feature() as a common helper to retrieve
> VFIO device features.
> 
> No functional change intended.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Hi Shameer,

Happy new year.

Trivial thing noticed whilst glancing at this.

> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 100532f35d..0d9f42a1f0 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -516,6 +516,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>      vbasedev->bcontainer = NULL;
>  }
>  
> +

Stray change.

>  bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>  {
>      VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> @@ -527,6 +528,15 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>      return false;
>  }



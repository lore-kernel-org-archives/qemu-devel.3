Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5727EC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtWS-0007Ti-LS; Wed, 06 Mar 2024 10:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhtWQ-0007TL-KW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:49:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhtWN-0005uF-Vk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:49:34 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqcG30SqFz6K7MC;
 Wed,  6 Mar 2024 23:45:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D6C7140CB9;
 Wed,  6 Mar 2024 23:49:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:48:54 +0000
Date: Wed, 6 Mar 2024 15:48:53 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 04/13] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <20240306154853.00004c11@Huawei.com>
In-Reply-To: <20240304194331.1586191-5-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-5-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon,  4 Mar 2024 11:33:59 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, when setting up memory for type3 memory device, we can
> create DC regions.
> A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> number of DC regions to create. To make it easier, other region parameters
> like region base, length, and block size are hard coded. If needed,
> these parameters can be added easily.
> 
> With the change, we can create DC regions with proper kernel side
> support like below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Suggested changes are trivial formatting things
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/mem/cxl_type3.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 244d2b5fd5..a191211009 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/msix.h"
>  
>  #define DWORD_BYTE 4
> +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -567,6 +568,45 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      }
>  }
>  
> +/*
> + * TODO: dc region configuration will be updated once host backend and address
> + * space support is added for DCD.
> + */
> +static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> +{
> +    int i;
> +    uint64_t region_base = 0;
> +    uint64_t region_len =  2 * GiB;
> +    uint64_t decode_len = 2 * GiB;
> +    uint64_t blk_size = 2 * MiB;
> +    CXLDCRegion *region;
> +    MemoryRegion *mr;
> +
> +    if (ct3d->hostvmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        region_base += memory_region_size(mr);
> +    }
> +    if (ct3d->hostpmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        region_base += memory_region_size(mr);
> +    }
> +    assert(region_base % CXL_CAPACITY_MULTIPLIER == 0);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        region->base = region_base;
> +        region->decode_len = decode_len;
> +        region->len = region_len;
> +        region->block_size = blk_size;
> +        /* dsmad_handle is set when creating cdat table entries */
> +        region->flags = 0;
> +
> +        region_base += region->len;

Maybe make the loop update to do some or all of the variable updating
(perhaps all of them is a bit too complex!)

    for (i = 0, region = &ct3d->dc_regions[0];
         i < ct3d->dc.num_regions;
         i++, region++, region_base += region_len) {
Also, using this style of assignment will avoid lots of repetition of region.
        *region = (CXLDCRegion) {
            .base = region_base,
            .decode_len = decode_len,
            .len = region_len,
            .block_size = blk_size,
            /* dsmad_handle set when creating CDAT table entries */
            .flags = 0,
        };
    }

> +    }
> +
> +    return true;
> +}




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE164D29FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzKr-0007qm-9u; Wed, 14 Jan 2026 06:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfzKP-0007i0-8Q; Wed, 14 Jan 2026 06:46:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfzKK-0001JP-F9; Wed, 14 Jan 2026 06:46:19 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drknv2ythzHnHBm;
 Wed, 14 Jan 2026 19:45:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 426BC40570;
 Wed, 14 Jan 2026 19:45:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 11:45:58 +0000
Date: Wed, 14 Jan 2026 11:45:56 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <clg@redhat.com>,
 <alex@shazbot.org>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Message-ID: <20260114114556.0000153c@huawei.com>
In-Reply-To: <20260111195508.106943-34-skolothumtho@nvidia.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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

On Sun, 11 Jan 2026 19:53:19 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Add pcie_insert_capability(), a helper to insert a PCIe extended
> capability into an existing extended capability list at a
> caller-specified offset.
> 
> Unlike pcie_add_capability(), which always appends a capability to the
> end of the list, this helper preserves the existing list ordering while
> allowing insertion at an arbitrary offset.
> 
> The helper only validates that the insertion does not overwrite an
> existing PCIe extended capability header, since corrupting a header
> would break the extended capability linked list. Validation of overlaps
> with other configuration space registers or capability-specific
> register blocks is left to the caller.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Hi Shameer.

Random musings inline... Maybe I'm just failing in my spec grep skills.

> ---
>  hw/pci/pcie.c         | 58 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h |  2 ++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b302de6419..8568a062a5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1050,6 +1050,64 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>      pci_set_long(dev->config + pos, header);
>  }
>  
> +/*
> + * Insert a PCIe extended capability at a given offset.
> + *
> + * This helper only validates that the insertion does not overwrite an
> + * existing PCIe extended capability header, as corrupting a header would
> + * break the extended capability linked list.
> + *
> + * The caller must ensure that (offset, size) does not overlap with other
> + * registers or capability-specific register blocks. Overlaps with
> + * capability-specific registers are not checked and are considered a
> + * user-controlled override.
> + */
> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
> +                            uint16_t offset, uint16_t size)
> +{
> +    uint16_t prev = 0, next = 0;
> +    uint16_t cur = pci_get_word(dev->config + PCI_CONFIG_SPACE_SIZE);
> +
> +    /* Walk the ext cap list to find insertion point */
> +    while (cur) {
> +        uint32_t hdr = pci_get_long(dev->config + cur);
> +        next = PCI_EXT_CAP_NEXT(hdr);
> +
> +        /* Check we are not overwriting any existing CAP header area */
> +        if (offset >= cur && offset < cur + PCI_EXT_CAP_ALIGN) {
> +            return false;
> +        }
> +
> +        prev = cur;
> +        cur = next;
> +        if (next == 0 || next > offset) {

So this (sort of) relies on a thing I've never been able to find a clear
statement of in the PCIe spec.  Does Next Capability Offset have to be
larger than the offset of the current record?  I.e. Can we have
backwards pointers?

Meh, I think this is fine, it just came up before and I couldn't find
a reference to prove it!

More importantly, if it isn't a requirement and a rare device turns up
that has a backwards pointer, that just means there isn't a 'right'
point in the list to put this at, so any random choice is fine and
the next == 0 condition means we always fine an option.


> +            break;
> +        }
> +    }
> +
> +   /* Make sure, next CAP header area is not over written either */

Looks like one space too few.

> +    if (next && (offset + size) >= next) {
> +        return false;
> +    }
> +
> +    /* Insert new cap */
> +    pci_set_long(dev->config + offset,
> +                 PCI_EXT_CAP(cap_id, cap_ver, cur));
> +    if (prev) {
> +        pcie_ext_cap_set_next(dev, prev, offset);
> +    } else {
> +        /* Insert at head (0x100) */

Comment is a little confusing as you aren't inserting the new capability
there.  What I think this is actually doing is

/*
 * Insert a Null Extended Capability (7.9.28 in the PCI 6.2 spec)
 * at head when there are no extended capabilities and use that to
 * point to the inserted capability at offset.
 */

> +        pci_set_word(dev->config + PCI_CONFIG_SPACE_SIZE, offset);
> +    }
> +
> +    /* Make capability read-only by default */
> +    memset(dev->wmask + offset, 0, size);
> +    memset(dev->w1cmask + offset, 0, size);
> +    /* Check capability by default */
> +    memset(dev->cmask + offset, 0xFF, size);
> +    return true;
> +}




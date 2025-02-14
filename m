Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C698C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwrh-0006EK-CJ; Fri, 14 Feb 2025 09:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiwrY-0006AX-Ns
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:40:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiwrT-0001IV-Rj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:40:14 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvZQW2KVFz6L6ww;
 Fri, 14 Feb 2025 22:37:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A4897140B63;
 Fri, 14 Feb 2025 22:40:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 15:40:07 +0100
Date: Fri, 14 Feb 2025 14:40:05 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2 3/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250214144005.000018d2@huawei.com>
In-Reply-To: <20250213091558.2294806-4-vinayak.kh@samsung.com>
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
 <CGME20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2@epcas5p2.samsung.com>
 <20250213091558.2294806-4-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 13 Feb 2025 14:45:58 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
As in previous - please update to the r3.2 spec.

A few comments inline.

Thanks,

Jonathan

> CXL devices supports media operations Sanitize and Write zero command.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |   4 +
>  2 files changed, 216 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d58c20842f..2d8d1171b4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1732,6 +1732,130 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>  }
>  
>  #define CXL_CACHELINE_SIZE 64
> +struct CXLSanitizeInfo {
> +    uint32_t dpa_range_count;
> +    uint8_t fill_value;
> +    struct {
> +            uint64_t starting_dpa;
> +            uint64_t length;
> +    } dpa_range_list[];
> +};
> +
> +struct dpa_range_list_entry {
> +    uint64_t starting_dpa;
> +    uint64_t length;
> +};

Declare it above and use in CXLSanitizeInfo

> +
> +static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
> +{
> +    uint64_t vmr_size = 0;
> +    if (ct3d->hostvmem) {
> +        *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(*vmr);
> +    }
> +    return vmr_size;
> +}
> +

I would write as

static uint64_t get_pmr_size(CXLTYpe3Dev *ct3d, MemoryRegion **pmr)
{
    MemoryRegion *mr;
    if (ct3d->hostpmem) {
        mr = host_memory_region_backend_get_memory(ct3d->hostpmem);
        if (pmr) {
            *pmr = mr;
        }
	return memory_region_size(mr);
    }
    return 0;
}

Making the pmr argument optional for when you don't need it.

> +static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
> +{
> +    uint64_t pmr_size = 0;
> +    if (ct3d->hostpmem) {
> +        *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(*pmr);
> +    }
> +    return pmr_size;
> +}
> +
> +static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
> +{
> +    uint64_t dc_size = 0;
> +    if (ct3d->dc.host_dc) {
> +        *dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        dc_size = memory_region_size(*dc_mr);
> +    }
> +    return dc_size;
> +}
> +
> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> +                             size_t length)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;

overwritten in all paths were we use them. So don't assign initial values.

> +
> +    if ((dpa_addr % CXL_CACHELINE_SIZE) ||
> +         (length % CXL_CACHELINE_SIZE)  ||
> +         (length <= 0)) {
Align as
    if ((dpa_addr % CXL_CACHELINE_SIZE) ||
        (length % CXL_CACHELINE_SIZE) ||
        (length <= 0)) {

> +        return -EINVAL;
> +    }
> +
> +    vmr_size = get_vmr_size(ct3d, &vmr);
> +    pmr_size = get_pmr_size(ct3d, &pmr);
> +    dc_size = get_dc_size(ct3d, &dc_mr);
> +
> +    if (!vmr && !pmr && !dc_mr) {

That's a bit late given you used them to get the sizes.
Do this before filling sizes.

> +        return -ENODEV;
> +    }
> +
> +    if ((dpa_addr + length) > vmr_size + pmr_size + dc_size) {
Skip inner brackets.

> +        return -EINVAL;
> +    }
> +
> +    if (dpa_addr > vmr_size + pmr_size) {
> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> +            return -ENODEV;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
> +                          uint8_t fill_value)
> +{
> +
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0;
> +    AddressSpace *as = NULL;
> +    MemTxAttrs mem_attrs = {0};
> +
> +    vmr_size = get_vmr_size(ct3d, &vmr);
> +    pmr_size = get_pmr_size(ct3d, &pmr);
> +
> +    if (dpa_addr < vmr_size) {
> +        as = &ct3d->hostvmem_as;
> +    } else if (dpa_addr < vmr_size + pmr_size) {
> +        as = &ct3d->hostpmem_as;
> +    } else {
> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> +            return -ENODEV;
> +        }
> +        as = &ct3d->dc.host_dc_as;
> +    }
> +
> +    return address_space_set(as, dpa_addr,
> +                              fill_value, length, mem_attrs);

Odd wrap.  Put as much as fits on line under 80 chars on first line
then align next line to just after (

> +}
> +
> +/* Perform the actual device zeroing */
> +static void __do_sanitize(CXLType3Dev *ct3d)
> +{
> +    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
> +    int dpa_range_count = san_info->dpa_range_count;
> +    int rc = 0;
> +
> +    for (int i = 0; i < dpa_range_count; i++) {

Declare i outside loop (match local style).

> +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
> +                san_info->dpa_range_list[i].length, san_info->fill_value);

Either align 4 spaces after start of line above, or immediately after (

> +        if (rc) {
> +            goto exit;
> +        }
> +    }
> +exit:
> +    g_free(ct3d->media_op_sanitize);
> +    ct3d->media_op_sanitize = NULL;
> +    return;
> +}
> +
>  enum {
>      MEDIA_OP_CLASS_GENERAL  = 0x0,
>          #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
> @@ -1760,9 +1884,9 @@ static const struct media_op_supported_list_entry media_op_matrix[] = {
>  };
>  
>  static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> -                                                size_t len_in,
> -                                                uint8_t *payload_out,
> -                                                size_t *len_out)
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out)

Ah. Drag this to earlier patch.

>  {
>      struct {
>          uint8_t media_operation_class;
> @@ -1811,6 +1935,66 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            uint8_t fill_value,
> +                                            CXLCCI *cci)
> +{
> +    struct media_operations_sanitize {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +        struct {
> +            uint64_t starting_dpa;
> +            uint64_t length;
> +        } dpa_range_list[];
> +    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
> +    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
> +    uint64_t total_mem = 0;
> +    int secs = 0;
> +
> +    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
> +           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    for (int i = 0; i < dpa_range_count; i++) {

Declare outside of there (to match local style)

> +        if (validate_dpa_addr(ct3d,
> +            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa,

Hmm. This is tricky to read because of alignment.  I'd have local
start_dpa nad length variables.

    for (i = 0; i < dpa_range_count; i++) {
        uint64_t start_dpa = media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;

	if (validate_dpa_addr(ct3d, dpa_start, length)) {

> +            media_op_in_sanitize_pl->dpa_range_list[i].length)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        total_mem += media_op_in_sanitize_pl->dpa_range_list[i].length;
> +    }
> +    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
> +                                  (dpa_range_count *
> +                                  sizeof(struct dpa_range_list_entry)));
> +
> +    if (ct3d->media_op_sanitize) {
> +        ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
> +        ct3d->media_op_sanitize->fill_value = fill_value;
> +        memcpy(ct3d->media_op_sanitize->dpa_range_list,
> +                  media_op_in_sanitize_pl->dpa_range_list,
> +                  (dpa_range_count *
> +                  sizeof(struct dpa_range_list_entry)));
> +        secs = get_sanitize_duration(total_mem >> 20);
> +    }
> +
> +    /* EBUSY other bg cmds as of now */
> +    cci->bg.runtime = secs * 1000UL;
> +    *len_out = 0;
> +    /*
> +     * media op sanitize is targeted so no need to disable media or
> +     * clear event logs
> +     */
> +    return CXL_MBOX_BG_STARTED;
> +

No blank line here.

> +}
> +
>  static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -1825,6 +2009,9 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>          uint32_t dpa_range_count;
>      } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
>  
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint8_t fill_value = 0;

Maybe just put this value in directly into where it is used?

> +
>      if (len_in < sizeof(*media_op_in_common_pl)) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
> @@ -1851,15 +2038,29 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>          return media_operations_discovery(payload_in, len_in, payload_out,
>                                               len_out);
>      case MEDIA_OP_CLASS_SANITIZE:
> +        if (dpa_range_count == 0) {
> +            return CXL_MBOX_SUCCESS;
> +        }
>          switch (media_op_subclass) {
> +        case MEDIA_OP_SAN_SUBC_SANITIZE:
> +            fill_value = 0xF;
> +            return media_operations_sanitize(ct3d, payload_in, len_in,
> +                                             payload_out, len_out, fill_value,
> +                                             cci);
> +            break;

Can reach this break so remove it.

> +        case MEDIA_OP_SAN_SUBC_ZERO:
> +            fill_value = 0;
> +            return media_operations_sanitize(ct3d, payload_in, len_in,
> +                                             payload_out, len_out, fill_value,
> +                                             cci);
> +            break;

Can't reach this break either.

>          default:
>              return CXL_MBOX_UNSUPPORTED;
>          }
> +        break;
>      default:
>          return CXL_MBOX_UNSUPPORTED;
>      }
> -
> -    return CXL_MBOX_SUCCESS;

This removal belongs in patch 1

>  }

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..b391a293a8 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -581,6 +581,8 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
>  
> +struct CXLSanitizeInfo;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -651,6 +653,8 @@ struct CXLType3Dev {
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>      } dc;
> +
> +    struct CXLSanitizeInfo  *media_op_sanitize;

Only one place before *

>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41994C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8C7-0001FT-Ta; Thu, 20 Feb 2025 10:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl8C6-0001Ex-Lu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:10:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl8C1-0006HG-7W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:10:30 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzGpF4MzTz6GDn7;
 Thu, 20 Feb 2025 23:07:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 57708140AE5;
 Thu, 20 Feb 2025 23:10:11 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 16:10:10 +0100
Date: Thu, 20 Feb 2025 15:10:09 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v3 3/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands cxl r3.2(8.2.10.9.5.3)
Message-ID: <20250220151009.000009e7@huawei.com>
In-Reply-To: <20250220052724.1256642-4-vinayak.kh@samsung.com>
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
 <CGME20250220052738epcas5p24b49106f81b1a621acffe6124eba9e52@epcas5p2.samsung.com>
 <20250220052724.1256642-4-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 20 Feb 2025 10:57:24 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> CXL devices supports media operations Sanitize and Write zero command.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>

Another one where I made some minor tweaks whilst applying. Let me know if I
messed up!  Comments on why folow.

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4aa695cfa9..a48a551bfc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1796,7 +1796,7 @@ static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,

     uint64_t vmr_size, pmr_size;
     AddressSpace *as = NULL;
-    MemTxAttrs mem_attrs = {0};
+    MemTxAttrs mem_attrs = {};

     vmr_size = get_vmr_size(ct3d, NULL);
     pmr_size = get_pmr_size(ct3d, NULL);
@@ -1820,7 +1820,8 @@ static void __do_sanitize(CXLType3Dev *ct3d)
 {
     struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
     int dpa_range_count = san_info->dpa_range_count;
-    int rc = 0, i;
+    int rc = 0;
+    int i;

     for (i = 0; i < dpa_range_count; i++) {
         rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
@@ -1933,21 +1934,19 @@ static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
         uint8_t media_operation_subclass;
         uint8_t rsvd[2];
         uint32_t dpa_range_count;
-        struct {
-            uint64_t starting_dpa;
-            uint64_t length;
-        } dpa_range_list[];
+        struct dpa_range_list_entry dpa_range_list[];
     } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
     uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
     uint64_t total_mem = 0;
+    size_t dpa_range_list_size;
     int secs = 0, i;

     if (dpa_range_count == 0) {
         return CXL_MBOX_SUCCESS;
     }

-    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
-           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
+    dpa_range_list_size = dpa_range_count * sizeof(struct dpa_range_list_entry);
+    if (len_in < (sizeof(*media_op_in_sanitize_pl) + dpa_range_list_size)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }

@@ -1955,24 +1954,21 @@ static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
         uint64_t start_dpa =
             media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
         uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
+
         if (validate_dpa_addr(ct3d, start_dpa, length)) {
             return CXL_MBOX_INVALID_INPUT;
         }
-        total_mem += media_op_in_sanitize_pl->dpa_range_list[i].length;
+        total_mem += length;
     }
     ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
-                                  (dpa_range_count *
-                                  sizeof(struct dpa_range_list_entry)));
-
-    if (ct3d->media_op_sanitize) {
-        ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
-        ct3d->media_op_sanitize->fill_value = fill_value;
-        memcpy(ct3d->media_op_sanitize->dpa_range_list,
-                  media_op_in_sanitize_pl->dpa_range_list,
-                  (dpa_range_count *
-                  sizeof(struct dpa_range_list_entry)));
-        secs = get_sanitize_duration(total_mem >> 20);
-    }
+                                        dpa_range_list_size);
+
+    ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
+    ct3d->media_op_sanitize->fill_value = fill_value;
+    memcpy(ct3d->media_op_sanitize->dpa_range_list,
+           media_op_in_sanitize_pl->dpa_range_list,
+           dpa_range_list_size);
+    secs = get_sanitize_duration(total_mem >> 20);

     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 210 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |   4 +
>  2 files changed, 213 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2428d85fef..7b4e4daeb2 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1731,6 +1731,130 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +struct dpa_range_list_entry {
> +    uint64_t starting_dpa;
> +    uint64_t length;
> +} QEMU_PACKED;
> +
> +struct CXLSanitizeInfo {
> +    uint32_t dpa_range_count;
> +    uint8_t fill_value;
> +    struct dpa_range_list_entry dpa_range_list[];
> +} QEMU_PACKED;
> +
> +static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
> +{
> +    MemoryRegion *mr;
> +    if (ct3d->hostvmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (vmr) {
> +            *vmr = mr;
> +        }
> +        return memory_region_size(mr);
> +    }
> +    return 0;
> +}
> +
> +static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
> +{
> +    MemoryRegion *mr;
> +    if (ct3d->hostpmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (pmr) {
> +            *pmr = mr;
> +        }
> +        return memory_region_size(mr);
> +    }
> +    return 0;
> +}
> +
> +static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
> +{
> +    MemoryRegion *mr;
> +    if (ct3d->dc.host_dc) {
> +        mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        if (dc_mr) {
> +            *dc_mr = mr;
> +        }
> +        return memory_region_size(mr);
> +    }
> +    return 0;
> +}
> +
> +static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
> +                             size_t length)
> +{
> +    uint64_t vmr_size, pmr_size, dc_size;
> +
> +    if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
> +        (length % CXL_CACHE_LINE_SIZE)  ||

extra spce before the ||

> +        (length <= 0)) {
> +        return -EINVAL;
> +    }
> +
> +    vmr_size = get_vmr_size(ct3d, NULL);
> +    pmr_size = get_pmr_size(ct3d, NULL);
> +    dc_size = get_dc_size(ct3d, NULL);
> +
> +    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
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
> +    uint64_t vmr_size, pmr_size;
> +    AddressSpace *as = NULL;
> +    MemTxAttrs mem_attrs = {0};

No need for the 0.  {} is same thing.

> +
> +    vmr_size = get_vmr_size(ct3d, NULL);
> +    pmr_size = get_pmr_size(ct3d, NULL);
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
> +    return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
> +}
> +
> +/* Perform the actual device zeroing */
> +static void __do_sanitize(CXLType3Dev *ct3d)
> +{
> +    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
> +    int dpa_range_count = san_info->dpa_range_count;
> +    int rc = 0, i;

I'll spit this.  Generally mixing assignment and non assignment declarations
can be a small readabilty issue.

> +
> +    for (i = 0; i < dpa_range_count; i++) {
> +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
> +                            san_info->dpa_range_list[i].length,
> +                            san_info->fill_value);
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
> @@ -1823,6 +1947,70 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
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

struct dpa_range_list_entry dpa_range_list[] which makes the 

> +    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
> +    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
> +    uint64_t total_mem = 0;
> +    int secs = 0, i;
As above.
> +
> +    if (dpa_range_count == 0) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
> +           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
Lots of use is made of this size of the dpa_range list.
Deserves a local variable.

> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    for (i = 0; i < dpa_range_count; i++) {
> +        uint64_t start_dpa =
> +            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
> +        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
> +        if (validate_dpa_addr(ct3d, start_dpa, length)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        total_mem += media_op_in_sanitize_pl->dpa_range_list[i].length;
totalmem += length.

> +    }
> +    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
> +                                  (dpa_range_count *
> +                                  sizeof(struct dpa_range_list_entry)));
> +
> +    if (ct3d->media_op_sanitize) {
This can't fail.  g_malloc0 failing kills qemu anyway (makes memory
handling simple ;)

> +        ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
> +        ct3d->media_op_sanitize->fill_value = fill_value;
> +        memcpy(ct3d->media_op_sanitize->dpa_range_list,
> +                  media_op_in_sanitize_pl->dpa_range_list,
Align after the (
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
> +}
> +
>  static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>                                         uint8_t *payload_in,
>                                         size_t len_in,
> @@ -1836,6 +2024,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>          uint8_t rsvd[2];
>          uint32_t dpa_range_count;
>      } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      uint8_t media_op_cl = 0;
>      uint8_t media_op_subclass = 0;
>  
> @@ -1853,7 +2042,20 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
>          }
>  
>          return media_operations_discovery(payload_in, len_in, payload_out,
> -                                             len_out);
> +                                          len_out);
> +    case MEDIA_OP_CLASS_SANITIZE:
> +        switch (media_op_subclass) {
> +        case MEDIA_OP_SAN_SUBC_SANITIZE:
> +            return media_operations_sanitize(ct3d, payload_in, len_in,
> +                                             payload_out, len_out, 0xF,
> +                                             cci);
> +        case MEDIA_OP_SAN_SUBC_ZERO:
> +            return media_operations_sanitize(ct3d, payload_in, len_in,
> +                                             payload_out, len_out, 0,
> +                                             cci);
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
>      default:
>          return CXL_MBOX_UNSUPPORTED;
>      }
> @@ -3170,6 +3372,12 @@ static void bg_timercb(void *opaque)
>              cxl_dev_enable_media(&ct3d->cxl_dstate);
>          }
>          break;
> +        case 0x4402: /* Media Operations sanitize */
> +        {
> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +            __do_sanitize(ct3d);
> +        }
> +        break;
>          case 0x4304: /* scan media */
>          {
>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..3c5711249b 100644
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
> +    struct CXLSanitizeInfo *media_op_sanitize;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"



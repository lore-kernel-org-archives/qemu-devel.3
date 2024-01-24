Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96826C48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgSI-0006Uz-Of; Wed, 24 Jan 2024 11:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSgS8-0006Ud-4p
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:50:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rSgS3-00067s-8B
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:50:15 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKqcY2yFJz6K92W;
 Thu, 25 Jan 2024 00:47:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 480D2140A70;
 Thu, 25 Jan 2024 00:50:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 16:50:05 +0000
Date: Wed, 24 Jan 2024 16:50:04 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <20240124165004.00003228@Huawei.com>
In-Reply-To: <20231107180907.553451-9-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-9-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue,  7 Nov 2023 10:07:12 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Note: we block any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 0,
>           "len": 128
>       },
>       {
>           "dpa": 128,
>           "len": 128
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) look like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "region-id": 0,
>       "extents": [
>       {
>           "dpa": 128,
>           "len": 128
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
A few more comment and found some answers to previous comments. I should have
read the whole thing first :(

> ---
>  hw/cxl/cxl-mailbox-utils.c  |  25 +++-
>  hw/mem/cxl_type3.c          | 225 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  14 +++
>  include/hw/cxl/cxl_device.h |   8 +-
>  include/hw/cxl/cxl_events.h |  15 +++
>  qapi/cxl.json               |  60 +++++++++-
>  6 files changed, 338 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9f788b03b6..8e6a98753a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1362,7 +1362,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>   * Check whether any bit between addr[nr, nr+size) is set,
>   * return true if any bit is set, otherwise return false
>   */
> -static bool test_any_bits_set(const unsigned long *addr, int nr, int size)
> +bool test_any_bits_set(const unsigned long *addr, int nr, int size)
>  {
>      unsigned long res = find_next_bit(addr, size + nr, nr);
>  
> @@ -1400,7 +1400,7 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
>      return NULL;
>  }
>  
> -static void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> +void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
>                                               uint64_t dpa,
>                                               uint64_t len,
>                                               uint8_t *tag,
> @@ -1538,15 +1538,28 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>              }
>          }
>  
> -        /*
> -         * TODO: add a pending extent list based on event log record and
> -         * verify the input response
> -         */

Ahah. I should have read on :)  Ignore comments on previous agreeing
that such a list was needed.

> +        QTAILQ_FOREACH(ent, &ct3d->dc.extents_pending_to_add, node) {
> +            if (ent->start_dpa <= dpa &&
> +                dpa + len <= ent->start_dpa + ent->len) {
> +                break;
> +            }
> +        }
> +        if (ent) {
> +            QTAILQ_REMOVE(&ct3d->dc.extents_pending_to_add, ent, node);
> +            g_free(ent);
> +        } else {
> +            return CXL_MBOX_INVALID_PA;
> +        }
Flip to simplify logic

           if (!end) {
                return CXL_MBOX_INVALID_PA;
           }

	   QTAILQ...

>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
>      }
>  
> +    /*
> +     * TODO: extents_pending_to_add needs to be cleared so the extents not
> +     * accepted can be reclaimed base on spec r3.0: 8.2.9.8.9.3
> +     */
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 482329a499..43cea3d818 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -813,6 +813,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>          region_base += region->len;
>      }
>      QTAILQ_INIT(&ct3d->dc.extents);
> +    QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
>  
>      return 0;
>  }
> @@ -1616,7 +1617,8 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
>          return CXL_EVENT_TYPE_FAIL;
>      case CXL_EVENT_LOG_FATAL:
>          return CXL_EVENT_TYPE_FATAL;
> -/* DCD not yet supported */
> +    case CXL_EVENT_LOG_DYNCAP:
> +        return CXL_EVENT_TYPE_DYNAMIC_CAP;
>      default:
>          return -EINVAL;
>      }
> @@ -1867,6 +1869,227 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +/* CXL r3.0 Table 8-47: Dynanic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +    DC_EVENT_NUM
Don't thing EVENT_NUM is used. Don't define it unless it's useful.

> +} CXLDCEventType;
> +
> +/*
> + * Check whether the exact extent exists in the list
> + * Return value: true if exists, otherwise false
> + */
> +static bool cxl_dc_extent_exists(CXLDCDExtentList *list, CXLDCExtentRaw *ext)
> +{
> +    CXLDCDExtent *ent;
> +
> +    if (!ext || !list) {
> +        return false;
> +    }
> +
> +    QTAILQ_FOREACH(ent, list, node) {
> +        if (ent->start_dpa != ext->start_dpa) {
> +            continue;
> +        }
> +
> +        /*Found exact extent*/

	   return ent->len == ext->len;

> +        if (ent->len == ext->len) {
> +            return true;
> +        } else {
> +            return false;
> +        }
> +    }
> +    return false;
> +}
> +
> +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> +                                             CXLDCEventType type, uint16_t hid,
> +                                             uint8_t rid,
> +                                             CXLDCExtentRecordList *records,
> +                                             Error **errp)
> +{
> +    Object *obj;
> +    CXLEventDynamicCapacity dCap = {};
> +    CXLEventRecordHdr *hdr = &dCap.hdr;
> +    CXLType3Dev *dcd;
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +    uint32_t num_extents = 0;
> +    CXLDCExtentRecordList *list;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +    CXLDCDExtentList *extent_list = NULL;
> +    uint8_t enc_log;
> +    uint64_t offset, len, block_size;
> +    int i;
> +    int rc;
> +    g_autofree unsigned long *blk_bitmap = NULL;
> +
> +    obj = object_resolve_path(path, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +    block_size = dcd->dc.regions[rid].block_size;
> +
> +    /* Sanity check and count the extents */
> +    list = records;
> +    while (list) {
> +        offset = list->value->offset * MiB;
> +        len = list->value->len * MiB;
> +
> +        if (len == 0) {
> +            error_setg(errp, "extent with 0 length is not allowed");
> +            return;
> +        }
> +
> +        if (offset % block_size || len % block_size) {
> +            error_setg(errp, "dpa or len is not aligned to region block size");
> +            return;
> +        }
> +
> +        if (offset + len > dcd->dc.regions[rid].len) {
> +            error_setg(errp, "extent range is beyond the region end");
> +            return;
> +        }
> +
> +        num_extents++;
> +        list = list->next;
> +    }
> +    if (num_extents == 0) {
> +        error_setg(errp, "No extents found in the command");
> +        return;
> +    }
> +
> +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> +
> +    /* Create Extent list for event being passed to host */
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtentRaw, num_extents);
> +    while (list) {
> +        offset = list->value->offset * MiB;
> +        len = list->value->len * MiB;
That suggests it wasn't in MiB unlike the comment below.

> +
> +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);
> +        extents[i].shared_seq = 0;
> +
> +        /*
> +         * We block the release request from FM if the exact extent has
> +         * not been accepted by the host yet

If it's released before host accepts it that is fine - drop it from the pending list.
If the host then tries to accept we validate it and fail the accept.

Should really validate no overlap with existing extents in pending list or
accepted lists.


> +         * TODO: We can loose the restriction by skipping the check if desired
> +         */
> +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> +            if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> +                error_setg(errp, "No exact extent found in the extent list");
> +                return;
> +            }
> +        }
> +
> +        /* No duplicate or overlapped extents are allowed */
> +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> +                              len / block_size)) {
> +            error_setg(errp, "duplicate or overlapped extents are detected");
> +            return;
> +        }
> +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> +
> +        list = list->next;
> +        i++;
> +    }
> +
> +    switch (type) {
> +    case DC_EVENT_ADD_CAPACITY:
> +        extent_list = &dcd->dc.extents_pending_to_add;
> +        break;
> +    default:
> +        break;
> +    }
> +    /*
> +     * CXL r3.0 section 8.2.9.1.5: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +
> +    dCap.type = type;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = 0;
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +
> +        if (extent_list) {
Given this is always the same list
	   if (type == DC_EVENT_ADD_CAPACITY) {
               cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
//local variable here to avoid line length but the basic idea is the same.


> +            cxl_insert_extent_to_extent_list(extent_list,
> +                                             extents[i].start_dpa,
> +                                             extents[i].len,
> +                                             extents[i].tag,
> +                                             extents[i].shared_seq);
> +        }
> +
> +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> +                             (CXLEventRecordRaw *)&dCap)) {
> +            cxl_event_irq_assert(dcd);
> +        }
> +    }
> +}

...

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b3d35fe000..ca4f824b11 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -491,6 +491,7 @@ struct CXLType3Dev {
>          AddressSpace host_dc_as;
>          uint64_t total_capacity; /* 256M aligned */
>          CXLDCDExtentList extents;
> +        CXLDCDExtentList extents_pending_to_add;
>  
>          uint32_t total_extent_count;
>          uint32_t ext_list_gen_seq;
> @@ -550,5 +551,10 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
>  
>  CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> -
Avoid the whitespace change either by never adding that blank line or by keeping it here.

> +void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> +                                             uint64_t dpa,
> +                                             uint64_t len,
> +                                             uint8_t *tag,
> +                                             uint16_t shared_seq);
> +bool test_any_bits_set(const unsigned long *addr, int nr, int size);
>  #endif
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index d778487b7e..4f8cb3215d 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -166,4 +166,19 @@ typedef struct CXLEventMemoryModule {
>      uint8_t reserved[0x3d];
>  } QEMU_PACKED CXLEventMemoryModule;
>  
> +/*
> + * CXL r3.0 section Table 8-47: Dynamic Capacity Event Record
> + * All fields little endian.
> + */
> +typedef struct CXLEventDynamicCapacity {
> +    CXLEventRecordHdr hdr;
> +    uint8_t type;
> +    uint8_t reserved1;
> +    uint16_t host_id;
> +    uint8_t updated_region_id;
> +    uint8_t reserved2[3];
> +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */

Can't we use that definition here?

> +    uint8_t reserved[0x20];
> +} QEMU_PACKED CXLEventDynamicCapacity;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..6b631f64f1 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
...

> @@ -361,3 +362,60 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDCExtentRecord:
> +#
> +# Record of a single extent to add/release
> +#
> +# @offset: offset of the extent start related to current region base address
> +# @len: extent size (in MiB)

Why?  Extents can be smaller than that (though we might not have implemented
that yet).  Bytes would be better.

> +#
> +# Since: 8.0
> +##
> +{ 'struct': 'CXLDCExtentRecord',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The host will
> +# need to respond to indicate it accepts the capacity before it becomes
> +# available for read and write.

The device will have to have acknowledged the accept though perhaps that is
too much detail.

> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release
> +# @extents: Extents to add
> +#
> +# Since : 8.2

Update for next version.  9.0 is ideal target now.

> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will
> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release
> +# @extents: Extents to release
> +#
> +# Since : 8.2
> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'region-id': 'uint8',
> +            'extents': [ 'CXLDCExtentRecord' ]
> +           }
> +}



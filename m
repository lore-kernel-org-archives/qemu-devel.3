Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C503EC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ucu-0003i0-22; Thu, 24 Apr 2025 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uco-0003hU-3Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:20:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uck-0003qx-86
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:20:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjtgp6v89z6M4MZ;
 Thu, 24 Apr 2025 19:15:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C7AD140122;
 Thu, 24 Apr 2025 19:20:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 13:20:01 +0200
Date: Thu, 24 Apr 2025 12:19:59 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <20250424121959.0000042d@huawei.com>
In-Reply-To: <20250317164204.2299371-9-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-9-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 17 Mar 2025 16:31:35 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 173 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +-
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 181 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 77cf0fdb15..5bcbd434b7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -127,6 +127,8 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
>          #define GET_DC_REGION_EXTENT_LIST 0x3
> +        #define INITIATE_DC_ADD           0x4
> +

No blank line here.

>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3669,6 +3671,170 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> +                                                        uint16_t host_id,
> +                                                        uint32_t ext_count,
> +                                                        CXLDCExtentRaw extents[],
> +                                                        CXLDCEventType type)
> +{
> +    CXLDCExtentRaw ext;
> +    CXLDCRegion *reg = NULL;
> +    int i, j;
> +
> +    if (dcd->dc.num_regions == 0) {

Can we actually get here like that?

> +        qemu_log_mask(LOG_UNIMP,
> +                      "No dynamic capacity support from the device.\n");
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* TODO: host id check will be added later, currently host id must be 0. */
> +    if (host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    for (i = 0; i < ext_count; i++) {
> +        ext = extents[i];
> +
> +        if (ext.len == 0) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
> +        if (!reg) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        /* Check requested extents do not overlap with each other. */
> +        for (j = i + 1; j < ext_count; j++) {
> +            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
> +                               extents[j].len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/*
> + * CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h)
> + */
> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;

Move some of this into the scope of the case below

Or maybe factor out that whole thing as a new function?

> +    CXLEventDynamicCapacity event_rec = {};
> +    CXLDCExtentGroup *group = NULL;
> +    CXLDCExtentRaw ext;
> +    int rc, i;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents causes exceeding device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> +                                                   in->host_id,
> +                                                   in->ext_count,
> +                                                   in->extents,
> +                                                   DC_EVENT_ADD_CAPACITY);
> +        if (rc) {
> +            return rc;
> +        }
> +
> +        /* Prepare extents for Event Record */
> +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> +        for (i = 0; i < in->ext_count; i++) {
> +            ext = in->extents[i];
> +            event_rec_exts[i].start_dpa = ext.start_dpa;
> +            event_rec_exts[i].len = ext.len;
> +            memset(event_rec_exts[i].tag, 0, 0x10);
> +            event_rec_exts[i].shared_seq = 0;
> +
> +            /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                     ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +
> +            /* Create extent group to add to pending list. */
> +            group = cxl_insert_extent_to_extent_group(group,
> +                                                      event_rec_exts[i].start_dpa,
> +                                                      event_rec_exts[i].len,
> +                                                      event_rec_exts[i].tag,
> +                                                      event_rec_exts[i].shared_seq);
> +        }
> +
> +        /* Add requested extents to pending list. */
> +        if (group) {
> +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +        }
> +
> +        /* Create event record and insert to event log */
> +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> +        event_rec.type = DC_EVENT_ADD_CAPACITY;
> +        /* FIXME: for now, validity flag is cleared */

This stuff is probably all valid.  If we can return remaining extents though we might
as well.

> +        event_rec.validity_flags = 0;
> +        /* FIXME: Currently only support 1 host */
> +        event_rec.host_id = 0;
> +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> +        event_rec.updated_region_id = 0;

The event_rec is zeroed anyway so probably just don't set this at all
and no need for the comment.

> +        for (i = 0; i < in->ext_count; i++) {

Why can't we combine this with the earlier loop and avoid the
need for separate storage of extents in event_rec_exts?

> +            memcpy(&event_rec.dynamic_capacity_extent,
> +                   &event_rec_exts[i],
> +                   sizeof(CXLDCExtentRaw));
> +
> +            event_rec.flags = 0;
> +            if (i < in->ext_count - 1) {
> +                /* Set "More" flag */
> +                event_rec.flags |= BIT(0);
> +            }
> +
> +            if (cxl_event_insert(&ct3d->cxl_dstate,
> +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                                 (CXLEventRecordRaw *)&event_rec)) {
> +                cxl_event_irq_assert(ct3d);
> +            }
> +        }
> +
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
>      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>          cmd_fm_get_dc_region_extent_list, 12, 0},
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b742b2bb8d..ccc619fe10 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>   * the list.
>   * Return value: return true if has overlaps; otherwise, return false
>   */
> -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> -                                           uint64_t dpa, uint64_t len)
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtent *ent;
>      Range range1, range2;
> @@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
>      return false;
>  }
>  
> -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> -                                                 uint64_t dpa, uint64_t len)
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtentGroup *group;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 217003a29d..1d5831a0b6 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif



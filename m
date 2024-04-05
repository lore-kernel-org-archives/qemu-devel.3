Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F7C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 11:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rshuh-0002Xx-M6; Fri, 05 Apr 2024 07:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rshue-0002XU-47
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:39:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rshuZ-0007zH-6e
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:39:14 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9xLF410Cz6J6pL;
 Fri,  5 Apr 2024 19:37:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1741F140C98;
 Fri,  5 Apr 2024 19:39:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 12:39:03 +0100
Date: Fri, 5 Apr 2024 12:39:02 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240405123902.00004344@Huawei.com>
In-Reply-To: <20240325190339.696686-9-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-9-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 25 Mar 2024 12:02:26 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.1, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> 
> For the process of the above two commands, we use two-pass approach.
> Pass 1: Check whether the input payload is valid or not; if not, skip
>         Pass 2 and return mailbox process error.
> Pass 2: Do the real work--add or release extents, respectively.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

A few additional comments from me.

Jonathan


> +/*
> + * For the extents in the extent list to operate, check whether they are valid
> + * 1. The extent should be in the range of a valid DC region;
> + * 2. The extent should not cross multiple regions;
> + * 3. The start DPA and the length of the extent should align with the block
> + * size of the region;
> + * 4. The address range of multiple extents in the list should not overlap.
> + */
> +static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
> +        const CXLUpdateDCExtentListInPl *in)
> +{
> +    uint64_t min_block_size = UINT64_MAX;
> +    CXLDCRegion *region = &ct3d->dc.regions[0];

This is immediately overwritten if num_regions != 0 (Which I think is checked before
calling this function).  So no need to initialize it.

> +    CXLDCRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
> +    g_autofree unsigned long *blk_bitmap = NULL;
> +    uint64_t dpa, len;
> +    uint32_t i;
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        min_block_size = MIN(min_block_size, region->block_size);
> +    }
> +
> +    blk_bitmap = bitmap_new((lastregion->base + lastregion->len -
> +                             ct3d->dc.regions[0].base) / min_block_size);
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        region = cxl_find_dc_region(ct3d, dpa, len);
> +        if (!region) {
> +            return CXL_MBOX_INVALID_PA;
> +        }
> +
> +        dpa -= ct3d->dc.regions[0].base;
> +        if (dpa % region->block_size || len % region->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +        /* the dpa range already covered by some other extents in the list */
> +        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> +            len / min_block_size)) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> +   }
> +
> +    return CXL_MBOX_SUCCESS;
> +}



> +/*
> + * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (Opcode 4802h)
> + * An extent is added to the extent list and becomes usable only after the
> + * response is processed successfully
> + */
> +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_SUCCESS;
> +    }


A zero length response is a rejection of an offered set of extents.
Probably want a todo here to say this will wipe out part of the pending list
(similar to the one you have below).

> +
> +    /* Adding extents causes exceeding device's extent tracking ability. */
> +    if (in->num_entries_updated + ct3d->dc.total_extent_count >
> +        CXL_NUM_EXTENTS_SUPPORTED) {
> +        return CXL_MBOX_RESOURCES_EXHAUSTED;
> +    }
> +
> +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> +        ct3d->dc.total_extent_count += 1;
> +        /*
> +         * TODO: we will add a pending extent list based on event log record
> +         * and process the list according here.
> +         */
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}

> +static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> +        const CXLUpdateDCExtentListInPl *in)
> +{
> +    CXLDCExtent *ent, *ent_next;
> +    uint64_t dpa, len;
> +    uint32_t i;
> +    int cnt_delta = 0;
> +    CXLDCExtentList tmp_list;
> +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> +
> +    if (in->num_entries_updated == 0) {

This is only used in paths where we already checked this. I don't hink
we need to repeat.

> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    QTAILQ_INIT(&tmp_list);
> +    copy_extent_list(&tmp_list, &ct3d->dc.extents);
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        Range range;
> +
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        while (len > 0) {
> +            QTAILQ_FOREACH(ent, &tmp_list, node) 
> +                range_init_nofail(&range, ent->start_dpa, ent->len);
> +
> +                if (range_contains(&range, dpa)) {
> +                    uint64_t len1, len2, len_done = 0;
> +                    uint64_t ent_start_dpa = ent->start_dpa;
> +                    uint64_t ent_len = ent->len;
> +                    /*
> +                     * Found the exact extent or the subset of an existing
> +                     * extent.
> +                     */
> +                    if (range_contains(&range, dpa + len - 1)) {
> +                        len1 = dpa - ent->start_dpa;
> +                        len2 = ent_start_dpa + ent_len - dpa - len;
> +                        len_done = ent_len - len1 - len2;
I'd like this to look a bit more like the real run - possibly allowing code
sharing. Though definitely see if there is a way to share more as Jorgen suggested.

                        len1 = dpa - ent_start_dpa;
                        if (range_contains(&range, dpa + len - 1) {
                            len 2 = ent_start_dpa + ent_len - dpa - len;
                        } else { /* maybe add an if (dry_run) here to allow code reuse */
                            /*
                             * TODO: we reject the attempt to remove an extent
                             * that overlaps with multiple extents in the device 
                             * for now, we will allow it once superset release
                             * support is added.
                             */
                             ret = CXL_MBOX_INVALID_PA;
                             goto free_and_exit;
			}
> +
> +                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +                        cnt_delta--;
> +
> +                        if (len1) {
> +                            cxl_insert_extent_to_extent_list(&tmp_list,
> +                                                             ent_start_dpa,
> +                                                             len1, NULL, 0);
> +                            cnt_delta++;
> +                        }
> +                        if (len2) {
> +                            cxl_insert_extent_to_extent_list(&tmp_list,
> +                                                             dpa + len,
> +                                                             len2, NULL, 0);
> +                            cnt_delta++;
> +                        }
> +
> +                        if (cnt_delta + ct3d->dc.total_extent_count >
> +                            CXL_NUM_EXTENTS_SUPPORTED) {
> +                            ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> +                            goto free_and_exit;
> +                        }
> +                    } else {
> +                        /*
> +                         * TODO: we reject the attempt to remove an extent
> +                         * that overlaps with multiple extents in the device
> +                         * for now, we will allow it once superset release
> +                         * support is added.
> +                         */
> +                        ret = CXL_MBOX_INVALID_PA;
> +                        goto free_and_exit;
> +                    }
> +
> +                    len -= len_done;
> +                    /* len == 0 here until superset release is added */
> +                    break;
> +                }
> +            }
> +            if (len) {
> +                ret = CXL_MBOX_INVALID_PA;
> +                goto free_and_exit;
> +            }
> +        }
> +    }
> +free_and_exit:
> +    QTAILQ_FOREACH_SAFE(ent, &tmp_list, node, ent_next) {
> +        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +    }
> +
> +    return ret;
> +}
> +
> +/*
> + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
> + */
> +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLCCI *cci)
> +{
> +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCExtent *ent;
> +    uint32_t i;
> +    uint64_t dpa, len;
> +    CXLRetCode ret;
> +
> +    if (in->num_entries_updated == 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    ret = cxl_dc_extent_release_dry_run(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
> +
> +    /* From this point, all the extents to release are valid */

known to be valid

> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        Range range;
Perhaps factor out the handling of each extent?  Will reduce indent
and give more readable code I think. 

> +
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        while (len > 0) {
> +            QTAILQ_FOREACH(ent, extent_list, node) {
> +                range_init_nofail(&range, ent->start_dpa, ent->len);
> +
> +                /* Found the extent overlapping with */
> +                if (range_contains(&range, dpa)) {
> +                    uint64_t len1, len2 = 0, len_done = 0;
> +                    uint64_t ent_start_dpa = ent->start_dpa;
> +                    uint64_t ent_len = ent->len;
> +
> +                    len1 = dpa - ent_start_dpa;
> +                    if (range_contains(&range, dpa + len - 1)) {
> +                        len2 = ent_start_dpa + ent_len - dpa - len;
> +                    }
> +                    len_done = ent_len - len1 - len2;
> +
> +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> +                    ct3d->dc.total_extent_count -= 1;
> +
> +                    if (len1) {
> +                        cxl_insert_extent_to_extent_list(extent_list,
> +                                                         ent_start_dpa,
> +                                                         len1, NULL, 0);
> +                        ct3d->dc.total_extent_count += 1;
> +                    }
> +                    if (len2) {
> +                        cxl_insert_extent_to_extent_list(extent_list,
> +                                                         dpa + len,
> +                                                         len2, NULL, 0);
> +                        ct3d->dc.total_extent_count += 1;
> +                    }
> +
> +                    len -= len_done;
> +                    /*
> +                     * len will always be 0 until superset release is add.
> +                     * TODO: superset release will be added.
> +                     */
> +                    break;
> +                }
> +            }
> +        }
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1413,15 +1832,15 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
>          cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
>      [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
> -                                      cmd_events_get_interrupt_policy, 0, 0 },
> +        cmd_events_get_interrupt_policy, 0, 0 },
>      [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
> -                                      cmd_events_set_interrupt_policy,
> -                                      ~0, IMMEDIATE_CONFIG_CHANGE },
> +        cmd_events_set_interrupt_policy,
> +        ~0, IMMEDIATE_CONFIG_CHANGE },

Avoid the reformatting in a patch that does other stuff.
Adds noise and hides any actual changes in the blocks re indented.

>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> -                         8, IMMEDIATE_POLICY_CHANGE },
> +        8, IMMEDIATE_POLICY_CHANGE },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> @@ -1450,6 +1869,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>      [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>          "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>          8, 0 },
> +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +        "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +        ~0, IMMEDIATE_DATA_CHANGE },
> +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> +        "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> +        ~0, IMMEDIATE_DATA_CHANGE },
>  };
>  




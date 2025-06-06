Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13988C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbh1-0000tL-Nq; Fri, 06 Jun 2025 14:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNbgo-0000qd-RY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:21:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNbgm-0006jU-JX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:21:14 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-747fc77ba9eso1931922b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749234071; x=1749838871; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tP/wQPBGjbbKyfTZfIc/iAV9m6jQ7fU2q5ZDYkmBio0=;
 b=NNuYtv1a5nO1PhwVdNPvvQ8VFoQlioaBS8X8x6W5E5fps3gWMdYl/Yv8aqfacGRQOQ
 KaDhgrDqrY8miTY/fKLXkr8y6Jz7t7ajTVFraiHsra7VlGh8D5OKY3TFFYaMNnXNJGTp
 6sceMdszVOw24bmyu5WCCUM7i0vxzMkNFdrC4CRE6/84uf6I6506S7xrX1Y12IZipLdc
 pqarvIlVAT3AuglRSDIWoh7xEe7LEU0d+LUiVdJlqMvHTdt9vw1k4HJw3W2P4rGhh6cA
 RqeFnhQQZBhNFYrxUwoH5Z1JfQlexjmOhVKEIYWw9dnE9Ef1o5ZRkvvqmcL/VbwOyvmM
 bJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749234071; x=1749838871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tP/wQPBGjbbKyfTZfIc/iAV9m6jQ7fU2q5ZDYkmBio0=;
 b=XL6rL9ACU9/Mp7OGtP8+Y60Y7GxogGiXyRTFG9tXM/p+fnjwJRHmCOdQ0X1Kcv3Gq+
 9je7cS8cM0d2ro1oeN2dakj0xg1tNFZQrS5cWg4zM17eoRf/nqU7B6nYXlLI+hjHGxY/
 +9vywqNF1DowXbobLLsQ2uOABak9LcIEBUqBz87kCMH0PQIuC4oaFgW59TCWgRb7zcTD
 6qiWaxiH30OUVNuyTyBJTil3zSJ0VQbZF55zdUh4hgZJx9zjZsC6H1X5stu7qYR1udOu
 MVmqozbXzpn8BCLbR21qivveURd13JHdod7OErpvARoCf/lX7DfkWPnmo6yE8h4mhjFm
 VCdQ==
X-Gm-Message-State: AOJu0Yxbr8bq/WkMV6CQ4uVSzbwgCEkv1feurhXkis71UraonmE1x7eY
 L450dB4JSd1TUgquosQuidOx38mGnxmzMy2NwwQbsFO6oKQvkSwld/ls
X-Gm-Gg: ASbGnct2U9qpDwLAMAp+SikBbH5UrU9GTdAhKck1qlRPbriTepQuZ1nDU+64yEv4jRv
 3Nr482ro+PrRlitlvg1ufyPOIaC4O4wQoqDbY2Ty0AJYdm+1NE5Zecb/xAgQEtrBY2S1CgLrNSN
 ydqmy2ju15iBIb4zq+jhhwDlKpO96WQKhyMRTHtpR83D7BGWYk8+2hZxbXMcAaZrU60syjhif9v
 D2XXbJpjUf7F5CfREMXSUkP09gQNkGFmuPB43oK0VLPjBXxgH3yfjC59SlF5GcB+hQ7f7LWTF03
 lLtWf03gS4AqdAvvt+Nla4Nr54VfSpxmK1wKrtaTYXj0Ug40q6TQSnsq
X-Google-Smtp-Source: AGHT+IEQKwEx2+/rddCXUF2Qea6AEuSEJ2Z4uB4eLOdmdV0gZL/ozRb0PlKzXwtLOLvwFDwZQdiaXw==
X-Received: by 2002:a05:6a20:3d8a:b0:215:e9ec:81d2 with SMTP id
 adf61e73a8af0-21ee686173bmr6007354637.32.1749234070773; 
 Fri, 06 Jun 2025 11:21:10 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b091cc3sm1612701b3a.106.2025.06.06.11.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 11:21:10 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:21:08 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aEMxlAvukxhWXhw1@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-9-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605234227.970187-9-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 05, 2025 at 11:42:22PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

See below...

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +-
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 004e502b22..7ee5be00bc 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG   0x1
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,

This naming can be improved here, not straightforward to me.
Maybe cxl_add_extents_to_pending_list() ?

> +                                       uint32_t ext_count,
> +                                       CXLDCExtentRaw extents[])
> +{
> +    CXLDCExtentGroup *group = NULL;
> +    int i;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        group = cxl_insert_extent_to_extent_group(group,
> +                                                  extents[i].start_dpa,
> +                                                  extents[i].len,
> +                                                  extents[i].tag,
> +                                                  extents[i].shared_seq);
> +    }
> +
> +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +    ct3d->dc.total_extent_count += ext_count;
> +}

Also the code is duplicate with existing code in cxl_type3.c 
qmp_cxl_process_dynamic_capacity_prescriptive(). 
The function was simulating the behaviour of the mailbox command, so it is
behaviour will be smilar to what we have in this patch, 
find a way to reuse code, maybe extract common code as a helper function and use
it in both qmp interface and here.

> +
> +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
cxl_create_dc_extent_records_for extents()?
> +                                                         CXLDCEventType type,
> +                                                         CXLDCExtentRaw extents[],
> +                                                         uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}

Some issue here. A lot of duplicate code compared to
qmp_cxl_process_dynamic_capacity_prescriptive.

> +
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
> + * CXLUpdateDCExtentListInPl as a parameter.
> + */
> +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> +                                CXLUpdateDCExtentListInPl *extent_list,
> +                                int count)
> +{
> +    int i;
> +
> +    extent_list->num_entries_updated = count;
> +
> +    for (i = 0; i < count; i++) {
> +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> +        extent_list->updated_entries[i].len = raw_extents[i].len;
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
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
> +    CXLUpdateDCExtentListInPl *list;
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents exceeds device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));

Use g_malloc() and g_free().

> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +        for (i = 0; i < in->ext_count; i++) {
> +            CXLDCExtentRaw ext = in->extents[i];
> +             /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                     ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (rc) {
> +            return rc;
> +        }
> +
> +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_ADD_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +

For all the case to return, instead of return directly set return code and jump
here, do two things:
1. g_free(list);
2. return rt;

Fan

> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>          cmd_fm_get_dc_region_extent_list, 12, 0 },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ee554a77be..ca9fe89e4f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
> @@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
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
> index 76af75d2d0..d30f6503fa 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> -- 
> 2.47.2
> 


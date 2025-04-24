Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB10C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ufm-00055G-PF; Thu, 24 Apr 2025 07:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7ufl-00054q-7K
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:23:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7ufh-0004PM-Bj
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:23:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjtpD24xFz6L53f;
 Thu, 24 Apr 2025 19:21:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 832BB140122;
 Thu, 24 Apr 2025 19:23:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 13:23:10 +0200
Date: Thu, 24 Apr 2025 12:23:08 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Message-ID: <20250424122308.00004e8e@huawei.com>
In-Reply-To: <20250317164204.2299371-10-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-10-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
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

On Mon, 17 Mar 2025 16:31:36 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Similar comments to patch 8 around the double loop.

I'd also like Fan to take a look through these (v2 probably)
as he's messed with DCD a lot more than me!

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5bcbd434b7..37810d892f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -128,6 +128,7 @@ enum {
>          #define SET_DC_REGION_CONFIG 0x2
>          #define GET_DC_REGION_EXTENT_LIST 0x3
>          #define INITIATE_DC_ADD           0x4
> +        #define INITIATE_DC_RELEASE       0x5
>  
>  };
>  
> @@ -3722,6 +3723,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
>                                                 ext.start_dpa, ext.len)) {
>                  return CXL_MBOX_INVALID_EXTENT_LIST;
>              }
> +        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
> +            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_PA;
> +            }
>          }
>      }
>  
> @@ -3835,6 +3840,88 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h)
> + */
> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
> +    CXLEventDynamicCapacity event_rec = {};
> +    CXLDCExtentRaw ext;
> +    int i, rc = 0;

Prefer not to combine cases where you init and ones where you don't.
Just use 2 lines instead.

> +
> +    switch (in->flags & 0x7) {

That 7 needs a define.

> +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> +                                                   in->host_id,
> +                                                   in->ext_count,
> +                                                   in->extents,
> +                                                   DC_EVENT_RELEASE_CAPACITY);
> +        if (rc) {
> +            return rc;
> +        }
> +
> +        /* Create extents for Event Record */
> +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> +        for (i = 0; i < in->ext_count; i++) {
> +            ext = in->extents[i];
> +            event_rec_exts[i].start_dpa = ext.start_dpa;
> +            event_rec_exts[i].len = ext.len;
> +            memset(event_rec_exts[i].tag, 0, 0x10);
> +            event_rec_exts[i].shared_seq = 0;
> +        }

Similar to before. I'm not currently following the reason for the local
storage.

> +
> +        /* Create event record and insert to event log */
> +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> +        event_rec.type = DC_EVENT_RELEASE_CAPACITY;
> +        /* FIXME: for now, validity flag is cleared */
> +        event_rec.validity_flags = 0;
> +        /* FIXME: Currently only support 1 host */
> +        event_rec.host_id = 0;
> +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> +        event_rec.updated_region_id = 0;
> +        for (i = 0; i < in->ext_count; i++) {
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
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +            "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3977,6 +4064,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> +        cmd_fm_initiate_dc_release, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
>  };
>  
>  /*



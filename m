Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC30C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uTf-0001dN-0P; Thu, 24 Apr 2025 07:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uTd-0001d7-QG
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:10:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uTb-000332-Cy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:10:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjtSW3nd1z6K9hq;
 Thu, 24 Apr 2025 19:06:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 29B151402EF;
 Thu, 24 Apr 2025 19:10:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 13:10:39 +0200
Date: Thu, 24 Apr 2025 12:10:38 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 7/9] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Message-ID: <20250424121038.0000379d@huawei.com>
In-Reply-To: <20250317164204.2299371-8-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-8-anisa.su887@gmail.com>
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

On Mon, 17 Mar 2025 16:31:34 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
> Very similar to previously implemented command 0x4801.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 84 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 51ead2b152..77cf0fdb15 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -126,6 +126,7 @@ enum {
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
> +        #define GET_DC_REGION_EXTENT_LIST 0x3
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3587,6 +3588,87 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h)

Single line comment fine here.

> + */
> +static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t rsvd[2];
> +        uint32_t start_extent_id;
> +        uint32_t extents_returned;
> +        uint32_t total_extents;
> +        uint32_t list_generation_num;
> +        uint8_t rsvd2[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCExtent *ent;
> +    CXLDCExtentRaw *out_rec;
> +    uint16_t record_count = 0, record_done = 0, i = 0;
> +    uint16_t out_pl_len, max_size;
> +
> +    if (ct3d->dc.num_regions == 0) {

As in previous.

> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (in->start_extent_id > ct3d->dc.total_extent_count) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(in->extent_cnt,
> +                       ct3d->dc.total_extent_count - in->start_extent_id);
> +    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
> +    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    stw_le_p(&out->host_id, in->host_id);
> +    stl_le_p(&out->start_extent_id, in->start_extent_id);
> +    stl_le_p(&out->extents_returned, record_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +    if (record_count > 0) {
> +        out_rec = &out->records[record_done];

Given this isn't in the loop, record_done is always 0, so maybe just
use that here?
Or maybe drag that into the loop and...

> +
> +        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> +            if (i++ < in->start_extent_id) {
> +                continue;
> +            }
> +            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
> +            stq_le_p(&out_rec->len, ent->len);
> +            memcpy(&out_rec->tag, ent->tag, 0x10);
> +            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
> +
> +            record_done++;
> +            out_rec++;

Then no need to increment out_rec here.

> +            if (record_done == record_count) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3720,6 +3802,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>           CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> +    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> +        cmd_fm_get_dc_region_extent_list, 12, 0},

space before }


>  };
>  
>  /*



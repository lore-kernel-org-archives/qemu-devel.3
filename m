Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C5C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uDI-0001N4-Um; Thu, 24 Apr 2025 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uDF-0001MX-UQ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:53:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7uDD-00018o-2a
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:53:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjt5R5Sgxz6M4Qg;
 Thu, 24 Apr 2025 18:49:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6E48D1400DB;
 Thu, 24 Apr 2025 18:53:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:53:38 +0200
Date: Thu, 24 Apr 2025 11:53:37 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 4/9] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region
 Config
Message-ID: <20250424115337.00006768@huawei.com>
In-Reply-To: <20250317164204.2299371-5-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-5-anisa.su887@gmail.com>
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

On Mon, 17 Mar 2025 16:31:31 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Hi Anisa,

Just a few trivial things in here.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 97 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e9991fd1a7..4bb51bf3e8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -124,6 +124,7 @@ enum {
>          #define GET_MHD_INFO 0x0
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
> +        #define GET_HOST_DC_REGION_CONFIG 0x1
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3399,6 +3400,100 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h)
> + */
> +static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t region_cnt;
> +        uint8_t start_rid;
> +    } QEMU_PACKED *in;

= (void *)payload_in;

> +    struct {
> +        uint16_t host_id;
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint8_t dsmas_flags;
> +            uint8_t rsvd1[3];
> +            uint8_t sanitize;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out;

= (void *)payload_out;

> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint16_t record_count, out_pl_len, i;
> +    uint8_t start_rid;
> +
> +    if (ct3d->dc.num_regions == 0) {

As in earlier patch - we don't register these commands
at all unless num_regions > 0 so probably don't need this
check.

> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    in = (void *)payload_in;
> +    if (in->start_rid >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    start_rid = in->start_rid;

The saving in characters for having the local variable doesn't seem
worthwhile to me.  I'd just in->start_rid where ever you need it.

> +    record_count = MIN(ct3d->dc.num_regions - start_rid, in->region_cnt);
> +
> +    out = (void *)payload_out;
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +
> +    extra_out = (void *)(out) + out_pl_len;

Do we need the brackets around out?

> +    out_pl_len += sizeof(*extra_out);
> +
> +    assert(*len_out <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    /* TODO: For now, fix host id to be 0 */
> +    stw_le_p(&out->host_id, 0);
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[start_rid + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[start_rid + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[start_rid + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[start_rid + i].block_size);
> +        out->records[i].dsmas_flags =
> +            ct3d->dc.regions[start_rid + i].dsmas_flags;

As in previous patch. I'd build this here from specific booleans
as the relationship to the dmsas flags isn't defined that tightly.


> +        out->records[i].sanitize = 0;
> +    }
> +    /*
> +     * TODO: Assign values once extents and tags are introduced
> +     * to use.
> +     */
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
> +             ct3d->dc.total_extent_count);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3523,6 +3618,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>  static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>      [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
>          cmd_fm_get_dcd_info, 0, 0},
> +    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
> +        cmd_fm_get_host_dc_region_config, 4, 0},
Space before }

Check for any other instances of this in the rest of the series.

>  };
>  
>  /*



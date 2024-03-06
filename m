Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB463C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 15:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rht7s-0007Sf-3Z; Wed, 06 Mar 2024 10:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rht7q-0007Re-09
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:24:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rht7n-0002uJ-7P
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 10:24:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqbhk2kyWz6K7F9;
 Wed,  6 Mar 2024 23:20:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id CD32D1400DB;
 Wed,  6 Mar 2024 23:24:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:24:03 +0000
Date: Wed, 6 Mar 2024 15:24:02 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 02/13] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240306152402.0000097c@Huawei.com>
In-Reply-To: <20240304194331.1586191-3-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon,  4 Mar 2024 11:33:57 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: we store region decode length as byte-wise length on the device, which
> should be divided by 256 * MiB before being returned to the host
> for "Get Dynamic Capacity Configuration" mailbox command per
> specification.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Really minor nice to have type comments inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 99 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 16 ++++++
>  2 files changed, 115 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..5792010c12 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,8 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> +#define CXL_NUM_EXTENTS_SUPPORTED 512
> +#define CXL_NUM_TAGS_SUPPORTED 0
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -80,6 +82,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1238,6 +1242,91 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
> + * (Opcode: 4800h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct {
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED *in;

If you respin a few line breaks might help on readability.
I'd stick one after each struct.

> +    struct {
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        uint8_t rsvd1[6];
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;
> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out;
    } QEMU_PACKED *out = (void *)payload_out;
(see below)

> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;

> +    uint16_t record_count;
> +    uint16_t i;
> +    uint16_t out_pl_len;
> +    uint8_t start_region_id;
> +
> +    in = (void *)payload_in;
> +    out = (void *)payload_out;

These are a bit uninteresting so could just assign them at the definitions above?


> +    start_region_id = in->start_region_id;

Perhaps something shorter like start_rid for the local variable?

> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
I'd align with just after opening bracket.

> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    extra_out = (void *)(payload_out + out_pl_len);
> +    out_pl_len += sizeof(*extra_out);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[start_region_id + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[start_region_id + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[start_region_id + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[start_region_id + i].block_size);
> +        stl_le_p(&out->records[i].dsmadhandle,
> +                 ct3d->dc.regions[start_region_id + i].dsmadhandle);
> +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> +    }
> +    /*
> +     * TODO: will assign proper values when extents and tags are introduced
> +     * to use.
Drop the to use
	* TODO: Assign values once extents and tags are introduced.

> +     */
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753A9C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwNK-0002sG-NS; Fri, 14 Feb 2025 09:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiwNI-0002s6-Ex
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:09:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tiwNF-0003YW-Js
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:09:00 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvYjk51knz6L59c;
 Fri, 14 Feb 2025 22:05:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C339140134;
 Fri, 14 Feb 2025 22:08:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 15:08:52 +0100
Date: Fri, 14 Feb 2025 14:08:51 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Message-ID: <20250214140851.000073fe@huawei.com>
In-Reply-To: <20250213091558.2294806-2-vinayak.kh@samsung.com>
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
 <CGME20250213091629epcas5p1e5435929f701840a7e13f22a83edff22@epcas5p1.samsung.com>
 <20250213091558.2294806-2-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Thu, 13 Feb 2025 14:45:56 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.

Given the CXL consortium only makes the latest spec available,
generally we try to reference that.
It's move to 8.2.10.9.5.3 in r3.2

Otherwise mostly minor style comments inline.

Thanks,

Jonathan



> CXL devices supports media operations discovery command.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 136 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..fa38ecf507 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -89,6 +89,7 @@ enum {
>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
>      PERSISTENT_MEM = 0x45,
>          #define GET_SECURITY_STATE     0x0
>      MEDIA_AND_POISON = 0x43,
> @@ -1721,6 +1722,137 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +#define CXL_CACHELINE_SIZE 64

Already defined in include/hw/cxl/cxl.h

> +enum {
> +    MEDIA_OP_CLASS_GENERAL  = 0x0,
> +        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
> +    MEDIA_OP_CLASS_SANITIZE = 0x1,
> +        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
> +        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
> +    MEDIA_OP_CLASS_MAX
> +};
> +
> +struct media_op_supported_list_entry {
> +    uint8_t media_op_class;
> +    uint8_t media_op_subclass;
> +};
> +
> +struct media_op_discovery_out_pl {
> +    uint64_t dpa_range_granularity;
> +    uint16_t total_supported_operations;
> +    uint16_t num_of_supported_operations;
> +    struct media_op_supported_list_entry entry[];
> +} QEMU_PACKED;
> +
> +static const struct media_op_supported_list_entry media_op_matrix[] = {
> +    {MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY},
> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE},
> +    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO}
Add trailing comma as we may well get more of these in future.
In general use a trailing comma whenever there isn't a definite reason
we will never get them.

Also I'd prefer space after { and before } to match local style.
    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },

> +};
> +
> +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out)
Align to opening bracket (just after it)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count; 
> +        struct {
> +            uint16_t start_index;
> +            uint16_t num_supported_ops;

I'd just call this num or num_ops


> +        } discovery_osa;
> +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
> +    int count = 0;
> +
> +    if (len_in < sizeof(*media_op_in_disc_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    struct media_op_discovery_out_pl *media_out_pl =
> +                                                  (void *)payload_out;
> +    int num_ops = media_op_in_disc_pl->discovery_osa.num_supported_ops;
> +    int start_index = media_op_in_disc_pl->discovery_osa.start_index;

Generally we don't mix declarations and code. So move these local variable
declarations up.


> +
> +    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    media_out_pl->dpa_range_granularity = CXL_CACHELINE_SIZE;
> +    media_out_pl->total_supported_operations =
> +                                     ARRAY_SIZE(media_op_matrix);
> +    if (num_ops > 0) {
> +        for (int i = start_index; i < ARRAY_SIZE(media_op_matrix); i++) {

Given you already checked for going out of range, can just do 
i < start_index + num_ops
I think and avoid the need to break or keep a count.

Keep to local style and declare i outside the loop


> +            media_out_pl->entry[count].media_op_class =
> +                    media_op_matrix[i].media_op_class;
> +            media_out_pl->entry[count].media_op_subclass =
> +                        media_op_matrix[i].media_op_subclass;
> +            count++;
> +            if (count == num_ops) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    media_out_pl->num_of_supported_operations = count;
> +    *len_out = sizeof(struct media_op_discovery_out_pl) +
> +        (sizeof(struct media_op_supported_list_entry) * count);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,

Alignment should be to opening bracket.

> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t media_operation_class;
> +        uint8_t media_operation_subclass;
> +        uint8_t rsvd[2];
> +        uint32_t dpa_range_count;
> +    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
> +
> +    if (len_in < sizeof(*media_op_in_common_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    uint8_t media_op_cl = media_op_in_common_pl->media_operation_class;
> +    uint8_t media_op_subclass =
> +                      media_op_in_common_pl->media_operation_subclass;
> +    uint32_t dpa_range_count = media_op_in_common_pl->dpa_range_count;

As above, traditional c style with declarations before code.

> +
> +    switch (media_op_cl) {
> +    case MEDIA_OP_CLASS_GENERAL:
> +        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        /*
> +         * As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count
> +         * should be zero for discovery sub class command
> +         */

I would move this into media_operations_discovery.

> +        if (dpa_range_count) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        return media_operations_discovery(payload_in, len_in, payload_out,
> +                                             len_out);
> +    case MEDIA_OP_CLASS_SANITIZE:

Easier to introduce this case in next patch.  Until then can just let
the default deal with it.

> +        switch (media_op_subclass) {
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +    default:
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +




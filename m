Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6136C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGdd-0007qa-CN; Tue, 04 Feb 2025 05:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfGdb-0007q9-Hk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:58:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfGdZ-0002w9-1K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:58:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnL1H2Pwrz6HJdZ;
 Tue,  4 Feb 2025 18:57:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id AFBB1140442;
 Tue,  4 Feb 2025 18:58:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 11:58:31 +0100
Date: Tue, 4 Feb 2025 10:58:29 +0000
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 3/3] hw/cxl/cxl-mailbox-utils.c: Added support for
 Populate Log (Opcode 0404h) as background operation
Message-ID: <20250204105829.00001c47@huawei.com>
In-Reply-To: <20250203055950.2126627-4-arpit1.kumar@samsung.com>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060055epcas5p4a7889ddf3b73b10f8b9b41778375ce63@epcas5p4.samsung.com>
 <20250203055950.2126627-4-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Mon,  3 Feb 2025 11:29:50 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Likewise, the CEL isn't a dynamic thing.  Asking to populate
it makes little sense so the log capability should always
say this is not supported.

I suspect you had this running with a different log and flipped
to CEL for purposes of up streaming?

Anyhow, choose something else.  Maybe component state dump or ECS log?

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 95 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  2 +
>  2 files changed, 97 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5fd7f850c4..115c2dc66b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -78,6 +78,7 @@ enum {
>          #define GET_LOG       0x1
>          #define GET_LOG_CAPABILITIES   0x2
>          #define CLEAR_LOG     0x3
> +        #define POPULATE_LOG  0x4
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1149,6 +1150,94 @@ static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_rebuild_cel(CXLCCI *cci);
> +
> +static int get_populate_duration(uint32_t total_mem)
> +{
> +    int secs = 0;
> +
> +    if (total_mem <= 512) {
> +        secs = 4;
> +    } else if (total_mem <= 1024) {
> +        secs = 8;
> +    } else if (total_mem <= 2 * 1024) {
> +        secs = 15;
> +    } else if (total_mem <= 4 * 1024) {
> +        secs = 30;
> +    } else if (total_mem <= 8 * 1024) {
> +        secs = 60;
> +    } else if (total_mem <= 16 * 1024) {
> +        secs = 2 * 60;
> +    } else if (total_mem <= 32 * 1024) {
> +        secs = 4 * 60;
> +    } else if (total_mem <= 64 * 1024) {
> +        secs = 8 * 60;
> +    } else if (total_mem <= 128 * 1024) {
> +        secs = 15 * 60;
> +    } else if (total_mem <= 256 * 1024) {
> +        secs = 30 * 60;
> +    } else if (total_mem <= 512 * 1024) {
> +        secs = 60 * 60;
> +    } else if (total_mem <= 1024 * 1024) {
> +        secs = 120 * 60;
> +    } else {
> +        secs = 240 * 60; /* max 4 hrs */
> +    }
> +
> +    return secs;
> +}
> +
> +/* CXL r3.1 Section 8.2.9.5.5: Populate log (Opcode 0404h) */
> +static CXLRetCode cmd_logs_populate_log(const struct cxl_cmd *cmd,
> +                                        uint8_t *payload_in,
> +                                        size_t len_in,
> +                                        uint8_t *payload_out,
> +                                        size_t *len_out,
> +                                        CXLCCI *cci)
> +{
> +    int32_t cap_id;
> +    uint32_t total_mem = 0;
> +    int secs = 0;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) * populate_log = (void *)payload_in;
> +
> +    cap_id = valid_log_check(&populate_log->uuid, cci);
> +    if (cap_id == -1) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
> +    if (cci->supported_log_cap[cap_id].param_flags.populate_log_supported) {
> +        switch (cap_id) {
> +        case CEL:
Similar to before, a callback to fill the log inside the cap entry
is probably going to be the most extensible way to do this rather
than using an ID and a switch statement that gets steadily more
complex and doesn't easily allow for different device emulation to
make different choices on what to fill with (e.g. faking component
state dump for a type 3 vs a type 2 device - once supported in qemu).

> +            cci->log = CEL;
> +            total_mem = (1 << 16) * sizeof(struct cel_log);
> +            secs = get_populate_duration(total_mem >> 20);

Why would the CEL be based on memory size?

> +            goto start_bg;
> +            break;
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +    }
> +    return CXL_MBOX_UNSUPPORTED;
> +
> +start_bg:
> +    cci->bg.runtime = secs * 1000UL;
> +    *len_out = 0;
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
> +static void __do_populate(CXLCCI *cci)
> +{
> +    switch (cci->log) {
> +    case CEL:
> +        cxl_rebuild_cel(cci);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -2918,6 +3007,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>                                       cmd_logs_get_log_capabilities, 0x10, 0 },
>      [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
>                            CXL_MBOX_IMMEDIATE_LOG_CHANGE},
> +    [LOGS][POPULATE_LOG] = { "LOGS_POPULATE_LOG", cmd_logs_populate_log, 0x10,
> +                             (CXL_MBOX_IMMEDIATE_LOG_CHANGE |
> +                              CXL_MBOX_BACKGROUND_OPERATION)},
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> @@ -3098,6 +3190,9 @@ static void bg_timercb(void *opaque)
>          case 0x0201: /* fw transfer */
>              __do_firmware_xfer(cci);
>              break;
> +        case 0x0404: /* populate_ log */
> +            __do_populate(cci);
> +            break;
>          case 0x4400: /* sanitize */
>          {
>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index e7cb99a1d2..d90d0d4a8f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -230,6 +230,8 @@ typedef struct CXLCCI {
>      } cel_log[1 << 16];
>      size_t cel_size;
>  
> +    enum Logs log;
> +
>      /* get log capabilities */
>      CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
>  



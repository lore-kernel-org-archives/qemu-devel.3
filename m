Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDC1C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGAQ-0007Yk-G2; Tue, 04 Feb 2025 05:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfGAO-0007YD-MM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:28:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfGAM-0000I5-5X
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:28:28 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnKJW4srLz6L50m;
 Tue,  4 Feb 2025 18:25:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 84BAC140442;
 Tue,  4 Feb 2025 18:28:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 11:28:21 +0100
Date: Tue, 4 Feb 2025 10:28:20 +0000
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250204102820.000047fb@huawei.com>
In-Reply-To: <20250203055950.2126627-2-arpit1.kumar@samsung.com>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>
 <20250203055950.2126627-2-arpit1.kumar@samsung.com>
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

On Mon,  3 Feb 2025 11:29:48 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

Please add some descriptive teext here.

> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Hi Arpit,

Whilst it is good to do internal reviews, I'd prefer to see feedback
on the mailing list if possible.  Hard for a maintainer to tell
what a RB tag given before posting means unfortunately so in most
cases preference is to not add RB tags based on internal review.
If your colleagues have greatly affected the code, a
Co-developed-by: and additional sign off may be a good way to
reflect that.

Great to have you working on these features. Some comments inline.
Main ones are around naming (always tricky!) and suggestion to
handle the arrays of log capabilities as static const pointers.

Thanks,

Jonathan


> ---
>  hw/cxl/cxl-mailbox-utils.c   | 55 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h  | 31 ++++++++++++++++++++
>  include/hw/cxl/cxl_mailbox.h |  5 ++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..3d66a425a9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -76,6 +76,7 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1075,6 +1076,45 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static int32_t valid_log_check(QemuUUID *uuid, CXLCCI *cci)

Perhaps find_log_index() or something like that?
I would return &ccx->supported_log_cap[i] / NULL if not found
as then can avoid long reference into array below.

> +{
> +    int32_t id = -1;
> +    for (int i = CEL; i < MAX_LOG_TYPE; i++) {
> +        if (qemu_uuid_is_equal(uuid,
> +            &cci->supported_log_cap[i].uuid)) {
> +            id = i;
> +            break;
> +        }
> +    }
> +    return id;
> +}
> +
> +/* CXL r3.1 Section 8.2.9.5.3: Get Log Capabilities (Opcode 0402h) */

For new documentation please use latest spec.
This is a bit different to many other spec where the request is the
earliest one. That is due to the consortium only making the latest
version available (currently r3.2)

> +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    int32_t cap_id;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) * get_log_capabilities_in = (void *)payload_in;
> +
> +    CXLParamFlags *get_log_capabilities_out = (void *)payload_out;
> +
> +    cap_id = valid_log_check(&get_log_capabilities_in->uuid, cci);
    CXLLogCapabilities *cap;

    cap = find_log_cap(&get_log_capabilities_in->uuid, cci);
    if (!cap) {
        return CXL_MBOX_INVALID_LOG);
    }

    mempcy(get_log_capabilities_out, cap->param_flags.pflags,
           sizeof(cap->param_flags.pflags));
...

> +    if (cap_id == -1) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
> +    memcpy(get_log_capabilities_out, &cci->supported_log_cap[cap_id].param_flags.pflags,
> +           sizeof(CXLParamFlags));
> +    *len_out = sizeof(*get_log_capabilities_out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -2840,6 +2880,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
> +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> @@ -3084,10 +3126,23 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>      }
>  }
>  
> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> +    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
> +             .uuid = cel_uuid},
> +};
> +
> +static void cxl_init_get_log(CXLCCI *cci)
> +{
> +    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
> +        cci->supported_log_cap[set] = cxl_get_log_cap[set];

As below. Can we just use a static const pointer in cci?
Seems relatively unlikely we'll have lots of different log combinations
depending on runtime configuration.  So may be better to just pick
between a few const arrays like cxl_get_log_cap.

Good to also store the length of that log or use a terminating entry
of some type so that we don't need to iterate over empty entries.

> +    }
> +}
> +
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  {
>      cci->payload_max = payload_max;
>      cxl_rebuild_cel(cci);
> +    cxl_init_get_log(cci);
>  
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..e7cb99a1d2 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -164,6 +164,18 @@ typedef enum {
>      CXL_MBOX_MAX = 0x20
>  } CXLRetCode;
>  
> +/* types of logs */
> +enum Logs {

For things in the header please prefix with CXL.  The chances
of a naming clash in future drivers that include this is too high
without that! 

Also QEMU tends to use typedefs for enums

typedef enum {
	CXL_LOG_CEL,
	CXL_LOG_VENDOR,
} CXLLogType;
or something like that.

Some of these abbreviations are a bit too compact and
don't line up with spec like CEL does.,




> +    CEL,
> +    VDL,
> +    CSDL,
CXL_LOG_COMPONENT_STATE_DUMP,
> +    ECSL,
CXL_LOG_ECS, //this one is standard acronym
> +    MTCL,
CXL_LOG_MEDIA_TEST_CAP
> +    MTRSL,
CXL_LOG_MEDIA_TEST_SHORT
> +    MTRLL,
CXL_LOG_MEDIA_TEST_LONG

perhaps?
> +    MAX_LOG_TYPE
> +};
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -194,6 +206,22 @@ typedef struct CXLEventLog {
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
>  
> +typedef struct CXLParamFlags {
> +    union {

Unless I'm reading this wrong this is a union of lots of flags
on top of each other.

Also, don't use bitfields. They don't play well with
different endian architectures. 
Defines for the various bits are a more reliable solution.
Similar to the ones you have below in cxl_mailbox.h


> +        uint32_t clear_log_supported:1;
> +        uint32_t populate_log_supported:1;
> +        uint32_t auto_populate_supported:1;
> +        uint32_t persistent_across_cold_reset:1;
> +        uint32_t reserved:28;
> +        uint32_t pflags;
> +    };
> +} CXLParamFlags;
> +
> +typedef struct CXLLogCapabilities {
> +    CXLParamFlags param_flags;
> +    QemuUUID uuid;
> +} CXLLogCapabilities;
> +
>  typedef struct CXLCCI {
>      struct cxl_cmd cxl_cmd_set[256][256];
>      struct cel_log {
> @@ -202,6 +230,9 @@ typedef struct CXLCCI {
>      } cel_log[1 << 16];
>      size_t cel_size;
>  
> +    /* get log capabilities */
> +    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
Perhaps a const pointer is appropriate?
> +
>      /* background command handling (times in ms) */
>      struct {
>          uint16_t opcode;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..f3502c3f68 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -16,4 +16,9 @@
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>  
> +#define CXL_LOG_CAP_CLEAR 1
> +#define CXL_LOG_CAP_POPULATE (1 << 1)
> +#define CXL_LOG_CAP_AUTO_POPULATE (1 << 2)
> +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET (1 << 3)
> +
>  #endif



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8901C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tizjZ-0004Wy-UP; Fri, 14 Feb 2025 12:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tizjV-0004Wc-C7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:44:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tizjR-0005rp-Hz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:44:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvfTy4lxNz6L531;
 Sat, 15 Feb 2025 01:40:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C4DC31402CB;
 Sat, 15 Feb 2025 01:44:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 18:44:01 +0100
Date: Fri, 14 Feb 2025 17:43:59 +0000
To: Sweta Kumari <s5.kumari@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v2] CXL CCI Get/Set Alert Configuration commands
 implmented as per CXL Specification 3.2 section 8.2.10.9.3
Message-ID: <20250214174359.0000368a@huawei.com>
In-Reply-To: <20250214132211.528019-1-s5.kumari@samsung.com>
References: <CGME20250214132317epcas5p3732f86a4aa3cee5c396e18c2bf98a82b@epcas5p3.samsung.com>
 <20250214132211.528019-1-s5.kumari@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 14 Feb 2025 18:52:11 +0530
Sweta Kumari <s5.kumari@samsung.com> wrote:

> 1)get alert configuration(Opcode 4201h)
> 2)set alert configuration(Opcode 4202h)

Move the change log to below the ---
The key thing being git then doesn't pick it up whilst applying the patch.
Whilst changed logs are very useful during the review process we don't
typically want to keep them in the git history for ever!

Otherwise, main comment here is shorten more names.

Jonathan

> 
> This v2 patch addresses the feedback from the v1 patch and include some minor new changes.
> 
> Changes in V2:
> - Removed cover letter as it's a single patch
> - Added latest spec reference
> - Fixed alignment issues
> - Updated shorter variable names to be more descriptive
> - Replaced field-by-field initialization in 'init_alert_config' with structured initialization for improved readability.
> - Replaced bit fields with 'uint8_t' and added defines for individual bits.
> 
> The patch is generated against the Johnathan's tree
> https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.
> 
> Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 116 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  16 +++++
>  include/hw/cxl/cxl_device.h |  15 +++++
>  3 files changed, 147 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..105c63fdec 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -28,6 +28,11 @@
>  #define CXL_DC_EVENT_LOG_SIZE 8
>  #define CXL_NUM_EXTENTS_SUPPORTED 512
>  #define CXL_NUM_TAGS_SUPPORTED 0
> +#define CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD (1 << 0)
> +#define CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD (1 << 1)
> +#define CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD (1 << 2)
> +#define CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD (1 << 3)
> +#define CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD (1 << 4)
Let's shorten these as they are very ugly to use when a line long!

#define CXL_ALERTS_OVER_TEMP_WARN_THRESH
etc. Similar to comments below.

>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -86,6 +91,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIGURATION 0x1
> +        #define SET_ALERT_CONFIGURATION 0x2
CONFIG maybe enough?

>      SANITIZE    = 0x44,
>          #define OVERWRITE     0x0
>          #define SECURE_ERASE  0x1
> @@ -1625,6 +1633,110 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 Section 8.2.10.9.3.2 Get Alert Configuration (Opcode 4201h) */
> +static CXLRetCode cmd_get_alert_config(const struct cxl_cmd *cmd,
> +                                       uint8_t *payload_in,
> +                                       size_t len_in,
> +                                       uint8_t *payload_out,
> +                                       size_t *len_out,
> +                                       CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *out = (void *)payload_out;

In this case we can cast to the right type (can't do that if we don't
name that type which happens in a lot these structures). So prefer
    CXLAlertConfig *out = (CXLAlertConfig *)payload_out;
 

> +
> +    memcpy(out, &ct3d->alert_config, sizeof(ct3d->alert_config));
> +    *len_out = sizeof(ct3d->alert_config);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.2 Section 8.2.10.9.3.3 Set Alert Configuration (Opcode 4202h) */
> +static CXLRetCode cmd_set_alert_config(const struct cxl_cmd *cmd,
> +                                       uint8_t *payload_in,
> +                                       size_t len_in,
> +                                       uint8_t *payload_out,
> +                                       size_t *len_out,
> +                                       CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLAlertConfig *alert_config = &ct3d->alert_config;
> +    struct {
> +        uint8_t valid_alert_actions;
> +        uint8_t enable_alert_actions;
> +        uint8_t life_used_warning_threshold;
> +        uint8_t rsvd;
> +        uint16_t device_over_temperature_warning_threshold;
> +        uint16_t device_under_temperature_warning_threshold;
> +        uint16_t Corrected_volatile_memory_error_warning_threshold;
> +        uint16_t Corrected_persistent_memory_error_warning_threshold;

Shorten these as well. Similar to suggestions below.  They are
just too long to make for nice code!

> +    } QEMU_PACKED *in = (void *)payload_in;
> +
> +    if (in->valid_alert_actions & CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD) {
> +        /*
> +         * CXL 3.2 Table 8-149 The life used warning threshold shall be
> +         * less than the life used critical alert value.
> +         */
> +        if (in->life_used_warning_threshold >=
> +            alert_config->life_used_critical_alert_threshold) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        alert_config->life_used_warning_threshold =
> +            in->life_used_warning_threshold;
> +        alert_config->enable_alerts |= CXL_ALERTS_LIFE_USED_WARNING_THRESHOLD;
> +    }
> +
> +    if (in->valid_alert_actions &
> +        CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD) {
> +        /*
> +         * CXL 3.2 Table 8-149 The Device Over-Temperature Warning Threshold
> +         * shall be less than the the Device Over-Temperature Critical
> +         * Alert Threshold.
> +         */
> +        if (in->device_over_temperature_warning_threshold >=
> +            alert_config->device_over_temperature_critical_alert_threshold) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        alert_config->device_over_temperature_warning_threshold =
> +            in->device_over_temperature_warning_threshold;
> +        alert_config->enable_alerts |=
> +            CXL_ALERTS_DEVICE_OVER_TEMP_WARNING_THRESHOLD;
> +    }
> +
> +    if (in->valid_alert_actions &
> +        CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD) {
> +        /*
> +         * CXL 3.2 Table 8-149 The Device Under-Temperature Warning Threshold
> +         * shall be higher than the the Device Under-Temperature Critical
> +         * Alert Threshold.
> +         */
> +        if (in->device_under_temperature_warning_threshold <=
> +            alert_config->device_under_temperature_critical_alert_threshold) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        alert_config->device_under_temperature_warning_threshold =
> +            in->device_under_temperature_warning_threshold;
> +        alert_config->enable_alerts |=
> +            CXL_ALERTS_DEVICE_UNDER_TEMP_WARNING_THRESHOLD;
> +    }
> +
> +    if (in->valid_alert_actions &
> +        CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD) {
> +        alert_config->Corrected_volatile_memory_error_warning_threshold =
> +            in->Corrected_volatile_memory_error_warning_threshold;
> +        alert_config->enable_alerts |=
> +            CXL_ALERTS_CORRECTED_VOLATILE_MEMORY_ERROR_WARNING_THRESHOLD;
> +    }
> +
> +    if (in->valid_alert_actions &
> +        CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD) {
> +        alert_config->Corrected_persistent_memory_error_warning_threshold =
> +            in->Corrected_persistent_memory_error_warning_threshold;
> +        alert_config->enable_alerts |=
> +            CXL_ALERTS_CORRECTED_PERSISTENT_MEMORY_ERROR_WARNING_THRESHOLD;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* Perform the actual device zeroing */
>  static void __do_sanitization(CXLType3Dev *ct3d)
>  {
> @@ -2859,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
> +    [HEALTH_INFO_ALERTS][GET_ALERT_CONFIGURATION] = {"GET_ALERT_CONFIGURATION",

Space after { to match local style.

> +        cmd_get_alert_config, 0, 0 },
> +    [HEALTH_INFO_ALERTS][SET_ALERT_CONFIGURATION] = {"SET_ALERT_CONFIGURATION",
> +        cmd_set_alert_config, 12, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
>          (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>           CXL_MBOX_SECURITY_STATE_CHANGE |

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25..1da23bf553 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -581,6 +581,19 @@ typedef struct CXLSetFeatureInfo {
>      size_t data_size;
>  } CXLSetFeatureInfo;
>  
> +typedef struct CXLAlertConfig {
> +    uint8_t valid_alerts;
> +    uint8_t enable_alerts;
> +    uint8_t life_used_critical_alert_threshold;
> +    uint8_t life_used_warning_threshold;
> +    uint16_t device_over_temperature_critical_alert_threshold;
I think we can shorten these at least a bit without lost of meaning!
It's on a device so can drop that entirely. Perhaps

    uint8_t life_used_crit_alert_thresh;
    uint8_t life_used_warn_thresh;
    uint16_t over_temp_crit_alert_thresh;
    uint16_t under_temp_crit_alert_thresh;
    uint16_t over_temp_warn_thresh;
    uint16_t under_temp_warn_thresh;
    uint16_t cor_volatile_mem_err_warn_thresh;
    uint16_t cor_persistent_mem_err_warn_thresh;

> +    uint16_t device_under_temperature_critical_alert_threshold;
> +    uint16_t device_over_temperature_warning_threshold;
> +    uint16_t device_under_temperature_warning_threshold;
> +    uint16_t Corrected_volatile_memory_error_warning_threshold;
Capital in just this one doesn't make much sense.
> +    uint16_t Corrected_persistent_memory_error_warning_threshold;
> +} QEMU_PACKED CXLAlertConfig;




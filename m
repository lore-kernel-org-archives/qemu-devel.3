Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EE4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlj-0003sa-9J; Mon, 12 May 2025 04:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEOkK-0002TG-74
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEOkH-0001sc-JA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747039364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6ohPqMOJcmTNEQKajOFANKaCxzi/ZzXJ8BO28MUwXQ=;
 b=NGgt0BHvhSW8RaU+9wx8BJSQwsBcM53NMRLliHwY2aEeEG6qrybF/SscoqZmgrgzDhERNO
 4ReSAfITigYh6vI/j0hSpWtU1SJb5lDCy9KcFXgZSKL/298Km4kZcEKzZq6Q235tcGqdZi
 PA+NesmtFYD4FiBKeB/YcRShETh/hwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-y_ORvoJRMuOrAeC_MrkJNg-1; Mon, 12 May 2025 04:42:43 -0400
X-MC-Unique: y_ORvoJRMuOrAeC_MrkJNg-1
X-Mimecast-MFC-AGG-ID: y_ORvoJRMuOrAeC_MrkJNg_1747039362
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so20420165e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039361; x=1747644161;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b6ohPqMOJcmTNEQKajOFANKaCxzi/ZzXJ8BO28MUwXQ=;
 b=aYNRbfHehUk8rBdzC0gMN7Foup7FGNV5JhJJavqZUSgRPv01sKfR8w24QPaiHWAuZ0
 6pXyj217MPikecITq4dYLH333/6Epqjj+T7bOIepIqaSPcMlrpg2Rkwrslw8qvlfkQNX
 dIQLBuHKkYdv+i2tYqDIZFD4wNOEUR4jXu/nTgZnd5ynOz3nwPpT2EvWAkQ/LarYb1cS
 nmRf0KLVIB4k+2ahW61zB7o81Vpo+2dh8fIzZ40WYsh4/A8O43cnRiiUMs0sjQcmXfGB
 SrUaZ/mxfIyWFduGeKN2B34T09MZSLrfCb/Mi6PGPT1+uUiXS0xSUVcI4qH1usyRnH6T
 WKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaa0Kx4VsbscNIu7GrLxasw0INvz3JfLHgYbnj0w+Ze6dkhJanGq8FB7aj6Q3hFY1n/+MIFt8AKYwi@nongnu.org
X-Gm-Message-State: AOJu0YxMc5q5BmgGqB4w2lnK1urOkc89rbcxfUiKME4MQACSpXbAIfpW
 5wxtxyAu25lCV0inVLprzXmIMbG4CK2AwOGrR0C0T8/aEAz2KRiBV6hswcg6Ce5GrUL3tq13c75
 BruN+Q705U/DvI4osm0K0TYTnXLCEQXenC+kNr9+o3aW1FKOopUU4P/c/0DNo
X-Gm-Gg: ASbGncv7jpy6eK560/SFMuHHt1nOQ8hgdrkdX9fJrKkr4GeQ3NFdU4bKdcmyIgZHFxm
 LbDsqrx1iOYAL5VSSr98Vfz1Zk2qXFIDdeiZMF5L4A1DuUlw5sKI0qiSTXu3UOH19WDBltwFVu2
 NaiunEE4TWVU8z738wTIwaMhL/GxFuPIDkwVwvoxH9MxIfc6jyLZxfAoQNEpqFe7G1aH6N/Z187
 VJpb+ZAgKb0J8+/O2B11PBdPD7Iu9jUMBJz/6ZRUESe3WYJj/W6e2Hj7tGhgCK4YQwJhxJK5wmM
 HAi3zg==
X-Received: by 2002:a05:600c:6612:b0:43d:36c:f24 with SMTP id
 5b1f17b1804b1-442d6d44830mr105920965e9.13.1747039361499; 
 Mon, 12 May 2025 01:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrFFICCMjlfgRZPh+HswsHits6mww/NovwFZZRp4J19jWEWy4aqUMXbOv5GZaynkA7NY+h+Q==
X-Received: by 2002:a05:600c:6612:b0:43d:36c:f24 with SMTP id
 5b1f17b1804b1-442d6d44830mr105920555e9.13.1747039361024; 
 Mon, 12 May 2025 01:42:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c2asm118205725e9.1.2025.05.12.01.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 01:42:40 -0700 (PDT)
Date: Mon, 12 May 2025 04:42:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, linuxarm@huawei.com,
 fan.ni@samsung.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>,
 Vinayak Holikatti <vinayak.kh@samsung.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250512043011-mutt-send-email-mst@kernel.org>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
 <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
> From: Arpit Kumar <arpit1.kumar@samsung.com>
> 
> CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> It provides log capabilities supported by specified log.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
>  include/hw/cxl/cxl_mailbox.h |  5 ++++
>  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed6cd50c67..87a376c982 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -133,6 +133,18 @@ typedef enum {
>      CXL_MBOX_MAX = 0x20
>  } CXLRetCode;
>  
> +/* types of logs */
> +typedef enum {
> +    CXL_LOG_COMMAND_EFFECT,
> +    CXL_LOG_VENDOR_DEBUG,
> +    CXL_LOG_COMPONENT_STATE_DUMP,
> +    CXL_LOG_ERROR_CHECK_SCRUB,
> +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> +    MAX_LOG_TYPE
> +} CXLLogType;
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
>      QSIMPLEQ_HEAD(, CXLEvent) events;
>  } CXLEventLog;
>  
> +typedef struct CXLLogCapabilities {
> +    uint32_t param_flags;
> +    QemuUUID uuid;
> +} CXLLogCapabilities;
> +
>  typedef struct CXLCCI {
>      struct cxl_cmd cxl_cmd_set[256][256];
>      struct cel_log {
> @@ -171,6 +188,9 @@ typedef struct CXLCCI {
>      } cel_log[1 << 16];
>      size_t cel_size;
>  
> +    /* get log capabilities */
> +    const CXLLogCapabilities *supported_log_cap;
> +
>      /* background command handling (times in ms) */
>      struct {
>          uint16_t opcode;
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..8e1c7c5f15 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -16,4 +16,9 @@
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>  
> +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> +
>  #endif
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 299f232f26..f35fc4f112 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,7 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
> +{
> +    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
> +        if (qemu_uuid_is_equal(uuid,
> +            &cci->supported_log_cap[i].uuid)) {
> +                return &cci->supported_log_cap[i];
> +        }
> +    }
> +    return NULL;
> +}
> +
> +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
> +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    const CXLLogCapabilities *cap;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
> +
> +    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
> +
> +    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
> +    if (!cap) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
> +    memcpy(get_log_capabilities_out, &cap->param_flags,
> +           sizeof(cap->param_flags));
> +    *len_out = sizeof(*get_log_capabilities_out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
> +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>      }
>  }
>  
> +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
> +};
> +


causes ci build failures:

https://gitlab.com/mstredhat/qemu/-/jobs/9999980051

../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not constant
     [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
                                                            ^~~~~~~~
../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for ‘cxl_get_log_cap[0].uuid’)


Fixed it up like this:

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f35fc4f112..13d26e391b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
 }
 
 /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
-static const QemuUUID cel_uuid = {
-    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
+#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
                  0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
+static const QemuUUID cel_uuid = {
+    .data = CEL_UUID
 };
 
 /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
@@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
 }
 
 static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
-    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
+    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = CEL_UUID },
 };
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)


>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  {
>      cci->payload_max = payload_max;
>      cxl_rebuild_cel(cci);
> +    cci->supported_log_cap = cxl_get_log_cap;
>  
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
> -- 
> 2.43.0



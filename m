Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007FCC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAe-0003o4-5a; Tue, 08 Jul 2025 16:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDmB-0003Mk-QZ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:52 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.milosevic@9elements.com>)
 id 1uZDm0-0006eO-NM
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:44 -0400
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so922815166b.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1752002013; x=1752606813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrgt4ES6n88SrJJVBc5jpMxbkw/Ck0SwU3aY5MiKzdI=;
 b=NLsk7qetdgR90RFLhx9QZ5QlkWhElp29OtfjqQSsEPyy96NmoYR1a0ZKemsGQ2El4M
 K2O2omtPtc+6Z/Q5jxK2r2UQYqDZu3JmPyLYYs5QEbsJ1V6u0JMw+pj24z5HVw/sFTNw
 CJJt3jvbUayNEbEoxc7hC3M+CySeLLy0Zzkr01rzParvG3YxqBt1i0TL+3xT7e7XAQ6/
 9moZDAw5KsY4L68m1bhz7MAgfZne4bumqorgOa63NEnbyzfXSY27E5wJit909vwlpUSa
 nKVC6MaFfz5R3xvJglnMHoqKY1MlBNJVoiNMxdThIKZzyub3/VYvZvQhda4p/RtQzpfq
 4XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002013; x=1752606813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrgt4ES6n88SrJJVBc5jpMxbkw/Ck0SwU3aY5MiKzdI=;
 b=Ho83i8uj3LpqvmgfLiidN3kiGwM0mlGf4z/CJ5W/lUaZ89JKi1J+BaVDLkslAwT45y
 wmUsf8tG5VJk286zVne/r2H0FcwHOYIDmQo06R9PE3RvDyR0OnDCB8GJAS4Xb4UwzXLr
 UsT112mysm7z4qu34G6kLadUMyJso23mvUFEncQX4lRN1jrdA93WM3hOU3rQbca+3rwF
 XKvZKARsCIm10DO9TERh7Qd++wzJ8tocjs1lju2uIoYRjPV+D9n7Fr93wfKQAK07I/au
 W9K4rhvN0VSlxE6JMuy+hZvYtaUwf8vNxAG4FFCudty/qGZr9a9AKv5yareVTLWaH99Y
 sd1g==
X-Gm-Message-State: AOJu0Ywu1yI2ApTLlA/hTiZSoiNN2pScvpA3SQQpy+yGt6xLhHpwK9nb
 3gY+5076aENBhBLPzv6HylgpKrrSDkcZqfssHA9a3J5JEnfuyzNAXmGiSPlm4vjClrmHpCwn5mZ
 U0BMEaqoXU50A5kE=
X-Gm-Gg: ASbGncubG9yWEhpMPeHQdzUKXLlJWAKcWIX3FE/NIWGuR6Gf6kMX9qfdclMu4dGxaQQ
 lo40bFRtP1VtOhC/aDA707UrWhIvNbd5FB6KwxdEt4rAT+dcNoAOgeqCioVBTOJI+ESwg6FIkqE
 uWwvbjb9a/nnUYh8Qv0wYluPu3J+Aop100zGQnS7TkprygXNiVcJI/l6R9RrGnv2xFe6IQCV3Mv
 ndlXrrWM50ELD2GiOUweRSC7qlwm1t25KTwEnxcnssAkllsY62YrwJZlCSmexq+lU1MQkhNKOtK
 SAy7ZBNeRPTfya9mVuevfcG6hGzcnWq6kWa4l8nMI3u0vE2+URGHdAkeAh9bF7HSBzafg5ATFDd
 178I0hcpTl0YHP/blbGqeAhn4w5Xsk0scLR+kIIhYU/dyr16m6qDy
X-Google-Smtp-Source: AGHT+IEBbXjaAVezQk+mS+iX8eoHdgrjOom+qmxeUbBAY+uAp+Q2v6OnyOrEyiIQFRS997815/5lgA==
X-Received: by 2002:a05:600c:a00e:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-454cd4baeb6mr34036405e9.7.1751986712544; 
 Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
Received: from cbox.sec.9e.network
 (p200300f75f10f341000000000000002d.dip0.t-ipconnect.de.
 [2003:f7:5f10:f341::2d]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2749sm25445735e9.25.2025.07.08.07.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
From: David Milosevic <david.milosevic@9elements.com>
X-Google-Original-From: David Milosevic <David.Milosevic@9elements.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pizhenwei@bytedance.com, marcello.bauer@9elements.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Milosevic <David.Milosevic@9elements.com>
Subject: [PATCH 1/3] video: introduce video subsystem with inital v4l2 backend
Date: Tue,  8 Jul 2025 16:56:48 +0200
Message-ID: <20250708145828.63295-2-David.Milosevic@9elements.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250708145828.63295-1-David.Milosevic@9elements.com>
References: <20250708145828.63295-1-David.Milosevic@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=david.milosevic@9elements.com; helo=mail-ej1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This commit introduces a new video subsystem to QEMU. It provides
the foundation for emulated video devices with support for multiple
host backends.

The first supported backend is video4linux (v4l2), allowing video
devices such as /dev/video0 to be exposed to guest operating systems
via emulated USB Video Class (UVC) devices.

Example usage:
  qemu-system-x86_64 \
    -device qemu-xhci \
    -videodev v4l2,id=cam0,device=/dev/video0 \
    -device usb-video,videodev=cam0

With this commit, we lay the groundwork for further backend support
(e.g. GStreamer, libcamera) and future device types (e.g. virtio-video).

It is worth mentioning, that this patch incorporates and builds upon
earlier work by Zhenwei Pi on video device emulation in QEMU.

Previous RFC:
https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg02804.html

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: David Milosevic <David.Milosevic@9elements.com>
---
 hw/core/qdev-properties-system.c    |   52 ++
 hw/usb/Kconfig                      |    5 +
 hw/usb/dev-video.c                  | 1333 +++++++++++++++++++++++++++
 hw/usb/meson.build                  |    1 +
 hw/usb/trace-events                 |   10 +
 include/hw/qdev-properties-system.h |    4 +
 include/hw/usb.h                    |    2 +
 include/hw/usb/video.h              |  322 +++++++
 meson.build                         |   20 +
 meson_options.txt                   |    3 +
 qemu-options.hx                     |    6 +
 scripts/meson-buildoptions.sh       |    3 +
 system/vl.c                         |   39 +-
 video/meson.build                   |   21 +
 video/v4l2.c                        |  619 +++++++++++++
 video/video.c                       |  450 +++++++++
 video/video.h                       |  298 ++++++
 17 files changed, 3187 insertions(+), 1 deletion(-)
 create mode 100644 hw/usb/dev-video.c
 create mode 100644 include/hw/usb/video.h
 create mode 100644 video/meson.build
 create mode 100644 video/v4l2.c
 create mode 100644 video/video.c
 create mode 100644 video/video.h

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 24e145d870..26a25d2672 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -36,6 +36,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/i386/x86.h"
 #include "util/block-helpers.h"
+#include "video/video.h"
 
 static bool check_prop_still_unset(Object *obj, const char *name,
                                    const void *old_val, const char *new_val,
@@ -1299,3 +1300,54 @@ const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
+
+/* --- videodev --- */
+
+static void get_videodev(Object *obj, Visitor *v, const char* name,
+                         void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    Videodev *video = object_field_prop_ptr(obj, prop);
+    char *p = g_strdup(qemu_videodev_get_id(video));
+
+    visit_type_str(v, name, &p, errp);
+    g_free(p);
+}
+
+static void set_videodev(Object *obj, Visitor *v, const char* name,
+                         void *opaque, Error **errp)
+{
+    Property *prop = opaque;
+    void **ptr = object_field_prop_ptr(obj, prop);
+    Error *local_err = NULL;
+    g_autofree char *str = NULL;
+    Videodev *video;
+
+    if (!visit_type_str(v, name, &str, &local_err)) {
+        goto error;
+    }
+
+    video = qemu_videodev_by_id(str, &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    qemu_videodev_register(video, &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    *ptr = video;
+    return;
+
+error:
+    error_propagate(errp, local_err);
+}
+
+const PropertyInfo qdev_prop_videodev = {
+    .type = "str",
+    .description = "ID of an videodev to use as a backend",
+    /* release done on shutdown */
+    .get = get_videodev,
+    .set = set_videodev,
+};
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 69c663be52..6652b646cb 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -147,3 +147,8 @@ config XLNX_USB_SUBSYS
 config USB_CHIPIDEA
     bool
     select USB_EHCI_SYSBUS
+
+config USB_VIDEO
+    bool
+    default y
+    depends on USB
diff --git a/hw/usb/dev-video.c b/hw/usb/dev-video.c
new file mode 100644
index 0000000000..19c66b609c
--- /dev/null
+++ b/hw/usb/dev-video.c
@@ -0,0 +1,1333 @@
+/*
+ * UVC Device emulation, base on UVC specification 1.5
+ *
+ * Copyright 2025 9elements GmbH
+ * Copyright 2021 Bytedance, Inc.
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *   zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/usb.h"
+#include "hw/usb/video.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "video/video.h"
+
+#include "desc.h"
+#include "trace.h"
+
+typedef enum AttributeIndex {
+    ATTRIBUTE_DEF,
+    ATTRIBUTE_MIN,
+    ATTRIBUTE_MAX,
+    ATTRIBUTE_CUR,
+    ATTRIBUTE_RES,
+    ATTRIBUTE_ALL
+} AttributeIndex;
+
+enum video_desc_iface_idx {
+    VC = 0,
+    VS0,
+    VS1,
+    USB_VIDEO_IFACE_COUNT
+};
+
+typedef struct USBVideoControlStats {
+    VideoControlStatus status;
+    uint8_t size; /* value size in bytes */
+    QTAILQ_ENTRY(USBVideoControlStats) list;
+} USBVideoControlStats;
+
+typedef struct USBVideoControlInfo {
+    uint8_t selector;
+    uint8_t caps;
+    uint8_t size;
+    uint32_t value[ATTRIBUTE_ALL]; /* stored in le32 */
+} USBVideoControlInfo;
+
+struct USBVideoState {
+    /* qemu interfaces */
+    USBDevice dev;
+    Videodev *video;
+
+    /* UVC control */
+    int altset;
+    bool fid;
+    uint8_t error;
+    uint8_t streaming_error;
+    USBVideoControlInfo pu_attrs[PU_MAX];
+    QTAILQ_HEAD(, USBVideoControlStats) control_status;
+
+    /* video streaming control */
+    uint8_t vsc_info;
+    uint16_t vsc_len;
+    VideoStreamingControl vsc_attrs[ATTRIBUTE_ALL];
+};
+
+#define TYPE_USB_VIDEO "usb-video"
+OBJECT_DECLARE_SIMPLE_TYPE(USBVideoState, USB_VIDEO)
+
+#define USBVIDEO_VENDOR_NUM     0x46f4 /* CRC16() of "QEMU" */
+#define USBVIDEO_PRODUCT_NUM    0x0001
+
+/* Interface IDs */
+#define IF_CONTROL   0x0
+#define IF_STREAMING 0x1
+
+/* Endpoint IDs */
+#define EP_CONTROL   0x1
+#define EP_STREAMING 0x2
+
+/* Terminal and Unit IDs */
+#define INPUT_TERMINAL  0x1
+#define OUTPUT_TERMINAL 0x2
+
+/* Alternate Settings */
+#define ALTSET_OFF       0x0
+#define ALTSET_STREAMING 0x1
+
+/* XU IDs */
+#define SELECTOR_UNIT   0x4
+#define PROCESSING_UNIT 0x5
+#define ENCODING_UNIT   0x6
+
+#define U16(x) ((x) & 0xff), (((x) >> 8) & 0xff)
+#define U24(x) U16(x), (((x) >> 16) & 0xff)
+#define U32(x) U24(x), (((x) >> 24) & 0xff)
+#define DELTA_ABS(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
+
+enum usb_video_strings {
+    STR_NULL,
+    STR_MANUFACTURER,
+    STR_PRODUCT,
+    STR_SERIALNUMBER,
+    STR_CONFIG,
+    STR_INTERFACE_ASSOCIATION,
+    STR_VIDEO_CONTROL,
+    STR_INPUT_TERMINAL,
+    STR_SELECTOR_UNIT,
+    STR_PROCESSING_UNIT,
+    STR_OUTPUT_TERMINAL,
+    STR_VIDEO_STREAMING,
+    STR_VIDEO_STREAMING_ALTERNATE1,
+};
+
+static const USBDescStrings usb_video_stringtable = {
+    [STR_MANUFACTURER]               = "QEMU",
+    [STR_PRODUCT]                    = "QEMU USB Video",
+    [STR_SERIALNUMBER]               = "1",
+    [STR_CONFIG]                     = "Video Configuration",
+    [STR_INTERFACE_ASSOCIATION]      = "Integrated Camera",
+    [STR_VIDEO_CONTROL]              = "Video Control",
+    [STR_INPUT_TERMINAL]             = "Video Input Terminal",
+    [STR_SELECTOR_UNIT]              = "Video Selector Unit",
+    [STR_PROCESSING_UNIT]            = "Video Processing Unit",
+    [STR_OUTPUT_TERMINAL]            = "Video Output Terminal",
+    [STR_VIDEO_STREAMING]            = "Video Streaming",
+    [STR_VIDEO_STREAMING_ALTERNATE1] = "Video Streaming Alternate Setting 1",
+};
+
+static AttributeIndex req_to_attr(uint8_t req)
+{
+    switch (req) {
+    case SET_CUR:
+    case GET_CUR:
+        return ATTRIBUTE_CUR;
+    case GET_MIN:
+        return ATTRIBUTE_MIN;
+    case GET_MAX:
+        return ATTRIBUTE_MAX;
+    case GET_RES:
+        return ATTRIBUTE_RES;
+    case GET_DEF:
+        return ATTRIBUTE_DEF;
+    default:
+        break;
+    }
+
+    return -1;
+}
+
+static inline uint32_t frmrt_to_frmival(VideoFramerate *frmrt)
+{
+    return (10000000 * frmrt->numerator) / frmrt->denominator;
+}
+
+static int handle_get_control(USBVideoControlInfo *ctrl_info, uint8_t req, int length, uint8_t* data)
+{
+    int len;
+    AttributeIndex idx;
+
+    if (!ctrl_info->selector) {
+        return 0;
+    }
+
+    if ((req == GET_INFO) && (length >= 1)) {
+
+        *((uint8_t*) data) = ctrl_info->caps;
+        return 1;
+    }
+
+    if ((req == GET_LEN) && (length >= 2)) {
+
+        *((uint16_t*) data) = cpu_to_le16(ctrl_info->size);
+        return 2;
+    }
+
+    if ((idx = req_to_attr(req)) >= 0) {
+
+        len = MIN(length, ctrl_info->size);
+        memcpy(data, &ctrl_info->value[idx], len);
+        return len;
+    }
+
+    return 0;
+}
+
+static int handle_get_streaming(USBVideoState *s, uint8_t req, int length, uint8_t *data)
+{
+    AttributeIndex idx;
+    int len = MIN(length, sizeof(s->vsc_attrs[0]));
+
+    if ((req == GET_INFO) && (length >= 1)) {
+
+        *((uint8_t*) data) = s->vsc_len;
+        return 1;
+    }
+
+    if ((req == GET_LEN) && (length >= 2)) {
+
+        *((uint16_t*) data) = cpu_to_le16(s->vsc_len);
+        return 2;
+    }
+
+    if ((idx = req_to_attr(req)) >= 0) {
+
+        memcpy(data, &s->vsc_attrs[idx], len);
+        return len;
+    }
+
+    return 0;
+}
+
+static const USBDescIfaceAssoc desc_if_groups[] = {
+    {
+        .bFirstInterface = IF_CONTROL,
+        .bInterfaceCount = 2,
+        .bFunctionClass = USB_CLASS_VIDEO,
+        .bFunctionSubClass = SC_VIDEO_INTERFACE_COLLECTION,
+        .bFunctionProtocol = PC_PROTOCOL_UNDEFINED,
+        .iFunction = STR_INTERFACE_ASSOCIATION
+    },
+};
+
+static const USBDescOther vc_iface_descs[] = {
+    {
+        /* Class-specific VS Interface Input Header Descriptor */
+        .data = (uint8_t[]) {
+            0x0D,                    /*  u8  bLength */
+            CS_INTERFACE,            /*  u8  bDescriptorType */
+            VC_HEADER,               /*  u8  bDescriptorSubtype */
+            U16(0x0110),             /* u16  bcdADC */
+            U16(0x003b),             /* u16  wTotalLength */
+            U32(0x005B8D80),         /* u32  dwClockFrequency */
+            0x01,                    /*  u8  bInCollection */
+            0x01,                    /*  u8  baInterfaceNr */
+        }
+    },
+    {
+        /* Input Terminal Descriptor (Camera) */
+        .data = (uint8_t[]) {
+            0x11,                    /*  u8  bLength */
+            CS_INTERFACE,            /*  u8  bDescriptorType */
+            VC_INPUT_TERMINAL,       /*  u8  bDescriptorSubtype */
+            INPUT_TERMINAL,          /*  u8  bTerminalID */
+            U16(ITT_CAMERA),         /* u16  wTerminalType */
+            0x00,                    /*  u8  bAssocTerminal */
+            STR_INPUT_TERMINAL,      /*  u8  iTerminal */
+            U16(0x0000),             /* u16  wObjectiveFocalLengthMin */
+            U16(0x0000),             /* u16  wObjectiveFocalLengthMax */
+            U16(0x0000),             /* u16  wOcularFocalLength */
+            0x02,                    /*  u8  bControlSize */
+            U16(0x0000),             /* u16  bmControls */
+        }
+    },
+    {
+        /* Output Terminal Descriptor */
+        .data = (uint8_t[]) {
+            0x09,                    /*  u8  bLength */
+            CS_INTERFACE,            /*  u8  bDescriptorType */
+            VC_OUTPUT_TERMINAL,      /*  u8  bDescriptorSubtype */
+            OUTPUT_TERMINAL,         /*  u8  bTerminalID */
+            U16(TT_STREAMING),       /* u16  wTerminalType */
+            0x00,                    /*  u8  bAssocTerminal */
+            PROCESSING_UNIT,         /*  u8  bSourceID */
+            STR_OUTPUT_TERMINAL,     /*  u8  iTerminal */
+        }
+    },
+    {
+        /* Selector Unit Descriptor */
+        .data = (uint8_t[]) {
+            0x07,                    /*  u8  bLength */
+            CS_INTERFACE,            /*  u8  bDescriptorType */
+            VC_SELECTOR_UNIT,        /*  u8  bDescriptorSubtype */
+            SELECTOR_UNIT,           /*  u8  bUnitID */
+            1,                       /*  u8  bNrInPins */
+            INPUT_TERMINAL,          /*  u8  baSourceID(1) */
+            STR_SELECTOR_UNIT,       /*  u8  iSelector */
+        }
+    },
+    {
+        /* Processing Unit Descriptor */
+        .data = (uint8_t[]) {
+            0x0d,                    /*  u8  bLength */
+            CS_INTERFACE,            /*  u8  bDescriptorType */
+            VC_PROCESSING_UNIT,      /*  u8  bDescriptorSubtype */
+            PROCESSING_UNIT,         /*  u8  bUnitID */
+            SELECTOR_UNIT,           /*  u8  bSourceID */
+            U16(0x0000),             /* u16  wMaxMultiplier */
+            0x03,                    /*  u8  bControlSize */
+            U24(0x000000),           /* u24  bmControls */
+            STR_PROCESSING_UNIT,     /*  u8  iProcessing */
+            0x00,                    /*  u8  bmVideoStandards */
+        }
+    }
+};
+
+static const USBDescEndpoint vc_iface_eps[] = {
+    {
+        .bEndpointAddress = USB_DIR_IN | EP_CONTROL,
+        .bmAttributes     = USB_ENDPOINT_XFER_INT,
+        .wMaxPacketSize   = 0x40,
+        .bInterval        = 0x20,
+    },
+};
+
+static const USBDescEndpoint vs_iface_eps[] = {
+    {
+        .bEndpointAddress = USB_DIR_IN | EP_STREAMING,
+        .bmAttributes     = 0x05,
+        .wMaxPacketSize   = 1024,
+        .bInterval        = 0x1,
+    },
+};
+
+#define VS_HEADER_LEN                  0xe
+#define VS_FORMAT_UNCOMPRESSED_LEN     0x1b
+#define VS_FRAME_MIN_LEN 0x1a
+#define VS_FRAME_SIZE(n)  (VS_FRAME_MIN_LEN+4*(n))
+
+static VideoControlType usb_video_pu_control_type_to_qemu(uint8_t cs)
+{
+    switch (cs) {
+    case PU_BRIGHTNESS_CONTROL:
+        return VideoControlTypeBrightness;
+    case PU_CONTRAST_CONTROL:
+        return VideoControlTypeContrast;
+    case PU_GAIN_CONTROL:
+        return VideoControlTypeGain;
+    case PU_GAMMA_CONTROL:
+        return VideoControlTypeGamma;
+    case PU_HUE_CONTROL:
+        return VideoControlTypeHue;
+    case PU_HUE_AUTO_CONTROL:
+        return VideoControlTypeHueAuto;
+    case PU_SATURATION_CONTROL:
+        return VideoControlTypeSaturation;
+    case PU_SHARPNESS_CONTROL:
+        return VideoControlTypeSharpness;
+    case PU_WHITE_BALANCE_TEMPERATURE_CONTROL:
+        return VideoControlTypeWhiteBalanceTemperature;
+    }
+
+    return VideoControlTypeMax;
+}
+
+static int usb_video_pu_control_bits(VideoControlType type)
+{
+    switch ((int) type) {
+    case VideoControlTypeBrightness:
+        return PU_CONTRL_BRIGHTNESS;
+    case VideoControlTypeContrast:
+        return PU_CONTRL_CONTRAST;
+    case VideoControlTypeGain:
+        return PU_CONTRL_GAIN;
+    case VideoControlTypeGamma:
+        return PU_CONTRL_GAMMA;
+    case VideoControlTypeHue:
+        return PU_CONTRL_HUE;
+    case VideoControlTypeHueAuto:
+        return PU_CONTRL_HUE_AUTO;
+    case VideoControlTypeSaturation:
+        return PU_CONTRL_SATURATION;
+    case VideoControlTypeSharpness:
+        return PU_CONTRL_SHARPNESS;
+    case VideoControlTypeWhiteBalanceTemperature:
+        return PU_CONTRL_WHITE_BALANCE_TEMPERATURE;
+    }
+
+    return 0;
+}
+
+static int usb_video_pu_control_type(VideoControlType type, uint8_t *size)
+{
+    switch ((int)type) {
+    case VideoControlTypeBrightness:
+        *size = 2;
+        return PU_BRIGHTNESS_CONTROL;
+    case VideoControlTypeContrast:
+        *size = 2;
+        return PU_CONTRAST_CONTROL;
+    case VideoControlTypeGain:
+        *size = 2;
+        return PU_GAIN_CONTROL;
+    case VideoControlTypeGamma:
+        *size = 2;
+        return PU_GAMMA_CONTROL;
+    case VideoControlTypeHue:
+        *size = 2;
+        return PU_HUE_CONTROL;
+    case VideoControlTypeHueAuto:
+        *size = 1;
+        return PU_HUE_AUTO_CONTROL;
+    case VideoControlTypeSaturation:
+        *size = 2;
+        return PU_SATURATION_CONTROL;
+    case VideoControlTypeSharpness:
+        *size = 2;
+        return PU_SHARPNESS_CONTROL;
+    case VideoControlTypeWhiteBalanceTemperature:
+        *size = 2;
+        return PU_WHITE_BALANCE_TEMPERATURE_CONTROL;
+    }
+
+    return PU_CONTROL_UNDEFINED;
+}
+
+static void usb_video_add_vs_header(USBDescOther *header, uint16_t wTotalLength)
+{
+    uint8_t *data;
+    /* Class-specific VS Header Descriptor (Input) */
+    uint8_t header_data[] = {
+        VS_HEADER_LEN,              /*  u8  bLength */
+        CS_INTERFACE,               /*  u8  bDescriptorType */
+        VS_INPUT_HEADER,            /*  u8  bDescriptorSubtype */
+        0x01,                       /*  u8  bNumFormats */
+        U16(wTotalLength),          /* u16  wTotalLength */
+        USB_DIR_IN | EP_STREAMING,  /*  u8  bEndPointAddress */
+        0x00,                       /*  u8  bmInfo */
+        OUTPUT_TERMINAL,            /*  u8  bTerminalLink */
+        0x01,                       /*  u8  bStillCaptureMethod */
+        0x01,                       /*  u8  bTriggerSupport */
+        0x00,                       /*  u8  bTriggerUsage */
+        0x01,                       /*  u8  bControlSize */
+        0x00,                       /*  u8  bmaControls */
+    };
+
+    header->length = header_data[0];
+    data = g_malloc0(header->length);
+    memcpy(data, header_data, VS_HEADER_LEN);
+    header->data = data;
+}
+
+static uint8_t usb_video_pixfmt_to_vsfmt(uint32_t pixfmt)
+{
+    switch (pixfmt) {
+    case QEMU_VIDEO_PIX_FMT_YUYV:
+    case QEMU_VIDEO_PIX_FMT_NV12:
+        return VS_FORMAT_UNCOMPRESSED;
+    }
+
+    return VS_UNDEFINED;
+}
+
+static void usb_video_add_vs_frame(USBDescIface *iface, VideoFramesize *frmsz, int frame_index, int *len)
+{
+    USBDescOther *desc;
+    uint8_t *data, bLength = VS_FRAME_SIZE(frmsz->nframerate);
+    uint16_t wWidth = frmsz->width;
+    uint16_t wHeight = frmsz->height;
+    // XXX: Parse from format descriptor
+    uint8_t bDescriptorSubtype = VS_FRAME_UNCOMPRESSED;
+    int i;
+    uint32_t *ival;
+    VideoFramerate frmival;
+    uint8_t bFrameIntervalType = frmsz->nframerate;
+
+    /* Class-specific VS Frame Descriptor */
+    uint8_t frame_data[] = {
+        bLength,                    /*  u8  bLength */
+        CS_INTERFACE,               /*  u8  bDescriptorType */
+        bDescriptorSubtype,         /*  u8  bDescriptorSubtype */
+        frame_index,                /*  u8  bFrameIndex */
+        0x03,                       /*  u8  bmCapabilities */
+        U16(wWidth),                /* u16  wWidth */
+        U16(wHeight),               /* u16  wHeight */
+        U32(442368000),             /* u32  dwMinBitRate */
+        U32(442368000),             /* u32  dwMaxBitRate */
+        // XXX
+        U32(0),                     /* u32  dwMaxVideoFrameBufSize */
+        // XXX
+        U32(0),                     /* u32  dwDefaultFrameInterval */
+        bFrameIntervalType,         /*  u8  bFrameIntervalType */
+    };
+
+    iface->ndesc++;
+    iface->descs = g_realloc(iface->descs,
+                             iface->ndesc * sizeof(USBDescOther));
+    desc = &iface->descs[iface->ndesc - 1];
+    desc->length = frame_data[0];
+    data = g_malloc0(frame_data[0]);
+    memcpy(data, frame_data, VS_FRAME_MIN_LEN);
+    desc->data = data;
+    *len += desc->length;
+
+    for (i = 0; i < bFrameIntervalType; i++) {
+        frmival = frmsz->framerates[i];
+        ival = (uint32_t *)((void*)data + VS_FRAME_MIN_LEN + 4 * i);
+        *ival = cpu_to_le32(10000000 * frmival.numerator / frmival.denominator);
+    }
+}
+
+static void usb_video_add_vs_format(USBDescIface *iface, VideoMode *mode, int format_index, int *len)
+{
+    int i;
+    USBDescOther *desc;
+    uint8_t *data, *format_data;
+    uint8_t bDescriptorSubtype = usb_video_pixfmt_to_vsfmt(mode->pixelformat);
+    uint8_t bNumFrameDescriptors = mode->nframesize;
+
+    uint8_t yuyv_fmt[] = {
+        VS_FORMAT_UNCOMPRESSED_LEN, /*  u8  bLength */
+        CS_INTERFACE,               /*  u8  bDescriptorType */
+        bDescriptorSubtype,         /*  u8  bDescriptorSubtype */
+        format_index,               /*  u8  bFormatIndex */
+        bNumFrameDescriptors,       /*  u8  bNumFrameDescriptors */
+        /* guidFormat */
+        'Y',  'U',  'Y',  '2', 0x00, 0x00, 0x10, 0x00,
+        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71,
+        0x10,                       /*  u8  bBitsPerPixel */
+        0x01,                       /*  u8  bDefaultFrameIndex */
+        0x00,                       /*  u8  bAspectRatioX */
+        0x00,                       /*  u8  bAspectRatioY */
+        0x00,                       /*  u8  bmInterlaceFlags */
+        0x00,                       /*  u8  bCopyProtect */
+    };
+
+    uint8_t nv12_fmt[] = {
+        VS_FORMAT_UNCOMPRESSED_LEN, /*  u8  bLength */
+        CS_INTERFACE,               /*  u8  bDescriptorType */
+        bDescriptorSubtype,         /*  u8  bDescriptorSubtype */
+        format_index,               /*  u8  bFormatIndex */
+        bNumFrameDescriptors,       /*  u8  bNumFrameDescriptors */
+        /* guidFormat */
+        'N',  'V',  '1',  '2', 0x00, 0x00, 0x10, 0x00,
+        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71,
+        0x10,                       /*  u8  bBitsPerPixel */
+        0x01,                       /*  u8  bDefaultFrameIndex */
+        0x00,                       /*  u8  bAspectRatioX */
+        0x00,                       /*  u8  bAspectRatioY */
+        0x00,                       /*  u8  bmInterlaceFlags */
+        0x00,                       /*  u8  bCopyProtect */
+    };
+
+    assert(qemu_video_pixfmt_supported(mode->pixelformat));
+    switch(mode->pixelformat) {
+    case QEMU_VIDEO_PIX_FMT_YUYV:
+        format_data = yuyv_fmt;
+        break;
+    case QEMU_VIDEO_PIX_FMT_NV12:
+        format_data = nv12_fmt;
+        break;
+    }
+
+    iface->ndesc++;
+    iface->descs = g_realloc(iface->descs,
+                             iface->ndesc * sizeof(USBDescOther));
+    desc = &iface->descs[iface->ndesc - 1];
+    desc->length = format_data[0];
+    data = g_malloc0(desc->length);
+    memcpy(data, format_data, format_data[0]);
+    desc->data = data;
+    *len += desc->length;
+
+    for (i = 0; i < bNumFrameDescriptors; i++)
+        usb_video_add_vs_frame(iface, &mode->framesizes[i], i + 1, len);
+}
+
+static void usb_video_add_vs_desc(USBVideoState *s, USBDescIface *iface)
+{
+    int i, len;
+
+    assert(s->video);
+    assert(iface->descs == NULL);
+    assert(iface->ndesc == 0);
+
+    // parse the header descriptors once we know the total size.
+    len = VS_HEADER_LEN;
+    iface->ndesc = 1;
+    iface->descs = g_new0(USBDescOther, iface->ndesc);
+
+    // parse all formats
+    for (i = 0; i < s->video->nmodes; i++) {
+        usb_video_add_vs_format(iface, &s->video->modes[i], i + 1, &len);
+    }
+
+    usb_video_add_vs_header(&iface->descs[0], len);
+}
+
+static void usb_video_add_vc_desc(USBVideoState *s, USBDescIface *iface)
+{
+    uint8_t *bmControls = NULL;
+    uint32_t bitmap = 0;
+
+    for (int i = 0; i < s->video->ncontrols; i++) {
+
+        VideoControl *control;
+        int pu_control;
+        uint8_t size = 0;
+
+        control = &s->video->controls[i];
+        bitmap |= usb_video_pu_control_bits(control->type);
+        pu_control = usb_video_pu_control_type(control->type, &size);
+
+        if (pu_control == PU_CONTROL_UNDEFINED)
+            continue;
+
+        s->pu_attrs[control->type] = (USBVideoControlInfo) {
+
+            .selector = pu_control,
+            .caps     = CONTROL_CAP_GET | CONTROL_CAP_SET | CONTROL_CAP_ASYNCHRONOUS,
+            .size     = size,
+
+            .value[ATTRIBUTE_DEF] = cpu_to_le32(control->def),
+            .value[ATTRIBUTE_MIN] = cpu_to_le32(control->min),
+            .value[ATTRIBUTE_MAX] = cpu_to_le32(control->max),
+            .value[ATTRIBUTE_CUR] = cpu_to_le32(control->def),
+            .value[ATTRIBUTE_RES] = cpu_to_le32(control->step)
+        };
+    }
+
+    for (uint8_t i = 0; i < iface->ndesc; i++) {
+
+        if (iface->descs[i].data[2] == VC_PROCESSING_UNIT) {
+            bmControls = (uint8_t*) &iface->descs[i].data[8];
+        }
+    }
+
+    /*
+     * PU descriptor not found. Should not happen...
+     * */
+    assert(bmControls != NULL);
+
+    bitmap = cpu_to_le32(bitmap);
+
+    *(bmControls + 0) = (bitmap >>  0) & 0xff;
+    *(bmControls + 1) = (bitmap >>  8) & 0xff;
+    *(bmControls + 2) = (bitmap >> 16) & 0xff;
+}
+
+static const USBDescIface *usb_video_desc_iface_new(USBDevice *dev)
+{
+
+    USBVideoState *s = USB_VIDEO(dev);
+    USBDescIface *d = g_new0(USBDescIface, USB_VIDEO_IFACE_COUNT);
+
+    d[VC].bInterfaceNumber   = IF_CONTROL;
+    d[VC].bInterfaceClass    = USB_CLASS_VIDEO;
+    d[VC].bInterfaceSubClass = SC_VIDEOCONTROL;
+    d[VC].bInterfaceProtocol = PC_PROTOCOL_15;
+    d[VC].iInterface         = STR_VIDEO_CONTROL;
+    d[VC].ndesc              = ARRAY_SIZE(vc_iface_descs);
+    d[VC].descs              = (USBDescOther *) &vc_iface_descs;
+    d[VC].bNumEndpoints      = ARRAY_SIZE(vc_iface_eps);
+    d[VC].eps                = (USBDescEndpoint *)vc_iface_eps;
+
+    d[VS0].bInterfaceNumber   = IF_STREAMING;
+    d[VS0].bAlternateSetting  = ALTSET_OFF;
+    d[VS0].bNumEndpoints      = 0;
+    d[VS0].bInterfaceClass    = USB_CLASS_VIDEO;
+    d[VS0].bInterfaceSubClass = SC_VIDEOSTREAMING;
+    d[VS0].bInterfaceProtocol = PC_PROTOCOL_15;
+    d[VS0].iInterface         = STR_VIDEO_STREAMING;
+
+    d[VS1].bInterfaceNumber   = IF_STREAMING;
+    d[VS1].bAlternateSetting  = ALTSET_STREAMING;
+    d[VS1].bNumEndpoints      = 0;
+    d[VS1].bInterfaceClass    = USB_CLASS_VIDEO;
+    d[VS1].bInterfaceSubClass = SC_VIDEOSTREAMING;
+    d[VS1].bInterfaceProtocol = PC_PROTOCOL_15;
+    d[VS1].iInterface         = STR_VIDEO_STREAMING_ALTERNATE1;
+    d[VS1].bNumEndpoints      = ARRAY_SIZE(vs_iface_eps);
+    d[VS1].eps                = (USBDescEndpoint *)vs_iface_eps;
+
+    usb_video_add_vs_desc(s, &d[VS0]);
+    usb_video_add_vc_desc(s, &d[VC]);
+
+    return d;
+}
+
+static const USBDescDevice *usb_video_desc_device_new(USBDevice *dev,
+                                                      const uint16_t bcdUSB,
+                                                      const uint8_t bMaxPacketSize0)
+{
+    USBDescDevice *d = g_new0(USBDescDevice, 1);
+    USBDescConfig *c = g_new0(USBDescConfig, 1);
+
+    d->bcdUSB              = bcdUSB;
+    d->bDeviceClass        = USB_CLASS_MISCELLANEOUS;
+    d->bDeviceSubClass     = 2;
+    d->bDeviceProtocol     = 1;
+    d->bMaxPacketSize0     = bMaxPacketSize0;
+    d->bNumConfigurations  = 1;
+
+    d->confs = c;
+    c->bNumInterfaces      = 2;
+    c->bConfigurationValue = 1;
+    c->iConfiguration      = STR_CONFIG;
+    c->bmAttributes        = USB_CFG_ATT_ONE | USB_CFG_ATT_SELFPOWER;
+    c->bMaxPower           = 0x32;
+    c->nif_groups          = ARRAY_SIZE(desc_if_groups);
+    c->if_groups           = desc_if_groups;
+    c->nif                 = USB_VIDEO_IFACE_COUNT;
+    c->ifs                 = usb_video_desc_iface_new(dev);
+
+    return d;
+}
+
+static void usb_video_desc_new(USBDevice *dev)
+{
+    USBDesc *d;
+
+    d = g_new0(USBDesc, 1);
+    d->id.idVendor      = USBVIDEO_VENDOR_NUM;
+    d->id.idProduct     = USBVIDEO_PRODUCT_NUM;
+    d->id.bcdDevice     = 0;
+    d->id.iManufacturer = STR_MANUFACTURER;
+    d->id.iProduct      = STR_PRODUCT;
+    d->id.iSerialNumber = STR_SERIALNUMBER;
+    d->str              = usb_video_stringtable;
+    d->full             = usb_video_desc_device_new(dev, 0x0100, 8);
+    d->high             = usb_video_desc_device_new(dev, 0x0200, 64);
+
+    dev->usb_desc = d;
+}
+
+static void usb_video_desc_free(USBDevice *dev)
+{
+    const USBDesc *d = dev->usb_desc;
+    g_free((void *)d->full->confs->ifs);
+    g_free((void *)d->full->confs);
+    g_free((void *)d->high->confs->ifs);
+    g_free((void *)d->high->confs);
+    g_free((void *)d->super->confs);
+    g_free((void *)d->full);
+    g_free((void *)d->high);
+    g_free((void *)d->super);
+
+    dev->usb_desc = NULL;
+}
+
+static void usb_video_handle_data_control_in(USBDevice *dev, USBPacket *p)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    USBBus *bus = usb_bus_from_device(dev);
+    USBVideoControlStats *usb_status = NULL;
+    QEMUIOVector *iov = p->combined ? &p->combined->iov : &p->iov;
+    size_t len;
+
+    if (QTAILQ_EMPTY(&s->control_status)) {
+
+        p->status = USB_RET_NAK;
+        return;
+    }
+
+    usb_status = QTAILQ_FIRST(&s->control_status);
+    QTAILQ_REMOVE(&s->control_status, usb_status, list);
+
+    len = MIN(5 + usb_status->size, iov->size);
+    usb_packet_copy(p, &usb_status->status, len);
+
+    p->status = USB_RET_SUCCESS;
+    trace_usb_video_handle_data_control_in(bus->busnr, dev->addr, len);
+}
+
+static void usb_video_send_empty_packet(USBDevice *dev, USBPacket *p)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+
+    VideoImagePayloadHeader header = {
+
+        .bmHeaderInfo  = PAYLOAD_HEADER_EOH | PAYLOAD_HEADER_ERR,
+        .bHeaderLength = 2
+    };
+
+    usb_packet_copy(p, &header, header.bHeaderLength);
+    s->streaming_error = VS_ERROR_INPUT_BUFFER_UNDERRUN;
+}
+
+static void usb_video_handle_data_streaming_in(USBDevice *dev, USBPacket *p)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    USBBus *bus = usb_bus_from_device(dev);
+    QEMUIOVector *iov = p->combined ? &p->combined->iov : &p->iov;
+    size_t payload_length, packet_with_header_length;
+    VideoFrameChunk frame_chunk;
+    Error *err = NULL;
+    int rc;
+
+    VideoImagePayloadHeader header = {
+
+        .bmHeaderInfo  = PAYLOAD_HEADER_EOH | (s->fid ? PAYLOAD_HEADER_FID : 0),
+        .bHeaderLength = 2
+    };
+
+    packet_with_header_length = p->actual_length + header.bHeaderLength;
+    payload_length            = iov->size - packet_with_header_length;
+
+    if (s->altset != ALTSET_STREAMING) {
+
+        p->status = USB_RET_NAK;
+        return;
+    }
+
+    if (packet_with_header_length >= iov->size) {
+
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    rc = qemu_videodev_read_frame(s->video, payload_length, &frame_chunk, &err);
+
+    if (rc == VIDEODEV_RC_UNDERRUN) {
+
+        error_free(err);
+        usb_video_send_empty_packet(dev, p);
+        p->status = USB_RET_SUCCESS;
+        return;
+    }
+
+    if (rc != VIDEODEV_RC_OK) {
+
+        error_reportf_err(err, "%s: ", TYPE_USB_VIDEO);
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    if (qemu_videodev_current_frame_length(s->video) == 0) {
+
+        header.bmHeaderInfo |= PAYLOAD_HEADER_EOF;
+        s->fid = !s->fid;
+    }
+
+    usb_packet_copy(p, &header, header.bHeaderLength);
+    usb_packet_copy(p, frame_chunk.data, frame_chunk.size);
+    qemu_videodev_read_frame_done(s->video, NULL);
+
+    p->status = USB_RET_SUCCESS;
+
+    trace_usb_video_handle_data_streaming_in(bus->busnr, dev->addr, payload_length);
+}
+
+static uint32_t usb_video_get_max_framesize(Videodev *video)
+{
+    /*
+     * currently only YUYV support
+     * */
+
+    uint32_t max_framesize = 0;
+
+    for (int i = 0; i < video->nmodes; i++) {
+
+        VideoMode *mode = &video->modes[i];
+
+        for (int j = 0; j < mode->nframesize; j++) {
+
+            const uint32_t height = mode->framesizes[j].height;
+            const uint32_t width  = mode->framesizes[j].width;
+
+            if (height * width * 2 > max_framesize)
+                max_framesize = height * width * 2;
+        }
+    }
+
+    return max_framesize;
+}
+
+static int usb_video_initialize(USBDevice *dev)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    VideoStreamingControl *vsc;
+    VideoFramerate *avail_frmrts;
+    int n_framerates;
+
+    /*
+     * build USB descriptors
+     * */
+
+    usb_video_desc_new(dev);
+    usb_desc_create_serial(dev);
+    usb_desc_init(dev);
+
+    /*
+     * initialize video streaming control attributes
+     * */
+
+    s->vsc_info = 0;
+    s->vsc_len  = sizeof(VideoStreamingControl);
+
+    vsc = &s->vsc_attrs[ATTRIBUTE_DEF];
+
+    vsc->bFormatIndex             = 1;
+    vsc->bFrameIndex              = 1;
+
+    avail_frmrts = qemu_videodev_get_framerates(s->video, 0, 0, &n_framerates);
+    assert(n_framerates > 0);
+
+    vsc->dwFrameInterval          = cpu_to_le32(frmrt_to_frmival(&avail_frmrts[0]));
+    vsc->wDelay                   = cpu_to_le16(32);
+    vsc->dwMaxVideoFrameSize      = cpu_to_le32(usb_video_get_max_framesize(s->video));
+    vsc->dwMaxPayloadTransferSize = cpu_to_le32(1024);
+    vsc->dwClockFrequency         = cpu_to_le32(15000000);
+
+    memcpy(&s->vsc_attrs[ATTRIBUTE_CUR], vsc, sizeof(VideoStreamingControl));
+    memcpy(&s->vsc_attrs[ATTRIBUTE_MIN], vsc, sizeof(VideoStreamingControl));
+    memcpy(&s->vsc_attrs[ATTRIBUTE_MAX], vsc, sizeof(VideoStreamingControl));
+
+    return 0;
+}
+
+static void usb_video_realize(USBDevice *dev, Error **errp)
+{
+    USBBus *bus = usb_bus_from_device(dev);
+    USBVideoState *s = USB_VIDEO(dev);
+
+    trace_usb_video_realize(bus->busnr, dev->addr);
+
+    if (!s->video) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "videodev");
+        return;
+    }
+
+    if (usb_video_initialize(dev) < 0) {
+        error_setg(errp, "%s: Could not initialize USB video", TYPE_USB_VIDEO);
+        return;
+    }
+
+    QTAILQ_INIT(&s->control_status);
+
+    s->dev.opaque      = s;
+    s->altset          = ALTSET_OFF;
+    s->fid             = false;
+    s->error           = 0;
+    s->streaming_error = 0;
+}
+
+static void usb_video_handle_reset(USBDevice *dev)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    USBBus *bus = usb_bus_from_device(dev);
+
+    trace_usb_video_handle_reset(bus->busnr, dev->addr);
+    qemu_videodev_stream_off(s->video, NULL);
+}
+
+static void usb_video_queue_control_status(USBDevice *dev, uint8_t bOriginator,
+                                           uint8_t bSelector, uint32_t *value, uint8_t size)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    USBVideoControlStats *usb_status;
+    VideoControlStatus *status;
+
+    usb_status = g_malloc0(sizeof(USBVideoControlStats));
+    usb_status->size = size;
+    status = &usb_status->status;
+    status->bStatusType = STATUS_INTERRUPT_CONTROL;
+    status->bOriginator = bOriginator;
+    status->bEvent = 0;
+    status->bSelector = bSelector;
+    status->bAttribute = STATUS_CONTROL_VALUE_CHANGE;
+    memcpy(status->bValue, value, size);
+
+    QTAILQ_INSERT_TAIL(&s->control_status, usb_status, list);
+}
+
+static uint32_t usb_video_negotiate_frmival(Videodev *vd, VideoStreamingControl *vsc)
+{
+    int n_framerates;
+    VideoFramerate *avail_frmrts;
+    uint32_t request = le32_to_cpu(vsc->dwFrameInterval);
+    uint32_t best_delta = -1, best_frmival = request;
+
+    avail_frmrts = qemu_videodev_get_framerates(vd, vsc->bFormatIndex - 1,
+                                                    vsc->bFrameIndex  - 1,
+                                                    &n_framerates);
+
+    for (int i = 0; i < n_framerates; i++) {
+
+        uint32_t cur_frmival = frmrt_to_frmival(&avail_frmrts[i]);
+        uint32_t delta = DELTA_ABS(cur_frmival, request);
+
+        if (delta <= best_delta) {
+            best_delta = delta;
+            best_frmival = cur_frmival;
+        }
+    }
+
+    return best_frmival;
+}
+
+static int usb_video_set_vs_control(USBDevice *dev, uint8_t req, int length, uint8_t *data)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    AttributeIndex idx = req_to_attr(req);
+    int ret = USB_RET_STALL;
+
+    if ((idx >= 0) && (length <= sizeof(s->vsc_attrs[0]))) {
+
+        VideoStreamingControl *dst = s->vsc_attrs + idx;
+        VideoStreamingControl *src = (VideoStreamingControl*) data;
+
+        dst->bFormatIndex    = src->bFormatIndex;
+        dst->bFrameIndex     = src->bFrameIndex;
+        dst->dwFrameInterval = cpu_to_le32(usb_video_negotiate_frmival(s->video, src));
+
+        /*
+         * wKeyFrameRate, wPFrameRate, wCompQuality, wCompWindowSize are currently
+         * being ignored due to missing support for compressed formats!
+         */
+
+        ret = length;
+    }
+
+    return ret;
+}
+
+static int usb_video_get_control(USBDevice *dev, int request, int value,
+                                 int index, int length, uint8_t *data)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    uint8_t req = request & 0xff;
+    uint8_t cs = value >> 8;
+    uint8_t intfnum = index & 0xff;
+    uint8_t unit = index >> 8;
+    int ret = USB_RET_STALL;
+
+    switch (intfnum) {
+    case IF_CONTROL:
+        switch (unit) {
+        case 0:
+            if (length != 1) {
+                break;
+            }
+
+            if (cs == VC_VIDEO_POWER_MODE_CONTROL) {
+                data[0] = 127; /* 4.2.1.1 Power Mode Control */
+                ret = 1;
+            } else if (cs == VC_REQUEST_ERROR_CODE_CONTROL) {
+                data[0] = s->error; /* 4.2.1.2 Request Error Code Control */
+                s->error = 0;
+                ret = 1;
+            }
+            break;
+
+        case PROCESSING_UNIT:
+            {
+                VideoControlType t;
+                if ((t = usb_video_pu_control_type_to_qemu(cs)) >= VideoControlTypeMax) {
+                    break;
+                }
+                int copied = handle_get_control(&s->pu_attrs[t], req, length, data);
+                ret = (copied == 0) ? USB_RET_STALL : copied;
+            }
+            break;
+
+        case SELECTOR_UNIT:
+        case ENCODING_UNIT:
+        default:
+            /* TODO XU control support */
+            break;
+        }
+        break;
+
+    case IF_STREAMING:
+        switch (cs) {
+        case VS_PROBE_CONTROL: {
+            int copied = handle_get_streaming(s, req, length, data);
+            ret = (copied == 0) ? USB_RET_STALL : copied;
+        } break;
+
+        case VS_STREAM_ERROR_CODE_CONTROL:
+            if (length != 1)
+                break;
+
+            data[0] = s->streaming_error;
+            ret     = 1;
+            break;
+
+        default:
+            qemu_log_mask(LOG_UNIMP, "%s: get streamimg %d not implemented\n",
+                          TYPE_USB_VIDEO, cs);
+        }
+
+        break;
+    }
+
+    return ret;
+}
+
+static int usb_video_set_control(USBDevice *dev, int request, int value,
+                                 int index, int length, uint8_t *data)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    uint8_t req = request & 0xff;
+    uint8_t cs = value >> 8;
+    uint8_t intfnum = index & 0xff;
+    uint8_t unit = index >> 8;
+    int ret = USB_RET_STALL;
+
+    switch (intfnum) {
+    case IF_CONTROL:
+        switch (unit) {
+        case PROCESSING_UNIT:
+            {
+                uint32_t val = 0;
+                VideoControl ctrl;
+                VideoControlType type;
+                Error *local_err = NULL;
+
+                type = usb_video_pu_control_type_to_qemu(cs);
+                if (type == VideoControlTypeMax) {
+                    break;
+                }
+
+                if (length > 4) {
+                    break;
+                }
+
+                memcpy(&val, data, length);
+                val = le32_to_cpu(val);
+                ctrl.type = type;
+                ctrl.cur = val;
+                if (qemu_videodev_set_control(s->video, &ctrl, &local_err) != VIDEODEV_RC_OK) {
+                    error_reportf_err(local_err, "%s: ", TYPE_USB_VIDEO);
+                    break;
+                }
+
+                memcpy(&s->pu_attrs[type].value[ATTRIBUTE_CUR], data, length);
+                ret = length;
+                usb_video_queue_control_status(dev, PROCESSING_UNIT, cs,
+                                               &val, length);
+            }
+            break;
+
+        /* TODO XU control support */
+        }
+
+        break;
+
+    case IF_STREAMING:
+        switch (cs) {
+        case VS_PROBE_CONTROL:
+        case VS_COMMIT_CONTROL:
+            {
+                VideoStreamingControl *vsc = (VideoStreamingControl*) data;
+
+                VideoStreamOptions opts = {
+                    .format_index   = vsc->bFormatIndex - 1,
+                    .frame_index    = vsc->bFrameIndex - 1,
+                    .frame_interval = le32_to_cpu(vsc->dwFrameInterval)
+                };
+
+                if (qemu_videodev_check_options(s->video, &opts) == false) {
+                    s->error = VC_ERROR_OUT_OF_RANGE;
+                    break;
+                }
+
+                ret = usb_video_set_vs_control(dev, req, length, data);
+            }
+            break;
+
+        default:
+            qemu_log_mask(LOG_UNIMP, "%s: set streamimg %d not implemented\n",
+                          TYPE_USB_VIDEO, cs);
+        }
+
+        break;
+    }
+
+    return ret;
+}
+
+static void usb_video_handle_control(USBDevice *dev, USBPacket *p,
+                                    int request, int value, int index,
+                                    int length, uint8_t *data)
+{
+    int ret;
+    USBBus *bus = usb_bus_from_device(dev);
+
+    trace_usb_video_handle_control(bus->busnr, dev->addr, request, value);
+
+    ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
+    if (ret >= 0) {
+        return;
+    }
+
+    switch (request) {
+    case ClassInterfaceRequest | GET_CUR:
+    case ClassInterfaceRequest | GET_MIN:
+    case ClassInterfaceRequest | GET_MAX:
+    case ClassInterfaceRequest | GET_RES:
+    case ClassInterfaceRequest | GET_LEN:
+    case ClassInterfaceRequest | GET_INFO:
+    case ClassInterfaceRequest | GET_DEF:
+        ret = usb_video_get_control(dev, request, value, index, length, data);
+        if (ret < 0) {
+            goto error;
+        }
+        break;
+    case ClassInterfaceOutRequest | SET_CUR:
+        ret = usb_video_set_control(dev, request, value, index, length, data);
+        if (ret < 0) {
+            goto error;
+        }
+        break;
+    case ClassInterfaceRequest | GET_CUR_ALL:
+    case ClassInterfaceRequest | GET_MIN_ALL:
+    case ClassInterfaceRequest | GET_MAX_ALL:
+    case ClassInterfaceRequest | GET_RES_ALL:
+    case ClassInterfaceRequest | GET_DEF_ALL:
+    case ClassInterfaceOutRequest | SET_CUR_ALL:
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: request %d not implemented\n",
+                      TYPE_USB_VIDEO, request);
+        goto error;
+    }
+
+    p->actual_length = ret;
+    p->status = USB_RET_SUCCESS;
+
+    return;
+
+error:
+    trace_usb_video_handle_control_error(bus->busnr, dev->addr, request,
+        value, index, length);
+    p->status = USB_RET_STALL;
+}
+
+static void usb_video_handle_data(USBDevice *dev, USBPacket *p)
+{
+    if ((p->pid == USB_TOKEN_IN) && (p->ep->nr == EP_STREAMING)) {
+        usb_video_handle_data_streaming_in(dev, p);
+        return;
+    } else if ((p->pid == USB_TOKEN_IN) && (p->ep->nr == EP_CONTROL)) {
+        usb_video_handle_data_control_in(dev, p);
+        return;
+    }
+
+    p->status = USB_RET_STALL;
+}
+
+static void usb_video_set_streaming_altset(USBDevice *dev, int altset)
+{
+    USBVideoState *s = USB_VIDEO(dev);
+    Error *local_err = NULL;
+
+    if (s->altset == altset)
+        return;
+
+    switch (altset) {
+    case ALTSET_OFF:
+        {
+            if (qemu_videodev_stream_off(s->video, &local_err) != VIDEODEV_RC_OK) {
+
+                s->error = VC_ERROR_INVALID_REQUEST;
+                error_reportf_err(local_err, "%s: ", TYPE_USB_VIDEO);
+                return;
+            }
+        }
+        break;
+
+    case ALTSET_STREAMING:
+        {
+            VideoStreamingControl *vsc = &s->vsc_attrs[ATTRIBUTE_CUR];
+
+            VideoStreamOptions opts = {
+                .format_index   = vsc->bFormatIndex - 1,
+                .frame_index    = vsc->bFrameIndex - 1,
+                .frame_interval = le32_to_cpu(vsc->dwFrameInterval)
+            };
+
+            if (qemu_videodev_stream_on(s->video, &opts, &local_err) != VIDEODEV_RC_OK) {
+
+                s->error = VC_ERROR_INVALID_REQUEST;
+                error_reportf_err(local_err, "%s: ", TYPE_USB_VIDEO);
+                return;
+            }
+        }
+        break;
+    }
+
+    s->altset = altset;
+}
+
+static void usb_video_set_interface(USBDevice *dev, int iface,
+                                    int old, int value)
+{
+    USBBus *bus = usb_bus_from_device(dev);
+    trace_usb_video_set_interface(bus->busnr, dev->addr, iface, value);
+
+    if (iface == IF_STREAMING) {
+        usb_video_set_streaming_altset(dev, value);
+    }
+}
+
+static void usb_video_unrealize(USBDevice *dev)
+{
+    USBBus *bus = usb_bus_from_device(dev);
+    trace_usb_video_unrealize(bus->busnr, dev->addr);
+    usb_video_desc_free(dev);
+}
+
+static const Property usb_video_properties[] = {
+    DEFINE_VIDEO_PROPERTIES(USBVideoState, video),
+};
+
+static void usb_video_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    USBDeviceClass *k = USB_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, usb_video_properties);
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);
+    k->product_desc   = "QEMU USB Video Interface";
+    k->realize        = usb_video_realize;
+    k->handle_control = usb_video_handle_control;
+    k->handle_reset   = usb_video_handle_reset;
+    k->handle_data    = usb_video_handle_data;
+    k->unrealize      = usb_video_unrealize;
+    k->set_interface  = usb_video_set_interface;
+}
+
+static const TypeInfo usb_video_info = {
+    .name          = TYPE_USB_VIDEO,
+    .parent        = TYPE_USB_DEVICE,
+    .instance_size = sizeof(USBVideoState),
+    .class_init    = usb_video_class_init,
+};
+
+static void usb_video_register_types(void)
+{
+    type_register_static(&usb_video_info);
+}
+
+type_init(usb_video_register_types)
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 17360a5b5a..ba2f565b8c 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -43,6 +43,7 @@ system_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
 system_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
 system_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
 system_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
+system_ss.add(when: 'CONFIG_USB_VIDEO', if_true: files('dev-video.c'))
 if host_os != 'windows'
   system_ss.add(when: 'CONFIG_USB_STORAGE_MTP', if_true: files('dev-mtp.c'))
 endif
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index dd04f14add..09d2bf7765 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -368,3 +368,13 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_len) "ep %d len %d"
 canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"
 canokey_realize(void)
 canokey_unrealize(void)
+
+# dev-video.c
+usb_video_handle_control(int bus, int addr, int request, int value) "dev %d:%u got control 0x%x, value 0x%x"
+usb_video_handle_control_error(int bus, int addr, int request, int value, int index, int length) "dev %d:%u got unsupported/bogus control request 0x%x, value 0x%x, index 0x%x, length 0x%x"
+usb_video_handle_data_control_in(int bus, int addr, int len) "dev %d:%u streaming in %d"
+usb_video_handle_data_streaming_in(int bus, int addr, int len) "dev %d:%u streaming in %d"
+usb_video_handle_reset(int bus, int addr) "dev %d:%u reset"
+usb_video_set_interface(int bus, int addr, int iface, int value) "dev %d:%u set iface %d with value %d"
+usb_video_realize(int bus, int addr) "dev %d:%u"
+usb_video_unrealize(int bus, int addr) "dev %d:%u"
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c52..0d85d184c0 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -32,6 +32,7 @@ extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 extern const PropertyInfo qdev_prop_endian_mode;
 extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
+extern const PropertyInfo qdev_prop_videodev;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -110,4 +111,7 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
                          qdev_prop_vmapple_virtio_blk_variant, \
                          VMAppleVirtioBlkVariant)
 
+#define DEFINE_PROP_VIDEODEV(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_videodev, Videodev*)
+
 #endif
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 26a9f3ecde..5d2520f7fc 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -81,6 +81,8 @@
 #define USB_CLASS_CDC_DATA              0x0a
 #define USB_CLASS_CSCID                 0x0b
 #define USB_CLASS_CONTENT_SEC           0x0d
+#define USB_CLASS_VIDEO                 0x0e
+#define USB_CLASS_MISCELLANEOUS         0xef
 #define USB_CLASS_APP_SPEC              0xfe
 #define USB_CLASS_VENDOR_SPEC           0xff
 
diff --git a/include/hw/usb/video.h b/include/hw/usb/video.h
new file mode 100644
index 0000000000..4e9dc70ea0
--- /dev/null
+++ b/include/hw/usb/video.h
@@ -0,0 +1,322 @@
+/*
+ * Copyright 2021 Bytedance, Inc.
+ *
+ * Authors:
+ *   zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_USB_VIDEO_H
+#define HW_USB_VIDEO_H
+
+/* Base on UVC specification 1.5 */
+
+/* A.2. Video Interface Subclass Codes */
+#define SC_UNDEFINED                  0x00
+#define SC_VIDEOCONTROL               0x01
+#define SC_VIDEOSTREAMING             0x02
+#define SC_VIDEO_INTERFACE_COLLECTION 0x03
+
+/* A.3. Video Interface Protocol Codes */
+#define PC_PROTOCOL_UNDEFINED 0x00
+#define PC_PROTOCOL_15        0x01
+
+/* A.4. Video Class-Specific Descriptor Types */
+#define CS_UNDEFINED     0x20
+#define CS_DEVICE        0x21
+#define CS_CONFIGURATION 0x22
+#define CS_STRING        0x23
+#define CS_INTERFACE     0x24
+#define CS_ENDPOINT      0x25
+
+/* A.5. Video Class-Specific VC Interface Descriptor Subtypes */
+#define VC_DESCRIPTOR_UNDEFINED 0x00
+#define VC_HEADER               0x01
+#define VC_INPUT_TERMINAL       0x02
+#define VC_OUTPUT_TERMINAL      0x03
+#define VC_SELECTOR_UNIT        0x04
+#define VC_PROCESSING_UNIT      0x05
+#define VC_EXTENSION_UNIT       0x06
+#define VC_ENCODING_UNIT        0x07
+
+/* A.6. Video Class-Specific VS Interface Descriptor Subtypes */
+#define VS_UNDEFINED             0x00
+#define VS_INPUT_HEADER          0x01
+#define VS_OUTPUT_HEADER         0x02
+#define VS_STILL_IMAGE_FRAME     0x03
+#define VS_FORMAT_UNCOMPRESSED   0x04
+#define VS_FRAME_UNCOMPRESSED    0x05
+#define VS_FORMAT_MJPEG          0x06
+#define VS_FRAME_MJPEG           0x07
+#define VS_FORMAT_MPEG2TS        0x0A
+#define VS_FORMAT_DV             0x0C
+#define VS_COLORFORMAT           0x0D
+#define VS_FORMAT_FRAME_BASED    0x10
+#define VS_FRAME_FRAME_BASED     0x11
+#define VS_FORMAT_STREAM_BASED   0x12
+#define VS_FORMAT_H264           0x13
+#define VS_FRAME_H264            0x14
+#define VS_FORMAT_H264_SIMULCAST 0x15
+#define VS_FORMAT_VP8            0x16
+#define VS_FRAME_VP8             0x17
+#define VS_FORMAT_VP8_SIMULCAST  0x18
+
+/* A.7. Video Class-Specific Endpoint Descriptor Subtypes */
+#define EP_UNDEFINED 0x00
+#define EP_GENERAL   0x01
+#define EP_ENDPOINT  0x02
+#define EP_INTERRUPT 0x03
+
+/* A.8. Video Class-Specific Request Codes */
+#define RC_UNDEFINED 0x00
+#define SET_CUR      0x01
+#define SET_CUR_ALL  0x11
+#define GET_CUR      0x81
+#define GET_MIN      0x82
+#define GET_MAX      0x83
+#define GET_RES      0x84
+#define GET_LEN      0x85
+#define GET_INFO     0x86
+#define GET_DEF      0x87
+#define GET_CUR_ALL  0x91
+#define GET_MIN_ALL  0x92
+#define GET_MAX_ALL  0x93
+#define GET_RES_ALL  0x94
+#define GET_DEF_ALL  0x97
+
+/* 4.1.2 Get Request: Defined Bits Containing Capabilities of the Control */
+#define CONTROL_CAP_GET          (1 << 0)
+#define CONTROL_CAP_SET          (1 << 1)
+#define CONTROL_CAP_DISABLED     (1 << 2)
+#define CONTROL_CAP_AUTOUPDATE   (1 << 3)
+#define CONTROL_CAP_ASYNCHRONOUS (1 << 4)
+
+/* 4.2.1.2 Request Error Code Control */
+#define VC_ERROR_NOT_READY                  0x01
+#define VC_ERROR_WRONG_STATE                0x02
+#define VC_ERROR_POWER                      0x03
+#define VC_ERROR_OUT_OF_RANGE               0x04
+#define VC_ERROR_INVALID_UNIT               0x05
+#define VC_ERROR_INVALID_CONTROL            0x06
+#define VC_ERROR_INVALID_REQUEST            0x07
+#define VC_ERROR_INVALID_VALUE_WITHIN_RANGE 0x08
+
+/* 4.3.1.7 Stream Error Code Control */
+#define VS_ERROR_PROTECTED_CONTENT      0x1
+#define VS_ERROR_INPUT_BUFFER_UNDERRUN  0x2
+#define VS_ERROR_DATA_DISCONTINUITY     0x3
+#define VS_ERROR_OUTPUT_BUFFER_UNDERRUN 0x4
+#define VS_ERROR_OUTPUT_BUFFER_OVERRUN  0x5
+#define VS_ERROR_FORMAT_CHANGE          0x6
+#define VS_ERROR_STILL_IMAGE_CAPTURE    0x7
+
+/* A.9.1. VideoControl Interface Control Selectors */
+#define VC_CONTROL_UNDEFINED          0x00
+#define VC_VIDEO_POWER_MODE_CONTROL   0x01
+#define VC_REQUEST_ERROR_CODE_CONTROL 0x02
+
+/* A.9.2. Terminal Control Selectors */
+#define TE_CONTROL_UNDEFINED 0x00
+
+/* A.9.3. Selector Unit Control Selectors */
+#define SU_CONTROL_UNDEFINED    0x00
+#define SU_INPUT_SELECT_CONTROL 0x01
+
+/* A.9.4. Camera Terminal Control Selectors */
+#define CT_CONTROL_UNDEFINED              0x00
+#define CT_SCANNING_MODE_CONTROL          0x01
+#define CT_AE_MODE_CONTROL                0x02
+#define CT_AE_PRIORITY_CONTROL            0x03
+#define CT_EXPOSURE_TIME_ABSOLUTE_CONTROL 0x04
+#define CT_EXPOSURE_TIME_RELATIVE_CONTROL 0x05
+#define CT_FOCUS_ABSOLUTE_CONTROL         0x06
+#define CT_FOCUS_RELATIVE_CONTROL         0x07
+#define CT_FOCUS_AUTO_CONTROL             0x08
+#define CT_IRIS_ABSOLUTE_CONTROL          0x09
+#define CT_IRIS_RELATIVE_CONTROL          0x0A
+#define CT_ZOOM_ABSOLUTE_CONTROL          0x0B
+#define CT_ZOOM_RELATIVE_CONTROL          0x0C
+#define CT_PANTILT_ABSOLUTE_CONTROL       0x0D
+#define CT_PANTILT_RELATIVE_CONTROL       0x0E
+#define CT_ROLL_ABSOLUTE_CONTROL          0x0F
+#define CT_ROLL_RELATIVE_CONTROL          0x10
+#define CT_PRIVACY_CONTROL                0x11
+#define CT_FOCUS_SIMPLE_CONTROL           0x12
+#define CT_WINDOW_CONTROL                 0x13
+#define CT_REGION_OF_INTEREST_CONTROL     0x14
+
+/* A.9.5. Processing Unit Control Selectors */
+#define PU_CONTROL_UNDEFINED                      0x00
+#define PU_BACKLIGHT_COMPENSATION_CONTROL         0x01
+#define PU_BRIGHTNESS_CONTROL                     0x02
+#define PU_CONTRAST_CONTROL                       0x03
+#define PU_GAIN_CONTROL                           0x04
+#define PU_POWER_LINE_FREQUENCY_CONTROL           0x05
+#define PU_HUE_CONTROL                            0x06
+#define PU_SATURATION_CONTROL                     0x07
+#define PU_SHARPNESS_CONTROL                      0x08
+#define PU_GAMMA_CONTROL                          0x09
+#define PU_WHITE_BALANCE_TEMPERATURE_CONTROL      0x0A
+#define PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL 0x0B
+#define PU_WHITE_BALANCE_COMPONENT_CONTROL        0x0C
+#define PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL   0x0D
+#define PU_DIGITAL_MULTIPLIER_CONTROL             0x0E
+#define PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL       0x0F
+#define PU_HUE_AUTO_CONTROL                       0x10
+#define PU_ANALOG_VIDEO_STANDARD_CONTROL          0x11
+#define PU_ANALOG_LOCK_STATUS_CONTROL             0x12
+#define PU_CONTRAST_AUTO_CONTROL                  0x13
+#define PU_MAX                                    0x14 /* self defined */
+
+/* 3.7.2.5 Processing Unit Descriptor bmControl bits */
+#define PU_CONTRL_BRIGHTNESS                     (1 << 0)
+#define PU_CONTRL_CONTRAST                       (1 << 1)
+#define PU_CONTRL_HUE                            (1 << 2)
+#define PU_CONTRL_SATURATION                     (1 << 3)
+#define PU_CONTRL_SHARPNESS                      (1 << 4)
+#define PU_CONTRL_GAMMA                          (1 << 5)
+#define PU_CONTRL_WHITE_BALANCE_TEMPERATURE      (1 << 6)
+#define PU_CONTRL_WHITE_BALANCE_COMPONENT        (1 << 7)
+#define PU_CONTRL_BACKLIGHT_COMPENSATION         (1 << 8)
+#define PU_CONTRL_GAIN                           (1 << 9)
+#define PU_CONTRL_POWER_LINE_FREQUENCY           (1 << 10)
+#define PU_CONTRL_HUE_AUTO                       (1 << 11)
+#define PU_CONTRL_WHITE_BALANCE_TEMPERATURE_AUTO (1 << 12)
+#define PU_CONTRL_WHITE_BALANCE_COMPONENT_AUTO   (1 << 13)
+#define PU_CONTRL_DIGITAL_MULTIPLIER             (1 << 14)
+#define PU_CONTRL_DIGITAL_MULTIPLIER_LIMIT       (1 << 15)
+#define PU_CONTRL_ANALOG_VIDEO_STANDARD          (1 << 16)
+#define PU_CONTRL_ANALOG_VIDEO_LOCK_STATUS       (1 << 17)
+#define PU_CONTRL_CONTRAST_AUTO                  (1 << 18)
+
+/* A.9.6. Encoding Unit Control Selectors */
+#define EU_CONTROL_UNDEFINED           0x00
+#define EU_SELECT_LAYER_CONTROL        0x01
+#define EU_PROFILE_TOOLSET_CONTROL     0x02
+#define EU_VIDEO_RESOLUTION_CONTROL    0x03
+#define EU_MIN_FRAME_INTERVAL_CONTROL  0x04
+#define EU_SLICE_MODE_CONTROL          0x05
+#define EU_RATE_CONTROL_MODE_CONTROL   0x06
+#define EU_AVERAGE_BITRATE_CONTROL     0x07
+#define EU_CPB_SIZE_CONTROL            0x08
+#define EU_PEAK_BIT_RATE_CONTROL       0x09
+#define EU_QUANTIZATION_PARAMS_CONTROL 0x0A
+#define EU_SYNC_REF_FRAME_CONTROL      0x0B
+#define EU_LTR_BUFFER_ CONTROL         0x0C
+#define EU_LTR_PICTURE_CONTROL         0x0D
+#define EU_LTR_VALIDATION_CONTROL      0x0E
+#define EU_LEVEL_IDC_LIMIT_CONTROL     0x0F
+#define EU_SEI_PAYLOADTYPE_CONTROL     0x10
+#define EU_QP_RANGE_CONTROL            0x11
+#define EU_PRIORITY_CONTROL            0x12
+#define EU_START_OR_STOP_LAYER_CONTROL 0x13
+#define EU_ERROR_RESILIENCY_CONTROL    0x14
+
+/* A.9.8. VideoStreaming Interface Control Selectors */
+#define VS_CONTROL_UNDEFINED            0x00
+#define VS_PROBE_CONTROL                0x01
+#define VS_COMMIT_CONTROL               0x02
+#define VS_STILL_PROBE_CONTROL          0x03
+#define VS_STILL_COMMIT_CONTROL         0x04
+#define VS_STILL_IMAGE_TRIGGER_CONTROL  0x05
+#define VS_STREAM_ERROR_CODE_CONTROL    0x06
+#define VS_GENERATE_KEY_FRAME_CONTROL   0x07
+#define VS_UPDATE_FRAME_SEGMENT_CONTROL 0x08
+#define VS_SYNCH_DELAY_CONTROL          0x09
+
+/* B.1. USB Terminal Types */
+#define TT_VENDOR_SPECIFIC 0x0100
+#define TT_STREAMING       0x0101
+
+/* B.2. Input Terminal Types */
+#define ITT_VENDOR_SPECIFIC       0x0200
+#define ITT_CAMERA                0x0201
+#define ITT_MEDIA_TRANSPORT_INPUT 0x0202
+
+/* B.3. Output Terminal Types */
+#define OTT_VENDOR_SPECIFIC        0x0300
+#define OTT_DISPLAY                0x0301
+#define OTT_MEDIA_TRANSPORT_OUTPUT 0x0302
+
+/* B.4. External Terminal Types */
+#define EXTERNAL_VENDOR_SPECIFIC 0x0400
+#define COMPOSITE_CONNECTOR      0x0401
+#define SVIDEO_CONNECTOR         0x0402
+#define COMPONENT_CONNECTOR      0x0403
+
+/* 4.3.1.1. Video Probe and Commit Controls */
+#define VIDEO_CONTROL_dwFrameInterval (1 << 0)
+#define VIDEO_CONTROL_wKeyFrameRate   (1 << 1)
+#define VIDEO_CONTROL_wPFrameRate     (1 << 2)
+#define VIDEO_CONTROL_wCompQuality    (1 << 3)
+#define VIDEO_CONTROL_wCompWindowSize (1 << 4)
+
+#define VIDEO_CONTROL_TEST_AND_SET(bmHint, field, src, dst) \
+        ((VIDEO_CONTROL_##field & bmHint) ? dst->field = src->field : 0)
+
+typedef struct QEMU_PACKED VideoStreamingControl {
+    uint16_t bmHint;
+    uint8_t bFormatIndex;
+    uint8_t bFrameIndex;
+    uint32_t dwFrameInterval;
+    uint16_t wKeyFrameRate;
+    uint16_t wPFrameRate;
+    uint16_t wCompQuality;
+    uint16_t wCompWindowSize;
+    uint16_t wDelay;
+    uint32_t dwMaxVideoFrameSize;
+    uint32_t dwMaxPayloadTransferSize;
+    uint32_t dwClockFrequency;
+    uint8_t bmFramingInfo;
+    uint8_t bPreferedVersion;
+    uint8_t bMinVersion;
+    uint8_t bMaxVersion;
+    uint8_t bUsage;
+    uint8_t bBitDepthLuma;
+    uint8_t bmSettings;
+    uint8_t bMaxNumberOfRefFramesPlus1;
+    uint16_t bmRateControlModes;
+    uint16_t bmLayoutPerStream[4];
+} VideoStreamingControl;
+
+/* 2.4.3.3 Video and Still Image Payload Headers */
+#define PAYLOAD_HEADER_FID (1 << 0)
+#define PAYLOAD_HEADER_EOF (1 << 1)
+#define PAYLOAD_HEADER_PTS (1 << 2)
+#define PAYLOAD_HEADER_SCR (1 << 3)
+#define PAYLOAD_HEADER_RES (1 << 4)
+#define PAYLOAD_HEADER_STI (1 << 5)
+#define PAYLOAD_HEADER_ERR (1 << 6)
+#define PAYLOAD_HEADER_EOH (1 << 7)
+
+typedef struct QEMU_PACKED VideoImagePayloadHeader {
+    uint8_t bHeaderLength;
+    uint8_t bmHeaderInfo;
+    uint32_t dwPresentationTime;
+    /* 6 bytes scrSourceClock */
+    uint32_t dwStc; /* D31..D0 */
+    uint16_t bmSof; /* D42..D32 */
+} VideoImagePayloadHeader;
+
+/* 2.4.2.2 Status Interrupt Endpoint */
+#define STATUS_INTERRUPT_CONTROL   0x1
+#define STATUS_INTERRUPT_STREAMING 0x2
+
+#define STATUS_CONTROL_VALUE_CHANGE   0x00
+#define STATUS_CONTROL_INFO_CHANGE    0x01
+#define STATUS_CONTROL_FAILURE_CHANGE 0x02
+#define STATUS_CONTROL_MIN_CHANGE     0x03
+#define STATUS_CONTROL_MAX_CHANGE     0x04
+
+typedef struct QEMU_PACKED VideoControlStatus {
+    uint8_t bStatusType;
+    uint8_t bOriginator;
+    uint8_t bEvent;
+    uint8_t bSelector;
+    uint8_t bAttribute;
+    uint8_t bValue[4];
+} VideoControlStatus;
+
+#endif
diff --git a/meson.build b/meson.build
index b5f74aa37a..9eb6349182 100644
--- a/meson.build
+++ b/meson.build
@@ -2313,6 +2313,11 @@ if not get_option('libdw').auto() or \
                        required: get_option('libdw'))
 endif
 
+v4l2 = not_found
+if not get_option('v4l2').auto() or (host_os == 'linux' and have_system)
+  v4l2 = declare_dependency()
+endif
+
 #################
 # config-host.h #
 #################
@@ -2361,6 +2366,15 @@ endif
 config_host_data.set('CONFIG_AUDIO_DRIVERS',
                      '"' + '", "'.join(audio_drivers_selected) + '", ')
 
+if have_system
+  video_backend_available = {
+    'v4l2': v4l2.found(),
+  }
+  foreach k, v: video_backend_available
+    config_host_data.set('CONFIG_VIDEO_' + k.to_upper(), v)
+  endforeach
+endif
+
 have_host_block_device = (host_os != 'darwin' or
     cc.has_header('IOKit/storage/IOMedia.h'))
 
@@ -3819,6 +3833,7 @@ subdir('io')
 subdir('chardev')
 subdir('fsdev')
 subdir('dump')
+subdir('video')
 
 if have_block
   block_ss.add(files(
@@ -4932,6 +4947,11 @@ summary_info += {'netmap support':    have_netmap}
 summary_info += {'l2tpv3 support':    have_l2tpv3}
 summary(summary_info, bool_yn: true, section: 'Network backends')
 
+# Video backends
+summary_info = {}
+summary_info += {'v4l2 support':          v4l2}
+summary(summary_info, bool_yn: true, section: 'Video backends')
+
 # Libraries
 summary_info = {}
 summary_info += {'libtasn1':          tasn1}
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..ec2d4236f4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -382,3 +382,6 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+
+option('v4l2', type: 'feature', value: 'auto',
+       description: 'v4l2 video backend support')
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a6..4e2cf31d88 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1088,6 +1088,12 @@ SRST
         ``qemu.wav``.
 ERST
 
+DEF("videodev", HAS_ARG, QEMU_OPTION_videodev,
+#ifdef CONFIG_VIDEO_V4L2
+    "-videodev v4l2,id=id,device=path\n"
+#endif
+    ,QEMU_ARCH_ALL)
+
 DEF("device", HAS_ARG, QEMU_OPTION_device,
     "-device driver[,prop[=value][,...]]\n"
     "                add device (based on driver)\n"
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 73e0770f42..b7ffa51921 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -196,6 +196,7 @@ meson_options_help() {
   printf "%s\n" '  u2f             U2F emulation support'
   printf "%s\n" '  uadk            UADK Library support'
   printf "%s\n" '  usb-redir       libusbredir support'
+  printf "%s\n" '  v4l2            v4l2 video backend support'
   printf "%s\n" '  valgrind        valgrind debug support for coroutine stacks'
   printf "%s\n" '  vde             vde network backend support'
   printf "%s\n" '  vdi             vdi image format support'
@@ -521,6 +522,8 @@ _meson_option_parse() {
     --disable-ubsan) printf "%s" -Dubsan=false ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
+    --enable-v4l2) printf "%s" -Dv4l2=enabled ;;
+    --disable-v4l2) printf "%s" -Dv4l2=disabled ;;
     --enable-valgrind) printf "%s" -Dvalgrind=enabled ;;
     --disable-valgrind) printf "%s" -Dvalgrind=disabled ;;
     --enable-vde) printf "%s" -Dvde=enabled ;;
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c6..48bf4ba8b8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -141,6 +141,7 @@
 #include "system/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
+#include "video/video.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -512,6 +513,16 @@ static QemuOptsList qemu_action_opts = {
     },
 };
 
+static QemuOptsList qemu_videodev_opts = {
+    .name = "videodev",
+    .implied_opt_name = "backend",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_videodev_opts.head),
+    .desc = {
+        /* options are defined in the videodev backends */
+        { /* end of list */ }
+    },
+};
+
 const char *qemu_get_vm_name(void)
 {
     return qemu_name;
@@ -1229,6 +1240,20 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int videodev_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    Error *local_err = NULL;
+
+    if (!qemu_videodev_new_from_opts(opts, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        exit(0);
+    }
+    return 0;
+}
+
 #ifdef CONFIG_VIRTFS
 static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
@@ -2066,6 +2091,9 @@ static void qemu_create_early_backends(void)
     if (default_audio) {
         audio_create_default_audiodevs();
     }
+
+    qemu_opts_foreach(qemu_find_opts("videodev"),
+                      videodev_init_func, NULL, &error_fatal);
 }
 
 
@@ -2876,6 +2904,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
     qemu_add_opts(&qemu_action_opts);
+    qemu_add_opts(&qemu_videodev_opts);
     qemu_add_run_with_opts();
     module_call_init(MODULE_INIT_OPTS);
 
@@ -3707,7 +3736,15 @@ void qemu_init(int argc, char **argv)
                 break;
             }
 #endif /* CONFIG_POSIX */
-
+#if defined(CONFIG_LINUX)
+            case QEMU_OPTION_videodev:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("videodev"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
+#endif /* CONFIG_LINUX */
             default:
                 error_report("Option not supported in this build");
                 exit(1);
diff --git a/video/meson.build b/video/meson.build
new file mode 100644
index 0000000000..278ebdc389
--- /dev/null
+++ b/video/meson.build
@@ -0,0 +1,21 @@
+system_ss.add([files(
+  'video.c',
+)])
+
+# index aliases
+name  = 0
+dep   = 1
+files = 2
+
+video_modules = {}
+foreach m : [
+  ['v4l2', v4l2, files('v4l2.c')],
+]
+  if m[dep].found()
+    module_ss = ss.source_set()
+    module_ss.add(m[dep], m[files])
+    video_modules += {m[name] : module_ss}
+  endif
+endforeach
+
+modules += {'video': video_modules}
diff --git a/video/v4l2.c b/video/v4l2.c
new file mode 100644
index 0000000000..8e7db5240e
--- /dev/null
+++ b/video/v4l2.c
@@ -0,0 +1,619 @@
+/*
+ * Copyright 2025 9elements GmbH
+ * Copyright 2021 Bytedance, Inc.
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *   zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/option.h"
+#include "video/video.h"
+
+#include <linux/videodev2.h>
+#include <sys/ioctl.h>
+
+#define TYPE_VIDEODEV_V4L2 TYPE_VIDEODEV"-v4l2"
+
+#define V4L2_BUFFER_MAX 16
+#define V4L2_BUFFER_DFL 4
+
+typedef struct V4l2Buffer {
+    uint8_t *addr;
+    uint32_t length;
+} V4l2Buffer;
+
+struct V4l2Videodev {
+    Videodev parent;
+    int fd;
+    char* device_path;
+
+    uint8_t nbuffers;
+    V4l2Buffer buffers[V4L2_BUFFER_MAX];
+
+    struct V4l2VideoFrame {
+        int index;
+    } current_frame;
+};
+typedef struct V4l2Videodev V4l2Videodev;
+
+DECLARE_INSTANCE_CHECKER(V4l2Videodev, V4L2_VIDEODEV, TYPE_VIDEODEV_V4L2)
+
+typedef struct VideoV4l2Ctrl {
+    VideoControlType q;
+    uint32_t v;
+} VideoV4l2Ctrl;
+
+static VideoV4l2Ctrl video_v4l2_ctrl_table[] = {
+    { .q = VideoControlTypeBrightness,
+      .v = V4L2_CID_BRIGHTNESS },
+    { .q = VideoControlTypeContrast,
+      .v = V4L2_CID_CONTRAST },
+    { .q = VideoControlTypeGain,
+      .v = V4L2_CID_GAIN },
+    { .q = VideoControlTypeGamma,
+      .v = V4L2_CID_GAMMA },
+    { .q = VideoControlTypeHue,
+      .v = V4L2_CID_HUE },
+    { .q = VideoControlTypeHueAuto,
+      .v = V4L2_CID_HUE_AUTO },
+    { .q = VideoControlTypeSaturation,
+      .v = V4L2_CID_SATURATION },
+    { .q = VideoControlTypeSharpness,
+      .v = V4L2_CID_SHARPNESS },
+    { .q = VideoControlTypeWhiteBalanceTemperature,
+      .v = V4L2_CID_WHITE_BALANCE_TEMPERATURE },
+};
+
+static uint32_t video_qemu_control_to_v4l2(VideoControlType type)
+{
+    for (int i = 0; i < ARRAY_SIZE(video_v4l2_ctrl_table); i++) {
+
+        if (video_v4l2_ctrl_table[i].q == type) {
+            return video_v4l2_ctrl_table[i].v;
+        }
+    }
+
+    return 0;
+}
+
+static VideoControlType video_v4l2_control_to_qemu(const uint32_t id)
+{
+    for (int i = 0; i < ARRAY_SIZE(video_v4l2_ctrl_table); i++) {
+
+        if (video_v4l2_ctrl_table[i].v == id) {
+            return video_v4l2_ctrl_table[i].q;
+        }
+    }
+
+    return VideoControlTypeMax;
+}
+
+static bool video_v4l2_is_capture_device(struct v4l2_capability *cap)
+{
+    return (cap->capabilities & V4L2_CAP_VIDEO_CAPTURE) && (cap->device_caps & V4L2_CAP_VIDEO_CAPTURE);
+}
+
+static int video_v4l2_open(Videodev *vd, QemuOpts *opts, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    const char *device = qemu_opt_get(opts, "device");
+    struct v4l2_capability v4l2_cap = { 0 };
+    struct stat si;
+
+    if (device == NULL) {
+
+        vd_error_setg(vd, errp, QERR_MISSING_PARAMETER, "device");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (stat(device, &si) == -1) {
+
+        vd_error_setg(vd, errp, "cannot identify device %s", device);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (!S_ISCHR(si.st_mode)) {
+
+        vd_error_setg(vd, errp, "'%s' is no device", device);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if ((vv->fd = open(device, O_RDWR | O_NONBLOCK)) == -1) {
+
+        vd_error_setg(vd, errp, "cannot open device '%s'", device);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (ioctl(vv->fd, VIDIOC_QUERYCAP, &v4l2_cap) == -1) {
+
+        close(vv->fd);
+        vd_error_setg(vd, errp, "VIDIOC_QUERYCAP: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (!video_v4l2_is_capture_device(&v4l2_cap)) {
+
+        close(vv->fd);
+        vd_error_setg(vd, errp, "%s is not a video capture device", device);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    vv->device_path = g_strdup(device);
+    vv->nbuffers = V4L2_BUFFER_DFL;
+    vv->current_frame.index = -1;
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_close(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    if (close(vv->fd) != 0) {
+
+        vd_error_setg(vd, errp, "cannot close %s", vv->device_path);
+        return VIDEODEV_RC_ERROR;
+    }
+
+    g_free(vv->device_path);
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_enum_modes(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    VideoMode *mode;
+    VideoFramesize *frmsz;
+    VideoFramerate *frmival;
+    struct v4l2_fmtdesc v4l2_fmt;
+    struct v4l2_frmsizeenum v4l2_frmsz;
+    struct v4l2_frmivalenum v4l2_frmival;
+
+    v4l2_fmt.type = V4L2_CAP_VIDEO_CAPTURE;
+
+    for (v4l2_fmt.index = 0; ioctl(vv->fd, VIDIOC_ENUM_FMT, &v4l2_fmt) == 0; v4l2_fmt.index++) {
+
+        if (!qemu_video_pixfmt_supported(v4l2_fmt.pixelformat)) {
+            continue;
+        }
+
+        vd->nmodes++;
+        vd->modes = g_realloc(vd->modes, vd->nmodes * sizeof(VideoMode));
+
+        mode = &vd->modes[vd->nmodes - 1];
+        mode->pixelformat = v4l2_fmt.pixelformat;
+        mode->framesizes = NULL;
+        mode->nframesize = 0;
+
+        v4l2_frmsz.pixel_format = v4l2_fmt.pixelformat;
+
+        for (v4l2_frmsz.index = 0; ioctl(vv->fd, VIDIOC_ENUM_FRAMESIZES, &v4l2_frmsz) == 0; v4l2_frmsz.index++) {
+
+            if (v4l2_frmsz.type != V4L2_FRMSIZE_TYPE_DISCRETE) {
+                continue;
+            }
+
+            mode->nframesize++;
+            mode->framesizes = g_realloc(mode->framesizes, mode->nframesize * sizeof(VideoFramesize));
+
+            frmsz = &mode->framesizes[mode->nframesize - 1];
+            frmsz->width = v4l2_frmsz.discrete.width;
+            frmsz->height = v4l2_frmsz.discrete.height;
+            frmsz->framerates = NULL;
+            frmsz->nframerate = 0;
+
+            v4l2_frmival.pixel_format = mode->pixelformat;
+            v4l2_frmival.width = frmsz->width;
+            v4l2_frmival.height = frmsz->height;
+
+            for (v4l2_frmival.index = 0; ioctl(vv->fd, VIDIOC_ENUM_FRAMEINTERVALS, &v4l2_frmival) == 0; v4l2_frmival.index++) {
+
+                frmsz->nframerate++;
+                frmsz->framerates = g_realloc(frmsz->framerates, frmsz->nframerate * sizeof(VideoFramerate));
+
+                frmival = &frmsz->framerates[frmsz->nframerate - 1];
+                frmival->numerator = v4l2_frmival.discrete.numerator;
+                frmival->denominator = v4l2_frmival.discrete.denominator;
+            }
+
+            if (errno != EINVAL) {
+
+                vd_error_setg(vd, errp, "VIDIOC_ENUM_FRAMEINTERVALS: %s", strerror(errno));
+                return VIDEODEV_RC_ERROR;
+            }
+        }
+
+        if (errno != EINVAL) {
+
+            vd_error_setg(vd, errp, "VIDIOC_ENUM_FRAMESIZES: %s", strerror(errno));
+            return VIDEODEV_RC_ERROR;
+        }
+    }
+
+    if (errno != EINVAL) {
+
+        vd_error_setg(vd, errp, "VIDIOC_ENUM_FMT: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_enum_controls(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    struct v4l2_queryctrl v4l2_ctrl = { 0 };
+    VideoControlType type;
+
+    while (1) {
+
+        v4l2_ctrl.id |= V4L2_CTRL_FLAG_NEXT_CTRL;
+
+        if (ioctl(vv->fd, VIDIOC_QUERYCTRL, &v4l2_ctrl) < 0) {
+
+            if (errno == EINVAL) {
+                break;
+            }
+
+            vd_error_setg(vd, errp, "VIDIOC_QUERYCTRL: %s", strerror(errno));
+
+            if (vd->controls != NULL)
+                g_free(vd->controls);
+
+            return VIDEODEV_RC_ERROR;
+        }
+
+        if (v4l2_ctrl.flags & V4L2_CTRL_FLAG_INACTIVE) {
+            continue;
+        }
+
+        if ((type = video_v4l2_control_to_qemu(v4l2_ctrl.id)) == VideoControlTypeMax) {
+            continue;
+        }
+
+        vd->ncontrols += 1;
+        vd->controls   = g_realloc(vd->controls, vd->ncontrols * sizeof(VideoControl));
+
+        vd->controls[vd->ncontrols - 1] = (VideoControl) {
+
+            .type = type,
+            .def  = v4l2_ctrl.default_value,
+            .min  = v4l2_ctrl.minimum,
+            .max  = v4l2_ctrl.maximum,
+            .step = v4l2_ctrl.step
+        };
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_set_control(Videodev *vd, VideoControl *ctrl, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    struct v4l2_control v4l2_ctrl;
+    uint32_t cid;
+
+    if ((cid = video_qemu_control_to_v4l2(ctrl->type)) == 0) {
+
+        vd_error_setg(vd, errp, "unsupported control type %d", ctrl->type);
+        return VIDEODEV_RC_INVAL;
+    }
+
+    v4l2_ctrl.id    = cid;
+    v4l2_ctrl.value = ctrl->cur;
+
+    if (ioctl(vv->fd, VIDIOC_S_CTRL, &v4l2_ctrl) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_S_CTRL: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+// @private
+static int video_v4l2_qbuf(Videodev *vd, const int index)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    struct v4l2_buffer buf = {
+
+        .index  = index,
+        .type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+        .field  = V4L2_FIELD_ANY,
+        .memory = V4L2_MEMORY_MMAP
+    };
+
+    return ioctl(vv->fd, VIDIOC_QBUF, &buf);
+}
+
+// @private
+static int video_v4l2_dqbuf(Videodev *vd, int *index)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    int ioctl_status = 0;
+
+    struct v4l2_buffer buf = {
+
+        .type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+        .memory = V4L2_MEMORY_MMAP
+    };
+
+    if ((ioctl_status = ioctl(vv->fd, VIDIOC_DQBUF, &buf)) < 0) {
+        return ioctl_status;
+    }
+
+    *index = buf.index;
+    return ioctl_status;
+}
+
+// @private
+static void video_v4l2_free_buffers(Videodev *vd)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    struct v4l2_requestbuffers v4l2_reqbufs = {
+
+        .count  = 0,
+        .type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+        .memory = V4L2_MEMORY_MMAP
+    };
+
+    for (int i = 0; i < vv->nbuffers; i++) {
+
+        int index = 0;
+        video_v4l2_dqbuf(vd, &index);
+    }
+
+    for (int i = 0; i < vv->nbuffers; i++) {
+
+        V4l2Buffer *current_buf = &vv->buffers[i];
+
+        if (current_buf->addr == NULL) {
+            continue;
+        }
+
+        munmap(current_buf->addr, current_buf->length);
+
+        *current_buf = (V4l2Buffer) {
+
+            .addr   = NULL,
+            .length = 0
+        };
+    }
+
+    ioctl(vv->fd, VIDIOC_REQBUFS, &v4l2_reqbufs);
+}
+
+// @private
+static int video_v4l2_setup_buffers(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    struct v4l2_requestbuffers v4l2_reqbufs = {
+
+        .count  = vv->nbuffers,
+        .type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+        .memory = V4L2_MEMORY_MMAP
+    };
+
+    if (ioctl(vv->fd, VIDIOC_REQBUFS, &v4l2_reqbufs) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_REQBUFS: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    for (int i = 0; i < vv->nbuffers; i++) {
+
+        struct v4l2_buffer v4l2_buf = {
+
+            .index  = i,
+            .type   = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+            .memory = V4L2_MEMORY_MMAP,
+            .length = 0
+        };
+
+        if (ioctl(vv->fd, VIDIOC_QUERYBUF, &v4l2_buf) < 0) {
+
+            vd_error_setg(vd, errp, "VIDIOC_QUERYBUF: %s", strerror(errno));
+            goto video_v4l2_setup_buffers_error;
+        }
+
+        if (v4l2_buf.type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+            continue;
+        }
+
+        void *addr = mmap(NULL, v4l2_buf.length, PROT_READ | PROT_WRITE,
+                          MAP_SHARED, vv->fd, v4l2_buf.m.offset);
+
+        if (addr == MAP_FAILED) {
+
+            vd_error_setg(vd, errp, "mmap: %s", strerror(errno));
+            goto video_v4l2_setup_buffers_error;
+        }
+
+        if (video_v4l2_qbuf(vd, i) < 0) {
+
+            vd_error_setg(vd, errp, "VIDIOC_QBUF: %s", strerror(errno));
+            goto video_v4l2_setup_buffers_error;
+        }
+
+        vv->buffers[i].addr   = addr;
+        vv->buffers[i].length = v4l2_buf.length;
+    }
+
+    return VIDEODEV_RC_OK;
+
+video_v4l2_setup_buffers_error:
+    video_v4l2_free_buffers(vd);
+    return VIDEODEV_RC_ERROR;
+}
+
+// @private
+static int video_v4l2_set_streaming_param(Videodev *vd, Error **errp)
+{
+    struct v4l2_streamparm   stream_param;
+    struct v4l2_captureparm* capture_param;
+    V4l2Videodev*            vv = V4L2_VIDEODEV(vd);
+
+    stream_param.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+    capture_param = &stream_param.parm.capture;
+    capture_param->timeperframe.numerator   = vd->selected.frmrt.numerator;
+    capture_param->timeperframe.denominator = vd->selected.frmrt.denominator;
+
+    if (ioctl(vv->fd, VIDIOC_S_PARM, &stream_param) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_S_PARM: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+// @private
+static int video_v4l2_set_format(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    struct v4l2_format fmt = {
+
+        .type                = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+        .fmt.pix.width       = vd->selected.frmsz->width,
+        .fmt.pix.height      = vd->selected.frmsz->height,
+        .fmt.pix.pixelformat = vd->selected.mode->pixelformat,
+        .fmt.pix.field       = V4L2_FIELD_NONE
+    };
+
+    if (ioctl(vv->fd, VIDIOC_S_FMT, &fmt) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_S_FMT: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (ioctl(vv->fd, VIDIOC_G_FMT, &fmt) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_G_FMT: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_stream_on(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    int type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+    if (video_v4l2_set_format(vd, errp) != VIDEODEV_RC_OK) {
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (video_v4l2_set_streaming_param(vd, errp) != VIDEODEV_RC_OK) {
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (video_v4l2_setup_buffers(vd, errp) != VIDEODEV_RC_OK) {
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (ioctl(vv->fd, VIDIOC_STREAMON, &type) < 0) {
+
+        video_v4l2_free_buffers(vd);
+        vd_error_setg(vd, errp, "VIDIOC_STREAMON: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_stream_off(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+    int type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+    if (ioctl(vv->fd, VIDIOC_STREAMOFF, &type) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_STREAMOFF: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    video_v4l2_free_buffers(vd);
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_claim_frame(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    if (video_v4l2_dqbuf(vd, &vv->current_frame.index) < 0) {
+
+        if (errno == EAGAIN) {
+
+            vd_error_setg(vd, errp, "VIDIOC_DQBUF: underrun");
+            return VIDEODEV_RC_UNDERRUN;
+        }
+
+        vd_error_setg(vd, errp, "VIDIOC_DQBUF: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    vd->current_frame.data       = vv->buffers[vv->current_frame.index].addr;
+    vd->current_frame.bytes_left = vv->buffers[vv->current_frame.index].length;
+
+    return VIDEODEV_RC_OK;
+}
+
+static int video_v4l2_release_frame(Videodev *vd, Error **errp)
+{
+    V4l2Videodev *vv = V4L2_VIDEODEV(vd);
+
+    if (video_v4l2_qbuf(vd, vv->current_frame.index) < 0) {
+
+        vd_error_setg(vd, errp, "VIDIOC_QBUF: %s", strerror(errno));
+        return VIDEODEV_RC_ERROR;
+    }
+
+    vv->current_frame.index      = -1;
+    vd->current_frame.data       = NULL;
+    vd->current_frame.bytes_left = 0;
+
+    return VIDEODEV_RC_OK;
+}
+
+static void video_v4l2_class_init(ObjectClass *oc, const void *data)
+{
+    VideodevClass *vc = VIDEODEV_CLASS(oc);
+
+    vc->open          = video_v4l2_open;
+    vc->close         = video_v4l2_close;
+    vc->enum_modes    = video_v4l2_enum_modes;
+    vc->enum_controls = video_v4l2_enum_controls;
+    vc->set_control   = video_v4l2_set_control;
+    vc->stream_on     = video_v4l2_stream_on;
+    vc->stream_off    = video_v4l2_stream_off;
+    vc->claim_frame   = video_v4l2_claim_frame;
+    vc->release_frame = video_v4l2_release_frame;
+}
+
+static const TypeInfo video_v4l2_type_info = {
+    .name = TYPE_VIDEODEV_V4L2,
+    .parent = TYPE_VIDEODEV,
+    .instance_size = sizeof(V4l2Videodev),
+    .class_init = video_v4l2_class_init,
+};
+
+static void register_types(void) {
+
+    type_register_static(&video_v4l2_type_info);
+}
+
+type_init(register_types);
diff --git a/video/video.c b/video/video.c
new file mode 100644
index 0000000000..3b805f24ae
--- /dev/null
+++ b/video/video.c
@@ -0,0 +1,450 @@
+/*
+ * Copyright 2025 9elements GmbH
+ * Copyright 2021 Bytedance, Inc.
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *   zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/help_option.h"
+#include "qemu/option.h"
+#include "qemu/qemu-print.h"
+#include "video/video.h"
+
+static QLIST_HEAD(, Videodev) videodevs;
+
+typedef struct VideodevClassFE {
+    void (*fn)(const char *name, void *opaque);
+    void *opaque;
+} VideodevClassFE;
+
+static void videodev_class_foreach(ObjectClass *klass, void *opaque)
+{
+    VideodevClassFE *fe = opaque;
+
+    assert(g_str_has_prefix(object_class_get_name(klass), "videodev-"));
+    fe->fn(object_class_get_name(klass) + sizeof(TYPE_VIDEODEV), fe->opaque);
+}
+
+static void videodev_name_foreach(void (*fn)(const char *name, void *opaque), void *opaque)
+{
+    VideodevClassFE fe = { .fn = fn, .opaque = opaque };
+    object_class_foreach(videodev_class_foreach, TYPE_VIDEODEV, false, &fe);
+}
+
+static void help_string_append(const char *name, void *opaque)
+{
+    GString *str = opaque;
+    g_string_append_printf(str, "\n%s", name);
+}
+
+static const VideodevClass *videodev_get_class(const char *backend, Error **errp)
+{
+    ObjectClass *oc;
+    const VideodevClass *vc;
+    char *typename = g_strdup_printf("videodev-%s", backend);
+
+    oc = module_object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_VIDEODEV)) {
+
+        error_setg(errp, "'%s' is not a valid videodev backend name", backend);
+        return NULL;
+    }
+
+    if (object_class_is_abstract(oc)) {
+
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "backend", "a non-abstract device type");
+        return NULL;
+    }
+
+    vc = VIDEODEV_CLASS(oc);
+    return vc;
+}
+
+// @private
+static inline bool videodev_frame_ready(Videodev *vd)
+{
+    return (vd->current_frame.data != NULL) && (vd->current_frame.bytes_left != 0);
+}
+
+// @private
+static int videodev_claim_frame(Videodev *vd, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+    int rc;
+
+    if (vc->claim_frame == NULL) {
+
+        vd_error_setg(vd, errp, "missing 'claim_frame' method!");
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    if ((rc = vc->claim_frame(vd, errp)) != VIDEODEV_RC_OK) {
+        return rc;
+    }
+
+    /*
+     * breaking this assertion means the backend
+     * messed up. It did NOT initialize the current frame
+     * properly despite returning VIDEODEV_RC_OK.
+     *
+     * The solution here is to fix the implementation
+     * of claim_frame
+     * */
+    assert(videodev_frame_ready(vd) == true);
+    return VIDEODEV_RC_OK;
+}
+
+// @private
+static int videodev_release_frame(Videodev *vd, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+    int rc;
+
+    if (vc->release_frame == NULL) {
+
+        vd_error_setg(vd, errp, "missing 'release_frame' method!");
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    if ((rc = vc->release_frame(vd, errp)) != VIDEODEV_RC_OK) {
+        return rc;
+    }
+
+    /*
+     * breaking this assertion means the backend
+     * messed up. It did NOT release the current frame
+     * properly despite returning VIDEODEV_RC_OK.
+     *
+     * The solution here is to fix the implementation
+     * of release_frame
+     * */
+    assert(videodev_frame_ready(vd) == false);
+    return VIDEODEV_RC_OK;
+}
+
+static void videodev_free_modes(Videodev *vd)
+{
+    if (vd->nmodes == 0)
+        return;
+
+    for (int i = 0; i < vd->nmodes; i++) {
+
+        for (int j = 0; j < vd->modes[i].nframesize; j++) {
+
+            g_free(vd->modes[i].framesizes[j].framerates);
+        }
+
+        g_free(vd->modes[i].framesizes);
+    }
+
+    g_free(vd->modes);
+    vd->nmodes = 0;
+    vd->modes  = NULL;
+}
+
+char *qemu_videodev_get_id(Videodev *vd)
+{
+    return vd->id;
+}
+
+Videodev *qemu_videodev_by_id(char *id, Error **errp)
+{
+    Videodev *vd;
+
+    QLIST_FOREACH(vd, &videodevs, list) {
+        if (strcmp(id, vd->id) == 0) {
+            return vd;
+        }
+    }
+
+    error_setg(errp, "videodev '%s' not found", id);
+    return NULL;
+}
+
+void qemu_videodev_register(Videodev *vd, Error **errp)
+{
+    if (vd->registered == true) {
+
+        error_setg(errp, "Videodev already registered");
+        return;
+    }
+
+    vd->registered = true;
+}
+
+Videodev *qemu_videodev_new_from_opts(QemuOpts *opts, Error **errp)
+{
+    Object *obj;
+    Videodev *vd;
+    const VideodevClass *vc;
+    const char *name = qemu_opt_get(opts, "backend");
+    const char *id = qemu_opts_id(opts);
+    Error *local_err = NULL;
+
+    if (name && is_help_option(name)) {
+
+        GString *str = g_string_new("");
+        videodev_name_foreach(help_string_append, str);
+
+        qemu_printf("Available videodev backend types: %s\n", str->str);
+        g_string_free(str, true);
+        return NULL;
+    }
+
+    if (id == NULL) {
+
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        return NULL;
+    }
+
+    if (name == NULL) {
+
+        error_setg(errp, "\"%s\" missing backend", qemu_opts_id(opts));
+        return NULL;
+    }
+
+    if ((vc = videodev_get_class(name, &local_err)) == NULL) {
+        goto propagate_error;
+    }
+
+    if (vc->open == NULL || vc->enum_modes == NULL) {
+
+        error_setg(errp, "missing open/enum_modes method!");
+        return NULL;
+    }
+
+    obj = object_new(object_class_get_name(OBJECT_CLASS(vc)));
+    vd  = VIDEODEV(obj);
+
+    vd->id = g_strdup(id);
+
+    if (vc->open(vd, opts, &local_err) != VIDEODEV_RC_OK) {
+        goto free_and_propagate_error;
+    }
+
+    if (vc->enum_modes(vd, &local_err) != VIDEODEV_RC_OK) {
+        goto free_and_propagate_error;
+    }
+
+    if (vc->enum_controls) {
+
+        if (vc->enum_controls(vd, &local_err) != VIDEODEV_RC_OK) {
+            goto free_and_propagate_error;
+        }
+    }
+
+    QLIST_INSERT_HEAD(&videodevs, vd, list);
+    return vd;
+
+free_and_propagate_error:
+    g_free(vd->id);
+    object_unref(vd);
+propagate_error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+int qemu_videodev_delete(Videodev *vd, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+
+    if (vd->is_streaming == true) {
+        qemu_videodev_stream_off(vd, NULL);
+    }
+
+    if (vc->close) {
+
+        if (vc->close(vd, errp) != VIDEODEV_RC_OK) {
+            return VIDEODEV_RC_ERROR;
+        }
+    }
+
+    videodev_free_modes(vd);
+
+    if (vd->controls != NULL) {
+        g_free(vd->controls);
+    }
+
+    g_free(vd->id);
+    QLIST_REMOVE(vd, list);
+    object_unref(vd);
+
+    return VIDEODEV_RC_OK;
+}
+
+int qemu_videodev_set_control(Videodev *vd, VideoControl *ctrl, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+
+    if (vc->set_control == NULL) {
+
+        vd_error_setg(vd, errp, "missing 'set_control' method!");
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    return vc->set_control(vd, ctrl, errp);
+}
+
+bool qemu_videodev_check_options(Videodev *vd, VideoStreamOptions *opts)
+{
+    if (opts->format_index >= vd->nmodes)
+        return false;
+
+    if (opts->frame_index >= vd->modes[opts->format_index].nframesize)
+        return false;
+
+    return true;
+}
+
+// @private
+static int qemu_videodev_select_options(Videodev *vd, VideoStreamOptions *opts)
+{
+    if (qemu_videodev_check_options(vd, opts) == false) {
+        return VIDEODEV_RC_ERROR;
+    }
+
+    vd->selected.mode  = &vd->modes[opts->format_index];
+    vd->selected.frmsz = &vd->modes[opts->format_index].framesizes[opts->frame_index];
+
+    vd->selected.frmrt.numerator   = 30; // prime number (2 * 3 * 5)
+    vd->selected.frmrt.denominator = 30 * 10000000 / opts->frame_interval;
+
+    return VIDEODEV_RC_OK;
+}
+
+int qemu_videodev_stream_on(Videodev *vd, VideoStreamOptions *opts, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+    int rc;
+
+    if (vd->is_streaming == true) {
+
+        vd_error_setg(vd, errp, "could not enable streaming. Already streaming!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (qemu_videodev_select_options(vd, opts) != VIDEODEV_RC_OK) {
+
+        vd_error_setg(vd, errp, "failed to select options - Invalid mode/framesize");
+        return VIDEODEV_RC_INVAL;
+    }
+
+    if (vc->stream_on == NULL) {
+
+        vd_error_setg(vd, errp, "missing 'stream_on' method!");
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    if ((rc = vc->stream_on(vd, errp)) != VIDEODEV_RC_OK)
+        return rc;
+
+    vd->is_streaming = true;
+    return VIDEODEV_RC_OK;
+}
+
+int qemu_videodev_stream_off(Videodev *vd, Error **errp)
+{
+    VideodevClass *vc = VIDEODEV_GET_CLASS(vd);
+    int rc;
+
+    if (vd->is_streaming == false) {
+
+        vd_error_setg(vd, errp, "could not disable streaming. Already disabled!");
+        return VIDEODEV_RC_ERROR;
+    }
+
+    if (vc->stream_off == NULL) {
+
+        vd_error_setg(vd, errp, "missing 'stream_off' method!");
+        return VIDEODEV_RC_NOTSUP;
+    }
+
+    if (videodev_frame_ready(vd) == true)
+        videodev_release_frame(vd, NULL);
+
+    if ((rc = vc->stream_off(vd, errp)) != VIDEODEV_RC_OK)
+        return rc;
+
+    vd->is_streaming = false;
+    return VIDEODEV_RC_OK;
+}
+
+int qemu_videodev_read_frame(Videodev *vd, const size_t upto, VideoFrameChunk *chunk, Error **errp)
+{
+    int rc;
+
+    if (videodev_frame_ready(vd) == false) {
+
+        if ((rc = videodev_claim_frame(vd, errp)) != VIDEODEV_RC_OK) {
+            return rc;
+        }
+    }
+
+    chunk->size = MIN(vd->current_frame.bytes_left, upto);
+    chunk->data = vd->current_frame.data;
+
+    vd->current_frame.data        = vd->current_frame.data + chunk->size;
+    vd->current_frame.bytes_left -= chunk->size;
+
+    return VIDEODEV_RC_OK;
+}
+
+int qemu_videodev_read_frame_done(Videodev *vd, Error **errp)
+{
+    int rc;
+
+    if (vd->current_frame.bytes_left == 0) {
+
+        if ((rc = videodev_release_frame(vd, errp)) != VIDEODEV_RC_OK) {
+            return rc;
+        }
+    }
+
+    return VIDEODEV_RC_OK;
+}
+
+size_t qemu_videodev_current_frame_length(Videodev *vd) {
+
+    return vd->current_frame.bytes_left;
+}
+
+VideoFramerate *qemu_videodev_get_framerates(Videodev *vd, uint8_t format_idx, uint8_t frame_idx, int *n)
+{
+    *n   = vd->modes[format_idx].framesizes[frame_idx].nframerate;
+    return vd->modes[format_idx].framesizes[frame_idx].framerates;
+}
+
+static void video_instance_init(Object *obj) {
+
+    Videodev *vd = VIDEODEV(obj);
+
+    vd->registered   = false;
+    vd->is_streaming = false;
+}
+
+static const TypeInfo video_type_info = {
+    .name = TYPE_VIDEODEV,
+    .parent = TYPE_OBJECT,
+    .instance_init = video_instance_init,
+    .instance_size = sizeof(Videodev),
+    .abstract = true,
+    .class_size = sizeof(VideodevClass),
+};
+
+static void register_types(void) {
+
+    type_register_static(&video_type_info);
+}
+
+type_init(register_types);
diff --git a/video/video.h b/video/video.h
new file mode 100644
index 0000000000..632db29d8b
--- /dev/null
+++ b/video/video.h
@@ -0,0 +1,298 @@
+/*
+ * Copyright 2025 9elements GmbH
+ * Copyright 2021 Bytedance, Inc.
+ *
+ * Authors:
+ *   David Milosevic <david.milosevic@9elements.com>
+ *   Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+ *   zhenwei pi <pizhenwei@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_VIDEO_H
+#define QEMU_VIDEO_H
+
+#include "qemu/osdep.h"
+#include "hw/qdev-properties-system.h"
+#include "qom/object.h"
+#include "qemu/queue.h"
+
+/*
+ * only to be used after vd->id has been initialized!
+ */
+#define vd_error_setg(vd, errp, fmt, ...) \
+    error_setg(errp, "%s: %s: " fmt, TYPE_VIDEODEV, qemu_videodev_get_id(vd), ## __VA_ARGS__)
+
+#define fourcc_code(a, b, c, d) \
+                          ((uint32_t)(a) | ((uint32_t)(b) << 8) | \
+                          ((uint32_t)(c) << 16) | ((uint32_t)(d) << 24))
+
+/*
+ * custom return codes emitted by Videodev
+ * */
+#define VIDEODEV_RC_OK        0 // everything ok
+#define VIDEODEV_RC_ERROR    -1 // generic error code
+#define VIDEODEV_RC_UNDERRUN -2 // streaming underrun
+#define VIDEODEV_RC_NOTSUP   -3 // operation not supported
+#define VIDEODEV_RC_INVAL    -4 // invalid argument
+
+#define QEMU_VIDEO_PIX_FMT_YUYV   fourcc_code('Y', 'U', 'Y', 'V')
+#define QEMU_VIDEO_PIX_FMT_NV12   fourcc_code('N', 'V', '1', '2')
+#define QEMU_VIDEO_PIX_FMT_MJPEG  fourcc_code('M', 'J', 'P', 'G')
+#define QEMU_VIDEO_PIX_FMT_RGB565 fourcc_code('R', 'G', 'B', 'P')
+
+typedef enum VideoControlType {
+    VideoControlTypeBrightness,
+    VideoControlTypeContrast,
+    VideoControlTypeGain,
+    VideoControlTypeGamma,
+    VideoControlTypeHue,
+    VideoControlTypeHueAuto,
+    VideoControlTypeSaturation,
+    VideoControlTypeSharpness,
+    VideoControlTypeWhiteBalanceTemperature,
+    VideoControlTypeMax
+} VideoControlType;
+
+static inline bool qemu_video_pixfmt_supported(uint32_t pixfmt)
+{
+    switch (pixfmt) {
+    case QEMU_VIDEO_PIX_FMT_YUYV:
+    case QEMU_VIDEO_PIX_FMT_NV12:
+    return true;
+    }
+
+    return false;
+}
+
+typedef struct VideoControl {
+    VideoControlType type;
+    int32_t cur;
+    int32_t def;
+    int32_t min;
+    int32_t max;
+    int32_t step;
+} VideoControl;
+
+typedef struct VideoFramerate {
+    uint32_t numerator;
+    uint32_t denominator;
+} VideoFramerate;
+
+typedef struct VideoFramesize {
+    uint32_t width;
+    uint32_t height;
+    int nframerate;
+    VideoFramerate *framerates;
+} VideoFramesize;
+
+typedef struct VideoModes {
+    uint32_t pixelformat;
+    int nframesize;
+    VideoFramesize *framesizes;
+} VideoMode;
+
+typedef struct VideoStreamOptions {
+    uint8_t format_index;
+    uint8_t frame_index;
+    uint32_t frame_interval;
+} VideoStreamOptions;
+
+typedef struct VideoFrameChunk {
+    void *data;
+    size_t size;
+} VideoFrameChunk;
+
+#define TYPE_VIDEODEV "videodev"
+OBJECT_DECLARE_TYPE(Videodev, VideodevClass, VIDEODEV)
+
+struct Videodev {
+    Object parent_obj;
+
+    char *id;
+    bool registered;
+    bool is_streaming;
+
+    int nmodes;
+    VideoMode *modes;
+
+    int ncontrols;
+    VideoControl *controls;
+
+    struct SelectedStreamOptions {
+        VideoMode *mode;
+        VideoFramesize *frmsz;
+        VideoFramerate frmrt;
+    } selected;
+
+    struct VideoFrame {
+        uint8_t *data;
+        size_t bytes_left;
+    } current_frame;
+
+    QLIST_ENTRY(Videodev) list;
+};
+
+struct VideodevClass {
+    ObjectClass parent_class;
+
+    /*
+     * Called upon construction, consumes QemuOpts* and
+     * opens/starts the backend
+     *
+     * on success:
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*open)(Videodev *vd, QemuOpts *opts, Error **errp);
+
+    /*
+     * [optional]
+     * Called upon deconstruction, closes the backend and frees resources
+     *
+     * on success:
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*close)(Videodev *vd, Error **errp);
+
+    /*
+     * Enumerate all supported modes
+     *
+     * The backend-specific implementation has to allocate
+     * and populate Videodev.modes (automatically free'd by
+     * Videodev upon deconstruction)
+     *
+     * on success:
+     *   creates and populates Videodev.modes
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*enum_modes)(Videodev *vd, Error **errp);
+
+    /*
+     * [optional]
+     * Enumerate camera controls
+     *
+     * Allocates and populates Videodev.controls (automatically
+     * free'd by Videodev upon deconstruction)
+     *
+     * on success:
+     *   creates and populates Videodev.controls
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*enum_controls)(Videodev *vd, Error **errp);
+
+    /*
+     * [optional]
+     * Set camera control settings
+     *
+     * on success:
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*set_control)(Videodev *vd, VideoControl *ctrl, Error **errp);
+
+    /*
+     * Start video capture stream
+     *
+     * This function enables the video streaming by following
+     * a backend-specific procedure.
+     *
+     * on success:
+     *   enables video streaming so that frames can be acquired
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*stream_on)(Videodev *vd, Error **errp);
+
+    /*
+     * Stop video capture stream
+     *
+     * Tbis function disables the video streaming. It is
+     * the counterpart to stream_on.
+     *
+     * on success:
+     *   disables video streaming, reverses stream_on
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*stream_off)(Videodev *vd, Error **errp);
+
+    /*
+     * Claim a single frame from the backend.
+     *
+     * An implementation of claim_frame must acquire the latest
+     * frame from the backend.
+     *
+     * If no frame is ready to be claimed, VIDEODEV_RC_UNDERRUN shall be returned
+     *
+     * on success:
+     *   set Videodev.current_frame.data to acquired frame
+     *   set Videodev.current_frame.bytes_left to total size of acquired frame (> 0)
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   must not modify Videodev.current_frame
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*claim_frame)(Videodev *vd, Error **errp);
+
+    /*
+     * Release a previously acquired frame.
+     *
+     * An implementation of release_frame must cleanup the previously
+     * acquired frame.
+     *
+     * on success:
+     *   set Videodev.current_frame.data to NULL
+     *   set Videodev.current_frame.bytes_left to 0
+     *   returns VIDEODEV_RC_OK
+     * on failure:
+     *   must not modify Videodev.current_frame
+     *   returns no VIDEODEV_RC_OK
+     *   sets @errp accordingly
+     * */
+    int (*release_frame)(Videodev *vd, Error **errp);
+};
+
+/* ====== */
+
+Videodev *qemu_videodev_new_from_opts(QemuOpts *opts, Error **errp);
+int qemu_videodev_delete(Videodev *vd, Error **errp);
+int qemu_videodev_set_control(Videodev *vd, VideoControl *ctrl, Error **errp);
+bool qemu_videodev_check_options(Videodev *vd, VideoStreamOptions *opts);
+int qemu_videodev_stream_on(Videodev *vd, VideoStreamOptions *opts, Error **errp);
+int qemu_videodev_stream_off(Videodev *vd, Error **errp);
+int qemu_videodev_read_frame(Videodev *vd, const size_t upto, VideoFrameChunk *chunk, Error **errp);
+int qemu_videodev_read_frame_done(Videodev *vd, Error **errp);
+size_t qemu_videodev_current_frame_length(Videodev *vd);
+VideoFramerate *qemu_videodev_get_framerates(Videodev *vd, uint8_t format_idx, uint8_t frame_idx, int *n);
+
+/* ====== */
+
+char *qemu_videodev_get_id(Videodev *vd);
+Videodev *qemu_videodev_by_id(char *id, Error **errp);
+void qemu_videodev_register(Videodev *vd, Error **errp);
+
+#define DEFINE_VIDEO_PROPERTIES(_s, _f)         \
+    DEFINE_PROP_VIDEODEV("videodev", _s, _f)
+
+#endif /* QEMU_VIDEO_H */
-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B411C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVucl-0007KV-QN; Fri, 02 Feb 2024 09:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVucj-0007Gv-Lo
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:33 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVucf-0003XQ-JE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:33 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso2003482a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706884348; x=1707489148;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fsos5cDtMXmCbKzxl/HldQGghxS6CytxqE0YUjWp5I4=;
 b=bSiIETdiItshP/ySLuKCVNPTF/FJWjDabPcK3G8Vn8UvG+DnDmNGjWQMZlr6M5ZDxg
 g/Fzdc3sfBy2gosAJw4YdKh7waxnoMW2ZNXUEj8m7xNUxZmISFkr/FPsfFn2VhEveWeJ
 W8KRzKXJP2MpKE0pOZqVdYpjwIlM7oI9Jur1YIkDvs3PsTl3fnstwXXRnrG6PKX/wXRF
 imzxlkIqfTUx48yh0N96E+LVBQH4g1h+G3XtfFBSqafHH7HGLAiq+eun7IQJLuD6SQvS
 686KSdxThemujQjPIYJUXTanCnQMCS6vl2KsKC9uBmJAemXGOP2HAUqZcdQpW7WVKveL
 RfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706884348; x=1707489148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fsos5cDtMXmCbKzxl/HldQGghxS6CytxqE0YUjWp5I4=;
 b=Vp0GRYazCsgEcTaQ5srqEwCFvHBEiTBpTexfbrKh4r1OrJ71kbEuUIYyflTJ0qgSzt
 rk+/j37qz4AVRA0+blwktZc6M+FtgqHhgP1UPCJab2C9cNURG6pW4KBTrAGxaTu/u4k1
 lJqtCEG3fUONzJbiJVZpblKSFwz2PGjAH0ymGXhG+8KY/l7/eS8XOwYcXzN9bN9plUoB
 nl/Dmf1ssrd9e5V7eGMMXzOK92SWL/2fc9ArApTEcFFkGxRXBWYapOrU5WqloidaOTdE
 1XMWjIqOOieUR4WXzlTxgB9SprEXVqfQhXg5a8qtWIfCsl/VLJIy2gc4xlWI8AlM1my/
 Tskw==
X-Gm-Message-State: AOJu0Ywzf3vYvUMRiyAaXIEXa4vMOQAuET8LLB2ivct/HK9cNzLideH8
 C7xv32oy6+It6OpABVMCao3JScf5LaLmT3edFJ2yJpsQyJmJ651QYKt9Who6+u3yideEILNiCFe
 J7OvmHA==
X-Google-Smtp-Source: AGHT+IGWeRJ+RYLyCtgwJOU8gkImfXBEO0FYbeAAZofgHsEaW6r/b6OHTjcBDLxVJFFZEvz+pOpBdw==
X-Received: by 2002:aa7:800b:0:b0:6da:c7ce:ef53 with SMTP id
 j11-20020aa7800b000000b006dac7ceef53mr2193090pfi.3.1706884347271; 
 Fri, 02 Feb 2024 06:32:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVrh2uTa5baV+z5JpyrS7AojQ8ArrQyc45amLMNcXlN9TIQjNjRDRN/NeuiEtm4jy/Y+SfIeRczqeJgtwmTWgwBONbdIATGL3tqaJnEiOFYD28cbOHVdf5Xsi9h1kzkfLupEYbNMNdC8g==
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a056a000b2000b006dde023cce8sm1684703pfu.57.2024.02.02.06.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:32:26 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 2/3] virtio: Declare the decoding functions to static
Date: Fri,  2 Feb 2024 22:32:16 +0800
Message-Id: <7b92f9ccc9ca5e4d6a2e2dd7804f172dc538f355.1706883915.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706883915.git.yong.huang@smartx.com>
References: <cover.1706883915.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
are now only used in virtio-hmp-cmds.c.  So move them into there,
redeclare them to static, and replace the qmp_ prefix with hmp_.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/meson.build       |   3 +-
 hw/virtio/virtio-hmp-cmds.c | 677 +++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-qmp.c      | 661 -----------------------------------
 hw/virtio/virtio-qmp.h      |   3 -
 4 files changed, 670 insertions(+), 674 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 47baf00366..6665669480 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,7 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
-specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
+specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c', 'virtio-hmp-cmds.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
@@ -74,7 +74,6 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
-system_ss.add(files('virtio-hmp-cmds.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 721c630ab0..f95bad0069 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -11,7 +11,668 @@
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
 #include "qapi/qmp/qdict.h"
+#include "hw/virtio/vhost-user.h"
 
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/vhost_types.h"
+#include "standard-headers/linux/virtio_blk.h"
+#include "standard-headers/linux/virtio_console.h"
+#include "standard-headers/linux/virtio_gpu.h"
+#include "standard-headers/linux/virtio_net.h"
+#include "standard-headers/linux/virtio_scsi.h"
+#include "standard-headers/linux/virtio_i2c.h"
+#include "standard-headers/linux/virtio_balloon.h"
+#include "standard-headers/linux/virtio_iommu.h"
+#include "standard-headers/linux/virtio_mem.h"
+#include "standard-headers/linux/virtio_vsock.h"
+#include "standard-headers/linux/virtio_gpio.h"
+
+#include CONFIG_DEVICES
+
+#define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
+    { .virtio_bit = name, .feature_desc = desc }
+
+/* Virtio transport features mapping */
+static const qmp_virtio_feature_map_t virtio_transport_map[] = {
+    /* Virtio device transport features */
+#ifndef VIRTIO_CONFIG_NO_LEGACY
+    FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
+            "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
+            "descs. on VQ"),
+    FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
+            "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
+#endif /* !VIRTIO_CONFIG_NO_LEGACY */
+    FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
+            "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
+    FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
+            "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform"),
+    FEATURE_ENTRY(VIRTIO_F_RING_PACKED, \
+            "VIRTIO_F_RING_PACKED: Device supports packed VQ layout"),
+    FEATURE_ENTRY(VIRTIO_F_IN_ORDER, \
+            "VIRTIO_F_IN_ORDER: Device uses buffers in same order as made "
+            "available by driver"),
+    FEATURE_ENTRY(VIRTIO_F_ORDER_PLATFORM, \
+            "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
+    FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
+            "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
+    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
+            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
+    /* Virtio ring transport features */
+    FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
+            "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
+    FEATURE_ENTRY(VIRTIO_RING_F_EVENT_IDX, \
+            "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled"),
+    { -1, "" }
+};
+
+/* Vhost-user protocol features mapping */
+static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_MQ, \
+            "VHOST_USER_PROTOCOL_F_MQ: Multiqueue protocol supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_LOG_SHMFD, \
+            "VHOST_USER_PROTOCOL_F_LOG_SHMFD: Shared log memory fd supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RARP, \
+            "VHOST_USER_PROTOCOL_F_RARP: Vhost-user back-end RARP broadcasting "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_REPLY_ACK, \
+            "VHOST_USER_PROTOCOL_F_REPLY_ACK: Requested operation status ack. "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_NET_MTU, \
+            "VHOST_USER_PROTOCOL_F_NET_MTU: Expose host MTU to guest supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_REQ, \
+            "VHOST_USER_PROTOCOL_F_BACKEND_REQ: Socket fd for back-end initiated "
+            "requests supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, \
+            "VHOST_USER_PROTOCOL_F_CROSS_ENDIAN: Endianness of VQs for legacy "
+            "devices supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CRYPTO_SESSION, \
+            "VHOST_USER_PROTOCOL_F_CRYPTO_SESSION: Session creation for crypto "
+            "operations supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_PAGEFAULT, \
+            "VHOST_USER_PROTOCOL_F_PAGEFAULT: Request servicing on userfaultfd "
+            "for accessed pages supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIG, \
+            "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for virtio "
+            "device configuration space supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
+            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd communication "
+            "channel supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
+            "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for specified "
+            "VQs supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD, \
+            "VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD: Shared inflight I/O buffers "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RESET_DEVICE, \
+            "VHOST_USER_PROTOCOL_F_RESET_DEVICE: Disabling all rings and "
+            "resetting internal device state supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS, \
+            "VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS: In-band messaging "
+            "supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
+            "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
+            "memory slots supported"),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
+            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
+            "device status supported"),
+    { -1, "" }
+};
+
+/* virtio device configuration statuses */
+static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER_OK, \
+            "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"),
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_FEATURES_OK, \
+            "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete"),
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER, \
+            "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"),
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_NEEDS_RESET, \
+            "VIRTIO_CONFIG_S_NEEDS_RESET: Irrecoverable error, device needs "
+            "reset"),
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_FAILED, \
+            "VIRTIO_CONFIG_S_FAILED: Error in guest, device failed"),
+    FEATURE_ENTRY(VIRTIO_CONFIG_S_ACKNOWLEDGE, \
+            "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found"),
+    { -1, "" }
+};
+
+/* virtio-blk features mapping */
+#ifdef CONFIG_VIRTIO_BLK
+static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
+            "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SEG_MAX, \
+            "VIRTIO_BLK_F_SEG_MAX: Max segments in a request is seg_max"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_GEOMETRY, \
+            "VIRTIO_BLK_F_GEOMETRY: Legacy geometry available"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_RO, \
+            "VIRTIO_BLK_F_RO: Device is read-only"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_BLK_SIZE, \
+            "VIRTIO_BLK_F_BLK_SIZE: Block size of disk available"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_TOPOLOGY, \
+            "VIRTIO_BLK_F_TOPOLOGY: Topology information available"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_MQ, \
+            "VIRTIO_BLK_F_MQ: Multiqueue supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_DISCARD, \
+            "VIRTIO_BLK_F_DISCARD: Discard command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
+            "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
+            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
+            "VIRTIO_BLK_F_ZONED: Zoned block devices"),
+#ifndef VIRTIO_BLK_NO_LEGACY
+    FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
+            "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
+            "VIRTIO_BLK_F_SCSI: SCSI packet commands supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_FLUSH, \
+            "VIRTIO_BLK_F_FLUSH: Flush command supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
+            "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
+            "supported"),
+#endif /* !VIRTIO_BLK_NO_LEGACY */
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-serial features mapping */
+#ifdef CONFIG_VIRTIO_SERIAL
+static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
+            "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
+    FEATURE_ENTRY(VIRTIO_CONSOLE_F_MULTIPORT, \
+            "VIRTIO_CONSOLE_F_MULTIPORT: Multiple ports for device supported"),
+    FEATURE_ENTRY(VIRTIO_CONSOLE_F_EMERG_WRITE, \
+            "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-gpu features mapping */
+#ifdef CONFIG_VIRTIO_GPU
+static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
+            "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
+    FEATURE_ENTRY(VIRTIO_GPU_F_EDID, \
+            "VIRTIO_GPU_F_EDID: EDID metadata supported"),
+    FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_UUID, \
+            "VIRTIO_GPU_F_RESOURCE_UUID: Resource UUID assigning supported"),
+    FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_BLOB, \
+            "VIRTIO_GPU_F_RESOURCE_BLOB: Size-based blob resources supported"),
+    FEATURE_ENTRY(VIRTIO_GPU_F_CONTEXT_INIT, \
+            "VIRTIO_GPU_F_CONTEXT_INIT: Context types and synchronization "
+            "timelines supported"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-input features mapping */
+#ifdef CONFIG_VIRTIO_INPUT
+static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-net features mapping */
+#ifdef CONFIG_VIRTIO_NET
+static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
+            "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
+            "supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_CSUM, \
+            "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial "
+            "checksum supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
+            "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading "
+            "reconfig. supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_MTU, \
+            "VIRTIO_NET_F_MTU: Device max MTU reporting supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_MAC, \
+            "VIRTIO_NET_F_MAC: Device has given MAC address"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO4, \
+            "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO6, \
+            "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ECN, \
+            "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UFO, \
+            "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO4, \
+            "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO6, \
+            "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_ECN, \
+            "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UFO, \
+            "VIRTIO_NET_F_HOST_UFO: Device can receive UFO"),
+    FEATURE_ENTRY(VIRTIO_NET_F_MRG_RXBUF, \
+            "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"),
+    FEATURE_ENTRY(VIRTIO_NET_F_STATUS, \
+            "VIRTIO_NET_F_STATUS: Configuration status field available"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VQ, \
+            "VIRTIO_NET_F_CTRL_VQ: Control channel available"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX, \
+            "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VLAN, \
+            "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX_EXTRA, \
+            "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ANNOUNCE, \
+            "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets "
+            "supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_MQ, \
+            "VIRTIO_NET_F_MQ: Multiqueue with automatic receive steering "
+            "supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
+            "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
+            "channel"),
+    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
+            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
+            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
+            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
+    FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
+            "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
+            "VIRTIO_NET_F_RSS: RSS RX steering supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_RSC_EXT, \
+            "VIRTIO_NET_F_RSC_EXT: Extended coalescing info supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_STANDBY, \
+            "VIRTIO_NET_F_STANDBY: Device acting as standby for primary "
+            "device with same MAC addr. supported"),
+    FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
+            "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
+#ifndef VIRTIO_NET_NO_LEGACY
+    FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
+            "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
+#endif /* !VIRTIO_NET_NO_LEGACY */
+    FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
+            "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
+            "packets supported"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-scsi features mapping */
+#ifdef CONFIG_VIRTIO_SCSI
+static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
+            "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
+            "buffers supported"),
+    FEATURE_ENTRY(VIRTIO_SCSI_F_HOTPLUG, \
+            "VIRTIO_SCSI_F_HOTPLUG: Reporting and handling hot-plug events "
+            "supported"),
+    FEATURE_ENTRY(VIRTIO_SCSI_F_CHANGE, \
+            "VIRTIO_SCSI_F_CHANGE: Reporting and handling LUN changes "
+            "supported"),
+    FEATURE_ENTRY(VIRTIO_SCSI_F_T10_PI, \
+            "VIRTIO_SCSI_F_T10_PI: T10 info included in request header"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio/vhost-user-fs features mapping */
+#ifdef CONFIG_VHOST_USER_FS
+static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio/vhost-user-i2c features mapping */
+#ifdef CONFIG_VIRTIO_I2C_ADAPTER
+static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
+            "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio/vhost-vsock features mapping */
+#ifdef CONFIG_VHOST_VSOCK
+static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
+            "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-balloon features mapping */
+#ifdef CONFIG_VIRTIO_BALLOON
+static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
+            "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
+            "pages"),
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_STATS_VQ, \
+            "VIRTIO_BALLOON_F_STATS_VQ: Guest memory stats VQ available"),
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_DEFLATE_ON_OOM, \
+            "VIRTIO_BALLOON_F_DEFLATE_ON_OOM: Deflate balloon when guest OOM"),
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_FREE_PAGE_HINT, \
+            "VIRTIO_BALLOON_F_FREE_PAGE_HINT: VQ reporting free pages enabled"),
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_PAGE_POISON, \
+            "VIRTIO_BALLOON_F_PAGE_POISON: Guest page poisoning enabled"),
+    FEATURE_ENTRY(VIRTIO_BALLOON_F_REPORTING, \
+            "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-crypto features mapping */
+#ifdef CONFIG_VIRTIO_CRYPTO
+static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-iommu features mapping */
+#ifdef CONFIG_VIRTIO_IOMMU
+static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
+            "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
+            "available"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_DOMAIN_RANGE, \
+            "VIRTIO_IOMMU_F_DOMAIN_RANGE: Number of supported domains "
+            "available"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_MAP_UNMAP, \
+            "VIRTIO_IOMMU_F_MAP_UNMAP: Map and unmap requests available"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS, \
+            "VIRTIO_IOMMU_F_BYPASS: Endpoints not attached to domains are in "
+            "bypass mode"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_PROBE, \
+            "VIRTIO_IOMMU_F_PROBE: Probe requests available"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_MMIO, \
+            "VIRTIO_IOMMU_F_MMIO: VIRTIO_IOMMU_MAP_F_MMIO flag available"),
+    FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS_CONFIG, \
+            "VIRTIO_IOMMU_F_BYPASS_CONFIG: Bypass field of IOMMU config "
+            "available"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-mem features mapping */
+#ifdef CONFIG_VIRTIO_MEM
+static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
+#ifndef CONFIG_ACPI
+    FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
+            "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
+#endif /* !CONFIG_ACPI */
+    FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
+            "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
+            "accessed"),
+    { -1, "" }
+};
+#endif
+
+/* virtio-rng features mapping */
+#ifdef CONFIG_VIRTIO_RNG
+static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+/* virtio/vhost-gpio features mapping */
+#ifdef CONFIG_VHOST_USER_GPIO
+static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
+            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
+            "negotiation supported"),
+    { -1, "" }
+};
+#endif
+
+#define CONVERT_FEATURES(type, map, is_status, bitmap)   \
+    ({                                                   \
+        type *list = NULL;                               \
+        type *node;                                      \
+        for (i = 0; map[i].virtio_bit != -1; i++) {      \
+            if (is_status) {                             \
+                bit = map[i].virtio_bit;                 \
+            }                                            \
+            else {                                       \
+                bit = 1ULL << map[i].virtio_bit;         \
+            }                                            \
+            if ((bitmap & bit) == 0) {                   \
+                continue;                                \
+            }                                            \
+            node = g_new0(type, 1);                      \
+            node->value = g_strdup(map[i].feature_desc); \
+            node->next = list;                           \
+            list = node;                                 \
+            bitmap ^= bit;                               \
+        }                                                \
+        list;                                            \
+    })
+
+static VhostDeviceProtocols *hmp_decode_protocols(uint64_t bitmap)
+{
+    VhostDeviceProtocols *vhu_protocols;
+    uint64_t bit;
+    int i;
+
+    vhu_protocols = g_new0(VhostDeviceProtocols, 1);
+    vhu_protocols->protocols =
+                    CONVERT_FEATURES(strList,
+                                     vhost_user_protocol_map, 0, bitmap);
+    vhu_protocols->has_unknown_protocols = bitmap != 0;
+    if (vhu_protocols->has_unknown_protocols) {
+        vhu_protocols->unknown_protocols = bitmap;
+    }
+
+    return vhu_protocols;
+}
+
+static VirtioDeviceStatus *hmp_decode_status(uint8_t bitmap)
+{
+    VirtioDeviceStatus *status;
+    uint8_t bit;
+    int i;
+
+    status = g_new0(VirtioDeviceStatus, 1);
+    status->statuses = CONVERT_FEATURES(strList, virtio_config_status_map,
+                                        1, bitmap);
+    status->has_unknown_statuses = bitmap != 0;
+    if (status->has_unknown_statuses) {
+        status->unknown_statuses = bitmap;
+    }
+
+    return status;
+}
+
+static VirtioDeviceFeatures *hmp_decode_features(uint16_t device_id,
+                                                 uint64_t bitmap)
+{
+    VirtioDeviceFeatures *features;
+    uint64_t bit;
+    int i;
+
+    features = g_new0(VirtioDeviceFeatures, 1);
+    features->has_dev_features = true;
+
+    /* transport features */
+    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
+                                            bitmap);
+
+    /* device features */
+    switch (device_id) {
+#ifdef CONFIG_VIRTIO_SERIAL
+    case VIRTIO_ID_CONSOLE:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_BLK
+    case VIRTIO_ID_BLOCK:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_GPU
+    case VIRTIO_ID_GPU:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_NET
+    case VIRTIO_ID_NET:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_SCSI
+    case VIRTIO_ID_SCSI:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_BALLOON
+    case VIRTIO_ID_BALLOON:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_IOMMU
+    case VIRTIO_ID_IOMMU:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_INPUT
+    case VIRTIO_ID_INPUT:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VHOST_USER_FS
+    case VIRTIO_ID_FS:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VHOST_VSOCK
+    case VIRTIO_ID_VSOCK:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_CRYPTO
+    case VIRTIO_ID_CRYPTO:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_MEM
+    case VIRTIO_ID_MEM:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_I2C_ADAPTER
+    case VIRTIO_ID_I2C_ADAPTER:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_RNG
+    case VIRTIO_ID_RNG:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VHOST_USER_GPIO
+    case VIRTIO_ID_GPIO:
+        features->dev_features =
+            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+        break;
+#endif
+    /* No features */
+    case VIRTIO_ID_9P:
+    case VIRTIO_ID_PMEM:
+    case VIRTIO_ID_IOMEM:
+    case VIRTIO_ID_RPMSG:
+    case VIRTIO_ID_CLOCK:
+    case VIRTIO_ID_MAC80211_WLAN:
+    case VIRTIO_ID_MAC80211_HWSIM:
+    case VIRTIO_ID_RPROC_SERIAL:
+    case VIRTIO_ID_MEMORY_BALLOON:
+    case VIRTIO_ID_CAIF:
+    case VIRTIO_ID_SIGNAL_DIST:
+    case VIRTIO_ID_PSTORE:
+    case VIRTIO_ID_SOUND:
+    case VIRTIO_ID_BT:
+    case VIRTIO_ID_RPMB:
+    case VIRTIO_ID_VIDEO_ENCODER:
+    case VIRTIO_ID_VIDEO_DECODER:
+    case VIRTIO_ID_SCMI:
+    case VIRTIO_ID_NITRO_SEC_MOD:
+    case VIRTIO_ID_WATCHDOG:
+    case VIRTIO_ID_CAN:
+    case VIRTIO_ID_DMABUF:
+    case VIRTIO_ID_PARAM_SERV:
+    case VIRTIO_ID_AUDIO_POLICY:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    features->has_unknown_dev_features = bitmap != 0;
+    if (features->has_unknown_dev_features) {
+        features->unknown_dev_features = bitmap;
+    }
+
+    return features;
+}
 
 static void hmp_virtio_dump_protocols(Monitor *mon,
                                       VhostDeviceProtocols *pcol)
@@ -147,16 +808,16 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
                    s->device_endian);
     monitor_printf(mon, "  status:\n");
     hmp_virtio_dump_status(mon,
-        qmp_decode_status(s->status));
+        hmp_decode_status(s->status));
     monitor_printf(mon, "  Guest features:\n");
     hmp_virtio_dump_features(mon,
-        qmp_decode_features(s->device_id, s->guest_features));
+        hmp_decode_features(s->device_id, s->guest_features));
     monitor_printf(mon, "  Host features:\n");
     hmp_virtio_dump_features(mon,
-        qmp_decode_features(s->device_id, s->host_features));
+        hmp_decode_features(s->device_id, s->host_features));
     monitor_printf(mon, "  Backend features:\n");
     hmp_virtio_dump_features(mon,
-        qmp_decode_features(s->device_id, s->backend_features));
+        hmp_decode_features(s->device_id, s->backend_features));
 
     if (s->vhost_dev) {
         monitor_printf(mon, "  VHost:\n");
@@ -178,16 +839,16 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
                        s->vhost_dev->log_size);
         monitor_printf(mon, "    Features:\n");
         hmp_virtio_dump_features(mon,
-            qmp_decode_features(s->device_id, s->vhost_dev->features));
+            hmp_decode_features(s->device_id, s->vhost_dev->features));
         monitor_printf(mon, "    Acked features:\n");
         hmp_virtio_dump_features(mon,
-            qmp_decode_features(s->device_id, s->vhost_dev->acked_features));
+            hmp_decode_features(s->device_id, s->vhost_dev->acked_features));
         monitor_printf(mon, "    Backend features:\n");
         hmp_virtio_dump_features(mon,
-            qmp_decode_features(s->device_id, s->vhost_dev->backend_features));
+            hmp_decode_features(s->device_id, s->vhost_dev->backend_features));
         monitor_printf(mon, "    Protocol features:\n");
         hmp_virtio_dump_protocols(mon,
-            qmp_decode_protocols(s->vhost_dev->protocol_features));
+            hmp_decode_protocols(s->vhost_dev->protocol_features));
     }
 
     qapi_free_VirtioStatus(s);
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1660c17653..37a1296604 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -17,667 +17,6 @@
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qjson.h"
-#include "hw/virtio/vhost-user.h"
-
-#include "standard-headers/linux/virtio_ids.h"
-#include "standard-headers/linux/vhost_types.h"
-#include "standard-headers/linux/virtio_blk.h"
-#include "standard-headers/linux/virtio_console.h"
-#include "standard-headers/linux/virtio_gpu.h"
-#include "standard-headers/linux/virtio_net.h"
-#include "standard-headers/linux/virtio_scsi.h"
-#include "standard-headers/linux/virtio_i2c.h"
-#include "standard-headers/linux/virtio_balloon.h"
-#include "standard-headers/linux/virtio_iommu.h"
-#include "standard-headers/linux/virtio_mem.h"
-#include "standard-headers/linux/virtio_vsock.h"
-#include "standard-headers/linux/virtio_gpio.h"
-
-#include CONFIG_DEVICES
-
-#define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
-    { .virtio_bit = name, .feature_desc = desc }
-
-/* Virtio transport features mapping */
-static const qmp_virtio_feature_map_t virtio_transport_map[] = {
-    /* Virtio device transport features */
-#ifndef VIRTIO_CONFIG_NO_LEGACY
-    FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
-            "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
-            "descs. on VQ"),
-    FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
-            "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
-#endif /* !VIRTIO_CONFIG_NO_LEGACY */
-    FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
-            "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
-    FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
-            "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform"),
-    FEATURE_ENTRY(VIRTIO_F_RING_PACKED, \
-            "VIRTIO_F_RING_PACKED: Device supports packed VQ layout"),
-    FEATURE_ENTRY(VIRTIO_F_IN_ORDER, \
-            "VIRTIO_F_IN_ORDER: Device uses buffers in same order as made "
-            "available by driver"),
-    FEATURE_ENTRY(VIRTIO_F_ORDER_PLATFORM, \
-            "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
-    FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
-            "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
-    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
-            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
-    /* Virtio ring transport features */
-    FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
-            "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
-    FEATURE_ENTRY(VIRTIO_RING_F_EVENT_IDX, \
-            "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled"),
-    { -1, "" }
-};
-
-/* Vhost-user protocol features mapping */
-static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_MQ, \
-            "VHOST_USER_PROTOCOL_F_MQ: Multiqueue protocol supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_LOG_SHMFD, \
-            "VHOST_USER_PROTOCOL_F_LOG_SHMFD: Shared log memory fd supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RARP, \
-            "VHOST_USER_PROTOCOL_F_RARP: Vhost-user back-end RARP broadcasting "
-            "supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_REPLY_ACK, \
-            "VHOST_USER_PROTOCOL_F_REPLY_ACK: Requested operation status ack. "
-            "supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_NET_MTU, \
-            "VHOST_USER_PROTOCOL_F_NET_MTU: Expose host MTU to guest supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_REQ, \
-            "VHOST_USER_PROTOCOL_F_BACKEND_REQ: Socket fd for back-end initiated "
-            "requests supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, \
-            "VHOST_USER_PROTOCOL_F_CROSS_ENDIAN: Endianness of VQs for legacy "
-            "devices supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CRYPTO_SESSION, \
-            "VHOST_USER_PROTOCOL_F_CRYPTO_SESSION: Session creation for crypto "
-            "operations supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_PAGEFAULT, \
-            "VHOST_USER_PROTOCOL_F_PAGEFAULT: Request servicing on userfaultfd "
-            "for accessed pages supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIG, \
-            "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for virtio "
-            "device configuration space supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
-            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd communication "
-            "channel supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
-            "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for specified "
-            "VQs supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD, \
-            "VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD: Shared inflight I/O buffers "
-            "supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RESET_DEVICE, \
-            "VHOST_USER_PROTOCOL_F_RESET_DEVICE: Disabling all rings and "
-            "resetting internal device state supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS, \
-            "VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS: In-band messaging "
-            "supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
-            "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
-            "memory slots supported"),
-    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
-            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
-            "device status supported"),
-    { -1, "" }
-};
-
-/* virtio device configuration statuses */
-static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER_OK, \
-            "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"),
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_FEATURES_OK, \
-            "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete"),
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER, \
-            "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"),
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_NEEDS_RESET, \
-            "VIRTIO_CONFIG_S_NEEDS_RESET: Irrecoverable error, device needs "
-            "reset"),
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_FAILED, \
-            "VIRTIO_CONFIG_S_FAILED: Error in guest, device failed"),
-    FEATURE_ENTRY(VIRTIO_CONFIG_S_ACKNOWLEDGE, \
-            "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found"),
-    { -1, "" }
-};
-
-/* virtio-blk features mapping */
-#ifdef CONFIG_VIRTIO_BLK
-static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
-            "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_SEG_MAX, \
-            "VIRTIO_BLK_F_SEG_MAX: Max segments in a request is seg_max"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_GEOMETRY, \
-            "VIRTIO_BLK_F_GEOMETRY: Legacy geometry available"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_RO, \
-            "VIRTIO_BLK_F_RO: Device is read-only"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_BLK_SIZE, \
-            "VIRTIO_BLK_F_BLK_SIZE: Block size of disk available"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_TOPOLOGY, \
-            "VIRTIO_BLK_F_TOPOLOGY: Topology information available"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_MQ, \
-            "VIRTIO_BLK_F_MQ: Multiqueue supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_DISCARD, \
-            "VIRTIO_BLK_F_DISCARD: Discard command supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
-            "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
-            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
-            "VIRTIO_BLK_F_ZONED: Zoned block devices"),
-#ifndef VIRTIO_BLK_NO_LEGACY
-    FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
-            "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
-            "VIRTIO_BLK_F_SCSI: SCSI packet commands supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_FLUSH, \
-            "VIRTIO_BLK_F_FLUSH: Flush command supported"),
-    FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
-            "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
-            "supported"),
-#endif /* !VIRTIO_BLK_NO_LEGACY */
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-serial features mapping */
-#ifdef CONFIG_VIRTIO_SERIAL
-static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
-            "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
-    FEATURE_ENTRY(VIRTIO_CONSOLE_F_MULTIPORT, \
-            "VIRTIO_CONSOLE_F_MULTIPORT: Multiple ports for device supported"),
-    FEATURE_ENTRY(VIRTIO_CONSOLE_F_EMERG_WRITE, \
-            "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-gpu features mapping */
-#ifdef CONFIG_VIRTIO_GPU
-static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
-            "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
-    FEATURE_ENTRY(VIRTIO_GPU_F_EDID, \
-            "VIRTIO_GPU_F_EDID: EDID metadata supported"),
-    FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_UUID, \
-            "VIRTIO_GPU_F_RESOURCE_UUID: Resource UUID assigning supported"),
-    FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_BLOB, \
-            "VIRTIO_GPU_F_RESOURCE_BLOB: Size-based blob resources supported"),
-    FEATURE_ENTRY(VIRTIO_GPU_F_CONTEXT_INIT, \
-            "VIRTIO_GPU_F_CONTEXT_INIT: Context types and synchronization "
-            "timelines supported"),
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-input features mapping */
-#ifdef CONFIG_VIRTIO_INPUT
-static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-net features mapping */
-#ifdef CONFIG_VIRTIO_NET
-static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
-            "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
-            "supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_CSUM, \
-            "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial "
-            "checksum supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-            "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading "
-            "reconfig. supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_MTU, \
-            "VIRTIO_NET_F_MTU: Device max MTU reporting supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_MAC, \
-            "VIRTIO_NET_F_MAC: Device has given MAC address"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO4, \
-            "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO6, \
-            "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ECN, \
-            "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UFO, \
-            "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO4, \
-            "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO6, \
-            "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HOST_ECN, \
-            "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UFO, \
-            "VIRTIO_NET_F_HOST_UFO: Device can receive UFO"),
-    FEATURE_ENTRY(VIRTIO_NET_F_MRG_RXBUF, \
-            "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"),
-    FEATURE_ENTRY(VIRTIO_NET_F_STATUS, \
-            "VIRTIO_NET_F_STATUS: Configuration status field available"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VQ, \
-            "VIRTIO_NET_F_CTRL_VQ: Control channel available"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX, \
-            "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VLAN, \
-            "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX_EXTRA, \
-            "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ANNOUNCE, \
-            "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets "
-            "supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_MQ, \
-            "VIRTIO_NET_F_MQ: Multiqueue with automatic receive steering "
-            "supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
-            "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
-            "channel"),
-    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
-            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
-    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
-            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
-            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
-    FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
-            "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
-            "VIRTIO_NET_F_RSS: RSS RX steering supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_RSC_EXT, \
-            "VIRTIO_NET_F_RSC_EXT: Extended coalescing info supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_STANDBY, \
-            "VIRTIO_NET_F_STANDBY: Device acting as standby for primary "
-            "device with same MAC addr. supported"),
-    FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
-            "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
-#ifndef VIRTIO_NET_NO_LEGACY
-    FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
-            "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
-#endif /* !VIRTIO_NET_NO_LEGACY */
-    FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
-            "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
-            "packets supported"),
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-scsi features mapping */
-#ifdef CONFIG_VIRTIO_SCSI
-static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
-            "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
-            "buffers supported"),
-    FEATURE_ENTRY(VIRTIO_SCSI_F_HOTPLUG, \
-            "VIRTIO_SCSI_F_HOTPLUG: Reporting and handling hot-plug events "
-            "supported"),
-    FEATURE_ENTRY(VIRTIO_SCSI_F_CHANGE, \
-            "VIRTIO_SCSI_F_CHANGE: Reporting and handling LUN changes "
-            "supported"),
-    FEATURE_ENTRY(VIRTIO_SCSI_F_T10_PI, \
-            "VIRTIO_SCSI_F_T10_PI: T10 info included in request header"),
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio/vhost-user-fs features mapping */
-#ifdef CONFIG_VHOST_USER_FS
-static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio/vhost-user-i2c features mapping */
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
-static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
-            "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio/vhost-vsock features mapping */
-#ifdef CONFIG_VHOST_VSOCK
-static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
-            "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-balloon features mapping */
-#ifdef CONFIG_VIRTIO_BALLOON
-static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
-            "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
-            "pages"),
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_STATS_VQ, \
-            "VIRTIO_BALLOON_F_STATS_VQ: Guest memory stats VQ available"),
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_DEFLATE_ON_OOM, \
-            "VIRTIO_BALLOON_F_DEFLATE_ON_OOM: Deflate balloon when guest OOM"),
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_FREE_PAGE_HINT, \
-            "VIRTIO_BALLOON_F_FREE_PAGE_HINT: VQ reporting free pages enabled"),
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_PAGE_POISON, \
-            "VIRTIO_BALLOON_F_PAGE_POISON: Guest page poisoning enabled"),
-    FEATURE_ENTRY(VIRTIO_BALLOON_F_REPORTING, \
-            "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-crypto features mapping */
-#ifdef CONFIG_VIRTIO_CRYPTO
-static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-iommu features mapping */
-#ifdef CONFIG_VIRTIO_IOMMU
-static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
-            "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
-            "available"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_DOMAIN_RANGE, \
-            "VIRTIO_IOMMU_F_DOMAIN_RANGE: Number of supported domains "
-            "available"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_MAP_UNMAP, \
-            "VIRTIO_IOMMU_F_MAP_UNMAP: Map and unmap requests available"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS, \
-            "VIRTIO_IOMMU_F_BYPASS: Endpoints not attached to domains are in "
-            "bypass mode"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_PROBE, \
-            "VIRTIO_IOMMU_F_PROBE: Probe requests available"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_MMIO, \
-            "VIRTIO_IOMMU_F_MMIO: VIRTIO_IOMMU_MAP_F_MMIO flag available"),
-    FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS_CONFIG, \
-            "VIRTIO_IOMMU_F_BYPASS_CONFIG: Bypass field of IOMMU config "
-            "available"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-mem features mapping */
-#ifdef CONFIG_VIRTIO_MEM
-static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
-#ifndef CONFIG_ACPI
-    FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
-            "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
-#endif /* !CONFIG_ACPI */
-    FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
-            "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
-            "accessed"),
-    { -1, "" }
-};
-#endif
-
-/* virtio-rng features mapping */
-#ifdef CONFIG_VIRTIO_RNG
-static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
-    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
-            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-/* virtio/vhost-gpio features mapping */
-#ifdef CONFIG_VHOST_USER_GPIO
-static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
-    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
-            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
-    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
-            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
-            "negotiation supported"),
-    { -1, "" }
-};
-#endif
-
-#define CONVERT_FEATURES(type, map, is_status, bitmap)   \
-    ({                                                   \
-        type *list = NULL;                               \
-        type *node;                                      \
-        for (i = 0; map[i].virtio_bit != -1; i++) {      \
-            if (is_status) {                             \
-                bit = map[i].virtio_bit;                 \
-            }                                            \
-            else {                                       \
-                bit = 1ULL << map[i].virtio_bit;         \
-            }                                            \
-            if ((bitmap & bit) == 0) {                   \
-                continue;                                \
-            }                                            \
-            node = g_new0(type, 1);                      \
-            node->value = g_strdup(map[i].feature_desc); \
-            node->next = list;                           \
-            list = node;                                 \
-            bitmap ^= bit;                               \
-        }                                                \
-        list;                                            \
-    })
-
-VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
-{
-    VirtioDeviceStatus *status;
-    uint8_t bit;
-    int i;
-
-    status = g_new0(VirtioDeviceStatus, 1);
-    status->statuses = CONVERT_FEATURES(strList, virtio_config_status_map,
-                                        1, bitmap);
-    status->has_unknown_statuses = bitmap != 0;
-    if (status->has_unknown_statuses) {
-        status->unknown_statuses = bitmap;
-    }
-
-    return status;
-}
-
-VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
-{
-    VhostDeviceProtocols *vhu_protocols;
-    uint64_t bit;
-    int i;
-
-    vhu_protocols = g_new0(VhostDeviceProtocols, 1);
-    vhu_protocols->protocols =
-                    CONVERT_FEATURES(strList,
-                                     vhost_user_protocol_map, 0, bitmap);
-    vhu_protocols->has_unknown_protocols = bitmap != 0;
-    if (vhu_protocols->has_unknown_protocols) {
-        vhu_protocols->unknown_protocols = bitmap;
-    }
-
-    return vhu_protocols;
-}
-
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
-{
-    VirtioDeviceFeatures *features;
-    uint64_t bit;
-    int i;
-
-    features = g_new0(VirtioDeviceFeatures, 1);
-    features->has_dev_features = true;
-
-    /* transport features */
-    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
-                                            bitmap);
-
-    /* device features */
-    switch (device_id) {
-#ifdef CONFIG_VIRTIO_SERIAL
-    case VIRTIO_ID_CONSOLE:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_BLK
-    case VIRTIO_ID_BLOCK:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_GPU
-    case VIRTIO_ID_GPU:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_NET
-    case VIRTIO_ID_NET:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_SCSI
-    case VIRTIO_ID_SCSI:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_BALLOON
-    case VIRTIO_ID_BALLOON:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_IOMMU
-    case VIRTIO_ID_IOMMU:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_INPUT
-    case VIRTIO_ID_INPUT:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VHOST_USER_FS
-    case VIRTIO_ID_FS:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VHOST_VSOCK
-    case VIRTIO_ID_VSOCK:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_CRYPTO
-    case VIRTIO_ID_CRYPTO:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_MEM
-    case VIRTIO_ID_MEM:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
-    case VIRTIO_ID_I2C_ADAPTER:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VIRTIO_RNG
-    case VIRTIO_ID_RNG:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
-        break;
-#endif
-#ifdef CONFIG_VHOST_USER_GPIO
-    case VIRTIO_ID_GPIO:
-        features->dev_features =
-            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
-        break;
-#endif
-    /* No features */
-    case VIRTIO_ID_9P:
-    case VIRTIO_ID_PMEM:
-    case VIRTIO_ID_IOMEM:
-    case VIRTIO_ID_RPMSG:
-    case VIRTIO_ID_CLOCK:
-    case VIRTIO_ID_MAC80211_WLAN:
-    case VIRTIO_ID_MAC80211_HWSIM:
-    case VIRTIO_ID_RPROC_SERIAL:
-    case VIRTIO_ID_MEMORY_BALLOON:
-    case VIRTIO_ID_CAIF:
-    case VIRTIO_ID_SIGNAL_DIST:
-    case VIRTIO_ID_PSTORE:
-    case VIRTIO_ID_SOUND:
-    case VIRTIO_ID_BT:
-    case VIRTIO_ID_RPMB:
-    case VIRTIO_ID_VIDEO_ENCODER:
-    case VIRTIO_ID_VIDEO_DECODER:
-    case VIRTIO_ID_SCMI:
-    case VIRTIO_ID_NITRO_SEC_MOD:
-    case VIRTIO_ID_WATCHDOG:
-    case VIRTIO_ID_CAN:
-    case VIRTIO_ID_DMABUF:
-    case VIRTIO_ID_PARAM_SERV:
-    case VIRTIO_ID_AUDIO_POLICY:
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    features->has_unknown_dev_features = bitmap != 0;
-    if (features->has_unknown_dev_features) {
-        features->unknown_dev_features = bitmap;
-    }
-
-    return features;
-}
 
 static int query_dev_child(Object *child, void *opaque)
 {
diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
index 245a446a56..7aa1bb3c08 100644
--- a/hw/virtio/virtio-qmp.h
+++ b/hw/virtio/virtio-qmp.h
@@ -16,8 +16,5 @@
 #include "hw/virtio/vhost.h"
 
 VirtIODevice *qmp_find_virtio_device(const char *path);
-VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
-VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
-VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
 
 #endif
-- 
2.31.1



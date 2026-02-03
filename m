Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD67E8B361
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSO-0006hx-Uk; Tue, 03 Feb 2026 15:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSH-0006e6-Il
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:01 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSE-0003Vu-UC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:57:01 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c5513f598c0so43817a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152217; x=1770757017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1d+/91JShFPwrkJUMSmFdVCFBtHWCReGt22lXLOogUI=;
 b=XhlYT3lIMs0XxDrdnnX6rJPayiE/frlwf9P9eK6YBIGClwABO9m6Xe6iKESk/0jbSk
 QroxGfXOm+cWGYtlw0CTIZoUKo5qztQ00ctC88bLtEVLolOqgM5+JC3Vww1kkAM6MUVt
 RM+Qv6AMOr0nbNFmwqQ+K6sItJwt9vnrnSN8YckcwIyv8uKl5HrUycKZppC3RS9gv+BC
 5pYduLUeq+hhvpC58d3+oklt5HSTWxVMAv8HzeeePC98q6YGnBrGBOTfcW7G1UiAKq/1
 E8lCa5/euAVsKAxNgsefKM6zXKz/lexas3Xw3CrHBmc4sYGfV2I0ILAv3IY4abfg2pk7
 ICSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152217; x=1770757017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1d+/91JShFPwrkJUMSmFdVCFBtHWCReGt22lXLOogUI=;
 b=isxURxgIRIGhv/VgyBFj+gwFpSMPX85YyfYJu1as+EOk9VRqyrSfEFDihEFi/h6A8o
 CTP/v0QcDe8m829rySB1TKFAHGGFWRNsQpfhxHn36wWFPb/IDut9cyOvqreT8fSDd69q
 tgx0lZ9n0ShWlgsXRT59fH1AAcCefuFxH5Ivnw/sr2QS/+qHtJNFJOoxAUZVfM6PIjhb
 ix47cHN6ElGvtPHqj0siIJPLckniXZ2ZWPWxSjzEkpuQRlD2KyAvpnmyW75ARiBu3H45
 VUnEnmPP9KpCx2yFyZ1fbMpZq/Z7nOWsnuMMUKg4n2C6+DcJMe3VucSjHpf9+0v5D1XX
 mVVw==
X-Gm-Message-State: AOJu0Ywmvd7y/BZ4prTNHbzbQM4N7r7pkJm+yxG7p/Fo9uzUNeq8Zt4i
 29+UiVsXp4YCmgVvrPq5tX4b/A3eyhgkBZTg58AJarwWBMr3ml+UebIdKY6lYYVTovVjz61oXMa
 ncCNbeH0=
X-Gm-Gg: AZuq6aIcR7HmuBKek1q0wPlX64lySoKfCf9WYsDM+lZv/6c6HiyD3hecbGvZIZCNyFQ
 UBFgc1CTigukD2t1wydfM+zEYRytevWfgHr3HUti9r7s9hP57zynOyG6cC98qt0RYq/2bqpOHhQ
 mJC3BQBSGD/omOg+ct4TogZY0aKv6F+ctb3kNtTdo/ohnoQg2nouW08dgA3twVevEP/wn5YuPjZ
 SmmEsANMED2gz26m8pBlaa3AvSVuEvAUG0iiab+h3keBzBrntZUfKNWubUYX7OkuydxlodJSiYt
 8JpFTOtrMCHAtPO7HG2cL09VCpPKt7MbL/j8ohQK7gxOfR9BM5Bm6/Rkp/TtO2PZ4lMRZImu1MB
 eb+9gyptVJymI62V62qlPGSL079aNGI1xa/GJJbqXAQGSaFMfZJamWEPE4hgIqjPeUkmlW3X5Ae
 D9CILYthEEUv1WQmphmlp8SZQ1Hcpma3gnVH++Ke7FifRmLFrb8/eJCqqYOFpT1/Qc
X-Received: by 2002:a17:902:e806:b0:2a7:87c0:2357 with SMTP id
 d9443c01a7336-2a933ce207cmr5544215ad.20.1770152217149; 
 Tue, 03 Feb 2026 12:56:57 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:56 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 8/9] hw/virtio/virtio-qmp: make compilation unit common
Date: Tue,  3 Feb 2026 12:56:36 -0800
Message-ID: <20260203205637.3109749-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All compile time conditionals have no impact at runtime, since they are
representing only possible features for devices present at runtime.

In case they are not present, associated features table will never be
used. In case they are present but some features are not, matching bits
will never be enabled, so those entries will be unused.

Thus, simply expose everything and call it a day.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/virtio-qmp.c | 70 ------------------------------------------
 hw/virtio/meson.build  |  2 +-
 2 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 968299fda0c..f9cdca50d99 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -33,21 +33,17 @@
 #include "standard-headers/linux/virtio_vsock.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
-#include CONFIG_DEVICES
-
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
 /* Virtio transport features mapping */
 static const qmp_virtio_feature_map_t virtio_transport_map[] = {
     /* Virtio device transport features */
-#ifndef VIRTIO_CONFIG_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
             "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
             "descs. on VQ"),
     FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
             "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
-#endif /* !VIRTIO_CONFIG_NO_LEGACY */
     FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
             "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
     FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
@@ -149,7 +145,6 @@ static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
 };
 
 /* virtio-blk features mapping */
-#ifdef CONFIG_VIRTIO_BLK
 static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
             "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
@@ -173,7 +168,6 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
-#ifndef VIRTIO_BLK_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
             "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
@@ -183,7 +177,6 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
             "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
             "supported"),
-#endif /* !VIRTIO_BLK_NO_LEGACY */
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
@@ -191,10 +184,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-serial features mapping */
-#ifdef CONFIG_VIRTIO_SERIAL
 static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
             "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
@@ -204,10 +195,8 @@ static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
             "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-gpu features mapping */
-#ifdef CONFIG_VIRTIO_GPU
 static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
             "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
@@ -227,10 +216,8 @@ static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-input features mapping */
-#ifdef CONFIG_VIRTIO_INPUT
 static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -239,10 +226,8 @@ static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-net features mapping */
-#ifdef CONFIG_VIRTIO_NET
 static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
             "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
@@ -313,10 +298,8 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
             "device with same MAC addr. supported"),
     FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
             "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
-#ifndef VIRTIO_NET_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
             "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
-#endif /* !VIRTIO_NET_NO_LEGACY */
     FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
             "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
             "packets supported"),
@@ -341,10 +324,8 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
             "header"),
     { -1, "" }
 };
-#endif
 
 /* virtio-scsi features mapping */
-#ifdef CONFIG_VIRTIO_SCSI
 static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
             "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
@@ -364,10 +345,8 @@ static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-user-fs features mapping */
-#ifdef CONFIG_VHOST_USER_FS
 static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -376,10 +355,8 @@ static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-user-i2c features mapping */
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
 static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
             "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
@@ -390,10 +367,8 @@ static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-vsock features mapping */
-#ifdef CONFIG_VHOST_VSOCK
 static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
             "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
@@ -404,10 +379,8 @@ static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-balloon features mapping */
-#ifdef CONFIG_VIRTIO_BALLOON
 static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
             "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
@@ -424,19 +397,15 @@ static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
             "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
     { -1, "" }
 };
-#endif
 
 /* virtio-crypto features mapping */
-#ifdef CONFIG_VIRTIO_CRYPTO
 static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio-iommu features mapping */
-#ifdef CONFIG_VIRTIO_IOMMU
 static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
             "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
@@ -458,15 +427,11 @@ static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
             "available"),
     { -1, "" }
 };
-#endif
 
 /* virtio-mem features mapping */
-#ifdef CONFIG_VIRTIO_MEM
 static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
-#ifndef CONFIG_ACPI
     FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
             "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
-#endif /* !CONFIG_ACPI */
     FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
             "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
             "accessed"),
@@ -475,10 +440,8 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
             "plugged when suspending+resuming"),
     { -1, "" }
 };
-#endif
 
 /* virtio-rng features mapping */
-#ifdef CONFIG_VIRTIO_RNG
 static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
     FEATURE_ENTRY(VHOST_F_LOG_ALL, \
             "VHOST_F_LOG_ALL: Logging write descriptors supported"),
@@ -487,10 +450,8 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 /* virtio/vhost-gpio features mapping */
-#ifdef CONFIG_VHOST_USER_GPIO
 static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
             "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
@@ -499,7 +460,6 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
             "negotiation supported"),
     { -1, "" }
 };
-#endif
 
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
@@ -595,96 +555,66 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
 
     /* device features */
     switch (device_id) {
-#ifdef CONFIG_VIRTIO_SERIAL
     case VIRTIO_ID_CONSOLE:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_BLK
     case VIRTIO_ID_BLOCK:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_GPU
     case VIRTIO_ID_GPU:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_NET
     case VIRTIO_ID_NET:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_SCSI
     case VIRTIO_ID_SCSI:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_BALLOON
     case VIRTIO_ID_BALLOON:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_IOMMU
     case VIRTIO_ID_IOMMU:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_INPUT
     case VIRTIO_ID_INPUT:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_USER_FS
     case VIRTIO_ID_FS:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_VSOCK
     case VIRTIO_ID_VSOCK:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_CRYPTO
     case VIRTIO_ID_CRYPTO:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_MEM
     case VIRTIO_ID_MEM:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_I2C_ADAPTER
     case VIRTIO_ID_I2C_ADAPTER:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VIRTIO_RNG
     case VIRTIO_ID_RNG:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
         break;
-#endif
-#ifdef CONFIG_VHOST_USER_GPIO
     case VIRTIO_ID_GPIO:
         features->dev_features =
             CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
         break;
-#endif
     /* No features */
     case VIRTIO_ID_9P:
     case VIRTIO_ID_PMEM:
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index ee397aaf196..d913b94e1ca 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -11,7 +11,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
-specific_virtio_ss.add(files('virtio-qmp.c'))
+system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-- 
2.47.3



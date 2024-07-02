Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D062BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjtv-0003MD-3M; Tue, 02 Jul 2024 16:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtt-0003M0-Sa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjts-0007dV-BZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=ifoEUJbcmQLHrNcUOZp0Qsj8Rk3S5Hoha7e8WBNzecjCsL64VOqtl0NhGD6MpomeB07R0d
 LBdMjUpPGMBHxYBrzXMdnbtsmLQqtWb2wV0mjCdpbNQAssKw9OGcCq+FPmyBeaY5+1gw9+
 rpgTKj06HAarE/8BdUqZMv1DJkkof8U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-7RnuDCL4MGuJSGYzeTCZSg-1; Tue, 02 Jul 2024 16:14:50 -0400
X-MC-Unique: 7RnuDCL4MGuJSGYzeTCZSg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4258675a531so14505125e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951288; x=1720556088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=OcOvZmK4uZm2QoZs76HWbCK7F3oMTHaG6S0ZyaXFB0ZCzyq8mYVw6I5nMcvYv/tFUa
 WP60rzdjNsErXQ3gIOoN2Kh7tpGz9fUX+qFUZ39o1dztJUNu0FnbP8nkIj7X9iTAzGBt
 pH6KAxeoyooz9L9jG1HhQAtYyyavHDcQDrX41Y7hsjbiBnLJI8dhyKxMvLR9kQ+vGQpJ
 39MHmjud4SV4KVcvWnLfyT8ZpczTc8k3jDK8/zmHHt1YrMyUqOOxNNxlZwNZpsWvCI0c
 4amtQuQqb56OZX0+GuWR2dj6KKWdamOg+kzlEJHR10X8GwRsQ3NZax5eRqT6pQQHNdZg
 0Uig==
X-Gm-Message-State: AOJu0Yx72BfDH7gGQ/KFjQ/I46rcclHloToxDZuO8erVGQjgavZVHpn1
 R+t1BhWhzeQWxCrm59ZkPh8kdfUd2LlLgSHEhENxycBFA2FT5Nnq9LHfW3C8aOUQlqKwePBy1fH
 lfv+qtFXeZbj7vnPjmS172oBD6PnLeQwQv5ec8pqqCO59pGHlOVCEggznY131ZO59k6Zk34oqCk
 ovg4w9pUXQNRYME9aKj7JYNEb4t5x5uw==
X-Received: by 2002:a05:6000:1aca:b0:366:ead6:6198 with SMTP id
 ffacd0b85a97d-36775696c0bmr6993027f8f.2.1719951288439; 
 Tue, 02 Jul 2024 13:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+dXUNcLOu+juR1AFIk5Ju7GBfr6GNKNlap0LZoRDAqr4T23uAwNjRIJgVCIjPsPsf5MLF0A==
X-Received: by 2002:a05:6000:1aca:b0:366:ead6:6198 with SMTP id
 ffacd0b85a97d-36775696c0bmr6992997f8f.2.1719951287586; 
 Tue, 02 Jul 2024 13:14:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12fcsm14085179f8f.48.2024.07.02.13.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:47 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 16/91] hw/cxl/mailbox: change CCI cmd set structure to be a
 member, not a reference
Message-ID: <05b70ceba033759d44c6d3d9b24118cd9fc9d616.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gregory Price <gourry.memverge@gmail.com>

This allows devices to have fully customized CCIs, along with complex
devices where wrapper devices can override or add additional CCI
commands without having to replicate full command structures or
pollute a base device with every command that might ever be used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-2-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  2 +-
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 279b276bda..ccc4611875 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -164,7 +164,7 @@ typedef struct CXLEventLog {
 } CXLEventLog;
 
 typedef struct CXLCCI {
-    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
         uint16_t opcode;
         uint16_t effect;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e5eb97cb91..2c9f50f0f9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1447,10 +1447,21 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
                                  bg_timercb, cci);
 }
 
+static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
+{
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmds[set][cmd].handler) {
+                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1458,7 +1469,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
@@ -1476,7 +1487,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
 void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_ld;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_ld);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1496,7 +1507,7 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_fm_owned_ld_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
-- 
MST



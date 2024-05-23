Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E0DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZ6-00069A-HU; Thu, 23 May 2024 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYh-0005wz-TQ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYT-0003e1-Nh
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:48:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f2ecea41deso118211815ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486519; x=1717091319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUY+tVIrLXlBWDYAZLBMIzgstxLzMinOnAd95xKbspQ=;
 b=lNnosEGQJm4g6YCEo9UHHvg4wxzOxIWXviyMqt8/VXfDeayg4wYPbIKzgVVvrbhg5F
 BSnsCOd1pVOJ5cwBRvpUC4WU0vvdSGyp9VbUj+e6LfJ4f3rkPV1GwVWs/aDUFigGMSNO
 pezxRGv6aSxNBb5mfrp33GORCl4+0vMI7RNgQG1ROHuPgVubmkYYBIDmuV+4uZOzMP8V
 J1Of04rHmmTXTnSKOZVmo9Ebw+E0Iiqdu3/gmyrVykhhhJl0OyhLe8Ew+vxdpmEf1TeS
 T6bv+rzDWQiyw5aMCrcN1dt+jEtw5SrK/arJ31fhqoOM5kMG3+P7LL2eQ7JH3EGiK9ac
 V95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486519; x=1717091319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUY+tVIrLXlBWDYAZLBMIzgstxLzMinOnAd95xKbspQ=;
 b=oWyzxfJTtlqBJvzRuegeTObiU9m+S54H+B+rVy2bI4n02EvkJ6TRNDR13xBNeBISus
 ff0hzMV+KTyYU+b2U7sxDvaKkxYYu7vVHGosrETKNV5uMRRIEu/3lmt9M8SwCT4kpGgi
 DUAm28XdgkijrksCJwP4/Z2yIWIbWVszpLf38lGil7ExkreYp0Rd/XiFw9/0pArj1t0t
 xg7ba4SQX4Pa2JWfCp+CwRbMFEMFMf2gl00OHx8uYRIWLtlv1qFjyiGT4uyJxDOAi7rE
 efIM+V/SyuNrOl9wTh9Ty6UZdFudRhk84rwOHOm/2gXaj9qBBhWDdwOz9Z9y9JAvYaPu
 n7CQ==
X-Gm-Message-State: AOJu0YxxASrwZGj2/hTePV0BF8RS6Ixy1JYDT2Y/AFy0EIZGC/486nYQ
 Tf+udyWdOHCs6S9ADcGNSwGNQbwkMtfxKvgKG6QIuZqLl6QXJ/0stiDYCQ==
X-Google-Smtp-Source: AGHT+IFf20NX3YEVB79xFwOa3YX1k2qEZb8NgiEQW9xioF3Hrc65GPKe5k6j4CXoBHvaPjkpWIscPA==
X-Received: by 2002:a17:903:22c6:b0:1ec:e3c2:790e with SMTP id
 d9443c01a7336-1f4486fe183mr792505ad.19.1716486519218; 
 Thu, 23 May 2024 10:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:38 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Gregory Price <gourry.memverge@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v8 01/14] hw/cxl/mailbox: change CCI cmd set structure to be a
 member, not a reference
Date: Thu, 23 May 2024 10:44:41 -0700
Message-ID: <20240523174651.1089554-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++----
 include/hw/cxl/cxl_device.h |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

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
-- 
2.43.0



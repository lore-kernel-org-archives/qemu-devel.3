Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800E2D60D14
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 08:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgSj-00007Z-Sc; Wed, 20 Nov 2024 03:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSZ-00005r-HV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSX-0004sB-4j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43169902057so54450925e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732092790; x=1732697590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk1t/53BIyz7NwFEHJ20Vl04uwLXRm6KfCax7gzeCvM=;
 b=YMYi9VMhcBf00EeS/iw807KtpFo4FkW8H0O2R2uxWKdV/5POgFXuRLTrxE2+3JiaB7
 15uM1jZFQz87nrLOWe6nVUzEOd/qOlzFI8/42Xy6lRkJ9OeAb/yErxvC/wzpEleKf8n6
 52JygQij730ACPmW0CcxUqUl/0vIns7+2pokP+iwwg76E3tul3Lk7FVchr70o2ZxY6N0
 nJqj2HwY2TTICDPEBi/t1TNnNsfgxFM4xuc3xoN4ueI2YCVi2BshcqBbxFDnxDxaM8vZ
 fUN3eRikVtuV7pQ/wkwT+o3G8qrHnC0u0k/4Fr9bC89yIqpHSj35JSNbd7a5BnDCJE0+
 kc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732092790; x=1732697590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vk1t/53BIyz7NwFEHJ20Vl04uwLXRm6KfCax7gzeCvM=;
 b=A5TkqshaXw92aXVKt1Ah8kIgV4GNHrdwDkB9JdfrvI0ZKJBXpFMum0Bc3gdmiTX5XT
 TKdfCkx2IhYfE7H6wgwvQ/dHQq26YN0jnibg6/0zsfgwEqyH/dH7qaUNwDZty0uUYE+e
 y4X0ta0r0DOQr8mIByFZp22UHOiSZ8RPeJ0SRI3oU6NzsiHFdRi8FuMI+4jhvVPI5Spr
 LKU5tPk05hs4XADOiJhkqBXGr2XrHhHY/+Zt2HbPXs+UDUci80NFgtFUeH3h5xkUlvfb
 lXhwpxl4Gpt9DfVcxCMOujsScdMb5AyNlZ8gVNW0cmYhlWXrjBCFYQyzDZvs3fCUH5H1
 LQRw==
X-Gm-Message-State: AOJu0YyYIK6CCeCNF55haKBT299/aPsrnbA8X/lJWOAS1csKWWXHl1Lg
 UX+3fGJs/uaH/aVKrSn0Z6Oz6FiCdoCG32UfcNMrtVWjEHL1Gshy2vHx4JRz50rpO1THMmSdjZC
 QlOQ=
X-Google-Smtp-Source: AGHT+IHSAC3R7yGdoqzkvrgiAWs5JMzRZn39HHMJE9QDZv4QGXihnqSGq8GY40jxSMUsl2CGHUdOZA==
X-Received: by 2002:a05:600c:444f:b0:431:58cd:b260 with SMTP id
 5b1f17b1804b1-4334f01815emr14901355e9.25.1732092789828; 
 Wed, 20 Nov 2024 00:53:09 -0800 (PST)
Received: from localhost.localdomain ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463b0d1sm11287495e9.42.2024.11.20.00.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Nov 2024 00:53:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/s390x: Declare loadparm as char[LOADPARM_LEN]
Date: Wed, 20 Nov 2024 09:52:59 +0100
Message-ID: <20241120085300.49866-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120085300.49866-1-philmd@linaro.org>
References: <20241120085300.49866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"hw/s390x/ipl/qipl.h" defines loadparm[] length as LOADPARM_LEN,
use that instead of the magic '8' value. Use a char type for
char buffer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ccw-device.h               | 5 +++--
 hw/s390x/ipl.h                      | 2 +-
 include/hw/qdev-properties-system.h | 2 +-
 include/hw/s390x/s390-virtio-ccw.h  | 3 ++-
 hw/core/qdev-properties-system.c    | 8 +++++---
 hw/s390x/ipl.c                      | 6 +++---
 hw/scsi/scsi-disk.c                 | 2 +-
 7 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 4439feb140..94a9b35714 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -15,6 +15,7 @@
 #include "hw/qdev-core.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/s390x/ipl/qipl.h"
 
 struct CcwDevice {
     DeviceState parent_obj;
@@ -27,7 +28,7 @@ struct CcwDevice {
     /* The actual busid of the virtual subchannel. */
     CssDevId subch_id;
     /* If set, use this loadparm value when device is boot target */
-    uint8_t loadparm[8];
+    char loadparm[LOADPARM_LEN];
 };
 typedef struct CcwDevice CcwDevice;
 
@@ -54,6 +55,6 @@ OBJECT_DECLARE_TYPE(CcwDevice, CCWDeviceClass, CCW_DEVICE)
 extern const PropertyInfo ccw_loadparm;
 
 #define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))
+    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(char[LOADPARM_LEN]))
 
 #endif
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d7d0b7bfd2..014b530ad2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -23,7 +23,7 @@
 #define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
-void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
+void s390_ipl_fmt_loadparm(char *loadparm, char *str, Error **errp);
 void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 7ec37f6316..844af7a200 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -3,7 +3,7 @@
 
 #include "hw/qdev-properties.h"
 
-bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
+bool qdev_prop_sanitize_s390x_loadparm(char *loadparm, const char *str,
                                        Error **errp);
 
 extern const PropertyInfo qdev_prop_chr;
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 996864a34e..9d4e00b0c7 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -14,6 +14,7 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 #include "hw/s390x/sclp.h"
+#include "hw/s390x/ipl/qipl.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
 
@@ -28,7 +29,7 @@ struct S390CcwMachineState {
     bool aes_key_wrap;
     bool dea_key_wrap;
     bool pv;
-    uint8_t loadparm[8];
+    char loadparm[LOADPARM_LEN];
 
     SCLPDevice *sclp;
 };
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a61c5ee6dd..e8e9cd8e04 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -35,6 +35,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
 #include "hw/i386/x86.h"
+#include "hw/s390x/ipl/qipl.h"
 #include "util/block-helpers.h"
 
 static bool check_prop_still_unset(Object *obj, const char *name,
@@ -58,14 +59,15 @@ static bool check_prop_still_unset(Object *obj, const char *name,
     return false;
 }
 
-bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
+bool qdev_prop_sanitize_s390x_loadparm(char *loadparm, const char *str,
                                        Error **errp)
 {
     int i, len;
 
     len = strlen(str);
-    if (len > 8) {
-        error_setg(errp, "'loadparm' can only contain up to 8 characters");
+    if (len > LOADPARM_LEN) {
+        error_setg(errp, "'loadparm' can only contain up to %u characters",
+                         LOADPARM_LEN);
         return false;
     }
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 30734661ad..6fd3774c7d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -416,7 +416,7 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
     return chain_addr;
 }
 
-void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
+void s390_ipl_fmt_loadparm(char *loadparm, char *str, Error **errp)
 {
     /* Initialize the loadparm with spaces */
     memset(loadparm, ' ', LOADPARM_LEN);
@@ -439,8 +439,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
-    uint8_t *lp;
-    g_autofree void *scsi_lp = NULL;
+    char *lp;
+    g_autofree char *scsi_lp = NULL;
 
     /*
      * Currently allow IPL only from CCW devices.
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8e553487d5..96a09fe170 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3145,7 +3145,7 @@ static char *scsi_property_get_loadparm(Object *obj, Error **errp)
 static void scsi_property_set_loadparm(Object *obj, const char *value,
                                        Error **errp)
 {
-    void *lp_str;
+    char *lp_str;
 
     if (object_property_get_int(obj, "bootindex", NULL) < 0) {
         error_setg(errp, "'loadparm' is only valid for boot devices");
-- 
2.45.2



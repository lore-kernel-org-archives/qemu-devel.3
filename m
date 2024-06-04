Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7E1C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZV0-00070R-IZ; Tue, 04 Jun 2024 15:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUy-0006lZ-7y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUu-0000rF-OZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=d2McZaScrJE+3/kB6scOlG/HEIZ/guTD4BxnNFupXCV5axzWC1NWtH1zRT8g0chY8H6CZL
 OB6UhdTH69HawqXxrxP+fHX2jYW8SOAuG0xQtD9As0iTbxkLlHW6//xzacOKLNK0AOIj/3
 fdJUEhJav4EJXhFwPaMWc6aBsR5Arjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-N969WC7VOGyjXVsTfZPDoA-1; Tue, 04 Jun 2024 15:07:01 -0400
X-MC-Unique: N969WC7VOGyjXVsTfZPDoA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212aeac0e2so670555e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528020; x=1718132820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=rrj69GU8/JNvGovU+Yx1edrJOijN6V1ZnAGM95diWfgwnlRJDNDRWukTa4f+oi3SbQ
 zsiQY8QyZqvgXfy5I5I2EkLWCIPLWeVdrUO7hBjcmoAGuktp3TUGveJoSm5g8eZufwV3
 g2BmZYHAwpvo+yv8mSMfhkDtOvv/De7y5JQmG8OfjVglIEgVIGxGYN5dU29TLwhQux/K
 nzCwVLnymJq/S7Cfj11KgyUVxYV3sR26XEMUUiMRfF41jUoO4kSVOu1QK7LmGzFQIAKi
 9KUSOYO9rE91M90XUD7oGiAHaW3gYwdvg9f3hkKmRNwdHLnubPIL6seW6V+6Cye7ZwS+
 hgHA==
X-Gm-Message-State: AOJu0YwjCxYbKqf0Uly9gizaAiCRbWb9CvuKQiwTVQ7mvjTHn9jfgy/Y
 SGGtGJ7jUcaMYZZte+cPVdHGiFryEOZNcPgRchpBIIFyfb9OW0SAaWIHas3AaLQIB8jzjBd2/TP
 AYh3yxjKt1reme7VQOxThML9g8fIl7SWF5+LQFF+QO+Fj4C/sm+uluIYC8DGyRHQmbJOCL4rXIL
 NZ/yqLMFCd6FTulL4CKA8LoP+zqff2Zg==
X-Received: by 2002:a05:600c:3589:b0:41f:dc27:a7c1 with SMTP id
 5b1f17b1804b1-421562da803mr4715045e9.5.1717528019822; 
 Tue, 04 Jun 2024 12:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+VLGrrKlFVj2OzhlD8Ew6iFdVY76qPENPt7iFHIz7OSYBtzYjKhRNYJ37i2LY30o+4ENsHA==
X-Received: by 2002:a05:600c:3589:b0:41f:dc27:a7c1 with SMTP id
 5b1f17b1804b1-421562da803mr4714885e9.5.1717528019397; 
 Tue, 04 Jun 2024 12:06:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213709a0d2sm125137665e9.26.2024.06.04.12.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:58 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 17/46] hw/cxl/mailbox: change CCI cmd set structure to be a
 member, not a reference
Message-ID: <69a99663c31fbc854e45b124406987347a87bd41.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



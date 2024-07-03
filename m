Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522D1C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jc-0003o5-RK; Wed, 03 Jul 2024 18:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jO-0003Pv-LF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8jJ-0001HM-Jl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=XhD66ozsSpZ7WR9iYabHQjKpADPEzo1pakZovXRFYlWdqUvKAloss0wHUy2AiLAVnFJPJT
 aU9lPxu8op5J0poIUzUpt9v1FNGMm1PKgIeIZeXLD+8nTp7h93ssy7/yuvpj9hIeKbDIFs
 InHroW+v/RO0F08JrN+Mle5sZPUkYz4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-4P1TOXXxO_qlQxGN2WQw_A-1; Wed, 03 Jul 2024 18:45:35 -0400
X-MC-Unique: 4P1TOXXxO_qlQxGN2WQw_A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-58c859c5d96so1039110a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046734; x=1720651534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=A1sa4erN88nNpgBw9UMeo48IKvA1oWfyVwK3K2Be9IONtkEUwFamuzalba7gMXu8Pg
 eUr/czh0JEo9/0XtBARmtQ4L2eVhpQq7oHGOPLCMSYnkTlB8tQcDvmRydbv82Ti4rPIp
 EZOZrjg4b9JoL9hlome6cFemGqcv2sYMBkDa2LsJCZ7T2ej7jFQfnfXGTE2T/BYAAdvq
 fCaPV0Y3MWQPV5aC6E1YNwyaI68H1kl6JXt1kdy13OptkfTtyW6rIHLN/tYMxiM3aV2W
 LHXCAxZerQdhOhXFwA4uXg840xh3o81IE/HgQ0uSEFRlPGGjSKo3wKLxYI7P44koYh5y
 xV1w==
X-Gm-Message-State: AOJu0YxnOUPvoyon88xk5Y+GVA7MC3mn8MIsmY/EXnTp0GzO3HLo5Lcv
 1YCLF1X46QWDGPvEFbcV7DzBBaeViocFe8mc6zem+gAVJ8sLXJZGpNJLNjgX/U90So7bK+dRqWE
 IzjN9gUzElZXNn71lExwQUkGDOsydQLE10hGkcOTN9U/PCMSYvz6tm/OT6rmjdQF1G2CbLp/2Xm
 9SovK1Qw4KtuNuBFISlvyQD/GQ3bsdaw==
X-Received: by 2002:a05:6402:2345:b0:58d:10a0:36c0 with SMTP id
 4fb4d7f45d1cf-58d10a03b2cmr1765912a12.14.1720046734142; 
 Wed, 03 Jul 2024 15:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEez081FkmCv+4WXnMyf10orIFemARh3Bv5Kak8t+EYBl1tDio916mj1mVWdiBiqysSYc6ccw==
X-Received: by 2002:a05:6402:2345:b0:58d:10a0:36c0 with SMTP id
 4fb4d7f45d1cf-58d10a03b2cmr1765890a12.14.1720046733130; 
 Wed, 03 Jul 2024 15:45:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-586132502ecsm7687298a12.40.2024.07.03.15.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:32 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v3 16/85] hw/cxl/mailbox: change CCI cmd set structure to be a
 member, not a reference
Message-ID: <05b70ceba033759d44c6d3d9b24118cd9fc9d616.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



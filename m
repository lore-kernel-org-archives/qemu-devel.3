Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC94C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb7W-00033H-D8; Thu, 01 May 2025 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7B-0002Z3-HA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:43 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb78-0006jJ-Nf
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:06:40 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d813c1c39eso12175435ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133597; x=1746738397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plmsFCscLUV04uq2qYRMQ5RH6cv8iwmOj9x5he8hi0s=;
 b=hDEsHcZRkfRTZeMkOPd2tfSxGmBfI68GpzkSzZtSrDgCWsnTPEdRuTHgTWvDRCZz2F
 +8cMyDTmuKJsAmQ/y/EhZMArwFBoHYjVUnTJUtonLtvdOkO4l1cBWMawzsKbByhXvpJZ
 icl7WScDrKYKFGQzb9Pv/Qv2h2IF8h1kJh0lqjjWgYShjcm8dtT+ytIluLlnjnZMs1kL
 01prLfYFKCxjIsGMZkHfevlT4LyU522Ej/NLjRosj4fYZKbuWrhgW9zuh+R3BTWhbBqv
 ATM+9jOklbOwysdNXuohIk+u5tAvbQlIv2F8ajFzWwUtk1JLTLjGeMxAbfUR48bQ+aIb
 geIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133597; x=1746738397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plmsFCscLUV04uq2qYRMQ5RH6cv8iwmOj9x5he8hi0s=;
 b=dcZvIvb4tBORnSr3GKvPVvbra81rdee2MjA0jxQ/zrxK9scBt4mwBBxLuVq9WO7mf/
 djDLciVNSkDRvGPVFT1gL4poTjrw0J23RkjUH0z4XKTEzAjrHflfKGkXQD8k/0+bN+vO
 jNbGQsdbwEwMtNIWcPaHkoZmGZkf/5vmzdYQ/JDLsZN29agWl7UbdPjnnhKb90DH4Erq
 v95qkDaKbigUTVjKM13qH10v+OcPvbKIEV8mG3SsEH6jFXeaHlSFU+gSOuVIHaqH/qkj
 OTRw0xMnUbupZCTc8TiN19O5oyrZq5foVz0zOYjWMJFhHkJHD+sDTW3Wz/iTnmUu+hjo
 iRgQ==
X-Gm-Message-State: AOJu0YxusVf8UIaQzn3P0hhzRDt6Llc71pZz4XVj0JgNQyzB2cKgmRLF
 ZdzJr48DGhHV6Om8Ptdn25GlrR5hGEvqYTVdC/7b9MBKhhpyIkJoQeJwy6O7yooz+BQ/3/HzJIR
 S
X-Gm-Gg: ASbGncvQfFRLmm3MYvHXVqFn4qbCqZK4ORZhdZSIV10IjHd2S0ecO292nN8x7q5qXeq
 x/nLl8sy+YSNQXG0UJXeAR2l5/PtXihySJ95ybOtdS6cx0u7vom/V18B0Z6jSOOAk221ICMUt+e
 Z1BG6aT4vl1BlVnqgPTyO2om5/tmzIv3b5lVgTS0eqZ1l/kJ5+g3vHAPK6+odj/YVxHrK0j1S4b
 o3SyWHW8z/pq04ecybPqFUhgwLEKqYulp+/VZr+BJPFg/pTkoDhlK11XUp1ZzhYDPlhqgAqMhoR
 6q2vnxZmaa0E4ySykPsgQhQmf7cKhz9PTHPJSMDcX9xnEeuwc2+5i8MfTRp1p9fC2/2Pon16TZJ
 P44VAWGAXsHtplus=
X-Google-Smtp-Source: AGHT+IE2EVWPt/an4zju0lHLQHhUQmTDSddIXQascsV19ewdipeU1SUU3c3LZXNsSrNz8PDdsE6w2A==
X-Received: by 2002:a05:6e02:148d:b0:3d5:deaf:b443 with SMTP id
 e9e14a558f8ab-3d97c13449bmr5738325ab.3.1746133597257; 
 Thu, 01 May 2025 14:06:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a91b069sm48588173.52.2025.05.01.14.06.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:06:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 11/18] hw/nvram/fw_cfg: Remove FWCfgState::file_slots field
Date: Thu,  1 May 2025 23:04:49 +0200
Message-ID: <20250501210456.89071-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

The FWCfgState::file_slots integer was only set in the
hw_compat_2_8[] array, via the 'x-file-slots=0x10' property.
We removed all machines using that array, lets remove that
property and all the code around it. The number of slots is
always FW_CFG_FILE_SLOTS_DFLT (32).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h |  1 -
 hw/nvram/fw_cfg.c         | 24 +-----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d41b9328fd1..07a31d214db 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -59,7 +59,6 @@ struct FWCfgState {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    uint16_t file_slots;
     FWCfgEntry *entries[2];
     int *entry_order;
     FWCfgFiles *files;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 54cfa07d3f5..71c41c979d7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -257,7 +257,7 @@ static void fw_cfg_write(FWCfgState *s, uint8_t value)
 
 static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
 {
-    return s->file_slots;
+    return FW_CFG_FILE_SLOTS_DFLT;
 }
 
 /* Note: this function returns an exclusive limit. */
@@ -1153,24 +1153,6 @@ static const TypeInfo fw_cfg_info = {
 
 static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
 {
-    uint16_t file_slots_max;
-
-    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_MIN) {
-        error_setg(errp, "\"file_slots\" must be at least 0x%x",
-                   FW_CFG_FILE_SLOTS_MIN);
-        return;
-    }
-
-    /* (UINT16_MAX & FW_CFG_ENTRY_MASK) is the highest inclusive selector value
-     * that we permit. The actual (exclusive) value coming from the
-     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_slots(s)). */
-    file_slots_max = (UINT16_MAX & FW_CFG_ENTRY_MASK) - FW_CFG_FILE_FIRST + 1;
-    if (fw_cfg_file_slots(s) > file_slots_max) {
-        error_setg(errp, "\"file_slots\" must not exceed 0x%" PRIx16,
-                   file_slots_max);
-        return;
-    }
-
     s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
     s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
     s->entry_order = g_new0(int, fw_cfg_max_entry(s));
@@ -1179,8 +1161,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
 static const Property fw_cfg_io_properties[] = {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
                      true),
-    DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
-                       FW_CFG_FILE_SLOTS_DFLT),
 };
 
 static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
@@ -1228,8 +1208,6 @@ static const Property fw_cfg_mem_properties[] = {
     DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
                      true),
-    DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_slots,
-                       FW_CFG_FILE_SLOTS_DFLT),
 };
 
 static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
-- 
2.47.1



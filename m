Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D74C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 23:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxbCx-00030u-3y; Thu, 18 Apr 2024 19:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCq-0002vw-IA
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxbCm-0005tG-AE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 19:30:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so1084051a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 16:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713483010; x=1714087810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ow2honBLfLsYAJoSrWVd0jh7a+uzahn+825h2aAqTgw=;
 b=fOeaBWIHfWgL8568EdvN9kHJO0EDQ3qn/1t2KlrtPzfvegUtuLlWHmF4hjFpwcIfR/
 1Qy/mI0YaHRv/yi0msN3l+Ltlmx4hbZkRf1DiqiOdxWaQ/kosUe1Zkdw80FQrZWH1i9j
 XdKVO5adl1kIjXhBKcFVq18wMMZLW+fdDa4HkZS+YY7fS8TrB55iOg3LXD14XvUv7bAF
 LQBJdi8N18ANs08uHcJwC0fWGPDQ9jwnDjrBeHiCoNEuVfQh+Wxw5r9WNTixIGBj2ILR
 sZ2NhDVR0SUFmxle1C5W5cveEz/7m6dfVKX6MG+CM2yeWNeouykF0N9BBWT4CpZIFhKO
 TYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713483011; x=1714087811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ow2honBLfLsYAJoSrWVd0jh7a+uzahn+825h2aAqTgw=;
 b=BwF2JOJ4WPHC+MkkhzbBP66Bt0DCCK9jEJJjftpyCRbEpr6Xk2QOQnAWf21tgIh1yQ
 9xTgb++Pk0Md0x2kJF0gF3iB6rz9S+BrO0v85XP0AJ0Y3hlz5WVWY8rLZ5l9Bp/MC/d9
 bwu3s639jIbhYdgMuJvj5Iey+tF+OP67/1l+LzMJcEe7zkumSXQ99MEhqPXuUYovOw5B
 AV1o+7sVIMmb8a6lu9lHx0nU1k7vut0QEiNkOa7HglO5Qia3aPtkq6WcrsIHvMTr/lHP
 9IZ8bWo629fBxUG3sGCeF6G+NdwSMfomNCT10BxJThIi2JjZvLbXub4lPiLrgonh0p76
 XEqA==
X-Gm-Message-State: AOJu0YxS+EZLhVEF6rxdIkTW0WSBnVsucQKgfmYfXhXBAYyor/n8xki2
 fSAIoZ+ecYP2poVULHGkt/4WFvP/2L5BEp4kWdOwstjjf19xPqKesaUGPg==
X-Google-Smtp-Source: AGHT+IE94ylxUx/UWiEiedIHul63+PwBYMukWUa1qdA/55cOY8EAPLn5Al2VYu6orH+j7LErQAQ6vg==
X-Received: by 2002:a05:6a20:96ce:b0:1a7:61f0:9ca9 with SMTP id
 hq14-20020a056a2096ce00b001a761f09ca9mr647381pzc.58.1713483010243; 
 Thu, 18 Apr 2024 16:30:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:ed8b:f40f:7543:e9ea])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a056a00230300b006e6be006637sm2040783pfh.135.2024.04.18.16.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 16:30:09 -0700 (PDT)
From: nifan.cxl@gmail.com
X-Google-Original-From: fan.ni@samsung.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 04/12] hw/mem/cxl_type3: Add support to create DC regions
 to type3 memory devices
Date: Thu, 18 Apr 2024 16:10:55 -0700
Message-ID: <20240418232902.583744-5-fan.ni@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418232902.583744-1-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

With the change, when setting up memory for type3 memory device, we can
create DC regions.
A property 'num-dc-regions' is added to ct3_props to allow users to pass the
number of DC regions to create. To make it easier, other region parameters
like region base, length, and block size are hard coded. If needed,
these parameters can be added easily.

With the change, we can create DC regions with proper kernel side
support like below:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5d6d3ab87d..5ceed0ab4c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,46 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
+/*
+ * TODO: dc region configuration will be updated once host backend and address
+ * space support is added for DCD.
+ */
+static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
+{
+    int i;
+    uint64_t region_base = 0;
+    uint64_t region_len =  2 * GiB;
+    uint64_t decode_len = 2 * GiB;
+    uint64_t blk_size = 2 * MiB;
+    CXLDCRegion *region;
+    MemoryRegion *mr;
+
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        region_base += memory_region_size(mr);
+    }
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        region_base += memory_region_size(mr);
+    }
+    assert(region_base % CXL_CAPACITY_MULTIPLIER == 0);
+
+    for (i = 0, region = &ct3d->dc.regions[0];
+         i < ct3d->dc.num_regions;
+         i++, region++, region_base += region_len) {
+        *region = (CXLDCRegion) {
+            .base = region_base,
+            .decode_len = decode_len,
+            .len = region_len,
+            .block_size = blk_size,
+            /* dsmad_handle set when creating CDAT table entries */
+            .flags = 0,
+        };
+    }
+
+    return true;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -635,6 +676,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->dc.num_regions > 0) {
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_setg(errp, "setup DC regions failed");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -931,6 +979,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0



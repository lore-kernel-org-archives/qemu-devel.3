Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD080C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropcd-0000z9-7G; Mon, 25 Mar 2024 15:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcb-0000uK-0D
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ropcZ-0004nu-AS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:04:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e709e0c123so3564887b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711393473; x=1711998273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGocJmgk/sEnzEmc6Kt8P5rytGfU0O9oNlpZCxOq1A=;
 b=h09k+88iNwUx8iECNo2j+CLk2smMGmKD2g+7VpPce1gjaWevLSYmKsUFBl4rkLZeci
 /RKd7I6FhsjMI8qe6CdDqovry4HOwfLWr1KRxonN3aT/pFrkMqQqQwlwU1lkXpG21xbH
 HpUaWk2FLFTZIRWr1MKi+145u+b4Py2i7pHP+3vxmLZmvynmGTCY0ICufoCXH9xkvbFP
 kONU9+nFJsiL/zjJEfN9/X/E7gG7tOjxf8jxWVVPoHcHCfxOxgq+8FT49nIw8D5Wv8CN
 mSbvByrzkh+AbVCUYo9o9zvJWgbKxOCiQXeeL+0wUtEos45XOZudjmB+1elxvz25HoLe
 Mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393473; x=1711998273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SGocJmgk/sEnzEmc6Kt8P5rytGfU0O9oNlpZCxOq1A=;
 b=tej0l+22Oajbs8P3uEKFT4PhpStwHsA5TWrZPJNQpjjUKsIE1lWSuAvNGfbF5RBG3l
 Z3su/IpjHOqwk7D4Dr3s3IDH/90/sfvWGpdIBBnu39QNQEPT3hMgamQt/o0CcT30arDJ
 NUhgXcMgbYzxCpRRKttCy10eNxrhMu21AILYIX85Fpie+12o66Mx4y7Zw9/R2ZSC66zD
 YCVWNvjrAaMWz8byqkclNiCcx3md1y/6BVeOhWJlxXRX28YNn3LPCQNtjcV841sqkijh
 qWpuFcCy7+p5z61YkZBWie0htzfSUZRUJHCe0kLcaq7PWfiA/iB41t+O/weANcjfS4Nc
 1gZA==
X-Gm-Message-State: AOJu0YyzM3YUH99oyqcsZoxMwf2kSPDYT9YFskW0K61FwpU/y+VkcLbm
 DOcGdiIXjw9LsBZy3S5wXmamBPgAPrR2+nAJK7kqMtuSZA/Yt4p8r8LYUfIt
X-Google-Smtp-Source: AGHT+IEet4CYlBzXytxndehASjVoSA2KP6NMROyP4aaNMcrhbw2pxprA5/Xl3Yf4Gtwld70yD4SjtA==
X-Received: by 2002:a05:6a00:80d2:b0:6ea:ad01:3550 with SMTP id
 ei18-20020a056a0080d200b006eaad013550mr2813950pfb.18.1711393473264; 
 Mon, 25 Mar 2024 12:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 12:04:32 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 04/12] hw/mem/cxl_type3: Add support to create DC regions
 to type3 memory devices
Date: Mon, 25 Mar 2024 12:02:22 -0700
Message-ID: <20240325190339.696686-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x431.google.com
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
 hw/mem/cxl_type3.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0836e9135b..c83d6f8004 100644
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
@@ -635,6 +676,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +976,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0



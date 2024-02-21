Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0628EC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDd-0007oW-Fp; Wed, 21 Feb 2024 13:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDa-0007he-TJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:19 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rcrDZ-0003Kf-2h
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:21:18 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-299c5a23f40so2220605a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539675; x=1709144475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJqQjnlAGwd774HUXqTHZfBD58qfYj95z3AiQp1cluE=;
 b=aw13FB7EPJYLeNKS5Wf677NyX0ey2+gQizAANuA4Y8XJ2TpH+JjmJL0IoUHmroHCEn
 AN/HOw8BoGptnupvxSmEy+qEcKeBTWMUdXzm1WBEc2ORAZX+ioutlgWJGgGbYVYLqf5b
 PF0VT3eq/X3zfbmO0WToiVZgEk/7FMYbHnWnVTg6buesjqDxZp5fiIBDbZsRyrPDbukT
 wrKE1B0sU2OMFbsPfdjRFAdyAhxnfz6X42KaDydUQbNcjKW9ZeRZiUxjfIORkwcDfgCF
 IHVV+JYBZaDIeKC/wMLYQeYlllfag33w5/8v2YBU1GUHPaTFy2OizNr8piGWpzrfHk0P
 /Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539675; x=1709144475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJqQjnlAGwd774HUXqTHZfBD58qfYj95z3AiQp1cluE=;
 b=tJJrQ6cz27JtuNIDG0cIcSqPOgDua+Vw+Ddvg95zKp8IHPcc41HDRyrSCtotW/tQIN
 M6ksF81t+L/qRIljAiWbxOK3RMUZFth304MiFU0F3iqsNpkiLRwrVIS56PLE6anSmo54
 prQOEIC+7U4vwW8aEX+kAiH0UYPRtKwJBs2vTw0VyOo6gCqyEW1aEtLJiLEWHkQt5pQV
 DTq/Uz3djuyP/B0uebniHNDBd4gH1Cj1Mqfoi3yAPa3DCvBm0OU9GSvGzYx5Ot9X3Mxm
 YsFBigkQXR77ljOscAt4WvLcvkKMEnNqgyj+N75H7OdkFeY91p8Wp7JEtzgUbDZhKKH1
 Pzww==
X-Gm-Message-State: AOJu0Yy15+agjWZIVw9wC1rTowSkqq/3MU3XkvQAnMxX70u6TZ/CAO97
 WbaNSWNdDKVjJydmiGPb3HF47GdtkrKvDMgD2AyGawbrjKwWHYff8B8zvpiL
X-Google-Smtp-Source: AGHT+IGIpQfawDAr7HNOdT8nJf9XYpRgVO5h7M9s1ju3JADRvCiD6h78Yzt+I16QV7f+Bfep1X3C2g==
X-Received: by 2002:a17:90a:fa0c:b0:299:2ed1:d462 with SMTP id
 cm12-20020a17090afa0c00b002992ed1d462mr13082477pjb.6.1708539675466; 
 Wed, 21 Feb 2024 10:21:15 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 10:21:15 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC regions
 to type3 memory devices
Date: Wed, 21 Feb 2024 10:15:57 -0800
Message-ID: <20240221182020.1086096-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

However, we cannot really read/write to the DC regions due to lack of
1. host backend and address space setup for DC regions;
2. mailbox command support for adding/releasing DC extents.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 244d2b5fd5..c61cd2b5ac 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -567,6 +567,40 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
+    CXLDCDRegion *region;
+
+    if (ct3d->hostvmem) {
+        region_base += ct3d->hostvmem->size;
+    }
+    if (ct3d->hostpmem) {
+        region_base += ct3d->hostpmem->size;
+    }
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        region->base = region_base;
+        region->decode_len = decode_len;
+        region->len = region_len;
+        region->block_size = blk_size;
+        /* dsmad_handle is set when creating cdat table entries */
+        region->flags = 0;
+
+        region_base += region->len;
+    }
+
+    return true;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
@@ -635,6 +669,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +969,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0



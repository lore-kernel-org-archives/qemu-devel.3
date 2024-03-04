Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F70C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEES-0005TP-L0; Mon, 04 Mar 2024 14:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEER-0005Sr-JV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:15 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEP-0006vR-QI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:15 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dcd7c526cc0so5184544276.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581453; x=1710186253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbOcnbLy9moWsSBbE+Q42MVGWhpKJBtzuH2spFlbBIc=;
 b=F+NqVZkan2g6rTkEtl2ksPATYTmVx/hF1j849qakco0Z7AqUSP9lAsc1nFMzYtn/Qk
 KwtB+TClJ5KMDeN0ryUy4DlmmxLlPKdH5kPABbyrRJz29hR0ePd2FTB4R8CxtBVRdjaC
 4r37NgEbO3TM/IRH/qhGAAzl4ocajaZWGBm3WcDLTcc0E5FpyWnNEh663+kOM2C4SlZz
 uDuKYqEp4SfllPglUe1i6tDRjHCI+uJN12a+WqaK7BF/MyKe8Em/KUGXXOScwvS3FLcc
 I5HFWrZISL2Wmz8bwgXItQKOipFwLJqBKbDyav8rnYO+eaOC+GQnNFCFYl7DT9fUm597
 KB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581453; x=1710186253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbOcnbLy9moWsSBbE+Q42MVGWhpKJBtzuH2spFlbBIc=;
 b=keQx2gReSyZsanffI9Yk69NEFeRs8OjDlr1eZDodaK9dwlAe9YGOruTQ2gz0Dh4ibH
 DzDxzSNrLiYCtfAp+3WxHygAF4GpTFArKNmGmI7q3rl3g0eLONZt3XqUhiWQTvCjjitN
 C9RYJs6cNm3Je2P40DzBoTjAJat2WYbEEdnHKvu7Ur2b+YUln60+Djo1TTYdJbI4s5JE
 rcoM6qMwMkCFt+si50FmHQA3rCJUGuB6jjrA/RbOZLVi9M2sUG3ZTsj3PV2FntI4+mmV
 P8dFepl2IeZHgsqRduDNnXDYOCY6of/jfusaBDUeHU+KsDnxhIXX5VfeC2wHfBRimNtF
 Wf0w==
X-Gm-Message-State: AOJu0YwAONjf1l0s0L3BqeBYp7XOhQtGe41mG87cHpNiYqjjVlR1/Yg4
 725OiBUPTncecbHvtv9/ncIOUGECjm6qJj9GaD1bWyvJnUzPwkX+RC1vT38u
X-Google-Smtp-Source: AGHT+IFj/6AKOb01CS8iZ0cx8I6hTpu+7AdNBUdow4ScUYPauwu6XEYgtcZPPXwXUBAP+6x/56QZMw==
X-Received: by 2002:a25:9d88:0:b0:dcb:aa26:50fe with SMTP id
 v8-20020a259d88000000b00dcbaa2650femr6868080ybp.15.1709581452753; 
 Mon, 04 Mar 2024 11:44:12 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:12 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 04/13] hw/mem/cxl_type3: Add support to create DC regions
 to type3 memory devices
Date: Mon,  4 Mar 2024 11:33:59 -0800
Message-ID: <20240304194331.1586191-5-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2c.google.com
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

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 244d2b5fd5..a191211009 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,45 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
@@ -635,6 +675,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (!cxl_create_dc_regions(ct3d, errp)) {
+        error_setg(errp, "setup DC regions failed");
+        return false;
+    }
+
     return true;
 }
 
@@ -930,6 +975,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0



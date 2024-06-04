Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE17C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVI-0000nT-0t; Tue, 04 Jun 2024 15:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVF-0000YX-Rx
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVD-0000ui-Cy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ElU1S3yGZ4jv6gdF/qOH23dlnO7FdnAYenskxuOvWI=;
 b=JNUGcnrSdMV1gyApcINwGNmEDZ/ZsF/mvj23YDKbYonMwpPRcHlwsJcb6SGg7TuH4FuVOU
 l6F5x5f2Q0tmg7e2+zXa+2ME2ye3K96lVE9zKBcr/qa9wEH/EHixbKtMLbA32nfwN3tInz
 /8eTdI5rgZGCRxHf6xm7Ld8UZtNlJbA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-tYgUC-slOaS70RMKhRQKdw-1; Tue, 04 Jun 2024 15:07:20 -0400
X-MC-Unique: tYgUC-slOaS70RMKhRQKdw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35dc5934390so3106313f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528038; x=1718132838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ElU1S3yGZ4jv6gdF/qOH23dlnO7FdnAYenskxuOvWI=;
 b=iC1bkkQg6RWCqjwatiYeh/fgIsN7qvW2UOHHKmJeisTt5+WLRzZ51d7M1x/YyzjEsg
 gQeSIB4bg8Mq25ZxnvEvcFGyXONuNOXg1BVLGe7kgLfh//osJySLdyeqO1wOK3eXaLqq
 IhBk3IqmjyQsNEa72lPFf43Tw99FwAkWBpSifKhcFMPkv+GVVZOVK4Cbzy2EjvV2h9BB
 3ukCXjXt+Jf1T7pVIy4Hz6A0U+wlkNgENx2/Vfgtse2mMHWitQVkDg2lnLNPOOwn6+9L
 9YxydKX1XkL22RfDD27kAKiiNXApNFCHJu+YOA8elNVK16FFz+HrWuGf21LiG3c6CELT
 p74Q==
X-Gm-Message-State: AOJu0YzWXEkTUVOkzEUHISN8C9UuoKCCItaGQp/sdMtGaOpF1l2g3gvm
 aG4VRpQp1SDEMbKb85hGYX7CmvoZDIdbJQbcs5ufZOTTpu2V1t6aMEi+ATf3AuGPEeWRqg98O91
 gZgk/dabZMcPjLcoiZo4J+h6XAHAQJSP41RfKfd6rq0zmoud8j0FtrekkZsCl5ig7YFOpabAStP
 l84CCYjfkeW/qctdZbgMDNjOWv/nED9Q==
X-Received: by 2002:adf:f552:0:b0:35e:5b3f:3954 with SMTP id
 ffacd0b85a97d-35e8d07a1famr255227f8f.21.1717528037998; 
 Tue, 04 Jun 2024 12:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETKaLoMDbKOvc029PhA7jBf1mQtFNjqHI7mm3boCu216JE12cqj2Q0GOIno40kmm0IttyT/g==
X-Received: by 2002:adf:f552:0:b0:35e:5b3f:3954 with SMTP id
 ffacd0b85a97d-35e8d07a1famr255201f8f.21.1717528037536; 
 Tue, 04 Jun 2024 12:07:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e5047f75esm9465264f8f.35.2024.06.04.12.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:16 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 22/46] hw/mem/cxl_type3: Add support to create DC regions to
 type3 memory devices
Message-ID: <fd34c6938b78872b63ae56793e6d54158b435448.1717527933.git.mst@redhat.com>
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

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-7-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 hw/mem/cxl_type3.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7194c8f902..06c6f9bb78 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msix.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -567,6 +568,50 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
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
+    if (region_base % CXL_CAPACITY_MULTIPLIER != 0) {
+        error_setg(errp, "DC region base not aligned to 0x%lx",
+                   CXL_CAPACITY_MULTIPLIER);
+        return false;
+    }
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
@@ -635,6 +680,13 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         g_free(p_name);
     }
 
+    if (ct3d->dc.num_regions > 0) {
+        if (!cxl_create_dc_regions(ct3d, errp)) {
+            error_append_hint(errp, "setup DC regions failed");
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -930,6 +982,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST



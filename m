Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76775C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwZ-0001GI-O3; Tue, 02 Jul 2024 16:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjva-0006x3-8V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjvY-0008ID-EK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ElU1S3yGZ4jv6gdF/qOH23dlnO7FdnAYenskxuOvWI=;
 b=Anp9nkM0eBXY0k0kkoHzElk1+NNzg5shj7d3fa+vMKpuQrAMrp5P67mAVKzTfoSw1dY6kx
 TspVVa/Brnw+DDOUsmsx8lEDkYLpjPrtd44aD1wlD5O/2mgQ2IRSmtQIyPgL7/dNZ4Wfld
 ObU+LowdHZgPs6yR0S51os+US5ZMz9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-rod21jHnMdyPBzRh4fVV2Q-1; Tue, 02 Jul 2024 16:16:34 -0400
X-MC-Unique: rod21jHnMdyPBzRh4fVV2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-424a775ee7fso32082785e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951392; x=1720556192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ElU1S3yGZ4jv6gdF/qOH23dlnO7FdnAYenskxuOvWI=;
 b=hvCSLz18ptNCGemFKNxQwDvBk5C+M81xA/8JJN0tJkGs9h1OFTNrfxhldpKpUKZ5RD
 QDTnRIsmWElm2H6MH4ByTpMNg81Cli6dM0LTR9tnpAKmfFD+HOqze5htaY1E6IIcMEHM
 PSnnnCB4xpzUkOG+TwwCIIHIv+74g7euROx7bAzYobpTb5MAtIKSkY75pdkm3aPWn6gw
 z3Lon7WF4ehwIO0f42S3Z3Xf/V1anscuSjL8Ql55pXeZifGWEFMBGsiuIk0t1lTM5F7w
 uTQcE3RfgKQZ68JfwgazUtTRUY9NacyvTsKon7z4gnSN4MJL2byrOwJGa+k1lUQ1ld19
 5UBg==
X-Gm-Message-State: AOJu0Yw551mjlxUurLn4pqwRuD1LF7yDYh+xT6VVgl+GlHmurikm7oo0
 AOjrTd006eEYVdcnTyuGSVQWCW1UOyfqQ8sjz32gk28rXgjJFwTgKn4gjs4X8Rzjel0Fv+BM0/n
 5tHpwGJzlm2a4C2AiP3cK5MuTrIm6v/lxj1s2k0PuhyNf6x57S4boCtJiHiqOJV+vH6t+RLjn/B
 lV875TzjB44mXPN3zSwHlsXRJ291S6cw==
X-Received: by 2002:a05:600c:12c6:b0:425:66ef:2722 with SMTP id
 5b1f17b1804b1-4257a02b947mr67833125e9.13.1719951392739; 
 Tue, 02 Jul 2024 13:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEruu40wKYBjuwpSmA2WC70AP5Lity4AzXJm46pj36KbjXXr6Z91d+DNunCa25+q9ARGSKu4w==
X-Received: by 2002:a05:600c:12c6:b0:425:66ef:2722 with SMTP id
 5b1f17b1804b1-4257a02b947mr67832935e9.13.1719951392206; 
 Tue, 02 Jul 2024 13:16:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b06377dsm212073405e9.28.2024.07.02.13.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:16:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:16:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL v2 21/88] hw/mem/cxl_type3: Add support to create DC regions
 to type3 memory devices
Message-ID: <f4fd91af3ae3b80c795ff5f3e0c1001b14ceb761.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



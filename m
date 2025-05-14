Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA0CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdG-0005rV-Q2; Wed, 14 May 2025 07:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdF-0005qu-1x
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd9-00064y-Cx
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYG1VcqUXYHTwq+yW1MWjdXMD8PNUK+wUVm5zXXHdec=;
 b=ZNWZ/lMmnO0AP7zZOWGwXyGLF8NLL3ZA8OKWEJgMruo6n0EWvZlqdY28qEUHFYBjPsPDqV
 Rbuy3m8WRR8xnv8jelHrKm7r2uL9nln7aXv+yKK44BN8iiv+8YTlaxiRTjtUpYl+DdMa9U
 HxwTc2SVcVZSFGetapoCYUDubHz8X1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-dPXnDTUgOVSwnL6ICXJ1NQ-1; Wed, 14 May 2025 07:50:32 -0400
X-MC-Unique: dPXnDTUgOVSwnL6ICXJ1NQ-1
X-Mimecast-MFC-AGG-ID: dPXnDTUgOVSwnL6ICXJ1NQ_1747223432
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442f4a3851fso4787255e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223431; x=1747828231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYG1VcqUXYHTwq+yW1MWjdXMD8PNUK+wUVm5zXXHdec=;
 b=jkcDM/ydzD39DP01vo3kAIaWhtKhxwr9DmUwFXU9UW1Yis3ucQkxHYZ0yEK/EICqxm
 mVk/HBe8CUAO+y2EYEn2oHhyzLeVMVZ8wtu6Af73B6rYYIPKKZN5RlyDXxQe6QUH4oXZ
 v7vcQvvBe5M63yTbS+Mo+HUh+YpFo/GGSO09QN7QwSSh3KQmyD/USU0Ce3Z43k4Ydryp
 tIaAV7SR32sl0bIHh270N/ybGAELJysQw5gJhR9LTEcxwcP0wzHP7Z9orQ5snheCid3X
 qENWiPf+JR/RbP1SwJM3qWawtjYJ1xBCZJnBzHZMQ11IMUO5Kvm2Q6zCnqb25OfG3KXp
 yVjg==
X-Gm-Message-State: AOJu0YxbVbE4kWHKBjdTWQSKqJ9e574V/SwlHMwhyF4HKJIe1uXtlmmN
 7yXTh7wvEFmLmtGyY9dvOgVpSxaTMZ4yqaUE3gfy3epNnsKRRzW+b+MAdT8URsAzTxbBKWi8i14
 R1HziSzIEnWye3H9rmtf57Kdbceua+FsB5H5Xx/XmKLtdMrB6dvvrPdPYzu1hLXZ8DM1GHrbNRR
 DI9en3MHKWSDAwnqaPqmd65ggDusP6/Q==
X-Gm-Gg: ASbGncvOm5F0OKcMe4a5T4FQ1/t0sFEEMS8dBk8ivkVOCGr+fYkpRho75NlJP18zU/5
 HXEsD0M4RSVVOkDUg2D1rZnrReW3pWppdvgMEqH5MRmsW0wVK2MdPosITz8ec7Qu4pSlJKkDtWt
 XedVDocNhQuDrwmVUH+ddTUsMpRF3xYtu3cz/P05tmqF7hdqdqusgtQOW076wyXnYGkd85Lnw6U
 kPo0tIdoCMblH8EQvIAiwoAT0QPwMtrFaNcJ/knQh1Djn9ziNpfi6LCxopcEDTHrOh4NAsRWLzM
 gTeKww==
X-Received: by 2002:a05:600c:a00a:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-442f20b9ca0mr25581875e9.6.1747223430893; 
 Wed, 14 May 2025 04:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdoyEnYssbSv1UgHuZJhNOA/W2iTnY0F6UqM+3HQX4W5+2legAvJ+l3UgiaoMtnSt6vIFgOA==
X-Received: by 2002:a05:600c:a00a:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-442f20b9ca0mr25581575e9.6.1747223430362; 
 Wed, 14 May 2025 04:50:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f33691fdsm27980855e9.5.2025.05.14.04.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:29 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vinayak Holikatti <vinayak.kh@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 05/27] hw/cxl/cxl-mailbox-utils: Media operations Sanitize and
 Write Zeros commands CXL r3.2(8.2.10.9.5.3)
Message-ID: <40ab4ed107757e1c5bdccc906e8a44cb4e2cb7a4.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vinayak Holikatti <vinayak.kh@samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations Sanitize and Write zero command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |   4 +
 hw/cxl/cxl-mailbox-utils.c  | 204 ++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d21695507f..3ec7be3809 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,8 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+struct CXLSanitizeInfo;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -606,6 +608,8 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
+
+    struct CXLSanitizeInfo *media_op_sanitize;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9f9d475678..2c6db70e5f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1715,6 +1715,131 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+struct dpa_range_list_entry {
+    uint64_t starting_dpa;
+    uint64_t length;
+} QEMU_PACKED;
+
+struct CXLSanitizeInfo {
+    uint32_t dpa_range_count;
+    uint8_t fill_value;
+    struct dpa_range_list_entry dpa_range_list[];
+} QEMU_PACKED;
+
+static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
+{
+    MemoryRegion *mr;
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (vmr) {
+            *vmr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
+{
+    MemoryRegion *mr;
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (pmr) {
+            *pmr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
+{
+    MemoryRegion *mr;
+    if (ct3d->dc.host_dc) {
+        mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (dc_mr) {
+            *dc_mr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
+                             size_t length)
+{
+    uint64_t vmr_size, pmr_size, dc_size;
+
+    if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
+        (length % CXL_CACHE_LINE_SIZE)  ||
+        (length <= 0)) {
+        return -EINVAL;
+    }
+
+    vmr_size = get_vmr_size(ct3d, NULL);
+    pmr_size = get_pmr_size(ct3d, NULL);
+    dc_size = get_dc_size(ct3d, NULL);
+
+    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
+        return -EINVAL;
+    }
+
+    if (dpa_addr > vmr_size + pmr_size) {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+    }
+
+    return 0;
+}
+
+static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
+                          uint8_t fill_value)
+{
+
+    uint64_t vmr_size, pmr_size;
+    AddressSpace *as = NULL;
+    MemTxAttrs mem_attrs = {};
+
+    vmr_size = get_vmr_size(ct3d, NULL);
+    pmr_size = get_pmr_size(ct3d, NULL);
+
+    if (dpa_addr < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_addr < vmr_size + pmr_size) {
+        as = &ct3d->hostpmem_as;
+    } else {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+        as = &ct3d->dc.host_dc_as;
+    }
+
+    return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
+}
+
+/* Perform the actual device zeroing */
+static void __do_sanitize(CXLType3Dev *ct3d)
+{
+    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
+    int dpa_range_count = san_info->dpa_range_count;
+    int rc = 0;
+    int i;
+
+    for (i = 0; i < dpa_range_count; i++) {
+        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
+                            san_info->dpa_range_list[i].length,
+                            san_info->fill_value);
+        if (rc) {
+            goto exit;
+        }
+    }
+exit:
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+    return;
+}
+
 enum {
     MEDIA_OP_CLASS_GENERAL  = 0x0,
         #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
@@ -1799,6 +1924,65 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            uint8_t fill_value,
+                                            CXLCCI *cci)
+{
+    struct media_operations_sanitize {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct dpa_range_list_entry dpa_range_list[];
+    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
+    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
+    uint64_t total_mem = 0;
+    size_t dpa_range_list_size;
+    int secs = 0, i;
+
+    if (dpa_range_count == 0) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    dpa_range_list_size = dpa_range_count * sizeof(struct dpa_range_list_entry);
+    if (len_in < (sizeof(*media_op_in_sanitize_pl) + dpa_range_list_size)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    for (i = 0; i < dpa_range_count; i++) {
+        uint64_t start_dpa =
+            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
+        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
+
+        if (validate_dpa_addr(ct3d, start_dpa, length)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        total_mem += length;
+    }
+    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
+                                        dpa_range_list_size);
+
+    ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
+    ct3d->media_op_sanitize->fill_value = fill_value;
+    memcpy(ct3d->media_op_sanitize->dpa_range_list,
+           media_op_in_sanitize_pl->dpa_range_list,
+           dpa_range_list_size);
+    secs = get_sanitize_duration(total_mem >> 20);
+
+    /* EBUSY other bg cmds as of now */
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+    /*
+     * media op sanitize is targeted so no need to disable media or
+     * clear event logs
+     */
+    return CXL_MBOX_BG_STARTED;
+}
+
 static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
                                        uint8_t *payload_in,
                                        size_t len_in,
@@ -1812,6 +1996,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         uint8_t rsvd[2];
         uint32_t dpa_range_count;
     } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint8_t media_op_cl = 0;
     uint8_t media_op_subclass = 0;
 
@@ -1830,6 +2015,19 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
 
         return media_operations_discovery(payload_in, len_in, payload_out,
                                              len_out);
+    case MEDIA_OP_CLASS_SANITIZE:
+        switch (media_op_subclass) {
+        case MEDIA_OP_SAN_SUBC_SANITIZE:
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, 0xF,
+                                             cci);
+        case MEDIA_OP_SAN_SUBC_ZERO:
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, 0,
+                                             cci);
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
     default:
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -3147,6 +3345,12 @@ static void bg_timercb(void *opaque)
             cxl_dev_enable_media(&ct3d->cxl_dstate);
         }
         break;
+        case 0x4402: /* Media Operations sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+            __do_sanitize(ct3d);
+        }
+        break;
         case 0x4304: /* scan media */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-- 
MST



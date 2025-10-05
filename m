Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40635CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDz-0007fV-NT; Sun, 05 Oct 2025 15:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDy-0007eX-Aa
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDw-0006QF-Jd
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swNEwSYytBCwmfM6PRGKjk51QDli8Xnv2NndUXljn+g=;
 b=ZoRSCQRIgjcHokW1RDSMMKsTNXMC9ET9kDMPOxRzD254IeinrbksLKUAX/a86VsGHR6yF4
 jCFpYJe4pyV2CZTrf2fk/32/CjAXbrNxnSGoYLv+exGIQmlCM6YcWS1FjQnHtTKaP8tixr
 1xc8NVtV5Wn/ETtcXHp/5HtCGvMbONg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-7MlgWQ0SNx6i7_noPbicHQ-1; Sun, 05 Oct 2025 15:16:45 -0400
X-MC-Unique: 7MlgWQ0SNx6i7_noPbicHQ-1
X-Mimecast-MFC-AGG-ID: 7MlgWQ0SNx6i7_noPbicHQ_1759691804
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e997eb7232so1743931f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691804; x=1760296604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swNEwSYytBCwmfM6PRGKjk51QDli8Xnv2NndUXljn+g=;
 b=Aa4k+l1UkjBYoCjfWNfvfUVDERrzMgp6j6AhYLyMMoZ//UiZmiU+Y7ZIvxAUsvCs/e
 WO2K9un+lDBwptUri3QMG9Xq3hjQwBpdRdpPl6fvg9hwYckf4wDSUCURz8+OMGF6zdKg
 UMERlQvLPv7EGI4Xr+zM4r+hgva7rl5RiPiN46uL8szaX/fDd1vyQAMxMQ/IdmnNMv/U
 4J83x8wraN3Mb4tfhcT7+3t0ltwOBtUT7Zq/ibycH18QKjKoUu/9zdZMQfsssAPxRpTv
 HCQzRY0u8F5IZ0cdGHHXLVscGOlWicb2AeZmFPPhnwZb0lV5fT0VmrQvF5mppfuPaV1s
 INnw==
X-Gm-Message-State: AOJu0YwdH8jxnkeNyfdVZ5tY9meKmhtwejoF5e4HjWbtNGEJHrKNul2K
 jLZC2C8q4h7j8VTxqbIblEht6J3oGdMfGj/VatIzEjl4Y4yRKTsseBwsET8qW+BFtLJuy8JUuky
 mYMtld5G+EV1SGZYqhl/vi3rzBy61ziNqYCIbWAhXDOkNwXJ3h4Q/XJ+GVoo+o7WsMKIjS7eL11
 oqgo4oLh0f0rWudpTRJBnvX52bPL4NikcWmg==
X-Gm-Gg: ASbGncvD6Qqf9Ei+Gvzcsj1wy4dVMh0ISpDnk0gGVA/d+KxnX99nJTmo6q3+vJMlJRq
 nc/WGZ3DPOCBTpXz1JfjeuhbZiqy5OeXDPKxwO3vB9sNeLGPlAvVNqFjAlpKggp/3DBvpWEGnmj
 c/6D6eE4cAQQuuxJxu+pcW89KRcS53TQr0FBxH2OH4U8x0X0FBgq9KreXv21jAsqYqS2aC7H+ex
 ISwiG/kcc4FpZebDb76MFJlD0fS66AwW0bsMhp2Uww8JJ1QmRuuRYyRU0tqi6ES1Gdi+9VQ/syO
 wYrkEk0gNgDLOzY8ee+4JF/Donylr5BtEUohkx0=
X-Received: by 2002:a05:600c:83c4:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46e71172a04mr72841355e9.37.1759691803953; 
 Sun, 05 Oct 2025 12:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8XpifGqdugAVZ4kjxOMzProQHDrm7VfKY7IxUESucu8e5Ibw1DdchA8edh0rhPmlex2J6uw==
X-Received: by 2002:a05:600c:83c4:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46e71172a04mr72841145e9.37.1759691803342; 
 Sun, 05 Oct 2025 12:16:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a4161bsm234285155e9.16.2025.10.05.12.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:42 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 18/75] acpi/ghes: add a firmware file with HEST address
Message-ID: <db16153f196f0ed7560aa138f08e2ef312ecf005.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Store HEST table address at GPA, placing its the start of the table at
hest_addr_le variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <c29aa5e6ab9b2d93dd5328481630c3b03da86261.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h |  6 +++++-
 hw/acpi/ghes.c         | 22 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 411f592662..ea9baab764 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -70,9 +70,13 @@ enum {
  * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
  * is stored at hw_error_le. This is the default on QEMU 9.x.
  *
- * An GPA value equal to zero means that GHES is not present.
+ * When use_hest_addr is true, the GPA of the HEST table is stored at
+ * hest_addr_le. This is the default for QEMU 10.x and above.
+ *
+ * Whe both GPA values are equal to zero means that GHES is not present.
  */
 typedef struct AcpiGhesState {
+    uint64_t hest_addr_le;
     uint64_t hw_error_le;
     bool use_hest_addr;         /* Currently, always false */
 } AcpiGhesState;
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 9243b5ad4a..cbc96c1909 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -30,6 +30,7 @@
 
 #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
+#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
@@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
 {
     AcpiTable table = { .sig = "HEST", .rev = 1,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
+    uint32_t hest_offset;
+
+    hest_offset = table_data->len;
 
     build_ghes_error_table(ags, hardware_errors, linker);
 
@@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
                   ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
 
     acpi_table_end(linker, &table);
+
+    if (ags->use_hest_addr) {
+        /*
+         * Tell firmware to write into GPA the address of HEST via fw_cfg,
+         * once initialized.
+         */
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }
 }
 
 void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
@@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
                     hardware_error->len);
 
-    if (!ags->use_hest_addr) {
+    if (ags->use_hest_addr) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    } else {
         /* Create a read-write fw_cfg file for Address */
         fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
             NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
@@ -484,7 +502,7 @@ AcpiGhesState *acpi_ghes_get_state(void)
     }
     ags = &acpi_ged_state->ghes_state;
 
-    if (!ags->hw_error_le) {
+    if (!ags->hw_error_le && !ags->hest_addr_le) {
         return NULL;
     }
     return ags;
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30071C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rt-0004gC-Tr; Wed, 15 Jan 2025 13:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qj-00089d-5O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qZ-00070Z-SL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W72gn/X43iSEWHwc8vF+OcjzKNW4pEeZuQNi+6C4SJg=;
 b=LWZCVM707lD9aBgpGcPXKiPprgHEg6lDMSPEzWOTNrJkhacS/LsAUO/RcClfi2kOxvuPyi
 LCq6CC18GSCDT565+Rry8+4n/4D26ZPtGJ4ld0tvbrYbgOZKHreZbUGld6PjDPf/GSDqHu
 XFs8TA30n7vcoWqO/AUytzM40jaVLsI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-WiVeAr8iONyLPbcZjk4b7g-1; Wed, 15 Jan 2025 13:10:26 -0500
X-MC-Unique: WiVeAr8iONyLPbcZjk4b7g-1
X-Mimecast-MFC-AGG-ID: WiVeAr8iONyLPbcZjk4b7g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43621907030so32477615e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964625; x=1737569425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W72gn/X43iSEWHwc8vF+OcjzKNW4pEeZuQNi+6C4SJg=;
 b=CVqB66lE05ZCMbpO2aoMse7VSEKi4+vZp2cA7YOGGtkQ8ZWj5p67Ie5SFJfSk50s3D
 XLof3lZfWek+Xh/AfATEeYN6IythaQQI+FcgAriF1sKgGyTFoQtZzcvcfVmoJCnWKHI0
 xx2vli1G1vHD9ROUOJvcj+9gmYcpGk9Js//mKRQoRUPrQWP9VTeeaLYIkUQFxd7HkOaq
 qrgAsuOCHRinbAZdUJOGBbwEp2yIn2/12HFbl08VTN4m9tLqT+cuaC2yckCZouYoWu/3
 C4g3r8wlLVEOJO/gWT5ACXKQ4hdxYcA7mFkdWXIKXbDTB+CoOJ7zRoc0GQMlDrOjnaQ4
 2PxQ==
X-Gm-Message-State: AOJu0YyV+qlYZmz5QD1KS6ZEt+ceatRS6YJvKxtbhgCF0bUWCWIliUeU
 /uataEcWWo3q2EPbBlHwZNSuBzCjXnPBZvVefc+hXiv4MPVelive8e0OrKP+cb5/B0T5Sfi7ApM
 OF38I1eIOqxGFGJJgoNpLJPH2tmkxdWAPWcPIvU8WfCBPSNWSeAA1A1h3dkZRsQ4KarjYoVTOsV
 taI+pBE+5aiNaXolpFFLlhuoI3HH9knQ==
X-Gm-Gg: ASbGncusRh8omjOSfu8UJGTT8pGlyHssKt2dbHI1sW/auFzP9NvqGuttgFFCiMvgg5m
 D0Xm0zQ0VX/iLS7M1kOI2Ji2S+igYExLZLIbc/WS0OChKQjgoJWlXQfgL+9wUiqs5+DrEr/nZbI
 eQVRrMcKaHiiSivzz6fkJ2zvc1aG2eO0KPmPEKG2yn98tfxee4TtXMD3PRB1O/33PJp+KCDN5Q9
 tmz+2yvQXeEgxF+YT6mKB6dyKevNvfLPrUaMIJZsIfl1D8xzw+f
X-Received: by 2002:a05:600c:4586:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-436e26f47f9mr300718145e9.31.1736964625163; 
 Wed, 15 Jan 2025 10:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQBbQ/ucVqe/1aRLFuXcnKDdErlW+RXJrbuNeDn0+FcDJpY3P4Ms2jbcdoT38rACpbOJjs1A==
X-Received: by 2002:a05:600c:4586:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-436e26f47f9mr300717745e9.31.1736964624696; 
 Wed, 15 Jan 2025 10:10:24 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm18082767f8f.48.2025.01.15.10.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:23 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: [PULL 36/48] acpi/ghes: better name GHES memory error function
Message-ID: <d32028a54000db671eb2d0b6b28bbf15acc2e5f9.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The current function used to generate GHES data is specific for
memory errors. Give a better name for it, as we now have a generic
function as well.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-Id: <35b59121129d5e99cb5062cc3d775594bbb0905b.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h | 4 ++--
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 target/arm/kvm.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 8859346af5..21666a4bcc 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -74,15 +74,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
 void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
  * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_record_errors() to record a memory error.
+ * safe to call acpi_ghes_memory_errors() to record a memory error.
  */
 bool acpi_ghes_present(void);
 #endif
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 2b64cbd281..7cec1812da 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 6f40cd35a9..66bd98337a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -415,7 +415,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
     return;
 }
 
-int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
+int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
 {
     /* Memory Error Section Type */
     const uint8_t guid[] =
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a9444a2c7a..da30bdbb23 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2387,7 +2387,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              */
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
-                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
+                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
                     kvm_inject_arm_sea(c);
                 } else {
                     error_report("failed to record the error");
-- 
MST



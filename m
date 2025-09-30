Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7259FCCA474
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZaF-0002Ds-H8; Tue, 30 Sep 2025 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaA-0002Ci-QJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Za0-0007bn-Oc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:35:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so56562685e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759235736; x=1759840536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/w2Jf+qeqeafHMIrcRF94krTFVy/TdywuHBFiP16cE=;
 b=dIE/YIWVI2VPP7y32Ic6C5hLdS9Wo8ABrzevcbKETaZ1th3VrDTWZsvnTdZY6am0Qi
 yCpVpmoMqm5ovKnSL4B61Z79xFRD6/cEfde6lSZI4+D/hw5EhmTSI97wzH5qj26EzQKe
 K8oC7aatqdoZqO+toBmSJPNkT0sEB+QwR6MyODzEiVlNAYmF9Fw3oCj5QVfjiQHivhiw
 gx0Sw4OifiGOqHZ89TFU8nLSUmOeUIC2AEH1zZgy2d6szK4LjWcuVlIMkcwKZ4sHuRG4
 77Zqk7E12dZi0YLLGXPvZlU/NK/7r9VHBs2hEkKajTJ1IPKDrheNbGxC6infrYAOYmYS
 JiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235736; x=1759840536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/w2Jf+qeqeafHMIrcRF94krTFVy/TdywuHBFiP16cE=;
 b=VC/iZ9k4Tsjh4YpnaBdu8s9YXYyQ8wRRCfqM4oVcjdvU7+yZZ1yhcliELm0uFMJbj0
 6pcqj8BKjNX6ul4De0QZFEMv0Ttt7dYz4EK1+wyPcj4prZz5Uf7jg1fC3Y26/r7nx9n8
 iB64XdCp0wRXNhll+tXB9DEXSU2NBguZvAoV6DjDGBatdjYvnDBLELwI0UvMELtYQym5
 ZaiNoc7t9exzZIk96DakPxXpSQxLW91/5Rt5DKkm1mG2OQLNuBViLxXIEv0QTsc7FHon
 IwQKmmVZ7ZWiBl0PuMcST+UzSNbyptm8wyismqU3H1bIhI9wVJSb7I1atnm8chQ35301
 EwWw==
X-Gm-Message-State: AOJu0YxQhnGN2nMzZkDi4LBW6l/YZcvUG+wZnYiIkF+A0QRjGJ3U+YZp
 wOKLMPQOQAbh1yUnc2kaevsAEo59gCs5V7AgzhxLl9pM+uDGqzxgWEbiBq4Lh3F7ch7hnZP4phT
 nKIpXMGzHCw==
X-Gm-Gg: ASbGncv2m1HDL3kgZ8BWjti/ZkKmxIr8nifLH+XIyG3TiZNPYyq3q7fztD86dxX0SgV
 VQmoNOS4H2v9XWmiuLMoT0GnWP+vqh8rmPXjAr8EPGwZUHk+Ao3LG4CljjEnm1/VTktntW5TEW1
 fWeVRAbi/EWekXI8YV/xMq5RR9XB04cYPvLJY/fYS5IGsStd45W36K9aAJqfDeaPvGbQKE1tFLD
 LGAO3Zn+FcBkwPgR/zoni9KWi44u1lZffzQnD1gGx3988KNz7+UuebVG9bCsrZCL/0hbxiMiVYv
 n9Rlm8zv/e9SKruV87FE9xwnFeKVHwSJB/M4NhD052li/ZqFh2qe1Kb/kOGTd365d2WzWG/sG0J
 4lhmHVLKd5jRDnxlpcDu3+6nAP989LG5ev1kxm3uMvdmW4nOLpR2eV1bUAUzQoNkc2+/Zn0bA5m
 K5+sq+Uy6ucOZP808428In
X-Google-Smtp-Source: AGHT+IFXfLJG0k2Ex/14FWtAC4mLlJIIcXwbHcVINOwydfN2uw+/0pSFrvS1EJl6TnSNYIqIYdgq2w==
X-Received: by 2002:a05:600c:181c:b0:46d:996b:826f with SMTP id
 5b1f17b1804b1-46e32a02d46mr148714075e9.25.1759235736119; 
 Tue, 30 Sep 2025 05:35:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb19fsm22909632f8f.21.2025.09.30.05.35.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 05:35:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/4] system/iommufd: Use uint64_t type for IOVA mapping size
Date: Tue, 30 Sep 2025 14:35:25 +0200
Message-ID: <20250930123528.42878-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930123528.42878-1-philmd@linaro.org>
References: <20250930123528.42878-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

This doesn't represent well an IOVA mapping size. Simply use
the uint64_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h | 6 +++---
 backends/iommufd.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c9c72ffc450..a659f36a20f 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -45,12 +45,12 @@ bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                 Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
 int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                                 hwaddr iova, ram_addr_t size, int fd,
+                                 hwaddr iova, uint64_t size, int fd,
                                  unsigned long start, bool readonly);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly);
+                            uint64_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                              hwaddr iova, ram_addr_t size);
+                              hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp);
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2a33c7ab0bc..fdfb7c9d671 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -197,7 +197,7 @@ void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
 }
 
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            uint64_t size, void *vaddr, bool readonly)
 {
     int ret, fd = be->fd;
     struct iommu_ioas_map map = {
@@ -230,7 +230,7 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
 }
 
 int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  int mfd, unsigned long start, bool readonly)
 {
     int ret, fd = be->fd;
@@ -268,7 +268,7 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 }
 
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                              hwaddr iova, ram_addr_t size)
+                              hwaddr iova, uint64_t size)
 {
     int ret, fd = be->fd;
     struct iommu_ioas_unmap unmap = {
-- 
2.51.0



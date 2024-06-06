Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2856AC27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXf-0003sy-U8; Thu, 06 Jun 2024 06:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXb-0003rx-6R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXW-0002xa-HG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4213b94b7e7so4465925e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670412; x=1718275212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJQM9NsMMAJH9bY3Q3nzlpRNxIjB2sYAJahUizBDung=;
 b=bqAHOmcnRUJveVbMovHHv85HE2FZthdJUWL6LQZ58rlWGzU+/fMg0drmnGdnLAoozO
 ET7lK1ttzXUdDG7j7N/AzqP0WGnhAS4eBxm0s7usOdbObc6/DWv64Z/C8M19wxAzllLl
 hJcq90BHjLoqQBNeKJf/OmF2cBpJpilh2SUnZ4jDbo6qfo823CRRJIjREO4YORJfqNe+
 5+t0gphlH/nKw/IaCT3XK8h3GOv27e7OMNrdsNNdq34uhOZNV7EvOc3q/f2dPDMXVoGN
 kK78irRJattGpLYYi8+/lru5V4GxGYKJVQpPV4EHHOupdIwQVcnqnHUKV1mk0V71WRCz
 0wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670412; x=1718275212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJQM9NsMMAJH9bY3Q3nzlpRNxIjB2sYAJahUizBDung=;
 b=N9eCu5h79OiCWCCdv1LyjTmkvhxCRs9Bsv39TbxzKzOB+dV7KMvoskJ+f12S0M79Ty
 XmdTfhvxTA0a3CsN57sx/ooNRZqkY4hyMzKnPEhNEpKoKq8jMvbppjFt55CTTLj+l8qG
 CnAAGq34bllkIaF98SlNcqFKx26Rm/+sKCLD+nl8dHYSrbJ3kdciWiffcD497kdFblqA
 a6EfMp1gs8ayI/e3Nwkyk6+29NcpuLtEkenCINExsoVqtcYrHRSI2tS1Y0RuiFZaGjja
 JUnBOXli2YJwxLq/4DZ090M0P5fZ53ziuvsv+JzGge0vMOtYLiaOWMClak5AKLmetbtD
 br0g==
X-Gm-Message-State: AOJu0YzFLAd0/Gvt2roebiKdaSw50eFJI/frZQhKC6BDuwWtayVONXlC
 6pzLaI43jJ7t5vRVpYer8hR3KStnuw9QxV2GPkZ54vI2cCOYET1E8IubpTiO9GB8Nj1JudYP8L2
 LyCI=
X-Google-Smtp-Source: AGHT+IE9+fiSQIUGoSVTB+yq0KaKF0vUDSpwqgCrbYn9/+XlA9+SqIblJFnsba6dWeNWbO17byeBrA==
X-Received: by 2002:a05:600c:314c:b0:418:5ef3:4a04 with SMTP id
 5b1f17b1804b1-4215ad180b9mr21005735e9.18.1717670412599; 
 Thu, 06 Jun 2024 03:40:12 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102a69sm51547525e9.15.2024.06.06.03.40.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:40:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/vfio: Remove newline character in trace events
Date: Thu,  6 Jun 2024 12:39:42 +0200
Message-ID: <20240606103943.79116-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
References: <20240606103943.79116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Trace events aren't designed to be multi-lines.
Remove the newline characters.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 64161bf6f4..e16179b507 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -19,7 +19,7 @@ vfio_msix_fixup(const char *name, int bar, uint64_t start, uint64_t end) " (%s)
 vfio_msix_relo(const char *name, int bar, uint64_t offset) " (%s) BAR %d offset 0x%"PRIx64""
 vfio_msi_enable(const char *name, int nr_vectors) " (%s) Enabled %d MSI vectors"
 vfio_msi_disable(const char *name) " (%s)"
-vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s ROM:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_pci_load_rom(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' ROM: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_rom_read(const char *name, uint64_t addr, int size, uint64_t data) " (%s, 0x%"PRIx64", 0x%x) = 0x%"PRIx64
 vfio_pci_size_rom(const char *name, int size) "%s ROM size 0x%x"
 vfio_vga_write(uint64_t addr, uint64_t data, int size) " (0x%"PRIx64", 0x%"PRIx64", %d)"
@@ -35,7 +35,7 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
-vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
 vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_attach_device(const char *name, int group_id) " (%s) group %d"
 vfio_detach_device(const char *name, int group_id) " (%s) group %d"
-- 
2.41.0



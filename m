Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD2E77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU6Ia-00035g-NL; Sat, 04 Jan 2025 10:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IP-00033X-Nq
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:39 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tU6IL-0000sL-BV
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 10:42:36 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-21634338cfdso266438675ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736005351; x=1736610151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AEAugRZEQWsrCJKh63bC8l5/3GgLWrtx/bu1cbl8cA=;
 b=V5o5DegVoZuQGXCetZ+9u5btQ9FyHADgk9GSrsz1n5kO219JPACVxL7WPzFzK7CPt+
 k2RdpSmrFzR8SpX16MVchOkrw8ycLtzw1K8AZbWbsyxYbDcokqUSIvRTyvHEUPcShpc/
 0U9QCP5tB1RKhhCBF77GHct6YIhh0RK42vDE4bycRpXrdAhrgdcY7y3aCtrT+9paMnxc
 SU1ijO6uJeMTUP1+M/v+HWxZxgK2W2q4dNx35H6J0bPC2YObiDetDkuynxM9IBPryU7v
 X4pjW5edMeMFIpIalRQwDaQsfqMJfMuKBYSn1rvS04MM98JqdGRNE00H4ajXNrQSoyAD
 iHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736005351; x=1736610151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AEAugRZEQWsrCJKh63bC8l5/3GgLWrtx/bu1cbl8cA=;
 b=SRdGIxL6JuFOym8OBOsKu4wHcaF3g4SVKaFTl61TjBbrUBj9Sb8tdNogr7X8jn8LGs
 1TOYfBzxDAclq2Z+RpJhr49Xxm8zu4Jobg6fNgFSQDWwl5WabTGDjnR0SlDo21u6S0nn
 KtY5OODosIF1zLRlV/PrRes+9oVHt3ZzVmg9ic6T0ztJNMOgPN8fdpS3DS6E9vRKGlP2
 2lR6/T0bt7Y8zgIo1KZOWBUb+Zq/52YRe/aPRMxKUJeuDVeXGTUmIYhXYprnVxTg2nZ0
 BwI7MpMZaCR58GbVYmHZNQG/7YxgblIfvKy8+2Tf/hkXh7r7GK3/foP4GQyZRKo4ad3D
 ZKxQ==
X-Gm-Message-State: AOJu0Yy0HtXiLk4V4FqJKepSUQ4n3SO57wlxIq6Qq54wpWZ0mBqBlRJz
 lmZmsyODCl0v5iPJNFnKArS+YCtubwWJ21xjc+QSImFJwPr+kCY=
X-Gm-Gg: ASbGnct0E2BVaXgh5j/r5jUTS8+RUU7KMDmmEfANdZJMzRrgeACx+84I9AOJ7NjU0V8
 iEzOxyhFbT8a6f4pqOBmZW/TwjcMpKO3BZE6KD3zxGpUPxShaWLmJqDMkEnxAx861ibnuFtsVrZ
 RT01ww4JYZDsEFAcatXZrzQOwciaRHMOOIdoVCX1HgwEekO0ILTh3KxGtDzuqVloc3RCNLJMOt4
 pU5lY6jnRbQizHk9jNBuowUbc9gCSyuREAqg82Pj3OeosoCR2EIC0a2m8FpO9GW2v0BYA==
X-Google-Smtp-Source: AGHT+IETAntAkrUUUZFBtmzHRF76LfSLqPX2U6y75nz8NAXIpK+Ap/Wyk/0qF7tmevFrzInbBo1Qvw==
X-Received: by 2002:a05:6a00:1144:b0:72a:8b8f:a0f1 with SMTP id
 d2e1a72fcca58-72abde8462dmr81358257b3a.20.1736005351616; 
 Sat, 04 Jan 2025 07:42:31 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8162d0sm28113388b3a.12.2025.01.04.07.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 07:42:31 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 2/3] vfio/pci: introduce config_offset field in
 VFIOConfigMirrorQuirk
Date: Sat,  4 Jan 2025 23:42:17 +0800
Message-ID: <20250104154219.7209-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250104154219.7209-1-tomitamoeko@gmail.com>
References: <20250104154219.7209-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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

Device may only expose a specific portion of PCI config space through a
region in a BAR, such behavior is seen in igd GGC and BDSM mirrors in
BAR0. To handle these, config_offset is introduced to allow mirroring
arbitrary region in PCI config space.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 2 ++
 hw/vfio/pci-quirks.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2258fdda5f..fbe43b0a79 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -162,6 +162,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
     (void)vfio_region_read(&vdev->bars[mirror->bar].region,
                            addr + mirror->offset, size);
 
+    addr += mirror->config_offset;
     data = vfio_pci_read_config(&vdev->pdev, addr, size);
     trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
                                          memory_region_name(mirror->mem),
@@ -175,6 +176,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
 
+    addr += mirror->config_offset;
     vfio_pci_write_config(&vdev->pdev, addr, data, size);
     trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
                                           memory_region_name(mirror->mem),
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index c0e96a01cc..d1532e379b 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -60,7 +60,8 @@ extern const MemoryRegionOps vfio_generic_window_data_quirk;
  */
 typedef struct VFIOConfigMirrorQuirk {
     struct VFIOPCIDevice *vdev;
-    uint32_t offset;
+    uint32_t offset; /* Offset in BAR */
+    uint32_t config_offset; /* Offset in PCI config space */
     uint8_t bar;
     MemoryRegion *mem;
     uint8_t data[];
-- 
2.45.2



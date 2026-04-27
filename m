Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17C1FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOC6-0005Xo-VF; Mon, 27 Apr 2026 11:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3OoXvaQQKClkIB9I7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--rkir.bounces.google.com>)
 id 1wHOBz-0005XG-It
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:16 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3OoXvaQQKClkIB9I7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--rkir.bounces.google.com>)
 id 1wHOBx-0003wA-7g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:48:14 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-82f0e12d375so6005900b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777304891; x=1777909691; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lsRufq+zOvxiSTMD2bdcsGu3QRTVJFWUCnfJIMUaVas=;
 b=Rut0n27pVKOablkh16z+6Z/ztvWfJUzlxI5SaX8xPsGxqgM1yUsug3uBqNzs0ty+kJ
 haDx5/XQqffr2g4gzymus/tlLXFsa1kt8ryy2Pq4u6NHCKkhJ5qGUyGZ671cf+Qupc7c
 ZfHnQW+M2c+wT1qAp3h+jFWAlW50gXki0RpbjQCIGrtydEJzpOrVCbMLgG0aZgxERYHk
 u9BzOoI2iv6bh3pdfqksajQJgxHx09/ns2eLonxxXoZh54wFmOFIySlru3GVXpzuf9Fr
 d1wotrWG9Ft9DUQhk7xAONk1Lgb0qYAq44PIPQaju806zAj7IyHwV605QfpEOrO0J0YE
 URNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304891; x=1777909691;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lsRufq+zOvxiSTMD2bdcsGu3QRTVJFWUCnfJIMUaVas=;
 b=KeuiKbNWjg/h+h1TFS2oCIywpmhjYw4MEhyEZSsDtI41H/ygHwXU6F6pRFQrMt5nlN
 dRwZNOr3xJA1MTVvvK0MsX924V8BMeqlw2SqyTKrylZoeNUv8EyZicwE1Hjb8IJqgGlZ
 NZSzsTAdL8zOHNlnMOanFDipxqV2raDMI2/wTBGqujAxUDrrxE4E2fVCUU9qstHmjXzZ
 lCdwKllRj9alwNxBvRGdSw0xQ2vw2n4qP7JxuwvFYjHjAXStrHO6ufKvGNcGeb26aanE
 Fp0KwPABOw4v3s2GuLBXFoedeSXudw1ZeipYIqN+XS3FE+F6vuO1L+9R3NdK8Xo2PIIA
 g8sQ==
X-Gm-Message-State: AOJu0Yxv81hbPj7GQHzN+NFQeJaRs0XXiKdJShDBitp/7nE9fDv9twIp
 arGhbiHKpbcQcea/7/jEDz8w370WJEvBl+KEPekdvirjeMXkGY+zA5n47NI5bUS8t/QoGPmSMQ=
 =
X-Received: from pfbdw7.prod.google.com ([2002:a05:6a00:3687:b0:82f:4afa:eef2])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2288:b0:82c:e1aa:21e3
 with SMTP id d2e1a72fcca58-82f8c84da16mr45072169b3a.10.1777304890832; Mon, 27
 Apr 2026 08:48:10 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:41 +0000
In-Reply-To: <20260427154441.1918536-1-rkir@google.com>
Mime-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260427154441.1918536-3-rkir@google.com>
Subject: [PATCH 2/2] display: rutabaga: unparent MemoryRegions in unmap
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3OoXvaQQKClkIB9I7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--rkir.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The virtio-gpu-rutabaga-device instance holds a
hash table of child objects (`Object::properties`)
and a memory region is added there every time
`memory_region_init_ram_ptr` is called.

The `unmap_blob` call invalidates a `MemoryRegion`
but does not remove it from the device, which makes
pointers to the region dangling and eventually causes
a crash when those pointers are dereferenced.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/display/virtio-gpu-rutabaga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ebb6c783fb..5cd9b19336 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -737,6 +737,7 @@ rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
 
         MemoryRegion *mr = &(vr->memory_regions[slot].mr);
         memory_region_del_subregion(&vb->hostmem, mr);
+        object_unparent(OBJECT(mr));
 
         vr->memory_regions[slot].resource_id = 0;
         vr->memory_regions[slot].used = 0;
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog



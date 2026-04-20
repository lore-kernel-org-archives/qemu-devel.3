Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E604FF588E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErWf-000318-OO; Mon, 20 Apr 2026 12:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErWX-00030X-QY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:31:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErWW-0005qh-8p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:31:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so1612886f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776702656; x=1777307456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ez33QsdNGvWGiCbQvummMOkAYILTE9ISsLbP8jJd/GI=;
 b=dgA6FJSEcmetDUiB/tEZMomdSCCyOZdvJvUJ8/BzB0l27ZumOX5x9VSzPx7lqmeCFF
 AQC9TsU7/HdOnZ7oqrl1FS6C5hJ8MKj8I6pAZrEb1+9i0tJ2W8gtpO9V+3DlNaNpK79M
 sVafdEHsGRj67HgXxP2yGnS1Ly7t4c+JeO6TULjFxbSTvhLnFkUwq+5luDHUZdJHdu/H
 w3U3x1fkdEpE1n1xxhxrbiSCQSd5h9kBJ81usjZQUTc7M/0Rk+MqnqPhj8VaLzFgD+Qc
 nzv4wchN0LV3t7GKHqkAqeNdYZTwjyo3B7oZ4/EajTe9OUQyV/aQEIiIPmjvgaGSdJJk
 kebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702656; x=1777307456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ez33QsdNGvWGiCbQvummMOkAYILTE9ISsLbP8jJd/GI=;
 b=GuNEVGvhmcV66C/HtYfj9u1QDcZipkgNLLCwjBkDgOhq5ZuyeMARv+SkZR1ufDFFgJ
 ub1vhGZy0A/WGohcfzW2RCJ8epf+TwSOV4U+6g/v3O107FgIGrx4dXm34AW7Qk1apHAO
 8QAHgqkw6as8bKiVqf2njb1G1EBWMy0WE4fsLgy1e+m9FF9X0/NIpUM7yfyNjsD56h2f
 PxtiRGO68T+RArgYU+uOUbPqO5rlYEC06up9IxvV+v4KZZGkIue1GnUrYEIf12KkLpLf
 MQ5G8mLAx0ztTy1AgxOnw9mA9WwZKSKOSpgCFUJxbH0QNUn3aFRBKgYvawDzoJziaKnN
 Pgog==
X-Forwarded-Encrypted: i=1;
 AFNElJ++K9igl8dyKtJM1Pan2xS4mIpNZaZfutws3/enSnHx5oPAuR8izvIVH0E+V0cVLr+fUCwM6lYcX+We@nongnu.org
X-Gm-Message-State: AOJu0YxQr5h+vcGqxSKm53ee9cVBnDtaodaXFpyuhFU6DMg+HHRMUoK+
 3Ik8YygIOlIotogUONd3vrfJz6Zq6xotvsLTjq0mLgtY9gSe8QkI9bc/
X-Gm-Gg: AeBDiet5TVoYAgr00NPBqv9HJZsOBpaHpHZjuld3qJriQ5Y5KddepNB/yen0rNqWeYv
 E4htYEyN4l5JVSuBA9RxWb0rHrCvl4JebZJKg1f1Xr2+wspqI6lHo+jf/4LdNH1oPO/X7rgaX+0
 /Hf8+fXI/8hA22OuQKje8y1vDOqduie9bxRSsqDyT5PKlCsZfgcqCl+m0XAP/6g85g+W6uiqu7s
 W8eCL1s1FJzrhUYwHpX2JGmD2RrIsPi/nkiENn/ZYpWRkZxFa5MxU2lgoMt3pnxEPSqRKmFfxh+
 2aRyxEAONvuZWqMEqmRGh52GgaoiV0JaL3RxzWpkT41/EHZ5Li8AftHDKKrq5rW/1Ddu9UyYCme
 wmgMtBDbLdb1kpcjCGIXmJznodpzabcJ44z38c3+zRHrVKNC3IIYEUB2+ugZivOqJw0xcq+MHLb
 hIy7b2jwcy2OMNGMtHzJOPojBdXRY0lCxVjujWfXDB0qxNLlhE/JGBgv72QRL3TG//slDCObY=
X-Received: by 2002:a05:6000:250f:b0:43d:68ad:3b7f with SMTP id
 ffacd0b85a97d-43fe3dd397dmr22645287f8f.21.1776702655880; 
 Mon, 20 Apr 2026 09:30:55 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e44f69sm32380026f8f.25.2026.04.20.09.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:30:55 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/virtio/virtio-iommu: remove duplicate include
Date: Mon, 20 Apr 2026 18:30:50 +0200
Message-ID: <20260420163050.321668-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x42b.google.com
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

qemu/reserved-region.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/virtio/virtio-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4226a676d0..08f7e8b783 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -28,7 +28,6 @@
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "system/system.h"
-#include "qemu/reserved-region.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-- 
2.43.0



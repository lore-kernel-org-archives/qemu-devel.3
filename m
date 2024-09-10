Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D794EE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8WO-0004a8-CM; Tue, 10 Sep 2024 17:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so8WM-0004Up-Sl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:35:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so8WK-00036f-M0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:35:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7cd967d8234so3909889a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726004130; x=1726608930;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jGi+lHOpgT/ylVqXhI7nLVR4vBTcqPZgS5ONhF4/Ujg=;
 b=mihkPUVoON3Ukrq8Sq4iPZ0yUfolex073zfbr65yO7UDnknSxrYSgYf+M0eVjmEVAE
 Srg0ZZBcTKKdeFDXs6j9mInAFeanhzN/sJnuJMyfu4IepjjuBnKKiLXYPsWsvULxHK0q
 T+pucaIrRLbP7l3zjUErUN6jByLXpl0d6305ViP3gBiUP7WF9nrckxuW9Ie6ezAkCLd9
 hExuIT4cAv5BTDUTdR50IFpay8razKVtFkD3gKAhHuIBVeGc/ZLIJyqX9V8hyKwWdukR
 N+j+bWgYI9/VQio+a1AgVe3GdiBI76SItQHMmao6Z2qr4e1+AB20UJDl4HhG5YzHC33a
 p6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726004130; x=1726608930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jGi+lHOpgT/ylVqXhI7nLVR4vBTcqPZgS5ONhF4/Ujg=;
 b=OiD4sE8FAbC7pL3L+2dzuuXEO5ja/TqJ4OkwG46nzvTu7RVIVwVscriom4fhGpczkV
 cbPnJkQK7Zi4Z2l0lnNjkRQKfio91bN4uAQN5NP0vlFKd2FRiDYHq+8X7gq6tZ/KT9zi
 yB/Jh0LzkVNOxElUaitoPTUrvasgZhtzlJxmOxfBG9pM6j9jJRwXCF8BWohNq1f6f1i9
 lONybrdcOGM+e9sP1Q2X2jd95h9h8ygT8K9a40M2I/HqTvWf5Uer4yIvbDM5L8oLHme9
 kr2vjk+siU9He4LUSpK6T0NwW2BEnalSUeeWeWtRv5GA3YWSivqp5CNlHyZb5qp2vmui
 oYIQ==
X-Gm-Message-State: AOJu0YzgVNT72X0hJv+tb01Mc4vS1Te2mnyBFVHkMbcro2WSkO6VLrv0
 0OJ6JRsJzuD2rsuF/ZM6XT9TSox2OdbyLlQ6bo3a1b4xHCLvzqDt+Zm00d3kT1kjkGj7jV7iGV5
 v
X-Google-Smtp-Source: AGHT+IGBNqA3K7WJPDRSXFKY8dE+GL3RpCg80n+V9lRoTbwDgNeEEQdzIiqziqFVG5wf+YgtL1CXmw==
X-Received: by 2002:a05:6a20:c888:b0:1cf:122b:37d1 with SMTP id
 adf61e73a8af0-1cf5e114436mr3384247637.30.1726004130293; 
 Tue, 10 Sep 2024 14:35:30 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b029csm1842451b3a.173.2024.09.10.14.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:35:29 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH] softmmu: Expand comments describing max_bounce_buffer_size
Date: Tue, 10 Sep 2024 14:35:12 -0700
Message-Id: <20240910213512.843130-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Clarify how the parameter gets configured and how it is used when
servicing DMA mapping requests targeting indirect memory regions.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 include/exec/memory.h       | 9 ++++++++-
 include/hw/pci/pci_device.h | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e5e865d1a9..9458e2801d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1104,7 +1104,14 @@ struct AddressSpace {
     QTAILQ_HEAD(, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 
-    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    /*
+     * Maximum DMA bounce buffer size used for indirect memory map requests.
+     * This limits the total size of bounce buffer allocations made for
+     * DMA requests to indirect memory regions within this AddressSpace. DMA
+     * requests that exceed the limit (e.g. due to overly large requested size
+     * or concurrent DMA requests having claimed too much buffer space) will be
+     * rejected and left to the caller to handle.
+     */
     size_t max_bounce_buffer_size;
     /* Total size of bounce buffers currently allocated, atomically accessed */
     size_t bounce_buffer_size;
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 91df40f989..8eaf0d58bb 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -168,7 +168,11 @@ struct PCIDevice {
     char *failover_pair_id;
     uint32_t acpi_index;
 
-    /* Maximum DMA bounce buffer size used for indirect memory map requests */
+    /*
+     * Indirect DMA region bounce buffer size as configured for the device. This
+     * is a configuration parameter that is reflected into bus_master_as when
+     * realizing the device.
+     */
     uint32_t max_bounce_buffer_size;
 };
 
-- 
2.34.1



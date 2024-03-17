Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A5EC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxaF-0002DC-Ja; Sun, 17 Mar 2024 16:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaD-0002CO-NP
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlxaB-0002aR-S4
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710709095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBrNqzZr7Hr6AbPSVoBq/JdhO106IzGnwVAYkki9vHs=;
 b=b91thGd7VwN+ZKN2PbQbtcZrcUdxjpnchAaSaH/GXvF1Yxe0OsaGJhAHFcyEnbBakt5lIi
 eLr0eCfbCimtLshAtL0VMvlKzqgf6kWe4aAs3VZ5pD1dmDh5zxxdQlcuTiVLpM448b2v7L
 08xDKJkbJWvlvTmiOaPDidoNFAx7yrk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-dj2BnyOlOcmvkq08ABwK-g-1; Sun, 17 Mar 2024 16:58:13 -0400
X-MC-Unique: dj2BnyOlOcmvkq08ABwK-g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-430c76df729so3705081cf.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710709093; x=1711313893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBrNqzZr7Hr6AbPSVoBq/JdhO106IzGnwVAYkki9vHs=;
 b=U/KPGp0vZ7m27GBgrTKsIISjMNklKbexEEYfMXUh5PIdqc/WCk71HO+A66puY1st9O
 WCI6c3lpOywupSK38Xfgaj4LAZo+IopksHjZEOZ7V28jtmEajG4S/aLeptQiEy/RRz6H
 JErUXRg7kFXNGNRxeyUNws5+HWo3556nCilrxAO6sIBxbb9GStB7jfip4nEcIfBrU/aT
 gjq17erp9DA3ahkUwr0y+Qm5VpxMfIBI+kYG3prRDIGazdtzdio21xWGMz8VQACD9w+V
 p7EcVJcaKVhNOtBPMyDLznyIOsCD1VNElVhQ7egQn4vnab+9jtTUyQYeoA2GfuNh+9lE
 W9gA==
X-Gm-Message-State: AOJu0Yw60+AdyH5vX15SHY62zXC9/VlkZh3miC/wl8bsuFVkHEL8TEZ3
 HMk0I16cipvrNeiiQk0tWf7MUjUiwZpJAcemFSCZIKJLSjYvwDFZF60K197no/vQjxlwrfsY9TD
 z2rTyPBdpcd23UcrLb0iEo0C6OdvLX+UOpO6mfmn1X8R5/dIBqlERBXW7JSW+dZiXQ4WWm0Daxm
 Eyz2j5dw8eg61YfoxkJDOHJTruj35puuO0Lg==
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr8961136qvb.3.1710709093146; 
 Sun, 17 Mar 2024 13:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2GXGuZfEQ4KPnVk3RegospeQLPcJekWOLOy2ws/e+5Wn9HY6GSrFBn9Kj8LYmk1rFwfV7Sg==
X-Received: by 2002:a05:6214:5345:b0:690:3c85:c5b with SMTP id
 kv5-20020a056214534500b006903c850c5bmr8961106qvb.3.1710709092510; 
 Sun, 17 Mar 2024 13:58:12 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ed8-20020ad44ea8000000b00691879d7a50sm2391566qvb.115.2024.03.17.13.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:58:12 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/10] physmem: Factor cpu_physical_memory_dirty_bits_cleared()
 out
Date: Sun, 17 Mar 2024 16:57:57 -0400
Message-ID: <20240317205803.361163-5-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317205803.361163-1-peterx@redhat.com>
References: <20240317205803.361163-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240219061731.232570-1-npiggin@gmail.com>
[PMD: Split patch in 2: part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240312201458.79532-3-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ram_addr.h | 9 +++++++++
 system/physmem.c        | 8 +++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..b060ea9176 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -25,6 +25,7 @@
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
+#include "exec/exec-all.h"
 
 extern uint64_t total_dirty_pages;
 
@@ -443,6 +444,14 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 }
 #endif /* not _WIN32 */
 
+static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                          ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+
+}
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
diff --git a/system/physmem.c b/system/physmem.c
index 5441480ff0..a4fe3d2bf8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -881,8 +881,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
     }
 
-    if (dirty && tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
+    if (dirty) {
+        cpu_physical_memory_dirty_bits_cleared(start, length);
     }
 
     return dirty;
@@ -929,9 +929,7 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
         }
     }
 
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
+    cpu_physical_memory_dirty_bits_cleared(start, length);
 
     memory_region_clear_dirty_bitmap(mr, offset, length);
 
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD54C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNz1-0003YF-T1; Wed, 12 Jun 2024 09:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNz0-0003Xa-GO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNyy-0004xK-Rs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so3704827a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718198743; x=1718803543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JM/gzg6Fck9TlOnDm2ZflmX6hvT5QMqxJafFp7HjnSg=;
 b=aqC9typcPzjbBDUqGAhWTBc0rZSCGq2yG7J0RWpWK9Ju8QPos3LJ6WWHLxaOLp9eFb
 ZACJlHLps03K/sJ5po8kyqpYUzGjXE+CP5VAUmfVwSeuYnNHcxAlm9hfQtlGpPizcVTD
 EUrzno7XZJFeJ0tffIp5CQ3ChkLLCrDatVRdy8tmYwuxfcyTEYtP1eNsV4eL56Ap0Dnw
 5SfG9lqccC+Tes4GsOjVTlIZjpQFgvzTolZjs038SQqQ9eG4ROdo9MpGXiFpNGFZtBnK
 FBNSbQgvEvxAauMpigd6Cp7AvlscWcxXvFQe7QvKvlp2tba4b987nxxjDH8axqTGoCnw
 bfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198743; x=1718803543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JM/gzg6Fck9TlOnDm2ZflmX6hvT5QMqxJafFp7HjnSg=;
 b=lmE/Q/75hZv3Csuy+/Pmyo3F5r9Ui+dUjGHgDOUssJ+F7iZLPPPFpwPVhZ4lKMHQl7
 rc17udksndB8wdcJ/qGJ6L2dWa7r4+nTp+3RDfbtWcBOBqcxs+xx9oto4aK6NJGc0J6y
 2QMCfK2ObdV/tmqBG0Guaf4COc7f1c4Uc1vElE+AmcTYlF2duJ4F3aqmA3j8Byl4wEiZ
 L5tiZ9edyDDyXLAkqmsHh/YaK79zzpWen+EUXLiW6kivDS2y0ucuViSiohmvPKmtTUsI
 dD4QfDTP+OIAXdvxKjszjDuztstzSJ5YnmdU3WW3e/o68t7sChZjTTCOhGJZnkXwSoUv
 s1rQ==
X-Gm-Message-State: AOJu0YwCHwwxXJvU/IpI31pVKLz7IZVrcYIqtBSAN/SPxsQfCe/kwlP1
 nxEpMzuj44AAUIgUtGPu7w9ZwAe/WHIkHgPbaHJ/8YEggUBkKPVPNCOr4BW1gkYSzjT2GjmvVGd
 G
X-Google-Smtp-Source: AGHT+IH5GtYMxgT2ufbi5rKE0o4I/odKrmSH6CP9+MR44R06RXitlsqOLM99JWQ3IqfNgjeJnkJlTA==
X-Received: by 2002:a50:951e:0:b0:57c:6004:4375 with SMTP id
 4fb4d7f45d1cf-57ca97513b7mr1433782a12.15.1718198742823; 
 Wed, 12 Jun 2024 06:25:42 -0700 (PDT)
Received: from m1x-phil.lan (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c6c95bb33sm7851525a12.8.2024.06.12.06.25.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jun 2024 06:25:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/3] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu_one()
Date: Wed, 12 Jun 2024 15:25:29 +0200
Message-ID: <20240612132532.85928-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240612132532.85928-1-philmd@linaro.org>
References: <20240612132532.85928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

@event access is read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 2 +-
 system/memory.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c..2bf5e23b6a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1852,7 +1852,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
  *         range.
  */
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
-                                    IOMMUTLBEvent *event);
+                                    const IOMMUTLBEvent *event);
 
 /**
  * memory_region_unmap_iommu_notifier_range: notify a unmap for an IOMMU
diff --git a/system/memory.c b/system/memory.c
index 74cd73ebc7..f3a37c97c1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2006,9 +2006,9 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
 }
 
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
-                                    IOMMUTLBEvent *event)
+                                    const IOMMUTLBEvent *event)
 {
-    IOMMUTLBEntry *entry = &event->entry;
+    const IOMMUTLBEntry *entry = &event->entry;
     hwaddr entry_end = entry->iova + entry->addr_mask;
     IOMMUTLBEntry tmp = *entry;
 
-- 
2.41.0



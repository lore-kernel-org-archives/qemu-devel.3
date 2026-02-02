Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E7E7FDE2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Ml-00053P-AD; Mon, 02 Feb 2026 16:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M7-0004X6-3R
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M5-0007ML-H4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so65521655e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067268; x=1770672068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uHF8IifM55Aqaq/6kWYrZN50Lp7Qdt66CjAoNd5bh+U=;
 b=Uuq3GhLt2fc0NdHka01Uh4mETFu8Sc8k/6oEEjvBw6sZ9ohc8dotQO4vL3GEycuwDl
 R1Lhmt0II5SWbjwc+yEnFnUfevSp0sH+lwp8SQxsTv+jYYsZywIFlXstKUitmYoJvJ6j
 Sz+GhFCuoxmA6bgx/KEg+IEhGL30G1J+8HyWxgWMixK6WCPwXkOPMnT2Rtiq6TXYEeJ+
 2A70VqTk22VjN/3kBRXkpY5crP5kLeXXNALU2QTWIdQxNEvBOLlPEAUEaPaQTxLXw82N
 dpguTmz+ttTWuAigGtkWceFsiAi3AjP5QSczs/LhPOyMVmGnSrAkgEF6E0DAa0mKYKCN
 hWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067268; x=1770672068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uHF8IifM55Aqaq/6kWYrZN50Lp7Qdt66CjAoNd5bh+U=;
 b=syAxKwiGdgLS+TVAesxuwoVp+94Lmn7ISKe4kXr0EJnrUrJZdWq4jrpPFc1yMwBFj/
 rLZKwnP48vf9pn1Zuuq7cEoLPrDGXZHPp2eDSt5rouCDh9jNRS5jwm0cEjUrajJnRrjH
 DliwF2xG4U5rDGWrAR8QYKX6B8tpOOppxQadK2Maxu4NqwobmgaSMYAI/cNtIMvGi7rf
 P+HKg1W7OdBLU+ONOqK8hqUBi7fIAQUgwUVMo51mIeTHt6Ue2DBoZbmfDrABrV6PdgTT
 N4+GpGaBPbfHUCAqId3jAwe4VZkQ0bl6hEmuimJwYFgdBvTlKi1svjhXCSJHsRKhuEtB
 fHNw==
X-Gm-Message-State: AOJu0YxTtKWoBW4nfZ8UC8L1Cr6vzR+Ih3NRGw5uQEq/0va/dPtDSQJL
 8RVuOAB44M9R3UAMXffNVXI/X/fByTHFPTdouTtfvMSfGgqZ1pK4rBw/Xgh/57bTZKhVThRN5BH
 deveyJe8=
X-Gm-Gg: AZuq6aKp3pT7QGrgoh8a05O1I3YG+tmn5wJu7dFmg4BuIZGGT/12X4iFn9XNdurPbwE
 0xGjjGzR5u+fQpeT7mzhZJ8uEMBF+NRLXyJTiUju8onySfmuTpJCN4F9x1RkH+tsP4FrWIxg0D+
 dmo556d8p3hN9u7AXQuUC7iWh+fO61oNA0hjHP6rXlKyYrQbDxqMvn+V+bbwyXlFWqGYx7l9AkK
 Jo1Nki+OtDCaQO6rz2EXK328s9SQlQ+7M03y/u94vxTPhlMw9Rljezcofjotoze9n1Al0D3fDWD
 zagRuuI+pW5u9jqXX2BUyWATbpV4Yo/H5+EDl9wGwK6SogEJCddj4n9C5v2fy1cSt5qUKxRqiGI
 4AWpl8iP4XM7aHt3QZl5/1LYNdwYLLYFU47PUijhjOer0Ha9yO6DWToGEr8RLo1dB/uQLYd/yPV
 qS/O+yrbNPuqXqXSazoa3Ob6hdm9A7LLoM839WKZ58ve3XdtEZUvy0GqBtO590
X-Received: by 2002:a05:600c:680a:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-482db46c758mr186158065e9.16.1770067267690; 
 Mon, 02 Feb 2026 13:21:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051292bcsm24193265e9.5.2026.02.02.13.21.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] memory: Add internal memory_region_set_ops helper
 function
Date: Mon,  2 Feb 2026 22:20:10 +0100
Message-ID: <20260202212019.94205-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This is a common operation used at multiple places, add a helper
function for it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <25045c95c083e31c6773521ecfe41900738b7bb5.1770042013.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index a9032fb2cfe..c51d0798a84 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1559,6 +1559,15 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
     }
 }
 
+static void memory_region_set_ops(MemoryRegion *mr,
+                                  const MemoryRegionOps *ops,
+                                  void *opaque)
+{
+    mr->ops = ops ?: &unassigned_mem_ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+}
+
 void memory_region_init_io(MemoryRegion *mr,
                            Object *owner,
                            const MemoryRegionOps *ops,
@@ -1567,9 +1576,7 @@ void memory_region_init_io(MemoryRegion *mr,
                            uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops ? ops : &unassigned_mem_ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
+    memory_region_set_ops(mr, ops, opaque);
 }
 
 bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
@@ -1710,10 +1717,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
-    mr->terminates = true;
     mr->ram_device = true;
-    mr->ops = &ram_device_mem_ops;
-    mr->opaque = mr;
+    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
     mr->destructor = memory_region_destructor_ram;
 
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
@@ -3780,9 +3785,7 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
 
     assert(ops);
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
+    memory_region_set_ops(mr, ops, opaque);
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-- 
2.52.0



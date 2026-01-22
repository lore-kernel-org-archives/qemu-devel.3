Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A9DC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqSy-0006K9-U1; Thu, 22 Jan 2026 03:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSB-0005QW-L6
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqS7-0005ub-F1
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so5760695e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072043; x=1769676843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e95VhvqMO+Qq7GUCp5VZHL+5pYlHvkErLQdbqhaXu8Y=;
 b=S4UPEn1JZLHJPjC8bzzg+l1kLfD80JQ64+/L8vijs/NfqhLHMrZlNt7oTAby166Dgz
 tVKc3T66nCcgkpQ254xuhNn5aLZlLqJfNRmZyHTdEyneb4FGCt2G/vaj+K8QX0ga5dG/
 bv85l9/1/AopYHPPHhBNHOQtybBTi1yFEB6QtkJKrA+gUU8pnQDwdfQFz/MygGN78vvZ
 RoWdiyAKADbLrOGmkg6AdzLbQdOa1hgTeRaiccNuArtS6b9MS6fugiq6yCIqN2QkZ7jC
 rTLo7H8E5P1/m76wuTd+1t5xzDuWw5YuRF5Ujo07R2Hns2ARlOr5KocqT66cn3ei3/xz
 vu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072043; x=1769676843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e95VhvqMO+Qq7GUCp5VZHL+5pYlHvkErLQdbqhaXu8Y=;
 b=SNCVdsfIMkg4WefSve3Cu+LTGuTR6Df+wwBF8drk7xQje2R/U2c2DtOb6lVPxlRoFj
 cp31xiVxfORXkPQNl3+siiWYnPP0j3rGoHcEsTAbHMC296pOVxgvjODXyN953d4pU/aN
 h+jyZM7CR4ZBXe3dCfO83+ljVgYMuLM//vxoWa2JBZARvxy+nmraG0P8MGjQ7Mic9jnh
 dlf7ey1YDfh9QzMjQsUG6Rq/R6ar/ofq/zz/2I6pvUdnJm2YpYUMn/hnTvmUfsWcqiPP
 URc3X3Q/kdjGDgiQol6PsxiPOCSVrKPO6MAzUr7F/RF0BVdXxlWKNQX9T+NEv5WB7M7X
 wOUA==
X-Gm-Message-State: AOJu0YzEkjJ1QDBfCLG559+ntUPdPT9JQfnNchE4rEmI6IXqMLlp6loI
 yl4PyVaEELh8szrnryYy9zFPcenDrW9dXbyF6pGMVY0ZNgY6EWS/nzwXw3bRm7MPNDs/3qG1CAu
 l9R0SYfg=
X-Gm-Gg: AZuq6aJFm0ZcY0cMpn/XYqCpcSWGTywR/rtUCTu6W5HsZa7tDtgzqvjYBcEnQWjjMsq
 N0eLatFo1A9ud6VCAFQeNC4ccd2QbIEGFYxGtTVmCTnvPmQukRuPkg/AiSDoHUhmBSkRY4DMm+j
 YHmOOGCa0ELi5ZGq/H+C0dT4vUtWyuxiOsI7FvKIAqWqiA5AAelvBb6RLeC3c4ZmguU2po2Et4A
 LhfS/0fAzhsyIqOqPGz3YGV6X985zeCl5TjkEAGxMbVEgdYd4PfFKGwEDcNCl0Yz4HNKf42OBh8
 vsbKu1MP+RIFrPru3AhQquP3eQEB382EECAjHR5nzaHOObQFrDmob1PPlxZ2001VItz5LKpn8GR
 XtMORK5IVGT4TbPk1iTfVVYwUAtPLB5bSo5nW9mcE5nrdAFrV8uy1HCpkFZwPMLMQjwrztr/DPJ
 HBT4+5+80kNlsn2P4FWW11FG1HJlRV77rws1ouxK3eiGSweD3ORxd1LdrMQ/ibRdI4/bmqu2Q=
X-Received: by 2002:a05:600c:c119:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-480470b7cfbmr27493955e9.11.1769072043076; 
 Thu, 22 Jan 2026 00:54:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cc278sm49410255e9.12.2026.01.22.00.54.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/31] system/memory: Use ldm_p() and stm_p() helpers
Date: Thu, 22 Jan 2026 09:52:33 +0100
Message-ID: <20260122085255.95035-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

address_space_{ld,st}m_internal() take a MemOp argument
so can directly use the {ld,st}m_p() helpers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-13-philmd@linaro.org>
---
 system/memory_ldst.c.inc | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 5c8299e0cdc..d51c5feddf7 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -27,7 +27,6 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                                   MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     uint64_t val;
     MemoryRegion *mr;
     hwaddr l = size;
@@ -45,12 +44,7 @@ uint64_t glue(address_space_ldm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
     } else {
         /* RAM case */
         fuzz_dma_read_cb(addr, size, mr);
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            val = ldn_le_p(ptr, size);
-        } else {
-            val = ldn_be_p(ptr, size);
-        }
+        val = ldm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop);
         r = MEMTX_OK;
     }
     if (result) {
@@ -102,7 +96,6 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
                                               MemTxResult *result)
 {
     const unsigned size = memop_size(mop);
-    uint8_t *ptr;
     MemoryRegion *mr;
     hwaddr l = size;
     hwaddr addr1;
@@ -116,12 +109,7 @@ void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
         r = memory_region_dispatch_write(mr, addr1, val, mop, attrs);
     } else {
         /* RAM case */
-        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-        if ((mop & MO_BSWAP) == MO_LE) {
-            stn_le_p(ptr, size, val);
-        } else {
-            stn_be_p(ptr, size, val);
-        }
+        stm_p(qemu_map_ram_ptr(mr->ram_block, addr1), mop, val);
         invalidate_and_set_dirty(mr, addr1, size);
         r = MEMTX_OK;
     }
-- 
2.52.0



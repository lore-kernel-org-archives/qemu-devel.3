Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76677CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rl1-0001sl-RD; Tue, 30 Sep 2025 00:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rkt-0001oX-Jz
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rki-0000sE-VR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:14:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so4219949f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205649; x=1759810449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uk5+wyHN7CkT7HC+T4CiL8GLFFBvq7A2wJEeem4enV4=;
 b=xJGZps97udBTc2lbfhV+49ELlHyw0ojHO/PMueyhP1nVif2psNO344j4cpFBRI1QL4
 BY1I23c4Jv03axcXlQYgoZIWQxBnSWt5rcILbINxT7HYJhBjUtwKpqzEu0v8B9IZFr1h
 bHnFIzQU/J4o4SZxkPT5LJAgXbALr+vlQ7BMrFgKmhGR/F9mBfKZM7YvkL6qmwTLjseX
 vA/uDYmHe2FNgiskdTMHWzYMuEu7pKUTix2v68JkfmbEwW2T1oJtGodhOONuFmyR6dPe
 u+SlfntkO6PmpuXBlf67qiMUzKlfwvBt2XTB9Us5dCH54oyBNN6NGdBPuas4/MIlGjv8
 ci3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205649; x=1759810449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uk5+wyHN7CkT7HC+T4CiL8GLFFBvq7A2wJEeem4enV4=;
 b=viX3Swa+UnhKCLZp1ZB33mF4RvhhDwrNlJAjHaww3LkOi2F35nFcXfmK9AuHIiyMjw
 Zy5f8oQ6tLRKJQWpQms/RTtBwHENwZACUOptBnuq5WhK9WPx4DKwFlIKhAISOX48FCJc
 abtgfFOF2Yz8vg5/BgsLSNT9L1C8G4Zus3exFLrVKUpU27dW0+kbgfhHfvTXVqgNuzbY
 zEytzYvSDKNacjokSOioSirQrYjtwAt3XLbzwuq5Zfq6XSJ/AvrVpYgNKBR1K/GEmnW3
 MoZ6pCbExPnmXWvxusGbSC/DDLWlQfJ0GyAYqCxh/9cJllGdJhie2iBSsjZanz2V7fxG
 JLkw==
X-Gm-Message-State: AOJu0Yx9uBIwmhHyLfQEYIGV/dNJ3+R4TjC7xJ3ZoAMLFhRx8ynGnWAj
 nIALwu75OhiyH1+94MBBoIt9eK1iBrXMXq48Vg2VFaWYkpcMrbp+vwN5RWDVlDHcSk45qSmG/1s
 PX/fImsin0g==
X-Gm-Gg: ASbGncvc/x2sWF0qeLSlst62o+KFFK0/oZf0eofhFdOq6qFtRk7Ab89gJngSnLdAjhi
 UNIlwnxdFuuvElu8M5ue/Zqrnt4lDNr1xzQGaJyDcfM7NWkoQAe7naCYGAX8e4+b72JoBSuLRLg
 XaH3lGvZyTeWcfkjDKacyIm0jdEE2vfW5wOb2sp3NUbL2Db/P7B94o2JAS6U0wzss+Xu+wDlMBr
 7Ul7/eOJtWDjfMxSvOyxSNMsMTMsdCNEX0A6XhuC9urwidDpmQ0kRt5NgNY3j8AxsQ6uGJEjOif
 crVsLSThcPBQhg2ZL0sqZsbGF7KKWvrmnxsH2RRdDV0KvRxO5KuW97klPmE78wuknOs0KqnYgtQ
 1pkQ5C9iy9PtDe88GczDRJ6L+8bxqCi7sKUxKHwCX2M9/YhnDDuO2EGgBJgtycDaJhRgLUBO1WX
 R7y6UWBeaaxNpFZxq0/sPW8SlJXK/uFdc=
X-Google-Smtp-Source: AGHT+IHVwaY6Q4s0F84QmaOmJAx4BK9ueW3Bbg0HpiOJvzkr7RtDJkQ0plXWj1SaEJLGINz1Ov7KPQ==
X-Received: by 2002:a05:6000:3101:b0:3eb:5e99:cbbc with SMTP id
 ffacd0b85a97d-40e458a9394mr12531634f8f.9.1759205648705; 
 Mon, 29 Sep 2025 21:14:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b69bc0bsm5141855e9.3.2025.09.29.21.14.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 07/17] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
Date: Tue, 30 Sep 2025 06:13:15 +0200
Message-ID: <20250930041326.6448-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename cpu_flush_icache_range() as address_space_flush_icache_range(),
passing an address space by argument. The single caller, rom_reset(),
already operates on an address space. Use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 --
 include/system/memory.h   | 2 ++
 hw/core/loader.c          | 2 +-
 system/physmem.c          | 5 ++---
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index a73463a7038..6c7d84aacb4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -156,8 +156,6 @@ void cpu_physical_memory_unmap(void *buffer, hwaddr len,
  */
 void qemu_flush_coalesced_mmio_buffer(void);
 
-void cpu_flush_icache_range(hwaddr start, hwaddr len);
-
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
diff --git a/include/system/memory.h b/include/system/memory.h
index 546c643961d..dfea90c4d6b 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2977,6 +2977,8 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
  */
 void address_space_cache_destroy(MemoryRegionCache *cache);
 
+void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len);
+
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
  */
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 524af6f14a0..477661a0255 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1242,7 +1242,7 @@ static void rom_reset(void *unused)
          * that the instruction cache for that new region is clear, so that the
          * CPU definitely fetches its instructions from the just written data.
          */
-        cpu_flush_icache_range(rom->addr, rom->datasize);
+        address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
     }
diff --git a/system/physmem.c b/system/physmem.c
index 573e5bb1adc..70b02675b93 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3214,7 +3214,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
     return MEMTX_OK;
 }
 
-void cpu_flush_icache_range(hwaddr addr, hwaddr len)
+void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
 {
     /*
      * This function should do the same thing as an icache flush that was
@@ -3229,8 +3229,7 @@ void cpu_flush_icache_range(hwaddr addr, hwaddr len)
     RCU_READ_LOCK_GUARD();
     while (len > 0) {
         hwaddr addr1, l = len;
-        MemoryRegion *mr = address_space_translate(&address_space_memory,
-                                                   addr, &addr1, &l, true,
+        MemoryRegion *mr = address_space_translate(as, addr, &addr1, &l, true,
                                                    MEMTXATTRS_UNSPECIFIED);
 
         if (!memory_region_supports_direct_access(mr)) {
-- 
2.51.0



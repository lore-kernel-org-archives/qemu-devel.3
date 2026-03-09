Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E77FCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziu4-0003Mw-9a; Mon, 09 Mar 2026 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTU-0000uZ-L6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:17 -0400
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1vziTT-0002CY-6S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:49:16 -0400
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1271195d2a7so8521503c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773092953; x=1773697753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgvw3VewudVvF9Ok3qNdpbXGvScSSWvQXrdO30ThciA=;
 b=mZoyevenAROLzWFv5xC4RNtalnN3H4I5JXmPRGLXkDqbqaFozVTvs5iAXMb+N2eVoZ
 ntKRU+vQvKoHecLRP704P+DKHWq8pW+9SnocSsUh5CLA3WeEtUmsQ8VbjGSQ0Lkd6Kd3
 PiMm+6w5qTrj8eb6br3dATwxPaqlcwcQoyhj36XpadpUG1BeSsWAiXW2h+0m08Uu172U
 cK6AnbpHPkpR50SYsQmwwqINLxaeTBY1gAtimCpA8r3Hn9l5FYw3HSoVTpK5yWiSKMhS
 DQyn0INgNy0AhxXMGMCFq06so0FAmZgc2EFF45TTRakR5YEOq1vdyx2KNLBaTcxfRvor
 h4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773092953; x=1773697753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgvw3VewudVvF9Ok3qNdpbXGvScSSWvQXrdO30ThciA=;
 b=ZdyfnswAYrdPJxlw3j4fK4ciGCHH0GBsxEvN4Mrhdd/criQjkFoTSURcRNcjPpPTam
 XOl7CxpxjZuzCEDwnP/n4C6TCMP9on9qPDEMF/z48d/AzV3NkPTQ8XCaiLaTO7vEDW9N
 eBfBu+qAMEd5jdPKG39RC4Bf4hPg8s05oh6SK0DiylmWBkc69V5daZJsswD+BcRMQ1NV
 4Y1APJ06yhQTghuA8idm/zRYg8TsocofefxtCFwD4jx1CEgxkqZH7ES306CASEMuQxys
 38oTFNq+TJQVVBJGgJnU9Q+eYziMIbXJ6fA/MVkKKJTSAVMKsN2FzX0557A5mVPkjURI
 ufxQ==
X-Gm-Message-State: AOJu0YyPI5YcKOIWGye7fYZrAmrgwRdXTpxfj6J67xkoskQOmxS+F4fI
 adgqgbPfmq0C0jK8617vMiVj9aBo+RdSsDQdM5/4vYuzXpsQ/NfONm1NJGrLpIjs
X-Gm-Gg: ATEYQzyErCNKSh1bS0+Ruj6ZmUbTJCDXtgkDDvj/M3ZxtePaIEO/q1Yp1JSrxfUTWNv
 A8MU94sSor35jfNKJRTUMHQcZr9q/BBRC3lHYeaTVNjx2XAT0Xr1f9CIa+94PjCVUeS9bzxAV/d
 BbmfUtffoX1hWP3kFf5/53OYGE3Q76nNVti1WaNYWHLiSbQZOSK00yArIDC0eyFuYVBx30tTx0Q
 9E3HG5Kb978nmbdUX8t2n5cfYhdkaT2EEDp+PM0r2pqk2QZgMVhkGUyC7mskqPkjb/VJ3sMpSwB
 oMMeuEpuc0fA6d7tD+tdQZqy7TeJDpckddvF+XAsl9b4TuDQ8Dvs2L536Yfy7ascxspuRFQfmIb
 suTTVuTw4/pRDUkOcbtRXNpEOv7S9+/zbY51B+sex27CnvxNtVgPyBKw7T7r8bK7WStAk9y4ZK/
 uaDU8CI7yCqZ0piNT00RF3dAQgkSfeUlRUM1lnuGPqMSUYaHy38PM=
X-Received: by 2002:a05:7301:2f95:b0:2be:e4b:60d2 with SMTP id
 5a478bee46e88-2be4de766demr5033962eec.4.1773092953384; 
 Mon, 09 Mar 2026 14:49:13 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:4cc9:ee1b:bd8d:dbab])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b1d3sm10821438eec.11.2026.03.09.14.49.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 14:49:12 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 1/2] accel/hvf: introduce map granule abstraction
Date: Mon,  9 Mar 2026 18:49:05 -0300
Message-ID: <20260309214906.92578-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309214906.92578-1-lucaaamaral@gmail.com>
References: <20260309214906.92578-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Mar 2026 18:16:41 -0400
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

Replace hardcoded qemu_real_host_page_size() calls in HVF memory
mapping with a configurable map granule (hvf_set/get_map_granule).

On macOS ARM64, the host page size is 16KB, but the guest kernel
typically uses 4KB pages.  The map granule determines the minimum
alignment for hv_vm_map() and hv_vm_protect().

Default behavior is unchanged (returns host page size).  A subsequent
commit will configure 4KB granule on macOS 26+.

Also fix the non-aligned region path in hvf_set_phys_mem() to return
early instead of proceeding with add=false, which would attempt an
unnecessary unmap of a region that was never mapped.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 accel/hvf/hvf-all.c  | 21 ++++++++++++++++++---
 include/system/hvf.h | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677..ccff626 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -23,6 +23,21 @@
 
 bool hvf_allowed;
 
+static uint64_t hvf_map_granule;
+
+void hvf_set_map_granule(uint64_t size)
+{
+    hvf_map_granule = size;
+}
+
+uint64_t hvf_get_map_granule(void)
+{
+    if (!hvf_map_granule) {
+        return qemu_real_host_page_size();
+    }
+    return hvf_map_granule;
+}
+
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
@@ -54,7 +69,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 static void do_hv_vm_protect(hwaddr start, size_t size,
                              hv_memory_flags_t flags)
 {
-    intptr_t page_mask = qemu_real_host_page_mask();
+    intptr_t page_mask = -(intptr_t)hvf_get_map_granule();
     hv_return_t ret;
 
     trace_hvf_vm_protect(start, size, flags,
@@ -84,7 +99,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     MemoryRegion *area = section->mr;
     bool writable = !area->readonly && !area->rom_device;
     hv_memory_flags_t flags;
-    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t page_size = hvf_get_map_granule();
     uint64_t gpa = section->offset_within_address_space;
     uint64_t size = int128_get64(section->size);
     hv_return_t ret;
@@ -105,7 +120,7 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     if (!QEMU_IS_ALIGNED(size, page_size) ||
         !QEMU_IS_ALIGNED(gpa, page_size)) {
         /* Not page aligned, so we can not map as RAM */
-        add = false;
+        return;
     }
 
     if (!add) {
diff --git a/include/system/hvf.h b/include/system/hvf.h
index d3dcf08..d1b702b 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -36,4 +36,19 @@ typedef struct HVFState HVFState;
 DECLARE_INSTANCE_CHECKER(HVFState, HVF_STATE,
                          TYPE_HVF_ACCEL)
 
+#ifdef CONFIG_HVF_IS_POSSIBLE
+/*
+ * Minimum alignment for hv_vm_map(). Returns host page size (16KB on
+ * macOS ARM64), or 4KB when HVF 4KB IPA granule is configured (macOS 26+).
+ */
+void hvf_set_map_granule(uint64_t size);
+uint64_t hvf_get_map_granule(void);
+#else
+static inline void hvf_set_map_granule(uint64_t size) {}
+static inline uint64_t hvf_get_map_granule(void)
+{
+    return qemu_real_host_page_size();
+}
+#endif
+
 #endif
-- 
2.52.0



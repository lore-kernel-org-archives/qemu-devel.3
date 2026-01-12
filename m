Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2383CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjI-0000TF-BB; Mon, 12 Jan 2026 17:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjG-0000Qt-VI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjF-0002Xg-9E
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so371515e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258179; x=1768862979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dxo90AOSwfgu9J2XgDP/+rX10E+aQoUAdEm6o/rPXxE=;
 b=oNXlrBGDnIqvPTOAkfJeVrV94zGkZGemvJwxH3VQH4/iEevfzJQes0d6I42zEyVPYD
 RA71ArixxRuJ1T6IEOxrTAVOPU50XJyNt4WyIVEZVHB4ry80i7r5ib8HVTjjgePiH8WZ
 5JSRS4tyZ2kuQcmDNTFT37sfoE8SFc7VS9mO4eVErAZiqlHKGSIy/dFbqaStrPoinWCG
 7WdoLvukZUzBN536QV8/a8XCHmwIa5+RtSM43vyLeJdpe4vB4bh79JjEREEutKga9R7V
 5w1VKg4kCQmcKw5fVzEYREbQ6t8v3HDsonZ/tORzLC4/BjXk0/4Ooc2eP6Jn9h4r0BuF
 iWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258179; x=1768862979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dxo90AOSwfgu9J2XgDP/+rX10E+aQoUAdEm6o/rPXxE=;
 b=mjWtl5+GPCuZOHnkBkGGkkYeA/5nNFFkiTrAqBXmAnmNdc7Nry2noF86DodoYPFyP5
 BAQwdw0ASLTZecSSvmGseeVz725S5op4vj5+CRyCiQ1nnD5El65KTTpArqkbLiu8dcWd
 HQyksYoIEGH8WeHyViUeEzLYcNsgMOb52FGho0S7h3ISafPiCxTt+y4XgAggPX9koJ6i
 c11AOQyuTuT5ZGuXgkQhD5m9nX+/DG7JP4BCB2MUFkZ/92TwQQfh//rxpTvVg/zMYV6b
 HsQt8fk2sm5Yq6o7ZKp6p9PL1ACrpZDk1UVq2qEoQpc/02Tv4tcB6uHsvcj6zw+lFMJK
 WS6w==
X-Gm-Message-State: AOJu0YxPj7ntZYW9jh7EH8YZJIcuIqAS+bC2xjs1ujilXMl2UsrKthxj
 bCcZwqqwtfYcQAJFLnabbTCIb8b0Oo8J51C6aiufqHz5dy5uQe2/GHAkppUXZQ5n0usY/qKS8MA
 v5jDdKrk=
X-Gm-Gg: AY/fxX5NgDqpSatH/Jpudk8NrfQHI8cVA4+wF8xOQRks7rLVDFkaKg4L26eKGAffcRy
 mPPCzOQ477DGMKwRkFgch0EuErWFh5Bd06ZG0W/ecwmAxCg9o9U4p3n9www+FH5gXfYaSU2ySca
 mjcWvdcmrSEuVuugF/bN4YduVmxE1r3w7ezaSAQ3C5gOgiPQRkyDOyorChs8CpNrOVJsr6ukNDZ
 fB2+8VQYymDe1WI1S17go62XqEqWJXnlYwwplS9WJdo3mj7VEOGbZvoZtINYFsY+ZGnHJAns+xm
 0EoYmq4vBkIfddZYCF6ySSzQXHxbZ7IEQ9Bzn2kHltTdaFJdXDNFjvdJh+5W4l0mID3bwA+SclV
 kkOFUJfVX+tYaga1epb6myh4rf0Y5Qp9MeaAbRdW6yUI8tzrxNfgPERRjljdZexljPnKf3Zy3eK
 kMgmCra8+5eL4MaA/WggynnbfitaKw6Sgpuis3kr3v03wxoO8SwSMa9nWeY7my
X-Google-Smtp-Source: AGHT+IHzzaI8NgIxxYpGFLUJWevJim7K8tkgoIP2KZM22x1xpFZ+rnSxkGvLQtwTXcqrMtC6wuFkNA==
X-Received: by 2002:a05:600c:3b90:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47d84b39890mr218207675e9.26.1768258178957; 
 Mon, 12 Jan 2026 14:49:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda4402fbsm998795e9.10.2026.01.12.14.49.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/61] system/physmem: Convert DEBUG_SUBPAGE printf() to trace
 events
Date: Mon, 12 Jan 2026 23:48:01 +0100
Message-ID: <20260112224857.42068-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Defining DEBUG_SUBPAGE allows to use raw printf() statements to
print information about some events; convert these to tracepoints.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-5-philmd@linaro.org>
---
 system/physmem.c    | 29 ++++++-----------------------
 system/trace-events |  6 ++++++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 829bf598189..9981539543f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -91,8 +91,6 @@
 
 #include "memory-internal.h"
 
-//#define DEBUG_SUBPAGE
-
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
  * are protected by the ramlist lock.
  */
@@ -2921,10 +2919,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     uint8_t buf[8];
     MemTxResult res;
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx "\n", __func__,
-           subpage, len, addr);
-#endif
+    trace_subpage_read(subpage, len, addr);
     res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
     if (res) {
         return res;
@@ -2939,11 +2934,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
     subpage_t *subpage = opaque;
     uint8_t buf[8];
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx
-           " value %"PRIx64"\n",
-           __func__, subpage, len, addr, value);
-#endif
+    trace_subpage_write(subpage, len, addr, value);
     stn_p(buf, len, value);
     return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
@@ -2953,10 +2944,8 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
                             MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p %c len %u addr " HWADDR_FMT_plx "\n",
-           __func__, subpage, is_write ? 'w' : 'r', len, addr);
-#endif
+
+    trace_subpage_accepts(subpage, is_write ? 'w' : 'r', len, addr);
 
     return flatview_access_valid(subpage->fv, addr + subpage->base,
                                  len, is_write, attrs);
@@ -2982,10 +2971,7 @@ static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
         return -1;
     idx = SUBPAGE_IDX(start);
     eidx = SUBPAGE_IDX(end);
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p start %08x end %08x idx %08x eidx %08x section %d\n",
-           __func__, mmio, start, end, idx, eidx, section);
-#endif
+    trace_subpage_register(mmio, start, end, idx, eidx, section);
     for (; idx <= eidx; idx++) {
         mmio->sub_section[idx] = section;
     }
@@ -3004,10 +2990,7 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
                           NULL, TARGET_PAGE_SIZE);
     mmio->iomem.subpage = true;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p base " HWADDR_FMT_plx " len %08x\n", __func__,
-           mmio, base, TARGET_PAGE_SIZE);
-#endif
+    trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
 
     return mmio;
 }
diff --git a/system/trace-events b/system/trace-events
index 82856e44f2e..6d29a823f04 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -35,6 +35,12 @@ find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
+subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, int eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x eidx 0x%08x section %u"
+subpage_init(void *subpage, uint64_t base, uint64_t len) "subpage %p base 0x%08" PRIx64 " len 0x%08" PRIx64
+subpage_accepts(void *subpage, char access, unsigned len, uint64_t addr) "subpage %p %c len %u addr 0x%" PRIx64
+subpage_read(void *subpage, unsigned len, uint64_t addr) "subpage %p len %u addr 0x%" PRIx64
+subpage_write(void *subpage, unsigned len, uint64_t addr, uint64_t value) "subpage %p len %u addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E3FD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghra-0000ZW-NU; Fri, 16 Jan 2026 06:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrZ-0000Qs-7H
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrX-00067b-DU
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso17296995e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562369; x=1769167169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4VCJw2Mh019bUGRv0tYMpX5m9MPccao029SIxhwO1Ug=;
 b=OJ6XVWMQHBgM+P/KtG6+MDlKWIiNmuv4G9VcjlbURpT/ukviR0aoo10oLLSN64K0L0
 KHCaWs9WuQOv72Acs9kuOdvGzim9XRg4lx/++h7uKD0jCaOKxFFLRJnylpsehkIjxbie
 e9Dtmvv1dld9cnT1HVhDbpCNSHWy3TMyHbM+leBphP+C3H6q4o5hOLVcZxmyp7PlR2PQ
 86t8tt6ZTLUY4ZcNw5pU/g/1B6llQEMQa8clLgN/Y8u7ZzMb27y2VB/oqQrwl6GQ1C5A
 O10hWPQlJIDFKNl4Em3ByUxugMbInV4wtjbIfJtz0fY0w0IX/JFTvRW48ha/MCOeNfJK
 g4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562369; x=1769167169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4VCJw2Mh019bUGRv0tYMpX5m9MPccao029SIxhwO1Ug=;
 b=cbcb9x+P+m3BjN3brYR5GtDrFOwyQuEgwEZU8jeoWeLMh7wqzJ18zzN2/KngoCSDx/
 wj1o8DuQRwYatsery66HvHwhFN7SqhOZNL1fFnxrNc0LwGPRH0fltJK0/zfIL5LD3A67
 npBzcHnTvtvzpux2oEy2cxQzt0a79m48CyX0HM7C66uGKYGgKV08vX25vi0D/LSbKGQj
 hSiLgswyQdy8kkygi5veyTj0zmBB1ohbE1Z79Wb9ox+G8pexgEo9R/Yb7RNhpJmwm8Jq
 dSrg7N7/g/H8GVO7qCsdncqpXARZ131MsuHLNjtu1OibBmMjW/DAm6HBShfshHTPnDFx
 c75Q==
X-Gm-Message-State: AOJu0YyfWmUYbT+0cpcxr9z5TkMN69+j+DuAumqPXAT9JlAmq7Vyz+gC
 YjrFxmbwDuZRpnDCApIYF0rOCVIiah+vBscZ2HQg4yw5fL0jXPXcmg1tmWsqeLLR8kPLyOcuo2m
 gTj0hA9I=
X-Gm-Gg: AY/fxX6hx/VDlPdtu0TXcXZdYJWpnjI+zG59hXKwUX2IeDUV8tncdTQD/AKWPBwRZ74
 td1xBqhqkgcDMIQQx7p97xHDjNzu/z+IuIYbV6pzL06L/3V1JAHtgDqVN+Fgr5jUSTIimpWdbAS
 GrsA4mhywjx/46Kjv0iIE8sDGOcELtDuqB+eBagtWcmoCaKKvRG2omd6Es6cs4q9kXrd9ctiDuZ
 t1l6vvoMAfj1QHhy5CzNp7W7vIu0lXml3ZgNWBVJaoO65rRqLefc/QVCiKq8PUPaUE5l2WmQYIo
 RkxoyYE7W9cUbzQF2FAx/1YwxgiHtzpgNICLqLkKeiN49FVMbqpXrBEtT5JVGoHOS/fnE14ELou
 ifQwMzMbsSGD2d8Oay+uDDCbGNpHVUuBfAb5U1ymxldVCcjk8RjH04GsZgBscvTZWO5Y0JZzOJD
 6e4XEJduUFTGeEkSonhGpPqA6hPrgmirE02PFttqHEbPoDvX9wSg82ff2scF4E
X-Received: by 2002:a05:600c:3107:b0:480:1a3a:5ce6 with SMTP id
 5b1f17b1804b1-4801eabf6b4mr26056385e9.14.1768562369470; 
 Fri, 16 Jan 2026 03:19:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm93965075e9.12.2026.01.16.03.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/30] target/i386/hvf: Use address_space_translate in
 ept_emulation_fault
Date: Fri, 16 Jan 2026 12:17:49 +0100
Message-ID: <20260116111807.36053-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The hvf_slot structure is a poor replacement for properly
looking up a memory region in the address space.
Use memory_region_get_dirty_log_mask instead of HVF_SLOT_LOG.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-6-philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1610000d9ca..8532e0fcffd 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -119,9 +119,12 @@ void hvf_handle_io(CPUState *env, uint16_t port, void *buffer,
     }
 }
 
-static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
+static bool ept_emulation_fault(CPUState *cs, uint64_t gpa, uint64_t ept_qual)
 {
-    int read, write;
+    bool read, write;
+    MemoryRegion *mr;
+    hwaddr gpa_page = gpa & qemu_real_host_page_mask();
+    hwaddr xlat;
 
     /* EPT fault on an instruction fetch doesn't make sense here */
     if (ept_qual & EPT_VIOLATION_INST_FETCH) {
@@ -129,21 +132,22 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
     }
 
     /* EPT fault must be a read fault or a write fault */
-    read = ept_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
-    write = ept_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
-    if ((read | write) == 0) {
+    read = ept_qual & EPT_VIOLATION_DATA_READ;
+    write = ept_qual & EPT_VIOLATION_DATA_WRITE;
+    if (!read && !write) {
         return false;
     }
 
-    if (write && slot) {
-        if (slot->flags & HVF_SLOT_LOG) {
-            uintptr_t page_size = qemu_real_host_page_size();
-            intptr_t page_mask = -(intptr_t)page_size;
-            uint64_t dirty_page_start = gpa & page_mask;
+    mr = address_space_translate(cpu_get_address_space(cs, X86ASIdx_MEM),
+                                 gpa_page, &xlat, NULL, write,
+                                 MEMTXATTRS_UNSPECIFIED);
 
-            memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hvf_unprotect_dirty_range(dirty_page_start, page_size);
-        }
+    /* Handle dirty page logging for ram. */
+    if (write && memory_region_get_dirty_log_mask(mr)) {
+        uintptr_t page_size = qemu_real_host_page_size();
+
+        memory_region_set_dirty(mr, gpa_page + xlat, page_size);
+        hvf_unprotect_dirty_range(gpa_page, page_size);
     }
 
     /*
@@ -156,11 +160,8 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
         return false;
     }
 
-    if (!slot) {
-        return true;
-    }
-    if (!memory_region_is_ram(slot->region) &&
-        !(read && memory_region_is_romd(slot->region))) {
+    if (!memory_region_is_ram(mr) &&
+        !(read && memory_region_is_romd(mr))) {
         return true;
     }
     return false;
@@ -765,7 +766,6 @@ static int hvf_handle_vmexit(CPUState *cpu)
     /* Need to check if MMIO or unmapped fault */
     case EXIT_REASON_EPT_FAULT:
     {
-        hvf_slot *slot;
         uint64_t gpa = rvmcs(cpu->accel->fd, VMCS_GUEST_PHYSICAL_ADDRESS);
 
         if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
@@ -773,9 +773,8 @@ static int hvf_handle_vmexit(CPUState *cpu)
             vmx_set_nmi_blocking(cpu);
         }
 
-        slot = hvf_find_overlap_slot(gpa, 1);
         /* mmio */
-        if (ept_emulation_fault(slot, gpa, exit_qual)) {
+        if (ept_emulation_fault(cpu, gpa, exit_qual)) {
             struct x86_decode decode;
 
             hvf_load_regs(cpu);
-- 
2.52.0



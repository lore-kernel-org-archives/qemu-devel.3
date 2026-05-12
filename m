Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BDCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYn-0007Gc-Ol; Tue, 12 May 2026 02:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYA-0004Oi-GD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:02 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgY8-0006e4-48
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso3072169f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567096; x=1779171896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bn7X1HxFbi8TLPRLLkIpSiNkQaC8IQE21wNQZ9Ce9pk=;
 b=mf4X9Ej92FZ8L0Jz41c+9URevfg/loVFV81i6nF3lLhOJb5rDBjRzMZvibpdwYf2Vq
 Uw+F3vhFxS9nH2MHhZHnIl1VxFkO6TxQG3CrYvrXx1OjzOojUeza2dczKkyiNXiftM5E
 NK0CogAbTUl4rOzT8eMRHkBy08SOeQ/nm7DYASwceHgKAqPD6o8/6jB/Ug04OnKOmsvn
 YHKb0hyE/5RKWj6/g/+wi0RzTBCh7aAtALBQ5O2mXJyTw3fQotog9VFnYHluUoFIagrh
 gtd+DMUhKpub1HiHoGOG4Tygf28QAfzZCdfynb6tStX03Ma4lT88lXUdOCAql45XJS6U
 5feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567096; x=1779171896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bn7X1HxFbi8TLPRLLkIpSiNkQaC8IQE21wNQZ9Ce9pk=;
 b=peoPC4VybaEmtSGAQP0O/JnbQ1SV7RAS7cd1UMqA+GPnQhXjDCcVGYGKQN8GtS4Qz4
 lTpBxmzeSFD5+LW1yNPx8CVeeq8auK65TjtmDOOw5NVdky03HZXruI8VSKU+3bH/auRI
 GctoVMhAar28/L7l9v+zlt/6f7bSnTIz93CaaqulDs1ceA5O5Pb+ENhx/BxKSMyLI9HX
 FiWClnBfyX0zVsBu+McH6+wMQp7e0O2+wmrAP189JgHfnfAXkBwAOCVIKMEnsudZqSQn
 uYQnk2+k1SkY5UGSzr8bq89/2DVx8RiRKRgSGbRwzfHgKYslmTVxn0JuWnEJwXShyb5C
 l6LA==
X-Gm-Message-State: AOJu0YzuO5VX6A3ZcYDf0VG1SRwtGAsIjyZ6rUNG4fV4UOd6Xat1FRmg
 ZBVL6ETFNxHAkbR+p2htuqQjRA90Y6tzi3DDVekecoQKZI91KetfofA6QcTyuwYaFOyloscqwc6
 vVE37WnU=
X-Gm-Gg: Acq92OHnNetD0b8xv0XvZTzK8D2J4dZ9vMZdGkc3zvsAIB0Gq52tstR+7IAO2uYdVJr
 iBFIM+JWSsGkb/V5WBpxSlmac2A2V2pXmMwIpWaPwXAGdfTKoqNzymy98fXo1GW/Cc8toQsvpZC
 1fmOIXHkBSL5F8K4tCqqY0BaYj+ALxu6KG4oRHss3Vh3mcqKEej63kCQf+0P1rO7pYOrEM8vI0I
 x8dxapU0VyDewFyaXkP0QpviPHFEP1pa9et9ivg5fSCiIBt9DtV3WfHrFDph8asmx2AHn0siGA6
 Gtfd54eAYy4NhPSzCzyCVTAVaM06oT1BSoVR7juo/JIKEPwOXkTa6xesy2LPCskW884FP/JXB83
 nw3yflucOtJ4iy4R6fgPiJ6pyxmSIXtol3s2RwSmhN23ljoIgeYDlhdOXhHVWnlLB4ZiuD+VYif
 jOxnYrWSyS0ubZ5cZYOsg0npRiOZ6aqI2AH0E+psax6eeIdo6OM1TrHvHn1091hOubanaq51P+
X-Received: by 2002:a05:6000:2288:b0:43e:a75e:352 with SMTP id
 ffacd0b85a97d-45ac093a86amr3545573f8f.4.1778567096080; 
 Mon, 11 May 2026 23:24:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c79fsm32151306f8f.15.2026.05.11.23.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
Date: Tue, 12 May 2026 08:21:28 +0200
Message-ID: <20260512062142.67998-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently cpu_memory_rw_debug() assumes page-granularity for translations,
and it works in a loop where each iteration translates for the vaddr
rounded down to a page boundary and then copies up to the end of the
page boundary.

Rewrite it to use the new cpu_translate_for_debug(): we no longer want
to round down the input address, and the boundary we copy up to is now
determined by the lg_page_size it returns rather than being assumed
to be page-sized.

This, together with the implementation of translate_for_debug for
Arm targets, fixes the bug where semihosting would incorrectly
fail to access parameter blocks that were in memory where the
start of the 4K region they were in was inaccessible due to MPU
region settings, even if the parameter block itself was readable.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3292
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260417173105.1648172-18-peter.maydell@linaro.org
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-19-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 652b03ad5f5..7bcbf875736 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4030,28 +4030,38 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write)
 {
-    hwaddr phys_addr;
-    vaddr l, page;
     uint8_t *buf = ptr;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
         int asidx;
-        MemTxAttrs attrs;
+        TranslateForDebugResult tres;
         MemTxResult res;
+        hwaddr blk_base, blk_size, l;
 
-        page = addr & TARGET_PAGE_MASK;
-        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
-        asidx = cpu_asidx_from_attrs(cpu, attrs);
-        /* if no physical page mapped, return an error */
-        if (phys_addr == -1)
+        if (!cpu_translate_for_debug(cpu, addr, &tres)) {
+            /* Return error if no physical page mapped */
             return -1;
-        l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        phys_addr += (addr & ~TARGET_PAGE_MASK);
-        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
-                               l, is_write);
+        }
+        asidx = cpu_asidx_from_attrs(cpu, tres.attrs);
+        /*
+         * Clamp the amount we read to not go beyond a page even if
+         * the CPU returned a larger lg_page_size, in case this access
+         * is to a memory-mapped IO region.
+         */
+        tres.lg_page_size = MIN(tres.lg_page_size, TARGET_PAGE_BITS);
+        /*
+         * Find the length in bytes from tres.physaddr to the end of the
+         * block whose size is 1 << tres.lg_page_size; we will access
+         * that much in one go.
+         */
+        blk_size = 1ULL << tres.lg_page_size;
+        blk_base = ROUND_DOWN(tres.physaddr, blk_size);
+        l = blk_base + blk_size - tres.physaddr;
+        l = MIN(l, len);
+
+        res = address_space_rw(cpu->cpu_ases[asidx].as, tres.physaddr,
+                               tres.attrs, buf, l, is_write);
         if (res != MEMTX_OK) {
             return -1;
         }
-- 
2.53.0



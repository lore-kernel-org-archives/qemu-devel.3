Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B22CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZV-0007jc-Dp; Tue, 12 May 2026 02:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYF-00052k-P5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYD-0006qs-Pg
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:07 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso2550207f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567103; x=1779171903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q/74YiYYWVPq8korOPGH440atE8m0+pkzhjzBW4zxKQ=;
 b=uqTrdMPBmfwA1irKNtmfuUpEh0NugP+Jze3VRtkpg1vV+GVKNu8SAnO4uWU08Q6L2p
 d18k6axxYLlbTLwoSblQA35prQSHQ2uVmNan7mLjs9mOpKUDHaMOa2LZQ0ftvp3G5o9p
 YI47s4ZuKuJzlRJMmr++grIUOailB8JzPU2LM3XaGnxCDpUbOmzuJaLDvKhPnK/srvJ5
 rGmxSFRYrH9vxaR1Wjybn2bZjyNe2FhXVNHRJ3fZYeLAver0l5q+LSOUTXVVnz0MhbcM
 4iddv1p8+nUk02BIM8eiqU27cOvoSeLrnkRkLYPBZ9ChTQsevD22Q9nRLFF/4lcXr+QE
 0M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567103; x=1779171903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q/74YiYYWVPq8korOPGH440atE8m0+pkzhjzBW4zxKQ=;
 b=oMyDa3asacGX3bHF5DGf2/4sK7UOXAzUR2BubXnZG88SolLPJJgC5hoforDOjsqBqY
 /9yMj/1qQakFySIrDhcaHKTFKfXRAn+y4XdGGYCV1T5U3vyOEIoB5mop4HRTYKO/Fl+L
 XIKrm7Wb9yBvK0hz34yPcoXIjCD8eOz9MngWpBd7FbUE3h4pSBL89BRiFlMZ11RO4Ngu
 5V2nz2hGIOltZS3GFvD0QXrurK/+WCcgecOIoRsS47RCsr9TCJ3Yzl/MR9QtlXf25dQy
 nesKgGubwk8d3/tnFf17aJc/iORNLOHfnPg819MfDRohSPvFAuN1bQd0wKQKhFZjeNNT
 mGLQ==
X-Gm-Message-State: AOJu0YxhDM30fyuLh1NHvI5oPYJ7GMjw3mb50cwKk/VLuljQw5rkPh5l
 uPIhkcCVFK26eb5lfTICX5ps6cGbON+BN6quEDWGtEOmIeBOFefTxQ7svosxD/bLsQptOI1Qsd0
 9ytTzm8M=
X-Gm-Gg: Acq92OGS4VXRCOC6xbc7qhma5GcRldIXuiZJU+2s8x8i8OnbKFrU0EtlU7sOnefMZEt
 JmNPkBmTiU9ELzA7Gy7r9ua8LvIgwzx3+7llwkcMlP7wB/FizJXdJnWjw5KqC3AtjZdfMtpk/qo
 mpgyFzJo2987NB92vhzz9C9iaY//PhWOxe45MOtlbIvussxmy9g97/gtPVYnJW8k7vPGy/KETyp
 sdoNmK0GtpgK87PH3uOxLJHeyDuIPFcCN0E0K/IM8XEojADQeBPImPOxKwpXDu0suxnGbgRqbte
 ZIen0wb/K4Mzjxox5eXsih9HF1WD2L00H8P7+c37qSNvjyZ8K0S2q3mhi/34ZjsyAgcWgOY8W0S
 rvr+N+JAR+BxpaiWBHksZsje8cxUcSY5A/RQLM4YH2WqHn+gFmdjwEtQ4AF72KwCCWFZaKkvddZ
 RYMUwClUz/bS24B9NTTU1fM6znl/2cHg6w1YySW1ziitk8jDZs5q3RtOYZ4bb2w1yVaptAUkmZ
X-Received: by 2002:a05:6000:2082:b0:43d:7e34:889c with SMTP id
 ffacd0b85a97d-4515da97e81mr42221304f8f.39.1778567102896; 
 Mon, 11 May 2026 23:25:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm29585051f8f.20.2026.05.11.23.25.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] hw/i386/vapic.c: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:29 +0200
Message-ID: <20260512062142.67998-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

We would like to remove the cpu_get_phys_addr_debug() function, by
moving all callers to cpu_translate_for_debug(). Update the callsites
in vapic.c.

In the process we can drop the old "OR the page offset back in"
workaround that we had for when cpu_get_phys_page_addr() returned
the physaddr of the page base rather than the exact physaddr of
the input virtual address.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-20-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/vapic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 225f19a75c7..781bf2a7fa5 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -161,7 +161,6 @@ static void update_guest_rom_state(VAPICROMState *s)
 static int find_real_tpr_addr(VAPICROMState *s, CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-    hwaddr paddr;
     target_ulong addr;
 
     if (s->state == VAPIC_ACTIVE) {
@@ -173,8 +172,10 @@ static int find_real_tpr_addr(VAPICROMState *s, CPUX86State *env)
      * virtual address space for the APIC mapping.
      */
     for (addr = 0xfffff000; addr >= 0x80000000; addr -= TARGET_PAGE_SIZE) {
-        paddr = cpu_get_phys_addr_debug(cs, addr);
-        if (paddr != APIC_DEFAULT_ADDRESS) {
+        TranslateForDebugResult tres;
+
+        if (!cpu_translate_for_debug(cs, addr, &tres) ||
+            tres.physaddr != APIC_DEFAULT_ADDRESS) {
             continue;
         }
         s->real_tpr_addr = addr + 0x80;
@@ -292,6 +293,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
     hwaddr paddr;
     uint32_t rom_state_vaddr;
     uint32_t pos, patch, offset;
+    TranslateForDebugResult tres;
 
     /* nothing to do if already activated */
     if (s->state == VAPIC_ACTIVE) {
@@ -305,11 +307,10 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
 
     /* find out virtual address of the ROM */
     rom_state_vaddr = s->rom_state_paddr + (ip & 0xf0000000);
-    paddr = cpu_get_phys_addr_debug(cs, rom_state_vaddr);
-    if (paddr == -1) {
+    if (!cpu_translate_for_debug(cs, rom_state_vaddr, &tres)) {
         return -1;
     }
-    paddr |= rom_state_vaddr & ~TARGET_PAGE_MASK;
+    paddr = tres.physaddr;
     if (paddr != s->rom_state_paddr) {
         return -1;
     }
-- 
2.53.0



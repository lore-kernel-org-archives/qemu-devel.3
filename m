Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB2DC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bRu-00072y-Bg; Tue, 15 Apr 2025 04:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bR2-0002Fh-5M
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQx-00025r-V5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:14:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227aaa82fafso41444225ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704852; x=1745309652; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r8MkLirfRd+1eYBUne8MUcSIMDu4+B+icN4ZLFGI96k=;
 b=gxIlBtTWEFYL7lEQ0Utx/NB+sqqjEwH4QDA3ht1YuJFpOPZCQpfQDBtCTyh8Hs9VTe
 A6+gqhtI2TsRNB4CTWP2GRYEzpO2SxyOP8fqj0nfYhkIE03JEKHgGldscXFDhKgtt1dp
 +IICnRTyga2V1UTYlby+aJXR5SVQ8iYTCcdnHy+BmhQNYtNzuDotWQZQp0w8mGR/HZFg
 ChqeO1t1kNQIjU/Y0T3OMLgfQ8HAAGmFqO+VCYGIGJ3Z99t+4jiAZ5rizVlUwgrONDsR
 5Mitm3tJE8NW32PrwbEs7FzlqAxg7QxPNCzNSO8fe947gQg4hqeQLiJ3e8yjE2b0Mofk
 FTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704852; x=1745309652;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8MkLirfRd+1eYBUne8MUcSIMDu4+B+icN4ZLFGI96k=;
 b=PaVsi37dsORIFtSOggnLaKySLfjVa+dDU2Xklerb2tvytaWOWv0P7CrEY3FYrnvQ00
 Vc6A2mAHLxWyZY+QSLyS6/LlFzea8Z08ZMRXyc9gCifIEIbP+TnsPfEP7YwdaAH/MKsI
 8Zpd4eJuCsVxImqy4O5BycGGKC8RoRyB1BbNwRtH+/SNnYhhGaIz9Soxgj1g+xIxh2SZ
 FLa9n6Q/dK1/BvPWSnfiq7Sp/PdHVfIPU/+ULaeTGiqmiyKB5ILA+YGHowB7Pjwwl8zB
 EESyMrRasfwDlKUybF3UuH82VXpUd1i+LSoNa8Ulvj10z8vO7DXFABCL56bqxFKxIpRQ
 ZNlQ==
X-Gm-Message-State: AOJu0YwL8cRbdeVKfZ5wt0xW2bdCtXvAY1wih4PmFaFsawuSH/64jxah
 2LH0Nz6S2C0kWqIU/ebZT3g+sLPAv2GWqs3yCHS9drTdB4x7rz4wSVLFTcpcem/dd+H1JXnBC9S
 k79OK3JSc3BDupGqo8KYZlIlsS/vxSKsnKHNOnT+sGURzZ9fD68WG/XBf9KzRqhCLB1QekLugu0
 bOhPoYxZafRsUiTvRotbYXphCmeo+8L8QDjA==
X-Gm-Gg: ASbGncs5TTlzkNYCHB8jSACB2VnYvKwQ0vhhocRxhDeA8HHkpSw7WnsA6KblCNyAZ+L
 kxh3AuEyATtgR570LsH/QwVSdGeNk1SCXkh7DRcf33yaa7fqm+ukWpC8eeCAVI1MwqK3b8cw7f1
 TZFkL8hjtoZ+6ZWmI1+YTwMz/S6M5di9gYAzXxe3fJigcb6R6WC6Wo1Al9pTJkhRmreaYN9WosJ
 NsNi1+i7t10NOaSLp/XZjcsvNgjCPS8Vwkq9NtNWmqVKwh1ivMIXr+GCly6R61YOGyElf2tu64E
 ijesyMq9pC7vCOv/S4xbY68mQLczBcSl6UKjczndHYzMODO/UxERyARdm+0Y4uc=
X-Google-Smtp-Source: AGHT+IHxw7teXwFJ4+Xorx5jZKi3l2qB+ap0ikCAJQv72KwcfUzrub4eg69qzmdmh8H2UK4tWBzqJw==
X-Received: by 2002:a17:902:f64e:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22bea4adf58mr246190645ad.22.1744704852067; 
 Tue, 15 Apr 2025 01:14:12 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:14:11 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 15/17] hw/misc: riscv_wgchecker: Implement correct
 block-access behavior
Date: Tue, 15 Apr 2025 16:12:29 +0800
Message-Id: <20250415081231.21186-16-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62c.google.com
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

The wgChecker is configurable for whether blocked accesses:
* should cause a bus error or just read return zero and write ignore
* should generate the interrupt or not

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/riscv_wgchecker.c | 169 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 2 deletions(-)

diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
index 8839d898c9..5d2af7946f 100644
--- a/hw/misc/riscv_wgchecker.c
+++ b/hw/misc/riscv_wgchecker.c
@@ -100,6 +100,169 @@ REG32(SLOT_CFG,             0x010)
 #define P_READ                  (1 << 0)
 #define P_WRITE                 (1 << 1)
 
+static void decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
+{
+    /*
+     * aaaa...aaa0   8-byte NAPOT range
+     * aaaa...aa01   16-byte NAPOT range
+     * aaaa...a011   32-byte NAPOT range
+     * ...
+     * aa01...1111   2^XLEN-byte NAPOT range
+     * a011...1111   2^(XLEN+1)-byte NAPOT range
+     * 0111...1111   2^(XLEN+2)-byte NAPOT range
+     * 1111...1111   Reserved
+     */
+
+    a = FROM_SLOT_ADDR(a) | 0x3;
+
+    if (sa) {
+        *sa = a & (a + 1);
+    }
+    if (ea) {
+        *ea = a | (a + 1);
+    }
+}
+
+typedef struct WgAccessResult WgAccessResult;
+struct WgAccessResult {
+    bool is_success;
+    bool has_bus_error;
+    bool has_interrupt;
+    uint8_t perm:2;
+};
+
+static WgAccessResult wgc_check_access(
+    RISCVWgCheckerState *s, hwaddr phys_addr, uint32_t wid, bool is_write)
+{
+    WgCheckerSlot *slot, *prev_slot;
+    uint32_t cfg_a, prev_cfg_a;
+    uint64_t start, end;
+    int slot_id, wgc_perm = 0;
+    WgAccessResult result = { 0 };
+
+    bool is_matching = false;
+    bool slot0_be, slot0_ip;
+    bool matched_slot_be = false, matched_slot_ip = false;
+
+    for (slot_id = 0; slot_id < s->slot_count; slot_id++) {
+        slot = &s->slots[slot_id + 1];
+        cfg_a = FIELD_EX32(slot->cfg, SLOT_CFG, A);
+
+        if (cfg_a == A_TOR) {
+            prev_slot = &s->slots[slot_id];
+
+            prev_cfg_a = FIELD_EX32(prev_slot->cfg, SLOT_CFG, A);
+            if (prev_cfg_a == A_NA4) {
+                start = FROM_SLOT_ADDR(prev_slot->addr) + 4;
+            } else if (prev_cfg_a == A_NAPOT) {
+                decode_napot(prev_slot->addr, NULL, &start);
+                start += 1;
+            } else { /* A_TOR or A_OFF */
+                start = FROM_SLOT_ADDR(prev_slot->addr);
+            }
+            end = FROM_SLOT_ADDR(slot->addr);
+        } else if (cfg_a == A_NA4) {
+            start = FROM_SLOT_ADDR(slot->addr);
+            end = start + 4;
+        } else if (cfg_a == A_NAPOT) {
+            decode_napot(slot->addr, &start, &end);
+            end += 1;
+        } else {
+            /* A_OFF: not in slot range. */
+            continue;
+        }
+
+        /* wgChecker slot range is between start to (end - 1). */
+        if ((start <= phys_addr) && (phys_addr < end)) {
+            /* Match the wgC slot */
+            int perm = ((slot->perm >> (wid * 2)) & 0x3);
+
+            /* If any matching rule permits access, the access is permitted. */
+            wgc_perm |= perm;
+
+            /*
+             * If any matching rule wants to report error (IRQ or Bus Error),
+             * the denied access should report error.
+             */
+            is_matching = true;
+            if (is_write) {
+                matched_slot_be |= FIELD_EX64(slot->cfg, SLOT_CFG, EW);
+                matched_slot_ip |= FIELD_EX64(slot->cfg, SLOT_CFG, IW);
+            } else {
+                matched_slot_be |= FIELD_EX64(slot->cfg, SLOT_CFG, ER);
+                matched_slot_ip |= FIELD_EX64(slot->cfg, SLOT_CFG, IR);
+            }
+        }
+    }
+
+    /* If no matching rule, error reporting depends on the slot0's config. */
+    if (is_write) {
+        slot0_be = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, EW);
+        slot0_ip = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, IW);
+    } else {
+        slot0_be = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, ER);
+        slot0_ip = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, IR);
+    }
+
+    result.is_success = is_write ? (wgc_perm & P_WRITE) : (wgc_perm & P_READ);
+    result.perm = wgc_perm;
+    if (!result.is_success) {
+        if (is_matching) {
+            result.has_bus_error = matched_slot_be;
+            result.has_interrupt = matched_slot_ip;
+        } else {
+            result.has_bus_error = slot0_be;
+            result.has_interrupt = slot0_ip;
+        }
+    }
+
+    return result;
+}
+
+static MemTxResult riscv_wgc_handle_blocked_access(
+    WgCheckerRegion *region, hwaddr addr, uint32_t wid, bool is_write)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
+    bool be, ip;
+    WgAccessResult result;
+    hwaddr phys_addr;
+
+    be = FIELD_EX64(s->errcause, ERRCAUSE, BE);
+    ip = FIELD_EX64(s->errcause, ERRCAUSE, IP);
+    phys_addr = addr + region->region_offset;
+
+    /*
+     * Check if this blocked access trigger IRQ (Bus Error) or not.
+     * It depends on wgChecker slot config (cfg.IR/IW/ER/EW bits).
+     */
+    result = wgc_check_access(s, phys_addr, wid, is_write);
+
+    if (!be && !ip) {
+        /*
+         * With either of the be or ip bits is set, further violations do not
+         * update the errcause or erraddr registers. Also, new interrupts
+         * cannot be generated until the be and ip fields are cleared.
+         */
+        if (result.has_interrupt || result.has_bus_error) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, WID, wid);
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, R, !is_write);
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, W, is_write);
+            s->erraddr = TO_SLOT_ADDR(phys_addr);
+        }
+
+        if (result.has_interrupt) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, IP, 1);
+            qemu_irq_raise(s->irq);
+        }
+
+        if (result.has_bus_error) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, BE, 1);
+        }
+    }
+
+    return result.has_bus_error ? MEMTX_ERROR : MEMTX_OK;
+}
+
 /*
  * Accesses only reach these read and write functions if the wgChecker
  * is blocking them; non-blocked accesses go directly to the downstream
@@ -109,23 +272,25 @@ static MemTxResult riscv_wgc_mem_blocked_read(void *opaque, hwaddr addr,
                                                uint64_t *pdata,
                                                unsigned size, MemTxAttrs attrs)
 {
+    WgCheckerRegion *region = opaque;
     uint32_t wid = mem_attrs_to_wid(attrs);
 
     trace_riscv_wgc_mem_blocked_read(addr, size, wid);
 
     *pdata = 0;
-    return MEMTX_OK;
+    return riscv_wgc_handle_blocked_access(region, addr, wid, false);
 }
 
 static MemTxResult riscv_wgc_mem_blocked_write(void *opaque, hwaddr addr,
                                                uint64_t value,
                                                unsigned size, MemTxAttrs attrs)
 {
+    WgCheckerRegion *region = opaque;
     uint32_t wid = mem_attrs_to_wid(attrs);
 
     trace_riscv_wgc_mem_blocked_write(addr, value, size, wid);
 
-    return MEMTX_OK;
+    return riscv_wgc_handle_blocked_access(region, addr, wid, true);
 }
 
 static const MemoryRegionOps riscv_wgc_mem_blocked_ops = {
-- 
2.17.1



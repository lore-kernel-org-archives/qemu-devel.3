Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15470C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Mt6-0000BU-U3; Thu, 17 Apr 2025 06:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mt5-00009U-Ac
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mt2-0003f8-3B
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:54:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso463082b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887265; x=1745492065; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PalTCHeL3ElxHt3CezuVo/2+iw/lympwyWxiua7uelw=;
 b=Q/2UjNj5KfJzrJHG0tOuvwGS/g8AZFg1a67CiDqvbeTeWy6h7p464+h4n5Mh/CsL5y
 v92f9Gv7d8wNnfz43H1E4IcTiDbQGALKS3Wu9RJQ+SGOpcX1nkGh+czskOnKCagpfwSB
 eJXGYFooE+MPnZhV1wWHVA2KDGKx5LaUsSqJgBoA9CzBphEeshtN6gT2bBPLsBaYubaw
 vciIke4s6FypxGiazd7l5cTBayxDyg09XwBNymbwMUoRGIAKVWwgtnWEEoVW9Mi8logi
 DwdjIdNgsA+5X9E2hVwJsp91ej6BZRjTVlDQZ/niE1z6Ic0lcMSLXZGkqkeEMBGaC5LE
 IXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887265; x=1745492065;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PalTCHeL3ElxHt3CezuVo/2+iw/lympwyWxiua7uelw=;
 b=TrHfo6g1PUNqaF/5VSEleNhdzm0j/NLkEAI2afMypq6c2CcAOSPIn4DhtFMJ0HFjiW
 V+4+E5GhF7tjg7EBdTnTRjVWTMZkclybRgkr9QYeJsE1ntx8LAbAPmqzKuY56v3A/SfP
 5cypvDumMw1ADSs5N84NJLLs54IMFgg7HgvRr69wCw7CWVzHGj2rxlY9+EGPn/XH1cUG
 u6b98xalLfTzumVtIIwmF0lc3uHiDkdO4OhIXTxwAFlY/gCvvV1nSfsN0kFPE0li+AeK
 uZcu0XSOHS4PJpd+40kaxMXTf3lcs5jiUsep9X8rUkcJ44wrAUJJRFnyrt6DwokvjZ1V
 4txA==
X-Gm-Message-State: AOJu0YyJ7sl5JZBmB+z+KOwm3Pm97TRfy8Y0JENqt8Hs5+bn8tpoBG1q
 YnnT7XwkyPIMfgPigDM+9ZVQAyO8lDyB8R9bhOWzSp7fx6LmpY31088lqpn/FtPteYmx3wMenv9
 qYMZrRVmWxTmXkZ4oQ78zmhTEcsZgX4l96owiDkG9JkVOPsXlghtjnfrspbT5N4ny79Xsv5fULR
 62lFxhha1L0OMQ1zHjyldtzoJF8SH48tqi5Q==
X-Gm-Gg: ASbGncvrCoSQHLUhAUA5c6G4u8aHGGW+Cp9RAIEQaSKn+DjgpPi0Rb65ceQZ4Orm5YJ
 F/nTvrsL3hG/CCm1hY8SP1svJ2sQadZAehe+qPHp9NrC5j8vb3mHvFVfrEe9mOPt6dqEB5DYcUo
 PrCDY99QJUJBs/qItysn1N/da5gTW4F3rQ0NzEexJlmZkuBFBRpOVOfUZdA6OXKS8rWUR3SjNWp
 5Yt7UVhjwe4roVw7O1vzFqANHmhlmrBizg+4vDcES9eIgxWzLHZPMmb4ZN/LMNag6b7Nu8PCkSb
 G8jQm3CJCCuWmaHhVlRLxNVoDUkJiqWSeZD0DsTMFeNcWG9lc/FgXtT/yjOBbeY=
X-Google-Smtp-Source: AGHT+IFb9NFOkDuZrltKII+EmDLWNKkqGGj9dnre7XEf8OCLAjzcROnJy/+vMybnUVS5/ETTgkkJbg==
X-Received: by 2002:a05:6a00:1252:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-73c267fa0dbmr8516319b3a.24.1744887265068; 
 Thu, 17 Apr 2025 03:54:25 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:54:24 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 15/18] hw/misc: riscv_wgchecker: Implement wgchecker slot
 registers
Date: Thu, 17 Apr 2025 18:52:46 +0800
Message-Id: <20250417105249.18232-16-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42b.google.com
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

wgChecker slot is similar to PMP region. SW could program each slot to
configure the permission of address range.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/misc/riscv_wgchecker.c          | 330 +++++++++++++++++++++++++++++
 hw/misc/riscv_worldguard.c         |   3 +
 include/hw/misc/riscv_worldguard.h |   4 +
 3 files changed, 337 insertions(+)

diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
index ea50f4f53a..8839d898c9 100644
--- a/hw/misc/riscv_wgchecker.c
+++ b/hw/misc/riscv_wgchecker.c
@@ -53,6 +53,52 @@ REG64(ERRCAUSE,             0x010)
      R_ERRCAUSE_IP_MASK)
 
 REG64(ERRADDR,              0x018)
+REG64(WGC_SLOT,             0x020)
+
+/* wgChecker slots */
+REG64(SLOT_ADDR,            0x000)
+REG64(SLOT_PERM,            0x008)
+REG32(SLOT_CFG,             0x010)
+    FIELD(SLOT_CFG, A,          0,  2)
+    FIELD(SLOT_CFG, ER,         8,  1)
+    FIELD(SLOT_CFG, EW,         9,  1)
+    FIELD(SLOT_CFG, IR,         10, 1)
+    FIELD(SLOT_CFG, IW,         11, 1)
+    FIELD(SLOT_CFG, LOCK,       31, 1)
+
+#define SLOT_SIZE               0x020
+
+#define SLOT0_CFG_MASK \
+    (R_SLOT_CFG_ER_MASK | \
+     R_SLOT_CFG_EW_MASK | \
+     R_SLOT_CFG_IR_MASK | \
+     R_SLOT_CFG_IW_MASK | \
+     R_SLOT_CFG_LOCK_MASK)
+
+#define SLOT_CFG_MASK \
+    (R_SLOT_CFG_A_MASK  | (SLOT0_CFG_MASK))
+
+#define WGC_SLOT_END(nslots) \
+    (A_WGC_SLOT + SLOT_SIZE * (nslots + 1))
+
+/* wgChecker slot is 4K alignment */
+#define WG_ALIGNED_SIZE         (1 << 12)
+#define WG_ALIGNED_MASK         MAKE_64BIT_MASK(0, 12)
+
+/* wgChecker slot address is (addr / 4). */
+#define TO_SLOT_ADDR(addr)      ((addr) >> 2)
+#define FROM_SLOT_ADDR(addr)    ((addr) << 2)
+
+/* wgChecker slot cfg.A[1:0] */
+#define A_OFF                   0
+#define A_TOR                   1
+#define A_NA4                   2
+#define A_NAPOT                 3
+
+/* wgChecker slot perm */
+#define WGC_PERM(wid, perm)     ((uint64_t)(perm) << (2 * (wid)))
+#define P_READ                  (1 << 0)
+#define P_WRITE                 (1 << 1)
 
 /*
  * Accesses only reach these read and write functions if the wgChecker
@@ -146,6 +192,28 @@ static uint64_t riscv_wgchecker_readq(void *opaque, hwaddr addr)
     RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
     uint64_t val = 0;
 
+    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
+        /* Read from WGC slot */
+        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
+        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
+
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+            val = s->slots[slot_id].addr;
+            break;
+        case A_SLOT_PERM:
+            val = s->slots[slot_id].perm;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 8);
+            break;
+        }
+
+        return val;
+    }
+
     switch (addr) {
     case A_ERRCAUSE:
         val = s->errcause & ERRCAUSE_MASK;
@@ -171,6 +239,37 @@ static uint64_t riscv_wgchecker_readl(void *opaque, hwaddr addr)
     RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
     uint64_t val = 0;
 
+    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
+        /* Read from WGC slot */
+        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
+        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
+
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+            val = extract64(s->slots[slot_id].addr, 0, 32);
+            break;
+        case A_SLOT_ADDR + 4:
+            val = extract64(s->slots[slot_id].addr, 32, 32);
+            break;
+        case A_SLOT_PERM:
+            val = extract64(s->slots[slot_id].perm, 0, 32);
+            break;
+        case A_SLOT_PERM + 4:
+            val = extract64(s->slots[slot_id].perm, 32, 32);
+            break;
+        case A_SLOT_CFG:
+            val = s->slots[slot_id].cfg & SLOT_CFG_MASK;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 4);
+            break;
+        }
+
+        return val;
+    }
+
     switch (addr) {
     case A_VENDOR:
         val = 0;
@@ -228,11 +327,121 @@ static uint64_t riscv_wgchecker_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
+/*
+ * Validate the WGC slot address is between address range.
+ *
+ * Fix the slot address to the start address if it's not within the address range.
+ * We need validation when changing "slot address" or "TOR/NAPOT mode (cfg.A)"
+ */
+static void validate_slot_address(void *opaque, int slot_id)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
+    uint64_t start = TO_SLOT_ADDR(s->addr_range_start);
+    uint64_t end = TO_SLOT_ADDR(s->addr_range_start + s->addr_range_size);
+    uint32_t cfg_a = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, A);
+
+    /* First and last slot address are hard-coded. */
+    if ((slot_id == 0) || (slot_id == s->slot_count)) {
+        return;
+    }
+
+    /* Check WGC slot address is between address range. */
+    if ((s->slots[slot_id].addr < start) || (s->slots[slot_id].addr >= end)) {
+        s->slots[slot_id].addr = start;
+    }
+
+    /* Check WGC slot is 4k-aligned. */
+    if (cfg_a == A_TOR) {
+        s->slots[slot_id].addr &= ~TO_SLOT_ADDR(WG_ALIGNED_MASK);
+    } else if (cfg_a == A_NAPOT) {
+        s->slots[slot_id].addr |= TO_SLOT_ADDR(WG_ALIGNED_MASK >> 1);
+    } else if (cfg_a == A_NA4) {
+        /* Forcely replace NA4 slot with 4K-aligned NAPOT slot. */
+        FIELD_DP32(s->slots[slot_id].cfg, SLOT_CFG, A, A_NAPOT);
+        s->slots[slot_id].addr |= TO_SLOT_ADDR(WG_ALIGNED_MASK >> 1);
+    }
+}
+
+static bool slots_reg_is_ro(int slot_id, int slot_offset, uint32_t nslots)
+{
+    /*
+     * Special slots:
+     *   - slot[0]:
+     *     - addr is RO
+     *     - perm is RO
+     *     - cfg.A is OFF
+     *
+     *   - slot[nslots]:
+     *     - addr is RO
+     *     - cfg.A is OFF or TOR
+     */
+    if (slot_id == 0) {
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+        case A_SLOT_ADDR + 4:
+        case A_SLOT_PERM:
+        case A_SLOT_PERM + 4:
+            return true;
+        default:
+            break;
+        }
+    } else if (slot_id == nslots) {
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+        case A_SLOT_ADDR + 4:
+            return true;
+        default:
+            break;
+        }
+    }
+
+    return false;
+}
+
 static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
                                     uint64_t value)
 {
     RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
 
+    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
+        /* Read from WGC slot */
+        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
+        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
+        bool locked = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, LOCK);
+
+        if (locked) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Couldn't write access to locked wgChecker Slot: "
+                          "slot = %d, offset = %d\n", __func__, slot_id,
+                          slot_offset);
+            return;
+        }
+
+        if (slots_reg_is_ro(slot_id, slot_offset, s->slot_count)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 8);
+        }
+
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+            s->slots[slot_id].addr = value;
+            validate_slot_address(s, slot_id);
+            break;
+        case A_SLOT_PERM:
+            value &= wgc_slot_perm_mask;
+            s->slots[slot_id].perm = value;
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 8);
+            break;
+        }
+
+        return;
+    }
+
     switch (addr) {
     case A_ERRCAUSE:
         s->errcause = value & ERRCAUSE_MASK;
@@ -253,6 +462,81 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
 {
     RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
 
+    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
+        /* Write to WGC slot */
+        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
+        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
+        bool locked = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, LOCK);
+        int cfg_a, old_cfg_a;
+
+        if (locked) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Couldn't write access to locked wgChecker Slot: "
+                          "slot = %d, offset = %d\n", __func__, slot_id,
+                          slot_offset);
+            return;
+        }
+
+        if (slots_reg_is_ro(slot_id, slot_offset, s->slot_count)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 4);
+        }
+
+        switch (slot_offset) {
+        case A_SLOT_ADDR:
+            s->slots[slot_id].addr = deposit64(
+                s->slots[slot_id].addr, 0, 32, value);
+            validate_slot_address(s, slot_id);
+            break;
+        case A_SLOT_ADDR + 4:
+            s->slots[slot_id].addr = deposit64(
+                s->slots[slot_id].addr, 32, 32, value);
+            validate_slot_address(s, slot_id);
+            break;
+        case A_SLOT_PERM:
+            value &= wgc_slot_perm_mask;
+            s->slots[slot_id].perm = deposit64(
+                s->slots[slot_id].perm, 0, 32, value);
+            break;
+        case A_SLOT_PERM + 4:
+            value &= extract64(wgc_slot_perm_mask, 32, 32);
+            s->slots[slot_id].perm = deposit64(
+                s->slots[slot_id].perm, 32, 32, value);
+            break;
+        case A_SLOT_CFG:
+            if (slot_id == 0) {
+                value &= SLOT0_CFG_MASK;
+                s->slots[0].cfg = value;
+            } else if (slot_id == s->slot_count) {
+                old_cfg_a = FIELD_EX32(s->slots[s->slot_count].cfg, SLOT_CFG, A);
+                cfg_a = FIELD_EX32(value, SLOT_CFG, A);
+
+                value &= SLOT0_CFG_MASK;
+                if ((cfg_a == A_OFF) || (cfg_a == A_TOR)) {
+                    value |= cfg_a;
+                } else {
+                    /* slot[nslots] could only use OFF or TOR config. */
+                    value |= old_cfg_a;
+                }
+                s->slots[s->slot_count].cfg = value;
+
+                validate_slot_address(s, slot_id);
+            } else {
+                value &= SLOT_CFG_MASK;
+                s->slots[slot_id].cfg = value;
+            }
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
+                          __func__, addr, 4);
+            break;
+        }
+
+        return;
+    }
+
     switch (addr) {
     case A_ERRCAUSE:
         value &= extract64(ERRCAUSE_MASK, 0, 32);
@@ -460,6 +744,8 @@ static void riscv_wgchecker_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->slots = g_new0(WgCheckerSlot, s->slot_count + 1);
+
     memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_wgchecker_ops, s,
                           TYPE_RISCV_WGCHECKER, s->mmio_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
@@ -523,6 +809,37 @@ static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
 
     s->errcause = 0;
     s->erraddr = 0;
+
+    for (int i = 0; i < nslots; i++) {
+        s->slots[i].addr = TO_SLOT_ADDR(start);
+        s->slots[i].perm = 0;
+        s->slots[i].cfg = 0;
+    }
+    s->slots[nslots].addr = TO_SLOT_ADDR(end);
+    s->slots[nslots].perm = 0;
+    s->slots[nslots].cfg = 0;
+
+    if (s->num_default_slots != 0) {
+        /*
+         * Use default slots:
+         *   slot[0] is hard-coded to start address, so the default slots
+         *   start from slot[1].
+         */
+        memcpy(&s->slots[1], s->default_slots,
+               sizeof(WgCheckerSlot) * s->num_default_slots);
+    } else if ((s->hw_bypass) ||
+               ((worldguard_config != NULL) && worldguard_config->hw_bypass)) {
+        /* HW bypass mode */
+        uint32_t trustedwid = worldguard_config->trustedwid;
+
+        if (trustedwid == NO_TRUSTEDWID) {
+            trustedwid = worldguard_config->nworlds - 1;
+        }
+
+        s->slots[nslots].perm = WGC_PERM(trustedwid, P_READ | P_WRITE);
+        s->slots[nslots].perm &= wgc_slot_perm_mask;
+        s->slots[nslots].cfg = A_TOR;
+    }
 }
 
 static void riscv_wgchecker_class_init(ObjectClass *klass, void *data)
@@ -596,6 +913,19 @@ DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
         qdev_prop_set_uint64(dev, name_offset, region_offset[i]);
     }
 
+    if (num_default_slots > slot_count) {
+        num_default_slots = slot_count;
+    }
+
+    s->num_default_slots = num_default_slots;
+    if (s->num_default_slots) {
+        s->default_slots = g_new0(WgCheckerSlot, s->num_default_slots);
+        memcpy(s->default_slots, default_slots,
+               sizeof(WgCheckerSlot) * s->num_default_slots);
+    } else {
+        s->default_slots = NULL;
+    }
+
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
index 1a910f4cf3..59ca6d16e7 100644
--- a/hw/misc/riscv_worldguard.c
+++ b/hw/misc/riscv_worldguard.c
@@ -38,6 +38,9 @@
  */
 struct RISCVWorldGuardState *worldguard_config = NULL;
 
+/* perm field bitmask of wgChecker slot, it's depends on NWorld. */
+uint64_t wgc_slot_perm_mask = 0;
+
 static Property riscv_worldguard_properties[] = {
     DEFINE_PROP_UINT32("nworlds", RISCVWorldGuardState, nworlds, 0),
 
diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
index 7b5aae866a..f53202524c 100644
--- a/include/hw/misc/riscv_worldguard.h
+++ b/include/hw/misc/riscv_worldguard.h
@@ -45,6 +45,7 @@ struct RISCVWorldGuardState {
 };
 
 extern struct RISCVWorldGuardState *worldguard_config;
+extern uint64_t wgc_slot_perm_mask;
 
 DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
                                      bool hw_bypass, bool tz_compat);
@@ -86,9 +87,12 @@ struct WgCheckerRegion {
 struct RISCVWgCheckerState {
     /*< private >*/
     SysBusDevice parent_obj;
+    uint32_t num_default_slots;
+    WgCheckerSlot *default_slots;
 
     /*< public >*/
     MemoryRegion mmio;
+    WgCheckerSlot *slots;
     qemu_irq irq;
 
     /* error reg */
-- 
2.17.1



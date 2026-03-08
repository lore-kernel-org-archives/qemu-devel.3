Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D5F55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Qu-0001HF-4s; Sun, 08 Mar 2026 03:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qr-00012i-JE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:09 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qo-0002P8-4w
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:09 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-126ea4b77adso13331210c88.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954404; x=1773559204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86xon8l74W9KjFelsko2w/gQm9AVLkIxkuNw3eT+zMk=;
 b=IjNvOlKR9qO+bj0EVboKbjHex28DaPSeGhCjPaDZLeJKZfRSa+sv5YTIL8FJpY8D/K
 yRLXidmJLGmVkBZ3RouX9oYf81L51En4RJw8R1h0N1PbV8dohXFE6hVBid4TBg5JMHMx
 S4+9DQlOjbrwo/l7WWMGDH5/rCgRltr/sFfJxl4wUkwOT5QWowSAFdJBVjD2uQyFVD/1
 2LawIs+Fs24iHmbKGloy+ALhcwmtPuhF/XJqYD7yOCXC91qmnWu31OCja+SxKX6gpuKz
 b6oxmF81gHStsr7eon42/TM4R9qCPtdOXTLLVKnq/QIi2rJCowMk1A/eH3h+KPDjhzY1
 FhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954404; x=1773559204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=86xon8l74W9KjFelsko2w/gQm9AVLkIxkuNw3eT+zMk=;
 b=B6J0vZ9BWOg2RTUzzuGH+1VUYCoiZbYS5l0AoESxELxyie53zx7bF87+7gcQRJ0zAp
 YQiqd4KMke52FHVy6C+s1Pm/0fORbj/9Gc90T+/Mnmf1E96wNcAYnmV+uo9DBAHodeyR
 iK0MbBjbUy/EHppl3i19U2QRjgQmVzqpu7HTsHnjsA4KQseXeB0tEZhvVVoIPNcVWY/s
 R1zDRnj8khwT0uqItxOkfyLmvyrSQfFYi8/9aAer7ouDasdylck2l/j1J4Q+e90PoVuz
 Q/viBDYzpVlfZV78GetCIwUCTOzADCAT0apiYjG+tFzs7bh5R5pfAZ2YsqiCp/Gef2rR
 Km1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyeIucVxTc6qUweVzuoqsxflBMVdAYPW2W99gq7pzUPSooVW36xV0wMsNAS9zg1WV8AYE5BB85wXi+@nongnu.org
X-Gm-Message-State: AOJu0YyixhCCduCwiRG0Dk/XMbw+TliV3xJk9hEerzT9cC+/b26Idl9l
 OKup47GRny54AS8pAFd546e7XoCpUSjrSv0kBQd330DIMjvZUES7p5N0
X-Gm-Gg: ATEYQzwqfoCc0yTPDKyeeQLolFqgqR8vbekgz1tNtIU1ccl7d0r0p9sdMzUIEDEYzAd
 f4nvShHWpnr9FVtIIxPQfl2xnTbccWHMr6hWsuPe8kiGR3ngVq456zXgWOWKIynYyWGt6V0lDLP
 vGk1WRTfPxwcyQdihOvMm89ENhAAn6cQn4aTTL1RhDe77uCI/E2MYd1rMlbl6SO4W36ZSJqmCUm
 f2cV1OS17xw3+0/XYZQRJbRVhyeGFNEZKb7/BP/KGw4/vl8hwRfgDwCGpWI6vScAhh9IGqfdI9U
 yV+fiFvnSUtFyYkw1A32Ilio97JOpMz4sTeqz55UFzejHEpaTXkMZqiKHqFEZ43/V6hvaGMe5dd
 fmJGHbYc4XYCScsTItCWaeQN5KUias43k7WITRiYP8J/goZsppIjVch9Iemi9vxaDqbxwMGmpSn
 D3gjaqMp/+JvPDXgMR7nt8dyj/qOHlizoLn+YlewbxxFqkXe/MnAVULUuRRvrTU4+qyA5ZidVDi
 nLPT632xYFLuYs92l7usovwAx8=
X-Received: by 2002:a05:7022:68a1:b0:123:34e8:ae9f with SMTP id
 a92af1059eb24-128c2da5453mr2889935c88.9.1772954404383; 
 Sat, 07 Mar 2026 23:20:04 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:03 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 16/28] hw/riscv/dm: track per-hart debug state
Date: Sun,  8 Mar 2026 15:17:19 +0800
Message-ID: <c175c14e6884da5c694a7cad96fe42c50ecd29f1.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add per-hart arrays for tracking halt, resume-acknowledge,
have-reset and reset-halt-request state. The initial DM reset
handler clears all arrays consistently using a for loop.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 183 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index 9ac5f2cfac..fad8e2b2ce 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -16,32 +16,148 @@
 
 REG32(DMCONTROL, 0x40)
     FIELD(DMCONTROL, DMACTIVE, 0, 1)
+    FIELD(DMCONTROL, HARTSELLO, 6, 10)
+    FIELD(DMCONTROL, HARTSELHI, 16, 10)
+    FIELD(DMCONTROL, HASEL, 26, 1)
 
 REG32(DMSTATUS, 0x44)
     FIELD(DMSTATUS, VERSION, 0, 4)
+    FIELD(DMSTATUS, HASRESETHALTREQ, 5, 1)
     FIELD(DMSTATUS, AUTHENTICATED, 7, 1)
+    FIELD(DMSTATUS, ANYHALTED, 8, 1)
+    FIELD(DMSTATUS, ALLHALTED, 9, 1)
+    FIELD(DMSTATUS, ANYRUNNING, 10, 1)
+    FIELD(DMSTATUS, ALLRUNNING, 11, 1)
+    FIELD(DMSTATUS, ANYNONEXISTENT, 14, 1)
+    FIELD(DMSTATUS, ALLNONEXISTENT, 15, 1)
+    FIELD(DMSTATUS, ANYRESUMEACK, 16, 1)
+    FIELD(DMSTATUS, ALLRESUMEACK, 17, 1)
+    FIELD(DMSTATUS, ANYHAVERESET, 18, 1)
+    FIELD(DMSTATUS, ALLHAVERESET, 19, 1)
+    FIELD(DMSTATUS, IMPEBREAK, 22, 1)
 
 REG32(HARTINFO, 0x48)
+    FIELD(HARTINFO, DATAADDR, 0, 12)
+    FIELD(HARTINFO, DATASIZE, 12, 4)
+    FIELD(HARTINFO, DATAACCESS, 16, 1)
+    FIELD(HARTINFO, NSCRATCH, 20, 4)
 
 REG32(ABSTRACTCS, 0x58)
     FIELD(ABSTRACTCS, DATACOUNT, 0, 4)
+    FIELD(ABSTRACTCS, CMDERR, 8, 3)
+    FIELD(ABSTRACTCS, BUSY, 12, 1)
     FIELD(ABSTRACTCS, PROGBUFSIZE, 24, 5)
 
+static inline uint32_t dm_get_hartsel(RISCVDMState *s)
+{
+    uint32_t hi = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI);
+    uint32_t lo = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELLO);
+
+    return (hi << 10) | lo;
+}
+
+static inline bool dm_hart_valid(RISCVDMState *s, uint32_t hartsel)
+{
+    return hartsel < s->num_harts;
+}
+
+static void dm_status_refresh(RISCVDMState *s)
+{
+    uint32_t hartsel = dm_get_hartsel(s);
+    bool valid = dm_hart_valid(s, hartsel);
+    bool halted = valid && s->hart_halted[hartsel];
+    bool running = valid && !s->hart_halted[hartsel];
+    bool resumeack = valid && s->hart_resumeack[hartsel];
+    bool havereset = valid && s->hart_havereset[hartsel];
+
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYNONEXISTENT, !valid);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLNONEXISTENT, !valid);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHALTED, halted);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHALTED, halted);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRUNNING, running);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRUNNING, running);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRESUMEACK, resumeack);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRESUMEACK, resumeack);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHAVERESET, havereset);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHAVERESET, havereset);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, HASRESETHALTREQ, 1);
+}
+
+static void dm_debug_reset(RISCVDMState *s);
+
+static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t val = val64;
+
+    if (!FIELD_EX32(val, DMCONTROL, DMACTIVE)) {
+        dm_debug_reset(s);
+        return 0;
+    }
+
+    s->dm_active = true;
+
+    val = FIELD_DP32(val, DMCONTROL, DMACTIVE, 1);
+    s->regs[R_DMCONTROL] = val;
+    dm_status_refresh(s);
+    return val;
+}
+
+static uint64_t dm_dmstatus_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    dm_status_refresh(s);
+    return val;
+}
+
+static uint64_t dm_hartinfo_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t v = val;
+
+    v = FIELD_DP32(v, HARTINFO, DATAADDR, RISCV_DM_ROM_DATA);
+    v = FIELD_DP32(v, HARTINFO, DATASIZE, s->num_abstract_data);
+    v = FIELD_DP32(v, HARTINFO, DATAACCESS, 1);
+    v = FIELD_DP32(v, HARTINFO, NSCRATCH, s->nscratch);
+    return v;
+}
+
 static RegisterAccessInfo riscv_dm_regs_info[] = {
-    { .name = "DMCONTROL", .addr = A_DMCONTROL, },
-    { .name = "DMSTATUS", .addr = A_DMSTATUS, .ro = 0xffffffff, },
-    { .name = "HARTINFO", .addr = A_HARTINFO, .ro = 0xffffffff, },
-    { .name = "ABSTRACTCS", .addr = A_ABSTRACTCS, .ro = 0xffffffff, },
+    { .name = "DMCONTROL", .addr = A_DMCONTROL,
+      .pre_write = dm_dmcontrol_pre_write, },
+    { .name = "DMSTATUS", .addr = A_DMSTATUS,
+      .ro = 0xffffffff,
+      .post_read = dm_dmstatus_post_read, },
+    { .name = "HARTINFO", .addr = A_HARTINFO,
+      .ro = 0xffffffff,
+      .post_read = dm_hartinfo_post_read, },
+    { .name = "ABSTRACTCS", .addr = A_ABSTRACTCS,
+      .ro = 0xffffffff, },
 };
 
 static uint64_t riscv_dm_read(void *opaque, hwaddr addr, unsigned size)
 {
+    RegisterInfoArray *reg_array = opaque;
+    RISCVDMState *s = RISCV_DM(reg_array->r[0]->opaque);
+
+    if (!s->dm_active && addr != A_DMCONTROL) {
+        return 0;
+    }
+
     return register_read_memory(opaque, addr, size);
 }
 
 static void riscv_dm_write(void *opaque, hwaddr addr,
                            uint64_t value, unsigned size)
 {
+    RegisterInfoArray *reg_array = opaque;
+    RISCVDMState *s = RISCV_DM(reg_array->r[0]->opaque);
+
+    if (!s->dm_active && addr != A_DMCONTROL) {
+        return;
+    }
+
     register_write_memory(opaque, addr, value, size);
 }
 
@@ -75,6 +191,20 @@ static void dm_rom_write(void *opaque, hwaddr offset,
     RISCVDMState *s = opaque;
 
     stn_le_p(s->rom_ptr + offset, size, value);
+
+    if (offset == RISCV_DM_ROM_HARTID && size == 4) {
+        riscv_dm_hart_halted(s, value);
+        return;
+    }
+
+    if (offset == RISCV_DM_ROM_RESUME && size == 4) {
+        riscv_dm_hart_resumed(s, value);
+        return;
+    }
+
+    if (offset == RISCV_DM_ROM_EXCP && size == 4) {
+        riscv_dm_abstracts_exception(s, dm_get_hartsel(s));
+    }
 }
 
 static const MemoryRegionOps dm_rom_ops = {
@@ -113,26 +243,38 @@ static bool dm_rom_realize(RISCVDMState *s, Error **errp)
 
 void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)s;
-    (void)hartsel;
+    if (!dm_hart_valid(s, hartsel)) {
+        return;
+    }
+
+    s->hart_halted[hartsel] = true;
+    riscv_dm_abstracts_done(s, hartsel);
+    dm_status_refresh(s);
 }
 
 void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)s;
-    (void)hartsel;
+    if (!dm_hart_valid(s, hartsel)) {
+        return;
+    }
+
+    s->hart_halted[hartsel] = false;
+    s->hart_resumeack[hartsel] = true;
+    dm_status_refresh(s);
 }
 
 void riscv_dm_abstracts_done(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)s;
     (void)hartsel;
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 0);
 }
 
 void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)s;
     (void)hartsel;
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 0);
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR,
+                     RISCV_DM_CMDERR_EXCEPTION);
 }
 
 static void dm_debug_reset(RISCVDMState *s)
@@ -140,12 +282,23 @@ static void dm_debug_reset(RISCVDMState *s)
     memset(s->regs, 0, sizeof(s->regs));
     ARRAY_FIELD_DP32(s->regs, DMSTATUS, VERSION, 3);
     ARRAY_FIELD_DP32(s->regs, DMSTATUS, AUTHENTICATED, 1);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, IMPEBREAK, s->impebreak);
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, DATACOUNT, s->num_abstract_data);
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, PROGBUFSIZE, s->progbuf_size);
 
+    if (s->hart_halted) {
+        memset(s->hart_halted, 0, s->num_harts * sizeof(bool));
+        memset(s->hart_resumeack, 0, s->num_harts * sizeof(bool));
+        memset(s->hart_havereset, 1, s->num_harts * sizeof(bool));
+    }
+
+    s->dm_active = false;
+
     if (s->rom_ptr) {
         memset(s->rom_ptr, 0, RISCV_DM_SIZE);
     }
+
+    dm_status_refresh(s);
 }
 
 static void riscv_dm_init(Object *obj)
@@ -171,6 +324,10 @@ static void riscv_dm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->hart_halted = g_new0(bool, s->num_harts);
+    s->hart_resumeack = g_new0(bool, s->num_harts);
+    s->hart_havereset = g_new0(bool, s->num_harts);
+
     if (!dm_rom_realize(s, errp)) {
         return;
     }
@@ -184,6 +341,15 @@ static void riscv_dm_reset_hold(Object *obj, ResetType type)
     dm_debug_reset(RISCV_DM(obj));
 }
 
+static void riscv_dm_unrealize(DeviceState *dev)
+{
+    RISCVDMState *s = RISCV_DM(dev);
+
+    g_free(s->hart_halted);
+    g_free(s->hart_resumeack);
+    g_free(s->hart_havereset);
+}
+
 static const Property riscv_dm_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVDMState, num_harts, 1),
     DEFINE_PROP_UINT32("datacount", RISCVDMState, num_abstract_data, 2),
@@ -200,6 +366,12 @@ static const VMStateDescription vmstate_riscv_dm = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, RISCVDMState, RISCV_DM_R_MAX),
         VMSTATE_BOOL(dm_active, RISCVDMState),
+        VMSTATE_VARRAY_UINT32(hart_halted, RISCVDMState, num_harts,
+                              0, vmstate_info_bool, bool),
+        VMSTATE_VARRAY_UINT32(hart_resumeack, RISCVDMState, num_harts,
+                              0, vmstate_info_bool, bool),
+        VMSTATE_VARRAY_UINT32(hart_havereset, RISCVDMState, num_harts,
+                              0, vmstate_info_bool, bool),
         VMSTATE_END_OF_LIST(),
     }
 };
@@ -210,6 +382,7 @@ static void riscv_dm_class_init(ObjectClass *klass, const void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = riscv_dm_realize;
+    dc->unrealize = riscv_dm_unrealize;
     dc->vmsd = &vmstate_riscv_dm;
     device_class_set_props(dc, riscv_dm_props);
     rc->phases.hold = riscv_dm_reset_hold;
-- 
2.53.0



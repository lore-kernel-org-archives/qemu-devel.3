Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2C7F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8SH-0003IL-Mv; Sun, 08 Mar 2026 03:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RS-0002BN-Of
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:49 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RQ-0002y0-N0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:46 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2be4781d2baso4108246eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954443; x=1773559243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kto/w2AEorrBM5dZgT70XuVChojeFObxlu6B65tX8r8=;
 b=LpKI2gej/9StYGbq++OIGLAxumf0k5YmqznI5zdoBWcl7GIJWHNzNg0zgbKRDQWNyC
 lgrhypS0aRKzuJmMQEkz6urPknOP5FjSyTiFTpbJyVAJWLEzlHSTMXVjgkYnaypWKZWq
 7GhLgSy+kmDH32vO0Q2M7hjmx+bA8Da0+z6XxLaoQwe+vmsUeJ+s3WufTLqJrjC4hx5q
 Eqq4+NohirxjWfMtRcro0eBhcdtM/bn/RHX4rqJX2Ok8WOBDxS+F4npsC8thOvao9N35
 7efrf3uSv6zRMZKBmnwa+Vnam8jv0dde2Cdf0nwn3cgeQ+0DtTe+EjETprH2EIPE8d2I
 htBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954443; x=1773559243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kto/w2AEorrBM5dZgT70XuVChojeFObxlu6B65tX8r8=;
 b=v6/Qm2NK2zcRPd6RQppkRyyyTIaTadO6AaitJtXZTPPSIONbzLEn7cQIti2m82kpFZ
 MmFp1BkusdCcAXCZr96fHjv/7/53RquYmD0ZgrLHhFX1Y46CdwyW4EgiXukVLy20NO7h
 ZnX8a68rSuOxalDo2IaV+e9nCPjtoOeuslPiKpU/tc8/oJTXbYMOdOTwZJwuNOfAdC72
 NjqbyKV6CgPuOl5qEOpFRnw6/547KuPdP6e8fkS3WvjI6/wmXXYgxgANGj16L7Ey2n9I
 OiBcR2whIHvJMrdf0w4UKHmfONkuC9q46nR9NjLBdM4COPF/29xHLfjxl5TDdoCUH4YC
 KpDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwbpdYlEOjD14YQXvWBJ9DIpDG937JP7vdWZ9Lcvc/xNaIExe+G2daQSDKQ7VMs/hXDhg76Q0s85LM@nongnu.org
X-Gm-Message-State: AOJu0YwXSGqe8l64+fL0pYcaITuY2cVWnp6Ug4xZZEK+YGHGVwII30wJ
 yDVy0awVf4YnqOTaUWK6T54DR++L2a30Q/h7V2Y29kwCTVfqzrKD0Dwv
X-Gm-Gg: ATEYQzxDHvhnP2FvYn4JxjxKlyYKVhlef8OSa/ojfsu2GlA+y+TWPmt+GhW4pWvILkZ
 lTK75vVvd/Tm4IoK8arQiba4hk1OBsqyG7U1ASqwh4LSKu1PADXoyPblcFNO7xHCGTmh7+xd34M
 CXcwjMe8lHieVtEQoamzY0MQrjBCT73+2YzUZcSjvk7H4sif6C1QjdXXBSKBHpBDqxurdYx9kPN
 ezDHFlgCl6YVIBCTC8kVZ5NMM5Nk3upsRs8wrIos4sNAHGdWvZ7Y8E0a4NaG9sBbpYdlzPiTZP+
 yHWCEGDGwwcjdd0Ky0PIN6nmrxlfPo4S9pm8X1+TH3V2vRf83Vi6rMaPgam7yWw2zmduFUIg8D4
 yRH92DEMpm+cqdBE6P/ehWDxA9jJymp9sqQlRUUDs7BFU+R2EHvEuG1tz+93KBjBIZgUh1n84iQ
 1O7w8JwNBjhtCjqEQa3S5SyzxuK86whKURd2EBQ7D3pMj/Kidvn7SlG42ICvK+cfsU8tVHUvJYO
 0fPwx/mYDXsDLtnXjr4TOglPlI=
X-Received: by 2002:a05:7300:2393:b0:2b8:66f3:2502 with SMTP id
 5a478bee46e88-2be4deb8aaamr3515941eec.1.1772954443092; 
 Sat, 07 Mar 2026 23:20:43 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:41 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 22/28] hw/riscv/dm: add system bus access
Date: Sun,  8 Mar 2026 15:17:25 +0800
Message-ID: <37a88487caad84ae50b47cc190820ebfac5ecb3e.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implement the optional System Bus Access (SBA) register set
that allows the debugger to read and write system memory
without involving a hart.

This adds SBCS, SBADDRESS0-3, and SBDATA0-3 register handlers
with sticky error reporting, sbreadonaddr, sbreadondata, and
sbautoincrement support. The SBA path supports 8/16/32/64-bit
access widths and sets the SBA capability bits during DM reset
based on the configured sba-addr-width property.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 249 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 242 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index 818e48629f..bcaaffd02b 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -19,6 +19,7 @@
 #include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "exec/translation-block.h"
+#include "system/address-spaces.h"
 #include "system/tcg.h"
 #include "target/riscv/cpu.h"
 #include "trace.h"
@@ -736,6 +737,95 @@ static bool dm_execute_abstract_cmd(RISCVDMState *s, uint32_t command)
 }
 
 
+static int dm_sba_access_bytes(uint32_t sbaccess)
+{
+    if (sbaccess <= 4) {
+        return 1 << sbaccess;
+    }
+    return 0;
+}
+
+static bool dm_sba_access_supported(RISCVDMState *s, uint32_t sbaccess)
+{
+    switch (sbaccess) {
+    case 0: return ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS8);
+    case 1: return ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS16);
+    case 2: return ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS32);
+    case 3: return ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS64);
+    case 4: return ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS128);
+    default: return false;
+    }
+}
+
+static void dm_sba_execute(RISCVDMState *s, bool is_write)
+{
+    uint32_t sbaccess = ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS);
+    int access_bytes = dm_sba_access_bytes(sbaccess);
+    uint8_t buf[16] = { 0 };
+    MemTxResult result;
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSYERROR) ||
+        ARRAY_FIELD_EX32(s->regs, SBCS, SBERROR)) {
+        return;
+    }
+
+    if (!access_bytes || !dm_sba_access_supported(s, sbaccess)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBERROR, 4); /* other error */
+        return;
+    }
+
+    if (s->regs[R_SBADDRESS2] || s->regs[R_SBADDRESS3]) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBERROR, 2);
+        return;
+    }
+
+    hwaddr lo = s->regs[R_SBADDRESS0];
+    hwaddr hi = s->regs[R_SBADDRESS1];
+    hwaddr addr = (hi << 32) | lo;
+
+    if (addr & (access_bytes - 1)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBERROR, 3); /* alignment */
+        return;
+    }
+
+    ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSY, 1);
+    for (int i = 0; i < 4; i++) {
+        stl_le_p(buf + i * 4, s->regs[R_SBDATA0 + i]);
+    }
+
+    if (is_write) {
+        result = address_space_rw(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, buf,
+                                  access_bytes, true);
+    } else {
+        result = address_space_rw(&address_space_memory, addr,
+                                  MEMTXATTRS_UNSPECIFIED, buf,
+                                  access_bytes, false);
+        if (result == MEMTX_OK) {
+            for (int i = 0; i < 4; i++) {
+                s->regs[R_SBDATA0 + i] = ldl_le_p(buf + i * 4);
+            }
+        }
+    }
+
+    if (result != MEMTX_OK) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBERROR,
+                         result == MEMTX_DECODE_ERROR ? 2 : 7);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSY, 0);
+        return;
+    }
+
+    trace_riscv_dm_sba_access(addr, s->regs[R_SBDATA0], access_bytes, is_write);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBAUTOINCREMENT)) {
+        addr += access_bytes;
+        s->regs[R_SBADDRESS0] = (uint32_t)addr;
+        s->regs[R_SBADDRESS1] = addr >> 32;
+    }
+
+    ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSY, 0);
+}
+
 
 static void dm_status_refresh(RISCVDMState *s)
 {
@@ -1108,6 +1198,129 @@ static uint64_t dm_progbuf_post_read(RegisterInfo *reg, uint64_t val)
     return val;
 }
 
+static uint64_t dm_sbcs_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t val = (uint32_t)val64;
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "riscv-dm: write to sbcs while busy\n");
+        return s->regs[R_SBCS];
+    }
+
+    uint32_t cur = s->regs[R_SBCS];
+
+    /* W1C: sberror and sbbusyerror */
+    uint32_t sberror_clr = FIELD_EX32(val, SBCS, SBERROR);
+    uint32_t sberror_cur = FIELD_EX32(cur, SBCS, SBERROR);
+    cur = FIELD_DP32(cur, SBCS, SBERROR, sberror_cur & ~sberror_clr);
+
+    uint32_t busyerr_clr = FIELD_EX32(val, SBCS, SBBUSYERROR);
+    uint32_t busyerr_cur = FIELD_EX32(cur, SBCS, SBBUSYERROR);
+    cur = FIELD_DP32(cur, SBCS, SBBUSYERROR, busyerr_cur & ~busyerr_clr);
+
+    /* Writable fields */
+    cur = FIELD_DP32(cur, SBCS, SBREADONADDR,
+                     FIELD_EX32(val, SBCS, SBREADONADDR));
+    cur = FIELD_DP32(cur, SBCS, SBACCESS,
+                     FIELD_EX32(val, SBCS, SBACCESS));
+    cur = FIELD_DP32(cur, SBCS, SBAUTOINCREMENT,
+                     FIELD_EX32(val, SBCS, SBAUTOINCREMENT));
+    cur = FIELD_DP32(cur, SBCS, SBREADONDATA,
+                     FIELD_EX32(val, SBCS, SBREADONDATA));
+
+    return cur;
+}
+
+static void dm_sbaddress0_post_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+        return;
+    }
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBREADONADDR) &&
+        !ARRAY_FIELD_EX32(s->regs, SBCS, SBERROR) &&
+        !ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSYERROR)) {
+        dm_sba_execute(s, false);
+    }
+}
+
+static uint64_t dm_sbaddress1_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+        return s->regs[R_SBADDRESS1];
+    }
+    return (uint32_t)val64;
+}
+
+static void dm_sbdata0_post_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+        return;
+    }
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSYERROR) ||
+        ARRAY_FIELD_EX32(s->regs, SBCS, SBERROR)) {
+        return;
+    }
+
+    dm_sba_execute(s, true);
+}
+
+static uint64_t dm_sbdata0_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+        return val;
+    }
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSYERROR) ||
+        ARRAY_FIELD_EX32(s->regs, SBCS, SBERROR)) {
+        return val;
+    }
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBREADONDATA)) {
+        dm_sba_execute(s, false);
+        return val;
+    }
+    return val;
+}
+
+static uint64_t dm_sbdata1_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+        return s->regs[R_SBDATA1];
+    }
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSYERROR) ||
+        ARRAY_FIELD_EX32(s->regs, SBCS, SBERROR)) {
+        return s->regs[R_SBDATA1];
+    }
+    return (uint32_t)val64;
+}
+
+static uint64_t dm_sbdata_hi_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, SBCS, SBBUSY)) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBBUSYERROR, 1);
+    }
+    return val;
+}
+
 static uint64_t dm_haltsum0_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
@@ -1287,20 +1500,31 @@ static RegisterAccessInfo riscv_dm_regs_info[] = {
       .ro = R_SBCS_SBACCESS8_MASK | R_SBCS_SBACCESS16_MASK |
             R_SBCS_SBACCESS32_MASK | R_SBCS_SBACCESS64_MASK |
             R_SBCS_SBACCESS128_MASK | R_SBCS_SBASIZE_MASK |
-            R_SBCS_SBBUSY_MASK | R_SBCS_SBVERSION_MASK, },
+            R_SBCS_SBBUSY_MASK | R_SBCS_SBVERSION_MASK,
+      .pre_write = dm_sbcs_pre_write, },
 
-    { .name = "SBADDRESS0", .addr = A_SBADDRESS0, },
+    { .name = "SBADDRESS0", .addr = A_SBADDRESS0,
+      .post_write = dm_sbaddress0_post_write, },
 
-    { .name = "SBADDRESS1", .addr = A_SBADDRESS1, },
+    { .name = "SBADDRESS1", .addr = A_SBADDRESS1,
+      .pre_write = dm_sbaddress1_pre_write, },
 
     { .name = "SBADDRESS2", .addr = A_SBADDRESS2, },
 
-    { .name = "SBDATA0", .addr = A_SBDATA0, },
+    { .name = "SBDATA0", .addr = A_SBDATA0,
+      .post_write = dm_sbdata0_post_write,
+      .post_read = dm_sbdata0_post_read, },
 
-    { .name = "SBDATA1", .addr = A_SBDATA1, },
+    { .name = "SBDATA1", .addr = A_SBDATA1,
+      .pre_write = dm_sbdata1_pre_write,
+      .post_read = dm_sbdata_hi_post_read, },
 
-    { .name = "SBDATA2", .addr = A_SBDATA2, },
-    { .name = "SBDATA3", .addr = A_SBDATA3, },
+    { .name = "SBDATA2", .addr = A_SBDATA2,
+      .pre_write = dm_sbdata1_pre_write,
+      .post_read = dm_sbdata_hi_post_read, },
+    { .name = "SBDATA3", .addr = A_SBDATA3,
+      .pre_write = dm_sbdata1_pre_write,
+      .post_read = dm_sbdata_hi_post_read, },
 
     { .name = "HALTSUM0", .addr = A_HALTSUM0,
       .ro = 0xFFFFFFFF,
@@ -1602,6 +1826,17 @@ static void dm_debug_reset(RISCVDMState *s)
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, DATACOUNT, s->num_abstract_data);
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, PROGBUFSIZE, s->progbuf_size);
 
+    /* SBA capabilities */
+    if (s->sba_addr_width > 0) {
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBACCESS8, 1);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBACCESS16, 1);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBACCESS32, 1);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBACCESS64, 1);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBASIZE, s->sba_addr_width);
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBACCESS, 2); /* default 32-bit */
+        ARRAY_FIELD_DP32(s->regs, SBCS, SBVERSION, 1);
+    }
+
     /* Reset per-hart state */
     if (s->hart_resumeack && s->num_harts > 0) {
         for (uint32_t i = 0; i < s->num_harts; i++) {
-- 
2.53.0



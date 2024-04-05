Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35A4C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglB-000604-9n; Fri, 05 Apr 2024 06:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0005xj-GD
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:18 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkx-0004bK-Ej
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:16 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5a4f608432bso1257874eaf.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312710; x=1712917510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u5+pVSAg9tQ0fLP/+FG5I9U0zGo5SwpUOOXoI7YuppI=;
 b=CxrjXb8fwVzB6wQyBfRIB1gxiqlN/sPjvFY3QnrmnOpC+aAQd+kMjGR/92K8eFRV5D
 JmVamEBwlAQGVwi2tYJJz83dV7t2mn9CAm0FWw+HqJZBFURGWDJ3DyasHBQ33fllK1JW
 KX8tsqSc4tvfTOFcyRd/wzicXL/nRoUIlfvszMAdoul5k6g+OIafpl5SlSIArV2EqkIX
 xp291+4QtpSU1mvGfSnlhYNy/2Da9/vrz3PcAK7OB11Nb3Syw/0krpktCtvV3OpSMJqc
 vcgGLNFkmnvsMZm3bH87XpOzQM9cU5ySRSDYfIk5kE+b7mnTfOuSK/VaZijfro5xWdtX
 jT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312710; x=1712917510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5+pVSAg9tQ0fLP/+FG5I9U0zGo5SwpUOOXoI7YuppI=;
 b=mw+dfFXjqw05of2LqXUevwbXi6uifSdKjnJhiOg+nwTBZkkFfiBeNkjALx6ur2mQSH
 35jpIWAyjOgzxaS22meoNg/xJlZ2xq9t7NQYfYWVtvPCbYOnGJg/MxY7XeBHoUMxOMEM
 XW/CX/1f3lck26VtPzN3bNcpQJN1uQn9wMKxpqmTPfwqdRplDuW+04ix4DW0zdJxfGSW
 CQaauPeUbhpzuP9HYcXXE1TvoZVbBCIVLVmZD6k2xZSg4HUbNb0Hwofzrl+DqTKNpnoO
 YnzhT7uZMB/6A+irHOSoaVugvMlGkrSM5QcctuODUNUdNTAH8EOIOCEdc7xgegq/HwSJ
 zo9w==
X-Gm-Message-State: AOJu0Ywu+EdkQqoWzHwcuD5yU6ArwNA4LRpoxwUIGIQa2WJTJM9QjF90
 lRFETAHl+62ywSPg2Y+635WhOgfHnu+OlcaDV7LSBEyclW9j3HMNtT1ykNJBNwQT+jvZ9w+dxti
 K
X-Google-Smtp-Source: AGHT+IF/NijoWoFXeiahVYcUihmEka2iZJJ707dvUeXpuHoHODBVzya7twY/sqSeayl7QO6/XakquA==
X-Received: by 2002:a05:6358:c8e:b0:183:cfe0:8da8 with SMTP id
 o14-20020a0563580c8e00b00183cfe08da8mr1058912rwj.23.1712312709912; 
 Fri, 05 Apr 2024 03:25:09 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/32] accel/tcg: Record mmio bytes during translation
Date: Fri,  5 Apr 2024 00:24:33 -1000
Message-Id: <20240405102459.462551-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

This will be able to replace plugin_insn_append, and will
be usable for disassembly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 12 ++++++++++++
 accel/tcg/translator.c    | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 65d0c6489a..b341dfbf02 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -88,6 +88,18 @@ typedef struct DisasContextBase {
     int8_t saved_can_do_io;
     bool plugin_enabled;
     void *host_addr[2];
+
+    /*
+     * Record insn data that we cannot read directly from host memory.
+     * There are only two reasons we cannot use host memory:
+     * (1) We are executing from I/O,
+     * (2) We are executing a synthetic instruction (s390x EX).
+     * In both cases we need record exactly one instruction,
+     * and thus the maximum amount of data we record is limited.
+     */
+    int record_start;
+    int record_len;
+    uint8_t record[32];
 } DisasContextBase;
 
 /**
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 438b6d4cba..401c0ca30c 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -143,6 +143,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->saved_can_do_io = -1;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
+    db->record_start = 0;
+    db->record_len = 0;
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -314,6 +316,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     return true;
 }
 
+static void record_save(DisasContextBase *db, vaddr pc,
+                        const void *from, int size)
+{
+    int offset;
+
+    /* Do not record probes before the start of TB. */
+    if (pc < db->pc_first) {
+        return;
+    }
+
+    /*
+     * In translator_access, we verified that pc is within 2 pages
+     * of pc_first, thus this will never overflow.
+     */
+    offset = pc - db->pc_first;
+
+    /*
+     * Either the first or second page may be I/O.  If it is the second,
+     * then the first byte we need to record will be at a non-zero offset.
+     * In either case, we should not need to record but a single insn.
+     */
+    if (db->record_len == 0) {
+        db->record_start = offset;
+        db->record_len = size;
+    } else {
+        assert(offset == db->record_start + db->record_len);
+        assert(db->record_len + size <= sizeof(db->record));
+        db->record_len += size;
+    }
+
+    memcpy(db->record + (offset - db->record_start), from, size);
+}
+
 static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 {
 #ifdef CONFIG_PLUGIN
@@ -341,6 +376,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
     if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
         raw = cpu_ldub_code(env, pc);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
@@ -355,6 +391,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_lduw_code(env, pc);
         raw = tswap16(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -369,6 +406,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldl_code(env, pc);
         raw = tswap32(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -383,6 +421,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldl_code(env, pc);
         raw = tswap64(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -390,5 +429,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
+    assert(pc >= db->pc_first);
+    record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C490C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvVJ-0007A8-MH; Thu, 08 Aug 2024 01:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVF-00071z-KK
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:15:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVD-0002kL-L3
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:15:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d333d5890so581518b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723094153; x=1723698953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsLWShV0KYG63q6ApLyZEwJPcBpjz5iccGdNDN/z9sI=;
 b=a7CfNMmt2lA0NEBgh0Lo3IZmuikqItU7LBWlaK48eLtYR1A1SkVhPm2lwd24nD5f0w
 jvMUkpuNWIYS5/Dxh3ZM1GCdgGJFMGaL5s7rFTdblWouFdJNy+ttCG1mjglSxna25B1E
 F4Fd5Y57Ou6Hubv1LkLsVJ3FYDxPNCxDRtszx4Lh6X2ZZjZU/c5HG+EHwuzdXtWxtPFw
 RTvDtLkvno0daPqLZvoWlgez+geZDrfiBxStivVCtdWAwNJU6jIDKCX8gw1SyLGT5IuG
 VZs8EAOtVd/4B3DX/jFFnA4NoETOoW1hffUKGUviMMIDUkKOjFUrhA0GJH1i6L9sk24t
 lj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723094153; x=1723698953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsLWShV0KYG63q6ApLyZEwJPcBpjz5iccGdNDN/z9sI=;
 b=xKvZyVIaKulz9ags3usGmErvQgxAXH8g6nRNpYCYsVfmOmcZIq+So7xvVHGO4YqaAk
 hwLqiZtxyGxQIMsXfaKHme7TNdat2nLqGKl7geMRFhy5brUx4W70R0ZSGkEqk1JmMdJH
 auWPDTBnkb6gxHN5Z+HRZ1I8i5xtZm9WwsJWO1muZaC7SnrAYsi7RFt3eDyziefbQBSn
 sTd2/o8Bhmj8Glw7opyxL3cwAYm8gzv+zWAgDenN2cY704rx/lD3nvdC0m7QOnOWguYN
 ZcpHfIU78+gTBGpupmTdkQljvVihPid46Q60p1ZQ6pYa7+33L8fYpOIdDTRmLW3wLm50
 tY4w==
X-Gm-Message-State: AOJu0YxRyRUFmLeYe/lcAIKJUgskOZ2L6XfC9CImwGrHunwDFxdi/tIe
 SzJwnZuZbiTNKT9SfMcao4YolRAx7sLRZs735Vt1JELkCEH38PUI3kEzAf/JI/n3YP9mp1iZw6L
 V
X-Google-Smtp-Source: AGHT+IFDvanuq+tNgWtnW6sGvGpowIL0zslFKe1k4fG5K+uxZlDrSpS4B0u63evemke30Boq8W3e9g==
X-Received: by 2002:a05:6a00:1aca:b0:70d:2621:5808 with SMTP id
 d2e1a72fcca58-710cad57928mr1049761b3a.9.1723094153399; 
 Wed, 07 Aug 2024 22:15:53 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm373484b3a.71.2024.08.07.22.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 22:15:52 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 1/4] gdbstub: Use specific MMU index when probing MTE
 addresses
Date: Thu,  8 Aug 2024 05:15:28 +0000
Message-Id: <20240808051531.3183498-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808051531.3183498-1-gustavo.romero@linaro.org>
References: <20240808051531.3183498-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

Use cpu_mmu_index() to determine the specific translation regime (MMU
index) before probing addresses using allocation_tag_mem_probe().

Currently, the MMU index is hardcoded to 0 and only works for user mode.
By obtaining the specific MMU index according to the translation regime,
future use of the stubs relying on allocation_tag_mem_probe in other
regimes will be possible, like in EL1.

This commit also changes the ptr_size value passed to
allocation_tag_mem_probe() from 8 to 1. The ptr_size parameter actually
represents the number of bytes in the memory access (which can be as
small as 1 byte), rather than the number of bits used in the address
space pointed to by ptr.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 5221381cc8..26d242dd63 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -435,6 +435,7 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -458,8 +459,10 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
         gdb_put_packet("E03");
     }
 
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false) & ARM_MMU_IDX_COREIDX_MASK;
     /* Note that tags are packed here (2 tags packed in one byte). */
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
@@ -478,13 +481,16 @@ static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
 
     uint8_t *tags;
     const char *reply;
 
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false) & ARM_MMU_IDX_COREIDX_MASK;
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     reply = tags ? "01" : "00";
 
@@ -495,6 +501,7 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t start_addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -527,8 +534,10 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
      * Get all tags in the page starting from the tag of the start address.
      * Note that there are two tags packed into a single byte here.
      */
-    tags = allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
-                                    8 /* 64-bit */, MMU_DATA_STORE, true, 0);
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false) & ARM_MMU_IDX_COREIDX_MASK;
+    tags = allocation_tag_mem_probe(env, mmu_index, start_addr, MMU_DATA_STORE,
+                                    1, MMU_DATA_STORE, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
-- 
2.34.1



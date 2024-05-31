Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40ACC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Jr-0001qz-NA; Fri, 31 May 2024 13:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Jq-0001qX-26
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:34 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sD6Jj-0007WY-14
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:45:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f6342c5fa8so8737075ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717177522; x=1717782322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNUjy3Lyly2ANVQLK35XiynkZqf6DtnuQXKWv8PGktk=;
 b=FoQpFzhv18orLpNtdahmGjjyvTDziPEu2rWiFuKariBndk72dNPgAO7+2Epi3IYS9s
 fb1nWUB2oFiGjAJ85ANpcJyXhqeGlgrgUBoRjZiNkXaAp528DeYA3YHdzNfRS6U52TN2
 dAcPHlMhdln/kNh2QUWAxhKpWTvfMxCoNCbiXnc3fiJcfZsmmj2Vh6vAwQK2u8aAAJ99
 FDBlfKmlW03DZSeJy7+qRxKktA9qYhSff4vdaU3B68pKdkx5ej6Wo7vgmm37e5uGv1wC
 DlXTPBN98THgGIYJuQx+qTCQGRMlf0YmUpOf+wldn03noR7g2+bpBf6CoqBDHRFwP/g9
 DrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177522; x=1717782322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNUjy3Lyly2ANVQLK35XiynkZqf6DtnuQXKWv8PGktk=;
 b=AViJjq2K2aOKdf1Fo2tFqQQ73TkRIy9J78DQxVEqU16tjTFU0C6UGjgOJdP0rYaPbI
 viMnnMSvGkJ4J2oiGIm1u7hmVOD6rjfQEKJLcEgA7SDUgn/GjzTm7SyqFvaikmZHRGv7
 47AX+Fq6vu7fzpdzWH4nDUl02nbyXbnug+DRB3HvxGC0u2FKbs68CID4IZ+n7K0JOxUg
 HHtE3PHqLLzBiEe6Uj6SWORYTPG3oTgxSUign/XiWcXBxp6SgNafAJMJTZ0eLeUuWY0T
 MrIQIesMtBztVlwY4FhwVF39fes8ioUtxd2Bs9qDXb1vCNg212nWQFLA6zOg66ewaVG1
 By2w==
X-Gm-Message-State: AOJu0YxNdUyuizJTzYNEV64ZjOTbfVAdI4ZePrYqiUzsjbRiRlClVwCX
 Z8k6gBKCI6ZVDZYKhI1dr5dfAMT7ElSdYp+LVHiRAIOS01EahihMuUXubiXs1Ky/J3Mw4kCOQ4S
 xPybXKCncI5rQtPDNT9nRT5JFMol/fR+v0shAqOsZ2a+seY9rMSgbDf60X3dVpLbS0V7cGrTa6v
 7f8DPoHPaiYQDROBm2U4ePm0xeV4LXoGYAangZMw==
X-Google-Smtp-Source: AGHT+IGUGjtUJ1hN8pGESw4gO6VOz43UlJixyBVehNle/WKiJXMIR/pDwvAq8FI01JD1YEoatIYU5g==
X-Received: by 2002:a17:902:da89:b0:1f6:2ab1:6037 with SMTP id
 d9443c01a7336-1f6370ad379mr32146895ad.53.1717177522174; 
 Fri, 31 May 2024 10:45:22 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63236ce6dsm19389875ad.95.2024.05.31.10.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:45:21 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 2/6] accel/tcg: Avoid unnecessary call overhead from
 qemu_plugin_vcpu_mem_cb
Date: Sat,  1 Jun 2024 01:44:49 +0800
Message-Id: <20240531174504.281461-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531174504.281461-1-max.chou@sifive.com>
References: <20240531174504.281461-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If there are not any QEMU plugin memory callback functions, checking
before calling the qemu_plugin_vcpu_mem_cb function can reduce the
function call overhead.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 accel/tcg/ldst_common.c.inc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index c82048e377e..87ceb954873 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -125,7 +125,9 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
 
 static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+    }
 }
 
 uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
@@ -188,7 +190,9 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
 static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+    }
 }
 
 void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
-- 
2.34.1



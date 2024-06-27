Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813AAC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxn-0007hX-5Q; Thu, 27 Jun 2024 06:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxT-00070H-H9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxQ-00022t-Rk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso4624082b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482542; x=1720087342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnkZtfqlRk/cYHVUB0haBca2EsSvWjX5ehFS1hvQupE=;
 b=arWaMsBL3wFg8+1rwIXSUYSu2QiUFRni47qxhMDtiMruSumKZU2LpgSrnTfMCiv5Ra
 AVPPJIcYLnSKcQxmi7eDvFcC6r+6wqBhUq4zy1bLFpl6xgHiSCItZpcxL+IKu+nKcHm0
 fmeSqvSKSk/SVeRJlVCUkQpQgF2aFdx14FOoY7grUYStaBsIgvIYqGOUpZZ9YhLQKO4Q
 4s37aUP9ZMxDh+IoEghLdO3Mg4qcX+REkizcC4kqM+O9h6GUIkYvFnPas0BBkBSzSywb
 yNK7sllTGheHzlpseJTlz8S7XFtDNBmkI0dnrURd7toZ/z9WsUb5iMWb2g9gEHdLIIcT
 7CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482542; x=1720087342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnkZtfqlRk/cYHVUB0haBca2EsSvWjX5ehFS1hvQupE=;
 b=M4HDkAyGP4cDOf6BZbp6rsjYasa3x5XwVssRWa2NP8SK1TL0cU/rJm8mtxIfPFCjlw
 6GBT+em/r8YWhjbldyuu2YMIyLcViLi30IAvu8sh9JttGohn7r9skIxdYMinPXp23GaC
 xgoTnoB2qo3d0Tflwe1WEGDAwnIIn3XzHz6G6RlvkRoeJPaQzsTN+kdzUp+dcrGGxypB
 RzPRNUNRiPE9XnkDUSgHlOlQ3QJFBfWGeiRw7WHpZNhQKl1DnQQJPjnkKOTN6R2P7wV/
 tCl+FeFm4X38QJElWKu1HcqJwpDaL45xb9h4spQy3mKIZixpGj3BC42BpFOv6UvLdvzR
 Fofw==
X-Gm-Message-State: AOJu0YwnbcJUb5OLmd1F+eJEelCCy6bjw87KC1lwxoRZW0jidmnJdGys
 X9UvE8s9qRNQJRlMj51PowRVJatwXJyFxndYCDiCSz4nOkqBdyQe0eupvHWs
X-Google-Smtp-Source: AGHT+IHUFnWvX+Z7yhzkGn8VfG/zDNOZvrKxs1fwaNoPM1fq6R0o8wZHu226DvUYRVYEwYcQias+BQ==
X-Received: by 2002:aa7:8f8f:0:b0:706:b19c:46cf with SMTP id
 d2e1a72fcca58-706b19c4a75mr2201839b3a.20.1719482542055; 
 Thu, 27 Jun 2024 03:02:22 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:21 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/32] target/riscv: Introduce extension implied rules
 definition
Date: Thu, 27 Jun 2024 20:00:45 +1000
Message-ID: <20240627100053.150937-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

RISCVCPUImpliedExtsRule is created to store the implied rules.
'is_misa' flag is used to distinguish whether the rule is derived
from the MISA or other extensions.
'ext' stores the MISA bit if 'is_misa' is true. Otherwise, it stores
the offset of the extension defined in RISCVCPUConfig. 'ext' will also
serve as the key of the hash tables to look up the rule in the following
commit.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240625114629.27793-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 23 +++++++++++++++++++++++
 target/riscv/cpu.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 90b8f1b08f..87742047ce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -124,6 +124,29 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+typedef struct riscv_cpu_implied_exts_rule {
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Bitmask indicates the rule enabled status for the harts.
+     * This enhancement is only available in system-mode QEMU,
+     * as we don't have a good way (e.g. mhartid) to distinguish
+     * the SMP cores in user-mode QEMU.
+     */
+    unsigned long *enabled;
+#endif
+    /* True if this is a MISA implied rule. */
+    bool is_misa;
+    /* ext is MISA bit if is_misa flag is true, else multi extension offset. */
+    const uint32_t ext;
+    const uint32_t implied_misa_exts;
+    const uint32_t implied_multi_exts[];
+} RISCVCPUImpliedExtsRule;
+
+extern RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[];
+extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
+
+#define RISCV_IMPLIED_EXTS_RULE_END -1
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4760cb2cc1..7b071ade04 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2250,6 +2250,14 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
+    NULL
+};
+
+RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
+    NULL
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
-- 
2.45.2



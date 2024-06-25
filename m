Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041A6C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4dW-0007zR-Fr; Tue, 25 Jun 2024 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dU-0007ym-1x
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dS-0000bO-Ge
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:46:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso42034975ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316012; x=1719920812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3BaoUoeV7yh5wrh+1aCVzWH7Yi6fNaAowLotftX5IA=;
 b=FC9kn3QqeYaC/Fc3pnpOeGDQv76yDqrNp0BfqGrttoYYmdrt6gEL42+OonRCWpicrB
 ezJdUbU5waNuaDljt73y1NdWL5l4TYDCCQv9WYm91ljKKlpARIA5jyBRS4khs8EtrzrI
 ACrWnC8Z5a1t1xy/SajQIDYEghRg7ZuJF3k7mT5uNDKilINY88JQ7Swt/B9TlFC4t8Sl
 KTDLWyieV5ROascoQ1ar4hi2IezB4yIJenSVHa+GA9XWWBQ+vCTEcQ7TLw6cJgANaVpt
 xejlCepvcgaA2mLbUQMWzqbX8x1gMLKFJXl1qR8lwObzBdcJa6uk08otda9rWo5xZenX
 +nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316012; x=1719920812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3BaoUoeV7yh5wrh+1aCVzWH7Yi6fNaAowLotftX5IA=;
 b=M5zUjzFkg1alaQWun6r/khBRr3nBQl13JciPAdZ9XFQzWOqIW0wM1XIjd1c4PuoOLS
 YOcHkEiatktV68Zfl/wBP11z9DPmvqdic0JkBITLY4p21/WpG7cwe9FqQqPxueura4jR
 2EwtadAq9sQjnWNID2kn+dl2cK0UGyCc9SUF5mnG0MaZRWhG+dQ+Ev+ElaKrvWsKtKSQ
 yUD28hG6bTcD5Xf2h6nbpL3cPYou+/dtXGPOINRe52DN9olYO9js8MUMorJrdSj3ZEF1
 +TC6nBPzm2GSj2phgXZHiMb04ciiHCygmN93VdS4y76cIcsWu5rJ91Z1xDYV7ipqZBPe
 QPdg==
X-Gm-Message-State: AOJu0YwhdMogOPwerYUCkp53EKEzYOuPSHMDmPiy9xsAvOxnryhFbS2K
 ovL0nQqHIF39G4aQCJ+3C6VtLcV2m+S9F6eR7G2BeoaC7fTWas6Bx9X+KxcxI4m1JNHyG69Hzwg
 zrNDXiQqM3JaH9jWFfspVVlXPzKkcGQy3LRndB5Y0oGl1YZ/jk6ptFSHOC0sHHE5Y8mvKiaigj2
 AEPYkk1j8lVy8bYy6K31sLkLHOt/NAGDBRppy3kb2rh9Jv
X-Google-Smtp-Source: AGHT+IF4m3I6jEQEx/iGD7KIQMfRqFeP2n/L4ibeglnHIyzFoSlEviiWfSpcJzlGnxsG6r9ayfxVrg==
X-Received: by 2002:a17:902:e891:b0:1f4:620b:6a27 with SMTP id
 d9443c01a7336-1fa1d3b6d92mr87638885ad.13.1719316012024; 
 Tue, 25 Jun 2024 04:46:52 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:46:51 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 1/6] target/riscv: Introduce extension implied rules
 definition
Date: Tue, 25 Jun 2024 19:46:24 +0800
Message-ID: <20240625114629.27793-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
References: <20240625114629.27793-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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
---
 target/riscv/cpu.c |  8 ++++++++
 target/riscv/cpu.h | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
-- 
2.43.2



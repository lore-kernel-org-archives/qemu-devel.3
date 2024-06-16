Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE00C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvM-0007R3-BH; Sat, 15 Jun 2024 22:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvC-0007N7-QR
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:12 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvB-0001h3-9E
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:10 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7e23dc4bda0so136488239f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506027; x=1719110827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQNMf+6wuwd34N5Qpr2xVvlJAXmEbxY00fEA9ntvmsU=;
 b=Id6k+gNGqYDaXqUCcYCjdInyx2wD+ChSgT0ylo5NP32BOJg9CEQ+rodU5gax2SAkjX
 oufOUknvvbY+zfFwEZo6yke9dveKoVw/rM8c9LkY+kmgv/nS4W0C7lEliVBCDOGf/vza
 +8HMBalh7oZ1buS2UGGjEn70cyLWr5K7rRysC+WrgE8cqla/fZOHVlleI5VpUI/oLGpp
 BmC5ayRUxXitm5KIOXqxd47LPT0r7EPdUTElnD2k9lauthRebbMK7cAlkjOC8Ub0YFCW
 B9wBDvnVp+sipbGAMUP4Cp29RipWiL3kRvdS4T6JddLFzPrKV7fX2e0FXwoll9kVOP+V
 KGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506027; x=1719110827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQNMf+6wuwd34N5Qpr2xVvlJAXmEbxY00fEA9ntvmsU=;
 b=iEWkMGQ2be0hWfszgzdZ4wGjOxFSyfu7IB2AVx2RuMocaoNEOyJbGnKRhZev3d5pB6
 LaNPHNn+ipolizaKbSwD/rtJZE669fnK3+Ob3EWBjQgfc95OdijHsimt0QBarzd3BFMz
 bnujUp88CqikAegCE8e8wbk8hsFzDnRK62+n3CyDeTmEuE1+NNYHkAnE7jzpZGekflJD
 k5VMt53t96g/aqkKlEmjIYYTwXtCNJGjgW+SMWVWdN8sL/CjaCIS3Oe1Awn4rjEvmjX1
 uug6Kzow/eh+D3KeRvEd0/5Tz6TDN7XrHmHC8XNJAGOHHLgZI4OGNX90QLxqGQXXQdlC
 RZWQ==
X-Gm-Message-State: AOJu0YwlS6ZXy8aPmjYU7v4O8IZvYaX3ID5ucv6oi7Ojw6aSH4HYNGkb
 T2pt4Vth7YGwTK86g9YxN+YiS3z0s13w/RkDMD6LCbaqErPW7Zuo74FygMSS6hTbX/QFdZm2FQZ
 t0adLDS0xUnmSG+Y1K5cAq+PVPVBxMW2st/nn5zw2hriNj9+E9f4w49XaM0GAKXxgvcj+bBpu8W
 g4U3SoU9xvG8pJ2WEl4ic48PpXml5GS1oZJ0j5iDE=
X-Google-Smtp-Source: AGHT+IE0xIguhYHUiCnDxVpXM9r8oyIGirxsikhdNDjAwryUuR86cq1+ajvEmVL8nopuAmjKl/NKBw==
X-Received: by 2002:a05:6602:1503:b0:7eb:78b4:faee with SMTP id
 ca18e2360f4ac-7ebeb4909cbmr763582639f.3.1718506027140; 
 Sat, 15 Jun 2024 19:47:07 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:06 -0700 (PDT)
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
Subject: [PATCH v2 1/6] target/riscv: Introduce extension implied rules
 definition
Date: Sun, 16 Jun 2024 10:46:52 +0800
Message-ID: <20240616024657.17948-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=frank.chang@sifive.com; helo=mail-io1-xd2c.google.com
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
---
 target/riscv/cpu.c |  8 ++++++++
 target/riscv/cpu.h | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4760cb2cc1..bacbb32120 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2250,6 +2250,14 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
+    NULL
+};
+
+RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
+    NULL
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 90b8f1b08f..6b31731fa8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -124,6 +124,31 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
+
+struct riscv_cpu_implied_exts_rule {
+#ifndef CONFIG_USER_ONLY
+    /*
+     * Bitmask indicates the rule enabled status for the harts.
+     * This enhancement is only available in system-mode QEMU,
+     * as we don't have a good way (e.g. mhartid) to distinguish
+     * the SMP cores in user-mode QEMU.
+     */
+    uint64_t enabled;
+#endif
+    /* True if this is a MISA implied rule. */
+    bool is_misa;
+    /* ext is MISA bit if is_misa flag is true, else extension offset. */
+    const uint32_t ext;
+    const uint32_t implied_misas;
+    const uint32_t implied_exts[];
+};
+
+extern RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[];
+extern RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[];
+
+#define RISCV_IMPLIED_EXTS_RULE_END -1
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
-- 
2.43.2



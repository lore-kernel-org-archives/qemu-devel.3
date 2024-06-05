Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE0FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEkC2-0000pF-7x; Wed, 05 Jun 2024 02:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkBz-0000o4-0i
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:15 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEkBx-0007C9-Aa
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:32:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f6342c5faaso15711925ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717569131; x=1718173931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa2C9g/hhBjt/2P8x4j/ute7YkUYfWoypMZ0xm5ODao=;
 b=EvZAutqLoW6LkThvCEsN0IQ0AcuCvNdZz1dAWXyLgs431DDg8jkYe/Sc5c6BIX1T/X
 JLpY9oJvUDIKQoQAEUrg/ZXH35XgQXDhcqNE1ZzBr0ZAdm6q0S2tOebKJw/FHMBmf0Nb
 uWGUsAVk1KKw6ljMuiofIxIL+SLcp7Em0Vk8Aeh54NpTEDhJtOc8Oc1Mts4HgpiJ/bw4
 8PKwZ+5NPAkqZf4cG33WjvZO2iwtf9wdzYrGwdgER5jL585iiC2OAHDALWDHORRrIISD
 oa2ukBcKXJ4gLa84bOMvm0ifxejI9jVK5NSaybY3Us3UMzEI20kB0ng9KMvoO17ZSA7i
 6w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717569131; x=1718173931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oa2C9g/hhBjt/2P8x4j/ute7YkUYfWoypMZ0xm5ODao=;
 b=WOxqIx7Ey053CxclDcyd09SaJCQjpAkJ/bD3Cb4DfBvl3vsAp7SJHB7aM00YpyXfjV
 90POWbLRacPsSar+yTerltNjpxCb5kJtYykMjB2H0Fp3fmr6yu+wxQrR5dgf4t3ooXop
 H5ybZUhQvzL5Bol29qsDzea++4At9RfFEtHhHgb03SxhZDJfuMQVTYl67fj/T3dolNIv
 5esgZu7xP8f0nfUEpP8jPa3jDcKFB0ga/FgAKyFmGAlli8bqUtKGWIOgBQ4IP4Ptz0sY
 D9FV4ODblhf1i7FJI1E4LUKFRPZyiddd5cw3BbY08UGBBcs1R9Nugjyoaz+U6Ho8WFIr
 xMkQ==
X-Gm-Message-State: AOJu0Yxoy5DHO9AjJr17r2wM+NCX2rFeIDOToaU8KptRTfat9vo/ITNn
 SdChW1yJRRDQnL9lo7vfDYhkICPaax2v857NHd7QbwhRKdCNwU0xeKL0WD4Xbzvm8ApwDcj3QxI
 gab+TaasyeBqfTeOEKq3UwSwgSPVgEmkqh5bLxWMSQbwNCUr6aL5NiSlTnOvcvhkfT/4RoCcOJZ
 on7SOa0FsLBxyT/3kxlutZ1bicgP7QFuKNOxct7H1X0g==
X-Google-Smtp-Source: AGHT+IH1FFHJNfVg7wPEdzHucFicBafq+gzZKhbcwwcmEeJ++f+EAhCvX98iKI4NwHZhtmo+YEayhA==
X-Received: by 2002:a17:902:ce8e:b0:1f4:b702:f12d with SMTP id
 d9443c01a7336-1f6a5a11c6bmr17855905ad.26.1717569130636; 
 Tue, 04 Jun 2024 23:32:10 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356c84sm94819725ad.76.2024.06.04.23.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 23:32:10 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH RESEND 1/6] target/riscv: Introduce extension implied rules
 definition
Date: Wed,  5 Jun 2024 14:31:49 +0800
Message-ID: <20240605063154.31298-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240605063154.31298-1-frank.chang@sifive.com>
References: <20240605063154.31298-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
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
---
 target/riscv/cpu.c |  8 ++++++++
 target/riscv/cpu.h | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cee6fc4a9a..c7e5cec7ef 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2242,6 +2242,14 @@ RISCVCPUProfile *riscv_profiles[] = {
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
index 1501868008..b5a036cf27 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -122,6 +122,24 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;
 
+typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
+
+struct riscv_cpu_implied_exts_rule {
+    /* Bitmask indicates the rule enabled status for the harts. */
+    uint64_t enabled;
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



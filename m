Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBAC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0pO-0004q3-KK; Mon, 03 Jun 2024 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pN-0004pN-6Z
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:53 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sE0pI-0008Dz-Ez
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:05:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c1e6fcb2f1so1931207a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717394746; x=1717999546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uwnnss/+xz98w0owWG49u8M9znV5LjVPvCyxyfKwe8Y=;
 b=LVIPi0ojGRKYrInM7aRdacnY4lCX4H5DqeyqQHeq4/3FWZUc5UeIAv88cbxlvK7arP
 F0eq7BgWvGxnFfKup7t8DGqvOBwYRETTqmUfMYKNjDql50aFfakCcq97FTgTB3OHgnQT
 JD81qUnZFNeUHUBpR8jdzWPMFS2c/pDpdEDwZ6D9F/Izf6qTQB4DdIZI3FiJGgNjsBje
 hWBfbWm31TNpRsMAbnNHwoRaL+3CgSVCxm4NxxaHUACQuFLehddnmfQoYGFnMABcgFFp
 RlfrzxTIKpuDW3QhVXtW8HFaQw+tdjz1mncEsTc46i/PLR3vnpgxAADYOPoVEvo3itlm
 V/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717394746; x=1717999546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uwnnss/+xz98w0owWG49u8M9znV5LjVPvCyxyfKwe8Y=;
 b=TturiEEKxJqvJIrUrLxMfhUJyoIZ1u5JR/Df6kNB2FMB4oXEiwWLp3jkVC5mdeu5qM
 00eOqDvnJD3sGwsW2uE69u6v+sdrXhHTbTp2FpJefQcjQ3rV8lFo/XJeMzhSHctJ5LQp
 IGS0PLAhx8i3PUv1/kHkGYKvBGJrNSuniuS4s5jBPKkOLFSFD5O0b3RrP8arP11kNi9/
 jM4n0h4whrKay9ncDDKmOrngmL8gA7vltLV6tkn4ByJ7DT10rBjaT1oTHiHufcs3mT39
 oqCBKhQRmng/igjZ9X9NgboRIp0lmgny7oOm8bK0BEgSUozYocfnGXzQ9RwT1p0QNLQ4
 yqWw==
X-Gm-Message-State: AOJu0YzqFVs69cijHJf3t9p1jl62tF0pxNFcWFDrZsidSU0On1QJ1v+g
 Dn8dHcLEsOjNoG3KDlghgAArqjKwtiXgJAqn+Qhx7Vv+5SDULVQRdWHjzog17g/1oO1+4/fZCaN
 J7+MQDiBCRa50coBQZxf3W27DEvMa1lqP6h8O/yL21wIeK8TmHlNfIy5BmMvhkhCcFa2/zYtgsM
 uhoYrtzwrPN8SMXvop9V8Nq9dLVMElWuocgsPnxtA=
X-Google-Smtp-Source: AGHT+IGDb6zSuWz19G2iiVt2gUMxgSHaLjh+zY3w/+vSpbZVYGb/FpFguKHfl4owdwz1pXmJFTLiyQ==
X-Received: by 2002:a17:90b:60f:b0:2b2:6975:bf49 with SMTP id
 98e67ed59e1d1-2c1dc56dcd4mr6704924a91.6.1717394745503; 
 Sun, 02 Jun 2024 23:05:45 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a77afa1fsm7149291a91.42.2024.06.02.23.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 23:05:45 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Subject: [PATCH 1/6] target/riscv: Introduce extension implied rules definition
Date: Mon,  3 Jun 2024 14:05:17 +0800
Message-ID: <20240603060522.2180-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240603060522.2180-1-frank.chang@sifive.com>
References: <20240603060522.2180-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
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
---
 target/riscv/cpu.c |  8 ++++++++
 target/riscv/cpu.h | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 1501868008..b8ebff6631 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -122,6 +122,23 @@ typedef enum {
     EXT_STATUS_DIRTY,
 } RISCVExtStatus;

+typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
+
+struct riscv_cpu_implied_exts_rule {
+    bool enabled;
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



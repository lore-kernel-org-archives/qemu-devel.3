Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA3BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuD0a-0002yk-Tz; Wed, 12 Aug 2026 13:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0L-0002qR-FG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wuD0J-0007dD-L5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 13:44:41 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2164232a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1786556675; x=1787161475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzDpG69c0U/dBiv0BSn17OfVNnj4yY7pxo9nq5cILcc=;
 b=IUYDfi/t/vlewy7jN+SYY2zR1+lTmpN1OHUBgHGt/xUZo+kO23w7izSC7Hr9CXZN/W
 iQD0cFIHuj+ZoIprm1XwNR1jiX3yJ33sDrD+EMxGFdHlQA1/BeDkANO8kYw1OhQe5DSi
 VU0kukBmXxc6Rz0CiSidz4v+V9MzGUBhh7/4P8+gyvVrQH+c1S+Pu7hoWYG8Kbr2k0dS
 zFPOL0EtX7QMy2ShE3UQ+CWBuEqBM3KTQY1zvC6StAD8Kb29g+76gWn9gtbB0svkgClX
 lmkO8alqt1nk6kw+bUz5z8NZ+P29KJj5+XiyG8PxBq3GxE9JYJ5TXt9S2avuGcBdFGdC
 LadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786556675; x=1787161475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gzDpG69c0U/dBiv0BSn17OfVNnj4yY7pxo9nq5cILcc=;
 b=kP2fiLULvUToq4Xzt6IvKsC41IKZSpwbQFku6jTfVJJmUdLGqiG57dQunKBN19e/UT
 ZRXO9ocVCdZDcOfYyt41G/+plGRROdJzQg0NX362YuuWQuw5TRt00Ik2UGmtiKZU2dOS
 PWTx72hXShYGiSxqttNvss7W6ddSJUjAxKDOJjUBSK4OTAqpRJfyHnT32AiqWNn+cn06
 0PuwXBEGwIaNhNUlqb4JLe3AHDyCk/m8FSjvozZiuKpoP8pJKYZspAs2QJeXaD8EUwpQ
 S6lJ7FrySfqHTCI5ELK2pi+EH4H1taJ9Sa2fXot5r2YcL/rVPxPl2NuBBmnq77TCL27H
 P0QQ==
X-Gm-Message-State: AOJu0Yzxlrv3TXRyCK1zFlJP4ovflXxKyjwmNnmCDqpzEVcpoEO/JzRr
 ABBoxLxODpnW0pAYHeMbAkjqW8eWVJDvL1EfWQnnCvhOPGKKxfSpM7tDovRau52mSXNFk20/dch
 frPYA4OEt/7Am6MpyK0H274tz+LN5oiRSeySqRoP0Uf49qaJNTPd6nQ2ozmhhNvUeQdoDg48Bjs
 9ndseX2CnX4aM+MczqQUEx4K6dTHNeTCtxRHK1npo=
X-Gm-Gg: AR+sD118yxMHGoSBEeQkRFom6XWRmP0zlx5O3e+8Y6pYhWgxCsvcCMFaaK4+T2aUvlj
 dWWPY22NDIb/qc2TrLNuCrh5vf0gN+NgRY14Qo/oScNF6leERmGeUkvKQGxl5UQjqP6A/z9I+h8
 Wug8nkVYtOaEDlbGdf+p4sMBCMTBozvnNbNLUHi9GxBoaYzvKuB7aGBAgSDjKroMd9cV5UwqF2y
 qbvvkOZAPOf9IjsyYBdAnkIZmPqHMmmhw80L7TU+c1xYgfrAjNkyUMC03BCy7Q093N5rZPBhqxW
 hRKjXUhY7o+RL+u37mNs268rPOTpjPHZFrqZf4ZUg5rwVGINbMWAbmSArhZh6mbfHCd3RcL6xoM
 iYlKx+mxBodJqJGJUhEv0htyC3ge7KOQ/mMUSwPBpZqgrd/E2Xa0l/k1QIAPRGIJQ4sRACzt1CS
 gaZHtwDoYPfmqenlS4n9QSZS0RwQTiqfNQ0xTpc8PWyP8uTEMxjHKibSLHAZcn+/By/lv15FMrw
 aCIFTAmd5XhFJYPexPR648UhcR4/bFAdkha54+Ij3LIe4MQMlS5q79DBI0Z0y3g
X-Received: by 2002:a17:90b:1f90:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-39301416e89mr7931944a91.13.1786556674645; 
 Wed, 12 Aug 2026 10:44:34 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931db13c3bsm13210a91.3.2026.08.12.10.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:44:33 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Date: Thu, 13 Aug 2026 01:44:13 +0800
Message-ID: <20260812174417.2468981-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812174417.2468981-1-max.chou@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1032.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add SiFive custom int8 matmul extension implied rules to enable the
implied extensions of SiFive custom int8 matmul extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fffb92ff110..265a92a8b7f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2811,6 +2811,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
@@ -2862,6 +2880,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &SMCTR_IMPLIED,
     &SSCTR_IMPLIED,
     &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED,
+    &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.43.0



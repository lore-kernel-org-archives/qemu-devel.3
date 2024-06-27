Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1526DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlx9-0005dR-5k; Thu, 27 Jun 2024 06:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx6-0005OA-9g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:04 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlx3-0001h7-0E
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:03 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70679845d69so3370659b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482519; x=1720087319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDmHgwe/yLeAAO02Qn8XqoyaNs3eApAfdC0KQgpDfB8=;
 b=kmXMw0otjom2D0WUcZ0OSB1ajmuNprlsax5k8BSZhui6qBfpc8pPTqCwz+4XPT/UKL
 nKSusrnXCFa92p8dAWVv7OAicBNEFzYrPdhgIFW2/wKCpRa++PQvlomxpI45PviqQsIN
 Xi/HHsVovgKLPVp3j3uoN5YDc8k7mUz0ly/ztSetf/m2JQ77rwSS6qqOtYFGEfgVlFsf
 1hmctu4p4zIa3GRXf1OzUkO6qfgZbRhecwEAeDyO5My1vN5lnkRJA3AY1I3+r2BpSBXQ
 SbwL9x9NTME3brex1QJm9oPSh3qSU10EYwNwE3GGUYGVgSA9+GMKhyx3Thzo+bkYikA8
 xbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482519; x=1720087319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDmHgwe/yLeAAO02Qn8XqoyaNs3eApAfdC0KQgpDfB8=;
 b=ZNgRkAaYEBV7+QTrBRbxbA+CRPgANAaCtvVPGlvMpx5iulhNfa0Vd07SxhmcgnaBOR
 qfEOyb8vro+HDcBhgLfEgD0x0PhzJkh67jKTgp1ZHFnXWorcgrAgrp8s+IkWCyiJDtIh
 oyxRdDqSTr5zkraNWtPrZm52vDu6FFyA7ucEP+EeS55Bq84pWG1vRp/NkhirgCV6eB/B
 xwALfKRaEBWKgLs+aIw3zzTf3FQq6tUKweatUFurgtRdx/mBqnim01qKA1rIBTEUzoOv
 IzHKItuy23pusGx7IOx5yuYvJvYmpkEK8RUDKZ39bh5ewnZu850hYF04/lD+s4IqNtCa
 kAYA==
X-Gm-Message-State: AOJu0YwpSd5cEnRqG3kJ60cHRJ2o36XMU5n83Mlp9+8Na3pp2vYO2trX
 5aUGOJCth+kPohQdKi7hM+HQycIf6EakjgMPxk4MESJ9cj42mxVG5UXKiLdU
X-Google-Smtp-Source: AGHT+IGeyKfoH3ak7Via7nTbG6lxjunFbANvaBtrMPi/NjXr4Xw4d5s8uMJXWwQl4Py0/eTChl9iug==
X-Received: by 2002:a05:6a00:398f:b0:704:3678:3f03 with SMTP id
 d2e1a72fcca58-7067455bf67mr13919910b3a.5.1719482518770; 
 Thu, 27 Jun 2024 03:01:58 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/32] target/riscv: Add 'P1P13' bit in SMSTATEEN0
Date: Thu, 27 Jun 2024 20:00:38 +1000
Message-ID: <20240627100053.150937-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
mstateen0 that controls access to the hedeleg.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240606135454.119186-4-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a470fda9be..c895aa0334 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -315,6 +315,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
 #define SMSTATEEN0_AIA      (1ULL << 59)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ee33019b03..a19e1afa1f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2252,6 +2252,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2287,6 +2291,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
-- 
2.45.2



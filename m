Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9D4C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79ZI-0003Ed-5w; Wed, 15 May 2024 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ZE-0002mZ-Ll
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:53 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79ZC-0006XU-MJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:52 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso3993460a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715760049; x=1716364849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBqdliMEnz302NXVukyGkGL9Vj4A6ULArkG/4ozIHhk=;
 b=jw6J5V1gy7qFGr8680o6OTxCTB4+woXmwgBtwQT3v8OnjvXyXQ9lUSOq/UxOTzJbc8
 TxHyNP2GFJFEW/716sMBemzrPWjdEfRXv0FvkU0KKgZPQlDvZ3J/xY5yYXCR4aJO8MKB
 M+XGpKgxzrfbbUukcE15BM6NtVtMAzeAn5zAYOqwcxYOCODy7uA0CFAVRFHqr/HvF+/m
 iwx5PgxVeu4LaULuAKi5gDtyALgiVQmdO96+kI/pK2TDrQNcsJhWS76dHyjQ/98JJRGo
 Z/4tTxka+i3NQbhQeB4lLwOw4mIaC4+KRpwovj0c+5PDiftXVv7u8nDbJbPU3SueArxg
 2uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760049; x=1716364849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBqdliMEnz302NXVukyGkGL9Vj4A6ULArkG/4ozIHhk=;
 b=mH7iWG4vUSQ52HEI09GLEkXga07kb3pITaIY9Wpcj89qeJoour0Hww3Qxi5Q5S9QB1
 CsPv4L4e6aImgVLKAhBdEviySU56NxOEr/Zf6PLiy+3d17D7DJzGB5AFB4AZb0AOh2FM
 dHisfSRLK6JgglUh/ylro6O/oi7qTPnQVO5Jvk5V1z7GrEDMqFQp4VXT5dOdIF9gybRv
 vvVMMF8ayiF1hi0oj4PSiiyU87qTkG8OGW70fHALYyqskmm0rLeRTcW+ugIeg/by3bYV
 OnFonCUwucm4K1YWL2EM3Kt8pNTfCOS3J0HqH91aozMur3ODUVmYaMWq6TjfFerRwyRj
 u+0g==
X-Gm-Message-State: AOJu0YzKUerY4jJ6FUZtGqduV6GOLyvlhG/n4CIqwFtW7jrPqhJueSk5
 SM5Bg84rXjJFY0fOgRZ6+wJ9Gs1phqae5N/hfA63kp+fuYwJrWQywIE0Qluxj1ZqLwBkuD1WSCn
 yw5id8mpIp7OYKyvP6qC09EVOYiqE9RX0w9YpwWImktWZkt48B5+fw7CIZ3hsVj+1tcyXG/UvsP
 2OW59j4A5xY2cRR+7IR5uTPtHvoA+MNHSu5Bg=
X-Google-Smtp-Source: AGHT+IF0ZVMrPHTHmsmfiZo0bK58t5IXJIUZ/nNUSrps4Pcnm4rZU2iZhbq8D8pzuia1e9uCqsD/Wg==
X-Received: by 2002:a17:90b:1c0d:b0:2b5:46b3:2e8a with SMTP id
 98e67ed59e1d1-2b6ccd76db3mr11925158a91.39.1715760048295; 
 Wed, 15 May 2024 01:00:48 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d1642sm111418795ad.31.2024.05.15.01.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:00:47 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [RESEND PATCH v2 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
Date: Wed, 15 May 2024 16:06:00 +0800
Message-Id: <20240515080605.2675399-4-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515080605.2675399-1-fea.wang@sifive.com>
References: <20240515080605.2675399-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=fea.wang@sifive.com; helo=mail-pg1-x52a.google.com
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

Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
SMSTATEEN0 that controls access to the hedeleg.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..28bd3fb0b4 100644
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
index 6b460ee0e8..bdbc8de0e2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2248,6 +2248,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_FCSR;
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -2283,6 +2287,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (env->priv_ver >= PRIV_VERSION_1_13_0) {
+        wr_mask |= SMSTATEEN0_P1P13;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
-- 
2.34.1



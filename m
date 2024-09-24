Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C75CF9C74
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrI-00039f-F0; Tue, 24 Sep 2024 18:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrE-00031J-B1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrC-0001bK-KN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71781f42f75so5522100b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216284; x=1727821084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNALoGxYT8shTu5z76fc9Bj/Xb/aPmADmGUdV2UZRFg=;
 b=m6sH3iQZXoWkyroPzmoRqkysTGZRuQbSFuYkiuSQ4yla0D6/JlGuSAzSeZ2WIwoHyC
 QirYChhRpLua+eWvTyTfvDBK6zB49HtfT71e9Qr/EPtiE3BcpRbDtNtT7K2hYEFQkPJ4
 N6QT35PoOe9HVR5q6B5PTy5b930+lJyHO9zRwxzc2jlrwO8JYCWjy+oCD1QLDnu7eq+O
 KjNYtzz05qqlFvZwZgdSuuQChAIzhcwdhhkrpm2uSOK35E6zndq/gjgkx1BrT61W6ur6
 QLKJO4FksZR4N1CrDjAZN7NQJyXoMu+wDgCgItnptQnfti23oou8gwv44gyBnzBUJizj
 ZbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216284; x=1727821084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNALoGxYT8shTu5z76fc9Bj/Xb/aPmADmGUdV2UZRFg=;
 b=hN/uE0XjTtqoL7RWEjvHbQlzlheBtlIudyZ2zP5u8GO4lKVvYmJef2J+tZHoIVHWq6
 pRNdF6h+5Py4kM8aiJN8q++I41VESz82dxJNsKRHWlOZc1opjLtxA4Sj2Aa1O08/sZZx
 uOlZNNbUC7eZ5tuE9oATCZuXBxr5ixOvO7S8nVgvUobmTDxVW7cIw/n+FB9kn3E3UZqs
 xHjL8ukzIYfCWqmFEmyYgUwZG78zfwuaTtJVHKqRWg6EKxbTUBWQLUKJ58xFf+sM6Flf
 S+QRGw2vDFKfz7o9LKxVfNSrxUOzvqpDOaX4KaR0vdoJpcx7OR30UZQg2BatVevyMxEw
 Vwvw==
X-Gm-Message-State: AOJu0Ywq3ZyKxAnfLic57WnI2oJYQQU6/SWYi6ph6FszfomKyP89JfSm
 f0HvFX0+YMqfNIC400fSxj4NP0jBErOpXKuFCowuMyT9nzRqOoi35RYVew==
X-Google-Smtp-Source: AGHT+IES2g/ikU9Qe+9lJ0wSLRPqKPvkNFUTX8b/oJSwzP24hG8X9SZDCE+zUdofc6L+LXdu4OrbLQ==
X-Received: by 2002:a05:6a21:164e:b0:1cf:5aba:eac4 with SMTP id
 adf61e73a8af0-1d4e0ba3dc5mr847624637.41.1727216284292; 
 Tue, 24 Sep 2024 15:18:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/47] target/riscv: Add a property to set vl to ceil(AVL/2)
Date: Wed, 25 Sep 2024 08:17:02 +1000
Message-ID: <20240924221751.2688389-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Jason Chien <jason.chien@sifive.com>

RVV spec allows implementations to set vl with values within
[ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
property "rvv_vl_half_avl" to enable setting vl = ceil(AVL/2). This
behavior helps identify compiler issues and bugs.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-ID: <20240722175004.23666-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h       | 1 +
 target/riscv/cpu.c           | 1 +
 target/riscv/vector_helper.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..96fe26d4ea 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -127,6 +127,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool rvv_vl_half_avl;
 
     uint32_t mvendorid;
     uint64_t marchid;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4bda754b01..cc5552500a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2661,6 +2661,7 @@ static Property riscv_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
+    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 10a52ceb5b..072bd444b1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
     if (s1 <= vlmax) {
         vl = s1;
+    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
+        vl = (s1 + 1) >> 1;
     } else {
         vl = vlmax;
     }
-- 
2.46.1



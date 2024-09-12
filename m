Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C14EE644C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPC-0008CY-2F; Thu, 12 Sep 2024 01:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socP9-00087O-6q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socP7-0002xx-I3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so395603b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119003; x=1726723803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98jPE8Nm5XmnYTmie79vaM5ax8offv0h+SJp0+g/oio=;
 b=Afxv0VCtUYpmGXE+E3xiFi4twTPhNAMzS/Dd4zPkG518f6FGPYPoMz75hS2RwbiUXU
 AbinH5gBzwMyHs7bZ9NNyN6oC7Yhcby1JJ18/BTDVkf/iBOE6YhpJXGk3Y7Bvk6uS1s6
 eWJx3C6tN6vX2B5RD+1pJITYt4uMyiXei9vJS9tWZFU+Ff0dljdA7GAea+Tx+hBZuMvo
 Caf+tF4aPrI6kKw+gMY7WREpfdNsVI5sB3lNQmE+Td3DyI5hJrV2Zk1ET4ZsbYjvkHxy
 MiiqAWtWtzJZRzyX/6KTlsiX9h7fMzdkHsHOzMAtYdRV2HlWipxVVylzLOI0f3vOloch
 V5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119003; x=1726723803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98jPE8Nm5XmnYTmie79vaM5ax8offv0h+SJp0+g/oio=;
 b=SIiqhGzesIHAYDLQ6KJDiv1EUpgNGxOkMWWkjXkmYPQ1MN6WYROIwPaNE5nIwF/+7P
 np70AFgmy45YN8XBKMLfkRP0ayYeyByIWsnplcjftSc46JXjL6dWkcbB6+faZXbhE3Rf
 QXIwzOlTKGpgAgtHjEHYn0JUHswVgrINjpixl+h3m4Bhd2Z7d2ezPrRu86qfkXDCF5WY
 0EJ45l+/tUV3eg6w3irrj9My1MlfLOYlMJaP6xD3PHUgdTaR1pEt9nbwRBjyEw3e1toA
 QJor2ieJ1+r5EJCOJKisxfgSlDs28SBfmQvyeKoc61DHV0irlmM0Tt/I6oQcAcGZg2x2
 mI5A==
X-Gm-Message-State: AOJu0Yw0l7+eRclvHqKXrobKt4wFYsXJrTPjQCtR6GXOiOtIIW/Uo2ct
 swfjxKQA0viEpGoWGUTNIf6htD1Qd7MsmvrpSwM/HTGrRd6vEDM0ItWRKQ==
X-Google-Smtp-Source: AGHT+IHFJpVoqRTRqJDN/lRzeXEUecBDgoyLc/B9teFup1hMsYS91/uIyJP48qIzncqFu24UBz+plg==
X-Received: by 2002:a05:6a00:2d17:b0:714:2d05:60df with SMTP id
 d2e1a72fcca58-71926091d24mr2537578b3a.15.1726119003315; 
 Wed, 11 Sep 2024 22:30:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/47] target/riscv: Add a property to set vl to ceil(AVL/2)
Date: Thu, 12 Sep 2024 15:29:06 +1000
Message-ID: <20240912052953.2552501-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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
index a90808a3ba..8f21171ffa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] = {
 
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
2.46.0



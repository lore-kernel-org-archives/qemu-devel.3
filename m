Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2073D1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6n-00012l-0A; Mon, 26 Jan 2026 20:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6h-0000yz-8j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:07 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6e-0008Ch-78
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:01 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34b75fba315so2989044a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478177; x=1770082977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFZpZ49tLdHKzMIaMG0bb7LtfxShsQG9N5JmF1VdHtY=;
 b=CHvv7X/ILnAMFAAGy6QhPe/nCFCOSkXpaATmRwIMiR5QG3Qm6Ct2EVtAxlfKBlW10/
 EHwbEmKT3l03LzfZ96ZOW+XpFHKXt4r2QHftZOU29LP9KsBFq8fCfjVATT1+BI1tQ7i+
 gPluI3XmPR9F/kRCsqoCCgy3o9QH4KJvsOWUSHYhr57MYfKJCOZ7R89Dojct6i9JE2dh
 t/8jpdC1Ty0Hfix1CtMqGxPjl0vhkfy12LO6E8g4Z4na0g7K8OVfFdtZp+q2GcCVZzxO
 oJLx9EwtxDF8S9XTrs7ldYmJi18cPw9AeeXBZxtca6dZ+1CSyi2FG4v2e17WURM1i0iN
 zQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478177; x=1770082977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CFZpZ49tLdHKzMIaMG0bb7LtfxShsQG9N5JmF1VdHtY=;
 b=aASqrPv3YXUQfdGQSe7WfEZYG33fcci3mdSJ9Yl26zV/cotreqAe2zLGOKIJUXnObx
 aTdUnae7spei+CEBhq/wktt7dtMwQAAQtMXT8/LvdwoHmi+9XW/9xv2UnrmEpSXjKnmV
 2C/S1mEVtNvNv4Rjj9btqoqeT9Jd6Dfj8O7ML9saxUBvAd/kmLZ4Pu8ASVwSHDnnc8OV
 o2J9l78DT20OGvPboC9LZ3zEJ1MGBnNV4WEtXk1BozlXkzZdUraMk4tKOh9mHZDCD1ug
 Arnx5/NZuIXQkWegSJYVH9sjFZ3BAeZxlYdv6rCFVFkcuH2TSnAMvs3rsvL2NXkSUeBj
 IckQ==
X-Gm-Message-State: AOJu0Yyf1zLZ4b3IeVq8lIbOYpga2NlzEGgeJtmgJVFoARniOCqG9d6W
 Sk8J2a0JuuDYMmf9apFPhS+EXYqRsxGqu5zq4+4J6ymtRHLERlrXeD/aEtB2fdYai//WTJUsneA
 M5CfPAmWA2fvUavj5tbSmibRB4V574J9Vx3/JT502o+IQDVA23SygOq6oq6JVgqxCrxoZ0hzukB
 0bgwgvK1riDl9RuJWisnoxsBHs11/PizvBT4RQeu2uQA==
X-Gm-Gg: AZuq6aKBs2GyHkg+JOQElZKPPZxvuHNTNWGm/4A9vuHUrlKuF6U+sr7BVisFMCEbsIJ
 zajwHoiA+RyxV/JTtSXgN0VKN/fdCJ/UoaJzbrH6laH5u6iUTa4swKQwK2UeW/PxP+MSnKbZK2c
 nHdy9ulpTdJu7Fo70dX5Dw/PK0bpKJe2Wd8DVcdtV2PUa6YwXpiHV2ktzT8XPGjHeqKsCb93iqU
 Xgp19pl/WLX462q+Q5ioTM+tiMy6zV6CqsjaY0yz9iXE2/4Z9RU91frkM1YupLCKMrc4CEClxoG
 lvOkS6SKiFXVj++Lcb5Qo5/TIJ1UMtLxZaFN1+7yVc3ttLZfIi/a9H6Lnn7aUsIX0GcU6iu/nrO
 ZF0R0KbUSXApde5Jnsel3IXdd5gxILFmwbUBFZifizZB4wydUUpALeX/m0QIyDNvbaZND1MBbIl
 wtU+0l+oMgmpYwN3wFqbfTx9g1V+MFOABeiHMlC1W5SzvJ/Mkhiu5OCRpkYjXAeFeNwBBuSwKyx
 tfW37EwiSOc2Jw=
X-Received: by 2002:a17:90b:1fc6:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-353fedae015mr165599a91.33.1769478177335; 
 Mon, 26 Jan 2026 17:42:57 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:56 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 4/9] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Tue, 27 Jan 2026 09:42:22 +0800
Message-ID: <20260127014227.406653-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102b.google.com
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

Replace the same vill reset flow by reset_ill_vtype function.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/vector_helper.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 525a47bf66..c7b9d6b467 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     return reserved;
 }
 
+static inline void reset_ill_vtype(CPURISCVState *env)
+{
+    /* only set vill bit. */
+    env->vill = 1;
+    env->vtype = 0;
+    env->vl = 0;
+    env->vstart = 0;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -83,11 +92,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
@@ -103,11 +108,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     }
 
     if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
-        /* only set vill bit. */
-        env->vill = 1;
-        env->vtype = 0;
-        env->vl = 0;
-        env->vstart = 0;
+        reset_ill_vtype(env);
         return 0;
     }
 
-- 
2.52.0



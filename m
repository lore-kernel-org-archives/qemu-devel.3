Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB2AD185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq2O-0000dr-OZ; Thu, 08 Jan 2026 08:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2N-0000cq-55
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:51 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdq2L-0003Vb-KD
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:26:50 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso1953237a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767878808; x=1768483608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAts/Z0FTNhdHhzy/9PWHFjxTqh27BRSBirl8Gv16LA=;
 b=IE18EAf143cMglQIDdFNITukRd+rtbommwr/BUVdxWVPWd7b/IxFwR9c/lmx11/ma2
 iU+vOBTFVwFBe7S9lbPBOChe6loBtRp4mSJajN58UMCetXUK8svbVdCmaGLoJr0FWThs
 dC4w7tRLGuu7b1xIjBPuf6jHr64DuFg+NNumcd8QBEj/jk8237DXtYEITA2d5Cv9xYp7
 VuERO9fSxM4F5X75Pv+8R8ucEkg6DyhELPHxYZSnjjsbGqm12LCPTIlhmtXtThSgD8t8
 pIbUznkAgYA8/OspkG1m7HyATZD+Xo48DFUVu/8wk9LMwzBts1Lc++1fGejPnlYxtpq8
 SekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767878808; x=1768483608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HAts/Z0FTNhdHhzy/9PWHFjxTqh27BRSBirl8Gv16LA=;
 b=PGtK+lDOM+noGmAP+/pi52FBHh2OOuhSYPVrxE8TrmEZmGo6n5gC745bhsk3xBPZQH
 fSqKlvmKua9z3/+Ypsr9rMulIGvfA8gSpOO01wbT2JvBgltT2+NL9ZLW2YY/nroo+KYU
 G16yEPG2BWUN/yYAtp4QvsYhd+C2N7/yM1ouWpz48+ULgwiK8X4eOzynAkU4FDq/83rx
 dJcU1NXu8vk9QAqqykC5S6gf2kNMgn8BJBYOzdEPpsEY5JASxt45x94wciWrneukWw6z
 A6NCUnG3Vfy4ZToiIcAf2gICxZQEc5oHI/TwYjxZlNOhcckjjTW56RquFFdGpuQZTaSp
 XeCg==
X-Gm-Message-State: AOJu0YyVH+3cZndn8I5ubq1bvp5ZS6rgnZJqTjjdxWU0MSKsuqWprNm+
 gwzd2LhayXqTXc2QMaUdBoZP9wPkAIkhdHS1gVGtHpaFXxEio6ddGX3fLaxcb9lpvG13hKmQJTJ
 RS3Zn/142kuW8nbV0Y7haiPniBcLchq5e8wH+w6U2vOaCYu7ndVAFvw4unHE1PomWaZejB+Xspw
 RDJYUSrF+VAQXsjLnFsSORE2UZds01azKeikRt7T0=
X-Gm-Gg: AY/fxX5buda9FzJsVQWk0Tuf1vFMN6uK4jwtlom0xaQWWDQHIAZLXK4yc5oLU9xCAfd
 9ZR0YfXGuXyCReQp1ouGuGEFPfEbLB4XwX7Dxv3cA84foY26NXCb5QGebpjbh60gjhihF5XG/C7
 y2366tISSJGA7gMJiJ4Wx40hgV5bJBXjgY37iRfmG27bIXbJgqjcgM86ORgxBQpdwD+wttVvOIx
 HbZH9xEZcgqR4EGfqY8hnYCAOUA7tDSKkR/iSuV6DnIB5lzo+vf5JFxsB7PKK/4LXEY9SyTnmT9
 R4VpZDn9wnv65nPLSpfW3TRU3+mZ2ON7yd/ejwttT+VDPfbg8I6YVaRrALsHZJ0Pc98Qxhi7r8d
 XXT/n12phpza+IufWq9a8UtxxV9XUJA9ES16CugtGfgifSoUAop1WAf5YP6dNH2mAAIo5pA9sZE
 dNiXIqPriDzdJKsGcwgoxn/ZJZNGR1qNI79oBmIhAqFe/xwQeAgXLA/876UM1PCp2Ybw==
X-Google-Smtp-Source: AGHT+IGOdt5QoC6tHghoIWvdp433TsIthVXqrPSqRXDkYClPLK16BMzkAPuAXVA5nC6Rm23XMBNIKA==
X-Received: by 2002:a17:90b:528e:b0:349:5b1b:78bf with SMTP id
 98e67ed59e1d1-34f68d0bc85mr5969734a91.23.1767878808092; 
 Thu, 08 Jan 2026 05:26:48 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6ae3f033sm2298787a91.0.2026.01.08.05.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:26:47 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 4/9] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Thu,  8 Jan 2026 21:26:25 +0800
Message-ID: <20260108132631.9429-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108132631.9429-1-max.chou@sifive.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x536.google.com
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

Replace the same vill reset flow by reset_ill_vtype function.

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
2.43.7



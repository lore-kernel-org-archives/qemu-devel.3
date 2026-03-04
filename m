Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9535EF8FE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEg-0006pk-Nj; Wed, 04 Mar 2026 08:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEH-0006gD-DC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:35 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEE-00023E-Kf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:33 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so7344987b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630729; x=1773235529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fahDgpb+eRRfOL6hXgxXnxO4Za+FAxoup7zF0DRj/y8=;
 b=KLsp43GSRHbH761Vt+hFBUO+wgrPgYVSa43+1A0ePej6D8PJwhaTwMCqqDEi84mePX
 PpO/WjUuNUyL2uAjLBJhvD8Sbri9at6IUbReOA9w1hwyh7NrL+qo+kFLlO5hnHVd4vbb
 X3fSOHLKEA2SvOlSmfVb/DR8aajB/4xtBD+7VEOhpLVRSsGHovJH3hucuok8Cw/9rBsR
 PnCmus3cjv6pXGuqE0cNer6TKReM9vTu8dq5dZeMuuDNG71oV/lzoDfAMj64GcybUSMi
 Qu5NRc45s/c8kfsWpXBDlXuhLFsCVtE8hebWgsYRW4J6eZvXVEv42aGZ8+sedYkUnMUf
 U/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630729; x=1773235529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fahDgpb+eRRfOL6hXgxXnxO4Za+FAxoup7zF0DRj/y8=;
 b=SSbeO8d+uTIIyjD6Y+G+9BwwIg7ntGvXWrt+QKFnqDtZhDL9lAPIzeTWkXGTy4IULx
 m9VuWllFmZwC2If6Zu9V16BP/J0D5KztYb6As0anXCGORjBS6K7xFRJ+JukvYSfPV1gC
 sNvKXV8k6nI1KoQZrvgoUQPdVHdxaD/HDW4aJc13VZBrudhB9gdGaGc+Ip/zcV4jwJO4
 FjGJPw/shjxyx9NQWmHuAQGGTnMOowBm6IK2fg1GmUV2oflsgfIrO4ybzm3bKHwWbXT3
 pBM3rvlaB4/adGY6M1h+rorwfiLSXrQkUW7QrqrcxAKLJ4JNxwcDGdVJFv7T/GlYwZ9b
 Ws2A==
X-Gm-Message-State: AOJu0Yw3/T5+TybCAyNUh986lCmr+oeTnsni+adsvepssyf9jir4ivqn
 U1uRyrVLBkzMurOYIJ2jJqgRT4X2UcCnOTAs4IuZuQV68Ob2109vt7t10hEMuLoKTUGYQ0A0LRp
 dI6cc5toQFgigv7ZydzbV4GZJUWWLqZ3bumgG8GnVTuQOxuEIe3fGo1h/3IokKVkxnlBP49pngu
 vnDAhZiNx5qvgcBnBc4nipAgm7KuLoqB5W6HTlDYv3LA==
X-Gm-Gg: ATEYQzxQQjMRo4ibsoh65iq1FelD25B2HsJ3jrl1iIm2p5VOTyTC4/84NHDhTCOoHyc
 h59G7wIVsC4V6KXT/iLZB5NzpaqI2ymdRfXpsPUWJzDwnMrvZi6LEUUwS/MAK7EtxnUml23+1j1
 fPr/JHD3Q3UEiwIgwKPpMvbvQp6dcjCSq1iPG5ZcpiqSjIJPh+3yrdo5rCLe7WPimQK6QizkoV7
 8LSyOueh1MUYl0tcwH2NBKI1JsGjuJ5uUc3U0X2NQwdrHJJLYyy1Dawk5rzBHhGCIpmriLmvh07
 Q4z99DgNdidHbSqT0XAACPtZVdX8ah5NV7TtYcmvHnCrrOxJpOB+6tOojhsBvSTVyn9Xto/JOs2
 LfzjvBOIltVkPrcUpIWoC5MhfCiPddaaxbxbxIve9g6SOLCDTS8P1RF7w/h57tJvvY/gk9acgOz
 DQR4N0McOQD+GRv3OSN8BLYJQVCoq+PGYnCNujKiTn50hLkKeGsZiHN4HQr8dV7xBpdiOiMCW/w
 7KvmIOuHdkUP0paBWJmLXj/D7U=
X-Received: by 2002:a05:6a00:1789:b0:824:9848:b020 with SMTP id
 d2e1a72fcca58-82972cb1609mr1883511b3a.52.1772630728909; 
 Wed, 04 Mar 2026 05:25:28 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:28 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 4/9] target/riscv: rvv: Introduce reset_ill_vtype to reset
 illegal vtype CSR
Date: Wed,  4 Mar 2026 21:25:08 +0800
Message-ID: <20260304132514.2889449-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x430.google.com
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
index 7575e24084..b7105627ed 100644
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
@@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
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
 
@@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
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



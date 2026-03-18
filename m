Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA5410854CE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 02:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2gry-0002Nh-Ev; Tue, 17 Mar 2026 22:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1w2grw-0002N3-Jj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 22:42:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1w2grv-0002DR-4A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 22:42:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35b95e21ccaso232801a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773801765; x=1774406565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h5HVr6oMXmyyZo/7M7vYBpkPmDpvrpR169IY4RgXgJ8=;
 b=GLekj9WixSVv5nlbjUKZEKbGzsp3Oa9+IWkMg/kftMFj18KWXGAOax21PQlEsBr9tw
 McNeyzEJijyMFhg/olM6HRYN7UQ9Y1M7PyJFj4O3+4Vpa7d6XK/NMRx3m8mnPwh1QfO2
 c3/YQtN4Ig0A/6An1WCNmBu81wJkmt9SvM11vshnKZKqt5qx2zGE8XnJEOY59e/XmBSw
 OU1cQcvsMi+z+RVfylBWmd3GozglaujCGU4+gvnI1VJYCqPf56lZqte7wIbjAG002TmI
 bSYcPNf44FjCVhLk8SaAA5jdYWa8mYhIBqzlTJtWERnqkL/MuA2nM82uz7YTZJTJY0Hg
 cnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773801765; x=1774406565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5HVr6oMXmyyZo/7M7vYBpkPmDpvrpR169IY4RgXgJ8=;
 b=syztBjlQ0aUDAestnue8uvzYjvpcx5/WfzHfPHubWKQYxCP5u4Q6G6vZF7ZwlcJOvE
 3zS66hbFqJV/f9B5gebtpecAzC40Q9DlF3vdjq5Q9rC3u8mGoRYKiSHQXOB/Yaf0oTg/
 mxq8+n2EJ4M1S0Qcy6EeeO40kFb6cL+J9R9Tf+4iLR/Oir1Xw6o4H3q5Ct2JeUVcMTJA
 SFHlJBv3soW1yiVe7IF4Xj4QlOtYNqYexsP15+feW4nW/u64IfBVN1A5MhJMEN9/TwEr
 +ojseDfGNIGisjawiTJBdNBbDdtCSKFcPSnLuf7U67TECyM9hkkDGri5KLAAnjj6cNFK
 kj8Q==
X-Gm-Message-State: AOJu0YyAd1WfKxhdkc7uI4p6UaITaiTIfui3rT+FDhzsw5sjCvn+qJwQ
 f3ahgPDKgORPEU3irPJU57Kv/XnmBXFOOBvSmwCq4PlHXz3mSyicUDaHm2lHpEGE5Pyf3sdxcOX
 BS1srVK4FtbY11R0yHI4/zLD8zRBzoKdwaQJanETYGQMac0SxiOClVY7LzQFLBrtpCyZp1kDuqE
 yTLYw1zZ3q7A+6Y1vFjnpXbBgVlAwNxfHKrPN9rdA5
X-Gm-Gg: ATEYQzz83dTkzLKaYP9OSWs9zMPVp/zA+JA8cMraUNtgNwjlUYXeRDBemo9ePvuaWga
 cKEQMQV1vBrtwBm1gQwKdPUyOVSodQEztc1yey8+wfM0XQ6dgoCCi/fy4tZZ3rc2pE9mf8gIlld
 wo6ryAZnXzBIVF1B56hBVOQwmjivUfKr6LtCaSz60TvPDsL+e0cn5cp+HUUhlUgLGz5/YgihG9n
 60F6AGUMLKjqSuuLYOLYIndbPJ2uL8mAgG/6dA19s3F68LV4sgSlYggAN+ScYVZjwT9NR7fOUQn
 FNa/yTc5Ru09V1zund7Nw/aY1BOe35iyMLPgwj30+6C3mfsBGE6XcUWqQWvjRO5wsekwEhd+Vrs
 KNWVPhpl/KBjs/owoQ2WLNbUsgnLLGfGJUvZfeFYo1vgxsYbMbdl2ltf35KQvmC3eA66oevrdI/
 C0pe8N1XnBPd1w5JCotGCaHbdK3h1B584ZygFJwBZd/w5a
X-Received: by 2002:a17:90b:52:b0:35b:9d0c:a2f3 with SMTP id
 98e67ed59e1d1-35bb9a41281mr1478191a91.15.1773801764524; 
 Tue, 17 Mar 2026 19:42:44 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bbbedd0desm462732a91.4.2026.03.17.19.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 19:42:42 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH] target/riscv: Fix scountovf CSR behavior in VS-mode and M-mode
Date: Wed, 18 Mar 2026 10:42:34 +0800
Message-ID: <20260318024234.2772480-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x102b.google.com
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

From Sscofpmf spec [1]:
- In M-mode, scountovf bit X is always readable.
- in VS mode, scountovf bit X is readable when mcounteren bit X and
  hcounteren bit X are both set, and otherwise reads as zero.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/src/sscofpmf.adoc

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/csr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5064483917..a75281539b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1599,6 +1599,7 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
     *val = 0;
+    bool virt = env->virt_enabled;
 
     /* Virtualize scountovf for counter delegation */
     if (riscv_cpu_cfg(env)->ext_sscofpmf &&
@@ -1609,8 +1610,19 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     }
 
     for (i = mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
-        if ((get_field(env->mcounteren, BIT(i))) &&
-            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
+        if (env->priv < PRV_M) {
+            if (!get_field(env->mcounteren, BIT(i))) {
+                /* no mcounteren in S/HS-mode */
+                continue;
+            }
+
+            if (virt && !get_field(env->hcounteren, BIT(i))) {
+                /* no hcounteren in VS-mode */
+                continue;
+            }
+        }
+
+        if (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF) {
             *val |= BIT(i);
         }
     }
-- 
2.43.0



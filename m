Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1961FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwto-0000YX-A4; Wed, 29 Apr 2026 00:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtg-00005S-Om
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:40 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwte-00012W-HE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so8097351a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438297; x=1778043097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ius4D9M7tl+j4IAM5LwiK6lcQnEKNl9qLPhtJSpOtD0=;
 b=V1zW6E/9mnM1MTSMJnWNxPa/86oQfwP7CQjaWkJIrX8d8mfHCTMhl1j1zNDCTMvoUq
 cOxLXifOkGarDC8SrvNhcx5kNTUD5I9mpQXLkK9aT9vxNsIw6zNcgGzXqroXsQaAWU/o
 mTgn22NcJVjXJlrWbi7Rj3oXfrZ2Kbk4E6YZOy4OulRDVMSMqRTsXQDdqdHsVeR3bN8/
 /8ZmT8G9U+tp03m0aK8aJfulaV7mZfD24Z5ji2EkxKlbmBIIsoReIirXeLgkRLxf92st
 hahUJ9pjngQwn9NtnZl+JJ4jL027aLmo/BvZuaqvNsj1tHhA6Wq8H7KfH4KUoVauiLe8
 06fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438297; x=1778043097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ius4D9M7tl+j4IAM5LwiK6lcQnEKNl9qLPhtJSpOtD0=;
 b=iCJ83auexpczMpd8BhKdL2l/4tNUTBT84TexqLeKDHXYcJwQplFKF3MXC4kb5nhTLt
 wD/MXwm7AOyVmSBxzNVXAHUKRFmQ7Zt/JcojIyRjtFYqWqLKwXCMj1PDt0wKH9KeMPey
 LgLjnSwKl9kRixR23+OV5QigiazvgzfZe1DJn3qeITxdu4dxe04vkpKeStN8H0t+Fr2l
 0MpLB2WK+TujpJcGHQXs9EWY3a7A1/3zKU4aLwu1KEsZZsd6lCXwLUTHNVNlG+iAMyH3
 DJsEY3/v43ZMAZtvuopa1QYVj2w+JgYcAkHvgIl95USzYGsMzpTGLCTkjJl1V/bflbtn
 tieQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TgxvNIclvoTTY+YpaVx4YzCEPBc7ChDq3gkBM4W0V8DwBq1/LvBWu6IC9uV+BfKhiTpkq0vCGqwaO@nongnu.org
X-Gm-Message-State: AOJu0YzJhVTg5QpzBEh8GAb2ufvxwjd2Gu31JVc6a54szd5ohK38asPe
 jF1laR3GAQVT1hUiZXRpgoB+IKBrk59tzo2DG2d3ljFwWEwyGwSAwW7n
X-Gm-Gg: AeBDiev2Wt9dcCaMDo1Q1AM4T30pirIPYYCSoB6cLXpyiGn1htvI169v981w4AendRr
 MX5F+9WwyuFMqnaAc+72CksVbjS/GRO/x3I1LP/jUfFtnGDwVBIWU6v6NcXKCzMaOU4GhORLggO
 cwLA+4bUvEsNn5G2KKjtFmgmEGPdV2X9mfVogZEcAZtUxDfP3bqx4eX7+OKJBS2+i88MoysQvIC
 96TP3VvBuQQWZGdncJTVy+x8GERBh5uDCnWXYo482tFHJMbgOfUdTpJn8zPpMQno9VNWEa+FObZ
 H+FjHQBaQtS65U/GB59jcLE8QnCS12iQabRgKr7q5po07emG+U8Ze4y47z5FJpoqHao0vYrcvkv
 B9uYWb9ZfHMQvD0JGNWMIKbfVx0HG9/p7feW+jXvVnaq35nJFJIPoy4wh+lbHJTNhvtWOWXcwhB
 3gtwVrkSf/liM+HyWiM18bcv080GtUiyRShcLXD/h6s1e8bsrwFwXdRwjrCfsFfBs=
X-Received: by 2002:a17:903:3c48:b0:2b2:4611:5dca with SMTP id
 d9443c01a7336-2b987407ddemr20967845ad.24.1777438297017; 
 Tue, 28 Apr 2026 21:51:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/51] target/riscv: Mask xepc[0] only when Zc* extension is
 enabled
Date: Wed, 29 Apr 2026 14:47:42 +1000
Message-ID: <20260429044752.4176397-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

IALIGN is 16 when the CPU supports the Zc* extension. Only xepc[0]
should be masked when the Zc* extension is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260421074940.2916287-1-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b001cbc080..ab8dea45c9 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -173,9 +173,15 @@ static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
 
 static inline target_ulong get_xepc_mask(CPURISCVState *env)
 {
-    /* When IALIGN=32, both low bits must be zero.
-     * When IALIGN=16 (has C extension), only bit 0 must be zero. */
-    if (riscv_has_ext(env, RVC)) {
+    RISCVCPU *cpu = env_archcpu(env);
+
+    /*
+     * When IALIGN=32, both low bits must be zero.
+     * When IALIGN=16 (has C or Zc* extensions), only bit 0 must be zero.
+     */
+    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
+        cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
+        cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
         return ~(target_ulong)1;
     } else {
         return ~(target_ulong)3;
-- 
2.53.0



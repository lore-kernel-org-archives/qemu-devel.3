Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7914BFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwuD-0001FA-C8; Wed, 29 Apr 2026 00:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtx-0000rD-BG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtu-00015D-Df
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:57 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c79467f124dso4537957a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438312; x=1778043112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCn+ToTOdAoAqsdxgqAQs8i2tRaruwvkYVx+22xQbrs=;
 b=iGecLGdirPNV97WzxUlj4NEpY6HuPagA9ZsflScUIQycr5Dvm5Z1dcCbmw+oYytT+H
 lKIVV/S2HxThjKvd6DUWkoUGECnZhkI8oQd6J+Wb6y6iRufG22RZSYDx7urG9QiGBO+B
 VpDBU1OfmVj87KApr2XWMSeMgW5OJwTL0D89tjyuQZ1oIVS7wnxrPNcOIY/OSiUwoDxi
 +mUnqGm2jvsRxzqYWNo3r+Ej2PnTNc6NaJ5/PVXapZnwlTjat/1oe487MKGkVoGRpsFD
 z0wL5ODov9ZJS5fBNoHFRivNUGJkbu7QXG5Pvp+hFesTeekCZlEtyfnAWQvPZi1t7TBO
 PAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438312; x=1778043112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCn+ToTOdAoAqsdxgqAQs8i2tRaruwvkYVx+22xQbrs=;
 b=TR8AbfU+ZaqxYRSNOw+uaSAP6oEYz5TG9dY6yeX4De4TF8azVnc8jS/ESTbSRY18U8
 Eyyd4fw4QbG19Yg8fVFWAmF7z9JSSEWG946tIpNiNoWky7ozXsWMnEIq35Xvj1Z7WRV6
 +PPGumLwKiwe5/TAYBnfqzY8ZxGl0PoZuWJ3GQW92++ZuZakvehdhE05PLRTQJRa6pxZ
 PscAUNw4jTgNFqMKPIljuL8PPEiKf0pcreToVRTrRvvwVWu2eNTOzIL1apYsbyAjZQQS
 RGxBDKAQRlX/7vfxx2nitGYtskzjAd87KFCp7O2XxgWQpXWQeFJ4C2gz22qyVZHwmBWY
 dyZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y/9REC3bR+Yn9ed/RrzlbZ8lYDth+EeTroB6bAby08v+E7H6B35S+FRJhZ6OumFHv0zM2M8NZ/aO4@nongnu.org
X-Gm-Message-State: AOJu0YytJX6UnXrw6ngFRwi8wt1qcUw+0xybFmTgs9NK/p28S0vQBdXI
 iQDhEd3KRCB2Rm7OtAFlW1EeaikaVy+ruObNwUOjFF/fgquanTjRm00H
X-Gm-Gg: AeBDietakipNRp4fLRnKEPzwR2PgPCjHs+JyH8YihaQhyGJW9h8RZXZBo9pf3WLJ1NH
 8MXmPvEUFRDh1YpI++FvTW8EjGlHTrHM56vaL0HP2Skp7+nGVH5WKZtUZOlFPK0hJ9J7ycTnwQR
 KAjJDWr6Bk1H5QWKblVa0I71SPn+3FjsQFsWNghL9pfI2cwOTWwETi3UnosdcoSWWxF2MFEmUrC
 aQXAdFJylKmUr9k/tWBjFQs78PPcAkKiKPX0NChE8f9hQt+M7fk0M6qugdUr/5OS6IO1REut8Gr
 MJwz7bEFxy6idrCeBJoj+3yO2fWf7XQhASnDTMR9g5TLhTh4SMHe/JslHxX3ZyEdxxHKXYjMBFF
 B+Wq5t8A1X+pEPIHMamjK/ynzt5D7uRJhrRlwOU8sQjjPuYviqiE1HC3tFRvz3x6+L7NxhW3jsk
 OulpN2wIgGZBrUaze0KPfu9TkW0bh1+hCA2jRTPjb0Ezfg8xZ8FWw7
X-Received: by 2002:a17:902:e34a:b0:2b0:4579:ae6 with SMTP id
 d9443c01a7336-2b97c4cb993mr45089105ad.38.1777438311922; 
 Tue, 28 Apr 2026 21:51:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>
Subject: [PULL 44/51] target/riscv: Use ELEN for Fractional LMUL check
Date: Wed, 29 Apr 2026 14:47:45 +1000
Message-ID: <20260429044752.4176397-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states that

"""
For a given supported fractional LMUL setting, implementations
must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
"""

We were previously checking VLEN, instead of ELEN, so let's update to
check ELEN instead of VLEN for fractional scaling.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260415233740.3027321-5-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 538168efc9..5a3554dd71 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -70,18 +70,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     bool ill_altfmt = true;
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
-    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
         /*
          * Fractional LMUL, check:
          *
-         * VLEN * LMUL >= SEW
-         * VLEN >> (8 - lmul) >= sew
-         * (vlenb << 3) >> (8 - lmul) >= sew
+         * ELEN * LMUL >= SEW
+         * ELEN >> (8 - vlmul) >= sew
          */
-        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
+        if (vlmul == 4 ||
+            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.53.0



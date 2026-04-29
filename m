Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C9FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwro-00034m-GB; Wed, 29 Apr 2026 00:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwri-0002v0-Nk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:40 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrg-0008Sr-MI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:37 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so10202288a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438175; x=1778042975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NI1miOV7mrsZ3JQDa5kG7B4WvfyBv1kO+i190i8zle0=;
 b=jB6tx6oEzngKnav3NNjAilL4lbDzTC0vlZWcm9yeNqI2WGBq667oZj26X/wnfYXQNQ
 OlfQCA3auz8DHw4N9zCB1mQjO0lLpR7B7WeE1lAYAcfFRlGIJQ4zDoZMiHInvEDrpQ2L
 AnvJ5MPpSPnWyWMWHUz3OWsmpucXwUI3/s+EYtfkSHmyuZxkk8sBgEOcxqETO9FU+AWk
 JiOX20lzaaeb6Pt+Ldxxtk6qI/pnvjD7bnC7LTgT4xd46mHs+cke9bX6uKb0Va2pJSgh
 nVezVoIg48RRtsOa+9gxE4Em9A1pGSBkWLZ+LSouLx+lARaz6Bn2FLc6LPEjVEju2mqj
 EPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438175; x=1778042975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NI1miOV7mrsZ3JQDa5kG7B4WvfyBv1kO+i190i8zle0=;
 b=neX+4P5Q+rwpFGwpWfoiVQUVMTh+ilk3vgCVBeAAfe1coCuebv+Uei1GgAzB/V+NB+
 v7pxHP74+zIKBf0u4PgcTaGMuJ9OlD4YdtcHoL8tgxNmfTGsKwLjrfFdcjCQAEnFq0xH
 +Bh6uso/5/Evl/gC/hTn1ivDdE+AnuB9ZdFB0xORgWnBbTE2cRGbcLsjDvYyLo1beQ5s
 /UjPfLRnALBK2a1I9BLELR+fa+qbV5Os6c1uQjP6g+zwQmkJ9+OEiXmSzjJfLUz3mz2a
 k1g0mrhmWw5WTCg0VhKCYwvh2lpuieZvdkPzXWHltXGaen+49OruH4hu3Y3C0qLg1O2Y
 Lgmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8VwShJmYVh9HA4WgBFiB0g4o3P99x8BHIxZGavHHM5xRSgf0eR7hXXFSTBLrnXd6i5yImAOvqgAzB@nongnu.org
X-Gm-Message-State: AOJu0Yy8Sck5d02KvJ0VSg8B/tW8Z/H45piEYjQHq4HEnKKpmHmja1Az
 jDNEmxMjxgJ+b16HJJEHvz8aO9gJobR95P3mmQ0A+8DRbdTnNvA8fcwA
X-Gm-Gg: AeBDievnQp2hZc9zICcfMRsb2xrfm3/cE8MnFWFYN5BDIkNz2o75hcrOpv1xRwCIwVB
 BLr+CKEf4SuW76pKtmQtTIkrRabrJAak/PdUhxBO1ISdOx+Hndldx1M4pAwxtBCMukBSrkP87z6
 agBOge6W8vegWEPb8rv9qtLJsCDQviOA1X0BqpvFyu8DtltdKiI6tDBx9dqdHYhieU4bczgHv9w
 /Vs8EM9XdwVNp3/jovIdIaFKoKciZU5e/uP1qlKwB0fWlDL3aypVAuXyC3vJDUZhXMj9jA9K6Wv
 4/NvDLYCi3sfbK2FtPyphi+AI3ZV/kNBjhUXr1fmBPYR1npemqmevViVryKHwuIqRnuOE7lyF+d
 Z28QchvOi/JwuyGgBi3hyLAeF81syPXlT47+aHSZLnWtxuQbiI1Vvccoro2wjCnWjoOzvCNxw1p
 Tg1WQ1zAX/LwayjjMY+UG/dJuCC+JLekbp352Ut9n3O48bpGIfFWlq
X-Received: by 2002:a17:90b:4d:b0:35a:1762:92fc with SMTP id
 98e67ed59e1d1-364a0f61584mr2369199a91.26.1777438175286; 
 Tue, 28 Apr 2026 21:49:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/51] target/riscv: Replace MO_TE -> MO_LE
Date: Wed, 29 Apr 2026 14:47:18 +1000
Message-ID: <20260429044752.4176397-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We only build the RISC-V target using little endianness order,
therefore the MO_TE definitions expand to the little endian
one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_LE/ \
        $(git grep -wl MO_TE target/riscv/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-15-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 2 +-
 target/riscv/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 860c47732b..460346dd6d 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -71,7 +71,7 @@ static inline MemOp mo_endian_env(CPURISCVState *env)
      *  - MSTATUS_MBE (Machine-mode)
      * but we don't implement that yet.
      */
-    return MO_TE;
+    return MO_LE;
 }
 
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 711080f3fd..1a25c517a2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -135,7 +135,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
      *  - MSTATUS_MBE (Machine-mode)
      * but we don't implement that yet.
      */
-    return MO_TE;
+    return MO_LE;
 }
 
 #ifdef TARGET_RISCV32
-- 
2.53.0



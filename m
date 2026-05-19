Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F598CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNE0-00070g-TE; Tue, 19 May 2026 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDy-0006yr-R0
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:18 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDx-0000qq-8c
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:18 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de7dc85b74so3776372a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207796; x=1779812596; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1VoRlbXkR15d2ZRoRf7gg0M4ZU/RzYT8g2aQHKJbRO8=;
 b=Ok2OqhR86UiMTVBnA2w+kwHus6XeUDtC6zurIHUeBWYsOs3u5A/fKxkrUrK9HOpYf/
 CxYxa4rBj/7Q56KCH8JZIQqPZDkkmYGTMmtx/U4g1O833YLKWtRMcUnV+QZ2Uqp+h0mu
 VxTskxGqeroYPw/kCMuwXa74KQLTtkTQ2o8U1ScVOmwuLrAgEtj8smRq6kFGyYQnZyJ5
 kndudJ9Af9zIu6amqmW816TVgkBycYZzwt5oFh6ZDOYwUBb3cI/WKvG4aZcM01X4Cp6l
 gIyqxCEAQOKhnsMoqXjm8S5Wgd92HmdzMZOsWN8xv0bEmcdoMFAu2NhXsPADwpP14TfK
 WYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207796; x=1779812596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1VoRlbXkR15d2ZRoRf7gg0M4ZU/RzYT8g2aQHKJbRO8=;
 b=g1R/nOpP7pF0sfGfeMdn1ZtLHmwRw0cCDW8h4GglImaAxsYZJ+bIHPgEyTeRWbLaQ5
 x907BdVAZGjeCsavgB5h5U/jYC5z0Z3qFin3vOADtKqTvQ0UZ2reUahv4aGJxeVniFEZ
 ny8rrBmGV9OpnQ6HZBy7FPmrREXidatb3z9N1HQtxGZ6RaJ9WqHIiBiPVEJWvufmHvEh
 Yk6vq4oln7pS07mz3rFkJcv9EjMq2zf4s2B6m8INnOxJolrBoRydrpC+Zg3yFxzAS78a
 XUqTxIijtfEIAWTmWBhZwZP7NLTnL79uyZM3TrPy9UNGqJ4pm0PD7L8ZaqrUo7Korsbh
 HyfA==
X-Gm-Message-State: AOJu0Yza3OPtFQGGdqLMty5HfRC79c3YSC3mk+CETBIl9fx9TTp5+SE9
 nxjfTqx96TI5fW3XksUS8GsKoPMq6yML45qhd1zshnUJPcZhP5EgrYCw
X-Gm-Gg: Acq92OGXVFsdcx548iSHVs2vAtBHT/D19o/xOA8txV7CRUyQ9WBToewpRUps/88eX6R
 RiNrejDJyw42V0kziTudGBdYbhOisEIUhCcwTV/XnMeORLqIws0F/FATWDnA7E7E+0XIWIkOkdm
 y74si8UAktXVYLQwvBjVMbuzSsC95l1k8g0+QWOTFAGkzuyf4QViTPajJlHxM1ze79nUD6syxGL
 lCKJRd7O6sKk2p6BPZ1OPIEJT//zD1W+0ZjCQvQGUAH/JOXJ7xB/9FWRWwdoyXxSxczCuw1TQIB
 AX4XKHPzSZaauYvxCsu6QWZHs8IFrV5UAMbYHYojoMkgrav970X9WgkSrfhs/ozLw3p9SbvGMDJ
 8u2N3W3CbG4uWSYOni2cGFWSTOfpBXvnassbpReZFBa4FNK6zQ4gVdcT0rx/dEEk1A/ONvSEhG7
 AE7hFMywGYMVrcBgiC6bhPrMoP34sYtZoa2F4aTRuUIYgEwX7XYJVg4PjHw5iVvDvToGjRROjBS
 t4DUoJlMVCJER/40gZkm3d8mnG9CNgvtac2vyNsRAA3q3lB74nENwd6yWFR15JkAbvq
X-Received: by 2002:a05:6820:2004:b0:67e:1be4:d8c6 with SMTP id
 006d021491bc7-69c9bfe5dc9mr13034106eaf.58.1779207796017; 
 Tue, 19 May 2026 09:23:16 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:15 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:42 -0600
Subject: [PATCH v9 40/40] target/mips: expose Octeon68XX floating-point support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-40-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
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

Octeon68XX cores implement CP1. Advertise that in the CPU definition by
setting Config1.FP, enabling the writable Status bits, and providing the
FCR0/FCR31 defaults used by this CPU model.

This lets guests observe the expected floating-point feature bits and use
CP1 with -cpu Octeon68XX.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Move this CPU-model correction into a separate final patch.
    (suggested by Philippe Mathieu-Daudé)
---
 target/mips/cpu-defs.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index faefab0473..cc1916232f 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -997,7 +997,8 @@ const mips_def_t mips_defs[] =
         .CP0_PRid = 0x000D9100,
         .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
                        (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (0x3F << CP0C1_MMU) |
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
                        (1 << CP0C1_IS) | (4 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (1 << CP0C1_DS) | (4 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
@@ -1011,7 +1012,12 @@ const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_ELPA),
         .SYNCI_Step = 32,
         .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x12F8FFFF,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .SEGBITS = 42,
         .PABITS = 49,
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,

-- 
2.54.0



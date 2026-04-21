Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C574F327B6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5ri-0002yf-Lb; Tue, 21 Apr 2026 03:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5rh-0002yA-EH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:49:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5rf-0005lG-Ne
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:49:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so34748045ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776757786; x=1777362586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7cYW6KbF4poXK526aINabHrFRHqhvoQAAEkXMo0P2tU=;
 b=hY+ON+UML273a1mkhE41m24RNhd+B0w3p4KE2xRPi+NisGarUVbNKVkjtM3aSOCvVr
 ChbOxK3o/YHr5CPHjLIUPIHHXL5XlLi0AQ7Uts3TmMn5WzB8wIzkfBICzdZu4BVHCtXP
 yxOWJfsFSvAwURryQOAlKafq/BiW9eWOLn7ApJZQ9p6QYzwBttAuBXJ6uCTMz7PfRIN4
 bcW9zAxPJhyrD/kdBhToj+XdnqvBGwYo42Jl05CCQ8JcOveFnD3drxIYUepLS2nuaSa9
 tEOOGEcUKuNziBSCP4l0HwDjtKixEJNqJyYx61+LqMEd+gSvr3oJr/ozflBEuGVdr+8P
 NEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757786; x=1777362586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cYW6KbF4poXK526aINabHrFRHqhvoQAAEkXMo0P2tU=;
 b=BhjDcjkUoxdydIxITxsaB0yK+RX29G2J3mtaii4zunQytvNsQf5nI1Au8BuXHGWKIx
 +Aaxn+u91SlvI93xIvTeTT4/ZrIyMoiDk92uY9UVjPSuogZ3SKF/PjKmVN6EGVxHBUOz
 IIdLcCUT5+xJ24un9Nl0r74fPPLZRvQG4YC8ujUuto+cZehfw0Qao1BXJPxvITat6XEz
 TyVAR34BqrMn4TEJIgpaB/Ub+wnN2NxPe7ECzyeEe1ZWXOrCF9K9FuMm5JxvVb8q2ciY
 RxSmPqyfzcJRZ0OGjYzu/GFhuBeNBAzvtOEzvpO7wQCwLmMIZDz7wMPjXgoM2FdAl4oo
 ypmQ==
X-Gm-Message-State: AOJu0Yxh/kj/lE2YbjGFFktNTGtnobTjtiIr4ZmcNfcsVVFVBPmFD1LC
 vGEsI72kg0MRPFnK3jGJblPWAtvtx/v9LMOrMVdMfICm6hNvQfq4W7Q83RmneJqaKnJScGaiJ9t
 04Up8KFspL0YA7Dfo7IpPCTEZyDMUkNqLTQoALMkfuZ7eBZtKA1rWNJopjJOMmXyb2Qh4i5Xpog
 chAYJFj1GDT5etIraBfo/X/KSyWUvxGRo6/InbIeYwS28WHGOZ
X-Gm-Gg: AeBDieuZ+BhW73l2rj02JkpSS/953QfA2+h6VoEyEbstTpKu0cohsfsUTWG+UWMTV6P
 esrNgLAKdmqWh5E2PmJM+8x7ApdF4h0kKdVObCw+O9r5UpQUgXrI+0DB57TTcweGGpTCTta1WU1
 zB5/O4fB3cKBm/XB4Jyex0joCt6KLBhTFEFw3BfcdkMxuWmkRETM2cvVsXtOyU2xG+WDlZdgja4
 RvIQG+dvLgTGRCo5Sk9acrJGR/7V84+YQubw7XTt+WIPJXXlKPVKxR/OUXxtB6SUiBf4i3gO4Ao
 Rlu/lijp5ER+9IBLnz6Vv/DFubdMiK4sCcZvhdnadBHUh/uPdcy57oglNcUubcVCpU7LCZippEK
 3girK5+RFnN35ESka85x6MGA1tyHi3mk4NReqlQZg62LbDn/3AV0+Yo/25yucxl9zfirKc0vAvu
 56qiP3XQiDrUD/Ry1wuDVYr/PCOzEQHtuOY0zeA3WBbkagOHkU1HJk36UBiIzP
X-Received: by 2002:a17:903:2c0e:b0:2b2:9a70:3f0a with SMTP id
 d9443c01a7336-2b5f9da626bmr144255735ad.4.1776757785545; 
 Tue, 21 Apr 2026 00:49:45 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0dafcsm129947685ad.52.2026.04.21.00.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:49:44 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2] target/riscv: Mask xepc[0] only when Zc* extension is
 enabled
Date: Tue, 21 Apr 2026 15:49:40 +0800
Message-ID: <20260421074940.2916287-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x633.google.com
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

From: Frank Chang <frank.chang@sifive.com>

IALIGN is 16 when the CPU supports the Zc* extension. Only xepc[0]
should be masked when the Zc* extension is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/internals.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index b001cbc080a..ab8dea45c90 100644
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
2.43.0



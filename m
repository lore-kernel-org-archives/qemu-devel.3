Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9834CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWP8-0004UV-Np; Thu, 15 Oct 2026 21:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMS-0000W4-Iw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMQ-0004JS-EB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e6038cebefso44430375ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112627; x=1792717427; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gxeQ8ZkuHg+ukHo+g53m13SzaFDQUPDslx+/Bi6z9vw=;
 b=rrG5njO5+fI0j8em14w1v6OYF9uhKeEgSRFVedm1g4kXbZzcgLGzJhO9MVA/FvUFty
 Cmx2btj0XcnoRUjij3jYqzGbOGVi7s0HNzthb6CXqp++jRplrzAOa/iXLPycikZEJk95
 VcJFyascWXDwqSTjFtL6gSwe25PXPEk0uAuQG7LyWIT9jxjcncn59fklsk8LGisAb+ZY
 qK15jF6FlXBgZsh74Z+fFUfsXlpTFgK6SCH5eprRnFYEpxFvDFe0SBvnXfsGhQgTEJQD
 Lf3I55UWiUusFhlh+ZnMFgPtNkqjl/x20OQcfmZfbLn3FJf+X9kMFhodkRZ/njs0fAl/
 iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112627; x=1792717427;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gxeQ8ZkuHg+ukHo+g53m13SzaFDQUPDslx+/Bi6z9vw=;
 b=sFXzdHY62WQzbdF8T0pDqevwSYms8BEi3utMDghC/Sp0uvluQUi33EiQsQWXY7eMFz
 Ve82hnenuA4GEvUgMCLX5RATCPhtrdFsVO4mLJj9bVvj1NLf77xmVqvdCn46Cmqru36O
 Kw2gyzQyoCUHcvQgkJ1+Z+LbGohw01wBONGMa5tIhN6Pc/jRojySG16p4fE9kS31Xrq9
 wYsKHw99br/feoT4tSez+/eHRdokbWZsaQwtdmFPSjKf0Y0anXYSnOwYabW0iF5PCDEf
 Kw0ds4V7H0cKRmWXdR8l7xDInM1cATb34rrLfi1FoLopGEbAbHYLbGtLdZM3GVqYtHi2
 fXtA==
X-Gm-Message-State: AFq9FYK/eOroFzhptHwC8S84+6K/6fPKbvEQ5VAYpUTFapVwkFD0haVw
 2bmgV+1haGa5yynDXJhcz8iESQpJzcB/l6dGenoIeA3BY01AzHfkVlCJ/2SnhA==
X-Gm-Gg: AYBFou3Lh9MpbHd9iXzcbt7JwmlX0skw1MkiH6LfSNT5sde9UhQQU0YmuFQsWu7Nhrm
 7XMF7mslVzE+vni1gxKTMIpP03kN9lLjAGWnegRtOTwXxFzKziBC1i/FJNg868UzkvihF7xlmLU
 VQpm4rvRxR+opoKVZieSWAZvS979lQn7ip6pN3U7FylzzW94oiVoyRTSKufMVcGEEFk0yD6aOED
 X8Z+oVBtujUgs++4gGaKCLy3IL4BmtkHnGq2kvQ3e7M3U4Uz7I5ODBCS4gD6UMCKrnoJMp30iWP
 k/V1gOFeyVrJqSzTMPrlesm/R0rGue2323eqB2AZdEsh/U9U0pzZE32RSIWua6ruWINoafp+Nmv
 A15jmMtQSpn13pQEb2l96xO8H8I94ZGKKOxvZTa4HJl4NmKMNNvNCAZruRUxwUgt/3W2EcR5844
 wzSp4Zn6Sc2XvN0SUVkKjNaiUvdXfwrEnE85ss/3/un9Nhflf157vrVOMBi70GXZCdD9kqC4A67
 zV3otlzID5IKvLj
X-Received: by 2002:a17:902:ccd0:b0:2e8:5202:aa8c with SMTP id
 d9443c01a7336-2e85202ace2mr168987535ad.48.1792112626719; 
 Thu, 15 Oct 2026 18:03:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 21/50] target/riscv: Access MIP atomically
Date: Fri, 16 Oct 2026 11:02:08 +1000
Message-ID: <20261016010237.1102834-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Make riscv_cpu_get_mip() read env->mip with qatomic_read() and
riscv_cpu_update_mip() store it with qatomic_set(). This makes
MIP reads and writes safe for riscv_cpu_has_work(), which may
run without the BQL.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-7-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 3 ++-
 target/riscv/tcg/cpu_helper.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8d6f992ba..45e82fc30c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "qemu/guest-random.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/tcg/csr.h"
@@ -956,7 +957,7 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
 
 uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
 {
-    return env->mip;
+    return qatomic_read(&env->mip);
 }
 
 bool riscv_cpu_has_work(CPUState *cs)
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index f03f149a66..58901bc3d8 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
@@ -584,7 +585,7 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     BQL_LOCK_GUARD();
 
     old = riscv_cpu_get_mip(env);
-    env->mip = (old & ~mask) | (value & mask);
+    qatomic_set(&env->mip, (old & ~mask) | (value & mask));
 
     riscv_cpu_interrupt(env);
 
-- 
2.55.0



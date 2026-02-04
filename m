Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4573E8B38A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 02:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnSfc-0004AF-Dd; Tue, 03 Feb 2026 21:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vnSfa-00049I-P6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 21:31:06 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vnSfY-0000Oy-39
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 21:31:06 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a743050256so40230915ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 18:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770172262; x=1770777062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sBNSP7pWMOIu/H9JEVCg9qlWgOq5ASSmzfH3BGFRZJI=;
 b=a4HEr10Yk2fhXnEDL8UGAggCWnDlhthMMdOBqpr8SgTGeSRdumiu1DI5d5AJGz5f34
 lQrO0GqQ+kU4n9Q0oIQbNl8W/xPLpwe1c2yxvKBys9hvx6QUIGvi0Q3YljKPqjzd79ar
 JLrcr+/vOX54MxF5pfUxqwtpDpdZsBsZph35nwu6+6kk/jqB1YsvTdFbgRqQGSgUiYh2
 vsX3E6SbXroE/X7lYSJBBh4b+afWUi9YB1p3M/i7rvt27NzJ3aFwQegBm43OOgUfUjwS
 VzXnkHTkc6ev6RfqqVT1eGfqJdGMiIahfkp2RZt+fATGFYFB4usByrgbMCtthp0MJsRt
 YEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770172262; x=1770777062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBNSP7pWMOIu/H9JEVCg9qlWgOq5ASSmzfH3BGFRZJI=;
 b=G1dmiaccjodTlpGNERwxgORuaC6mDtbsJ2jP9k65xxbLt15Zi+tjsClrCNcEiRCZdO
 6drBc3thSxP346UmVhsAD8Wz+m2Kb3vg+JZcVOWqebRMtGxwe3jMQwO9pjDGFr9FqB5z
 fk4CWhlQ9jCmH17g4ya6eefJaIymQxHnKPm6gzPUczSinCuTYL3M3t02WWmTQtqCIi+9
 KdQoXEYB+42EC+wrNA+suI06zkfznk1R2GFL2V+jCVmocDYPqt3AwxigtX91lj0JQg6J
 zyju1+zu2eyPV+7212adTlvE1UWNEVECm9HBBfAzTv+n3Y/J0RV2tiGUhYtPzVRyv4D7
 rUXw==
X-Gm-Message-State: AOJu0YySnsFpAb58ptT5DisP8tMR0dXDrok00CPSaL/n9HZEVty3UqmS
 Vm3N4mS+lXzZHPf6iU16SR0M2Tzg3TeFETuOY5ZfG4ggSGMETxeTOt7RaJ0UF8AAxlIzPwXhDjt
 sfHiOLWK51oinyeQT1ywDoTYdau1+EGPf+Ca3rju/sQuz5NNeMEG1jOL09BsrlxpPJt05VY8/7v
 MmW70FApQgZxjexBFXZYitH8IOVbc5++CY7VSX7ArzCZ0=
X-Gm-Gg: AZuq6aLyRLcPXuGJcsXjNjv+fa/hv+P+AD3KVAscYdG6FB3SgBCGMzfYJ5jsaZLFUym
 v1t5c5UzpAkFOtN6U/0flcWEBlsa4FYurWLjwLFrgPUDZ8V2V0ZpfnLoXe8xWW1n5DbUOOssPXj
 AgTJ+XrdZboG44q2SwFA//UUbmEj6J3+t0bXmPAfqL7hINl+V29AP81Nxo/tq8xF6QUok5vsWDl
 a2GQF63wl21ELBJjKK21x4qTrb95HWtFDwbHQi1hpMt0dkae6aJ8SQ0IGbgr2KJ5SR3/Eyt3409
 DHlOKjOkvWr/E2RHxFKYVQsohoKiJqW0bWoMTRSQzkz5fVknEonzD7yA9rGQ877FfuMiP2I00UE
 bPNnsGk748hcieI1Gn/Bps4tALSHcTRQv54sVDBArNOh/0JbjlsHIGvnfUyCs++/tdFfT0pQ1rP
 fldLElLXylsqUoSoIIOfjyAVQAVR+BdzE7jRTgRG8o0mWOCJAl
X-Received: by 2002:a17:903:4b0d:b0:2a7:cf36:80f with SMTP id
 d9443c01a7336-2a933fffb49mr13008675ad.55.1770172261945; 
 Tue, 03 Feb 2026 18:31:01 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965e6csm6991695ad.73.2026.02.03.18.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 18:31:01 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] target/riscv: Mask xepc[0] only when Zc* extension is enabled
Date: Wed,  4 Feb 2026 10:30:55 +0800
Message-ID: <20260204023055.589588-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
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

IALIGN is 16 when the CPU supports the Zc* extension. We should only
mask xepc[0] when the Zc* extension is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/internals.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf5..d2a77c41047 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -160,9 +160,15 @@ static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
 
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



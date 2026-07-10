Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65770C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Q2-0000gX-Vt; Thu, 09 Jul 2026 22:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Q1-0000OV-0i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:49 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pz-0008RT-EZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:48 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c88973b6965so1123360a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652206; x=1784257006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0G/60SeEjs0TcXFYzAzkWqqv3h555oE5jdrvQspi6p8=;
 b=kaL9xCeSVjguy+6GUJfED/g2HAueQv9WmrKi3e0AJJPDjVq27g4J4HIegMBnhPgWEx
 2Y8uK+vCKiJ1WxFilIvCccLsuWG6ZRiloV70V2/X8jAu3QvFNpJ2UNHvDSNtdT1G0eTB
 gsRoemfR8ZvQjLt2MS40KB4Rc4y3wPkkjscboCBqH1FiQHpOWGRoAUadE6Dxpd3+Elfo
 irRuXvbKC38Nw6DHAw0i5lKaz4/xtTqziXPHZ9d24k7BgfQJtOnsmQMpeKjGMR+4bkxW
 MR/XUngWG6Lq2VTClT4E+T0WwRKyQ1B9Q2oDBF3kwyxOxIA7iXFoJFirC3szLoZjH+K7
 yQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652206; x=1784257006;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0G/60SeEjs0TcXFYzAzkWqqv3h555oE5jdrvQspi6p8=;
 b=lXlXgYn7MpKTUdmkmHkehAxOUuNtBwdmho2VYXFUrI/rtt+qR6B9gUSx+QbndzWmPp
 WR+mhL8q/NdR0ghl2kENysHUEqmTE7RTgjsne/lMD9INqbkYkeVOMgmAAPRPUkgsc5H6
 xYMJ21v/aTDFee4nhsS6ceqjcP8+oVt53qj2cPiOSPn4852/ip2hTPQJ+YmejtW6Q2EG
 b/Jez7R7hu1VSR4leAmqpLAmWIAUmIvGzf/k/mmLAtMIgyXObaeAcbM7PhS+O3y1OkgN
 +S89Kt8ByzzKuqOZBEP+s8gJ3fmWNDh1n3GQygUWoEkhc6RgH6aDROyMXI81ouZ0y0Lb
 jI6A==
X-Gm-Message-State: AOJu0YzzAoTPqLxb5dDwh3gZsZEWEEcUrxgCPqHzvAGaCR7JL0TI4iE7
 OVX0q/nFiIqLQ3rSsyoJdYhXRFm/67bacglOAWEsNeRc2WHASwgU+AqRqMWK3g==
X-Gm-Gg: AfdE7ckPMqdKhi0MUd+t1q6gpSQTeJmVgsD1NheCXmLUOUlSbhGHZQZDx5YDbQ/YSwv
 +vnd1h+c7qq+dBDpq2oXIti6wpxRMuStwHSpWftcO7YBbBe27zx08FUj0bwOpA2/b1/L5TKaF4V
 vNsTXH+17lgmolMH7Atg5oQf1ptrYyR51YV526CgHhtt4obs70fkFfaXyLyghfCtuFTvOwQVRmS
 Hz5JfLpzwIz/V+SBykFnHSsAmWAAytkc6b4NcUeObBe+wZ3CW8RlvmUoJ5yiJ/Z1YOWfeh2da8j
 PicH6ofHhnby+6K1/fP3dMvFzSoTm/VW7/fYKlJAv5tD7bEjATRQcdncYDHRIAPYfxJxupe521c
 oZSJ8gHYioi6ES99aoY4txIN5l26VKA1eZnafNmJT/E/jMWIKYVVnNSMo1EwjR603qvdRA5MwQn
 w2e/HHqhhRhU4utY0bhnnMjVO3yp6n+ns=
X-Received: by 2002:a05:6a20:6a0c:b0:3c0:9acb:3fe with SMTP id
 adf61e73a8af0-3c0f139e9d5mr1627026637.35.1783652205914; 
 Thu, 09 Jul 2026 19:56:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 21/40] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Date: Fri, 10 Jul 2026 12:55:06 +1000
Message-ID: <20260710025525.1704417-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_dump_csr() is a TCG only function but we'll have to implement it
at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
ifdef while making a note that this function is unimplemented in KVM.

The csr_ops array is also TCG specific, thus the for loop inside
dump_state that iterates it is also TCG only business.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-16-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2741047769..db18c52656 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -612,8 +612,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+/* Note: this function needs a KVM implementation.  */
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
+#ifdef CONFIG_TCG
     target_ulong val = 0;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
@@ -625,6 +627,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
         qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
+#endif
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -662,7 +665,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 #endif
     qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
 
-- 
2.54.0



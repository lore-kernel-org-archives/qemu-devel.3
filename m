Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F281C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtmL-00088x-Ge; Wed, 19 Aug 2026 23:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtmD-0007ni-Vn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtmC-0004UV-ID
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:13 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so400189a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197751; x=1787802551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xa78VJXkRTr/R10IbacHsImvODmXgVktvTMEhHcpiSY=;
 b=bE33lFj9IhPUwkEEoXmsq1ZPSmFXqER0BlnjxqRn9lV5MnA3HskVPL78GRs3rqWgIt
 JoVS0emB+qP7wzNGEpoiaZKHPU+Z5uXNtrVQwpikUy+1y846BXQM0gEFTWny7zjxEa0g
 iMQw1swKdUa+M9a1RT3s2n/nvowngRQ0Qt8WzFs1upiAChhfURRmfGUO95XlorauEzVw
 pvynLWgx464m5jgKOqMN9IL5W+a0urYunA39FDBhVdm2IUjDIaUugBnxyTRRShs05JFa
 0OLhrzXxK5iBm22B12TQm2p3TosPoeRboVYsG0u89BrcWM39XWqJ4H5dbcXU+JdU9qSj
 a1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197751; x=1787802551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xa78VJXkRTr/R10IbacHsImvODmXgVktvTMEhHcpiSY=;
 b=DsJ1slwUT3SsPgY/Ls7upcXmkEQg8O21vAkONDZ7RTDxMeRjqZerlchrTYZ7VSdhkk
 uzpTW9TsGFjsuTrSA5RqRdujeN3hx7YaJuEnUQ4bP9JlXudB4yXJFxDZWKiugTQqE85P
 HEw+2iCOtOn9GOUSAxpy4aT0NmQGxAzEuM0mM5oEC95gSl5+TctlL/qfep8KHw41vsLg
 C3AdhI6XbJIT+QffA1cXQVsJaDw2MYH3M5scA0+h//XNobgxSvxc72UwBvTWSQOuF20H
 D50INIdpw4quZcmrwXLex8mTft7XIhDpd5446qxrjn8PLsbzoa/sux6Y7CMUfku583HU
 NIyw==
X-Gm-Message-State: AFuF++mZ0RCN7hxYTyIPVvJjEY3B8dSx0VFd6wBGNuaf1FXNzRMfC/kx
 LKtX6REZ4n6fM8Tv+AsiBaYYYhhxySXrYJIAmFFvzSiRmMM6cmep1z2N9GgbCQ==
X-Gm-Gg: AR+sD13Y0hg+/9bixhcQpScqY1r1Y1M/VKXA3jixOtDMGfLgdb7bvWfDuage1PiKNtS
 t3j7LD7b/8YE4t1VqEB2N5YI1NW0Uge5AyRbXMU/9CiUxUaCZjtaoy2JSaJ/J52U7b8q87g3MeP
 n0xZHjwkeT7ls0rMes0nMI5wc1bbsFY+/JzN69bGivRoc0rzPT8gKK6R+hHR5VXwP00hsgHnlLb
 K5gEzNMTLROhOqc//UDXdees0FS30cGed9kbXrKFt3VKXDqROgES+xZxy685Rrd8kn4dwLwqO+f
 Um8GLr/8OOkWgWz6eLXMh4Zo81Z51LG8yBVENVg+JYTH0ANhGxObiJH7wClbv+1CQYpRkQbcpsA
 uUNcvIu1CSP3UrIFt5NMQw4TS0pW7M6sWX0MvPeMaLEX3D0eK9XxJURzgFPMmktULqpgRKocDhY
 AVPIhOFhX260heXDxL93sieNHYsXX3DG14/5b6S0u+N0HccaSGKnAQgSOFWRH7DDSr2UsD3pZOl
 11VfQ==
X-Received: by 2002:a17:90a:d40e:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-395a071b857mr4477453a91.19.1787197751368; 
 Wed, 19 Aug 2026 20:49:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:49:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Anton Johansson <anjo@rev.ng>,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 93/93] target/riscv: Restore register dump zero padding
Date: Thu, 20 Aug 2026 13:44:30 +1000
Message-ID: <20260820034430.1186695-94-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Joel Stanley <joel@jms.id.au>

The register values lost their leading zeroes when the underlying type
was changed, resulting in mismatched padding and harder to read output.

Print with a runtime field width based on MXL, so values are 16 hex
digits on rv64 and 8 on rv32, matching the csr and fp dump. This avoids
adding target_ulong back into the dump.

Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260813032421.54438-1-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 79ddde419a..a13177b7b7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -651,6 +651,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    int width = rv32 ? 8 : 16;
+    uint64_t mask = rv32 ? UINT32_MAX : UINT64_MAX;
     int i, j;
     uint8_t *p;
 
@@ -665,7 +668,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
+    qemu_fprintf(f, " %-13s %0*" PRIx64 "\n", "pc", width, env->pc & mask);
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
@@ -692,8 +695,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s %" PRIx64,
-                     riscv_int_regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %-8s %0*" PRIx64,
+                     riscv_int_regnames[i], width, env->gpr[i] & mask);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
-- 
2.54.0



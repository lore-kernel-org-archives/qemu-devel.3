Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD6BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1QA-00016s-73; Thu, 09 Jul 2026 22:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Q7-0000xo-Ut
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:55 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Q5-0008SG-N8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:55 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso356397a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652212; x=1784257012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RLYdpAzigg9J75XfNcRMec9sSKmFFpVw8BwdfGHdZvs=;
 b=VjVpNQmlnswRNhCMmb+6MaYa28NP62fsEatIhrqa/o6fML3mMZbkhQKWsG1ISWH7VN
 l3iuzZRMn59k8GBmYXP/i0P84UFIgYhfY8JThDuT1N0M4sAJ2lUBmmeBzTsqAlbLHvPD
 ETRvoKKrqIKR9GeH60YYAvqWFtOQfW+yFs5cFGNwy8J8tIrASUhGxHxSMdbqzFS/EYua
 YdlalICeNzC1IXfhtfq0YrLif8u0wZXS27W1NGgMQ7/EuiD9kBThJiZnPQuXLs/Z2BZh
 QD2uLA3nbmJvw4AZ9jpQo9IFwsMxS05lkJ5B6DJat0ZsYyRcXgSHjktSdQQzoP/ccbG+
 iexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652212; x=1784257012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RLYdpAzigg9J75XfNcRMec9sSKmFFpVw8BwdfGHdZvs=;
 b=aHmzSbnGc6kcJRtZ02EFV/EpVJdYpe3zUyXWxrEkGHe6tiLzqWX/54qUSAk81BHUNG
 bgHHQMafifHz4fRsacMm1QJvMZEEHp1hdlmCaebnUrimmh6GXAyltViWvFeSSWcA8eDe
 bFVKc0ecGUP0dkfx8Sb8rYcM+aTtcH2oqb3c+3A5csPEgkXV4McaP2DlAskPrFfeLhA0
 SvtgAKwCmTafRgSzB0JcqkjXYSkkkx2gdKHLOaEjv6LNV4KRmtI7Tb+VE8NaKyZF/Mba
 bEIlLls2WN1SYEdmRLJgVQYouSZD9Jl4m4x601Nsx4DBx71ccA+JVU0pgHwOvlIgya7m
 GGdg==
X-Gm-Message-State: AOJu0YxI2IBXMnkp3h6g02jqDiHd+Q78rwyPleiW9qBscMpC1uPTdqs7
 CAifxq9wwtDt97ihfA2nWdYfoyNfV8v57+4bkC88MNm3X05GP5OgUZ5RnaTL/Q==
X-Gm-Gg: AfdE7ck6kJ3yFCHE3iqjSIiMQZqervbWdulr/KEu+vCjWV7xWBcqbvqmya0PcMbO+j5
 V0y0OXAkKSlx0gmJ1UGWhvRVundWRLtYKh8b2vraG0eCean2bbWfs1FYpiYVfZzgJtcsxjvSVJO
 xFUAXE0e7ZqGn+qsOCFvlZuX2Qmc8WHYstsTFd3bqjKzvl66UbxLvP+/ynoHky+Qr7HrTNCxCZW
 minCBuRCkbM31ND5nYeXfkIiW604LdLTDOAtKBuQuagnEN+H0rDMYUYY816l7PNTQIK/0HEYWwK
 mO67gG9YgEG4maeV5USLNgWmAgO4naK4IOdKiR1wmqlQl2yUdcSyL5WylH4YYf81OvRJjuGULZm
 GmQ3NBCq6ckHmGVWPjFPv+AS+vUnd8zth2Ahb7jqBNX9V9PZJB56USlakl4TwpoOMC1pkdWPdgd
 4pydVWc2ygsFSOj8v/RhfOWrDj727TsmA=
X-Received: by 2002:a05:6a21:682:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3c0bcbe6cdbmr9111763637.9.1783652212219; 
 Thu, 09 Jul 2026 19:56:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/40] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Date: Fri, 10 Jul 2026 12:55:08 +1000
Message-ID: <20260710025525.1704417-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

We have a lot of TCG only initialization in the common cpu_reset_hold
callback that prevents --disable-tcg to work.

Put a CONFIG_TCG ifdef around those bits to make the build work.
Eventually we'll create a TCG specific reset function in tcg-cpu.c but
for now this suffices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-18-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b79dcc5ee..5a82e6563b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -965,10 +965,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
-#ifndef CONFIG_USER_ONLY
-    uint8_t iprio;
-    int i, irq, rdzero;
-#endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1020,6 +1016,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
                     MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
+#ifdef CONFIG_TCG
+    uint8_t iprio;
+    int i, irq, rdzero;
+
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
         iprio = riscv_cpu_default_priority(i);
@@ -1057,11 +1057,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
     env->menvcfg = 0;
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
     /* on reset elp is clear */
     env->elp = false;
-- 
2.54.0



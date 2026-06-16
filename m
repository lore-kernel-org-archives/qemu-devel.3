Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA1CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjL-0006Jd-A1; Tue, 16 Jun 2026 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj0-000601-55
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiy-0003ji-HP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-842264dde84so2722833b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604531; x=1782209331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB27e2Kj2VlqVIO8yDB2+UY5InhZ7Eg6JtDLLKAzkDQ=;
 b=lN+teEHDlSBsVKm2yLN73XXxlDAENa2ooMeqgXBG29TmSXJFygEh8d3z6cPcyw4loe
 M4tRZOCtNv76iZ8zRWQcHgP1kFj8TyqyPEl6eVhcidxzc1sOK1Hv9zC1Fw9K2io1bOyJ
 kvwVcJX21o2YswizO2BOCL2Z2CZlf5vxxgoRTbVB+lFsaa3SCYsSjfS6e6IK8bkRnuLU
 5Z7BvvocPai+B/UcdW9wBJa9ajhHXTl/bCnv30yKlNRLxhAnitTosbidGTp/IkyRzW4u
 zM8XF6evbeQ+ItnneoVTs7w5GXslhkYqqf9cag0iql3zkyk3spWZ8GzRF9p7OwOaJye9
 DGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604531; x=1782209331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GB27e2Kj2VlqVIO8yDB2+UY5InhZ7Eg6JtDLLKAzkDQ=;
 b=p08umgFqL9g/wTrVtTZTDKZiABtJLimsSGg9KBYKYC9XtBpAi2Nju7tcnI44qEbHwQ
 GZ/l15m4h2J0qCqxhwMdIRjvN2v9q25wswac5lj5YtbZxu+PqzGgedfe+K1tpdF5O7oy
 5KJlgaAvD9RdmNgaDabEaL/cR8AfgImZ9qq6EooQQdYDdLRAcuguRle77jIPOWFXrez8
 HCCq6yb61klMd4T/OgBxOpF/Eh+GAp3Czc7ty6ww5AyrFtPlbFeRiTiflyPxIJsdeJcV
 pqHr5C5x4B0xMaREWL8FFeFuQuz2wGV/XAWZ7Sh/nSRnWUANzTlbATZhAWiV4b1rQErk
 Qodw==
X-Gm-Message-State: AOJu0Yw6D38DDVeHrars6GDfN5L723KBkx8C8cHPcONL8MMdUPUE2Yk6
 AY5Jot1QsxZafaZ5q78or/m5B09+JOSD4/wE6c5WUM6WaovZ7/M63KRZIrkh/+IF
X-Gm-Gg: Acq92OGGR6h9qCOzN7ChsT4HlhcaLXHuBUHlQ1EzpmbYtjoIQ1QkimQMkw49IomLU4v
 hkJs01BE4OPpuzLIs7Shyph1LgODw1fk3BF5TB3NcpNfCNkHU94EQOS1r0NGagEZlnueuui+9ki
 kA51VS59T9F003Up+PLoFj2Xg02hLvJsOi2HjVsONwh271GciXeE6IL2rkn7dwmcizJkW+/AmJP
 XO+QlD51o28YLaRzf3uPLPZysMqtvT7ASu0w2KoJ2Y0U2bJKnp0GjFZRpbKRsNaAqUSeIrl0i0X
 DwpSL1yzTBkHs+AscUIxga77DJpWeJQr1xhvARIX3ByTtmbq1DzmO0RD3tgyj91SoYf2i3BCczz
 5HPZ7w85bB+ULdpl+LPOBOXO1YWbIItNgM5trvJZ1kn2AN1I+OUxrs5XFeOUyBJUZwd/vrwBeTF
 C7/hfFawBJzNcal58Yn1XLBkWTgdQF/Uv4mp7JglCb
X-Received: by 2002:a05:6a20:d492:b0:3b4:6f45:d8ed with SMTP id
 adf61e73a8af0-3b7e249580emr2906416637.21.1781604531160; 
 Tue, 16 Jun 2026 03:08:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 56/83] target/riscv: Improve alignment in riscv_cpu_dump_state
Date: Tue, 16 Jun 2026 20:04:59 +1000
Message-ID: <20260616100527.1939565-57-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

From: Anton Blanchard <antonb@tenstorrent.com>

Align all the CSR values. mcountinhibit is the longest CSR name at
13 characters, so use that width for PC, implicit state, and CSR names.
Also remove the redundant '=' from the implicit state lines.t

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260529053519.1224019-2-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a5b1c2ba62..a74384a091 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -572,7 +572,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
      * to do the filtering of the registers that are present.
      */
     if (res == RISCV_EXCP_NONE) {
-        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+        qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
 }
@@ -601,17 +601,17 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint8_t *p;
 
 #if !defined(CONFIG_USER_ONLY)
-    qemu_fprintf(f, " %s %s\n", "priv   =  ", riscv_priv_str(env->priv));
+    qemu_fprintf(f, " %-13s %s\n", "priv", riscv_priv_str(env->priv));
 
     if (riscv_has_ext(env, RVH)) {
-        qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
+        qemu_fprintf(f, " %-13s %d\n", "V", env->virt_enabled);
     }
 
     if (cpu->cfg.ext_zicfilp) {
-        qemu_fprintf(f, " %s %d\n", "elp    =  ", env->elp);
+        qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
+    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
-- 
2.54.0



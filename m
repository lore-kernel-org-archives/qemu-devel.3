Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2A9E87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0W-0001f1-B1; Tue, 03 Feb 2026 10:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0U-0001Mk-1X
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0R-0002Vz-Hw
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so61255345e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131274; x=1770736074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I1D+oGV5u690BAY34zejmMpSYej+AEt8IrxwvBH9z7Q=;
 b=Mc43ILZKKgimogaQJIdY/h+ann1fVkKzKx+VYek14l7dXCkMIhlhv4x3s9UJIhx0jh
 OV5abW/f05nN6VxUpBuLsPF1ef0ZvMlwGHMNHOlwbHDb1fjOGGBSiBGAAVgBwdubhi5y
 ND66Fmf3Y42O8XJej5RnRVwi0SGxRo6HdKOtOLB5q8hv2gdjDjXLc3MAlQTtH2AMFtC3
 q6HRCodF9mf9VkLThD4eFxRaRSyD2mGFfz4pcwj7tA4GyLy9PWQ0t8B1twYWvbciN5rN
 SSjnAHUhf2GqqygmTp8jCvYTeyihxEapaF/2vJGiRgN0pjxtKUv9FfGHYxHgC3MC/c+7
 +EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131274; x=1770736074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I1D+oGV5u690BAY34zejmMpSYej+AEt8IrxwvBH9z7Q=;
 b=h1GNNzFBd3poD/oIG9R0HT4Fx1+rk2rmf6sspkNvAJLdx/l4kzd2oRTcGtXQLK96mU
 EkwWzWjtLD+rFt0OVD7s+wRiIQFbzQ5ra0r5MhDsdEeroIWOV2llUNL7YYhEUvL2442O
 MEjpxd4xgLtTW9M4HoK2RLbojP5MH5jJeXgLk8YVOWQyiyhTuDCFDOcUWhbi09LoJZpG
 VIHwH4bePctcTDY1vgzf1FqePFGeYQPhLrbbCAdA7pUzMTAJVVJsZ+GdGpzczS0noiFW
 NXlZn3X3T+G4mw6jtHCQaB9pJ0vh//XZOxyo2HHiF0xYixEtTjPNrDL/AasSRkyQiQqt
 I2CQ==
X-Gm-Message-State: AOJu0YyNY8/xNNWopVBXN3qOyyCDBy/LEtVREgc/rELulxta0V6Uib2Z
 b9Rgx0saS3nLiShceZCPCAaVAgJ+ZxPPCJyESMfsR18nqcO2k5gVDjNngRa3Cfcaw/1YX70gXDI
 v/8F98Y4=
X-Gm-Gg: AZuq6aKhiIb3fgOmkQELHnmc7+4Mg0y5atj7HBitxV/p+085vhJ2Y3i+ZsmSgoL6dvZ
 7E9O4Qh7WezPRz3aXEH1BURbtLegNzA6VpjKq3Q794ovP4jx5YFoecG9LlujQsOoee2CQn2x7Iq
 5QPYSgOrZC8+V0wK4hzImv2na3wVGbQrmI2KwYaqrZn2nvPE/w05UctPOTacdQgHSUcE8eg2Ig8
 HsnE1dQUX40aRxvvGrFpde7LQgj1AwptK1aGeuRT0H/l+OhAqyBwENAI/ADGbo9lsGBMf92Q4MW
 0Gwop7NnHQTbZL5+cJsouUWoM4eB6dI0Jhdu+JrGLNnyHEFnKH8Vlc1UV9y34em0KUNRHPSkfWW
 eg/EeGALBbUp4DxGpEHlZqD78Qc+fr7ETa4CzdCqc26dbhO1eEREWj4+wg9dDx6jSKpLJO8L2yM
 zueBHsej6VYcWx3igXYOHzWtyf0QGkMJf0Fm3lpWwwltKLN8SbfybAHIHzb7LB
X-Received: by 2002:a05:600d:8444:20b0:483:a21:7744 with SMTP id
 5b1f17b1804b1-4830a217780mr18909125e9.26.1770131273585; 
 Tue, 03 Feb 2026 07:07:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd21f5dsm142638365e9.8.2026.02.03.07.07.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] disas/riscv: Make rv_decode::cfg const
Date: Tue,  3 Feb 2026 16:04:33 +0100
Message-ID: <20260203150436.71907-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Disassembler is not expected to alter the CPU config.
Besides, all other RISC-V methods takes a const RISCVCPUConfig.
Make the @cfg field of the rv_decode structure const, passing
a const pointer to disasm_inst().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-6-philmd@linaro.org>
---
 disas/riscv.h | 2 +-
 disas/riscv.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index d211700cb2f..379e642ec84 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -189,7 +189,7 @@ typedef struct {
 } rv_opcode_data;
 
 typedef struct {
-    RISCVCPUConfig *cfg;
+    const RISCVCPUConfig *cfg;
     uint64_t  pc;
     uint64_t  inst;
     const rv_opcode_data *opcode_data;
diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2ae..6f2667482dc 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5409,7 +5409,7 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 /* disassemble instruction */
 
 static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
-                            RISCVCPUConfig *cfg)
+                            const RISCVCPUConfig *cfg)
 {
     rv_decode dec = { 0 };
     dec.pc = pc;
@@ -5509,7 +5509,8 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
     }
 
     g_autoptr(GString) str =
-        disasm_inst(isa, memaddr, inst, (RISCVCPUConfig *)info->target_info);
+        disasm_inst(isa, memaddr, inst,
+                    (const RISCVCPUConfig *)info->target_info);
     (*info->fprintf_func)(info->stream, "%s", str->str);
 
     return len;
-- 
2.52.0



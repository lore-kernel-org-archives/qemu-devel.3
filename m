Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06DBE7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2Ll-000870-9x; Mon, 02 Feb 2026 17:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2Lk-00086D-2A
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2Li-0005hs-Aj
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:51 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43246af170aso135144f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071088; x=1770675888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hxmb3dBWSHQNJ/KevGbWtwZmdhaTBJBpW5JHAL3soIQ=;
 b=fV2prkgqe3vhXB9z53+SWDFaUNm1muKK9FRN00ucb+Ohm6qr4ZiJsmvXtxyQSe0lq6
 neRnNAmN7m9j1rwgxlFyT4OIi/0cJrb/4QCLVXkI1vWyLknlx25XWYgxR9smiGDcUtGn
 3iiAChagaNoF6b6wV9adCP/8Me9BmY7CAufYnHXNajgrgBKVS4a3+hRFOcWv+vMANwFP
 EZzd91v3TV55hvdkWQf5lK1PUzCL+ng2VQ4gyNKgmUX+b/SjaRA1Tawzr49uvCcaN/hx
 WaSSgKnBe6JH3+tywZZIBLirdCT2gQWE9qJ1jjlXoddAg3pIvCFzQLw+omdPtkmNe2Aa
 gSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071088; x=1770675888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hxmb3dBWSHQNJ/KevGbWtwZmdhaTBJBpW5JHAL3soIQ=;
 b=pLdYP+MMLELu7deYQj0MOH2w28I6+062/3KLBYTephrlay535Xj8nFmPpqk27uPI5E
 +AenliQgrZYtyEQLYOpu+vZ46fIQn+LdCu2NWY8VPMwmCd5+rM0LZz0UUpHNtnk0krH3
 XqdXPyuPzjYUYp4DkriZHrAkqOaf2jT0Sw6dOCsr60P90apoKO48UKGgH8U2IdmIKJxh
 qGN5nhNp3xelLIphldLCrlRy7opUvBxlq2jHpYKVSwMd64PNpBr6iT6qezS+/madPrD1
 HCKl01x9smF4nzwpvKPP7r1eoSGT36CeeOGTmZ4hkFOgQ5EWwOX8XFy1fwSGwBl6SA6Y
 HUAQ==
X-Gm-Message-State: AOJu0YwkmoqHkoqp4Gla7OEIAzjDXYQuoDiTa7X4bZIGeFaaQlQ5BLW1
 ha6VnAESbwDf+k1+RAIBPWUwmbSz/ZfLn9JlLhHuD5UgQdBVvpR2NooZKA7JerLZOzOZ3hAL0KB
 gTwwSI5I=
X-Gm-Gg: AZuq6aIUG/phEGsRGjLUcaG54SUndO9dyUDjg8i7wapo/2RiIq36m5phnxCb2VFDBV4
 gmL45l6zPhu+EyVwkVOYln0ZUnHsCc6YNHqAh7e0qpXcVmsDCjGNIiDTtdAnc8KmT/NLqbicEOF
 lgnUEF2Xo/tLDc9x9Rj4/6ayAVFmkyqD3FXklDueQum4PPmzM6u7YEPOh6sr+G4YweOJPvBYgSz
 OAxukY4SCiUULvJxRR3vFIOUv7rc5tBZDI7ZksjYTCWK+m7sIfz+sl9/5TZg6CisKGMYd+HTvln
 H/fRIlo97/c+4PpzDQRjc1lRSjyHObIaOzbw69Ot6BSJWMqCCZ/aazdAzhPiq5SUrhEotiSvuXw
 6SzsrohkufXJmNmqgCuprg4QA/BsJK4kVNYJy43DS2sMzE8XJ2D2Kwmp+WCDuYxnpWgzbZvCAkj
 y3hY22suqWjqG2f6uxhKV1lDe9RfCmpnxh4XHG9Nn50fr2N8Li72xWMkZATUpVMLPHbZfVpy4=
X-Received: by 2002:a05:6000:4011:b0:435:932e:f932 with SMTP id
 ffacd0b85a97d-436114074e3mr1512247f8f.7.1770071088453; 
 Mon, 02 Feb 2026 14:24:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10f82aesm49210576f8f.19.2026.02.02.14.24.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 5/7] disas/riscv: Make rv_decode::cfg const
Date: Mon,  2 Feb 2026 23:24:10 +0100
Message-ID: <20260202222412.24923-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Disassembler is not expected to alter the CPU config.
Besides, all other RISC-V methods takes a const RISCVCPUConfig.
Make the @cfg field of the rv_decode structure const, passing
a const pointer to disasm_inst().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



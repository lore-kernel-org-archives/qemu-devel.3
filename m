Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ADE9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9aO-0000vF-R9; Thu, 19 Feb 2026 14:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9aN-0000pB-2v
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9aK-0007wb-GB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so871809f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528871; x=1772133671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufaMYrYceaVnaduM5mCM0R6LouL1uV1u/qnpNj3Au4M=;
 b=x27TbcgYZS/vxLR25x89gMZLSIotEqU75ULATfPdcJydl6Y7mw4WGYD+JaK5S5vZ7g
 FdYZIFVOTtKBt+jyocM6PZNXXHvRONm7hLFp0EG+sbJSld0ovefcPVEXxPTgNY/jfkud
 +s1V4uE2SOXUqGUHBh0OZzgArIiU5A3s37FWZQTI+wybL8+6GW32RTu4sJ3f/saoaGQk
 4jkxpEJTQJmrjZJC3ZgeIzFsObAGBQ4nOTxTPm6lfs32Z5Xjgig860XnMgMtTAdF3kyd
 sszYzOS3krah8dqLbYFac26u5o+InvbqklyMYt5FJD/mYhXR8OGvMnM6kTlBRFe9svXH
 hxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528871; x=1772133671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ufaMYrYceaVnaduM5mCM0R6LouL1uV1u/qnpNj3Au4M=;
 b=BzVduJyN0N9kRFJtvO5RhTRk/bUY6Imxr6IeDQSryrGgY6wjudDDVwOPv8O5zD2LPr
 VXNI5u+Rl7MRE8C1BKzKYDkqoyWK2kV4sN3huYotkLCpg4EF+KEAj8leF3cKNJ+byZb/
 gLeosbpjk0ItwhIWLkGzPPYPHDz94Up+ctf2yutWn2AXsaBOTyxBGIaKCDffln1TGoKk
 zplsQy3cPtYS1+yvb+ge6ccO6+pwaHYaXNdS8MXAl16+3vveGWEOD28iJD31p5Kxsimk
 t0PCHqigj61KR4EWPZ76tDkzo2dWr3FZR2rEwCa9ervToczHWgj1mxuuJp0AfRGlMsLk
 ummw==
X-Gm-Message-State: AOJu0YzEVD5TzFC+QZhkLCdQWYjk/ZrDsSMReFS4g62qB8CT2KZLNjdL
 9CTil6eI9Nx14AU1mzfJMMOUhGDHHe4UFZl6gbYXWNYfk688jXqpIxXehzzWB3VX4etjvsdoy7s
 1yPXkbU/b2w==
X-Gm-Gg: AZuq6aKAkI8baQ8eyelPfYhQkSfRfbHvCfuH2hxfnidqGXM6IaB4NYYm+GkEKZMHGpd
 c3+T4dxV9nSNNpBD1+fFFjLVUftJ4RtZ/VgilQVvLWq3x68m7eQszSErRd67w5oc/WlhSJhAzcy
 W63cyUSrJLj4nz36wHDvM1RzEVtgF95+bx+nqpFTQhg19sJY1MhEgkFf4O+jBHqpg4Ggvi7CvBP
 QdaUlD8hie5oJVqTZWafHLe5XNOLho/WkBd13ktnBIU6LRAQTqmGb92rR4yrCGzIFc9KqNzNvFV
 ckm4Ra1u5YpmqHvQfGgNgqVgK8CF6a4CWC5eBmnAr5KKMu8cqcGowTb+LUnEmYqKW9N2vHH+bXY
 FdoizfcVh26NSNs81d+H1+uH4kY9rxow3OxTjec/3AZsYKuUThDx1IlR91uAkqQn85MR9eokP+T
 wNTm9bB+FbqEoszvtdeXuIuPuUhEVEkCOFtYQXzOx+po6WsYVLEgwQKPqHqT8DVgkZK5W47Vbd
X-Received: by 2002:a05:6000:603:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-43796ac24fcmr41171564f8f.25.1771528870557; 
 Thu, 19 Feb 2026 11:21:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437969fd36dsm53544047f8f.0.2026.02.19.11.21.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 10/50] target/sparc: Introduce
 sparc_cpu_register_gdb_regs() stub
Date: Thu, 19 Feb 2026 20:19:12 +0100
Message-ID: <20260219191955.83815-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Introduce sparc_cpu_register_gdb_regs() which we are going
to fill in the next commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h     | 1 +
 target/sparc/cpu.c     | 2 ++
 target/sparc/gdbstub.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 7169a502432..0139732e4cc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -586,6 +586,7 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void sparc_cpu_do_interrupt(CPUState *cpu);
 int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void sparc_cpu_register_gdb_regs(CPUState *cs);
 G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                               MMUAccessType access_type,
                                               int mmu_idx,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c11d600dc30..f688f07445c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -897,6 +897,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    sparc_cpu_register_gdb_regs(cs);
+
     qemu_init_vcpu(cs);
 
     scc->parent_realize(dev, errp);
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 134617fb232..79d661fbc10 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -215,3 +215,12 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 8;
 #endif
 }
+
+void sparc_cpu_register_gdb_regs(CPUState *cs)
+{
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    /* Not yet supported */
+#else
+    /* Not yet supported */
+#endif
+}
-- 
2.52.0



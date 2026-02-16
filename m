Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABEE83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7SO-0001jn-2b; Mon, 16 Feb 2026 17:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7SM-0001jT-Md
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7SL-0006RR-68
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:52:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so40826125e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282359; x=1771887159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EVDqUSnKuLSZFx2rfFInU6uMYtrVK22qZ3vqfoVMVw=;
 b=JpQ35XCznKkmKSzqu0ELt3v3QV5UaMNv+MTjLmNCsEEWW9TzmtM/fyo1OaW6RwwKVX
 +cgVBlrwMv8+rUswObbogvs+z5eWcYJ/lb5yz8gEAjzx1ovMFodFJTFDiIP9mSnCJ216
 M48f6WJzJfgvW405i3ddmEp3WTGrXK3mKVfbZx2UKCLhiPZVPtHfCFd34/njtH4PzR9S
 nTJorfeg7BNW1IC8+NuT8Rc+qW0peoFERKooYRGUy+QV9QcJCN2N+3/982RbmNkzssWD
 i3ByYNuTEm0gCgoH2jhopFTyefjWtt8UUOopubHWhJcczzjZUnrBwCjz8uvv9qNNWlMs
 QMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282359; x=1771887159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5EVDqUSnKuLSZFx2rfFInU6uMYtrVK22qZ3vqfoVMVw=;
 b=oZKeloEys4GF/jlkYodw6nLXVFGA7j4079GMzIIZaMm1UCfz5caCThDJQ5aIWe0EOQ
 DmgDyU9XBaY61YcRwef30PHcsz6JEdwoAHRD1u51S8Ugrmn8HpBnRebSaOcYnZT6Fo/k
 fhxWydtP/aWBDRkqE7/S8lw5susA519BFaiJxD0Jzp2YlqhIoSPs94nsObbWop7YElCN
 2Wn2jt2hHB5+3NiEWaxp0sHAeVmRbhawYnUt5EggsYeN5EjNDHig0DDRY4pc5iamlKeQ
 KN0+glC+pNykhARqDS2kem4qHhQiImxS4Xiei34tn6jFaTWbdw4Xr+IoGePCOcvX7oSp
 MIMg==
X-Gm-Message-State: AOJu0YxnQMW6USml48pm+1j18zo6j26bzz4Zu6nvLtVF9deJDYeyyIKO
 4V6jRd7igC1pZvvij9n0OF9K6Mitg2aQ1Or4iXCx17Gz2pNAcgPjO10mmupfPdbxMn45xV71tQw
 504yHyng=
X-Gm-Gg: AZuq6aIss3JIosFlVwpYynaUT7VaIoZEIldY5XPXGds79+IWgdUk6zrrhDRDM+jpfok
 3hkgzvXqa+JMervkOsp9+5ARTLMTLvuvIk4JroBYcLO3LV9u22MsCW8Zp/9SaZrILveIuvk6lGI
 RgMAOjKeuYFNQ7VWNgVBqruCNwAmk1zQze2Db5UBDfLag3CuVaj3N/rByUtDA6EvqqfYOvIwgnf
 GjaLV6fPz9UDH/+u0tPbwegeL2+YRdHyrwo1FehsecvMcdiXnVeTdoN+oimNDJ8AWVTVflM9oXt
 LoYufVIoqAi2jr7WP0oOJptIWEGl2gKCzu14Kfl5kCPs9aBPagmNoRjecBmivy3tvIZnV5iPdmX
 0gelvDTniW5nCTgNMtPwPp6LZFcOAaOQFl4fujXj3HIWmooCho0hO1qT0xcH3X5n+zBsRAnbmRC
 XaOi4F2CeHyILQhIDdF2UKwePNaGP8q505nvar4Ibf5G+xA9FKGb4KeTLg3mgb8oml+cZXYbIX
X-Received: by 2002:a05:6000:40c7:b0:430:f241:a11f with SMTP id
 ffacd0b85a97d-43797913b7bmr21800706f8f.30.1771282359336; 
 Mon, 16 Feb 2026 14:52:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abe3b3sm35305599f8f.18.2026.02.16.14.52.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:52:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 01/11] target/sparc: Introduce sparc_cpu_register_gdb_regs()
 stub
Date: Mon, 16 Feb 2026 23:52:17 +0100
Message-ID: <20260216225228.53959-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
index 3991681d1d1..f58d0298966 100644
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



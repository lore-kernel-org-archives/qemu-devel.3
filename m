Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE7CFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO85-00016U-C0; Wed, 25 Feb 2026 18:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO72-0007Nd-FQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO70-0002pu-P2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so165331f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061368; x=1772666168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OdmsbI9Au2TUjGLocKfplEKLAz2COL3GTGMnmx6k6OU=;
 b=WEDzDTx1yyuuXQfDwVi2lNr5LjB/Oq2K5f11MCsaOpbsZY2hZ1vgBlqoYv1ohv+8qC
 nJlV4E2yZZPPYsbIZMxkG4hM+zkIIrD886NyWr5SUrBZP9AIbk6dysY/0NGejfkryy6V
 gD8lMJcutfLBLtQfeUHiur84bBJtDQTVVyFKWNV4U0EgOzmyW1+gM2+DEPImHnr9kzon
 rfuBcx0mG9jS1LuJQBV7vfjhgv2td1waOiOWZDNyxyUFx9k/4WtkY1dDXQM62Mt4UggK
 aBlGfE7CFVC3DBQX7plkCzh2Cl1haBvSoCb3pv5dVOZ4gahOMOKYvogIzTFHIGeIow3E
 laXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061368; x=1772666168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OdmsbI9Au2TUjGLocKfplEKLAz2COL3GTGMnmx6k6OU=;
 b=FtxJg7+1CJ+aGpFn4IaIwHAw8S+nrG8fr8uRTwfwAXaY9igFjxlMiBZp7vTjjWAKwf
 g68EPI3etUc0v+lXYPja37Yavx1xHSVJQh1rj8zK0si8ZOEj3ZrGP8QyLR0iIA4m0+/J
 JHrVv2qXLXt1bQTVsk9M7lvGtDxaY/AFnnAoYhKWGTXQ9ghqoRTWG1Kl+yINr4XMY8ka
 UBVUWPAArKeaEh65cjLEcZOkrmn/BiXVBCbCQeJpJDOLwVvEOsGbSadtoN5YKsX70xgs
 jyNEXrPYy4ct0UK/w9dMsjpOHPy/y0RzU0Cpw9lMAyFQK5E2TSyj1/8c/JSPyaVVFcuA
 PsuA==
X-Gm-Message-State: AOJu0YyjdRPg1fy+9h8qCZ+wYVCEwvdabY8b9nDSxIYrRYxml7gOB9q+
 m06DCjgF04ItzFdKCkMa5rnDOJmP3awES1NKCHyh3Mh5pWxK3znumUNrMTi4zB37dqNMWJx+HOk
 fiQB28Uo=
X-Gm-Gg: ATEYQzzn6SFpMnVbXB7KLFj0rqA4xVqiEsF0n8lsumibgwCxTxmj6/KjOvtZQDRT+oC
 MXhkNGoj1+Q46bYWSEVXReLK4fYDuFEnoKvKu8RvFN2Un7LBVrV9cf/uLTACnvngsoyd7usS+Ql
 YrR2zEr/f3H7Gv8Z0zzGUIzEgshMHsiXobvRp+2SR+Cd+Rm0fc2u4YX8EPzCkhuP6PDlj5XrbWx
 9HEm3FZSz4k/p+sAFoqq8qCDb8ZFNp+7DD1eWoIvB4ve8+Vez9C9EmCoiZ4IUWxeGaEbvsB5fOy
 mX/NQV8FLJOXV397EGicJOepJ+keXmJ8dOxzITg4oXMOWIwdH//81licE7o5MtdBpAOTur3QSr+
 XMs3kizbt7lWCz44G65/zi2gDentlf3vmyq09F8UbR/g5aaoENawDaETUgqkYwyb7l3IrjFdEcA
 V1myBH8ZlVizePVgunUwU8twrXwMWOC04sKEG18n+znD/s3XhICl+UOZslBsZBro2phd9ZnGh9
X-Received: by 2002:a05:6000:25c1:b0:437:73a2:2d36 with SMTP id
 ffacd0b85a97d-439942fba11mr3876734f8f.43.1772061368146; 
 Wed, 25 Feb 2026 15:16:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9ff5sm38778227f8f.4.2026.02.25.15.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/70] gdbstub: Always infer gdb_num_core_regs when using XML
 file
Date: Thu, 26 Feb 2026 00:13:17 +0100
Message-ID: <20260225231411.96482-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Rather correct inferred count over invalid manual one.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-10-philmd@linaro.org>
---
 include/hw/core/cpu.h | 4 ++--
 gdbstub/gdbstub.c     | 1 +
 target/alpha/cpu.c    | 1 -
 target/ppc/cpu_init.c | 2 --
 target/sparc/cpu.c    | 1 -
 5 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 89934b8efe2..7d2f4459d2b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -128,9 +128,9 @@ struct SysemuCPUOps;
  * @gdb_adjust_breakpoint: Callback for adjusting the address of a
  *       breakpoint.  Used by AVR to handle a gdb mis-feature with
  *       its Harvard architecture split code and data.
- * @gdb_num_core_regs: Number of core registers accessible to GDB or 0 to infer
- *                     from @gdb_core_xml_file.
  * @gdb_core_xml_file: File name for core registers GDB XML description.
+ * @gdb_num_core_regs: Number of core registers accessible to GDB if no
+ *                     @gdb_core_xml_file available (otherwise inferred).
  * @gdb_get_core_xml_file: Optional callback that returns the file name for
  * the core registers GDB XML description. The returned value is expected to
  * be a simple constant string: the caller will not g_free() it. If this
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b45eb7c7b2b..90f4b95135b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -593,6 +593,7 @@ void gdb_init_cpu(CPUState *cpu)
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
+        assert(!cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
     }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1780db7d1e2..e0e13d31e55 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -295,7 +295,6 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
     cc->disas_set_info = alpha_cpu_disas_set_info;
 
     cc->tcg_ops = &alpha_tcg_ops;
-    cc->gdb_num_core_regs = 67;
 }
 
 #define DEFINE_ALPHA_CPU_TYPE(base_type, cpu_model, initfn) \
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0b5610d02d5..3d932a5642b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7551,8 +7551,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                       MMU_INST_FETCH == 2 && PAGE_READ == 1 &&
                       PAGE_WRITE == 2 && PAGE_EXEC == 4);
 #endif
-
-    cc->gdb_num_core_regs = 70;
     cc->gdb_arch_name = ppc_gdb_arch_name;
 #if defined(TARGET_PPC64)
     cc->gdb_core_xml_file = "power64-core.xml";
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3991681d1d1..c11d600dc30 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1092,7 +1092,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     cc->gdb_core_xml_file = "sparc64-core.xml";
-    cc->gdb_num_core_regs = 86;
 #else
     cc->gdb_num_core_regs = 72;
 #endif
-- 
2.52.0



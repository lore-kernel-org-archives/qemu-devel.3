Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32649E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9aG-0000Zu-Ng; Thu, 19 Feb 2026 14:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9aF-0000TV-3s
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:07 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9aD-0007tJ-7S
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4359a302794so1062397f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528863; x=1772133663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MToM/SYV6jWDuUwDT2OuuwA8a4FUOrFsveOqd2r/UZs=;
 b=yAbR1uRFRqwuc1Ycic0D+HZv3zYlW9GvpJ9E/PbxGIz+oKbiCUz71bxEv/ww9WytJj
 6SXIIPfRieOD5gXAc/kLcBpVyGyAFypECUjTFVAhIZZEZ3fo7wxjr5Op8gqugVcXOr7J
 6Ub7p1/qB7EK88mKQylYJfTusFAdDIhP2frcWs0u/onGvrIlYpPwsXnV29njAB8mUHQR
 LHk/YZ94puXhD/+wjXEX/HKFep6qawbJXG3jzkUsHtDxARFTCOACV2NhtnqAF28kcuzo
 JQoon+2WlB2gT4S5H+l5t0qoAhilwUEcqP2hdhRXzIiyziEStzusoqx0JxlmgTt6Cow9
 1NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528863; x=1772133663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MToM/SYV6jWDuUwDT2OuuwA8a4FUOrFsveOqd2r/UZs=;
 b=uqaFHwR6dg71ApQNRVXd6KcMkz+2BSrlSuBoA+JpzL+wuwWW5Pjxw0VGM3Jee1JboO
 UQRHFvLGrHs9UK8dpvt5gEjEs+tRgmte9onlaj+XmED8WH6uFiaIVmllVAVhKwHzWjWv
 2GSOnoA95lWsgvCpQR69xI0qHWiVVul+y0Mu4ZQCnodxMacrYM2ROWHG00GhJiHWAmLn
 tRkdYELWhoco4Pz9P7nsSgYshHQcXBe9eOrmphJ2Tt1B7HbsEMF+NI2yWKqqozuOybfL
 sVXw6qpdQ1Pj8blWxi0L5b0Rxp/wIPa3k8Z5jEQCvfLMAp6uJkSR5BXhDN9q98lkcpZi
 swVQ==
X-Gm-Message-State: AOJu0Yzhpov/knFss+OGDKBoHKsVuQeo7WGAQelJckqRF+8YtQzqZhVm
 sWNVJgmR/p1nDOnytdHU3e2fE2SOPCOb4CIDK38jRWTLScU+WFwzEmvVcWXzSCa4PGgMrF2PlRW
 3NK0tNbgP3A==
X-Gm-Gg: AZuq6aIz0IVaTJ3wli/Tr0OhWNUpY8+vffaXQFbu4gZInk2NB39gwSd3uTCqH9yVQlt
 /6qGPidkNtmhgVf1lUBh+pw5pbn4AnVxzdmyfZYtY39BPAEnzV0CxJrT2QOjUMoCKojVLERyo4R
 7Z30KcMM57n71cHOm6BDfPROgHmzQVAYKJtCF5FSbL2Gd3lyOmeE9BdWssOUAnoEvaN3zz6e/D/
 kQu1PV1oyHf4tbUpS1SlMJD9MlktvvagKmikRAoh2yYb+R8dqvGkkQmkOGzIja4OE11xSPZwxRM
 Nn0ueaIy5fP7/t2eRUaKoT9rVJ5M/MKpj/MIJuF8rr89+c4rncDGkJN5xhAoiom2HJDsQCPBgp7
 GeFtMeSHVkPglgCngkWy/+G5NiH9W/W7WayEFMLCsnm1lAw0M2wjyF7zKm+SJ8qkJfXaR1sh9/v
 9gmapK8R8sI8mJNV9qAM4HayKz+UoWYdbjQXE6sPjseCrnCkaFsGEqJPo5D1nWTFNqvkLmpyXJS
 tp5cYzy2RE=
X-Received: by 2002:a05:6000:2c12:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-4379db98794mr34177380f8f.34.1771528863114; 
 Thu, 19 Feb 2026 11:21:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6b563sm50564138f8f.12.2026.02.19.11.21.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:21:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 09/50] gdbstub: Always infer gdb_num_core_regs when using
 XML file
Date: Thu, 19 Feb 2026 20:19:11 +0100
Message-ID: <20260219191955.83815-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 4 ++--
 gdbstub/gdbstub.c     | 3 +--
 target/alpha/cpu.c    | 1 -
 target/ppc/cpu_init.c | 2 --
 target/sparc/cpu.c    | 1 -
 5 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ef20cb356a6..4bdc9d62a4d 100644
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
index 474f6712f8d..90f4b95135b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -593,8 +593,7 @@ void gdb_init_cpu(CPUState *cpu)
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
-        assert(!cc->gdb_num_core_regs
-               || cc->gdb_num_core_regs == feature->num_regs);
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



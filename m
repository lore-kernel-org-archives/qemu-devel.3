Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB069C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQzh-000138-Be; Mon, 10 Feb 2025 05:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzX-0000nQ-Rv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:16 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzW-0001dM-0f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dd91c313bso693550f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183171; x=1739787971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVG9LleBgVUQXQy5aq+er1NbCMyLlUd6s760Io8ryMc=;
 b=yQT+iUtsVH5Yob4VEXYrftwBQrucQ04DzFeUZahZmPDw6wtKbnqm9oSLA8Jj3NpNBb
 juSr3l8Vf87pcHHhH0/B9ttHmW6pUutPiUfyQij3hyZB0ewsGPLkVRJkwk6UfkgVYhkB
 LczM655Mid6oVZUwC5POmrq/PJrZhNhYX+e4N5ssWSad8h5S5E6altZ3wf0IIF0IXFPQ
 St2QWop3p2w0IqaQ5goSgTmrRaCEOBeLPIalqnUJbYFL9smUtCGxsa9hU96ceoX1CLsn
 wmfIxkn0HdYYGkN3MWF33UENswJKKRXZIHJmTin/88WwLJ1WOK81lzEPyy8IGYrzVTvT
 FFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183171; x=1739787971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVG9LleBgVUQXQy5aq+er1NbCMyLlUd6s760Io8ryMc=;
 b=jEyLjRz8LAqanJWhZ0MkKmePP0/nJM6d6WO3IrwcZ+gm7n2pEht1MdQVYOFHln5s1N
 odpKgTWLaggnN1n88pfCMUU3LHcNILxxmdnnCqNMosPV8HSrvvlrYYDm/XxbF3Yf14A5
 lSnN7EHpQspKBZsfN/PXJ0SpFQwINNqEllYADD0uv55C0X16k7qSky7Tq6hPsEc8pkTm
 Bi6KOII2xoOfm5jAPXPD3KdPXzmbN6hFXAnnkisO/84VEkQhxsFrAuDKllS/4WDGvh6i
 pZzXbFScCqufZw/A8xHAmZdg2rpv4iJF+e+Kp8rsN8JFDHB9AbaHLN1Oee4wGdB7ITjD
 AJTQ==
X-Gm-Message-State: AOJu0YxW6vVW/Fe4DyaLLXjfJqyRYFlyEol9al2keEg7nbzli3ErTXmk
 b0qhuGEfyIfwPMiK8+oDQO63JZ58I3SExa0hUP4LXek6ZfhWbFBDZr3XggZ2aZHUPV4Uiy1uxPp
 dUas=
X-Gm-Gg: ASbGncusTvt1USzMyP552iBuAQt1bzX6uPRICkO2asfY97vjl0vKqSvYBV1N9l5IFtc
 pLL6APlD4CzVr0xuzXveWFYwBXI60ZR1FaMd5syvNx8lsUKdDMFbxzYwRAiF6oYpwBewkeaeIPT
 KwWnIOY6qsy92kzxfw0zwmZpYYsdlLP7IXHcmaFXuVrui0Jgo9CqE4vQe115OMcrSNoYHDs5H2U
 QHtK16PyZf/8Wek0INC5NRwoZHNaF00nPtWF3SLLMqENE1Dd6jZtIjB5z+o+A8735RBkuyFyrBR
 1pM6HiNsJuGJOnavNexa6ZTKe2190hUwpQ3TI96NwwBBT8DO0NrE/OUYdnU/LITXEa/PBl0=
X-Google-Smtp-Source: AGHT+IFehIn60V7mJ495h0wtm/Qx97nJE1dS4PAagOEUGOF9p/D0LBXdDWsCZqBUPiMCxcvmrojKXw==
X-Received: by 2002:a05:6000:18ab:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-38dcf333683mr7851954f8f.3.1739183171615; 
 Mon, 10 Feb 2025 02:26:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd18sm11930370f8f.72.2025.02.10.02.26.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] target/i386: Constify X86CPUModel uses
Date: Mon, 10 Feb 2025 11:25:55 +0100
Message-ID: <20250210102604.34284-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34fc..f9ce6970ee1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2288,7 +2288,7 @@ struct X86CPUClass {
      * CPU definition, automatically loaded by instance_init if not NULL.
      * Should be eventually replaced by subclass-specific property defaults.
      */
-    X86CPUModel *model;
+    const X86CPUModel *model;
 
     bool host_cpuid_required;
     int ordering;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5dd60d2812..4b2da45366b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6436,7 +6436,7 @@ void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
 
-static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_apply_version_props(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6465,7 +6465,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 }
 
 static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
-                                                         X86CPUModel *model)
+                                                       const X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
     X86CPUVersion version = x86_cpu_model_resolve_version(model);
@@ -6493,7 +6493,7 @@ static const CPUCaches *x86_cpu_get_versioned_cache_info(X86CPU *cpu,
  * Load data from X86CPUDefinition into a X86CPU object.
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
+static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
 {
     const X86CPUDefinition *def = model->cpudef;
     CPUX86State *env = &cpu->env;
@@ -6563,7 +6563,7 @@ static const gchar *x86_gdb_arch_name(CPUState *cs)
 
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
-    X86CPUModel *model = data;
+    const X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
     CPUClass *cc = CPU_CLASS(oc);
 
-- 
2.47.1



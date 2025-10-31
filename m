Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA5CCCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwq-0004lj-1A; Fri, 31 Oct 2025 14:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwY-0004Ok-F8
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwG-0006D3-Kl
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1699120f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935606; x=1762540406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PHTqkOaXOVQe6AabY3bz99btZKhsmQw/SbC2lr7Fuog=;
 b=BQo1ONWGwYJFSclhsi6SL0kSG07H7kbx7VderQNDO5wcB2jselZz+GnWZOgfmSys7/
 y/59q0gvsrl8KzIzQHicAmjXA/SYuR8xzCMA9HbYlpS5uQcWNSBLXYB9+7dmXjyd/Gyp
 CFhVrRu7vzNV522vke/PiryApqAVDdhACZswlKEhl3OGQuthlw5rALuX6BPnC0l/D9kt
 Oudnxdc8G39q3I9mi5hVzsT2Hq6WJtEsDFv8vX5FayXLZsP/dR2SR07yin9coXJR7Flb
 mQiahmi3dn0WR933p0aBr+P8XU4tzdIboy42b/QowBxWdjSrl4HyWvxt4zrNcC1V0asd
 tnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935606; x=1762540406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PHTqkOaXOVQe6AabY3bz99btZKhsmQw/SbC2lr7Fuog=;
 b=YFLukju7m6UPb2WY6XdOWMWdtnD0v7Hr0+22PUkYEAYbwbIEoZpX0f8NLkBfKWUbIR
 aEU6iGmWjJhIfGJ99XK+8Q/oVGNx2KfpN+8I1owNJUu7sY6oPRWn0TnM3g4+PkxSfSnL
 MHAifpK5qLP/J5tTvdP3ia4G6CZDSegVf18z1ulty0D5XYc9XcpLh7bvJwmsdED2Q2fy
 ehRQ3KXVZVkE1dc/rSmPSexallPZSdOX2ihQ2QVJGCuB0+1KcugOTPyKk4ZtYrP2aS6C
 4OMCipEnQ3NWP+/U4jqIZPAsyEkG24Q6lPJqXWKrNWNfuO3UqbvTfD91MVNgVtbhrlh+
 ebrA==
X-Gm-Message-State: AOJu0YyHUFi/WZGKODa+FDHI4nKLq9vC3HlDRPHiqUlKNF77jHycDZH2
 KWxN10ROFnj4qYVw7DjjVv/DZqqHUSKEuEOKovnH2g699N473l0nFnBly6nzRIvnvc23zqmeHfQ
 Uqhe/
X-Gm-Gg: ASbGnctemsci7FPK7PTZf/mYzZproefu7IR6zi/s4BGC4gf+hzzwm+OPPhPWchgndIw
 /hRPFAqUDeFK2g1r249xzknh1IGFtDjFAP+crCz/3rMNPkqqOIhUmvzoW1Zwsyc+zcUorwh82F9
 3QW5pxQD8ZWEQVuwQXUyIZEKMIg3j3h3P/sgYdNNrNETV1IjayRxc3ycAHsU5pT16aJNvBgl8bE
 2BXop2oWY5p4qVeCmV7sf+XXhP3ZAKLD6kbPuEWbZ9fjmBtkPirBLs5nnWFYe1Nc/9hbnDUjWKs
 azNEngzL5FW+PriJEgtNx02Br4ymUQR4B3AUJH3T4ZeG7LFkV85FObZNJfXxi5W+6z9fi0rwuH5
 Eosb6uynX81Vk3SgzQ0JJy61tRQjqIUaunS+GGjIZpjwez11SfMNo5Vot14HoTqYCwoF6wTfL/3
 wr67nIwQVYqXQo1ylP
X-Google-Smtp-Source: AGHT+IGajp8+eNzshW6v05xrpc22js6hRmEfJHV/7uC5u1i+1NqdCwlol0NCBiu09RHbzJ8RyNxASw==
X-Received: by 2002:a05:6000:1acb:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-429bd680bb9mr4166962f8f.16.1761935605709; 
 Fri, 31 Oct 2025 11:33:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/38] accel/hvf: Rename hvf_vcpu_exec() -> hvf_arch_vcpu_exec()
Date: Fri, 31 Oct 2025 18:32:45 +0000
Message-ID: <20251031183310.3778349-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hvf_vcpu_exec() is implemented per target, rename it as
hvf_arch_vcpu_exec(), following the per target pattern.

Since it calls hv_vcpu_run(), mention it must be called
on the vCPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h  | 4 +++-
 accel/hvf/hvf-accel-ops.c | 2 +-
 target/arm/hvf/hvf.c      | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a3b06a3e75b..32b32e1d024 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -73,12 +73,14 @@ int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
-int hvf_vcpu_exec(CPUState *);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+/* Must be called by the owning thread */
+int hvf_arch_vcpu_exec(CPUState *);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8b794c2d418..005e2bd891a 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -194,7 +194,7 @@ static void *hvf_cpu_thread_fn(void *arg)
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
-            r = hvf_vcpu_exec(cpu);
+            r = hvf_arch_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bbe0b24b821..9111c1d717b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1788,7 +1788,7 @@ static void hvf_sync_vtimer(CPUState *cpu)
     }
 }
 
-int hvf_vcpu_exec(CPUState *cpu)
+int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 33f723a76a7..b2bf59cb483 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -721,7 +721,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
     printf("write msr %llx\n", RCX(cs));*/
 }
 
-int hvf_vcpu_exec(CPUState *cpu)
+int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-- 
2.43.0



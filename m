Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC87CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv22-0001dy-0d; Thu, 23 Oct 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1u-0001Xq-AL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1s-0006KW-4P
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so4520935e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224814; x=1761829614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvTtMqMAFWvn5LLkR/vIY7avxcTn9pA4YCh2pIIZxqY=;
 b=bTHH3u9w4Pht+fB6DzdM3ntHPn5OCsJQU795TYP+XVr3cOPooZpUvvp8zY9TsXCpH8
 Pug1BxStbNmYz7V4HSpHNqUTeiCHOsfBvdAQ7i41X2SYuonDWZcgy5skpHU8NLxaZwzj
 FdKti6zvU8lJWozlUHQUyTXFtoQxmgG0gG9TslkHmPidXUoc+E7t0o8k35dMp1EAW4X1
 sBvsm5RD8X6cuIpmjc+/7VNaNp8plXF31veGS3HkAGRLTYjACf+o6M24hOBGEOcxtE2n
 4qXIIj6wxd9QMAyMvbhLMQT6clO9yvioi1d+ph+4FYesuOacw9Mje000d3xTkrb0r2Wp
 v3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224814; x=1761829614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VvTtMqMAFWvn5LLkR/vIY7avxcTn9pA4YCh2pIIZxqY=;
 b=iEgthfwzEOCFiVA/e0BCatgJTVgNlYIm602yJW64ESoO83OIP9xkRhaA5ZJ3tfMLGK
 ZGD60OA3Aac2SN+F20YE9FdHgRQz9k7oAulSVAXYkfXUIUY6mVrdNcwfvRDXvGVpp7uT
 uW2jGJ1Ph2xR7CnZU2gMkY3O2atkKqJwaFpXqPLOWQ19mdwXgN/OaXHphn9skigFmBh3
 KpXxXo6YL/OWqziI58MACdqmgyWfOvfNlqVs2tdmo5gzSmEd6kOePrH39QdXSE6sBvZl
 Wp44ePSvXwQqwp6V2GnA0YjzeFI3PUmS38DfHsb51C+bhtCPEQcEmkEV5A9z8XdhCXyf
 uELg==
X-Gm-Message-State: AOJu0YzWPoXWsj7x5NztCgeQqu6WAhRYsuHnFvDbfj3CUiBZYWys9YWG
 C3lMII8FEjzDklcpCPhJ6IQa49DQprMKCWpxJlcTr4lHT4tJeH8gmEDdxiYMX6dPfsgRdnP1t11
 i5N2/nV4=
X-Gm-Gg: ASbGncvKmBS1ClLyx7UmC33c29pYBStsGPpAs638MD1xyOwP2eUJlSD4OZx8nvJiNor
 ORrx+4LMrSzOsGxpfDn2LagKtFCHNbKqZUdwVWbvUGNyJdadPIyGCyyfO+moJWJUOh/D3VDlmEh
 6LXGcuLSv+mrbj5uh0StvmEHF6K/V5GcMnKaHPh7WapahdoMiZJb6ZvxNwBrKNPsSZqKNOeBYW3
 k/jiy1llK0RaHLjVgjbHZ27VrvUetXAosNjLfs01cnGtw3spyNqwYu4lzcoXm0TtbxJiG8n6MpW
 QNmxWn5xjVS5foUQZ8I6ZS6GtOHT7OkiRGEleZ5ksaZuq+wKlAUDzNfLBueEpbvEva0ndiyelFW
 TjwqeyKKbs2MEJ2bGyffCcYFPYk3bAIAu8hrWR5slz6CozXECYzs/r6CAvUcIlQuj0soSg4xkWb
 3sQFGxJIY70boe0pYP0viLSnfjIBkkO/zMsMMazTPBFsH7BnosmA==
X-Google-Smtp-Source: AGHT+IESrMJglDcfDuyTU5fVqNkF2Joo3L8KXHN5lQ0+HPu1mF9z8qte+JgkSyruDKu3pENu8N7C4Q==
X-Received: by 2002:a05:600c:8284:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-47117920935mr192868025e9.37.1761224813604; 
 Thu, 23 Oct 2025 06:06:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9253bsm35607955e9.1.2025.10.23.06.06.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 47/58] accel/hvf: Introduce
 hvf_arch_cpu_synchronize_[pre/post]exec() hooks
Date: Thu, 23 Oct 2025 15:06:23 +0200
Message-ID: <20251023130625.9157-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 include/system/hvf_int.h  | 4 ++++
 accel/hvf/hvf-accel-ops.c | 3 +++
 target/arm/hvf/hvf.c      | 8 ++++++++
 target/i386/hvf/hvf.c     | 8 ++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index c8e407a1463..eab443aa91f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,6 +71,10 @@ int hvf_arch_put_registers(CPUState *);
 int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
+/* Must be called by the owning thread */
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu);
+/* Must be called by the owning thread */
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu);
 
 void hvf_protect_clean_range(hwaddr addr, size_t size);
 void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e9dd2d24745..744a5288298 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -181,10 +181,13 @@ static void *hvf_cpu_thread_fn(void *arg)
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
+
+            hvf_arch_cpu_synchronize_pre_exec(cpu);
             r = hvf_arch_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
+            hvf_arch_cpu_synchronize_post_exec(cpu);
         }
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b0918de5f92..c83bffe46ad 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2009,6 +2009,14 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
     return ret;
 }
 
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
+{
+}
+
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
+{
+}
+
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     int ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 4597d191f9d..de5e8b45d19 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -722,6 +722,14 @@ void hvf_simulate_wrmsr(CPUState *cs)
     printf("write msr %llx\n", RCX(cs));*/
 }
 
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
+{
+}
+
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
+{
+}
+
 static int hvf_handle_vmexit(CPUState *cpu)
 {
     X86CPU *x86_cpu = env_archcpu(cpu_env(cpu));
-- 
2.51.0



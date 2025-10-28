Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B260CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd3n-0001rP-Hd; Tue, 28 Oct 2025 02:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd3k-0001jr-TU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd3i-0007r1-2r
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:19:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47114a40161so62548495e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632386; x=1762237186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IChYbWTlLnmk9z3MzpiGjHtdHd4pwj5fs9KZRAqli+E=;
 b=ifgcRnXSjWmZMQpzAo4wPO/Nl+M1tmkuGq2XW7bn/3xIBJ+M19hzNYovgcBjcvcDFR
 VFGTLnUXV94S7WFGOIjl/35R/unhWXXCbDIglAPjB4LsJxTWxHDYbcppnEkVZzqRmOOE
 uZpd+y9KxT5d1LzimEYo4A26tu1p0mwNPAcK5fIYcLHYqhVwbjj1/Bt/k9JcIY/7OzkE
 uRoUQ4Owj56Ap49sAc+zE6bt82s8IHLRa+WvclxjGGxbk8DCumglSkpc0WCjjR/h5CFI
 3qGTQYSqd+aTJ0K/ZkDcLGlf2qmdu4oXvk9jZtoVU26A94JtfiQXHvVyX6cDR1EDOE+k
 s3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632386; x=1762237186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IChYbWTlLnmk9z3MzpiGjHtdHd4pwj5fs9KZRAqli+E=;
 b=f2EsEMWlIa/9Hhu3TZD1stBrWE4xSOgHXbQ4V2/W4rZzIt03/0R91Iw1z1R2C+ySAy
 BPS+OrH6hINK/S3GUes4yNSSo8+6NCNWdeZ75hvr05qA/zhzBqm2oTfZyvD/9kWxMpxz
 EXaIR1Xl31XLYIS66N1JIWXf/SUh4f3ocpTCtoq3BfNVXgkwoNMDgR43IkAOGdnBGepb
 jkRQ5BU4Dq3bC0EHwiMNrr02dU3irUmh/xTC0bgtKHrgH/npadsi7lwEWNOH0T/JQLpD
 v/AZNGJlAmQzXJgQRIwcdJRyHamtOkiK4DVecFmGmgDwVulLkoCmLqR7RGOKSNS64MgA
 YRAg==
X-Gm-Message-State: AOJu0YwSSAe+QAChhpb9BSVqCYG1034jvxSVDP99IFCarOud3JWt3IjI
 K+RCgsnVIJKoLke7qmXluwCkqMcLBP38fz5W56C01J1oFdkK454U2FRydOvFR2LKDCqJnKy5HC0
 J6kJ7Xh0=
X-Gm-Gg: ASbGnctCdG572U+z6rXs3cb6rt9f9ZsMxmYMgcP7kSEBbPETTyvszl/cPo0ddhuBBRx
 efIbIfXpyTlJE+mi7h6Z9xwDILYRbqf7Gw9pjpmFfJJ5JqQ9pzoaw8bnXAKwOVKVQBEtMtcO0rv
 WI2nMasGMwcFN+qP10/5u0xgOEnySjOknNXqs/GDFAR7bwXqLBTIZRM289GRzCVaHpn0b9rqvVa
 ndfX563LV2Bj1Y5RrWToMBudXc8ER69CzIwCMjvgCwSX7nOL2Fy14Ejiz2TWCzmItNope4Jt95r
 fJVQn5zWIEBpWR2Mul+TGNi/v86l/fqxNKV5o7N4mOH/QIkpAmo8CbwPgp8wIbHE3gMDXgI8F1K
 VFV0M7ADpkPza1/IQ9XE9pJSImxgmKg+G9JZMkH8J9HTwNCeEAOsz3d+nhyBsPKYX4QWWTEq0rs
 LGxW6Yk9Xk1Vu0KsPyR2rOlJ4go6OcEmbiYs2Kpgmr7g1aYmwgpaOM7A0H4S1edCpeWg==
X-Google-Smtp-Source: AGHT+IEmlXZ5Hi/grDN8QyvFykamGhiXCVwlMh1BTIQWIZ+pquFTUZ0Hdq4yf0NlTMVbIx5zjOGtTA==
X-Received: by 2002:a05:600c:8710:b0:475:d8c8:6894 with SMTP id
 5b1f17b1804b1-47717dfc603mr18653855e9.9.1761632385803; 
 Mon, 27 Oct 2025 23:19:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd374e4esm170612465e9.11.2025.10.27.23.19.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 52/59] accel/hvf: Introduce
 hvf_arch_cpu_synchronize_[pre/post]exec() hooks
Date: Tue, 28 Oct 2025 06:42:28 +0100
Message-ID: <20251028054238.14949-53-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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
index 96790b49386..3120a4593a4 100644
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
index 28d50e23017..6fb1fda424c 100644
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
index 5b077744720..f5bab7e7213 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2013,6 +2013,14 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
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
index 49f26169632..5711ed6f1d3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -729,6 +729,14 @@ void hvf_simulate_wrmsr(CPUState *cs)
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



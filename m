Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F63C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHhO-0001Zg-3k; Thu, 03 Jul 2025 07:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeG-0005dp-7F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeD-0002qd-Of
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so66300665e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540312; x=1752145112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Nod2XnKcLFCGDw4Al66TFSscA1L5ljopnzhztAklYo=;
 b=eZuGPncspxb0rG8da7cX/NdiCLxMfV2RGBv+4PL8UhW2QiV5Nju1Nhc/3NgE72B/yi
 tT/fC0adiKOUMffZ/N9UgpDK+fgAAF4mT3ytEIL6yZfyldpAxX1Nt7WxarHqLLQ7lmnA
 9bCv7z84n1oKRC9sAzh6821fSU9zLwNwOqqt/jHhLPs+Ox1KS8gPPRotrSv0idbugFmn
 gaTwb7MhXzEvcoWbuXkWyuuNybn/qjAo76EY7QHoKTW+FaFbfTLZQ2OVFKeCbGc1qCIb
 6I8hjjSwHfdvlR6u01bLPJUYz4YsBKfj4TPRvC2owfLa9weH3uIhaB2At0UlT3dST6Xt
 P6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540312; x=1752145112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Nod2XnKcLFCGDw4Al66TFSscA1L5ljopnzhztAklYo=;
 b=pwidV68anzWIKuY+g/mDHs6SnhBLFnpjMrt5GJQZJ7dYjmYVnAGiLlGEJka1plHbbC
 +iLTGv22IJPZ6kY3lkXkU7GSb8D1vXwF09Xaj7AbbDaE1oTUf91L8Fx9+Sxcl/pzO0JR
 8mVY4KD9tVjmLWVbCmkoFnN60AOhvRuTYnqWnQPIzvXLYT1g3cGCM6aPyCb4rwIdKnTV
 8As+zQbypssaOy7UMuCitTuAw9E7m8BpCrLFrwduy+uHdFq1WDBFmn7DzN3LheUhx1fI
 pK3Pfayzb8pZqhztNoLi3a1UeQf/jFEJ8fDX8Q1knVbYgyqXtNUH0+oQSoHB5PcxskXa
 JOnA==
X-Gm-Message-State: AOJu0YxvMRuQNqMXe+QSS+YCQe5RkkwT6UoMCyTSpAnsQZTP5yQzC4eK
 r3HNQnjGMntCBBEU+qvguFYgL9V6ZcEmIOl6MZPsRkUlDtmc2nsXBuDpjYglbUFObEAVZcfx8te
 2GIcj+EU=
X-Gm-Gg: ASbGncvtV7jrJdUrR+7zexE6BZBdN66anoZwavQ3jirJE2VWInezX7xknbxCuzZs2OM
 X+RFc+TjWyoReKKhad2AC4QvnQzlKodm+ERwv1ps4oGvwG8uBwVbSI6ExkAgMz5fYdD8J6vNNDW
 DBMk1YfgY7M6hkD/x7QJbt0GTIxbPORPXTwYa9S3cx1v9wkeqbFOMrmORptvmJGkK7EVoLYsQvf
 xJbgA2r1H+vKD/hyZ/Uxr0DnKBufowBnrIuyQASOAPLAO5jPgJdOipEp3Akhr5zQAGyBCfOVNdz
 rtfmje+s3dURkiIMZJKql3xHcJNUNw/T61l8qOdmLFDqX/yLQin1biMkZ6DqeYRcmMW9pigY8mY
 o3WVrZrKekkk=
X-Google-Smtp-Source: AGHT+IGcickO/WQ33gY9Gyq+jaddIwf7/whYrVsk66+TMl1n3JbF5YhpX2jiMT2tTmqO0asrgEwj+Q==
X-Received: by 2002:a05:600c:5249:b0:453:8bc7:5c9b with SMTP id
 5b1f17b1804b1-454a372636bmr65941105e9.24.1751540311639; 
 Thu, 03 Jul 2025 03:58:31 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a998aa1dsm23893825e9.21.2025.07.03.03.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 32/69] accel/hvf: Implement get_vcpu_stats()
Date: Thu,  3 Jul 2025 12:54:58 +0200
Message-ID: <20250703105540.67664-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index e7f40888c26..c07ebf8a652 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -358,6 +358,12 @@ static inline int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -583,6 +589,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_us; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_us));
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                time_us / 1000000, (time_us % 1000000) / 1000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -601,7 +617,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0



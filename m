Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E05C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hd-0000Gp-Li; Wed, 02 Jul 2025 15:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hJ-0007dL-Td
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hC-0003Za-KI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso5026227f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482835; x=1752087635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m478kLJmgkVJLppYyCk6e1zeeU4b7TwzrQ0ODlPJ2Ls=;
 b=lD6NMqJZsUpFNVy7cCPaiIDfR6EKsf1p2KcQWEuDKrSORlnfMmn2m00m/PN61/6CUU
 TjS8Mgk7xqdSxTjhUXJ3YiJ9zLGtR1fV6B3eJPk9LxPnNYWZ3eoNsmuCycDjhQ3aggtk
 P1kxo7QcEzrqbhK3AGuRhRf74BTK0UH2YHb7n1lAbSi+1OYcpflJ01c0AHTRHoReCNVK
 lhyKMbSiv3/xRFcHVdBnlzsSRl1lPZ2MslHLlHXT0WIIqlgtHGe/XZfEejZytcf0kUWC
 e2LllcI/yuv7Iaun6sTRfBdV6oPwToM7NxK59S8Rm904jmWJu1Cq36f8gh54CJdN0jZi
 EejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482835; x=1752087635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m478kLJmgkVJLppYyCk6e1zeeU4b7TwzrQ0ODlPJ2Ls=;
 b=xGbEa9OcUt2NeRG8x9JaXhXLZRpgo0pCTUIVdPDs6Ep4xV5SXLPEJx5itLKPorBONs
 s1XpFVQSyN61mz9ygqqAZcyQctaDhsLlX0JTjFmtNfKh3MVmbNsfvem3Tby53e+TWxb4
 8FC4dkp4Dr/01qdxYrYwUpxc/MnnUhJuSwADJSRyKeRTP6CeO2MvVa8yxuCfn7g3BxsV
 jEsVMbnyfWyVUIstXJYizL9kyQMErhhQD2ZazDPguJgjs4BvnGUA4ymhrQv717y8Zkl+
 H1m75gMfaVcxOutOeaosL3SZVRf3YwLXlGec8/CV0yH0onzOHD/ztX1wFHZIKOhYboJS
 0yPQ==
X-Gm-Message-State: AOJu0Yz9KDqp/X1sBysfMT7ZvogM38NV+CYtiGP8Kj+0p7tbGFV850A6
 7tugqi9nQFZCvqGzJYWPW2Qpi4qUXIx9Y3tyXuX+vQesBUvLuHb/BW74UNbR0Qx6u/ml4XfcXhd
 YWcQi
X-Gm-Gg: ASbGncvgOn8vMEOtZ73EH+Wuh1wU4Hwf++lviLAp+5AUK6VU3Wzup1wbJQgaAPwPdkI
 Nf/NcsFnCNGkmx4ocNVHZokI2Gt9xCsb0hWpp8G9keXHBb42XskVRTYFJujFMv1y1+d7GdCVL47
 s3XJ20ASlZ7u0IjiUsHsbb9AV3SZcOQxWwe+Skqj2XT0pZavql7rFB+9FMWiMbL0tCgDJfLsmIt
 u9956Y+4SFl9eccCGgGaudqX0w5CMcMbe4uNU5l9EDdaDPlx51XeQ+wELwf6Y7wHEBurj3VNT9s
 4yRruSxBc59tmYFDRpepZUGU1tWnVmAhNrrqUizgeBw8P3ZAUKEUqqKbO4Aqbbq4rRT7+Q0aoGx
 mIkXrABPp4PlSrXs0wkXvWBVFle7OvgsKmmiW8PVuH/F+10I=
X-Google-Smtp-Source: AGHT+IGCaDHO0e/Ghvavm+IfLZZ5cXi1AmPNE21/IpR1hyepRHHxu5OmKLmdjinlP+fyVJkr4jMJDA==
X-Received: by 2002:a05:6000:25e3:b0:3a4:d5e8:e352 with SMTP id
 ffacd0b85a97d-3b1fdc209c0mr2780407f8f.7.1751482835398; 
 Wed, 02 Jul 2025 12:00:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fb67dsm17067668f8f.35.2025.07.02.12.00.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 62/65] accel/tcg: Factor mttcg_cpu_exec() out for re-use
Date: Wed,  2 Jul 2025 20:53:24 +0200
Message-ID: <20250702185332.43650-63-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 accel/tcg/tcg-accel-ops-mttcg.h |  1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8bf2452c886..72eb1a71d61 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -14,5 +14,6 @@
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
 void *mttcg_cpu_thread_routine(void *arg);
+int mttcg_cpu_exec(CPUState *cpu);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4de506a80ca..6f2a992efad 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -91,10 +91,7 @@ void *mttcg_cpu_thread_routine(void *arg)
 
     do {
         if (cpu_can_run(cpu)) {
-            int r;
-            bql_unlock();
-            r = tcg_cpu_exec(cpu);
-            bql_lock();
+            int r = mttcg_cpu_exec(cpu);
             switch (r) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -130,3 +127,14 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
+
+int mttcg_cpu_exec(CPUState *cpu)
+{
+    int ret;
+
+    bql_unlock();
+    ret = tcg_cpu_exec(cpu);
+    bql_lock();
+
+    return ret;
+}
-- 
2.49.0



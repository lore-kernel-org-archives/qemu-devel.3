Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADE9C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHkC-0007A1-Ve; Thu, 03 Jul 2025 07:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHhB-0001GX-S9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:40 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHh8-00045f-LO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so4893129f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540493; x=1752145293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m478kLJmgkVJLppYyCk6e1zeeU4b7TwzrQ0ODlPJ2Ls=;
 b=rwUeWqmfTfjTx8HInOBuZD2/fSVN5F9Iyi/xFae+HLd7DPiYxTTe9oo18Y/nssxtd/
 XAA6v/CZ8ePCtAZTKZd0UtQVQxBFw7XkBUXj6yDEEOsNhf5Udx4WhbL901Lt7n6V6gBr
 L2GI+WCcF6C4XeHAzYisRalbPOQz120wTY+AZXQ4aYq9wTarpUJwbnqyh1gKiOCilnzb
 kf7JLdGUlKOaZD81fcuhzKJHK1tZ1KBHQU4uZemCiDNldZdh/XLYHzR6feVUqqfNTAcn
 3OzojB/+RzgHTjeV+xxy4e/K2vcNXG5ZM4Rlk0ZvhpI6q6E53/91LOwx+tdW07NjblcM
 iHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540493; x=1752145293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m478kLJmgkVJLppYyCk6e1zeeU4b7TwzrQ0ODlPJ2Ls=;
 b=ITMYceYQAiinu92fo2nc6eavzi1etARI2VZjp9UZ8HoCLj1/yrpQ+FVhvQMfQD0ej8
 H8I+ty3pkxxvXB786yxjDscDo00Y3PG1uhUtUsCjra7WaA21JZGVy2TRQis7RYFhqMao
 2C9QjD2hLqP3MlgnqumPZ70QgIyUU+0D4Pb482XfheALaW2gFF2ZeQ3wpG1A+c3SqUBQ
 Jgk1Kgy2vKWlveFO2UcPsaKpcbChRnP3DvoKC+IvRGMjjOCPwlnQYVGmTGby+75tdDtb
 gJo4tmHA1X2pgpOzV6Vc205EabhY1BrnWmHFb0lyzq8oTJRfCcwVmTtGbyheoJNEUmB+
 UFyg==
X-Gm-Message-State: AOJu0YyhV46ClY4bmnjtbIFap1dfrwWrOMY6RdJmHAbPCARMpQtpnJXV
 f1N3LGLY9JoIfoKzGkCv+CMCy8qdDq2i5gkST6pqALcNKmmWEN0sJrrAP1wiOm88jgOE1FHK59L
 FNMyM5s8=
X-Gm-Gg: ASbGncs5KHP+7vELfo5SMNlL4drqtuNHSlZ5XqJ9Av9Hn7MoGRVkW3zrdytIkv3p6Bw
 ud/AEye3RigXT9FpLOq5qpRtEvjr16dwLpJ9TqAL1xjRjHUqRnpT86MA+yzHYLoBCsqH42JqUAK
 t1nPVMz1svFQdQ7XtOYPrgT0saAW3Rjygn6Cu195jgjdNESVmhorrqwfWXwDyca46XQzyyyiuVl
 8TFKCSBEIHUs1fMhhefv27v67PMPNpMXvjOklAtUuUV1mUAVuYScarRS0lTxACL6spV8kYdIUCm
 +zrMG6B2vgHY5QaT3ShycKQxkCnOobkfMFLwmURgyBZTiCU4HgnArwoTJroOmMZhcmNspVIPD9V
 NScsB1SJEfWA=
X-Google-Smtp-Source: AGHT+IGIMgupF+X350G1iQE9ivRvgkFBJXHg/X2hkLxKMzy2IDW7GqsBRN5vVWJ19cFF9OZbbcgAug==
X-Received: by 2002:a05:6000:2802:b0:3a4:dfc2:b9e1 with SMTP id
 ffacd0b85a97d-3b32b4277acmr1682699f8f.2.1751540492512; 
 Thu, 03 Jul 2025 04:01:32 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fadf3sm18666026f8f.34.2025.07.03.04.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 66/69] accel/tcg: Factor mttcg_cpu_exec() out for re-use
Date: Thu,  3 Jul 2025 12:55:32 +0200
Message-ID: <20250703105540.67664-67-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAC1C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHil-00058S-0t; Thu, 03 Jul 2025 07:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfr-0006uh-ON
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfp-0003cs-M8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:15 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4573797f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540411; x=1752145211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WhoOlqE7V0YYD9gThfuSml4H33X/s4g/0Rif+XmbeI=;
 b=MM5rvokXjkI1zHorUS6YLRQthA/ezttjRZO9pleFulHWUJ06CESCZoCYEakHCpRTv4
 fXOJiGpOLyjv/vi9xJdUgoJ010t7zQ7/3aFOeGYYIjfwRPBtyivoaxByoK+sbkkjxiv1
 qzMGZq3E4hwGeVawAFiMy/hIePdabI9U0uqJxqz3UQadXEmuGsx0PEya/RcGfZ06DXw1
 XD7TS9GPSdVvebvcGidEWtKc4SfmUy3VZc4jkhWW1pifQSuercj3pNpkPJAoBIY53ey/
 +uqkOkGMFnML3liSR4Vq/9CyglkB+fg7Rs6+JgqUGjnQO/mwO8SejqOdHm4xEb4ssqA5
 eMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540411; x=1752145211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WhoOlqE7V0YYD9gThfuSml4H33X/s4g/0Rif+XmbeI=;
 b=hFexPxeDhc3fdquxF1Gg7Y8EVmOVoFzMwo+teHzcfzSlr3eA+5YIHlUQov5xpecihh
 IEhhtvi0tu5HK7uPHn8VfaG2HyzR6+DJpd2HgOUJqcEZgnWTKMKxUo3xaMFs4NSpkI8l
 /j5VUyM/mt7aqQjAebLEs8Fh5ZPzeuS6xCxKlX3AzkhvWjh1FV3Eu30lmL13+ziBb1g8
 QHZFO4YZ5leE3tWENWrOAPzB1SZxvc9hx/QhPLgtfMBdh37vMYLmqXR8WC1IPQjXeTib
 Swt4hMrWXhXTtQ8eXamXKZ1+vOmVnIjBjGgfKB7e43tDeL1WFcW6Iau3IMLeGEUzbN9u
 +zWw==
X-Gm-Message-State: AOJu0YzqX6Hr/ixKONB1iVdvU3HdQKWYbT9TR+FRykDH9Q67sybTvIhA
 QT64RzRJRkSK5F9tBifs7kPzClk6dCO5g79APRmLz6oI2B2MHeCsE1mdfYuZyDtrsxabY3hgYB6
 meDzxnqk=
X-Gm-Gg: ASbGncuaCUNHK0BiYNNyEO4Miig7vqnL3XDp6CCSvP/eAnwXnpmF6WTxCF3OXZL71EA
 cw86ljKWSFGzzXZOPtw8Xq48Fjp4BDIR+nSdhZyCmo7owAKW2HUj72upBjLcuthLfedP8zuCkn5
 BOVOsLD7k+bjypdKKnytmlvcePkJ4t0vEwXSRWiHyzIMqJQLHHfAcQl4GndupQSigRvIK21nCfD
 MMx/+U61gXW7kRySekFqoUhKFelVGde8N0Bkg/5HUUYSidlKbuwGBpc+g8OU8TIxh/maAPg+r5N
 AY6kPNI3NMPFqq382nZW9tQP9zEfoUHnuTE9jDTHHKtb38fOm/kSe+mx62BdzvekVSfYvAUri/W
 JOhnNH4rysZw=
X-Google-Smtp-Source: AGHT+IFeTMDPZVIUsxjCRROs1WZhm0BU8cjbDiSZTXDbPKt2XE8RpH1YssNTtvaQDLjG2tnATSkPrg==
X-Received: by 2002:a05:6000:43c6:10b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3b32b70c2f9mr1573773f8f.14.1751540411437; 
 Thu, 03 Jul 2025 04:00:11 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm17967759f8f.43.2025.07.03.04.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 51/69] accel: Factor accel_create_vcpu_thread() out
Date: Thu,  3 Jul 2025 12:55:17 +0200
Message-ID: <20250703105540.67664-52-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
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

Factor accel_create_vcpu_thread() out of system/cpus.c
to be able to access accel/ internal definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 19 +++++++++++++++++++
 system/cpus.c        |  4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 598796bdca9..17cf103e445 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -97,6 +97,8 @@ void accel_pre_resume(MachineState *ms, bool step_pending);
  */
 void accel_cpu_instance_init(CPUState *cpu);
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d1a5f3ca3df..d719917063e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -89,6 +89,25 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
+{
+    AccelClass *ac;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    ac = ACCEL_GET_CLASS(accel);
+
+    /* accelerators all implement the AccelOpsClass */
+    g_assert(ac->ops);
+
+    if (ac->ops->create_vcpu_thread != NULL) {
+        ac->ops->create_vcpu_thread(cpu);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 2c3759ea9be..6055f7c1c5f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -698,9 +698,7 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    /* accelerators all implement the AccelOpsClass */
-    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
-    cpus_accel->create_vcpu_thread(cpu);
+    accel_create_vcpu_thread(NULL, cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &bql);
-- 
2.49.0



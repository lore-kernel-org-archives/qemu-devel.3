Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801BECCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwLT-0002fm-CN; Thu, 23 Oct 2025 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLQ-0002Xk-Rv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLO-0001ro-8o
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso644949f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229868; x=1761834668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7QBs13fwIjO7kuSvhwOAAtMaY6vnhC/TwMzIPPo1l8=;
 b=dwdCWWQwB0bHFH56hsc12nBeTLhZyKn3KnnWxv0QlWBno0cha/u7IrW5eOwHAPrxkr
 MGZZSORFv8dwMDpPUSR69pwt8L+H7ePdbtWn3yH7ioPEbE8jhCUF9ZlpERLQz0VDS7Hy
 Tsy5iYEFQSizeIj8hNE4MI91A/bI0jj2pVQ/F9Fnb2e2e5q4/jlmWtjWDKFDGJ/ll9Qw
 Re6bpFR6QvaRzD58u8OBvb5hLO6a/I+h5cxoWd2lsaJjZ9m+5syaEyVvADZD4KAvwPLP
 xZ1yi1NuQRWxV6jn3rOD60T5Ik6mT1Gk6THyrRT9Kufe862TqRvxbwYCXVKTJR0+nAlj
 Y8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229868; x=1761834668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7QBs13fwIjO7kuSvhwOAAtMaY6vnhC/TwMzIPPo1l8=;
 b=QdBh4LqB9h/ThK2qFZOD4+yg0GKIUkhh/5ZlnZFkzQLJ9NOSPBtOjfQQpC0ePe+aLc
 2u+YCcgrGnVZ878jOShfl5AScqjHWfZtjxKJhSBhuDsur279qEWGDux1FKP4gu7DNQOe
 ZKvMAm+tNuSnMZ+Ie3Ss1m2Z2y82BNQZD9CXjh3j5DthCiDQ+Jg5Jbwv5cdEBE3tZia7
 S4gf/XGv2XQ+mHbBmBm1ipPi/UBXbWt+v+UQadZR68hChI6EGIgPDYYRQELsjA5i+bHL
 GGGJ99hvQUcmOrK7T105QJFJRHXxs+r55gsH8ulGlKb6CMzjSeXGhzV8IqHjzoCdMEMH
 K8rQ==
X-Gm-Message-State: AOJu0YxRxmHKg5Dpn/DPt8lYPcg0NC4IDC7jv4sbgBXmaL1Y7cREuWtb
 vfQcnwglRnc1VO+s74k3959v3o19tcPE5ekOpEfpxwOtJndWuGcgFDaJllAyd1eVezBnNlUBLbJ
 i0RPQ4cw=
X-Gm-Gg: ASbGncvyVgJuLD463RDs1zRFBhwBtIKrtHacUaSdGe7gjZ5ZGG1/Ge7e+iWJ7HrTQtF
 jmC0Yeb6qMf7y9GPF33pDy53ywB2+5UYz99DDOpJDVu5TxRsrnlpR6Tk8pueiKFRovizVLrUm0C
 SfVX6tcbRyUchS6xcV/ACtuDi/rk2rEbv+u1iOyr9gTmG82qwmXf55lpeIZ2ZEQMzO4c51WF6dQ
 UxsLLJJfvrooZOPt8ET3ogslq5PzWQbBPgSgPkS5DCd22LtaPjmkOFhVZK6Z2o3AHOnikMJFWUb
 Uh/Tn3cF0nQUKyISSZHKOIUawWNWoJlw5oOU+fCtzrtS6NeaJeMGjkpwfXUTOtXRK0Jct7gANgE
 HWvw4khQGSYQ3l3oDqXuq2HgjFccKYC/51tMY74KWBv5LEsDOBGmOkfT8OBXn6Hbxsks6kdnWUt
 ViUHVDKOSBf/QWZsH6FdCeyt0eUTWLyBszsjzNnxm4i8bAY1lZ5FaqNhBlQRA+onvYmnXLqDc=
X-Google-Smtp-Source: AGHT+IEFBH2UqisSvsEaSXVNhvjBovLf6eF+c90xGmup8Zdbp61fnyasxTGb0uW7yN5vp2DgZR0yiw==
X-Received: by 2002:a05:6000:2383:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-42704e0ee2fmr18050724f8f.54.1761229868143; 
 Thu, 23 Oct 2025 07:31:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f57b7sm4275050f8f.16.2025.10.23.07.31.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 23/58] target/arm: Call aarch64_add_pauth_properties() once
 in host_initfn()
Date: Thu, 23 Oct 2025 16:30:44 +0200
Message-ID: <20251023143051.11195-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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
 target/arm/cpu64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..f81cfd0113c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -762,20 +762,20 @@ static void aarch64_a53_initfn(Object *obj)
 
 static void aarch64_host_initfn(Object *obj)
 {
-#if defined(CONFIG_KVM)
     ARMCPU *cpu = ARM_CPU(obj);
+#if defined(CONFIG_KVM)
     kvm_arm_set_cpu_features_from_host(cpu);
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
-        aarch64_add_pauth_properties(obj);
     }
 #elif defined(CONFIG_HVF)
-    ARMCPU *cpu = ARM_CPU(obj);
     hvf_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_pauth_properties(obj);
 #else
     g_assert_not_reached();
 #endif
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        aarch64_add_pauth_properties(obj);
+    }
 }
 
 static void aarch64_max_initfn(Object *obj)
-- 
2.51.0



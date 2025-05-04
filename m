Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAADC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvV-0002ZY-A8; Sun, 04 May 2025 01:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvJ-0002Po-8R
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvH-0004UR-Je
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so3043464b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336594; x=1746941394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0iUuajRF9Ju9HAVblTOBk8R4VBHR5p055b5FK0U9oc=;
 b=TXHKYDLXYoMk2udwOR0YixzXCo9zIEQRFNIbKqkVSQ73RBHtzRG9XwZoDCNoqWp2n5
 y59J7SIR36kAuZRQ7u5PrTZpN7o/hdY6f4QhJWqbF4IjXCbvBISiQLvAtJUgMqMM1rB/
 Ys+TM79L2SFoP5SFs4AlqEN52ZAIIjm/wVb29/nqzWvW5p4m8Izt+96AJ7acGxQSKCnl
 EUYivc739hR22ai+xgWtWtGuW9klWlJMpnNkdLRTTD4dVTsAfRok/PCczLyJlDNfixJw
 z1DAnwuPmKSOM+2BYp8ULHhPa+En6IUPn9wE5dAA1kXA/8xYFLJNydFZH+uxBt8WPyLY
 HjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336594; x=1746941394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0iUuajRF9Ju9HAVblTOBk8R4VBHR5p055b5FK0U9oc=;
 b=M/hzO4vNxTdFCGnpEDF/ydg3ivDHMuOuzNbfFeexct/vVI8kAQIMasQfpOPnD47zhj
 +wzYTrlF5W+ykeFpvF/pqe5Jf3ksdgzU1WrwdTMBLlKaIYmBylWvIL08ZVtnNgc2Xfnu
 XcV3FJtJLMwTzIuyInFVeeJXKkYC1as7Zg/hNRg9EbBi5/3SXVO7V4fs9jPi3iEMs82C
 luGmvJZiuUzcYdSYAywW8oZ3w8Ok/bAG2+guxLu26ONQJPLkQNqdgdStLuVcpcg4zDW3
 JTWz0NnSp18rJ/cIDrNE73g4xKCdeLoVMQmZRM41sqncvK0XPfxjQfhGfMNga56VT3S8
 ctSQ==
X-Gm-Message-State: AOJu0YylR4OepQhNz94R01FszDB3UV/UwdALBn++wFHXT2+tGfGtyQgk
 tl8IfqQChP30/lesJXWXOpeywQOzBhH4ri+2TU+GcHa+j63m1W8zMEcaheT1C5jN49Vs0AnQitz
 7UdY=
X-Gm-Gg: ASbGncv/6ke8f7FQjZTEW2QHl+rWj1868FQRwDyAtjGt75Orh5LQtKXHFoOsAgAQZ+o
 mSfhQyNrdi1u+Uy0jOPpbBRHWAlAyq211RnSlDT9Jv2wmcfzabz1K4Bj9Xety13yu+e2L5nGtq0
 XvO+V56rLV5GAPO9rSbx3rM/nMfCCYfrDebbnvZN8iIOkz7QqNyG3CqgZRuq0PdBz+NHgJObHMK
 rQWRwf5dARkBuhQJ/azSWsTq9nA5sh7Y7XIjr3ZN5+/KMIBXjrHpntoIEYYQLz0jLBIGRqiU/HF
 6ueBql/Uh052zDDsjKFSwUEB+BgYPWXfAF5pmLw/kGkwkFPcQtY=
X-Google-Smtp-Source: AGHT+IF+EPugBKZQllOB6ZlaN9XF/AgCeG8gT7XrYMYc5dzrkZ7ZMMR4F0EEYWmv2FreUz8tb1cCXA==
X-Received: by 2002:a05:6a00:410e:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-74058a568d4mr11150341b3a.14.1746336594179; 
 Sat, 03 May 2025 22:29:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 39/40] target/arm/kvm-stub: add missing stubs
Date: Sat,  3 May 2025 22:29:13 -0700
Message-ID: <20250504052914.3525365-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Those become needed once kvm_enabled can't be known at compile time.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2



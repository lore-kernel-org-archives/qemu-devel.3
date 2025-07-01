Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DB9C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSX-0005dd-R8; Tue, 01 Jul 2025 13:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSV-0005b6-PS
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeST-0003a8-MX
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso22607165e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389668; x=1751994468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LjPg1QfOBbDglyOlkTx99ANQnGLjk1OTG3KagRxzjyU=;
 b=u82T1diAzHUIYTCc15ih1IgDSa4qpfc3dNNEm6ffhf41Mccd+AJsVhc2mnIHQxyfyA
 02CbQCH2yJUjQvAgryICwAM4mZhX2HmkfhfCJJiO7PDJcH8u2hkGKX8HFlKOlULkSDG9
 1BfrslatFBcdioH4zW/67LbztsfigbUaGxTsSydnYMCdY6Y9P9gNuIYHGSongxwjwvAD
 H0kZy3RlM+qCExhCqn+K7H3FKq4kC03q3Yitln/JfJWJo2VxPWWa+HJLrqZISAfFeLhF
 u5VAUmCOPr+h7IQTyS9fwTEd7NSymk6lW2ifVnkw67ezzZ4N4PyVy6xrpfQ4lfWfBmsc
 WLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389668; x=1751994468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjPg1QfOBbDglyOlkTx99ANQnGLjk1OTG3KagRxzjyU=;
 b=M54/sFsWeAQ8tnNLVgJT0eeYYw0Z+o5Az6MbhjoyF9kUdk02VyzDa1aJTJTba9Wiv5
 LrWyzYB1dJ8Jp3Xs7QBuq3w//MGLgDYkBeu+pX5EmmOV0/5QTE3QXF05AbQJmsYo5Nau
 bYOw1mgOGEp1l+xvdiH+YgtF80GfbsbGqetjuwISn1xpsbrzUYw8a46u5SCN/ekVLBSp
 Jcbl2s2gNEalXCtcrnvc3akAICF+GM9naZhrdd1UHaKY6dS2YE1MCq/RTskqJRQteXX8
 kryhrVLyVEKnGo8j4RDevOm5DBxSlWn6xHeHOlSuwDNLlYb5kByWZDM7px1Lo0cshtCA
 N6Zw==
X-Gm-Message-State: AOJu0YxBKaryYiICDG0q1YtVpvbIrEj08TfL8Zop6GHBgcSiyRawDMij
 d5zagZFNk7BQfA82FEVgBHSL+oQaP/THIYzz7Qk24b3FYiaCg4UrfSH1IRzYHuGCApR02J2PUDd
 jMusn
X-Gm-Gg: ASbGncsszeMbxXRvOziF4J54Xbxn1JRRl/NjxHM+3m5qlYfBANoR6cUAn59VcyuZkPa
 g+TV6swRhGko6OcQxnJwkvFZW2yqbJAp06za7FNLPwMzs3TqmtJJine1Q4bCO29wLrJmouVgtb1
 1Hs8qFhe6iMeKz0KBnUvBZbsJcJ3hCjwBFFjqUAIS2r8+QHQkfpt1Ds1+hoGpQCIysAPA45k28y
 Sn28Z+LUbDsNHS8TprKdb8OAOesqdEbmQDbBowgyhRsgyr6hTTlVh94eND9E6VvyohsXWhMKs7B
 8/J3lX2V5oXgjenVxbE0BO30Eyh2GyGeQoR8HOKWaidipZ3WY20B8GjAeyLxZYl0zK3a
X-Google-Smtp-Source: AGHT+IH58ODinTQdBnd3KpZikR9SXrkYNjVSN+N/eGSbAj4pJQDD2K71e5vuHRwlZqzHzoRVUloo9Q==
X-Received: by 2002:a5d:4d11:0:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3a90038ac3dmr14070867f8f.45.1751389667806; 
 Tue, 01 Jul 2025 10:07:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] target/arm: Reduce arm_cpu_post_init() declaration scope
Date: Tue,  1 Jul 2025 18:07:01 +0100
Message-ID: <20250701170720.4072660-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

arm_cpu_post_init() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 --
 target/arm/cpu.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8744922330d..03381539238 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1168,8 +1168,6 @@ void arm_gt_sel2vtimer_cb(void *opaque);
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
-void arm_cpu_post_init(Object *obj);
-
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
 #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8e77414c2b9..7030540f91f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1713,7 +1713,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
     }
 }
 
-void arm_cpu_post_init(Object *obj)
+static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-- 
2.43.0



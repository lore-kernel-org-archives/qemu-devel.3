Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FA4C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRf-0005yD-OW; Fri, 04 Jul 2025 06:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRO-0005uv-M5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRL-00068Y-C4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so4169465e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624081; x=1752228881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yU4jFODLQ5Yk9FO8VyUpgwPHGFKBwT9h/DN9+uzfxQ=;
 b=SlCjpdPPkfJq61JejPhZ2Wj/AVyto4Rshs7bw0nA6JtWLpDbnVIh3vnHuUyxoqFbd9
 /pREJ82KkPYd02K+fN3yeLDyWQr/nly7dyQqlxShbF+v1Z2BwqsAcdLrwnjjywELgQvV
 Vu8prjPmuQ2s9pz9ma/DICwokTOKhDgOyn1ZJtJiV4nNQazyHk7cz/UiyIIg/WBriYmE
 5lLgeQG7fstVx0wQBeRFZgbaPp41gkuMRxTAyfWlkrwnsPbLUvtRH3v9r75x9TbDrrS7
 KIIkULI4um6Yx/1rOdTYv3YVfaZa7T4V9Y+Yu6lEuOOUJ1g5KcmysMZZaRUw4/Qsy7Di
 w6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624081; x=1752228881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yU4jFODLQ5Yk9FO8VyUpgwPHGFKBwT9h/DN9+uzfxQ=;
 b=rlJULHRc6oIYwYWWaXhs9EyQtSASDNPjdou4ZmaBUeHqoOItPacXw6NTY3bsj13RAF
 xrZKOJwwr4yNVH9DMKGhlFwL2SVDgigS9IyyXOPUWBCWRPJGyFkJR5m49GRhtM2gHUfh
 mv4L+CoNKlH+53BbHYP16CMURQOOqq5F7Nudx0fdRdYPLJxwEwLHhn0AQFLI4RqxJOnW
 barGXYGb2Wqu1ji12w7TYC14DFKjty7mI5lN7agqh+Yv0Sn+snNi2iwgVpsI8jYPObPF
 UQ80Ju4fchmqJ3Xeq/DKzsfGj5Ev1pXbPU9KKILSD3VJPocOAw75vIbq6Dtmid9o4tsz
 rTWg==
X-Gm-Message-State: AOJu0Yxybco9z2H9fNDT4BnjHfnegXmxnqbpX/0qMHUxQ+0Ua5LdaCRL
 J1dSJLVAwvJqw326QU5pQN5p5LgGdY1u+408lGsk7UVarPgO3VUOwpOyXV44I2+efFV8LPgtJD0
 ezlcDiJ4=
X-Gm-Gg: ASbGncv7RSJGoKO4Ok/6uJK8pMt/ARa8EXsoOJs/l+I7jq+2BVbqBvW250BSP7gWGgT
 MotoNiUQ6nA+vC24QwswlioQUK9DKwioDEtNO1Yg3zkQ5XsGq0CqLbAiFdGa+ylW8Lbw47Znjta
 TmlsuJYt99RN48VFWXHBPkThYLClEUilr9shTOaWrDytL43hQly/t8d55w6/3lkihtxUxJNCrjR
 g+W3eD/4Kdzj8W5ZTSp+hUOv8b4A6ztuy4EpWNE3sCQTUbCpIychSNJLgo5Vn9m+brGpR3T4Ph+
 OVatSjaXvahf1ZbPQK8WvgGNJIt6XmnYVrkgTxHT65y7SqgXl5yOjVfwMsSbh+eFSzpxLYSGdQM
 +eOKsdf6z+FcALrdhwjO/9exiFR14rOWq3T3m
X-Google-Smtp-Source: AGHT+IHsGoZ40OAnCXH3jYayS4gvuTz0xGTGwM8GhGEypnAAhuhYqUglyP8eggPVM4UrMH3RqdCyeA==
X-Received: by 2002:a05:600c:540f:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-454b4e67f8bmr13368495e9.7.1751624081235; 
 Fri, 04 Jul 2025 03:14:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bc79sm2100514f8f.9.2025.07.04.03.14.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/31] system/cpus: Assert interrupt handling is done with BQL
 locked
Date: Fri,  4 Jul 2025 12:14:02 +0200
Message-ID: <20250704101433.8813-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-5-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..6116644d1c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0



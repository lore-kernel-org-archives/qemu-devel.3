Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B9C61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaDg-0007SU-0A; Fri, 06 Jun 2025 12:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaDJ-00072S-DK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaDH-0003Tv-2M
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so20498785e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228397; x=1749833197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bscCZhJPor6p9xOGYxKsyHkSJQbAuOk7LsWMwFm7sCY=;
 b=II/Sxjs2GBolN5lwLhYzFLIJkxWKUqwdXU03MlPZ7Ekhc1HXrtN+Uh2R5oSOCgm3bP
 db7kbnmvAqFcPFaM1l+WZ0s6UcCSwg/vARbvWi4KYmq4HAs/ixoS3fvnugNCmGmA4wbd
 yK+j0ZFeGhrfnrwvmmt5unXBUlzOlYYuQq6yN1rJkXgN+ehePUvrsdsKtXpNReOAhrQH
 oKwlkUP33h0+5QRLLlCzlp6uRaQ1o6SVOOW1iT7Lv6pFv+5Me3neuTarp2hnwizSbGUA
 IMfUvEJAQyrsGsUhShNGlk8cOUvO6YFrNgq5oluQIGnQYk239npc8vpV8Q1sG+Azpn0F
 Lxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228397; x=1749833197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bscCZhJPor6p9xOGYxKsyHkSJQbAuOk7LsWMwFm7sCY=;
 b=rM9x5jSsqGZFNjlT4nG6pYwZe5B9kHTCyzX38zY+FTZKOFuKVVhY61kkw0ztIszJ/b
 pkH1O4YlWCcM+x9BT2SaFCT2ZpUBEsy0Zk2vj/vXNC6zES+d7/AZ+3CwNDG82VvI4s18
 P5YI3OpQZTquzc7GuhESUDuGFkvmzs4h0XjHkHiY5dMwJ4T5QnAYvsdof7Ykp42bMgQ8
 ijNKz1dVndXKWVo6EZNjWTFBXC3t587NQwKGv4DuG2dYYKPv5tep7c9l+KGjnKia6oLK
 UAjLavuE/ZrGFT9N2JoW/ai/Fc9+Tydzo5MmNhgLV8K+geTsXP8eCjFFBT/FzZtMDrDk
 A6iw==
X-Gm-Message-State: AOJu0Yx0ymsSIzomi2UPoeY3ljGqcB0TUd2Z6E9ld3FyZPt+UUJOwIkJ
 38Qqi4m5apwQ/YuNLIstpqjcgYG3fhdwGYlZffJb0vjkOydWBIOVFIfv5IPQFnlH8DGOQbzA3YF
 HXR/915V+0A==
X-Gm-Gg: ASbGncvwydSGSaNKN23rmCfH0/I+kvFbN4nVawUu1KxOilZtviLUdIY8WcXE2M/zAm/
 EbugkRGgkx1BOGN5Oq7MCiHCORB3VSHraVLelSq/dGk4HaKTpU5tOy0yMSgZcFDe010SOQAu/RP
 QaM97RLcmKOGGTmcVKHDadKU3IFLO3IXeu/29oSVn85fTIrjJ1b4vhHty5bSG+PSZP9vtI3tBp6
 O8CFPNhalz/OI5itkN0aSQip42a2CsC4FfCdsWapfpYkbVXQA7sy4F5EVLAmj5jENkdcDbUDa7z
 xanW7yMWSbucnBflh8HVMEkXjIZ6Xjcr7EQXqYSf+UmBkcNwfDHF2eFvy9duVVTz7+qCX/DKmHL
 qzSUdMyZ+P0q0kd7KjJnKdBYrR5PUC/p4jh9vXg==
X-Google-Smtp-Source: AGHT+IEfieFC9wvJ1rs1Wl1sCKCoM/i8eGhzo/CMfNmSSkbUp9KqidKwZLdkvGDV0kTw1gduv9DENA==
X-Received: by 2002:a05:600c:1c1b:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-4520139c741mr45100795e9.13.1749228396991; 
 Fri, 06 Jun 2025 09:46:36 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137277afsm30506935e9.30.2025.06.06.09.46.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:46:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 18/19] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri,  6 Jun 2025 18:44:17 +0200
Message-ID: <20250606164418.98655-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 21443078b72..bef6f61b776 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -61,16 +61,6 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void nvmm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 /*
  * Abort the call to run the virtual processor by another thread, and to
  * return the control to that thread.
@@ -85,7 +75,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = nvmm_start_vcpu_thread;
+    ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
-- 
2.49.0



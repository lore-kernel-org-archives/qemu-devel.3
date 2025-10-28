Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D11DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd56-0003Zq-7o; Tue, 28 Oct 2025 02:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd52-0003Y4-Jh
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd4z-0008EV-H8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:21:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-474975af41dso37851055e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632471; x=1762237271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D0jmLQ7xJcwtr4+38+nkD40sCiXmWSUTp82bWsui4GQ=;
 b=Tk9KW/y6dqm/AKrQZxhfy5YYh1jLkDHejBCiLDXO3vdPmUK1Y+8i5kE9w4HU0f/MTT
 RBZKZONHVK+Zw2Y7MOdMzU0h1rAH65Nsek01h2GHgjLU9vDn3xLoV1PKMxwuTjM2n8R3
 0SsVQwvJ7XsrYWR4E6fNjKa9jUpxcGgZaeVn3oD7G/hfwVAlT/EetKEPRTLVQI8OwnUT
 7VV9vv4D6q8bz84K00ekua96LYkIDYFuroQxlliLeVubnhLWVMa78gbrpIu8mSLjFBrs
 fRIxRpn91MrhKHJrx0GtqpoqZHWKmUjLhurYaL93BaPTYJkbqHKuETdNTDkewpKWBZjB
 XFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632471; x=1762237271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0jmLQ7xJcwtr4+38+nkD40sCiXmWSUTp82bWsui4GQ=;
 b=BVtNEbCZn4tQ+9jhUbYu0jfFkpqv/KRZnZONYHxbBLTnraWOZyXSniFNjOsL3ZsxAM
 FSAdjCrsCKnpG2Te0tof6ObnYKSQqFhxxjPpJTSi1OM0fQUgbK2itOhVVKsP4Pp6xwJe
 bhd5CWfN+qVryt7fBHAoREf3GT9tJtePwhbVQkeDPaU+E8qYjG+zBJudgwa6m269Vfhp
 8UKYXy0c9VtHLF7fKgAbRKUnkr8IF8pN7Wq93OG0l75LY+hN9Lc/cPVG5iKcoYLJBnTN
 vw2GLH0UBPke1q8Noak1NfFqYtXwzjZIN7kk/ILdB40arCOZfRNa0A2K9Ie1Zlz0RzNk
 8PvQ==
X-Gm-Message-State: AOJu0YzaH+UEzCDANZOxX0SRC44ghrweDW6n4Y0zkfypdbTLPtivZ5C6
 pcAbKf0rK/mU2o7UzYTghi+ZzoGCVM7VXQuYg7Skyt0E6bplIW2cggfB4IkfDSyK8y3M8vydt1j
 C5iquapY=
X-Gm-Gg: ASbGnctXM0c81kf+up+cZdU99FW8ZSV7OckNqcyEE/2Q7WmwjWrnLOdc4Yr3bblBDWz
 9aMFO3ibRwaYfyHm/6Eik9OFOfXKQHUqUHkSL31bwbmCkUzZ8JhWzNBfrUZF05ff1hY63To0abm
 09KsH0Q807/Y/T/PsEhcHSLR1wqHDY/YkXdzonD2TG6irTpfoseSxWE1xkTpF8+D4gfAuxedmr9
 n6/UuilUsf92AmO8IS0QjwfPWAAvsWVf1cdDKfYqn9+8dK4BSXdAYUWs8EunANgeKZCawFPapiL
 wBbwpnvFQRkAlFPt0rWkO1eD14+ZI3zz/7x9Y298bySzpQAI1tgbQ2o6ThsUHELi2I7C1zw3M/K
 6Su/RL4tlvMMnid9EEhSbx2MBYKr6iDodCjdNWjl2AgSmsV4Xj51zlHQfdnTniBWhG5m3U+Wkad
 RpmeJ/KA90/ruSrcT7/SIwzUOqRhKnXZHXaFJfB680XzR4NgHDSKgrJEM5yOOLOwB+4w==
X-Google-Smtp-Source: AGHT+IHhajkNrNNZVimRegSS7TPNdkf/SoG/WZE/1rEfDevQN/sLYG4tDIlVIQKx4SRvLt9Dnryn4A==
X-Received: by 2002:a05:600c:8716:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-47717dff8f1mr14761175e9.14.1761632470609; 
 Mon, 27 Oct 2025 23:21:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd48942dsm177891235e9.4.2025.10.27.23.21.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:21:10 -0700 (PDT)
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
Subject: [PATCH v3 54/59] target/arm/hvf: Flush vCPU registers once before
 vcpu_exec() loop
Date: Tue, 28 Oct 2025 06:42:30 +0100
Message-ID: <20251028054238.14949-55-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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
---
 target/arm/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f5bab7e7213..cc02df2e907 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2015,6 +2015,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    flush_cpu_state(cpu);
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
@@ -2030,8 +2031,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
-    flush_cpu_state(cpu);
-
     do {
         if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
-- 
2.51.0



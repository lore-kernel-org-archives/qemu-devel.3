Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFBFD12662
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQUXp-0000iL-R0; Tue, 02 Dec 2025 12:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQUXY-0000fa-VB
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:51:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQUXW-0001Vt-Rr
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:51:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779a637712so36462585e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764697908; x=1765302708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nNAKiD2KFQe7dDwm1ph5n7Eqp+TtKu8jd1cW1u/1N9k=;
 b=elMwHUQRmOaaQGRtsphMqmQhedC2JfTcOK35Gxn8W+6V6g+Yb0yBXUrFi7BqpXDNGw
 wMzqtlG+rpnvwErmnLUXIU1L1dZzHYmqOBMrypsaixOksWTVb8C3pTcHUe/bLyU4Rpue
 +vxdt0mnbC0eK4SX5BYicbCZN0OFoM9zNeB0Y2k+hj5MIA4GDzxxeDDV8hLUghzVtQs0
 PsrG3pqp7u1sxFAflqAUvX2FByYHF2zqhH/1JvjEP0uDjZHakPMnM6Yia0ih91E83OIt
 KQSij64XZR5kqD7TBfDqDT6CTCJzlX0Qh8sdHMAmH1U9PYR/133kCT9zKevbrgeAD111
 sxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764697908; x=1765302708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNAKiD2KFQe7dDwm1ph5n7Eqp+TtKu8jd1cW1u/1N9k=;
 b=f+81AvGzqeNIS91RP0nIXa3MNIoDpVAxj87jNmKpwVgCSt6TuuG7jVOr+N0DR72BAp
 ZEt95RklPpYcj24JxCobc/OxjMJ3wQO+cbNgDTDAppmQL3POHG6nohukRE4VnDNucTzV
 70zUBAa1aF9vjHRk6uk1vXSjcbajZsxPWaeN47sAkJI4bMeHUq9BWuOZovv3Gnl1SUT7
 FjBV/vsv+/AltiXU7yKp9y3E5ej+POPhMqJKSCCirh7BWzTWZvzCt/lzQ2XsVo3OWKxD
 RkmiROU22B3KujsPon+Rh4v19YadgINn+E9vfCpv8UmuHZ0ZWmCHUtPfo2Ncc+jdhAqE
 Lkgw==
X-Gm-Message-State: AOJu0YwvsActKtkKYr7uczjpdSIuv2hk81srpn38gHLomHcgXTDRWfZy
 iacLQCBmGNmW4/QCbBdULU8UvWzIRNeYWT94lHI5QdVaiqsxh6ygjbMDrCTmLy5iD/Oz8dm3KKn
 SJTMYqFw=
X-Gm-Gg: ASbGncvvvT3aN5I11mJSN7GPgy5CQDXRMiUNGH1XA0o3rGs29xrugp1hkkP1LZEMbUH
 u6EaGE+eY1X/Pw8OLMMrQEaV+UxSPuppvavLyPJ1vNZ4SeGaDl6vWy/2Gt+OrT+xf8u06lWxzsX
 Vnyc7i9v5XLCGF67asBhPot09K4+x4FSEsQu4Wi+wJgiU7Q5inDZGIwFPXT5cyArJZ1pEwRoQ58
 r9GAWSI9a2zRMo4L4RxLAMLq3ikebzvhdMGxaK5YJ4yetneCaogSftGKyyUKhoMXJFk3VwtkQ9L
 9C1GrIR9Fb4u5RkqO0DjLPlvrkgpHhgHnsIllgyNL08rngrJUN3GF608bdidCfrH2hp4GotFpUH
 2eHUK5nl3zvLNv5+zZ0rBF8yz8hjxzeDGPr783CjCRNxsv2Cq6oC8Jn+MDSw9kmHOJFR3hvOQEu
 UwJiMRTDAJQD10fHJfHXEJOO8LHu7cJ5D3hMbsJOtDtFO+7LlheeSrUs7r+foKfkHkRjeKV8E=
X-Google-Smtp-Source: AGHT+IGQWZrnhCXRrCNucUhJWFiPNs+g4YtJpn+pbgmUbfXkiD1t5XGrcULpcuYd3hQi9/Yd/6veiw==
X-Received: by 2002:a05:600c:1d0e:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-477c01c4d79mr401104005e9.27.1764697908157; 
 Tue, 02 Dec 2025 09:51:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a6530a5sm1689915e9.5.2025.12.02.09.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Dec 2025 09:51:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2] target/arm/hvf: Break loop if guest halted vCPU
 during hv_vcpu_run()
Date: Tue,  2 Dec 2025 18:51:46 +0100
Message-ID: <20251202175146.20331-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since commit 93ac765076a we try to call hv_vcpu_run() many times
in a row, but we missed the guest could have halted a vCPU; if so
we need to return to outer loop.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3230
Fixes: 93ac765076a ("target/arm/hvf: Keep calling hv_vcpu_run() in loop")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..10ac5559ca1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2029,10 +2029,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     int ret;
     hv_return_t r;
 
-    if (cpu->halted) {
-        return EXCP_HLT;
-    }
-
     flush_cpu_state(cpu);
 
     do {
@@ -2041,6 +2037,10 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_INTERRUPT;
         }
 
+        if (cpu->halted) {
+            return EXCP_HLT;
+        }
+
         bql_unlock();
         cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
-- 
2.51.0



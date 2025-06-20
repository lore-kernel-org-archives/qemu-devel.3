Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1776C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfP4-0000mr-20; Fri, 20 Jun 2025 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfM4-0003hK-EM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfM2-0004gW-Hq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so19672415e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439800; x=1751044600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7Q0I9KRKGwfpnxMkCGWptv5CW/tc1a4iSXRbv+1UdA=;
 b=aoV4RINRYnY/wnDNJfpBZPiokqmHIbQcUDTDHS2XzqQMrjV8Htm9FhIeJafksg2Vdd
 Kf5qT3OvmmojG0JHOcL7wQtT/xjWhbWLrlyHYShnKe9LdlS0O/31fPJ0w2Og2D93qsef
 MWvO0Z86xg00gJQncoTscFYyW7CWAMrQdhHQZKPBz0IK0BKlzMFxw9BJGtTXFUyE82ZS
 Va//BHHZ8C2g1s5ZWPPTXaun87ig8pRWQA7Q9d4G5r+TvoppKP/6/HjjMu1R+OxIpkYk
 jJIiPNJuaxEslywBJAbUNcLrsLHBYBPtiPxOltN0eGpd7+3fWQ31WsduJ2jWrFuea2/b
 5rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439800; x=1751044600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7Q0I9KRKGwfpnxMkCGWptv5CW/tc1a4iSXRbv+1UdA=;
 b=MQjQFHTvi+SoT3wZA8EodqtVNzGOppHEYrhwsmr3nBL0Hp/l1OR1+nwvr3e594S1gg
 IeJ27L+E2xCPSYoq8vG82Hsvw3lRxzDaBp4YA3uQ1JCY4vgAguZ0dMQx6EwmtZzpAHcz
 XEU/whEf8v6yzIb5WkMN/hrO5vySaZD5hU/IdSH/xAe+en5wz7me/QcCr2Mu9J0QKppc
 eUPAN3LomWl/7liLAxvCujfnsQlw3nY5ug4yxM6dL76hHin9/n1oNPRvbuvnHqoPePtp
 Hxfs75fVFalbZ5qONN/x8jROzAWRUdPxqLq85pJ80g6rBYxFLReYdr9DpKjDl1ptfy+T
 rGeA==
X-Gm-Message-State: AOJu0Yzs2rL/onR9KD5q6ysjYQbgIWZmdxFUm4/6rpG7EnRhZQtgseP8
 GN9in7z6snhWkbiTzUX8oM/WfUziKEOVnqF4cclLGdbncYCSM7ZAYo3oPE493AjyI8cfVMCdLGJ
 wk2oY8qw=
X-Gm-Gg: ASbGncuWscahf6u+ZpHGrQRK/u3YWifqIu8hFwPDaAPm0OcwLTTyQ/mem2mY35l1qaB
 YEWBQJ2TTV4LAu/UCDEuZs3fyNgp0j0uS6O1TzkJESXYfqfBgMBfFMYjhw0aUC5pE/2WfA63tyL
 vh8SbbtTAH6uXt8+PsIY5otpAOj+IEW6ZNAb3grL4zGivsvrG4cWm6lGIKsVEi1ivaThWglWOXY
 lyrB2L/dcHBLRsT61vLcd2ehQEIZ0GpDxpEq5O5NYKN6+o9REtgRyohHt7sPdctmbbWEetFytj5
 h8NoEmbKPWiym/zcPXhypIaxr199/1li1gS1oUdJht+orrZKA8PAWB2X1UoemupCrD1N7rg/4rm
 iX2LPNcjBcfKIpUmqnmDIK88S/WfCCyA/ndUT
X-Google-Smtp-Source: AGHT+IGWva309Va35eIX4bMH1Q9vtKZJIz9WhLCfTcF8FABRPXyGCrUwok25QvATTfNXMGnilTIv5w==
X-Received: by 2002:a05:600c:46cb:b0:44d:a244:4983 with SMTP id
 5b1f17b1804b1-453659c4973mr40974665e9.3.1750439800499; 
 Fri, 20 Jun 2025 10:16:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e9844a9sm66315435e9.12.2025.06.20.10.16.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 36/48] accel/whpx: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:29 +0200
Message-ID: <20250620171342.92678-37-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 target/i386/whpx/whpx-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index b8bebe403c9..c1b27d1b89d 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -61,16 +61,6 @@ static void *whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void whpx_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static void whpx_kick_vcpu_thread(CPUState *cpu)
 {
     if (!qemu_cpu_is_self(cpu)) {
@@ -87,7 +77,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = whpx_start_vcpu_thread;
+    ops->cpu_thread_routine = whpx_cpu_thread_fn;
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
 
-- 
2.49.0



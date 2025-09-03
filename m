Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F0ECA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPq-0000L9-AX; Wed, 03 Sep 2025 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPo-0000B5-BI
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPl-0008Eg-Lm
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:08:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b8b1a104cso30190735e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894108; x=1757498908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfBUeAUwt+eqp/pj/TWibPsbie+q9qDh7Zc332DV0wI=;
 b=vkx1hRVVGa0hhjDY36JQG6H0nLZcViTlkd4yR37B1dOE3AWYPzc7CEmx7uL2cStfck
 15zEoqRPuGmD9GqE+WayQojeMR5I/yFO99wLLITXIKzHfylJkJudwh6E0QCY6Lnd67XI
 j/BlDGBM5IoL/TINw7sguIDmmYI2EwgpjFmSaOgOK4EiPJFgcaTcjb0LD8XKwJeXUDON
 pPaNpKoZrBidEKQJXkjy7ufxhcUIKrbN/3WbAZN6B5wM1R6wyeSkjvvIhNkrmOJ3Imo7
 LqVUqnjkDG2OwRb94xRz5I7IyzumBSjGH1/ewonfnrj2OQv8T/SV+/U5Yj5GrbWz5Avy
 DaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894108; x=1757498908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfBUeAUwt+eqp/pj/TWibPsbie+q9qDh7Zc332DV0wI=;
 b=UmIr1O9nBkJCmYVZ4RAY0BOpG2XNXmTjKOJLBAhzjUtj9fzgKdP9w5lY4qGTuoBxHa
 D2SQYKGQhlKFUHwKuGqVh23DOKhHS1dOH3pxhaUW8Ntc8ik6dIsc6w66mpZfeuwcjoSE
 lbjfYzwJnEYkOYQHskIjQBeqcnYysZM/vn6hokV2TOtdK8Qa8cDxwbT+X0ULLsVHeCwG
 6qWmKN/lRWS4zR54XOITOliA6p+eVnxd1A8YfXL1KbqCFW/nZXwZkldnJTZ+EqRDJjrc
 vUCDHG6mMzDgBLbjYGdY/3q2/AYqTgQOiRa+oQJbFJhaSTopEdabNQHiv2X79KichQd7
 pHQA==
X-Gm-Message-State: AOJu0Yw1ocEakBAho1ECOgKu+c6YphsmK7Xnfv2V9+TZE8FapQyXCpaQ
 RTMrbzwt1P1XkSYkQI9k4q8McV3z773nkSkCZosATZCSHzeE3wCNVGSwfOv3BkuHISYpfkW14kr
 5juxT7gs=
X-Gm-Gg: ASbGncshHmu9hBnNTHk8Y1KdcD7eS4B/u8Ub+QKeT4bNmpRewR34I8XcWXL3uV8+7IE
 HSPPRkCxfCFC7tFW2veNBQkz3hdytcwPj0hykmC7C1ALBhsUHoZA5Mn+cNg+ncPxs3qTgiKaIYe
 iB+l4XvHQugYqg4nE2tnx+/25pCqKTUFSlenzYbk0cLa/kH4yqHOXaKVsBY6Dj5JcF/YQ03dlPj
 958dEI0eYSVe4Lso7SAOqx4J6ZkgDE+SGy6hACFB5GB9lC9SXqLBK2cNPpvZbkyXtALDmpWsLPM
 HFoDvS4MSin9eujZyEkQre1WLbAXhMM5ex7HUsO8inaLm4vRqKj7ctfLFRzyOFtNXsAtAmcjvsC
 B9xiluZ9pzMfgdiKYu2VLoKc55esoslBtQoA1cNwDejK6b10kQpcXy2eKYekZYaO8RnzAgdgnlw
 lRx5SIKw==
X-Google-Smtp-Source: AGHT+IHrZQWslXtIwFReCRNiCOlC1Ec2aBaEU1WWclLbkENvnuPBMNYygSJuQ75rsyGcP9LSqcQnNA==
X-Received: by 2002:a05:600c:5486:b0:45b:8d2a:cd09 with SMTP id
 5b1f17b1804b1-45b9bd607a7mr34954755e9.13.1756894107799; 
 Wed, 03 Sep 2025 03:08:27 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b813816desm127741245e9.4.2025.09.03.03.08.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 07/24] accel/hvf: Mention hvf_arch_init_vcpu() must run on
 vCPU thread
Date: Wed,  3 Sep 2025 12:06:43 +0200
Message-ID: <20250903100702.16726-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

hvf_arch_init_vcpu(), along with hvf_put_guest_debug_registers()
and hvf_put_gdbstub_debug_registers(), calls hv_vcpu_set_sys_reg(),
which must run on a vCPU. Mention they also must.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h | 3 ++-
 target/arm/hvf/hvf.c     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 8fce627b08c..0c335facc3b 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,11 +71,12 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+/* Must be called by the owning thread */
+int hvf_arch_init_vcpu(CPUState *cpu);
 /* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
 /* Must be called by the owning thread */
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 58934953c4a..d87a41bcc53 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2244,6 +2244,7 @@ void hvf_arch_remove_all_hw_breakpoints(void)
  * consists of all hardware breakpoints and watchpoints inserted so far while
  * debugging the guest.
  */
+/* Must be called by the owning thread */
 static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
 {
     hv_return_t r = HV_SUCCESS;
@@ -2282,6 +2283,7 @@ static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
  * Update the vCPU with the guest's view of debug registers. This view is kept
  * in the environment at all times.
  */
+/* Must be called by the owning thread */
 static void hvf_put_guest_debug_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF9AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s91-0007zp-A3; Fri, 03 May 2024 08:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8L-0007Hv-0C
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8H-00032O-Te
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so78712165e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739719; x=1715344519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=wjXV8v5+nLa6yd1Elu5FeD7gOCFbngXiTb6DKLq+m2brXsOEg8ygYTqNqO39oqlGGc
 fss+Omb87pnt5UOs3ny51LMc4F9OnIAeJZ/d47y88FEbV3ny9zqzF7dZyHc1qg5eOnNr
 d3Jya6/PB8WVbtzEcIE9aas6TJ939bTY2zfuwsGPa1rcLGG0Ic4ggTM9jkqpSQadrNIM
 aJ4ZH0Jm27KMlB0dFSjwLTN3auOA3/GlcSvo1PNeTfmi7EOYpYY8rR6s6BxeahibSxaf
 UROnAK5BlMSMHnuW9IqURpvjdM9GAVFylt63s6UodPH8v2lkOCc9DfZLapNsTId9yldV
 bqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739719; x=1715344519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=nmZZVhbzoNH2r/O5DZHe1J/fY3hGa75RSLdpI55MZDM/VaWOQmNE0UVZ01fDtyuJV6
 XTNp97kEC2FT2Pw47Dp1wgKC8bArieHmUSpyDQOXNwGmQBj/Xln9ywfX8clBCvVqA8dK
 6S44BVecWczFi6mVvjMaK3SGODj8jpSrj7wIDa6WhCJQogs81FogfRw8rKGimDJGRHBe
 fTg+Cis1SHXTL92QALsyG2++9GsH4dVtguvPWhw4rEc9Mhg3z9kCVq2njeQhF25ip3lR
 dwnVnn3nfV/4r29ZLZ0p0NwcHRgtjukjHNbLxfxHVja4Ho6K3PXYBlAh0QIpKGqHN9d4
 Et7w==
X-Gm-Message-State: AOJu0YxoaRCx86NEO0ybjazii6/i7cN2aqkNcwuNepTsvwrpPaLUVQMX
 wVssliXCZG0tzBpYOLqTFEIHA+TJ9IaneByUMvKFoE0Ad8iIbIZTn2mIrbFURwv4lOIPdS7X9+7
 q
X-Google-Smtp-Source: AGHT+IGegzUkFujYK5Pa61w72uaBEbWpAV6DXB85dKhww77dlfbCWtzx4EfYlQg4SWytArVrtLnV6A==
X-Received: by 2002:a05:600c:4fcb:b0:415:540e:74e3 with SMTP id
 o11-20020a05600c4fcb00b00415540e74e3mr2365576wmq.40.1714739718904; 
 Fri, 03 May 2024 05:35:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c469100b0041b083e16e2sm9330778wmo.2.2024.05.03.05.35.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:35:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/5] accel/tcg: Do not define cpu_exec_reset_hold() as stub
Date: Fri,  3 May 2024 14:34:54 +0200
Message-ID: <20240503123456.28866-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
References: <20240503123456.28866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

In commit 1b5120d74b ("accel: Introduce cpu_exec_reset_hold()")
we defined the user emulation backend cpu_exec_reset_hold() as
a stub. This was a mistake, since common fields are set in
CPU reset, and user emulation needs these fields to be resetted.
Move cpu_exec_reset_hold() back.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec-stub.c | 4 ----
 accel/tcg/user-exec.c      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc8..2dc6fd9c4e 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -14,10 +14,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
-void cpu_exec_reset_hold(CPUState *cpu)
-{
-}
-
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..6a108eb212 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -37,6 +37,10 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.41.0



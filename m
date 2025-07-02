Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE400C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hL-0007da-S1; Wed, 02 Jul 2025 15:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gZ-0006dE-CR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gP-0003CL-RY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so1453125e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482785; x=1752087585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=jXDaJjxWOpMja0Ege6bRB77vv2W0s2kDzgJp1fUs/Ut0C1GwjR4Ix+3A9EIxScwyAM
 fT5zTTYSzIcOobEf4+vlS1n7QxJHa0oQEoCQbgUgsaE/OUTVS1plMNharSyNiPkzVYYS
 XfibzTM3qNMuPiyeEKc418GZEJyLOrYRTRnQp6IZp6UEcvxLqwv4fl66Ay4fENO+7zM+
 pu0vmbC3R+GjXtT2hnuSOcaykQLihbURn8NO92gZBUXfOJ9OeI8iaBZLK6pMND41qhvC
 6mjPxP6VW8qNH+q8Obu+l4sEcD6zUKINYGjw2BectGwz2sr+7RlNTLKfMK0rwy2HsBPH
 +iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482785; x=1752087585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=iEa3umRd3AjFB4nzEe34uS9ji1rAtjaTXRx4ZZx1kdpGvLxOsb0vYfIWfbshbeMkgD
 WGT1HjIqtVbjZYcAl9SIhniqotMIgA4d7neu//Mlo2b0PPjijoM2+hhmto+yk8zmza4t
 AW82fzsk9mIOOBWn5LtjfS/TSdHDTOy6qApEsJ0EnQbdxWSvRfFX0oHTuHydNVfl+nTc
 ZA9dRIoXzash6pPyDT3nAW6P8+UTLRZ2Xl+FJcXYAboHu/IKBp3/RLeE9+D/fIDClAgN
 irm0vTfuTG4K6N2DcPiVo/TjK9FiOFvvz2Y4WX8nrYuw9pd3KRQ977kylb0Li2xOzOGT
 B4aQ==
X-Gm-Message-State: AOJu0Yy0k9APPR4vmAGM8PLBa6YmTA72i/hiu4u1nWCltaO0BbFKpXE3
 QxPcjYnrF4Pv4yyE6SOhOU6Wc4c7yGtzchxxmDJEdCqhlhrydmCv8+pPFeXdipmjY4MRmJDdFw0
 a9ygP
X-Gm-Gg: ASbGnctf3p+w3u9sPw/DHbgNyoH+L2YI//U2K2ucTEme/Tpm9M8f4qNbwU/0J0+S3VM
 oxPXgkKSYV8uVtihXgnocQIxnQl9YTJr36j/nrsO165y8i5DHi3bZksm43qFw6aTgt7BKsSe8Wk
 j0OlNCWdTqsFGVNDtmnDCcvdETxLM42VKT5RoHUqiYfz31bTYE3rXcbgS3D3lsJzFSHJrZRHCxy
 Fld25sWCtqi90rsmk3r5vGACdeTsU6QOFRcMpNHNLzd0YPybf2Kz+bPIml+DT6pHtaphucHR/ps
 GVED58j9rgexEY6EfzyaNoMZRFWJBBdggnrF2fZ8VNCmv0Lwgovrz4tFQ6P3wwdk+QQEHoTGLwl
 akzaByqSQjsoQWKWDn2wGL2nRhD1rwAXHejLU
X-Google-Smtp-Source: AGHT+IGKoqyLrJHd251IAg6YemLMT5eo8VIUmShtWca/gvdkVBUDIPFOxlqqtNAgxKTDEz7R/nSeBg==
X-Received: by 2002:a05:600c:1c12:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-454ab35e5e1mr129535e9.16.1751482784767; 
 Wed, 02 Jul 2025 11:59:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7386sm16555447f8f.20.2025.07.02.11.59.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v4 52/65] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Wed,  2 Jul 2025 20:53:14 +0200
Message-ID: <20250702185332.43650-53-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



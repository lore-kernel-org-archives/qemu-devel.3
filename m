Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F6FDEE27
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTs-0002Wn-CD; Thu, 23 Apr 2026 13:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTR-0001l2-Bq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTP-0005mf-4b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so112937535e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963857; x=1777568657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5k9kqQDv8QT0/Fw3i6//tVhmROXr99HTWpXkB4Vr04=;
 b=liM5ld9iYFH2G+4y57OysFIEgpmQdzwFXndKUqrCy46GR4VerbuKwNNHeH8b5yVSnI
 JbO+qkX2BQHP7vqVQesqsajXX/Xv2Eh+yoHep7eB+pfe32Hj+azZweLCzYD+CgJS1HHR
 qBHPkgWns65zv2wr9Lb8ILwo7WTLGTI3PhEUWcv0O/h4I1l/VSMqo1waXm8w9M2r+7kL
 We2GyVGuRfjIkkm54snz4WIxAsRharLL2BEco34vrsVrjnomTgQW0tzk0CvcRmQ/LGQU
 73gmSsKtiugoPYRHAsGMkx27lyGIMS0yUQz9LY9UqMqYr4+1k//xDwUjzxWPAGecANjh
 xcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963857; x=1777568657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5k9kqQDv8QT0/Fw3i6//tVhmROXr99HTWpXkB4Vr04=;
 b=XMWjuC9cXh5N3kPq8U0qVjIG/oa0tcpVJUTSaOTzNCtUKOgcOljGJSh1cj9GA4HHS+
 rzDvjeqI7gYHtQKbPhIsHkIpQesGLaLGLQYaMpEl727Prqe6XMNq+jxsrXgIfz517fEU
 F40yenbeD0GoZ1SyVG57lpK6gyEvxR5DySiP6p3AjVIlsQGnCFhXc+I2M0offinGykha
 SNeQBGCsSB5U1hKgj5Uxwy4hMHURv5iPFm/aCyicE2kKneWj1PwYPXb2/1W+RXrpmRb6
 fRvhCp64Gyp5u2U9XugpdJ1WaNw1SV+JU8eoEXPWaCRDOP9DgbbVUo8CKOqGNgaew0cc
 PXgQ==
X-Gm-Message-State: AOJu0YwCPQauTxyor5I3+4zBi5AoNkMbO4BaLv/IkWIwHNSW3KlwSnPJ
 rpR6evCJK21zUeS1/rHVwikJLT93nnvdMBFTrmIGPHOYlydPKqBMsaskFxEj1v8BsFTzg3dNInN
 Xz31Cyr0=
X-Gm-Gg: AeBDieuLq88CtyT3iRN3zCsfO/ckcCc2jKl3DYqxegvg0bOcNGzdkPoZhfWsJBtXqI3
 taVJF1ZZAVqDCydJQxaj4ZmTh4UmVqL1o98+znb16LBgq3HutQjzoWiVO+bx8QLhEqOxKqMNmED
 i1MEVCf3E3XOUHlg7c0aQh9/PYTDJBk4ogvDFFMniouStA45ZkriDwRD8TNdqEdyDJR4GAdcdR9
 EGt65mYvvQf6DNaKv8ZkIAfrOZBSpxTDYdbOY4pXWkG2DeOANqD1Hzv+8fmFAihUVi+W/LqbLce
 JGg5ZWj/TPRIoDF0rrPqbA46sDoNJAeCyk2MmChtyVGHwe7iC7/P2sSX395FhHtiVDjYDVqg4TF
 x+8dVH+MjmgQpgli9EIeOnC5GDm9Rtek2169ccI/A5CpYrS4wHAoEdzwGRy38gEhSG11Z/JfTdP
 YpVdSeqgONxRmmkuwEcEjfa0mNkdz+7KXmLT/DFXyCpNUYpA6napsm3lzbT78nfucnNcgq7AM93
 zl9qnGuicvlMwXbwaVB7w==
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id
 5b1f17b1804b1-48a53638e07mr154852825e9.22.1776963857307; 
 Thu, 23 Apr 2026 10:04:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e591cesm73428037f8f.36.2026.04.23.10.04.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 14/16] target/i386: Report TPR accesses to HVF
Date: Thu, 23 Apr 2026 19:02:26 +0200
Message-ID: <20260423170229.64655-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

HVF should be able to handle task priority register accesses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250616090632.55214-1-philmd@linaro.org>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index c397a6fde5a..28bc37966c0 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -563,7 +563,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
 
-    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled() || hvf_enabled()) {
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-- 
2.53.0



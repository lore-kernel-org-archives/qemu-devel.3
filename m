Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D6D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghsv-0003Sc-1t; Fri, 16 Jan 2026 06:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsm-0002qk-Be
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsk-0007FW-JU
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so1508688f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562445; x=1769167245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iiZoddP8opHtKuhdgUe6gxbSyVqZgSbFQm+3ARlNvQE=;
 b=i9od5EMAnQdER/NpDXDjz0hKkQIgaZm1stmaLYGSLxT6i1Sc7R8m7hkFrxRU0LYXgD
 nPpvWMm42dBds2YpnYTOvxWR21M/0bO1+IYUAZyKs2sfDMSzpF+fVNSinRHpDvjl1ft9
 fhxjhXEojfgohm9H6S34Huhw4a4EmYNIESMRVEtfU2Jw+vaziBHqXFoutRrQypYkhXS1
 zO2C97lNpDx3MGfTl0vXzM1dKbSmkUL2NHUDPM0ik1wcxlTrMxaCq11+d0951ANkgfR8
 y8zun5ThFfqq1yY3CEZnASy0KFvd+2/O7MBnYaIfSaMf4OdWfyUXf3qWT+cKbo/61hOC
 dFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562445; x=1769167245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iiZoddP8opHtKuhdgUe6gxbSyVqZgSbFQm+3ARlNvQE=;
 b=Ooodz50CpGolBsNb6mZHONE8e62Kg8tnpco0WTa3Fu1j+G08BJxcpiu3YnqtUHpKfm
 DUWJYyna9TBJa5u3lNeWq4ABpx5z6Zq11HM+OqBjqIKSe4dPgWsy0FHG8ZMLUowt22ko
 GdbqsooqjhTZHoVMVP870yFDCJ6VWDbfjDzvNhfGRcSBsg01Hny3yusemA7jl6y6Fljp
 Wi/NxDeTVCsLwcPg/Wv40QnaHveP28B3uYXUG1o+FsDhYBvK8dqaO0cuelkJ2tgcLwLP
 L+leSe6aaqeNVvxVwaivYXv8ThgCVn/idWjOe5Xh9EFHrnlYemfLHGNqLt5FUIHVPuYE
 fpoA==
X-Gm-Message-State: AOJu0YzAILFZq9j8X4e3W8iuxV82sBMHFzAgJ55TKznckjVEZHkg/fG2
 WD9K36McAcwPT7j4xyK8hL+1QM8IMVxdOhvWPt+z39/ZObpKBMFoh1+Owk4nMakG2VYsfb8O5ba
 euUafmiI=
X-Gm-Gg: AY/fxX4gdY2fSXmrjGigLWmm9TI2AH4WSsSGjpStxQAyxbVNOzCRfQ6Y2T9nfFh+2Bg
 I1dwnFL5gCgTUWMudrpjK+okteCwIS+TN+47bAQi1Ok8K/UHX7iDNEi1/WeMcAh/8wo7uS1cd8l
 BXxjMVRAok11luG3PkC9HVf2NTzeCxC1samX/YKOafytu/zRhvjO7j6XnHTLxo8V8Ph74NlyZAG
 Acx3+WskB/sxcjWwh//+Ccfw0p5h6qwjdhn/h+g+WD8mkvhuTH2/Kq1O6Mw720JRTX1836PwdLx
 tvhVU4o7y+3wFPGR5herrB8IGd3DgCswv9yj80E0y7CzZNXfdW0cJpeORfvjERRnJXCr8DrCEOd
 OnYyyCzwrZ9hyLYkBhiJYRALjw9hagqvVgXRkwdwJCYGC4iAHf2s4Wz8cocDL9TIEar+xC1Fy3m
 mEOgx0IsGvxw8kOMF1T1DW8clHwK1Jo8PmNbH0Pp4kIzyDO0V+Pyg9Y8NgLYwo
X-Received: by 2002:a05:6000:26ce:b0:432:8651:4070 with SMTP id
 ffacd0b85a97d-4356996f7ffmr3258090f8f.10.1768562444547; 
 Fri, 16 Jan 2026 03:20:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569922032sm4687643f8f.8.2026.01.16.03.20.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/30] accel/hvf: Add hvf_arch_cpu_realize() stubs
Date: Fri, 16 Jan 2026 12:18:00 +0100
Message-ID: <20260116111807.36053-24-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Implement HVF AccelOpsClass::cpu_target_realize() hook as
empty stubs. Target implementations will come separately.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-17-philmd@linaro.org>
---
 include/system/hvf_int.h  | 2 ++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 5 +++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index c8e407a1463..96790b49386 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -106,4 +106,6 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ffcfe9663b5..b74a5779c3d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,6 +356,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_target_realize = hvf_arch_cpu_realize;
+
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 718414cc53c..bf8bed1495d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -972,6 +972,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
     hv_return_t ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8532e0fcffd..7cfaee389e7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -370,6 +370,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return true;
+}
+
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.52.0



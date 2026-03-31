Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D27D109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yx4-0006Bi-Rg; Tue, 31 Mar 2026 09:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yx2-00069b-7v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yx0-0004A1-H5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43ccda008cdso2252877f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962969; x=1775567769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iji6HPNBq2wYQ2LzTKADv8GnzeOysve5TJdCd3ZuYX4=;
 b=zwuOeLdosUYtraQlsVVR9DTehem3T3FCgtMt75FfxXhXDh0s+xmpylwe7vNRVPMP2B
 xHbJ1VmHMQ3v8+YvdNWZFkrQKZ1xfAlkvpcr9DqlEXKd5EYwiYOcAED1nM57q6JiawRA
 sYdBmUyUuXDo7jqN9R760iyXKfgFL8Ib+OcSyKHMjjuiarPwrUgeYT83nrsWJ7ObH2Ru
 YlcLikcNF0UBMQbS7COv4DZjKcLGSBjbf+ldL+GtN7VYMfjkZHQHDcjeBS5EQ3ejeCUZ
 3uxZixM6PHvnp2IfZSohjzAHRO7RKrJhzhItyN3BjMNo0Jtech7Xcv14eDlZn5KhKhAy
 DUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962969; x=1775567769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iji6HPNBq2wYQ2LzTKADv8GnzeOysve5TJdCd3ZuYX4=;
 b=mi3IrXDX+b5ghbwlE0XAeNaf81hFRyV6NMwBj9soBDwgB8J12hJZ/E273zQ4BuNzL2
 hgnFrr6k/NH+9YP0V7fB/q8GcHb7tV1nVc07zA0jU9NEvSvn/yAJ2ocHOIrB4nX0UQiN
 5Y75b5AwqG20J1n7BKm5+BkMrABdIEhtgsL7Plx9FTa6cZho84CXopBSaPuUMEysQrdU
 4rra31GN9emFSup6L5PG7lxtEg44j+f1zdJSaWsqr8ZZ+ri6byqu1UT31/zVZ5X6eKiw
 sFcMSUfSmtSEKflxe4hJXc6rVY3ZePF9K1ExtiVjOapyWq00mN9vN+DsBNMux6qUDbkR
 BOEg==
X-Gm-Message-State: AOJu0YywwqVOsc9Ko760ndST7l0XdeuguhvNd21GkPjZ0dSKuPAcmlXZ
 88SImQbYLJL9VsLgE2/diqk3bIjWXWYAeJKUWqD3wW87McIEnXs8jxX5K9zQ4uBvaXPp7mHmG6C
 SYsKQuOo=
X-Gm-Gg: ATEYQzzB5+qDFz0KxfgVJUS0ikQv1Aax7j/2L/ZZJSX0fWIYBeABCyraW59qdmR2Fbh
 PWvzXV0vP+xnmdjzmPLCE4ArzsejmSD1yBs31RRlBLYGeigmjTm3UAhnT+qMdtsh4UR1CpoYi8N
 z+m4ucG/HLbaECALo/A4z8+5PIC85WKGPrEGkzgiYcdlBFPCYlE8q0/7nszM7mY39tgrAVchuAb
 3M5FgNyo8M5Phnnc1/wfR2xsUcHFcQUq7el7MG54Rw3bRlfbGfxP7dHCh1gsP3KD+wZct6/S+3g
 ZQNPir1AUGcQE+NJlHWQszP/9Ko7aNR8yrWoJmgCu7R/8Isn/oLAsX9RydW+6IhrBT8dZ5JLYqJ
 xFG+IKWXSSivRH0RUqMwBPphqK6MTMwPMSi+I5rEGSjnY7oWF2fMa1yI1lLdUxIlag+MgpTMaxl
 R5UF3bUkEml+C7He1dhEvdIX1dggrQV7kRftzFvIQywNHH8P6J4q6vWn28mckWJ8FBiLxIwPgDT
 jdqAA==
X-Received: by 2002:a05:6000:1846:b0:43c:f1da:487d with SMTP id
 ffacd0b85a97d-43d0818f22emr6358801f8f.2.1774962968534; 
 Tue, 31 Mar 2026 06:16:08 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eba4dsm29623899f8f.11.2026.03.31.06.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] target/i386: Treat qtest like TCG for supported-features
Date: Tue, 31 Mar 2026 15:15:08 +0200
Message-ID: <20260331131514.21152-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In x86_cpu_get_supported_feature_word() we figure out the supported
features differently for each accelerator. The default case is
"set all feature bits"; however this triggers a warning because
it enables two features which conflict with each other:

$ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]

Treat qtest like TCG here, to avoid the complaint.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20260330151437.1787008-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b0a7c73632..c6fd1dc00eb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8087,7 +8087,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
-    } else if (tcg_enabled()) {
+    } else if (tcg_enabled() || qtest_enabled()) {
         r = wi->tcg_features;
     } else {
         return ~0;
-- 
2.53.0



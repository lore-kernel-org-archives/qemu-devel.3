Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661DAFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBB-0007fD-6E; Wed, 25 Feb 2026 18:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOB3-0007dA-K6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAy-000471-Tl
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4398f8e2837so214661f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061615; x=1772666415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zycF9EWrfcu+cbAB2g8zGMKO0uTO4sCVZYCcJJrhwNo=;
 b=T8KVSzOWgmf/KmQAlcaUl7D1Fna3IZPc0LmmjxQRE0HL8K5Qj8UbhZCKOSnkKIi1ju
 fdktDteaOsrxRhc/M10HEQhmFfaeh6QDx7Vd5GgMiOQmUsVoeoKdQ6yEHFRt8t7A0TmP
 agUHg7Bebm5+xi5nczCvQf7HQb/Tab6/q4So/w7maFLjukyPtGrVlCnJuYrYjiEj9B4Z
 RyATm0L6E/TuFX3IH8OE4WBLxGRj72PjaQ09if2HwPZ+uMYp2eCH/RI9NeUSmgYmJgz5
 zsnzCEpfLEIJiURUF1gpGFnsjJWgQElIej5x+b6evL1wpskvfj/iJ46rYioYBsi5NpWp
 pdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061615; x=1772666415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zycF9EWrfcu+cbAB2g8zGMKO0uTO4sCVZYCcJJrhwNo=;
 b=tP5CYVP8rnv2DIzGnKsL5PVTqPJgb7fOBPocNfzZzAx2GxAntPb4UDnCzaLXU9wJ9T
 QGUw/iPzYuHJUze02mz22e2Je0xHf/AyrboGfD8STY7LXYyInl4Lq5HEXbgY4C/wO2yU
 vqogw39aGv1vqDY+n8sB0eemi2+ANU2O+PwD81PW1oQ1Fanw/VxCQeZxuiwfQn+OHqnk
 oJZtRSQCrM9ONyoS8/QkBuYCq/TRHUejYtI5GMN1Xx6T8pHZ1hLVYvqGxS6vFyRx1T4o
 2mUO6844/PbCmQaLRpeJdrxIaANmRH3Qk4DCIQO+oGiRWtPK8XYrGBJSqOGEL/QVWV6j
 jW6w==
X-Gm-Message-State: AOJu0Yw4e0e1oqYuGm1EZskVb0NzencRP02u8T1IP3g1CF5zvO+OlSXf
 h2lyeSiPXHXOOgFYhhE9l1v7IN6OJ72yqurczKilBq4Z4lDOT2dhgx7nz76rVVg05xcYLZA58QN
 59GU2nY4=
X-Gm-Gg: ATEYQzw7G82X7A14jBjsqzHg+/ltxUUUpZ1wuZ/Pnf6Nvn2Ze3/6wowM+oO0uqgy8db
 7wjAy9xSMFM4HoflFFSg9mZ7cerfaXNWDBH+pQy1WCfev2CuQ2ZsfRjdCLFlvCPY3byzo/Y7ZUJ
 g/fm9H5yTrWCSE+wcS1pMnL7Nd/iwbEYcLeUZXEd9muwlZ4RHUo06fMXYzNqMKlGcbm6Otjr+y5
 u7IDpzBCuOtztVYsBy1ecuvBXZAMDv2TIVUWTgfc9OjCJNkaSpjEgo4R3hm45XMRVOuoFeBHD0l
 BXLJ1LG+sYyy6TQk3z0JUXYZQoLpzCYrdz+ZtapLTg8eA7a36jTTiZPb1XMvXP+yrzbY/xxb2oD
 8OntmuBftvdweecuDLERs6nVfutSghGt2msly4S+1aFUomQ/lHNYB5L/UxQOu1IXYamKLMj0pPU
 X22i3B840tFY+Rqq21Ws7lLie6UIOE90xfu2QLqQfyO3nWl5J+rAImq7nyL57yqMoKL/iGKv+D
X-Received: by 2002:a05:6000:601:b0:432:5d73:79a1 with SMTP id
 ffacd0b85a97d-4396f188996mr34539045f8f.55.1772061614979; 
 Wed, 25 Feb 2026 15:20:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399037aecesm7334605f8f.15.2026.02.25.15.20.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/70] target/loongarch: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 26 Feb 2026 00:13:53 +0100
Message-ID: <20260225231411.96482-54-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

There is a single qemu-system-loongarch64 binary, but by
moving 'gdbstub.c' in the target_common_system_arch[] source
set the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-46-philmd@linaro.org>
---
 target/loongarch/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 20bd3e2f0a3..2ae96d68695 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -3,9 +3,14 @@ gen = decodetree.process('insns.decode')
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
 ))
 
+loongarch_user_ss = ss.source_set()
+loongarch_user_ss.add(files('gdbstub.c'))
+
+loongarch_common_system_ss = ss.source_set()
+loongarch_common_system_ss.add(files('gdbstub.c'))
+
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
   'arch_dump.c',
@@ -20,5 +25,7 @@ common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 subdir('tcg')
 
 target_arch += {'loongarch': loongarch_ss}
+target_user_arch += {'loongarch': loongarch_user_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
+target_common_system_arch += {'loongarch': loongarch_common_system_ss}
 subdir('kvm')
-- 
2.52.0



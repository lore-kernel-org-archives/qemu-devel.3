Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FFCC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvO-0002Tx-TK; Sun, 04 May 2025 01:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvA-0002E5-0a
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv8-0004Pn-4g
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso3518645b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336585; x=1746941385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=RNAz8pTtl1O7kB44rzMRJUEekeyAm26/YEuQesRzbsApaVQnaodC0nJOSgfb3mxbRc
 ZwUpZxAh0Ze3lvH1LjRXkO6AiGAjNlYPJ+e+YIXh1LCun7TXSTNNZDuGWISgTY/L/39s
 v9zlNvNCoDxB0mQDd/rXCHaQKBqNOH1N2/vKhPP1+oB+sV5cO/4Evp4+uAhOC6+KLRz4
 J49pYuZZkdpEapwQ5NamyO/6mXDJufy12ctD2M+ZOyZv+0aaS7F+N3C/jP29Nm3tdts7
 Q3R5sNZ8HtTvHQQpBzUzoJShkGDLRn7tUjID8wsNdI8rHjP3v6dSxDfLYbSDLLKNX9Qv
 Ezow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336585; x=1746941385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=e8DxGZpFrUc/IzZaPn8j10RSw6tlhE26BONY7LgzvG78Ai7PvStpf0uPBiB+yb5NG7
 yOeCzSIoM+uk4N82lKG8eA4sMmmAQkGJbyS9mUM6tXkPMcM2XN+h2fLCSaGgYI63LWQm
 jycF0jLciQRV2u5bau1MjYHLAn7LYbDA0lReSpmt9pOXdKz3ex7yYg/B8506scVNPQ68
 0FcedW+fOGlbVqMVtOxs7KmQ5y3ZKJWPA10jqcty4azA51xPv9N+C69OnKrvhJMH0CI6
 rmeI6NeKoojrm/tubXRvEMnR1oE7JUsarEgtWf30A6i9dba63ZLdxo51hPyLudQcmvf+
 2now==
X-Gm-Message-State: AOJu0YzV1y8ahBgYBvUmGWHnu06QbvdHSK3TrLbYC9RBVZtOLe6e0vEz
 vfWJabw5NAi4z41SsYcM2/iDVOVTTUhfp0dSzoI9KFLToK8Ov+CFXsdtavgodCykMnVpnuR7/dQ
 zxJ8=
X-Gm-Gg: ASbGncurb0zBagoufpNEQuD7kOQld+vHW8aR7yfcMT3a91K/lc1NiNp9Ghd52zcepWL
 d8YGMPsqqT5YGnYgLaLyNuxzolOV3Gk3yIkLXLyC8Xx8tHcMFcDetpLCDh1CizBD05p51ey4HZo
 mGNGsjJ/O7Dfj+VQX2RHiUlb7Q12Fm9XzBOWNvWHNBkJKqaFwQa370eXqWzXbtL185ZL5q8/ith
 f1unr+KSO365QCVd6hFr2VUv0YP972kz5ibvygnjEXRwKwqxc8gGl0wBp4SUxbzLJvyKqMIAkeV
 f1wdEpryYEGiDrtWckdlMgbIN5otaRJsEiSn6QKr
X-Google-Smtp-Source: AGHT+IF9bJqlPmghjDpbd8Zl1EC77NJasNz3fJ6npNVxR0Z+1P+76zRrAVulXFYymz8tcW1RA4zs4g==
X-Received: by 2002:a05:6a20:3d85:b0:1f5:77bd:ecbc with SMTP id
 adf61e73a8af0-20cde951f95mr12471654637.16.1746336584651; 
 Sat, 03 May 2025 22:29:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 28/40] target/arm/arch_dump: compile file once (system)
Date: Sat,  3 May 2025 22:29:02 -0700
Message-ID: <20250504052914.3525365-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2



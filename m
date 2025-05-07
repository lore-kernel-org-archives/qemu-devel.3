Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FF3C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQC-0000jG-Td; Wed, 07 May 2025 19:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPv-0000DS-1u
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPr-0002Yp-Uc
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e70a9c6bdso7571805ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661386; x=1747266186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=C3vBEgfLwBWBP8Mntsg0ZSb85e/Vj2x68q7iZKxiV1qv+VqCX7pak/rev3JsFiMLzQ
 q9ZhX+S+ecZ0wbdiKUiMzS+g5l86zIpehXNtt6RsW2SAIACnbxF5ez1yYIOZhgf03YDw
 aSWH1rMCFTG5Ehb+mVrPPVLGndHxpIgJjcl90QJB270YnCXyQkrp0KqGXFqeYhPniVO+
 y590upYc0p5xZdCOTruC8puv7Ig68l7/LZqP6HBUMiI8hMQj9ZNNC7hI2lGcIvxA+TZc
 OmkwXrbrdUZ4YqJmivz5hKCOmPQ4VDRZVu8r4/Mu8w8PiN1IW3H7z+zsomvj2Y/lP0E8
 Q9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661386; x=1747266186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=LA5xFBbJJzF098q88FKhB/WoeiH01k59BsznJpkZqScDdiprkOvLB92eM2EHIdY07L
 ogEYGaE/ByM+akSLglNRwZDUT89G99JxeRM8Uv7sUH0KTdfRTiZ53icFqx94YJYN52it
 FtiM73aFMG7yXUAGnQe8tPY5ZLjvFVIr+C9nv/B12RfCb5FrY14tgewz80N1k3MOIl08
 LYfPNCpLPLsCWVBbMnkysslubEext06VtJliIVLr+ODNcPf/hmFvYhhm2rolUM2AYhNg
 BRqcuBfzfKuRwfGWcR0lUcx0wI20TbymqOaaq51WIHVB/6at/V7u/aGsLuQ6/Fxdcx7R
 mGXA==
X-Gm-Message-State: AOJu0YyL7T5vdEhm09RCf7i9FSl4+1TZSa9czlZbpPGJd9tL/CDVh7pH
 FRCcvOzi+oSGMEpomZ/uvlwG/aMIkhZiRZ1XVHuS4bqsxit+A4WPwFgjZxjylNaiYKFQMnelIKK
 1bLsDfA==
X-Gm-Gg: ASbGnctwEyxpsS4csYtnbrgJ/7Vhoi38NJ7KI6o2SoZcmL5FMv5PKF00J2qjxr2dwpl
 C3vrGKjEoDiHwEQfIT2fOcDl3LrE5yYe3NcWswz2nPOPLaQ9972TRJ5CzXr/8iZyBlrztPitSCQ
 KpQbdJYbg/egk+G2ZViPLi6s+FacRXRNgiF04XH8HGQUlafNhvZLCEyUL9bBf+itx/yF/nyCmk/
 jIn6Rh443j07RS9UsqsiVreWjARJRC9I6Fg4wr07AEWHBYSZysdHrQEiO3QQV5cRoVyjtE1l7Op
 WecvX/HT4ik8Eg6MRGGR4QUrjIOg5dizGBQkhMWwnrkYKufD3jM=
X-Google-Smtp-Source: AGHT+IHt4tu+CujvY9eN9hIbp06QoRW/RBo9JhAAnZCE/TrHnO1sU7+xOK/Ll3Pyp9Y/rNdj63LYCw==
X-Received: by 2002:a17:903:3bb0:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22e5ee0f11bmr68096735ad.51.1746661386730; 
 Wed, 07 May 2025 16:43:06 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 27/49] target/arm/arch_dump: compile file once (system)
Date: Wed,  7 May 2025 16:42:18 -0700
Message-ID: <20250507234241.957746-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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



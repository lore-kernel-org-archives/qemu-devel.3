Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4794C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQM-0001D3-II; Wed, 07 May 2025 19:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPz-0000OC-Kl
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPx-0002ba-RT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so4069595ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661392; x=1747266192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=yKmUuHpesIoxx+HgVlsHpmDHIvUdWfY4oLB4yefXmdm4OiHH5eSZPjSMbSi/JgvFJk
 HmB6TxFAwQz6rTuLLRM0SJavwrmKsa6lJ6hDlQ9n+wsuhsllI+/89IOt++X7fug2Z9Uk
 M/hGxYytm7yqiJiHp3aIUuEDqx8W/PnaM/r1tHNEV5+7D4eKQBwIt6wkr2wgk7YFQxHo
 PZHkba2NGmq3wYjgI1CT6i77cbsQgwnyij3NiFvF2V7gfHjgQiOqt0qsYIwKcAEaLZLi
 vYeh2t+AIKYwD/r71AP0daHwsL51D4UK954z6WVJZZhfy7xUGEMK5v8OOo4DKaFn8UJD
 FlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661392; x=1747266192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=Kmaj4OhPeIDu9PFAKcKEfP1iizgrz+WzYCmHaFTABoVx8lnVub/x3cl3p9fx2XOTlW
 VDsAH5IyoR4QNJK4rtMkLXvKEWMdeesvlkOzOR7/Oq6jcx1o43xNu2Cg6laMx1Za2d61
 AUcvN0pszJ3MbTqw6lPddYEk24vcnMtWNrED8qNXs8QkFAW0PcyTXsnga3nzltksVDeJ
 aEgalWOmWWYuLbSO/IL6LpFQQV1doifWl+aEiQ6TvkyBOCQUQLY0jki6Ac29q4eTwEg9
 wog8OBSifriSivHgm/LXqqXtXqyxCZHO8fFrCQAY4hWEDXigUrBAwvCo9v2P2nP0+qID
 +W5w==
X-Gm-Message-State: AOJu0YyAqx98lDtBIbg3t+ZxkaPlgqPyvlEP8u9zX4PCoZtnGnPIp7Fu
 d2ntrAOVEX0nheR8WEPxbeM8X8PAV2SuzVveBuxNeyKyuRBDtXx8oETDHt9Jb4yAluPIu0DL8AS
 3shw2Ow==
X-Gm-Gg: ASbGncssD/rvlTVCw4PfQuM3Sm5tQJSjhqmREwZbrQUjOK2H25trwtGboFykxnjvHA1
 R3a7HrBSYE54C6xUhd8MnrfjJhyM1fCG8XDZqINsN8XKlqs7mixp2baqe8YL+GgDHoeuwNqWeWo
 Z30yVEhWoi6eArm4vb7yE8s2Yr+bbyf7ilwC2b3+yM+zZTWvXaWoWW90hPPSXl5yrDtG5fS8Gay
 tiLNGOVRJMXDZw466u7t4+aoss1mMuyRgU9cyapliWL5nYrE/o8T3Gm/yStmjpYO8BvvnrPrmrU
 HEoXLw34Sny7RTL0cSD3uFHcSBAAFTLMK+iADAno
X-Google-Smtp-Source: AGHT+IGl8QMLkXX0N5h5JsKWC5nqHNtFaM2hyM/uoczjU3eRHoUb/MaTp4KT615HMMrJAssEpmZ66w==
X-Received: by 2002:a17:902:cf0c:b0:224:a74:28d2 with SMTP id
 d9443c01a7336-22e860ccf77mr15541875ad.26.1746661392516; 
 Wed, 07 May 2025 16:43:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 34/49] target/arm/kvm-stub: compile file once (system)
Date: Wed,  7 May 2025 16:42:25 -0700
Message-ID: <20250507234241.957746-35-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLj0-0000SK-Io; Tue, 19 May 2026 10:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLil-0008Jl-Uk
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLik-0007rU-CG
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so2157793f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202017; x=1779806817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfq5AHy2S4W9XZ4bc/kPkATQGz/95IgvOsICubzDZ4E=;
 b=SqwtBHYONmuNdvV90A1qJq578nNRD87tV/Yt42WN+8eba+tQ8lneUJXm+3MZyXSfjE
 s7uPCqqXmI87EERDUDV/nkSL+wzFKD48pfC4q1MLVcmdj1dkpc2LKIBMnbuVGMmT12Ay
 ivmrRDJlvUu2oipQzj6ljhi/4ul94cYQ5YpeeeW0O3B7Tqptmgaj2zXAZ7xEHhqZ70Ca
 4tMgAvlk20qoGOR95glL+mHCK89i/mDBep0E/pHwqnmc/gF4Kgiw3kIbKI7/KEnwTl7x
 KlFDZ4ldf5b72DP8xOcgnc55zJoe1S3ZHMa+qwzjdrAVdCyyesiRxtggd8PrRV/pIluu
 JhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202017; x=1779806817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jfq5AHy2S4W9XZ4bc/kPkATQGz/95IgvOsICubzDZ4E=;
 b=pV0ZXX9nGeO4ycyMh19gwfSOuupfgBnNfPbZTSMPFxtVCbJEeD7UkucRCXgMC2OOMm
 MZOq89bW7ioEDr0WV7opty58I7wl5CyVutrq63M37ifhRKeArHk+jMWaCqDiMwrMoOvd
 vhSgwCqqVSmzCguNbAyjkGwBSX1zlhC9BckKoTzBeh57x1hzZxVf720SWvVbcm43XcHL
 yayDwot9XXq0EHxTkkQxIdu/jxGHY9Kn+qTHeiCzS9CN3TDQGteec/PJEiv0ehTTSS95
 FNx+tSJ9zzwtS7ILQ8rnIhzQZsa9C0+DDu8bNRq3GFBXP5aeBTgDWe9ZZfbunsytnwhv
 IM+w==
X-Gm-Message-State: AOJu0YwokRGor0l4ayyYGAbwvsSGypdKFRrU/P6o2seZWH8xn5Kb3IzZ
 5leGSF2fU/M9NkPy2lmp9gewrpvvpPPS3NZLNjMj/mSWnEsHHYiUsDbfsh5rzp6iH29DFsVDiBn
 np34xDmQ=
X-Gm-Gg: Acq92OE5TmGTAzoHhmAQpgCbGM0/0nDijqlyfN/tYk/EnRwQHVfej/qtVfl13BPoUOK
 0+TTKbVRdhcwtbCfHKfRsL3JJqIVASz+/heOIoi5Wfr/GfKYAGvOZYTc1BveOMgyl05JKH/PxYi
 smbfJdlvAQsn6l0MS28eF8KxhpAl9K/n/o1ai+dDTfilnv93HpLXdj7V1RCZSDL78M7zz4TsemV
 fubXzM22UboBT5OjheNr4A/Z2OZHzk4uwih441RMirtT8g2jgVRaIHfGCpu/1H0N3w//qeM2uUl
 4+WGCWIk3ibbd/J5Q8L7x2cm3L6rhvwhqJOOkemCTIJu08Lbyh5O+UzQEZGY0ggifTNVZE7l06J
 kmOM7BfwJe7qZKPvA2whKEpSRev3rd1KjwYmSlGg6VZ6KVXCalz5bB6Gxvzhx8is5MlHO3Zv0+f
 idhMN389nzE4coGgHzE0gGSxXnW3ETS3fachY4+uOYWZw6xfGP4rxqYKoe6Cu5vV+grVLMOOXyM
 HGUX2+qKd0w7ZI6y8R0/A==
X-Received: by 2002:a05:6000:1ac7:b0:43d:762e:76c6 with SMTP id
 ffacd0b85a97d-45e5c35da8fmr32071116f8f.7.1779202016672; 
 Tue, 19 May 2026 07:46:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3acf7sm46288114f8f.12.2026.05.19.07.46.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 09/18] target/arm: Build cpu64.o as common object
Date: Tue, 19 May 2026 16:45:44 +0200
Message-ID: <20260519144553.91483-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index b0f5342245b..d5a95bf54f2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -35,7 +35,6 @@ arm_ss.add(files(
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
   'gengvec64.c',
   'translate-a64.c',
   'translate-sve.c',
@@ -80,6 +79,9 @@ arm_common_user_system_ss.add(
   'vec_helper.c',
   'vfp_helper.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+))
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-- 
2.53.0



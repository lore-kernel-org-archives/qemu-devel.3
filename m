Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A62C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5S-0003aG-8y; Thu, 19 Jun 2025 09:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5Q-0003Zf-Bi
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5O-0003tl-89
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so428856f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338824; x=1750943624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AfBQUbCa0g6ZkI9T2sAPEVDRyQTsrNETxFPLqSkQ4k=;
 b=aUFnQWYGuwAwCsmzOqw0GzUJcVdyn6L8msk+0fc8n054K+P3Uj31BPotwmH5FBuH6H
 ZZsXk2WzK8Vgeezl15kCszBmK7aEX5hPuCKR+7oAHhGuLU3FgePVlWyqBGzS4ZvfyYSS
 zzEVJqglZwAikduQORdfDGdMMSylAvRtsj7bAXPnfwYfPD00hBzR1LrDm90iNowIf/5x
 GO7XGsDrExymwfvxxyeYXyuBsrElrW+NToW4mw3UxcMch+YRg+MeLdgMkOso84mApg5a
 YXvppnaB+j0HMV9E5UNP4/sVeWmBhMvAZA1CGV2sJB0T9lhFx1I4mQqzsK6QHdnx2w/2
 VjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338824; x=1750943624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AfBQUbCa0g6ZkI9T2sAPEVDRyQTsrNETxFPLqSkQ4k=;
 b=ZVj08YB17w0+O37YR2E4E1zIT9VR9jRZmti+GnZ4wj+7ZZn579F8zyYn7gqFmjwV/D
 mguH+fQz7vJ6dCr6TiFPseNSfFqzPDsEAimyxzy0kW9H2t3wsqZtd2H6kogd8EWJXYe4
 66s/EYwYc4N3vWAdfuwB6jAioNtgwHwr5IL6BLLs35snNJxMr+wlFBil1x0u/JFOBNPo
 nquZYXzlTW2Dbp4XmvHYfBltUDDf+WkzRt+oR9HYcbXeLhqPhS86EkUFu5ybFrXKqgcb
 XI6D8YmKK0hdRNZ3pSLegI6qPEzHerX7X7Hv5dDLfPDPTt6kgqhC6pO/kMliAyBkeCqX
 0YFA==
X-Gm-Message-State: AOJu0YysYF4+ix9hKkmazw6HNXjVi6JQH5Ed9q9XGRtWA4nqu32miGXW
 sTQ/OIMPKvGLfspYrOUjCcdtKUFRVR895gJYUFrTEhRhLytYFyc6opy9CvRLGWS0YbPILAyG1mS
 qQ8FTjho=
X-Gm-Gg: ASbGncthIffRhKYRX8wQbluPLSak/1Igr8z4+3ayvygufU1EuWqhlSZUPoI0REwB5Tv
 g7B1XIZ99VS54SgYuCxhk8Vw+BFA+2urrh8sVGVolO0gHdw4m496lbe9x5x4iNQTHppZrSe4nmv
 ykvx3loJjEjZR9ndhP9QRb3IAewVnDk0F95Nv7Sa0D9K5SRucLvnHBDTNA1lxGsAyVhuGtMCxpJ
 zjcIPJRdV26TYH25zIxUwyiZBCtkWxYD4TKrDjYwWV0vo8WwbLKgAR619uMnoheXG/yZuVr6IT8
 DfmOzTepOHgSLg/E9w/TZ/NvsYXnK3gW4BXA5IxJCDsp6fTVRSHn26236S5fWOBUxJs0y2y2GNo
 PsPWaz70abCTInxWJ5E1Pz3nCuyOhlErCXX5g
X-Google-Smtp-Source: AGHT+IF5e/MuVYJRmblkXpvIfqjyXNK9gk5KRckaMD59FVUxTzSpN5L9R5TIl76Grn5AxAQzY7bE9w==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a5723a1889mr19428150f8f.14.1750338824180; 
 Thu, 19 Jun 2025 06:13:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecdcsm27991485e9.36.2025.06.19.06.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 04/20] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
Date: Thu, 19 Jun 2025 15:13:03 +0200
Message-ID: <20250619131319.47301-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Only update the ID_AA64PFR0_EL1 register when a GIC is provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 42258cc2d88..06cfb7ba253 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1057,11 +1057,13 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->mp_affinity);
     assert_hvf_ok(ret);
 
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
-    assert_hvf_ok(ret);
-    pfr |= env->gicv3state ? (1 << 24) : 0;
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
-    assert_hvf_ok(ret);
+    if (env->gicv3state) {
+        ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
+        assert_hvf_ok(ret);
+        pfr = FIELD_DP64(pfr, ID_AA64PFR0, GIC, 1);
+        ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
+        assert_hvf_ok(ret);
+    }
 
     /* We're limited to underlying hardware caps, override internal versions */
     ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-- 
2.49.0



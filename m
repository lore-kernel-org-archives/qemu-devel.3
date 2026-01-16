Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EE9D48984
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqe-0007GS-31; Fri, 16 Jan 2026 06:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqa-0007FF-QP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqZ-0005fw-C2
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432d2670932so1575172f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562309; x=1769167109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CcnzBZgEqrP8OEgT2AND3gS2a/N3KEvsYp7Fa2E/Yak=;
 b=O1EYwyYZdXRdBgnGIM5WBE4vsPgCfMopspyv4/GCjXldvepkJAZJmSZ98FiipUyuWI
 mFoHIjwbdjsflY9Fo8NU1ZUecUD++/Lbh894hrwr9EPl2thpZ66dSzzDqDAzW4iwBdLN
 TzLFBn7uGAUEeHKDXsTG4siOsIcwO61ucV3z0D9A1h/T0dSvuOWNUJt3yUoyjWh9SQCb
 vpEFsu8t1QUqFPWDCYfcJ20E1689/kE8qCxAxYtNV9BSTR6a81/BdYhnOeCtoxg3M5qQ
 mln6aDqHgtopGhPMDlA4f+qHHUmuG6NUYzqx3jzeWWi+cT5DT7eBgNlqMGrZX3xAH6aA
 bDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562309; x=1769167109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CcnzBZgEqrP8OEgT2AND3gS2a/N3KEvsYp7Fa2E/Yak=;
 b=E9qMReKzswCVv3m1Mcvcu48bwEcHFsm5GkzZctIUsgy0HWEWhD8V7QoD8F8jpuSIqf
 uzjl3VxevBMHQu4m5U7wUjGXJEAhG6nOrSdAiO8+E6ftUppDOPE48+HI2nYbToWSfoia
 PlePqsRin1AT6+9c0S1Vr0nDAutPfC/wzGdNzaxu/GCrAL7AI9EG+JWit6XTEXTXnXBm
 g7NL7UOe1Ajjhtk1g4sm8gH8fMfiEMdS0eCArKFNukJNV0Rz4GMI+jwb1yqKw4wb4a1D
 UBk5zUUgsH8s9U1O7JhwYDte6e8uA5dbF71qBJeSNkog31SKGotKOQtXJMA18r0qZPVw
 7WxQ==
X-Gm-Message-State: AOJu0Yz+dLLDPkE1lfkhmUtk/fmhlg3yG0bNsieatEZyHBVwSD287DxM
 OnFORi9cVC+K9B1+GC1QIVXlPNixb7Mla8x8nFDW1ZGQGefZ6mntC/BnUdKUM57+QlJOv4PWwct
 eyivjfg0=
X-Gm-Gg: AY/fxX4Di0V2JvuvXc3T2xVTGP41/FwJThwFlp224/7Zt968SUxd+32X4LU3A6MXYVp
 XoC8aV5RjtPzojNfa/wQ1omh6EZp+7M24ph6lbSiNbZU+VgRICMz6129cQuhQQ/sK94qxH11024
 gdT4F1z5yBNelSHmcmMMjhR09s3f3jVgMe7jqV5j/HJKhabGBGjaWlJtzeCyP2x/QgMhfC47cs2
 EHwyXbS8Ikk0GxtZw9a9U6mdVs7Azsb7SWkKLovfZu1Ns5dlgw2Slh4tb/+RqjjN80SSWiobapX
 RgDbUepaII5WigY4yUlRkZX6fRESc+QvVbdLCmrnHwT8KZk0cJaMW6fvjA6oPwllgL0p2YE1zVp
 msSX9VQPj9NvuUs7FiGdEoKJXxhI5Ph8k2Mmg55vp1sfwNoMt6az/ok3ekBfXW9qEI7+iO/AoaN
 7d6MQWNyfV54Lwv7kavygkV8c3DWeJlnxAvQ1PSNXRAL1R04p7btbpxlvupUeEc7a5xazfA1U=
X-Received: by 2002:a5d:5d10:0:b0:431:a33:d872 with SMTP id
 ffacd0b85a97d-4356997f5f0mr2788890f8f.8.1768562309240; 
 Fri, 16 Jan 2026 03:18:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ff1sm4592945f8f.13.2026.01.16.03.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/30] tests/qtest/migration: Add MigrationTestEnv::has_hvf
 field
Date: Fri, 16 Jan 2026 12:17:40 +0100
Message-ID: <20260116111807.36053-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
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

Allow tests to tune their parameters when running on HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250128135429.8500-6-philmd@linaro.org>
---
 tests/qtest/migration/framework.h | 1 +
 tests/qtest/migration/framework.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ed85ed502dd..2ef0f579626 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -39,6 +39,7 @@ typedef enum {
 
 typedef struct MigrationTestEnv {
     bool has_kvm;
+    bool has_hvf;
     bool has_tcg;
     bool has_uffd;
     bool uffd_feature_thread_id;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 6d830079ee4..57d3b9b7c5a 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1101,6 +1101,7 @@ MigrationTestEnv *migration_get_env(void)
     }
 
     env->has_kvm = qtest_has_accel("kvm");
+    env->has_hvf = qtest_has_accel("hvf");
     env->has_tcg = qtest_has_accel("tcg");
 
     if (!env->has_tcg && !env->has_kvm) {
-- 
2.52.0



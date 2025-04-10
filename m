Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE7C369A8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 22:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u30p1-0004Dp-IL; Thu, 10 Apr 2025 18:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30od-0004Bq-LQ
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30ob-0002Zs-Nm
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so1121797a91.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744325768; x=1744930568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngzxySh83zpFGyW3pjy22+MdVTCG52OkuHe8t+5ldxE=;
 b=NyxIL4mNQPUxLlrZdPhHDsgHqgqRc54U48+I94Vr2CY4mpfXq4Gs07b7w490eX+uD4
 hPYksw5pu7u0rK8PIJPun36JtdDDTHe0Q69soxc5ONY8Dqt1BlL+nJ3A1HR58/CgEElR
 pZguZgjW9eY3mCpc688LygyL14t51rF9RDhUbm+aAQkmoQjilajeOdVB40DeY0NiH3Oh
 WFMa10cMAEgDdmrVDOM5jslOyXKG8UeeoSLk9RBTLTgaQno9kv5P7TMnerVkLnxpAjhj
 u6WZKFhZPruH7h1N+7uF77YE9HCuMjBxAG+n2pmrRWjcjxQgAKJW0qlj3e5Qh825/ySo
 iwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744325768; x=1744930568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngzxySh83zpFGyW3pjy22+MdVTCG52OkuHe8t+5ldxE=;
 b=unMs3yrDjKxkuGXUMeKHbYeqIthUV6K+33lIyIt9Koq3i+2pO7msO6Tb451V0veOQ3
 kQPqJn/k5ehNk0kfBgpuewJpB8z/Ee3Ny0rynxFgH6wezO0LZTuqMix0XRVWvlXxbKG6
 KZ9QPPtkEGCCK+ci/IzaIGnktGyJNzuquKVANDrdlh7knbWMdCnT3JjemKnDwyHUtGhS
 0PCIy1INH4ETgQvHVLmDYbDHx5yYmxUoAzlsCnJ44DssaLpE8bBrzzi8G706u6HKIFLx
 AmmOHherHbMHCy6YGNEDme5lNPO09jcb3yVQFcAttwQORQL9dnB50W+QVbK8pZkG4oxP
 6A1w==
X-Gm-Message-State: AOJu0YxsYzsgDC55sKTywUIQdhjubjk9XrS8aKUtT7bdOBuLm45Uo4AX
 2GOZjgy+BaEns6ijWVyeRd1gubsQHnJHOsCZfQwd2xA6YVkF/NwdwbagQFAcov6KEw5w6X5ul52
 KotY=
X-Gm-Gg: ASbGnctib15MHel2yGa2ws5rT1pcp9mcaHTjA9qBLXIenJa1Vnq9PBe+Qtr+qBepQk6
 228r4HzKwKtQ9nSNXwBeW2OgmmWp+EGiJkt/8YzMWk+Zo6XCi2HXf16TMlRyANDJ4xT0UOZKUIP
 P2IoMkgyfyHaajgbK2axhNyBx2agG5z9p6inikPlx3E9cTUf/abV0rrlz2uMDUd0bPQ4c9epOUP
 SlGpPbiYTPqodfMyvTaolUXt41CB3dRzjl+0XKiOO9PffPhwXqKGAwKXZEUCrrVKysCGLia0uSz
 s3H2QGrrVGiivgVUpYcftFNYaN/fy7k94+ErHiir
X-Google-Smtp-Source: AGHT+IHUlPRqrszEK/wBZZA5sipykQdx+eszCKvxdc3OYqBcONiY6hwrfDcV8Y9GGWaFXCKKBOgT5Q==
X-Received: by 2002:a17:90b:4ecf:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-308237ce142mr887982a91.30.1744325768075; 
 Thu, 10 Apr 2025 15:56:08 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c97228sm36249225ad.128.2025.04.10.15.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:56:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] tests/functional/test_aarch64_replay: reenable on macos
Date: Thu, 10 Apr 2025 15:55:50 -0700
Message-Id: <20250410225550.46807-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_replay.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/test_aarch64_replay.py
index 029fef3cbf8..bd6609d9149 100755
--- a/tests/functional/test_aarch64_replay.py
+++ b/tests/functional/test_aarch64_replay.py
@@ -16,8 +16,6 @@ class Aarch64Replay(ReplayKernelBase):
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
 
-    # Failing on Darwin: https://gitlab.com/qemu-project/qemu/-/issues/2907
-    @skipIfOperatingSystem('Darwin')
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-- 
2.39.5



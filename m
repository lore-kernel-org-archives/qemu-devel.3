Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B5BCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4iF-000306-Mr; Thu, 07 May 2026 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hX-0002mL-1V
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:09 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hR-0006A3-I3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so11893225e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183256; x=1778788056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9M59IsSQ4jRNfkdEPtwMPinyMjNpa0S+EfEckZHfMA=;
 b=yvM0SD1DbPS/fhF2nhZ6FIAwvjoPl50cetpo7E/7kxYNzJ/URcrDsAQ3kYGkLDMRU9
 wl5OQ5pcVSFh7R6f2x4DRDfQRUoI2Dde8CTZQtY++NIdbM70hrOxKCYfHcLeRZNfzuPb
 Z5SIcfYFgBo4v792vg2UyEgfS8h8cZZVd5U7FneUMLJGR+ds8/l80sq+ng16DqjFWuEK
 YxM5K5q2Spdzlc4YArt06xH1wwgBmPJdBsEo0HN04PHjV1AI90Thlz753gcuXjX9RZUX
 N7OoRHbTGhyGrWXzfOYHbSKXPJApJcvncMb6JrYGXELzyMhokX3i0VL9iz3i/JsZe12M
 sRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183256; x=1778788056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9M59IsSQ4jRNfkdEPtwMPinyMjNpa0S+EfEckZHfMA=;
 b=s8gf1XylgzpEa3ZGU3S0TolwcVB1284DvbUVZXh4qe3kp/NUfK4WEbsN1coffaQvjO
 u89qpVJ3neFkc7fuzmTx35hgbcInGVGKpNKNTSklelsqipiNxHzhtpSr2LPhUD4qRPr4
 WijiqoA3PcJHqM03aSu1kpDB6WhMCgIzhMt6+uYR0Ac00FXJfkUBhqSKYFmZIhfZrkx4
 Gsh2LeKc19GjdntQnC+wJkohej21aF4av6gmm+b6wW9g7dRZ/meDRhA1SwgpjnYi9pbh
 s+T7gj0NrDWbH1P0Ya3pP3L4x7CVAYu1HhP4X5lFEeHMp+fWZ+SG5F3lVwLWtojl+RxE
 fQag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/kCbxbMt4yYdVMhjfkrLXGxOjhZgYuiMK2dgTKPe8VLqUQnpcXMqkNiGn6XEouZle4CEqnZyr1BHU@nongnu.org
X-Gm-Message-State: AOJu0YwlW1EPMO2NBNUvCRaZRcMvBbrec77X7/YFikPhSBV/ar16nRmB
 cYrJhGO8X3ncr3Eqnd613tvt3snNprkNT9M0m+MGPGXGr7IIRjONhGV32rZQKEpnQlg=
X-Gm-Gg: AeBDietixx78uOkcic7q80BwpN7GRVhFUOLD5emat7iY5topTe2YSPsOivSQPYnYtMs
 loCuH64Gxd9aZdWGpC8wYoIlFot3rN0fGMnH6x347Kj7UFuFLlgyVqqJ2/li1yctYy13GtBIM+3
 sNEkGMQ0Hs3s69dawLDO9zeYXDZ1IcYtFsblH3JUf+D2mYHGeyTRxNKhDal2irDRwPdWWhtJqqJ
 VPdiOzCWMnPgudRceKa5k01RF0wPDFi+Ej/ZDsT/+phHVgJGA06voJBJH3aUR0mHGe3oqKz7+OU
 kmS2mWkfY2OCW6zoST2MUoIjMFH3pki5oz1eVG5TNlMI1fqk0Nh2ZfsCRuM4Qafn8zYAnggWMgD
 dhUnfsxYGnWS2P7wveFsdz+SBu/yk7XXoAs8VvXqYvf4SLQ8lll4lhrAuJBXhS0Tsk8j5TYsf+C
 bw2aI+uzQhFadKYhPYzOYLGKBM3Oxpqkkdr4oj3UQNFonS27VoQEdr2P5YaaE7uEu5Y3oInUVhC
 BGNbWNMVK9tl4guVVJyC4he5rCkHaU=
X-Received: by 2002:a05:600c:3548:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48e51e097fcmr148799915e9.3.1778183255813; 
 Thu, 07 May 2026 12:47:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c145aasm958375e9.25.2026.05.07.12.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:47:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/6] tests/functional/test_kvm.py: Skip if virtualization not
 supported
Date: Thu,  7 May 2026 20:47:26 +0100
Message-ID: <20260507194728.2034696-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507194728.2034696-1-peter.maydell@linaro.org>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The test_kvm test runs the virt board with virtualization=on,
which will fail if run with an accelerator that doesn't
support nested virtualization. Catch the VMLaunchFailure
exception and skip the test if startup failed because
the accelerator can't support virtualization.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_kvm.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index fed18aba60..c977e8c6d2 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -14,6 +14,7 @@
 from qemu_test import Asset
 from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
 from qemu_test.linuxkernel import LinuxKernelTest
+from qemu.machine.machine import VMLaunchFailure
 
 
 class Aarch64VirtKVMTests(LinuxKernelTest):
@@ -44,7 +45,14 @@ def _launch_guest(self, kvm_mode="nvhe"):
                          '-append', kernel_command_line)
         self.vm.add_args("-smp", "2", "-m", "320")
 
-        self.vm.launch()
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "does not support providing Virtualization" in excp.output:
+                self.skipTest("accelerator has no virtualization support")
+            else:
+                self.log.info("unhandled launch failure: %s", excp.output)
+                raise excp
 
         self.wait_for_console_pattern('buildroot login:')
         ec_and_wait(self, 'root', '#')
-- 
2.43.0



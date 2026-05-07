Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92FCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4iF-00030D-TH; Thu, 07 May 2026 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4ha-0002nA-Rt
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hY-00068Z-OI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so11394425e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183253; x=1778788053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwQoznHfoi6X0cMFnSCdgFp2onTlRFNtNkmcJ9GY4w8=;
 b=M/hCKBEjjDEvqrp5nqZlsfv9ubd5TEQXKJTRdeE3PuIk3KhtR0T23Pz7+8GZ0rVOJt
 +Tv8SpJVW+Ri2obPvI5ZMF7F0sI7H2bXoTYMiZ5LDyWMfePRYY5Ly/fDQOmJONe0L2d7
 zqadIvTe8IyiTU7gwlIR8LungJg/7tEERQt/aKI5mMi/NcIuXqXnZM1euvpKy/1VD1cM
 w4I8Rz5MzigI+JSodEoK5+0eVfiK5LoSaO/Cs1MJcXogS7zW+hPJqKNFZmoFogOOvrgj
 WF1cYG6jORPKIzN0kRjc9LPT5PGY8qWfxGhO6kR5bFNsHXFL2+fposlPDhEX8pgGfstC
 SrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183253; x=1778788053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwQoznHfoi6X0cMFnSCdgFp2onTlRFNtNkmcJ9GY4w8=;
 b=QWtQ6bcX+j/zFyDvLRPeUYaZ60gG7A45aq+vWxQ4VspfLE7pADDx0+HlyAUR+m2+XF
 MEMisKPoFFpJCTBUV8Ifxc1MVjnJwVnNZkFYy3WE46Rc0TM0nHtRw1aYpCzmSynzVHgb
 I42RfF3k46jzdSRhYmhDGtXbXwUT1t/UD0lfxj18yDa1ouiFPW0Uweq7jBbjSm3BzI+F
 +3G8xrt9LtT97KRmf7PjtwvZs6CizowbHxWZcMHPNCdjeXb7WW2xlwOCjlXHH4xufhFL
 EWUVS9y2Vvof3LHMKWMqGbWOyFxy+QknnH4OuktTKBgpqugAbwOiBTKmYY7p8OYD1Pv9
 pWzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N4wCcK9JJtAdnk7Cu6o0h/03qMwGgpJw17b9OVxHK2D9/zup/P94PiOafHuX8bN1M3Tu/i4PzALu7@nongnu.org
X-Gm-Message-State: AOJu0Yxc81zpE/Vn+v2ekrEb4wKtDgCe+4k/Oj0hEg4PidNdABhYlrM7
 Do+Mva4n5sm4zMR6yzjVZCA3qoBMVWZla/tuO/cAJCfYWj1zOASps1XJ0Olm+rsOy3Y=
X-Gm-Gg: AeBDiet7USOYKA6W9HyI2y6vJ8+lwr7eVdqW9eElgZ9fgPUYMABykX8uRaKYWaeCA7j
 SH7DuoOfBpHsorIbpLISkVmgSmWs+reL5Hi50sY9iqkIT2MpAbsSgLTFV6Z2f6+wN3dzxx1kTAO
 HiOINWyl7oaOcjct7U6wOTj5spLKOqpHl9YsGI1PswIXn5h4vBEB1lERntrst1t7IBYg6xuSZd2
 89PEg2FbDQQbfkzaUCIRDBJBGQS+PeHG+TJgGTns83R0ptjKNNZKvaHgeGW/b2fdQWUVcCqeHq3
 y3fH5Bgo9dMIqHZWnrgLrHc8LQ/FbBCRn7ARhNf18oi4gLMPvDxFbBNYRHWhb33LFSrFEWqYRgA
 UxRVoWF1Srm2fNbPKilKc9N17+OOyT4JAohHV4EhbWnYJQQy9Qo+zRyPfkAp1z8+hJMFYR+nkEl
 FETE2BlNONSqDCXo7tjivXzlCX81//6p0TKNUk4yHFG0eMIdvjyc6CnWNK8tUO3JX7BMCN/62ZI
 8hmymxOxMw19Q7x2d0VbO8SBLPnmk0=
X-Received: by 2002:a05:600c:a111:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-48e51f46e24mr123393295e9.25.1778183252784; 
 Thu, 07 May 2026 12:47:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c145aasm958375e9.25.2026.05.07.12.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:47:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/6] tests/functional/test_virt_vbsa: Skip UEFI test if
 virtualization not supported
Date: Thu,  7 May 2026 20:47:24 +0100
Message-ID: <20260507194728.2034696-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507194728.2034696-1-peter.maydell@linaro.org>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

If you try to run the functional tests on an AArch64 host which doesn't
support nested virtualization in KVM, the UEFI test fails with:

   Output: qemu-system-aarch64: mach-virt: host kernel KVM does
   not support providing Virtualization extensions to the guest CPU

Catch the VMLaunchFailure exception and if it matches the error
messages the virt board puts out for virtualization not being
supported, skip the test.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_virt_vbsa.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_virt_vbsa.py b/tests/functional/aarch64/test_virt_vbsa.py
index 57bfe5d7af..04b5ff0f9e 100755
--- a/tests/functional/aarch64/test_virt_vbsa.py
+++ b/tests/functional/aarch64/test_virt_vbsa.py
@@ -17,6 +17,7 @@
 from qemu_test import get_qemu_img, skipIfMissingCommands
 from qemu_test import wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
+from qemu.machine.machine import VMLaunchFailure
 
 
 @skipIfMissingCommands("mformat", "mcopy", "mmd")
@@ -96,7 +97,14 @@ def test_aarch64_vbsa_uefi_tests(self):
                          f'file={img_path},format=raw,if=none,id=drive0')
         self.vm.add_args('-device', 'virtio-blk-pci,drive=drive0')
 
-        self.vm.launch()
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "does not support providing Virtualization" in excp.output:
+                self.skipTest("accelerator has no virtualization support")
+            else:
+                self.log.info("unhandled launch failure: %s", excp.output)
+                raise excp
 
         # wait for EFI prompt
         self.wait_for_console_pattern('Shell>')
-- 
2.43.0



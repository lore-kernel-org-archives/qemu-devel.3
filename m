Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C21CD4F49
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7T-0000la-TM; Fri, 15 May 2026 06:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7Q-0000jY-GT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7O-0001iv-QZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so106423255e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842209; x=1779447009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t5UyGdhJ5ab4DMMu7acjly7i11P0+6d7XRfGXSmtjA8=;
 b=CMT0pPQ5fjdUN0+I4yISI9HPtr4oSyZAlr8mePJ7wGZ4bIk6ZPcPDeWM3WsvZYO6DD
 4WYzfApsYthu1KZvAC4IbOQ4bXaG7yXYdOFU0QbajuIx9JeDWGnVxq1h9po99z+Wol3v
 e453Ogarw+d/CBggI6UVVP4scUWOQYhbo2GHEwMLfO+HM5r28IoEXMb46FUXZP59es6q
 FeFecuRUKrf7gBO38u7inIHNaReOSvrXcFKFjNGAeORUJrm7aBvmE3lKFSqCduWFmWVv
 oNjaw6yVn11CQOubEQQ+4sa4IIPoIGyNEs7qfoboC+nodjhwAD6oSHZhwpFeOWZfvbUT
 LAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842209; x=1779447009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t5UyGdhJ5ab4DMMu7acjly7i11P0+6d7XRfGXSmtjA8=;
 b=fnD0/czoiRoJbkQP9An4qViDILmzlWQXLqH3kwvVmuT/QjWqtxWbasGaqCsP0fPgWQ
 TGIbK79wDnQVICK2uKVzUFRxT/PGyT6nkESeiRfHQ9FULrSuI0BVCjmImY/bhEznSYIf
 /0q2Wf2KmK6DxKgjjnEp867tWAjq4/P6WgxOkxwT+ivfmfu/CWCzPRTJYWJuCNbjEE8Z
 yEKAT3meoZndmaLnNP/YLfp7G4ln3HHpiD3kyIxhMu9ipv9bqM8euZG1VelJktDzsHG4
 qp60Rax3cv8bLnZ5k51PDphyDMhoCMUcj6qaYeWDhV/N6mMvtOKVuVXfdpyOAanwkqYR
 nN6g==
X-Gm-Message-State: AOJu0Yy3t1PGDy8EwTaW0/Qs2cAiSBPcCW4DfddIi7ERCktV0eMajBTW
 AJu0ZFli6URctM2YmXyFs7VNI8b77CEPmroMJQkPmnqC9/WJWlFPEFvjP6BvnJAXefnl6Lh38iH
 ty7gc
X-Gm-Gg: Acq92OEDuLmJPNt4BysNM3DWEijB5olLMyUTDt3lmNx/8r/m+uAbiBHQ51VHkHiH0LE
 RJCnJ4tWUP1eZThhwbrdW+saYm4NHeoh2hY77Cy8N/Ss/8j32ey+v9yPju1pmpHUtY1QR+C5lHu
 21NzQVLse9mHUmIg75/HQRiy0pj5AQEW4F9IeOGlYw1msyOTXZRzHouxufAq+2JGbCCT/3ZHq/J
 DPQWwOrkhIspWBzBZIzo7TrgWX0Xw0gKA0FbbOaNOc2oaHK7WN8DDRKYc7Ia0vqcddCnQ/LQ+Hz
 pu4/6XiCHxHCpYSyrdemUPz4sN8qqiHDMVqI9vTEtihH6gDOwaKJG/tCcpDBfwx3wIGSMNI60Po
 MGTl05Neiwx4f1X9jysCiL2Y9LEOOSvFB+HppVParemoco3+qs4276dI6vxus6ieRhVz7n6QuEV
 63bYMz14cJszPqei+GK0rmNWPMZi7LWamsoUfbMBgvgH4Z4oNH2k710vFbqLSrxzeaQhCthRRNm
 J/uuriQwYTZHarfWX0DNprGHvWwQlc=
X-Received: by 2002:a05:600c:848c:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-48fe60ecc19mr47082025e9.10.1778842209059; 
 Fri, 15 May 2026 03:50:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] tests/functional/test_kvm.py: Skip if virtualization not
 supported
Date: Fri, 15 May 2026 11:49:41 +0100
Message-ID: <20260515104945.4145203-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The test_kvm test runs the virt board with virtualization=on,
which will fail if run with an accelerator that doesn't
support nested virtualization. Catch the VMLaunchFailure
exception and skip the test if startup failed because
the accelerator can't support virtualization.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260507194728.2034696-5-peter.maydell@linaro.org
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



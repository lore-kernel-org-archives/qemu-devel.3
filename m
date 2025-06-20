Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3600DC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6W-00056d-N5; Fri, 20 Jun 2025 18:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcZ-00084Y-3z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcX-0006gR-Ga
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450dd065828so15684865e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440824; x=1751045624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfWWhjsYTEwf+OXuiGr5P2a/yneNzZ+GBAXkKsbcgoc=;
 b=QVR8nF8fVOb9cB3pF3esZwoCMAQFseXzsKWNk8QQdXbIhph5gsiHMTXvi4FTDYlujj
 aj/AFV+jwL6Ouf60MFERtHdsuR3OoELgGE7htSjxBApybwytZ7fQvxO/4l3yxSRnr/Uc
 ch/40L7oAEN+19vcTI4+v8fWberayKsmb61G6OEpOv1jvpFZKvlmESvM7JMDz/VGDBHc
 bcp5bYnrPf95Kai8lQaCH7dRoN/7/BkVPvWzL+BMdhfxPdo8zXtFu21X3liFRb6Ygc+6
 zxJy+28Ll+Jdng4m5CIUXEGOePcPyhmXDuYty1n0W3hLch/SMUmBmCtbzWQT3MOOwrzp
 44yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440824; x=1751045624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfWWhjsYTEwf+OXuiGr5P2a/yneNzZ+GBAXkKsbcgoc=;
 b=Om2uCiJAwIemS2ibn0phu4XzG4pheNQCVGHrxaqGjfvjOBkCYPf/dw+k77doBdHNxg
 0n7hHzsMjCvTDCj1MW2uiyiCSw1PS4un7MM47VsexgFx/qzuwqLXbCLk6A9faCdJ/5TO
 kaDFylih349X5O88MAa6m85ayONV26m4O8GL0APKMt61vRDI+E0TRfcIYysTSy8zCWde
 q8HVRtHjuFu1ZMlZxqahPDqWqPHwqe2MQMrnbg5rZCeYIUvnJscuRAcs1h2OCQlh5kgG
 HDc/9cOoElqD59LQZJO8sli/tOaVr31OUBzY3MyT8OowJdalM1U4q63dEYEctaC8xA9m
 gKyg==
X-Gm-Message-State: AOJu0YwO72y85dzakP0l8dlGTjlTrQ2NyUnG/1Iw89m5O76cddhmNTaV
 CbVfrUdAf1ylFq+fDWbjA+mrWBCPdrkhCo1wh5XcqVCz/vxRFb7cIa68wHt/6cqhkfZtoaVq3Fs
 K7Q3GVfwD9A==
X-Gm-Gg: ASbGncvOvj/pwP07a/RyLmSUTU+5hoBKscpsPAGkSVTmIqtyU6sxRUAmXMuIxWZBuVo
 dTXoxxo5P3GPLyxf0HfqZSkeGkMSDl2Rw7ACdDfG5IxXzPfCMx42DTE/B4oAt9wcMbwQcaAJWmP
 7/0pI5KGKgG/uHwNoNMyBb1+6L5t6xjKxe/UOrmgaAR9Aq+W6aqjmOtSPNL7iQoMip4Y17qTrNz
 H0XnPReE6l1tFXDa6RPMPQ9efq0N27YrPmZ5ddSQ3n/+N/xCWhBnYoukTiqwH/k/xWp7bhIwkOA
 YzTl8KvgGogvQvwnMs74+B+iJM22XECXTiPNAMmaQYdrMYc+7Yok+FmoOob2SIrry1U57O5HrWq
 B4xcbBjr9C4MhsAeG20VhxRE4po7uulwALAiHuXuLFlcZucDIHCWLBJ/B
X-Google-Smtp-Source: AGHT+IEkO1a0JCBcpYhzk2a8JAzVXYRTbhQvPhm1eDqHChIQG1lffcZ8QqSTbQsNUxTdNEbN9wM+aw==
X-Received: by 2002:a05:6000:4203:b0:3a5:7991:ff6 with SMTP id
 ffacd0b85a97d-3a6d11926bemr2996590f8f.1.1750440823802; 
 Fri, 20 Jun 2025 10:33:43 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c068sm2672385f8f.54.2025.06.20.10.33.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 41/42] tests/functional: Add split_available()
 helper
Date: Fri, 20 Jun 2025 19:27:49 +0200
Message-ID: <20250620172751.94231-42-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 python/qemu/utils/__init__.py          |  3 ++-
 python/qemu/utils/accel.py             | 10 ++++++++++
 tests/functional/qemu_test/testcase.py |  4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index d2fe5db223c..74218b9f2c6 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -23,7 +23,8 @@
 from typing import Optional
 
 # pylint: disable=import-error
-from .accel import hvf_available, kvm_available, list_accel, tcg_available
+from .accel import hvf_available, kvm_available, list_accel, tcg_available, \
+                   split_available
 
 
 __all__ = (
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index 376d1e30005..0f58998b2f7 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -90,3 +90,13 @@ def hvf_available(qemu_bin: str) -> bool:
     @param qemu_bin (str): path to the QEMU binary
     """
     return 'hvf' in list_accel(qemu_bin)
+
+def split_available(qemu_bin: str) -> bool:
+    """
+    Check if split accelerator is available.
+
+    @param qemu_bin (str): path to the QEMU binary
+    """
+    return 'split' in list_accel(qemu_bin) \
+           and tcg_available(qemu_bin) \
+           and hvf_available(qemu_bin)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2082c6fce43..b6a534a29f0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -23,7 +23,8 @@
 import uuid
 
 from qemu.machine import QEMUMachine
-from qemu.utils import hvf_available, kvm_available, tcg_available
+from qemu.utils import hvf_available, kvm_available, tcg_available, \
+                       split_available
 
 from .archive import archive_extract
 from .asset import Asset
@@ -319,6 +320,7 @@ def require_accelerator(self, accelerator):
         checker = {'tcg': tcg_available,
                    'kvm': kvm_available,
                    'hvf': hvf_available,
+                   'split': split_available,
                   }.get(accelerator)
         if checker is None:
             self.skipTest("Don't know how to check for the presence "
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BBAC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSn-0005qn-Ch; Tue, 01 Jul 2025 13:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSk-0005mT-0p
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSh-0003kl-U5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so3770841f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389682; x=1751994482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=glY6a1QW0oSKa+BPVnL2cNWYrq6lfNT2K+pLM2j25qk=;
 b=yH94nALA22vJZ6M9+FruDuIzj9kDELEIx+7FjOBSno5pLrJi5kjuro1BlE/QjMxs2I
 lnpfE4olQKySO6H3spD8NkWRx5+ZnKhFhiyCYJtDeb9gMPWCVldjxmJJtgjrWDNOFGyO
 AD6oEOixel/KTyON0C92+2k6To56UBfuunE4P1F8t2TsO+hiunh5Iv8jf25S0I8DiYRF
 NLrwkbe5IVi3zklxvk8HUSwUh2ehEeLjWp8Ct4ZsVwDMO3hLbn5JOTnaUMcQcqADPXje
 btoBk3g2SI0TPmeN4imdcuUK3ng0NwBv+Uvd09NP6ulvHXZMSmLPd92L4HvRxW5eiP51
 Xr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389682; x=1751994482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glY6a1QW0oSKa+BPVnL2cNWYrq6lfNT2K+pLM2j25qk=;
 b=NseTuSSVtZ7nec8Z1vfUCaGnFlBMbYF2ticFGe2bTAM5hCvkFZinl6h7k/cc1aR1Wn
 yrf4Vslxx1GOjSGNQ0fl0mlsdlQYYVFrzoukKvt9/Vi2OllKhhBxq4jKGpO1hEHwrPuE
 eRv5F9q97BgOGnmlHuSqHYXc5Ch9GT9nKHabW1r9hYZzRfLb98v76i6Y60wq/P6xjIJL
 IngkaaWdVXbMbm3j3/21b4+A59q9ni9aHz0Mk8Cy85vJF+HN7PNKlrUzHeeViESrXal1
 2yDw9/t4uYYGgpzSVbhXj85MQWrBbtlwpbEYmJUKCUfCXUnDTmMp6k59iKei6s+l+WP1
 PP8A==
X-Gm-Message-State: AOJu0Yx/DbDs9ZG32bD96VRxZ1LPsI6o8MhXhqxOYvlzJAIYGUPOD7jI
 U2XAJ/xQNoecsau5kxIiuwGgzhEG1AuiuGdj7TdCxo62iZUIx/85nRw0ADwQJ9ipKHFX8cotct7
 u9a95
X-Gm-Gg: ASbGncvI5jeGLW2Igm8sUiiEBMBsOkZMwrMZhKMIaOGWobWiucaoX6WTMYTkODgKM9P
 ou0ahlx19pQAe7XbnrDhGm3T/Ce9c87JxlQLtGOKYqI+FddifX6WyhHWl9Y1UCHvXtEHfKckrai
 19d00nYezBMlCyj/M+mlx1PKM/0OD5cAyDYvHlcQG41UMRvLpDAr06dGjHMrJa54NuBCFVkEehT
 ike6UFH17OdXkL3kosCLiYj1FVeYGIakVUGFBZKyITwXUXX0UU1CDVogeraILZdzPM/fU9PFyIA
 Hk/SaanwH8l380mhBYSqTtdKJzOr6+ZcGW62S7EfMOPv35EPO5QQbBS3MlCwb1ARfXG7SLicf9g
 V7rg=
X-Google-Smtp-Source: AGHT+IGDjHjcMWczVbfhf7aGrvSGV/OBxdbXzEnTW69A8WuZKy682IxH9vSHxQxDOhtoxeHexoCGmw==
X-Received: by 2002:adf:f4c9:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a900760066mr13971684f8f.47.1751389682342; 
 Tue, 01 Jul 2025 10:08:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:08:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] tests/functional: Add hvf_available() helper
Date: Tue,  1 Jul 2025 18:07:17 +0100
Message-ID: <20250701170720.4072660-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250623121845.7214-26-philmd@linaro.org
[PMM: tweaks to satisfy the python linter CI job]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 python/qemu/utils/__init__.py          | 8 +++++++-
 python/qemu/utils/accel.py             | 9 +++++++++
 tests/functional/qemu_test/testcase.py | 6 ++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index 017cfdcda75..be5daa83634 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -23,13 +23,19 @@
 from typing import Optional
 
 # pylint: disable=import-error
-from .accel import kvm_available, list_accel, tcg_available
+from .accel import (
+    hvf_available,
+    kvm_available,
+    list_accel,
+    tcg_available,
+)
 
 
 __all__ = (
     'VerboseProcessError',
     'add_visual_margin',
     'get_info_usernet_hostfwd_port',
+    'hvf_available',
     'kvm_available',
     'list_accel',
     'tcg_available',
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index 386ff640ca8..f915b646692 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -82,3 +82,12 @@ def tcg_available(qemu_bin: str) -> bool:
     @param qemu_bin (str): path to the QEMU binary
     """
     return 'tcg' in list_accel(qemu_bin)
+
+
+def hvf_available(qemu_bin: str) -> bool:
+    """
+    Check if HVF is available.
+
+    @param qemu_bin (str): path to the QEMU binary
+    """
+    return 'hvf' in list_accel(qemu_bin)
diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 50c401b8c3c..2082c6fce43 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -23,7 +23,7 @@
 import uuid
 
 from qemu.machine import QEMUMachine
-from qemu.utils import kvm_available, tcg_available
+from qemu.utils import hvf_available, kvm_available, tcg_available
 
 from .archive import archive_extract
 from .asset import Asset
@@ -317,7 +317,9 @@ def require_accelerator(self, accelerator):
         :type accelerator: str
         """
         checker = {'tcg': tcg_available,
-                   'kvm': kvm_available}.get(accelerator)
+                   'kvm': kvm_available,
+                   'hvf': hvf_available,
+                  }.get(accelerator)
         if checker is None:
             self.skipTest("Don't know how to check for the presence "
                           "of accelerator %s" % accelerator)
-- 
2.43.0



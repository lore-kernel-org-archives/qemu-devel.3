Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8A4EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAL-0002EX-Aj; Tue, 10 Feb 2026 08:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAH-0002Br-MW
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:29 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAG-0006N9-30
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so2702877f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731546; x=1771336346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kq2OeTrUcPIegeZ5VRCi1cFtIhc0er3FyZyNyjg0Krw=;
 b=R8nTJPOP8JkEEcuIQjye4i1DcboGnfcHbcwRL3V+gNloasHAj5ur6OVfB7Mkw0kMWt
 xp2ZKvv07ZDEVseDHTFDE7pW/FdzJ5eqr4wN788k4M1gCu8iwoxu+V3WeUXqw/pfqzam
 H7Frw/llDpM0uEJ/JzobqQ/PUBb7I26LpLYnsiaByqMN1/4f8fo186SKSHBX28MVKRLc
 uk3kQrX3jb6Q778MR3bt0o67W66bG8JHpmVHYqxWvvUATGIQHS7T+i38JhZuO5iq2Ig/
 FE0Cq4U3m14saLakzsD6/qjrzPp658mr8LG0Zfz/GpX95OzSDtFNx9+4WzMCUuIkUjiw
 jnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731546; x=1771336346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kq2OeTrUcPIegeZ5VRCi1cFtIhc0er3FyZyNyjg0Krw=;
 b=YovnQ2tcSJoPR1dweijtd3trG1HA2y4k2XF4Pqb69pV33VtEnem18X9+2Rgb+DretC
 rP9tCfnS7I+aJCnL1H5TAg3va08Znn30dH3/UjckI1k8FThIq4W9Sh5/BnfXtsWuHNub
 gOQ/ZaFEmASLjasP3LlkjDcOFd9tzQRU+lrpFI9D6Q9So829RsBuc3tmhy4tua2GARoJ
 fjlUL/4VlM+QDQV1JMtBvs9j91ZKoA4GqkLg+HIYMTHB3cuZ4CXVTILQ90FImlYM9a5d
 tA51fPlqVJO9RXSSm9QEB0dXGmaLC7uLkdvcjBFa4In3NCx/hF2lo2Ak3y9iqy4X9ePN
 rYzw==
X-Gm-Message-State: AOJu0YyhDFxY1UFi9D5a91jMtTxOUU2VLWrbu+vkiXMtuPqkisfm9feq
 QwABIBxFonhU1sVBg09/7s2hlTMtFj9cMKSIXAZAvHeCoruSLDhLFtTwhRg8CIFO0LPYcy8IjgY
 /i+KL
X-Gm-Gg: AZuq6aJ6H8HOAns38dxQn3KfY2PR4RJVAR16W6inI/4RFVc2whsvt/imijLIHWGgWLw
 I3hAc5YW/7AnBEcvMAOq3TuhcTkAQlzw4UINWoS8w3w5R20CCpnYYslgFZCWP/p/2M+yXxLGpUV
 Z3hYdGPCF2cMCBykU72UxiW0QrYIbad0ToHU/KHVIQgJQqsiBkJ2YsadXK0DMokEMBIdatQi1CZ
 J+Ze136Rtry0OmYfGKy3xj6up0h0f0XBsTlQr7NxFU0uCDZX6ET43kqpSrqaHwRvpM0mM+Udc8G
 DsS6z9ZO4P33W/HkvwFPei3Br8yj7WPo3FSQRNc+KD+Vd78+lmZsG8TCvrGh+ecxQ7KqPoJHWOO
 ZN9hRB9c93UiwulompYIVUDurdkdW3dhMNmSjxZZRlx5mMVhv9Ik7l4ayFGOh3aFDYtj+zmouVC
 10QVhzuxNXqsoIPrqHXNvOUkfKaNC2yjI4wx17zz/qbrq8afzHUdAiKnpitste2OQaiVCkP5QCH
 lHQTrxrgtrMg0s8vFsuYfgXh3frXdaAS2NhpmKBLg==
X-Received: by 2002:a05:600c:34c5:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-48320212e11mr263320435e9.17.1770731546402; 
 Tue, 10 Feb 2026 05:52:26 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] whpx: enable arm64 builds
Date: Tue, 10 Feb 2026 13:52:01 +0000
Message-ID: <20260210135206.229528-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e9018..e8fd77aac0 100644
--- a/meson.build
+++ b/meson.build
@@ -301,7 +301,8 @@ accelerator_targets += { 'CONFIG_XEN': xen_targets }
 
 if cpu == 'aarch64'
   accelerator_targets += {
-    'CONFIG_HVF': ['aarch64-softmmu']
+    'CONFIG_HVF': ['aarch64-softmmu'],
+    'CONFIG_WHPX': ['aarch64-softmmu']
   }
 elif cpu == 'x86_64'
   accelerator_targets += {
@@ -858,13 +859,18 @@ if get_option('mshv').allowed() and host_os == 'linux'
 endif
 
 if get_option('whpx').allowed() and host_os == 'windows'
-  if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
-    error('WHPX requires 64-bit host')
-  elif cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
-       cc.has_header('winhvemulation.h', required: get_option('whpx'))
-    accelerators += 'CONFIG_WHPX'
+  if cpu == 'i386'
+    if get_option('whpx').enabled()
+     error('WHPX requires 64-bit host')
+    endif
+   # Leave CONFIG_WHPX disabled
+  else
+    if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
+      cc.has_header('winhvemulation.h', required: get_option('whpx'))
+      accelerators += 'CONFIG_WHPX'
+    endif
   endif
-endif
+ endif
 
 hvf = not_found
 if get_option('hvf').allowed()
-- 
2.43.0



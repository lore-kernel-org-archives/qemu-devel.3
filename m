Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9EFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLU4-0005tu-Ta; Mon, 27 Apr 2026 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNj-00083i-10
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNc-0005eq-Aq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so68790265e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294083; x=1777898883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s17XNezLLDtLMz2CzUIKtH2WupPxDansNFDSHl7wZIs=;
 b=OLFNPSd0HyuokfIUE7w+8PkXoFIsdlf9i6dm3bfwRQrcKNkTZhyuTEVT/cCAxEbJFk
 qKXQGq2ZvYW8qgiIF0/UOLdL84VoSZP9V9sbmFAlAM9VytoatPSizR85wywVMJdMZMJP
 NpmS4JL1CPr3J9FWh9a1gjyr69uQAlbNqYkMuxYCS0aHF06xiiY+6OLMDto/SqpXcvwJ
 a48OscdEnzUEv5TJJwuBHCpUESTgK9X2RXBrLx77k5JGi9067b+aaaEvMnRw/Fh4ZV1J
 0Vs/kNDuoBfF6qw28pB4lxbmTGYSFM23VmuKo9Jpwy8HcF/P/UNzlnSfHmAFZnjXfO5D
 Jbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294083; x=1777898883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s17XNezLLDtLMz2CzUIKtH2WupPxDansNFDSHl7wZIs=;
 b=OuMh2YuJI4s2ubVDl4Yb4W0pwN7p41YmiS2n6d8FXuUPDyUyvUeU8cOZdQZKNYtq5/
 ViQe+lR2KphW3H+3Wl42BHBBEsgULAxX8JinvE+r7ZcMXXe9DwcZqZJuSqV31Rk0XdIY
 KLUTAHErdXKhgZifF/zhLcAM7YUibYbeeLRZYV6CwEEU8oQ8kI4gOK04270+vg8aGir0
 rlmpaOiJQ/TVLQM9rQqNwlgyje20HGC4OW8az/qecNhV06VyVG39e+8XqIMgPsP9KM/t
 v41lPRRZ+w5hpMFWpNyFHMn1NEMEbQfebawJL7QqVUA08LRDLSVXjXaJ3d28ZUmSb7x1
 sviA==
X-Gm-Message-State: AOJu0YyVB/lqfL22ee9EHhcZ7dbTRIxNUL3MAAPiVajeXifx1Wdsr3uN
 PD0cnySiDmi1wvW6MPUWG85TsRVJlZ2RhRDYB3/XHNRDJPhcAeKp71cBXe0nQuu9u6eVGlHP9bJ
 dY8uK
X-Gm-Gg: AeBDietatHtltkhke8oIMEVt1MNyDrTyB2QBrnw6AogzKL5pOQYrHNRVwY/M8MOBQjI
 B8NzKXE2zPoW4XAutZbVBYiqW5XYG/KM+xHibeMTnWHePzwVfurRpR1OkYHFrkh3bMXXQhrefIS
 C9XzPMJ72ET3kHYAj09d8O4BXxcpwoqwebDUWChJtaTaDei6DehZ2C9Ja8CGYplYDkqpksv32Wz
 FQRxQodPY37Mb1VkmneyBvJR/3IF9fEp3QMqZ9fvbz3EGzXuvSiywDIaXHKgOVVPwINUYx9ni2M
 NckScZNv4FJNdVRIMHolPr9W8SYSbGzGnDarfmDOeOGXHQxnhJA6xZn2XhZIum60wrd4ZdgYFV3
 yq36t1EDvBwbw4k44BKwlc0fPTDHkBKF4RUATLQ4uoYcUGGuEHrgTB2/+2WEjEOAMaIYPFjOdRr
 4Hj51kJx+FInfD9C62N5+7t8lhv9OyQp0U4NQExUxpZ7NdtuggeRIF6qHBtokIC965YAux9boBB
 b7p6ot+Nx//5u9IQ5mN0YudnNeuKilmRxzpuH1RMQ==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id
 5b1f17b1804b1-488fb7786e4mr484671895e9.19.1777294082686; 
 Mon, 27 Apr 2026 05:48:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/63] target/arm: Compile m_helper.c once
Date: Mon, 27 Apr 2026 13:46:59 +0100
Message-ID: <20260427124738.966578-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c  | 2 +-
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 1bec8e9aea..f2059ed8b0 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "semihosting/common-semi.h"
 #endif
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 95e9da151e..02774409e5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'm_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -70,6 +69,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'gengvec.c',
+  'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
@@ -94,6 +94,7 @@ arm_user_ss.add(
   'debug.c',
   'gengvec.c',
   'hflags.c',
+  'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.43.0



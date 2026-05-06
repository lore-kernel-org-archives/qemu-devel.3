Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F47CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcmF-0001Fk-4p; Wed, 06 May 2026 09:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcm7-00016d-2U
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcm5-00007C-F3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so99807555e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075931; x=1778680731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rg9sH0NGDIiEEpW0hzEJcpCTEAxsUkbnu7qniyS3cVY=;
 b=VkaPTGxdsaQSmqeYvi+84oBe1a/LQqHkgAhSRiui31GSLA4VrOAaT/s7kcY6lU0Qd2
 7zz+tQu39oW1rjmiFneelxAjeEjpLXOdrIQjaQc9RtdyIJrTc0m9F+kdxM/lCb49lvGE
 mpOk/Dcn56ZXwvdRiFO3NNusJgJjRrw136vRHcKSEBDXhLfVK4eixq9s+NXRXAQ6ftHZ
 9rp4mMQE5iUz2u5MNqPzoWma6AjOLqh+1OeH7smPvzRliKAiQQtVw8loCDvOxticTYpU
 Ug2x7JvfxBFMgKjYP2CvYK35IpbX/GzTuwUBv2WIRKlg1v6GZYpIuS6oFDNYm6YS6Qam
 oKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075931; x=1778680731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rg9sH0NGDIiEEpW0hzEJcpCTEAxsUkbnu7qniyS3cVY=;
 b=O1edgmG1Lyq0HOXFVTKVdXu2nAtI1PaaGvkyTLQ5J/KQLQwTyKihdV2OEXJxJR98wc
 IGnJ2ffmkwH/oGYOka//bHJ/oBz5CW0ePZr7OmEqu7TvcxvyympXUUmxvLwNNWOoZaJQ
 CPjG8qwhmtXCy3qj6S3XVicUy6o8kSZ77+wVrIavGzl4IRKoZKnUATNpRAhXdPi2nibq
 kiWSmmhaiXixgL0S47vwpqEpvK5nXdvw5Ez1GV9oTkQFn0Wi/kp0jUTRXz1qAUR1IkFl
 LxS6C5MacDScik2Ex1qG9ENgHHzx+mgE7w07jSPV/X5P/U0+2KKqvDLy9vPAzQHQv/l8
 Wc/g==
X-Gm-Message-State: AOJu0Yz4yVcxCayosZMV6XO5T8Z3O77FBCerrlDcbT+VPtqcCXnAHm0w
 yu1Y04gVXUioABWB2ew3wB6CcV8Ic+2hOkX1hldSxDYQ2oza48jOfzMkLod+uipgOw5b1WpZgOr
 LTfiZ8Oo=
X-Gm-Gg: AeBDietFTX+d5dteg+gZhhZAnqgtqHpmsJja+QiPa43EmD3RCyY/9OYCTgLIWCp1NcT
 Gwx7lf0DTIq8+QayXyvhvE2zueMLAmtze+Rb+Q0HUBOerVn6QzXGAXvNlE1TCH3cQrnfcVVDXm3
 8AKrpcM3HZjm9HvM7+y1ZiMM/lvG1BBaQ+KYA0XIY8d4qUCgBPUUaTH4DNsl2FUod3tUypXXsqY
 FzWDfmfZrG1QrpIhHVYjxPY47NxSnTptyPCvIHOlzM2eAbqHG9QcguXBD2qWSXSbj7kPXx0MzVR
 EYGJuidJPNUM8HlkWe2DuwuSW6YerTmK3m5ZBGQbmDOISI/Bza8TTjP4GyejI96IRasuSpCjIS+
 SD1TDabSNYXy5Q2O4XchxJV4M/99OAQgbaGcHvZMAW3JIuPXsyom+Uq6DsMUGYokxIbtFcFD8sZ
 UWYsypLYTPAFOsGedJAqMXeNCBE02+uX6LeNbSfLo5wG78e/SWrmDO+OeK6TOLu0ScggH/eHoJH
 Q9qCfHKFCQgcjC5vjAIag==
X-Received: by 2002:a05:600c:4ba6:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48e51f4bab4mr34413535e9.25.1778075930483; 
 Wed, 06 May 2026 06:58:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530a68aesm26570585e9.1.2026.05.06.06.58.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 027/110] target/loongarch: Avoid target-specific migration
 headers in machine.c
Date: Wed,  6 May 2026 15:53:59 +0200
Message-ID: <20260506135524.20617-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header required:
"migration/qemu-file-types.h" which is not target-specific.
This allows to build this file as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260325211728.89204-3-philmd@linaro.org>
---
 target/loongarch/machine.c   | 2 +-
 target/loongarch/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 28b9079d04e..4db53fec267 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/vmstate.h"
 #include "system/tcg.h"
 #include "vec.h"
 
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 2ae96d68695..c5a2953b29c 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -10,6 +10,7 @@ loongarch_user_ss.add(files('gdbstub.c'))
 
 loongarch_common_system_ss = ss.source_set()
 loongarch_common_system_ss.add(files('gdbstub.c'))
+loongarch_common_system_ss.add(files('machine.c'))
 
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
@@ -17,7 +18,6 @@ loongarch_system_ss.add(files(
   'cpu_helper.c',
   'csr.c',
   'loongarch-qmp-cmds.c',
-  'machine.c',
 ))
 
 common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A9C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHK-0002Of-Ga; Fri, 26 Jan 2024 09:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0002Kz-8x
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHG-0007xM-5s
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:56 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so7000195e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279632; x=1706884432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LouzfqvK2IHKPiiDEvjrZzysBnMRC0GfKDnWQD9WZEU=;
 b=MBs5J5Xt/Qy+tNUZG8p9FDnzJppyFPN5AHlNS28yEvJjVCZV7BH5o6PLPoTtbBksIS
 qdR9ZuSWYviHM4q8+P3xvxlCpK8P4FsraNGY7QZMy2WbDyMRMC4A1mz7UAQgNB7V74NV
 eLT5WTnUFhm794IXiCXYZk00+7hRLiISu8mLjHV/sTRIvNkHDp+5a0EBGZVTYtmKrl33
 1uR/BoF/kMe+z5wkBp2GNBQZpkWnr9BZtOilEtxUjyB96XK+ZXf0VJ2kGq0pRA+EgLwQ
 zS1lve/t+YPNidfJ0JyF38aUGQURlfY8Ots3qEi4yIaVNtsZWWy9n3/988e4v5nCtAXX
 +lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279632; x=1706884432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LouzfqvK2IHKPiiDEvjrZzysBnMRC0GfKDnWQD9WZEU=;
 b=Iy/Yv5A9/mc25eruVCBkM9VDoOtGW1blVMWmNZB6q0VOQ9JZ6Oy6nwBeT7trZjxJWe
 D5iOv4UGjeMxJ1cfbS0Hke8joEcc/efeNYza7N2hLJCC9Tg3HtLOSQt21OWKrmKY7Scj
 J4m7S/cnp4yusR3eFqRm+jLF7LTu8wxdjslaN1qjoNu4lBOHphpXvBW5HReE2P58nh5Q
 +FJMqSBVuOMmQxfDXj8twUG5B6BcNv21jth/kACX8b+ApThCIoE/7cZ6VN4FT5qrvAeg
 KJ2nqGOJtFE13FPHxT4HftCKfhkdFmQVY2PDODs2fk7EqLWV++VbBPdyGK0A+Np8wN6C
 78Sw==
X-Gm-Message-State: AOJu0YzHjqKxT/lZgQmlTekCJtYlAuDFXRZECeojTHhbwDMW2KE0ACGe
 rkZARuWuR1pCaV3limA3aqm0Q9YWTS7obDl1oSEH81fXXQJsyesi45XwR48CgHAiK6QPz6iy54b
 M
X-Google-Smtp-Source: AGHT+IEafsKxr2vb8cyaFangAYRpmu2zOUni7W8du/1ULX+hA4klsujtUyFenx+u3TJokHdsaC/ybw==
X-Received: by 2002:a7b:c3d1:0:b0:40e:47db:9a3b with SMTP id
 t17-20020a7bc3d1000000b0040e47db9a3bmr1023333wmj.75.1706279632501; 
 Fri, 26 Jan 2024 06:33:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/36] hw/misc/xlnx-versal-crl: Build it only once
Date: Fri, 26 Jan 2024 14:33:28 +0000
Message-Id: <20240126143341.2101237-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hw/misc/xlnx-versal-crl.c doesn't require "cpu.h"
anymore.  By removing it, the unit become target
agnostic: we can build it once. Update meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-15-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-crl.c | 1 -
 hw/misc/meson.build       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 1a596f1cf57..1f1762ef163 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -18,7 +18,6 @@
 #include "hw/register.h"
 #include "hw/resettable.h"
 
-#include "target/arm/cpu.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2ca2ce4b62e..e4ef1da5a53 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -96,8 +96,8 @@ system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-crf.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-apu-ctrl.c'))
-specific_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-crl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
+  'xlnx-versal-crl.c',
   'xlnx-versal-xramc.c',
   'xlnx-versal-pmc-iou-slcr.c',
   'xlnx-versal-cfu.c',
-- 
2.34.1



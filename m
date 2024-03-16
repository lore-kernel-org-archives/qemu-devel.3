Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4AC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIs-0002lu-MJ; Fri, 15 Mar 2024 21:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIo-0002km-2s
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:38 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIh-0000hl-KD
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:34 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3669ab1bd67so4254515ab.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554249; x=1711159049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W87lWQOU4ax1d83X8hX13Y9WQtWIQCcPTltB0qvJM70=;
 b=AIQo43I3t2V1LJ17A2hRa72kF+jhXnvvp7xatxpgh7PyuB9Vc2yq2iep0DDU0zmZB4
 koazckSCakmRYS6HtrfSK+YsUJu4qQwm5ZiwdXzFXi0mpCHHmzLIbt0mBTFXSAuWX8Q4
 3c/Lop9n2AGdeaVczyAnkO2EJsjDI6Jebs6WTN9fhFwMmYlgbRU+puDExp3fWwdTVFoI
 YbznQ4Mbw2bfyAgsHRogYq1wJhD2cw6npphVcET1ino7K7e6Um3O20VEZdWoBF0VBryy
 pQXOKEcnEfhupZfPVxUa1XnzdGDr0w6Ss63b7dofXOiYx6+8u2uN5VXnoWMlLDE2d9F/
 o+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554249; x=1711159049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W87lWQOU4ax1d83X8hX13Y9WQtWIQCcPTltB0qvJM70=;
 b=tR4KUy3TFbdiQWA4O2+ZMAU4q4bW8p8EHGrjuEGBWOsP2VV+v2zAKSXvHTxpOXwwqT
 4YlMp0xi8CAaqvAJ0HWdWvLdV2n2f157zFt501sHuH2QfKuoqJMic4DIRiN1UlXARq9u
 rp/6Jpw1j7MkNcQMs88Dv1bMyk8jHZtIdozXXc1i6PmTSEBqFQhoLI39S6NzH7yZvpa1
 iGew9dfqp+NFkesTibMY12BRgdtI3TV8vbSLlkmFAiP8ovtg5khBD1lfmisrhity83U2
 YvjHrQLCZ9tzGLLfxZhz3c2QnkNePxtgCovHkwS6v+mquoOSEVD3a/gIQebByWLbF2Iw
 QrUw==
X-Gm-Message-State: AOJu0Yzn+GYHSX9g5JG0aqCz6yAqWHp9y3o64oBE5h8JNyq3R3/FV3z6
 5VNEEt0XGSZPXGF4dq8fa7Vcsx8kBK054JMVw7m2o4hJaKwC76ghZku9X4V4XjyRe+dufcdQP7O
 j
X-Google-Smtp-Source: AGHT+IGQ+zl4g+pwjueYhA3Kt3+ytJ8OW40zUB38LW+lU425Oz8io9vVOk/br2NI8KhGPu7seE5uLg==
X-Received: by 2002:a92:d952:0:b0:365:d2be:3de6 with SMTP id
 l18-20020a92d952000000b00365d2be3de6mr5038549ilq.2.1710554249490; 
 Fri, 15 Mar 2024 18:57:29 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 02/22] tcg: Make tcg/helper-info.h self-contained
Date: Fri, 15 Mar 2024 15:57:00 -1000
Message-Id: <20240316015720.3661236-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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

Move MAX_CALL_IARGS from tcg.h and include for
the define of TCG_TARGET_REG_BITS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/helper-info.h | 3 +++
 include/tcg/tcg.h         | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tcg/helper-info.h b/include/tcg/helper-info.h
index 7c27d6164a..909fe73afa 100644
--- a/include/tcg/helper-info.h
+++ b/include/tcg/helper-info.h
@@ -12,6 +12,9 @@
 #ifdef CONFIG_TCG_INTERPRETER
 #include <ffi.h>
 #endif
+#include "tcg-target-reg-bits.h"
+
+#define MAX_CALL_IARGS  7
 
 /*
  * Describe the calling convention of a given argument type.
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e9d05f40b0..a6e7df146a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -39,8 +39,6 @@
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
 
-#define MAX_CALL_IARGS  7
-
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
-- 
2.34.1



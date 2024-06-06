Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5EFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAOE-0000VF-3q; Thu, 06 Jun 2024 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAOB-0000UO-UY
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:30:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAO8-00013n-SS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:30:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4215ac379fdso8194145e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717669830; x=1718274630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BWK/EfN701oM3pgWDTSDo41JLi2OHCRROtt96Imm5fI=;
 b=K3HSb3SAqUjD85L/oKw/1J69T+Bsq4XZ9/p07H9ZMvmcAfd8ycHLZn+iy/yO7syuKp
 3oC+VO+FDT3UUWUG4GDkMpdNkdaxqf9TI/RQetL8Vun/gXQ4i6qD/hNp92VcmEGUcS2c
 HESoe4ZmG0ESMR2ju/Tq18sUgxWUAAFQ+iMpR8a/D5JDMtlnEq57cFD/3i78LW1QKuZz
 Y140Um7s8ZbMIQlj5Z/XmMaEawFnmi8ePVyJkEkaR+/i8GtkbfmpiBwBs2MzLIMmT97Y
 G/aBf+Q4frb3Psd8cqPZHLz6kG/h6JKCy1JroEPpGxl5HW7sANfsf7UARhoH0cRZTyna
 zPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717669830; x=1718274630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWK/EfN701oM3pgWDTSDo41JLi2OHCRROtt96Imm5fI=;
 b=B08EycMm0GYsc8pPMeI4qycbw5cqIVUFKhpkOgWfcQOeFSzug77nsdUXoMf5sG8wjq
 eTnBcntxotN2ECay5/MKSF8yfh+pzKCfLfbuVzoiYgq/Xs937waKpuaO5zSV/TynGmOO
 MlMprERTmF7SHUW1hsQavQA0bFDZfIp5vDcbd5g/iPXlEiNUk7BloYHY9H9cWHwM4b8Y
 9nczwxOO6RCAXgpKEP4l9AhYGFa3+SEb8cy6NgY2elfjip6ZtRpdS4nDc7qaB++FOibs
 RXPDthoeIWdyoj40eaJJLgcceWuKOmaB/qPFiJXhrurX5RwlrLLlol9aGneWIZXWPdE7
 YoOQ==
X-Gm-Message-State: AOJu0YznF+bxYPu0lYQPX/7gZJnx3+to295i993KPXqNaE0AxpXVlWEF
 2dFfSHEMNibYlqQWeHVv/JTQt88fPep/hJ4Zntexib5x3exI2aXp2vwZRNL4yY/zUJUVHsytVWv
 Fc9M=
X-Google-Smtp-Source: AGHT+IEiF5CiznKx7HVB10fGs7eQdj43ODfPNE4e8852kH+npZRnaTis4fKOZb3FmijnBOEi8kgUnA==
X-Received: by 2002:a7b:c4d0:0:b0:41f:e959:9053 with SMTP id
 5b1f17b1804b1-4215634ddc4mr37601455e9.38.1717669829738; 
 Thu, 06 Jun 2024 03:30:29 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm16963035e9.25.2024.06.06.03.30.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x: Fix tracing header path in TCG mem_helper.c
Date: Thu,  6 Jun 2024 12:30:26 +0200
Message-ID: <20240606103026.78448-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit c9274b6bf0 ("target/s390x: start moving TCG-only code
to tcg/") moved mem_helper.c, but the trace-events file is
still in the parent directory, so is the generated trace.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally we should only use trace events from current directory.
---
 target/s390x/tcg/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6a308c5553..1fb6cbb6cf 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -30,7 +30,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
-#include "trace.h"
+#include "../trace.h"
 
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/storage-keys.h"
-- 
2.41.0



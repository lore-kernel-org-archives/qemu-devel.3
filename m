Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1B9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNcK-0005em-T7; Fri, 24 Oct 2025 15:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNcJ-0005dk-4K
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:38:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNcH-0002Z0-BL
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:38:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso25021795e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334703; x=1761939503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06EZMC4tBC7cPd7PMFGh3c+i0do87VDtuboi/W62pEQ=;
 b=S382Zg6Z5oZGkpF4VHWNMPsVeraUoaY3aNoUJp4cGGmiwi+VwHAW6EajlkRggB6vg2
 hBddnX5V/1e6rc2/G2iT9/9hKfmr4smO84vsOl4WJDOtYSNeNiwIqm8IXdwnxQObHi8W
 0g9Fv47P3IYH0Hm9xE00XbwpLQZ8lQ7LXTdFgBVCN0mwWYKZMDNRrc9K67V1QYhyuOQS
 eTlOB0yf+orT7CcNaY1gGUPPtt4FEOuVbIOGX/1VEhvTB4rSw//0pPJ7OsA5TS5//O5P
 C1bTodCny0JSOVnf76tdNUXZ7QPQufD1+hgREmy/k+EUAX042K3a7KWYiDJRNricTwJb
 bzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334703; x=1761939503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06EZMC4tBC7cPd7PMFGh3c+i0do87VDtuboi/W62pEQ=;
 b=Dk7Nb87ISWyiTO0oEcMyjLZSxkWJvKrt7Uf8icrg5UYqwU1DCEe+Qo4cxLFs3aL+rw
 iUoNNL5GEyskPtZEbIyqdkxVcGAvLj7EYQ9FRG52pBQYRieHIhjYso0qpCVoLOg6Ip66
 UDq3WpsCk/QB4xu2CUNGIu++re1drBxS5TNfL/KcXdgsO2A3VPfRyGebdNXsr9NjXgeT
 Qup6i5W+riXqRI3AuMQcAVP5XK/iQIXeI30wIzzGUZ+3awKfSE6agnqsNSeHmwNOmjCX
 Oa3VgBviXpHQeMTzm/729Ie/ZX1YRWw9yGdhwyfobMyHFXctMyfrNR6KqesCVzrXZLvu
 YrBQ==
X-Gm-Message-State: AOJu0YxK5upCjFk29PYn+BqNCmBrgkCVX3kAXzlVp1c6yL9yENEobeBK
 7ookS7g+jpfNlMrl+WGpftG/wgQjI2nZD39X0RpOP8IOFYJbV9HkEwqZFYci/FPOI+4R4RBOmg7
 /9DR4Nms=
X-Gm-Gg: ASbGncuZIKKPK3luEIGrDvPapHZaFDjGQQxiQ/+Fk+QwGuEbLOQSX5VoJV0AFFkw0lR
 LrHDNWqgMxzJDYvrd5UOCvkipcK+qLj9iSxkqmAS1p2qNjq/hqiNOZumN09qRzECqiKYcn6UH1W
 m8m1JR6tEqxf2nePepTK0+U4hyBEhfea3CwG1OuvSHXEYy2yPJVKc94sCY3UEzQiVVsjSEitD3/
 r8ZV0yaz8av+LdCKN4Or6mIm8PF0zlZZka9gi4h3ZO6R++t0Q/5SXv8Gst+BEYPz4gPIEdjD2fr
 B0LYt7E45Aa269Lq/AKhWUHVBO9js9mH6/LZt3ujrCl91c9F2I6VyXQnEFrFqO5fpYQkUfNb1NO
 UKm49CsWpBTEmZQ2OY1DLziKKGSD268cHVaEIae+gwyQReN0pjZyDQJpkk0wZ4VwbLP4WupxSRj
 wawwH/z2hY+n3RLCcByQxJER/6gse/p6n0kETfOBx+rd1vTJcaoe0EuPOF3yIe
X-Google-Smtp-Source: AGHT+IHnrPLiRhL2oVl9b+Hfwoc72motDn5PtrgzGLhtUUifl/weU/eTWhEL2TRc1lzgyH1I/3ugzg==
X-Received: by 2002:a05:600c:1ca0:b0:471:168f:717a with SMTP id
 5b1f17b1804b1-475d2e84559mr32749575e9.16.1761334702984; 
 Fri, 24 Oct 2025 12:38:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15416sm106478365e9.10.2025.10.24.12.38.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:38:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 22/27] hw/rtc/sun: Include 'exec/cpu-common.h' and
 'system/memory.h' headers
Date: Fri, 24 Oct 2025 21:04:09 +0200
Message-ID: <20251024190416.8803-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

"exec/cpu-common.h" and "system/memory.h" headers are indirectly
pulled by "hw/sysbus.h". Include them explicitly to avoid when
refactoring the latter:

  hw/rtc/sun4v-rtc.c:28:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     28 |     MemoryRegion iomem;
        |                  ^
  hw/rtc/sun4v-rtc.c:52:19: error: use of undeclared identifier 'DEVICE_NATIVE_ENDIAN'
     52 |     .endianness = DEVICE_NATIVE_ENDIAN,
        |                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/sun4v-rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index 29e24ef6bed..c0859b270d3 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -17,6 +17,8 @@
 #include "hw/rtc/sun4v-rtc.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "exec/cpu-common.h"
+#include "system/memory.h"
 
 
 #define TYPE_SUN4V_RTC "sun4v_rtc"
-- 
2.51.0



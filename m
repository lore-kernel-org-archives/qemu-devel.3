Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CD6C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVf-0004Yp-G8; Thu, 06 Mar 2025 10:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDU7-0003JS-PI
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:09 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDU4-0006RW-2T
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so5730195e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276202; x=1741881002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yLBo67sH6HjRZEuxvMy622hl56JAycvhfKaomqodUXg=;
 b=epkeGtII6ZbkOqj9L/67LmY5C9LDM7H5wfy8KPAo+6eP0nrndb8dj+9O9/ZRmKOEjL
 sjrQeikLYTtWuJkEb7EQ6g+uFPQMemU7gIbqn7DR/0O+6qiEbh0UxPIydjrkuIO47o/e
 YwGDBBvYI6qLnagQXHA0braoACOFra3Y2hMyHimROmvNuffLzpgKcIjSeKQ0kgz9KpUg
 Y/g4nd9aPrwHHNgxOYJeg1t2A7vh+y0v3V1cT1ViqkodeahwoxltOjUbycHc8iagDP2h
 D4vGZFDzot2M0CIt3RVEhORcMwTpOyqcUWX1wQZyojMzT8VFgjxtkuyNXtIUzgLdLwPj
 QVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276202; x=1741881002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLBo67sH6HjRZEuxvMy622hl56JAycvhfKaomqodUXg=;
 b=bEgQtRM9VLEBYHw45/0g1tQHXgRbZ447//v+yEfznOHFLcTGy3oChlQZETqHq1mkA8
 +mUZroSnPAwbFPCUyj1bRswjLY4zt0rgmVSQOJYW6u7D10OjxMpC1rRjUYx09555luc6
 xs240fe4ILChpFDqhVXYSoMa3T+z2Q6oMx+hYkeHyY4PuGznjR1WSdZX7KpSpdxKBlCo
 G6QZBegMWwiffVP5kTvAjA1Ghu63ihp0TqeEVoT25Klg1ABlzLyTTUG2JzbZROlu42r9
 1da9wZww4rEZ5rpJRUHrhvzEteNdGgH9bDDOMx4E0ZPPAr64EH5eYZEfb9ut+cTG8bU+
 RwKg==
X-Gm-Message-State: AOJu0YykAWqloeqO6q5gsqJLKi4LnUyNuDuwXlgia19YSJoSB85ymrgL
 91BoVuMpMjhX31KBCWbQ9/Y5IPIG+tTWmy+VECz3pz+u0O4r6gPI/3MOisZzhqSLaG2/kEX9RCN
 pVGY=
X-Gm-Gg: ASbGnctslv9EvEDLXvofZLBJa1syrjot0+LgR8fmc1Vkaw3f6xM4ldY229S66lozG5w
 ++MFosVwzBJ3bww/h+HMWNbSN1nlrWfCV9d6w3q9eTfeRHzD30sGkdl8unqs+Ks68V33YGFaoSl
 /C79xHHm0ve+XyGYPjiLnKEvgwQTTL2Owlu7drapmA1P+iesWD7hghisMhYkUVbrJRrP0j4dHRi
 aUvLo2MjCqhr/4XiGowxSgaiM28H//XEkipJiFqy/nmVPCXehJn/Ioe7HQaxx+3kzFPFJkkZwgw
 aIgK05ehC0DSw3NzShz63UDiEXkgnh9DB+PhoUg9cbA1KwX0ZofplCwPRq7atLx779l34uIxTrF
 6zqH8T3pp1rV8Xxm46nI=
X-Google-Smtp-Source: AGHT+IENSHPDy2P/nUJjd7zVgl6eCnXsq7IXgk9VJjJrMXpMzEzH+vyaJvdTY9B8dL5xjDwNvVJsNA==
X-Received: by 2002:a05:600c:4997:b0:43b:c824:97fa with SMTP id
 5b1f17b1804b1-43bdb3e12f3mr31583295e9.14.1741276201775; 
 Thu, 06 Mar 2025 07:50:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm22808915e9.37.2025.03.06.07.50.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/54] target/hexagon: Ensure not being build on system
 emulation
Date: Thu,  6 Mar 2025 16:47:14 +0100
Message-ID: <20250306154737.70886-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Currently only user emulation is supported.
Assert no target code is built for system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-Id: <20250121142341.17001-2-philmd@linaro.org>
---
 target/hexagon/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 79e60d4bfa1..f78c8f9c2a0 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -26,6 +26,10 @@
 #include "mmvec/mmvec.h"
 #include "hw/registerfields.h"
 
+#ifndef CONFIG_USER_ONLY
+#error "Hexagon does not support system emulation"
+#endif
+
 #define NUM_PREGS 4
 #define TOTAL_PER_THREAD_REGS 64
 
-- 
2.47.1



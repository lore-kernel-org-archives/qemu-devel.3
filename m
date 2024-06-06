Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B63C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXN-0003nx-MZ; Thu, 06 Jun 2024 06:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXL-0003nZ-AG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAXJ-0002ki-IM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:40:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421396e3918so11203865e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670400; x=1718275200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISkAlLR4031fIqCyDiG+LpKIpeuhJmmGNI75va6Ggz8=;
 b=YPn/FPq4ckGw0yylg7+V4jeVkymVZkNoMI2IPhjOio7gntBuTAeEGMI8PwKXg4IE/B
 lf/8XaRcckyDfLr6pGg53V9LOmThnd8G3chtmIGCvBu/r1sp6IktgPr3WMVrxq2gx/Vu
 lUcrBjtPj6aWhSUnnKNOuR74541gEfMa3QMm3ST5AjcbFEgCCqSVl88K7/mi/1qxYdNM
 NxG/HRTfruEZLfUaSFQQsC/G+yxdDpS217VM6l4HV/eacZ71BvukBi2mi0Q1Ci5mYmiP
 5YyG4OIxwSv/lR30tjJWOi9GESnICub9CBNsbbXZf40QhstQA6GEMRLvnZdB4bsvwJcV
 Mzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670400; x=1718275200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISkAlLR4031fIqCyDiG+LpKIpeuhJmmGNI75va6Ggz8=;
 b=k75Wp7hM1chQMCKAIaDP6Tnkj8+Nqw4rNSx28DZQ7JO07HIZAyYAdIwD04DOLo169j
 7p6qUSDxXVpnhPWUt2AcUKIvwes5uS8FREAwS6Sl9JAzw1br1u61jUsoHKh59SxGqyRm
 RqC0WS8wDX/DK6bDZ4g+qk9Cax/o0Io9P3sGfLk8l7bJnxBnSPGVNeqcpFHTzS9ntFHX
 lI4EfKCJakQeNFILiTb4dtfz14OhHCZWM51Q5E7FQFHlqb1rMTmNkqZi1pD8Huhioz4Q
 av2CK12/WWRtobXDV3JRSbl1hfRRaKxkU8brfGtaKnWxPob6VbFJ9d7yvz/gvigemI6f
 SnvQ==
X-Gm-Message-State: AOJu0YymOFAGmYco5jZAcyQKGtYAJDCl8BQTk/t342Vv7Y9l3ULb8ErV
 AX2f5qQ9e2K6xyCnblnz8xh4QfHCPw4TnZIqeeNF0MT+vzBItAAOejOiNJYvqItpTJOoCT8ro/U
 kUQQ=
X-Google-Smtp-Source: AGHT+IHSncPzWPTaQlVeqWTuWYhJC1FK09IlbNlNeNTPJqYU4bBOZom8O5AnXBmLQfA2X1yPNwGjwg==
X-Received: by 2002:a05:600c:3585:b0:420:78f:3f9b with SMTP id
 5b1f17b1804b1-42156350373mr53612595e9.37.1717670399696; 
 Thu, 06 Jun 2024 03:39:59 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19e572sm17265395e9.10.2024.06.06.03.39.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:39:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/sh4: Remove newline character in trace events
Date: Thu,  6 Jun 2024 12:39:40 +0200
Message-ID: <20240606103943.79116-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240606103943.79116-1-philmd@linaro.org>
References: <20240606103943.79116-1-philmd@linaro.org>
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

Trace events aren't designed to be multi-lines. Remove
the newline character which doesn't bring much value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sh4/trace-events b/hw/sh4/trace-events
index 4b61cd56c8..6bfd7eebc4 100644
--- a/hw/sh4/trace-events
+++ b/hw/sh4/trace-events
@@ -1,3 +1,3 @@
 # sh7750.c
-sh7750_porta(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "porta changed from 0x%04x to 0x%04x\npdtra=0x%04x, pctra=0x%08x"
-sh7750_portb(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "portb changed from 0x%04x to 0x%04x\npdtrb=0x%04x, pctrb=0x%08x"
+sh7750_porta(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "porta changed from 0x%04x to 0x%04x (pdtra=0x%04x, pctra=0x%08x)"
+sh7750_portb(uint16_t prev, uint16_t cur, uint16_t pdtr, uint16_t pctr) "portb changed from 0x%04x to 0x%04x (pdtrb=0x%04x, pctrb=0x%08x)"
-- 
2.41.0



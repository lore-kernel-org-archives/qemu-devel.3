Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60FE7BDA2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIY5-0002t0-Qv; Sun, 22 Feb 2026 18:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIY2-0002Zp-PD
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:36 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIY1-00060K-7v
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so2737306f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801650; x=1772406450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+Shgl9Yri5QWTxJtLwdRaSrm/tFNfZ+WrU+G3AQqME=;
 b=HlbSDKyyN4+AXz8xtPRMuJJL0v3+m5+s6XXdPZqyZGarcC97s1RWQ7OTCql69LJ42x
 YcQfq7dUuZVmCxtAMk2D4pRUA/zkz0h98L6fBs0fnKKXxeb9xbQuxTdolaAYGlLYKcu8
 FmwULieb5F/sNLSutJaTXKDXW38i23CuQVrdGAX4B12XJmZio8aW3njuNb8p/Fz0h/iq
 UYUveLpdHNUMM2/UhF1xBwrD/dq6PWxWMcMnRhdU1SjOVq73BciRSHhK7yQ/rJkH73oi
 7Dpmd3/VUCrjPIu7g+TAxtY6+2P9A5eq+9sB781NBCiyWDv0gXlV5RXVJOpojw2v7g1f
 RIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801650; x=1772406450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G+Shgl9Yri5QWTxJtLwdRaSrm/tFNfZ+WrU+G3AQqME=;
 b=p+LJFXAVZbKBh7x9Gx907itWzvBONR1JgSd1QmkrMM72XbZzb77Lx3HZ6QUP9CJWMx
 45lJAhYwmfIW3Km4Ps5RYYFvhYRo6jP5m23RsM4QgksBVDk1EEZyNi5lY2B7REqJksQQ
 9cVv4SFlwd0qD40VZjeTahtHS2qq1Z+PiW0S94tKM5EEGB15OQTShGER+67+ddkOwkkL
 GD/7nq6pEHgrP24rENYOpfQDaFfSnYzWCvjlqN7J8mtunmD7I8XvzhhPMwgGSgn2O7ZI
 KPMNbMO8jN0KaAYILZCbGXK0MZ/Pj/bJj4XA4YPUTU/XAMVcX3H3QS11gHlR7pkO9TVX
 cbzg==
X-Gm-Message-State: AOJu0YxWxIFs0VjL5XJR84sY5LQDkIfP7BJczOep0UOj+2LteWYR3R/1
 s6NAXLCn0gbyIYw5Ei15+ucWHH0GC2Wf4HlB0/JSDrIsSaMeBTr0VFDDyPGdUReigHvY6mLY42f
 /wZz8BS4=
X-Gm-Gg: AZuq6aJ8+rgst4pzisOXaRyeqTpJpZJxZSqCm+ky/sMVOkla/2B4vS/VvarV8UpeURh
 NdD7tG8ZDCBZU2PMIDtHNnYmc6eRBQ5HTUk7Od1209llgjSkmGeI1zTQ2Z7ofFNgZWgZ7qbMm9Z
 SkX45P+ylHJI0dIQmxmbqxQYemsu77k6jxXp9KHbQ5B6+1bMTZrMA+GV8jEULkswi0IoA7zvhzD
 3qLK/WsjSXhr5Fcqz4kSxqCy+HolsI0wDQ2WBj1LDhPHhY0qGWddNJpO5T2UeOVw++2YCFiEfgz
 TWzhmcOFrTJQgb3XlovD6eGTQqrAJVRy9RdlaJcqvtG+r/VKbXCKTchEvHfMNVCra8v2s4zi9co
 n7SyGNkCuQB7ehaJdyAkRjZt2vMM0364QzK7WOaMX02eHGy9ks556KS9C2x+8eftXXdCmhBvYRj
 sCjzzBneuf1fPZI/M0MfIMRNeNrvJoMryFZ0d//uCorfipD790vfmzxLyMv+zeWHC2Z+ttVEZ+
X-Received: by 2002:a5d:4e10:0:b0:435:96a1:ee4d with SMTP id
 ffacd0b85a97d-4396ffc46a8mr9588352f8f.14.1771801650428; 
 Sun, 22 Feb 2026 15:07:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff27sm16316578f8f.22.2026.02.22.15.07.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] hw/alpha: remove unused includes
Date: Mon, 23 Feb 2026 00:05:54 +0100
Message-ID: <20260222230602.5756-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260219171810.602667-12-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/dp264.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 5e64528431e..98219f04569 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -16,8 +16,6 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/ide/pci.h"
 #include "hw/isa/superio.h"
-#include "net/net.h"
-#include "qemu/cutils.h"
 #include "qemu/datadir.h"
 
 static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
-- 
2.52.0



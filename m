Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EBED0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZof-0001Fd-I4; Wed, 07 Jan 2026 15:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZod-0001B1-Hb
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:35 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoc-0002Ep-3N
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:35 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso1248421f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816452; x=1768421252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yip93xTYKFMNeN4R2CWJ5hGgTVQz7JK2bQGE6QD+RRY=;
 b=rQdCSGdHaGObl0D1kHfc9wWCSFpXXCWpHJx6djqEGjvrbWW+nDd2taixjFMcP0UCH6
 ZF0MuwcBQqfVOOq91rfRGp9jUjb+TkBXKCTOHQrmdClw+8/vQaZ2oAVBHbKiFbhmGB3Y
 AlpYKS1Y3o+E+jkJ1z4+uSKLrquyrMXEn5tmZcJGY3c9uopTv5DjkGSIq9QN3xPQ80Mw
 HczXOWeSgkJBfnhNlHzpHq4nIgPjSCqFlOvkW3dY9E3A8QB73VxT5mUGDmL1aVDRvIKs
 /t7w6rkv3rk0/PswWLNswDRIdmw73FGfrZg+Zb5ZxktxG/34KEZ7WE0kWLKUw47c2yv9
 kKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816452; x=1768421252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yip93xTYKFMNeN4R2CWJ5hGgTVQz7JK2bQGE6QD+RRY=;
 b=MVdB3h4Ev42dddbVB+IbDe/rn60Yqp5ZeVdGWJmvM4m++A7u8ZUJr5MHZl2/E+ozig
 ON5RkN9s+7fdIide7PHJAN6Uj3LTquWmToX9P8KSjsWd7YBcSFx+PjxXvLZC0MPK9GXV
 kBzwUqN23HgeeZHDUPLlYgXN7TyEzV4oAnhX5OLGvk0/1xTNYwA52PZi/lIkCzkx0uCA
 +vWRAYbF5OTDdOkinmHCBhsai6LWfvOE8GvQWL9rvOm3gBsG97AbZCPuyjdIk6Mnj1RP
 YA+kNghYA8cwmccwokLIAwFEo0DUJ80ktFWhCaUoaAgnXt+ddS53XOFZV64uK76upSzk
 C50Q==
X-Gm-Message-State: AOJu0Yw1zGoNldkjKTXe91d66BKrZwPJHfctxiy3ZzBISMFUFJdNEuOX
 mMQb1+atWgMfm/p3mcytPVxTJYT5CfVfgXk7b1BIqXvAiCbzdsQxUmRn2CxKzID8233o995cNjc
 qZk8xgdc=
X-Gm-Gg: AY/fxX4FdQWNZBypzL2RChzDwUbHOwEqqHR2QVOtyIwuDiO3eH3PuszZK1YBH0rmbHa
 muCFgZwIKJp3Cra1Cwwyu2ijZMwsH4TL0yuF1X9rbUrzE6f9fryOHvdwsahYzR2A0v8HfiYBUtb
 rVOQQdprZEtRtPIOJO0lzw8qQ2mK8bS9hObrqff7LW5q1/vr8JMUOr4xHSH2k2nMYC5AeALvTtJ
 nT9V7rQrTu+nMYktT2ve50fFsnA6d66VdC2haJh2YnVwwp/OMaRcVYheJ1GmMr0OHV4Eav+lRb1
 igCgn4UYWujvHiwyeJ3OK0mpzUz53SXfdptUnzscNrPRhAciLpOQF7BiKCO7+qfUQS1b2wVPqWd
 /VG70PuyHSdNsScLKJ0mJU+pgl61vwWXXU3frm2RNqIeCJg/uFdU+cTS0v8Xna3Z2b2rKLIvcnK
 SrufwEee2XgHuyYd6zcjnPg+MWh13+fxe488kJXAyE58EaOJC4CYpSEoWzUUK7
X-Google-Smtp-Source: AGHT+IEIUVgDv7jMmBSlV0mprzgWiNl4AmoKFrd44nX1q2ZbvmuICl1LoVGaEiHkkztbKkFtG13WVw==
X-Received: by 2002:a5d:5d83:0:b0:432:5b81:498 with SMTP id
 ffacd0b85a97d-432c377ceafmr4985399f8f.23.1767816452128; 
 Wed, 07 Jan 2026 12:07:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df91fsm12489353f8f.23.2026.01.07.12.07.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/openrisc: Remove unused 'gdbstub/helpers.h' header
 in helper.c
Date: Wed,  7 Jan 2026 21:06:57 +0100
Message-ID: <20260107200702.54582-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

"gdbstub/helpers.h" uses target-specific symbols, but we don't
need it, so remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/interrupt.c | 1 -
 target/openrisc/mmu.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 5528b80e7b8..6e89157639a 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/loader.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index b2b2b3c4a98..315debaf3e5 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -24,7 +24,6 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-#include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #include "hw/core/loader.h"
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4D0E7FDF9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3cN-0005TK-4e; Mon, 02 Feb 2026 18:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cK-0005Sc-2u
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:04 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn3cH-0004t3-Si
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:46:03 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so48452435e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770075959; x=1770680759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u36ztHOhlec9Pq23BQb5f5NJyw4ApURGBO0GygKKm5E=;
 b=Bv7XtwRAdFtfskiO+EuLVgYLORqzzfYUPLNnom3p6q9wnyfbc2wo08cFsB+L/XDp8Y
 +rCIs96Aq8RB6eTece6DOIibP9B1QLaQaXeWdbaI4soyT1bE7ckDe/zJc29VVxGxmO/L
 l2GbR5NLMA56/JcKYNzQVwcY4194lyEpOR1rNcJ57ims8XzP3DM1LIribwXhexpt9zD2
 MFoTL9JOQo7iMQ/0nQvJXEhIW5f8+g6n+5KATR4LOlk6Uv2bRGP9lRlB9IaVJq7r2Hnp
 K6ruIr9kHY+QQvYVz079q3zJ+1OLCBBQUFiibLtMfdtQHNQc3luQgt76Qs72FTNoplE/
 rOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770075959; x=1770680759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u36ztHOhlec9Pq23BQb5f5NJyw4ApURGBO0GygKKm5E=;
 b=kJYiz6MNn2/kv8401neqJeniwNtVD96kn8jSfj6ioy2tp/DIH9+SMri4NikRCRresF
 +RPNhy2XCm8PWr7ZLBk6FcefcwAIprTMbWqDpf6YbITeLBj30uJsxGfTic2mBgsH6wJt
 TAyi7WAzRh/yszAB2YzLCslQtNQstbw1chz4VGI+rkuZGsiIt1iUPb/ddH6BEINwnW24
 eIBeUp2nzbaVm+qr4906iM3qDtLjMIVF0MN3jYM2K90W1NuxgFzR7GjKlMoPg1v1p5Na
 Z04hsRYcdGlITEw6DSn8Q/ivwhSel5qXRv3wJFvPMfTgYWTbQLbhQNH+I3Ug7sDx+VTZ
 cxdQ==
X-Gm-Message-State: AOJu0YyMjh5HpZKVbC3E/TdnJBVhgJpZmkXY94loUHvyrRhrEsO0XcFc
 NV36j8yKcut9Ll92ZP3m3y9PhY0yygjPdTaplcfNijpHIyaKQKpnsmB5IS3QwWV+L6t6v8p08bn
 Vz3arvvI=
X-Gm-Gg: AZuq6aJUN9SQBj2ZFld+jBAqcUcPK3iH+0WHwWrN5aioaRLCupxnrw/YYT9vjsjeI4u
 RFY8aAvi3wdtJFpAWhTw6DinUiWp9ArvBLCrJ8uBoGyyDxohJgFVyjo+ePxsaw39lNEyE5HxP2U
 wTHUGiINBYsrsrDur9YPttyu9y6+kHyIqJS0HaCpWZswnpuou86o1cE4vqhAb9DL58Qvw8ijl9E
 Jbva2T78Y1w5q2a8y1CgpQfnRH71s6A5s6zQLzA7Sg023iho9O31c7jSFmQSiZlg0mkqVX25Bo1
 skMXJRAr6Kb0gUI4Jn7x+v3IeqTD5vkH3a5JdzSh7p5pmVy2nri4bq1GrCov0fnpfU/RHYQX1PG
 BG0vtOxaw3Ace7LIZJm4q+TNro+hSIjE4R/p6beX4QU2b8TUNFP6YiZ1d2GTHYB2hgxnsbl38eJ
 7hGt9m4Bi98xjpS+cqb6OqifDDlrqbOXSiwYtURUhIWWMcOFzCfZHZB8AIAY1f0D3RjE5esGE=
X-Received: by 2002:a05:600c:4e12:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-482db481b62mr159947335e9.19.1770075959451; 
 Mon, 02 Feb 2026 15:45:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051539ddsm21085465e9.9.2026.02.02.15.45.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 15:45:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] target/alpha: Avoid target-specific migration headers in
 machine.c
Date: Tue,  3 Feb 2026 00:45:43 +0100
Message-ID: <20260202234550.34156-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
References: <20260202234550.34156-1-philmd@linaro.org>
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
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 6828b123ca1..dcba5d441be 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field)
-- 
2.52.0



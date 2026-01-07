Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F8CD0D16F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZp3-0001nR-Rm; Wed, 07 Jan 2026 15:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZoz-0001lV-3h
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:57 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZox-0002GC-M2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:07:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so19790525e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816473; x=1768421273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAhWQ3YxMs3dN1sixAOjPN6pWcLdPX6neg/lCGcxDWg=;
 b=iVBcSEDGC+FyhCopKkbsFiYRNG1kBwHbqy9abQsev9ozyNhYInsesM/eInx/m3VxIX
 TMEKwRSVh2DXro4K8+sSDZiJD8VGE4wbRFFXRIz1W8FPol9t9Y3q19icXM3PY4gqMDAE
 i1r2v6k8Rk9im4GOw7S2RaSwz209Uk7brBRxk+0yicR65qXPYQ/jvlVzrhF88M/fjYIJ
 2PYkGsk4f8oErLS9ujGKvU3wVqwcSKAqJ77YrLHjBSX73fRqSNrHYmcjrPBTWdDQ8Dqr
 zc2SqQdZgDKCQHX0pQTPspkhVcWJ4M0SYDeusgXAmlA+kowxKLeCjRsFqw/SANZtnasP
 3pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816473; x=1768421273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAhWQ3YxMs3dN1sixAOjPN6pWcLdPX6neg/lCGcxDWg=;
 b=Z9ElW7RQEyaDcDj/KHQOPgG4cBP1oxbeWL37AcN8U9UIj6dSZ/1WLnri10Up1l0OrW
 RHMw6IzUPuRgxvMlbU7e81j3YBp5Fz5oZSi2/0dYmRYE9rk+kkvz/aR6XN9N3VmjA+7O
 Em2P/Hsxy1VafUdqeleOabI6Hf5WAdhiug94G8ZWVMVyObGxgaQoMZgIAU0AIVS3SWhk
 N9zuRAXX0MXeW7vlDc7lNSWyDP+++ftF4XwK6oerxOHWfAkYfauJ1weJE1HyHMWpwWnh
 Fh4NmITGHM8LKZSdh38rmku1uNCZS5COZRoo8lPJiB+C4IDbxvslMd8ujk7jCIU++1Bx
 EnSg==
X-Gm-Message-State: AOJu0YxPtMaeBEHxxE8hhX9RM/a+/doWZqpNRcy8yRnFAH4lb16M8B/g
 9Y7Hsf4+/SkkpWEpW1u13r6RBNBQHW+1Jyluwbk/XEIoYbRRqqVJZCvozB4I8x6W9hqe6EQSfXe
 KM2MPdoU=
X-Gm-Gg: AY/fxX7VXvLH2RkCV33P8kmhWxW7L7ZnYZPp3tNy85YsQjODrF1maWUXKzPuksSXLpj
 aBIO8umqnlhhdBou2FYe1LvPcg7rdNlThj0p8MZ7R1kgr8e7Yph5mPJwaR4Ii0uTkxUM0RkwbCw
 NkU70+hyF04KJWxA79PVao60ku0rNwWLXVXs2HZSqUZErC1vybty+siEKv2B9ycONrIhizUhQa/
 ZqopLKYX+xCfmlWG3zepKL+1JSq38YjHPjGwHFPOtoM6MKHClHTSoD6SuXfgiAjYvSKJwGy2T7y
 1o5qxj9kfc2JP5kmC2Qd2R4LPjTipHMDTBKvtykRgF9uhWRQaVxqhiew/ntk0Zj/nttzNbsB871
 ZJS5zq2cou6Td9H1e3+h+mOJbNKV+AgZCN6p6yTyw//98zkjzQ0OsxwUrw1b8ws5jh1DleaRCkk
 VIO4VBiAe6cbSc+wGrKkosCNR81P6Qx/yR3e+ZHM3wAesmZ3uQFfX1xUE7UFQs
X-Google-Smtp-Source: AGHT+IHEmApCqtnoOBINIeeT7bAZIRvlva8MTsXho2Mg+C5XtZEkziE0pwZNd/tYhvclOW1m01FH0g==
X-Received: by 2002:a05:600c:8b2c:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-47d84b186b4mr40981085e9.7.1767816473575; 
 Wed, 07 Jan 2026 12:07:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f418538sm113162855e9.5.2026.01.07.12.07.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:07:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/hppa: Avoid target-specific migration headers in
 machine.c
Date: Wed,  7 Jan 2026 21:07:00 +0100
Message-ID: <20260107200702.54582-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header requiered:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 13e555151a6..6a143cf8df2 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 
 static int get_psw(QEMUFile *f, void *opaque, size_t size,
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E567D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZpA-0002AQ-9K; Wed, 07 Jan 2026 15:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZp7-0001xn-VS
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:08:05 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZp4-0002GW-7Y
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:08:04 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso26772955e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816480; x=1768421280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tpd/l84XrVzBPcf0urzMcll6yyS6LWFj3wm0Rd/I+6E=;
 b=hCBSv81akcrhyXCs/zQ4zi733AuovHpyn6C7oC++g+wFh/bE9rtuLV4wYqQcNFxDe+
 V9XQts4AIt7q5xmg4xlh4AnrUBSXS+fY30Bs6QtIFJDmHk/Se0ZG6EjvPtMZlrCLcSgF
 PeX14HNXnqsePBfbbRbFUtA3nSGu/T4Bfgk4FOtddClrHQjQ7e8v67TAn8EYkc73ZSUy
 6rYH51EKmSYomCXY3ux5xas+MxAZrzl7Nji97oEuEegJ6WFHL8RgbU6oFEI7MT0TZgVR
 dVMxeiy1c1slo0F8kIq1GhcjvoTl0CWObf/6Xpu3rwPhfiA714Xy8OuvxryO0NVLCPKw
 XFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816480; x=1768421280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tpd/l84XrVzBPcf0urzMcll6yyS6LWFj3wm0Rd/I+6E=;
 b=j8oOGdK9NftyMX2Kd9wWPXZYO8ave4Kc/qB6XOyOJqBRRYtnlyYcEBZgUzx7H/IHDf
 msAJzaPDFYGfXAUPyGEOP34u+w2Ryf69luos4ENswZHTaHLFGtaujkkFO76CMSn5Lbja
 cULMIO0sfgJ/UDGdYHyL/uy3zpdUR6to3tTCClYaG0YxelHkbzOxzBehZ8Eaun+ito6Z
 kKrc238NCcCUNkE8LpYkyJTgyP9cTFZ2sYvDCuHd67WlRGtKhwmyQnYEpXvZbHRTjzL1
 hCLpSN/SfSEsWbK1LCMzF5b7sGHbQgastdsPtVuNTpt5PmiKdc2zdFg7+mtgJAjIlGLM
 mjwA==
X-Gm-Message-State: AOJu0Yyu0X7zsIhBvUbKO60IC6vkt/CQfOWkbC2Y4Tf+MdiMr4AlFibN
 C7VdxfOgOC79kVT/TRzdk5LiE5QIpEycIW3phycey33XnX0G7P9nJ+k+vyeRKRYRUSlBmpOn02N
 oOfxIifY=
X-Gm-Gg: AY/fxX5NwN5KyIk7NTgZL84I+5lvPz8m3GnAN9ufiGdZzrFee2hya6RmiKZ/4TYA3jC
 kDU+fetdg71TKbjnHiRqsOm8n1WVueFMiAZoacY73EGftmB/M3pz/LIF5qXv1NryRFEEAjL1rEQ
 fQcM/j9ok3RC2OP9/NPsd42XWFI65nZ1r8jFL/YY51lpLW3T7+B9zpsQgbEdZreb73tCWkeSo7s
 MmijNLZb1VV4qKpfCXbA/PJM+jeKD/VYjqWOJ4fh9xSS9sVxFvXAp63maMZvtgGOT24AEZ/1t1v
 HQAmIQ9mNWHiVOhuhv8x2fVPWXY1sX0nbR3WPOfLDnftYjAchqpBst3lJbUIPxf8ol46MF9yDSl
 LAgygOzSTHcizQx4OMLUmYnTIgCydRN6T5yJe5rz1Y8jSGyXEFQkOkuwJF+nGVsEJ0NuUxB89F4
 TpZavkbQ2H1HLQdbxUegxaNFgC53E+glIdxRmgGFEj5LbnR4LA5MP0gJsgYgiL
X-Google-Smtp-Source: AGHT+IEEo18OU6MPrOvLfD48XWigK9dJiCmyH8tRi4Vv2kC8GLRHl7K7Go3bBrDZDWobCvDGmGBf7g==
X-Received: by 2002:a05:600c:1d04:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47d84b3a06fmr53318475e9.27.1767816480523; 
 Wed, 07 Jan 2026 12:08:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm13322083f8f.24.2026.01.07.12.07.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:08:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/hppa: Remove target_ulong use in disas_log()
 handler
Date: Wed,  7 Jan 2026 21:07:01 +0100
Message-ID: <20260107200702.54582-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107200702.54582-1-philmd@linaro.org>
References: <20260107200702.54582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
virtual addresses") the DisasContextBase::pc_first field is a vaddr
type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0b7074649b7..0f8a66f7732 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4864,7 +4864,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 static bool hppa_tr_disas_log(const DisasContextBase *dcbase,
                               CPUState *cs, FILE *logfile)
 {
-    target_ulong pc = dcbase->pc_first;
+    vaddr pc = dcbase->pc_first;
 
     switch (pc) {
     case 0x00:
-- 
2.52.0



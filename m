Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80DA106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0w6y-0001wB-Ez; Fri, 13 Mar 2026 02:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0w6s-0001o0-2l
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:34:59 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0w6k-0002M5-IT
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:34:52 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506aa685d62so9198641cf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383689; x=1773988489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8OfwNP/qb3YSvAtgcTdU1bHLQ4wSkJCKR03bN89V6b8=;
 b=op3e0XdEDgLmvfGmFGjyUjNO9OwC8+PSYfQlFsLMcHaiUqGtxL/tgZov5LZ4zuQSoL
 qgN9ax2Zbi/nQFcXkng7eLvIPzMJFKfkAHSB2e7j09AJvyqOlc68bWgmnl/dyn/g4FDn
 eG2wNdAopz1r1qFGlK00bBI0FXMmFY3QDSFxkn/Lgg21JrXzRGPaFg8x6gXx+Jac/BeM
 nzo/eQGUhMfigWvhsp8ZbJq1XrmrwIcnSCBMbknvtgBsYe5DXc5wQM1eBXcXGmx8hptA
 hm+iwMMtmJYXuoT9t0aGbP7+byKf2dY7dnwTXRIOmWrC9XnnlSAgB6ngLOTPO9NpsrNS
 GSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383689; x=1773988489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OfwNP/qb3YSvAtgcTdU1bHLQ4wSkJCKR03bN89V6b8=;
 b=RYKU7dTyg6q9zHo+wtSOjXen5d61Q4U+B210XpT5keX2F83KN1Y0ABVpU8cubjGWef
 +eSWP0oEkBZImSDxHBW0mVT0segLkQSwqtIELtsvDj+RjHEt1/k7Vv8vQ2bIJW/Was3x
 xWW3lNu2Ygac/A3i937rKINyR7O7wfE0392IOsqz7dVQ9PjyYrUojIjTudeu1po/UydW
 gY+dzQzrtl+D//lE7wGmzKzzfSI4kb8+ojyNoU0uja9UCDy1Lp/NPRFpy4XeU0x3NTiI
 nmX4QCeAIp2FlCFalwZxMvl09Y5mnOp/af/WqiU29uG5hhN8kP9noiWFlpGdGIG1+Grg
 GbSA==
X-Gm-Message-State: AOJu0Yz0k023omqHjqwd4VfXMqAbwt9rzn90LbdIQL+SJyUfwdQplxrA
 42U9xQNSPiaIgWYpeBp058qwXKLAgA40edSNrNVE+ev+ci7ZHIEFAx54O9MsTfBAosaD3mu9tEX
 qWquzvQI=
X-Gm-Gg: ATEYQzyL+kRmSaI/C9x7LKihPOsrI7Q49mu4Q3IVSr/mC0jmvDhCPmpNn13HOhwAM7I
 1whTWtXPL2oLjjaReoLUdzXRVpILwyGiHy/AmhHBEyzzHRou4ldyw2XTdvM1BthiPpCXx6jvT0f
 IaywcmvKUg7WD/7zWdBzf3ICmMVnT4r3aefGVb6s2yUWt5Kn/sII9zpbkscF5DT9eVzt4uP3kF+
 PSYCjoDQ7GcZYTQBMfULyoPhy8v90r9UJX/9Z63/vmxiBD4+VZADucaOk84y6jYY/BxoyF+S7Zj
 Q8L64nwMKElBOFGqrbcGBzeX5KhWjlgGGGqAZ16W95UCOv7C4kdBr2kwU3PlMZ3dvKyk1mz1ClC
 YpmA2jBAjRWyTXDFFeKWUE8kds9WdWtfiYwFOFM1fhsFMFl/HLsCp0ZY138tagDy2ve8sZ+2BVZ
 nw9vdowgVFbMj3TdfTuhsUopk0JNElkmbVCZFBXwL2RcV7ZyAoejdHjNIC4sGgJyy5hZHqSnTKC
 haP
X-Received: by 2002:a05:622a:241:b0:509:1dc8:e9e9 with SMTP id
 d75a77b69052e-50957e29a12mr27367161cf.52.1773383688759; 
 Thu, 12 Mar 2026 23:34:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65bed85bsm49737556d6.17.2026.03.12.23.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 23:34:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Honggyu Kim <honggyu.kp@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] contrib/plugins/uftrace.c: fix depth for exit events
Date: Thu, 12 Mar 2026 23:34:41 -0700
Message-ID: <20260313063441.2048882-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x82e.google.com
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

Uftrace plugin was recording wrong depth for exit events, resulting in
incoherent traces, especially for partial ones.

Thanks to Honggyu Kim, one of the original author of uftrace, who
spotted the issue.
https://github.com/namhyung/uftrace/pull/2031#issuecomment-4051762627

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index e3c65a1c930..f974090e23e 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -817,7 +817,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (fp == caller.frame_pointer) {
         /* return */
         CallstackEntry e = callstack_pop(cs);
-        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        /* uftrace convention is to use same depth as entry */
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs) + 1);
         return;
     }
 
-- 
2.47.3



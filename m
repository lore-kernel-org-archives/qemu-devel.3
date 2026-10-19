Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F0606A328
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KgaeJa5M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq4q-0006YF-Vk; Mon, 19 Oct 2026 12:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq4o-0006XY-Ts
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:19:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq4n-0000ZW-B2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:19:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso16315695e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426744; x=1793031544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JWKsK7Snh0t1KTXHB45+a2dEyoOgG32jtYKITcCtOtI=;
 b=KgaeJa5MsR3Ma9z2CB606P7AcD5UuZpScbzwY3uphgMMTtH+h+yvm7AnGinhIREIAv
 gZHT8gUMBC7Y1lPgm0D545ko/bCa5HoDqiWhC0T3zmibBnTGNHMEaCDlw9ZPqh5Hk8B5
 C3b34153/88KrSv/2qM0fjaH24opDYbG3uK510QQ2BpqBpHYy9NiXMHJ0otUt/qHK0G9
 rqW643stacRAwLI3y+h390cTEjSDmcacm56DmQvSUURXnDLDkBuY0UZyTfIH+XLqyY54
 tEgYWKKzTCqnAE/uoqE3bhXbrbhJCngCaoAXJ3/6nBCoxQePuFQycD3uvDo5LrCXEHkS
 xmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426744; x=1793031544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JWKsK7Snh0t1KTXHB45+a2dEyoOgG32jtYKITcCtOtI=;
 b=NLyKeHFIKH+4JyUmm9ie2JoUW89h04UhfySRKRCEqI0SfYnw4JMjux29MELAKG4dIg
 xkF19TC88vFRbs3sM3BnxCwr2LM/9kF66h3kBWaEvcm+q4xhNkbmHKWBPTaO8kYLlY/K
 PW0qlzH5Y9wwSW1nGOYjDmNJqxdeZqVbibpw7KvzpKyMhtXCjqp6pCjF7aS8Yyae4aM1
 NnuW0enfFExku4PGBXjjr4k++MbFpVx8ZIl1QGh2X4eusBzUvSZzZIl5xbRThSiY0TV+
 e8LNKh/nUN833Yt+jtsaU6ae+29aW3vvErUdi2XcKtOnXWatRiE7lqToeZVE4kChtOu+
 LwsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6FOqp2hG8+hmPnWkB5T2A9XYoYlasbG3Bbf+bQEAEpGLmQLlUceZk2ExuIPqlssFU0XNY+KzHccpo@nongnu.org
X-Gm-Message-State: AFq9FYKXbSZ5AK9PNcA5iw2PV+8l2IjjkkBDtyRvT0J3t2Jx+EnbeyGy
 KHoWNcPyAaEdlYzuBL2RRsJZNkehRyyeh5ZoghgIAX3bpTgNZbuQS3zUwWQw3O3Z3QA=
X-Gm-Gg: AYBFou1achrmJXr62MQh5N1raLJrudruE4xJ43cDl9Am68hhf7djWDKn5Jw2yplwgTZ
 GHY7FDDfcRFonkRZhSYizladdPGBegbcWR4+MRd0jQ1XrMWCYjwdi3VGqxiDiMN61NtwE7jy7XF
 Ti+9XMQZ9n/ssz227GetBnIcwZ49F2P+cM4ntIfAUAkr0OODDxeprtwX4hQoNdegwHcA308ZOhQ
 gc3XIYdv5No+dTw24zT9wFNAYR1wSK/f4MV0vlFiyM+FW4LY04ohr0SqRcryDwQelqXyWUB6NJ8
 HYVHptZFS0ZkjZiCT3378cm5rULZVZjaMFM4I1WrghvA1dFJgfeQZxlNj5QMsjKdjvU+yo4lIEV
 pGJG3hJJsORk54sza6JzCoGibRNADywPI658oF3gYEIoCETG98a/b+t/Kt5GrClB4ySrxlN+l4H
 +Sz4kBYcOyW6haDGRus4k1gLmmEGJcO+W8YuLQ+HvCfHxq0n60TEritotdE7UhKI0IM9/tdoKgs
 VTLS9HPKz1dNNBBHjndLMkEd7aTu9vRJhzrQeA2lXkryYRDEsJj5apwsIdsQ164+3trmdeLSs1N
 hQE=
X-Received: by 2002:a05:600d:849a:10b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a1d75af354mr127906835e9.4.1792426742771; 
 Mon, 19 Oct 2026 09:19:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca26dc8sm205855445e9.3.2026.10.19.09.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:19:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] hw/misc/bcm2835_cprman: Treat invalid clock mux source select
 as GND
Date: Mon, 19 Oct 2026 17:19:00 +0100
Message-ID: <20261019161900.3271815-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The clock mux control registers in bcm2835_cprman have a 4 bit SRC
field that selects the input clock source to use.  There are only 10
valid SRC values.  Treat the invalid values as producing no clock
output, as if the GND clock source was used or the mux was disabled.
This avoids reading off the end of the mux->srcs[] array.

Cc: qemu-stable@nongnu.org
Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_cprman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index f9a77ff9bb0..10cad07623d 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -271,7 +271,7 @@ static void clock_mux_update(CprmanClockMuxState *mux)
 
     *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
 
-    if (!enabled) {
+    if (!enabled || src >= ARRAY_SIZE(mux->srcs)) {
         clock_update(mux->out, 0);
         return;
     }
-- 
2.43.0



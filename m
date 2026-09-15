Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E087C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdN-0005Qz-Tl; Tue, 15 Sep 2026 13:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdJ-0005Pi-Dt
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:49 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdH-0003VZ-QL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:49 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so402286f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492065; x=1790096865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+4YabQhOK9Ug1BZZyKHVnj9Vt0AW1leKOIGy5JnGFD4=;
 b=TRye5ymDJeCbkOVyriiUuqPA0FnE95ypTAh9rk/dhphzykZMw/p3t5pQiTyqTuQZs6
 S6zmk8sfvR4AYC31TtLrYEiSt+cPdU9HX6YvVujKnCz+QvHB3o55NkzVSfvVcsptsdHJ
 HXkeO1D+0T6rwDbHQAr6lz64hnIXuStNfwJaOlOYgbmT4+/Z6KsMv0r+HZJQLHHEPEOC
 apSJ8OxLk884OkSSeBymnbkCOjid+taQUYqRuQhZL7ZMufdH7BEqanrHiF8/X8wCjJq0
 lLpE3yQ99DK5m9sRCpNJzc6ALsmxG4eufGfV2YqSSfVCh8TvTC7mjJ38kqcU0wHDeIdy
 aKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492065; x=1790096865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+4YabQhOK9Ug1BZZyKHVnj9Vt0AW1leKOIGy5JnGFD4=;
 b=mqeIi7qgX7yaJf7p4iuAL8AMBW2zaVoXa0G1ASJNvXJlfXhzlNAI8yvg+REp1f9q4p
 EDMbbCUE+sCIwhq8M3JAB+UoVogLY5cLOEpTvHPL3+v4d8eRFPQxvreUwz9IqXjiKmIP
 bDcHBIUDEyR7J810V+tUqA7i8K2uh2ZPY4aMS9ip4sQbKag7XZRhFl9Esp3ffxL1uHGO
 29+eDDUaEhEh10rfoUKuZa942q77f9h7jT/J9pjkquvnSaO3BF8HtXujyIr5/tOUPo0e
 FuvJJJy/uex3NyjTqwKa2xoqM1EgoUeA7Od9m9lfCjKsdjzyM9SbNIGY1yPfkPqQg0Iw
 4XpA==
X-Gm-Message-State: AFuF++nmLrGkttTX2AAnl5XSDcNevg4JuBipmO/tLmpXi2+r2+LVOkPg
 LDvkQgV362E/VFQS7GtiPkP7nrDngVG3mgIDJVjssqx5bQK+SBsc4Cj8O6zQuvBmXJXNOZ69xtM
 Gx5b65sg=
X-Gm-Gg: AYBFou0rRslSG0RCpWLq61dPes3pPhhJyubXWPF/zqIJOmjRA08+Ju5aVIePHqkEQ+4
 1RsMCMA36tEnOkDoAB0GfaVk1aeAYnkFG2b8l2GtAC70/kU0JONM/z48+fDu2dv0zt87ucAt4bp
 H1NNufVC2MGdwK7d4cPdvTkgMOGoVSs/P4ojbDPZxKavGhZLgexxeCT8Hm0Ypw9z0NbTezH47H6
 LOFZdQVE18t+4Aq88xqG6KHRO8oJJSLgJIFjE6YlTskVXuDcEq6zwnnHX8bl8fpakTpGvU3EfkG
 5op2FsJlGITtaClkq857Kg3jMEJVdvqVvCvAI55USpxt2X3uBq9TZEXuEnBJ8aHs3Y3cFTjG9CI
 b9rKoazOBGo0VCzsz+yoiG+AI0WTGw0EwUwXplOU3/ZhS5npE5RQQWNp4MSQS1A9X7CwIWE5J2v
 KhP4oxib0ruFYM24y8G3xHopZHFTfMbm7/zlnQFfeXN6N478/X2tyrtct0oyNqqSc706cKcwukP
 hQP/gNDotxT6LiPkna1D7st53BTk7pPKsPEKhvo1eYHaYjgBgxDrAp+d3Ku1d5Vt+Twl2/tkhlx
 eFVr
X-Received: by 2002:a05:6000:4b19:b0:487:731:c87 with SMTP id
 ffacd0b85a97d-4870a97bfedmr2173635f8f.7.1789492065609; 
 Tue, 15 Sep 2026 10:07:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] arm: gwdt: simplify WCV update condition
Date: Tue, 15 Sep 2026 18:07:22 +0100
Message-ID: <20260915170735.425445-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Igor Mammedov <imammedo@redhat.com>

Current code implements SBSA 5.0, revision 1 of the generic watchdog.
Which requires WCV retain time when WS1 was triggered.

towards that effect sbsa_gwdt_update_timer(), used condition
   (rtype == TIMEOUT_REFRESH) && !(s->wcs & SBSA_GWDT_WCS_WS0)
to make sure that WCV won't be updated on WS1.

However that is dead code as sbsa_gwdt_timer_sysinterrupt() when
signalling WS1, never calls sbsa_gwdt_update_timer().

Delete dead condition and add assert to make sure that
sbsa_gwdt_update_timer() is never called unnoticed on WS1 path.

Above change leaves us with always true remaining if condition:
  (rtype == EXPLICIT_REFRESH) || (rtype == TIMEOUT_REFRESH)
drop it and update WCV unconditionaly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20260902122646.2848464-4-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 2aa44573a7b..0ed29faf13b 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -123,12 +123,18 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
     timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
-            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
-        /* store the current timeout value into compare registers */
-        s->wcvu = timeout >> 32;
-        s->wcvl = timeout;
-    }
+    /*
+     * We only call this function for an explicit refresh (which
+     * clears WS0 and WS1) or after the first timeout setting WS0;
+     * so we can always load the compare registers with the new
+     * timeout value (which is not permitted when the second timeout
+     * that sets WS1 happens).
+     */
+    g_assert(!(s->wcs & SBSA_GWDT_WCS_WS1));
+
+    s->wcvu = timeout >> 32;
+    s->wcvl = timeout;
+
     timer_mod(s->timer, timeout);
 }
 
-- 
2.43.0



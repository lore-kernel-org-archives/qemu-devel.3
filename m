Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C002CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72F-0000qj-VM; Thu, 07 May 2026 18:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72D-0000pd-VI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:33 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72B-0003Cz-IQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:33 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso701430fac.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192250; x=1778797050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s1EGlKjHauv/m/x0LCQ+RWfPuZ6/ygY2+9s9UxJlW7A=;
 b=PzJMcE+71RhBXYrfX9sy3AA/lizT1tE6mmxPbJpLyr8jk0APmtWnTXQyxq9wCQB843
 HMl/E3FV3DnjUgDK8HhUEa9otFa+YChnrFYLv2vKtjQzsd8YdlR7nJdEbGuH1gpsUl6r
 deODTyukE/s+jE64ooDq+94wT/0r/y5IsP3l+bDFbYSiOSwp0uhaOPBea3qy5drhuiBl
 +UZdMucW4sjXyfIqWTXIJ1CqAbqtPp0BKVmHhE8TLggE0FhsWN0L/+MxQy6pPlQfX5Sy
 wffUQfx2dmmxXJuSEohdaa0XFpbbDIFaeJrCNRTQHXkGvnbf5IdeNdtzAl1Twrf1gC9t
 2LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192250; x=1778797050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s1EGlKjHauv/m/x0LCQ+RWfPuZ6/ygY2+9s9UxJlW7A=;
 b=B1FsANnl0l/PupAGyyp0U3foA2JrI46koC/9E+v/PyUoxEkKxbI8XnK3LiR9w1dYyM
 EIiqV19hW/UKjfYTIb0neRqM5REP19klZlA5934ukA4RsN7zvD9iHqbjN7P4MrDlWOqs
 Ejy93GWuinNa+VIJo7fhewh9DhFcfsUFXnGYJyZg0L7JDoMWOo83LeNw0pBwIVxBZezB
 PRyzFTtNBBOb8z178Z2qpzTzlEUmN8GMxu9OYZzBgwRt4Vul9s4dJGNN4BsU70FAjHbp
 cNl3vmOXGsdcd0PWZ2TqFjsetV48LIfTnyEjdA4bYksW7R+TuS1HzQqI/BQN/mwggeVo
 bc9w==
X-Gm-Message-State: AOJu0YxNQ+1uNApO8D2OFZoSkRJL264wzhMohtF1TTFi7381y+7M7ykz
 Usk3yLotkbdz2vwgxaCwl59CAOcBY9KFR0WUp4sGpZEGvt2t4LM1Q+oeV3oWxuJxJPUlxTa/TnT
 iYKMi
X-Gm-Gg: AeBDietuO38SObDsWvCrL4HlAysHXp+Msg/hI0UNzTyG2V8/8SZwdE3EL1aWqFA2IlR
 plghcwfHL6bJCbSO8jJZwEhMWL3hrWRF0TMSeF7nnFmuJreOVfmGgq6EVeZLKuelyKtQRd3N8AV
 yrJQNkIJLPEfkoVKcwOU+8HL/9DZim7awX+6voKoY5mJIOmrCcCYFve6sFKZYSS0Bo3EoBkmHmd
 sm6eaKkXqWefxUSBKShw54wlwg+ZfBpxBKX6oTfUzp223JnEiZeSiZABW6R7o9S7ZvJTeZJTLGQ
 q14u0f513v9FORyfz9Uk00UmQY6AncpHuB/ISTJrg3/Ao3ScNn35LovKJeGGUA8TqIZQdJedEEM
 f1yfk8my0sHbfY/03Wq2QxjP40BtmJEClrcsFiysq0rBn+uQcVeFPfhLLmfa1b1b6uw4Yy0V565
 hU0DGwD5edEGHqU7sDSjShkg20lQC6Qv/EZ1pVaQD7HR96ww==
X-Received: by 2002:a05:6871:4e46:b0:42c:a86:abd0 with SMTP id
 586e51a60fabf-434f66d107cmr6556352fac.30.1778192250204; 
 Thu, 07 May 2026 15:17:30 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/18] fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
Date: Thu,  7 May 2026 17:17:07 -0500
Message-ID: <20260507221717.486023-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 0406a38206..ed28262aba 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -53,7 +53,7 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
         return partsN(default_nan)(s);
     }
 
-    switch (s->float_2nan_prop_rule) {
+    switch (get_float_2nan_prop_rule(s)) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
             ret = is_snan(a->cls) ? a : b;
-- 
2.43.0



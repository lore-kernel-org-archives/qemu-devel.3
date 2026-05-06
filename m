Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5DCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjA-0000ii-0B; Wed, 06 May 2026 09:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcix-0000ht-Ug
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKciv-0007mT-UY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:55:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso3192295e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075735; x=1778680535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VV1DtQ9tokUI/5dtEziTcj6XmKzBUi8fnJJrgQWncs8=;
 b=zPt+aqO4wX7ctga/SLKsxUWo3Md0ID09o0YyuAoPHTWzt+Fnp1wRz5Mqq0UhZwPIri
 OTpV4tEOPtgx4JRNK8e6HqDAJ5Ttqh/u+a7uL70AgCOqEgJ7kzQO6qso9mUxbdgNqwiF
 wC7zNfj4D9kLhTuUc7obJRnyihSFaqUQ+QHhF038kfBxWJXjtCf9bRkZ16Enc4LXvFke
 sa3oObBlErBOKR4MRBA/bAb/n2qWiuvbOJ9mxR1np/SdmMHaJEsuvqbmh2TIisiU7BLc
 MGH1NvqRRF2RJ/U4ysM+Hq2LF7kKR85A+neVOeiikR+TkLqzxNfM8eYZyoUaWkyHZ2bG
 k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075735; x=1778680535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VV1DtQ9tokUI/5dtEziTcj6XmKzBUi8fnJJrgQWncs8=;
 b=pz6nqNOdg6WWPL0wiLK1VrG4emKG1uR+624an9suvokWNPRML8UEOCr9gFlpD/lOe8
 y4m9CedQYXVdPFlnhQxctuO/evBfX9sVCzOYBN/74/jIhx3DZttDNRAT3IJr+Hq1nlly
 G071cEgJ27pDxOXXb9ltfGh1I6d9tSVyPspAl7aY65JBkneK9pGERJ2eRkmsrLTkPn3L
 mPBsLhGpd//UeqsZbqoWSYoo2p5uxgfvVjne7FTnawD0+UEMbBnPNPE4xQzCb4wOP9Cl
 UMfR7sxlu1J8wBFh++O12wNpENf5Lizm3FHdZPSx0c4c0oPnrgqadHhOP/7v+lVv9L7+
 xT/g==
X-Gm-Message-State: AOJu0YxiFrz4U1ZjN46eO/qNkpJaZe1JBOMl1qGaYdPezYvNn/R3mSsY
 /ve8vtbDGl0dt2JVXfQT5bJdiIimxAQvlg6jzGkwCyDhQSZIwO/y9vU47ydQr8KWe/FnVokUoxs
 Dmgepyj4=
X-Gm-Gg: AeBDieuQcJCp5Bd0p3OK5UjFwMVCJ6CFvnoBIVB+YjrlzT1/ens5mpSwsFgxAyeypRD
 QMPxxchBmkZouSsqyC+dpZoddkIiguMO8xklt29WOsNNUPZRpW/7h5jYq7rxtNR7hlP78g6nN8m
 yDNd7ji82hn5wEIo4JrI0JR/29ueHeXoOy3BVQwXrQs6YoMGtmpz42+6i/Rabr2e2NBrzRGchCb
 Hl49NjioG+kwCbIhwlhbrjGdRzy4GduinQtMz/878hXDUbkuK87JFnn0BPtB4hQd2aTCMMTHRQC
 mu6tR/1Uv0kO/TknmPNlZVIGfjwaOju58z1i+FOVmBp9bUG6TZLacWRtsVMDWtp2Dh+a3sRmQMs
 o2jQYO28ZqJm50FOjxJUGo1jMvkeYDx53roor/sJ25H/I7xpPYP9RX/y+piaP7+ed484r8+YuNd
 DjrrGyUFPai4vmasl0C04i5qcKqAbF4mYr1eciGfja+9I2byVgkSAx9Vy7jRvoog7N8Emb+U/Wq
 m0LrMmNzFo=
X-Received: by 2002:a05:600d:6:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-48e51f1d04bmr45423735e9.12.1778075735298; 
 Wed, 06 May 2026 06:55:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm8080760f8f.8.2026.05.06.06.55.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:55:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 001/110] monitor/hmp: : Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:33 +0200
Message-ID: <20260506135524.20617-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
we'd get when removing the latter:

  monitor/hmp-target.h:35:5: error: type name requires a specifier or qualifier
     35 |     target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260427080738.77138-2-philmd@linaro.org>
---
 include/monitor/hmp-target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 5167d17d41d..898473b3ed0 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -28,7 +28,7 @@
 typedef struct MonitorDef MonitorDef;
 
 #ifdef COMPILING_PER_TARGET
-#include "cpu.h"
+#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-- 
2.53.0



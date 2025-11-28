Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF90D116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 16:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP1Fn-0000zp-B5; Fri, 28 Nov 2025 11:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vP1Fc-0000wE-TC
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:23:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vP1Fb-0001Sr-GM
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:23:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so18092465e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764346992; x=1764951792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pr5yp29H0V4IUQeiIEA/B9+K+4Dm24CaDsEp9vyABNo=;
 b=MHK+xcXaV7w1fXnp9MkUdg+BfEz2cMWFjR3fLGla+eoYMDD0LURoOacMIrLAbbqaJ0
 iODbQsonCmdHPNxUPP4Wlf7oNsn17nvti0KUR/b2b4S/+lLwf4WylNqlw4y92Yh5BtsA
 4gEtXXSxU0Jd0+9b4XOW+lrW+D+udlkcDOzhdQL6ZzEklP+JvEVqLAVMBQJJ4qz2y0Fz
 ug1BqLrPspWVT4SMML6LZlydUoSjeq/NS96r884j6l0m1Odc7AMPwA8SO7mbI2jRDH9c
 66smGvNQbWb4zaM7Ovr+NTmf83wNZpiLjBR5+PU8yqSKH0KB2N39pn05aKtgnvJPBnCe
 qfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764346992; x=1764951792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pr5yp29H0V4IUQeiIEA/B9+K+4Dm24CaDsEp9vyABNo=;
 b=wM+5hc/MbA1PTqyfc5EaGrl7LOkhz6A5gmWWk8p+Xv8o8YNf0wsO8mfRYV+ymRWg+T
 VavckqPoa6kJizVlRIPEOhF2qNGaNFPaFr1Z5sCNhguVJwziFNfHoSxLwpBXR5/ixp8i
 oDQbFVqQaH7EEzXheR3txBhjleetXa6DK6wyOPfT1uSeUjN7ZStpHaJIxlOi7abZEcVN
 FkEOCoPRI3rLcrBgVKW9tG18rxBogu/ltfKDnYakYmFRxUMHzdWWvtHkppP50HKeXolJ
 JuZopZaSJouC8nOjFiX4tQlJji4obS77K2Nc+BHmJEKLy/tJWFZ2dM7RiInVzPdIhgid
 8vlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbaKJnItNfPQHQ0ghq6XFTM/nga04GMpAzCAgVP6k0K13KfxU8nk+8B36zK5pI1HKEnh6PsHH1EvSj@nongnu.org
X-Gm-Message-State: AOJu0Yy6H2nYAgzQhdSFNgwHQ90DROa9Wqeq/DMtCQBHl5wuO+LoPbkE
 pLMI1li1WsJ0cT+wtZp0kD8B/u7Ezlu72oWqqGCKcL40eMEGG41sFUH3
X-Gm-Gg: ASbGnctRyri09OhoICgG254w274i4xFGjNWsdipJnDzIs3GBm5sNMudSf5lgYcwNqcA
 pHpK15g7DgG4DvVFnRlOj9acT/OnCHMR34OLojCSs3KP+BBSq+YOLLAB9gOwf4qCgtImv2Yoqo/
 s0H0OH3wAJhJevEp0AMRDPKOE32IRyy6DqMsqfUX5CZGwKsnna6stJOdkJPtDzue/MJUf+5NSM0
 tT8qIwJJsXIIHw2R8yPbsMevQETmt8z2mICImCIh1hG1V8YR4W8aSXK8RtkYGWsl1Q57YT7s98Q
 qYJBY5hM/GE6OJMkRep0hsGmmBKKyCCU1M3tyJqOpBYD4Tx6Jmswtc7BVQG7FbBUjQ7po4tmyEN
 nLnAsW+4ktjCwV5257qr7UVcaUH6o1NQTpSbz9Mb3FBVD96Qjpb7F3wAlWKVHSwPwh3dGeLZDga
 EwdQ00V8Vml/y1WQ==
X-Google-Smtp-Source: AGHT+IGcJxj+MvTPHPjIhAjvMTzHqqsd8NMWcrN2hnQyCTuWEq36aOkVmFYeTxFQzNBrYjuGDWqWUQ==
X-Received: by 2002:a05:6000:401f:b0:42b:2ac7:7942 with SMTP id
 ffacd0b85a97d-42e0f1e3433mr16953347f8f.5.1764346992326; 
 Fri, 28 Nov 2025 08:23:12 -0800 (PST)
Received: from osama.. ([197.46.139.116]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a303sm10953167f8f.27.2025.11.28.08.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:23:11 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: peter.maydell@linaro.org,
	philmd@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/arm/raspi: remove duplicate include
Date: Fri, 28 Nov 2025 18:23:06 +0200
Message-ID: <20251128162306.13701-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

hw/arm/boot.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/arm/raspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 81d2fa1b67..bc723dd7d6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -24,7 +24,6 @@
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
-#include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
-- 
2.43.0



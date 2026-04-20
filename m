Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C932F36C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErgU-00077V-4n; Mon, 20 Apr 2026 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErgI-00076j-Ks
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:41:09 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErgG-0008Az-4P
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:41:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso2007047f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776703262; x=1777308062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yIYC8fw6Wo6hDwuqVHYp1q90cYW0CdKqOzhCJt3lqmg=;
 b=KwbXckhMqT8MLEEtSvTjcyH+YT4yEoiNpFfWVqVy+FzZTtkybJ1pfahqlgRFpuFekb
 JZLfgQ4NlOJNld4ieuhvaAr5HAHMKFFeG4bliJjMu7xSjyhX/pbW055gGVG3NW+aJzbp
 zRsdxmCDxqcjCE5DG6PJ5rR44T3kRWzQWk8c+BgXVL8ejNW7Q4RUErPHHGyBk7NUOuh/
 zUlweJbWgq7Q+VMRKJQLsR57nVE5v9fTQnTFpFozaUZO7ZE8/V/ucfzD9oiZZRBq7bkn
 fbYrbU/Nd28EhdmqzG1A4knQ8YZRfEUCr5nVaPLYlVzj9yOk6YumlykQKEU481hQpKln
 ZK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776703262; x=1777308062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIYC8fw6Wo6hDwuqVHYp1q90cYW0CdKqOzhCJt3lqmg=;
 b=cfH5YXBrPKAkbZdvH64I9UojXz4xdCRYEOwTviBMXExrVfWLluOw2Nc1GgPkA3kBeb
 n2a1JnBGH+xdl1VfBOqvc5Cmq1SfU3BinyGRgGgkUfe9pSvqkqwBjs5SUMCOj+9nUAD1
 IYm7v3TyhaCA4pd2Y3wpbh2bRJ/WYLZvwX6JigShs8do6oYkTX1YHr++bLE09EBzSegq
 lt2TyP6ruQtmCaSRW6RURdvNIwGB0GP+PIe57hUTaNYWjnLXeIJnoYXo2zP5F/w2zEfx
 1eP0lkRxfwwv9qqRFBYbIsFRN6CFjJI9mcOeJdhdSHl9pSMLscbia0Dcwy5Xn5/GFc28
 /Xzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HYzb53bwcOIial4GDgu6WTrqZmTL+cHVU0d5hUD6b8ENEl2YiIE8Qd4LiZ3pl8TwUeTwk+at94JFd@nongnu.org
X-Gm-Message-State: AOJu0Ywl09p0dL7/nS66rQ5P8JYDUbc63zr+q6cw8f9TPk7kLqm20aso
 UKO6TFjtHN/5WmxGoedi4RdfKtqYmuavLXwuHDFScnvUG3gAcN34Un6H
X-Gm-Gg: AeBDieuhvHmW+2iy1915ghQ6jLIGvRACJW8Cg6XRs0/L1MKzyX/Jx4G46TgGYjuoczx
 5zOmHDWHZqMDdcHHH30pFOr7f12CKSxPEdQGVTnzvPWaCFFCcsE9XqhiODqWiwulThtdmv2msPM
 +COCyWy6L/GT/g2xqntK48Nh3XQA4b7KZ+HMNazpE9UvMHWTH/QvUqmEkly3UHUsCNAc4tOASqD
 wnT+bMwqd3UxadAHfdIQYhVnTZ5DWzPZAUBOq5c2BcVnHUzwZKHhgxr79fnhgZQSJeaL+B33kKt
 MXw3lA4zLpxfATvH1NrQaghiz2f8R+Wi38U7XxAs/HsfVsnmGkFNobpmqrgXItlmjJOkqQB+Bj1
 oxGdtjuF4u1a0n5T5LvJruqScTjpONxdmN+S6jooFcZ6vzMfmkHQIIKQsdtMRLc4R6HL7hCVOxv
 8xAg2jRXoK8WjgU26rWiyoDBgJWfnCiLh332sWtg9+jZMGqFjWg4XCPC2TYE1ETGBTkEDLqe8=
X-Received: by 2002:a05:6000:2387:b0:43c:f447:f9cc with SMTP id
 ffacd0b85a97d-43fe3e1e15fmr22451214f8f.46.1776703262406; 
 Mon, 20 Apr 2026 09:41:02 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm31763544f8f.7.2026.04.20.09.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:41:01 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org (open list:amigaone),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/ppc: remove duplicate include
Date: Mon, 20 Apr 2026 18:40:58 +0200
Message-ID: <20260420164058.335872-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

hw/ppc/ppc.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/ppc/amigaone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 8074713fbe..9fba5ca03a 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -20,7 +20,6 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/ppc/ppc.h"
 #include "exec/cpu-common.h"
 #include "system/block-backend.h"
 #include "system/qtest.h"
-- 
2.43.0



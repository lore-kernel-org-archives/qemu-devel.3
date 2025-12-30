Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAA5EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagwy-0004WY-Hy; Tue, 30 Dec 2025 16:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagwx-0004WQ-RL
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagww-0002C4-Db
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:15 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so8176346f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128892; x=1767733692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SQymeuOhNMLqrAqX+KAFZo2+ziNig5pvD/1MSmnD9x4=;
 b=a3PFuDE2ixMGsTYqzPGUtJ6f7vXkTZHSO3yTLn1SfqURNij1umGhAIKUYuI0N2iFpQ
 LNE8ot+r3WWD6a1g4hXeg5/vOkXDp1fGIKwGdFQdQjYMm9IYI8xBbRRDMEtOMkpVa9yY
 p1pH60yBoikAM0ZlJbRIHlsmakqbx/k/kBQO3IvA0AepisjHKGo4qwlw4sAiW89yqpvg
 IrOOhZezWbjRzU97COUzSWQc4aSDuU8FNId2yj1ipkDNKc/niSrfAe7BskB+3w/nBnAg
 frCVYJYXH+MrfdStyNm7bbymPECFoMJGHPwfu8UMAS+Ca8QrU5j8oeQbl+wN0n5pyMny
 BRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128892; x=1767733692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SQymeuOhNMLqrAqX+KAFZo2+ziNig5pvD/1MSmnD9x4=;
 b=kaLRMY9xXV0wnpUjzFvRrkmvyM+fAfUUY1M7zfTjBCTio09COy9RQcrT8FUta7d8YC
 Y505NMxliuinKH8bRQWArl7BD/hoJmb+LIPXig0VDccoK+08LB0YnzTCjQJNHIs176YO
 sbJNWxfomtXoLmhkGc1bT6Ti2ldh2eiP+nqqjQGIiIWg4Re9+vVdyiY5zEy8wQSQLiia
 ucR1CA6b6oROei//nKjWQD+d1tnUSxUqdzCFf4RUxwcwga9LEM8bx4GSKdhqnRmEcxWk
 rqsWNGo7jT6GxBi2MYZo3utaj0IwejLr6VwGiNmfQ8g9akdXkJGoDEdzq858DhC7XskE
 RUJg==
X-Gm-Message-State: AOJu0YyX6x6CESPdrYmmQx2AU14XJNEDnr9KKOi2xdt0UqD87qlrnKte
 uBhnXXnEtZy6BX9Zr7cxvIhQIj7jyvu741ki2JsAm80FpNKHL2bO2e1Fn6F6X5ZY+UkUWo+uiiJ
 3gEiuIXo=
X-Gm-Gg: AY/fxX6o4EYEK1IQnZZGJGoVvpScJqGv6fmHSHWoKH2zlH9M1xPGb2M1DuO6JTi30OH
 PU022D0DYloRwzO9ueph76LUm8wRiDwZdNB86xLyjEhoeCAJSo/4Rfy1ydC8huxCBTrTQ3PDMi3
 lcfl6nF7uMG/NnLgL6APt5TdB2d5/t6FWj7spmopPVqHwvN4OutCzme782QeOtXEVAxiNtrEmSV
 N+vpwxFGb3/1t/3Dfvq4zbfCWOQjyxTrI+ESe8QXJ1nRWtPOBo2O7dwSLPa7cf7js5uKGJLYyKr
 Pqxg8cM1VL8GpE4bw22h3VPhOgfwGdRoyCx05+OcZfWFwAjU5Oqki6LQYmHM41a2rsL5zohj+8o
 01waY6x0srkX8HspXhZAzd8G/25bDTW2DDnfnvR8K7D9qpejgq3jKH3b1EFJxRSvgZ/fm19NiKP
 Hhhvx0AjHfDWgMLR6WlrYSLl7uEKtqb+NGZqgequGvf+PH3pXeO6F4f3T2sEUcFvwrP30JKPY=
X-Google-Smtp-Source: AGHT+IGhGaFy94KCgKuPi+ela8zv5XOLqBfNujPxQjHjhQaOgmW1g3L4z7FeZ9HDBxR+IA1HvhoeyQ==
X-Received: by 2002:a5d:63d1:0:b0:432:58c8:b90e with SMTP id
 ffacd0b85a97d-43258c8bbbfmr34203982f8f.15.1767128892243; 
 Tue, 30 Dec 2025 13:08:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm70766179f8f.30.2025.12.30.13.08.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/34] hw/core: remove duplicate include
Date: Tue, 30 Dec 2025 22:07:24 +0100
Message-ID: <20251230210757.13803-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

qemu/target-info.h is included twice.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251126210832.34011-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 2417f82c3ec..b60b8830509 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -41,7 +41,6 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
-#include "qemu/target-info.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
-- 
2.52.0



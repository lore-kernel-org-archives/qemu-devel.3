Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132CFF99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqub-0007ZC-95; Thu, 23 Apr 2026 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquF-0006dt-Ji
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquC-0002Sc-UY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so6320828f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938611; x=1777543411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JVz10CrCDOI9L4NieaArKqFLucBpvthbzdziOn4I7dU=;
 b=jqRL+hm43w9pfNJB5pU73eZqi3TrZvgSFE0oXB9Q5+3+17IV6LilUiigkDMrM6F1XZ
 UCG5o3EgX/L4i9GDZ0PFDdznxyp+vuTMdW/xagdopCaBr1PKhEli1sGFfaW5MOIPo9lh
 ZufnhoF68ol2OhcXl40IQw6eCeOW9zCj/bmjLTPRANhlws0ZnyU4cJ60+9Zp9x1lsNl2
 05TFT5M3Mlk4IOJWQZ+Peep1R6kP2cId0rgwjEDCyYXJP+IdL1JnfxEbSzgu5IoaFPxI
 zcan4VAcegT9QCn3kXOHkUIRU5CHY4q01qOXfwR9n7WOoSi2g7rUjnacAyGf3Yb+AMWA
 MZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938611; x=1777543411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JVz10CrCDOI9L4NieaArKqFLucBpvthbzdziOn4I7dU=;
 b=ZnDgwGj0WejoqZJX+BLZvcHS3mR/0J75HrqAQfvFL9R0pfnRGICWyHeEpDIdkAwbHk
 v4VjlKypHYExpkqN6uiTVzvzj7M7V7yMjXBFlT6pVzKC9qeDn3CwhEGiruQ6OstzZDv1
 aKs+NtHM0ZIMiy0umL9q57G6KPrU70kESm+MR1mYXVA+VutDQUW5HqDAjSQcTis36VJU
 Bh9b8DsHp6IiEDRP9zw4HknNzQmL2z3xsOiyYJj2DnGAItL0DPi1Gc+bTb9I1YnoTMS8
 8DI4K862TYCpxjKg+3idoLBB44tkLXZdT9P9HzsJ1IAbQWpMaqpF2u2U4EyKri/UtaDO
 XJNg==
X-Gm-Message-State: AOJu0YzaJEHS3wVf96Z1Otyg5CIl7kK8zN0BftQD7JW9pzpFE+dvz0EL
 lh5ZP3OAwf4PrhBW6QtN3quO2ux0QodeW4C8z6FNGA5InRtvFApSvHF1Jr5dUvfNf2d+qFZa2y8
 oHMtm
X-Gm-Gg: AeBDiet6jNoEHttupaAjc6BbscbAtxMxvJ0oAEZ1XnyNwnHa9fsLYWUj6oFCVM6g7Ft
 dbAj/0MDzlcZ8J9SY6tqulGKvg1M5iE407qakSJAcxHycrb8d1M7/pjhOU+CduHM1rhhj6DUJTX
 AFzk++5d5qckBLtLc1zzak/AiLOqYnI9QT33cKqPrTWSrBvIvNeJ2py3RC7zj+5w7pV3S73Hhl+
 XCMVRnFD3zUf6cTul24/45PeFSTFxnb9b8IUsvRlpiN6cGCnLDAK6wozI+c1AbL65EEgmQLQ0fj
 uEDzXl+PAXRNO6q16YiPD8caaJoYwJFj5SVplQAzhjpfXl47OqGPH3sJcLZKHSYnOb81yDTVk+9
 kMQnlM0tHcQFNeuyriIeUZcd6GjUvdPNRw7jj0moWr+dJ/7b4v3UP62akeeVRFqYnPI9D5bPQqc
 Io08hHf/vnu9HO8cTfNqEHBoGd/xcCuMfA8+prukLszo1yt2OS7MgtjAbznd/Vl8AcLfF2CMYg2
 y5oTF2M7KeV2C8mjwl0dftLaaXeZsX9BzT52gE3BA==
X-Received: by 2002:a05:6000:2309:b0:43f:e211:6e6 with SMTP id
 ffacd0b85a97d-43fe3db9b6fmr41352844f8f.1.1776938611232; 
 Thu, 23 Apr 2026 03:03:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/59] MAINTAINERS: Remove Su Hang
Date: Thu, 23 Apr 2026 11:02:24 +0100
Message-ID: <20260423100229.2941820-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Su Hang has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Intel Hexadecimal Object File Loader orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-24-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5d5f74099..02696f46f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2717,8 +2717,7 @@ F: docs/system/guest-loader.rst
 F: tests/functional/aarch64/test_xen.py
 
 Intel Hexadecimal Object File Loader
-M: Su Hang <suhang16@mails.ucas.ac.cn>
-S: Maintained
+S: Orphan
 F: tests/qtest/hexloader-test.c
 F: tests/data/hex-loader/test.hex
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B8F4368F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh1b-0008PA-Pq; Fri, 17 Apr 2026 07:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1O-0008Oi-Vq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1N-0003ia-Jz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so7538205e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423960; x=1777028760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noBITy7UK4OHaEIlj1g5Ct15qjTgADyomjiDJenN4XU=;
 b=WNiP/qgUSK0DlAn2JwrJsnfTrQhzQcijX+sME/lDNZO81FMPwE58++9rrbNlt/9DmU
 nSxgiDbDfcYBdAjHA1q1RTznEAPfgUl8JhfF2Xegj8gnbmzKfR0aD2P27h1YeYxEgMoZ
 HxaKqgiHRZ9tv1RTGlZyf6Tg8IWPDmW5qxcNzVgJw0pfcE8/NvA1Vn6+8UMoDtaUg2lX
 T5Qhcm+eU9eXYnwyp8FRIlpnd1v1PGGR3Ud+LE3AWvVjESIPvX/KHMi/RbfJW+MJLO7Y
 QYjUthLDsRRn+gJ37gI7vf8SBQpdWw4gndULSzqnEtzcu2iL8IK0wiAj5KlyoB9WyB+N
 qrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423960; x=1777028760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=noBITy7UK4OHaEIlj1g5Ct15qjTgADyomjiDJenN4XU=;
 b=AnrcOuntnAinp5liLtayttG80lgQNxxO1lYrcEmkR//4rYQnt5+QYgXtGQYDxr/gKG
 ZDXZvRR0ifcd0H8JVCNr4CxT0T4ue4wR/QUGVXh1+q3lNi555+Ouq7I7n232fEFpo6Sk
 jP6cQ3OGJCjIFkg6Ne3rsorFFWLvGOLFf65pPBIGi0+K6URQBqgKKdFVhv/yX3b0sPpO
 PykiBHDrTp3A13Uc2HCeJEK2/XflQnlOLmcFWxorXQQ9n8VVpL9N2+XPaHC/bEilXV1R
 lTb7XRt6D2HtfvVSBZM5nyB7FNxgjblrqwwW4vEEgroP18BwMLJ2xXow+gnKG1EgSkm0
 gzzw==
X-Gm-Message-State: AOJu0YwjWPSABXnCLJ7/yKtmTz/qWat8u9fWlGQ93ic48MysrssoVHee
 bPbY2ZJrJPiCjrMyaewr1txWqz5iCMYCpwojSqTFmmtYNk3cpU8yBYa5KZ/Q3yo7rsRVCZdibf7
 PmSOn1o8=
X-Gm-Gg: AeBDietW3eob28DLwn6cz7F7eTwo0dYg4ltNoLVAlkJGanQUaU6EnelhuQ4nx7wHuk3
 iwj4SdsV6WszZtrcWxGyFwUmJncb7YXGxoItUT7cSewO2D7/AASAdiLxjrhdUwvn+stDF8y6PS5
 WBWa5eLwpQzn84fP7TJjWYbugL0CPPX88Ykopnh+6eKWtRgrrHCnNlfpTciZRi5wulctZDfG7xO
 D2lm2uNCdxSnPs1TZ519Ox4FgZzj0ZQ9DuSPHfzOZH6gMQcaKbzWOqjHjJOih9to+kqjLpYg8KW
 82YgvDx6QUC7R+Vz6g8j/0+Sxfhso8XkP820vO6sdvi7P6ROho0BICdgJSI/hC/k6123SbB7QcK
 fMEEGm8JcfkR3v+QBaf9Kfp0I5a6SLwNletznQwK64xpZWncu00TeYwPXcADR8Mn9PMkLHY/FVE
 63ZE6UrY8Soj6bIYaNQBiiN1aDFZzEBqvrcnSGRAwT0CHkXUFpb0NBd7tvjdaw/M5jIvpssuOiC
 GbH0SlS2L4=
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id
 5b1f17b1804b1-488fb77faacmr30665815e9.20.1776423959795; 
 Fri, 17 Apr 2026 04:05:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1001bdsm60772095e9.6.2026.04.17.04.05.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:05:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/7] MAINTAINERS: Maintain MIPS Boston
Date: Fri, 17 Apr 2026 13:05:43 +0200
Message-ID: <20260417110550.70068-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
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

Maintain the Boston board as just another MIPS board.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e5dbaaba..f0950479ab2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1485,6 +1485,7 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
-- 
2.53.0



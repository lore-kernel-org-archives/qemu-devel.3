Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A34F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqug-0007xb-GA; Thu, 23 Apr 2026 06:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu6-0006Z4-II
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0002M9-4q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so59429195e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938601; x=1777543401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=co2cvif63j3+U7G00UZQLi6jjvOKb19tUasGk1HUUQ4=;
 b=r0zal3Xr3hLr9N+LdLIB0RStKMOvF8fGrkVfiNXgu01RxffW6KHTgpu/4f6Mn6sjlN
 QVIIBv+43UK2zbaYDPkLAlC7FLj1/WXs2oESEgjKx7cizygDSI/pVTYslqzPpgL4yBgz
 IZqybHK+I1Yfb2uBqtqAUW8gHAG6qkevuLt30YJWQgBMFAaWlSzuvpNaY8xtRSsORsM+
 aWaVf2RzQiZAhjuwsAeo+a5QfAkVnjsBoOAuwqmq9o/rZxFcARIDYN8u65aHtfRajTdX
 fxWZEUmwlhKoMOdwKoszdwL2z4bnppTHEtQAlVaGbxWYsPdVLu3moOZIS2wWbvZ2NUZn
 xFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938601; x=1777543401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=co2cvif63j3+U7G00UZQLi6jjvOKb19tUasGk1HUUQ4=;
 b=IttjqFLugWVEUcA0YyqSQEtKh+jwjq70krnSMPNR4WXJw0NH7yB5e+Ygt3UUxAIdOe
 8K6zRK8TRPUpR+syGe73TRXwXO4uy5ynX67u7oGVWyFXtpYEfWM1mH/SFjKSAV2EJbbq
 fLmZd+dWPibk28LIIosGkqBm8YX2sPwov5oFpAOg3xrku5DMJvecFUQ+h0hF57FG6keg
 WwQwQe2bgRPhzFohHPZMWAodKxpLzD0H9SWfbpL8P6mCDUoYN7/1OpMcsqICtCNwfZbK
 OYK4TWU1lwLHgcSFPW34pRVnphfJ1dj170dhZ+7dYm/gZGgBrOihiCRG2U8+ay1hrTHo
 Bnrw==
X-Gm-Message-State: AOJu0Yy3jPNtPDDMEDKjTLCzgy5DW7aiKr6qHz8R6GmGJFaveICVJ2cF
 Z6k21X4Ukn750OKJcog4qAC1EVgKUn2a0Bc1diyf+SlkjKW9h1E1xQIxN1Et9FqRyltSGye1EZt
 ZEm2b
X-Gm-Gg: AeBDievoCa95HJNJtZUAeJv3M089728wM3wGbMBHwhH0khkP7Y0669HseiLRninKoEY
 5JxXCuWfVpKD1KLCci5D4g6DY/BGKfu3WOcD+JAfZUsgKjMffrNqw1tr1OSmtMOwga2NapyFFvE
 a6ftu6P3TGgtzrT7l6oSRjBDnS6HoKEWsvOW44UfyFiYanLnGzU+1PBOh0R7axoT0xF60tTYhzi
 6QxRw3pF7sN1ynq5PpYf/O/YGbXJOEwMPTtBD/oTrOStUmr+SBJatO9t+nPwoQL1262JIuHuU8h
 c0dfBOCnFt8VFVCD52dnZFHOklNCuMAtAKw/n0qeygmbej2iwCgTj8lVYNF3ABk69rheSufjqYO
 wicPkuI4ynAQ/ayCc6sgZVASxVrytFQBYwgmctPDNDhR+w5NsiHPGgYnLz89Il/OPGGx8pd9oa4
 0wS9+euhsNDuEaIozMNwHS4ZQbSWcOIIDN2HTqZrfuzLJDjYYgLeZ7qfSjp+7YwFTzUMqXcGoLB
 WLRvB/EjpPiMIytE4yFvBWwtUGdZzkzv+u43GvJSA==
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488fb744fbemr373926915e9.7.1776938601088; 
 Thu, 23 Apr 2026 03:03:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/59] MAINTAINERS: Remove Aarushi Mehta
Date: Thu, 23 Apr 2026 11:02:16 +0100
Message-ID: <20260423100229.2941820-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Aarushi Mehta has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-16-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48bfa032e3..75cc6704f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4321,7 +4321,6 @@ F: block/file-win32.c
 F: block/win32-aio.c
 
 Linux io_uring
-M: Aarushi Mehta <mehta.aaru20@gmail.com>
 M: Julia Suvorova <jusual@redhat.com>
 M: Stefan Hajnoczi <stefanha@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E962CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv88-0003Mg-CD; Mon, 18 May 2026 06:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7i-0003GQ-8S
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7g-0004f2-TF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso9437075e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099773; x=1779704573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7xLReZYo6pwF56dk5clIQgRyvBII7+DVpu/38LqFDU=;
 b=u+2Zo2z+UdlY0B0eyLPkFDAhyuaYryAKiXigfF4R1gQSYrSlnannsBtCNDSGp4TFtZ
 vlsZbY6I2xOZgVv+Ff+tGwTreCaq+Un6//8w10L6PaxQkQqFwJZasIJzNT2A0tGD7e/9
 iFsu98ccdUf8MxOgA6D+2KwdEET/EA2YGcd8DOodvzQuWAT2caT52PnqS+3EJ9Gu3Fja
 T1ZfezL+ffUi7OCEG3Auoe+18eqNJW4e1YctZA25PL7PbuFv28IONdu6fzevhAJ4TGM6
 Tcp/I7sQGOj2o6sgqRQyu/F7WkgL3ulxNlAnQqw3YzkQ4Rx410xC5fNwi6Hmtesjk7iS
 ldjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099773; x=1779704573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7xLReZYo6pwF56dk5clIQgRyvBII7+DVpu/38LqFDU=;
 b=QWFiSuYBJiDGaqJnuQtFV02858nAwzYu3VejkL1xt01ulzOGYBzFhLcSQ7jBy2cTmO
 8PXTQVsRzX9KJoUd7xDUAb7OamdMM+kLwYe0g21g9ENrzoOzD+bipRxrYI8Zzsr3Btx1
 Y5rj2WTAKE2B/rw6mQMMnPJ+ALddkvtivWE1kFoLjXeZmfFgfRDrRlRQq1zlJTXIkdHG
 mITpjtbcoiud7OvG9Z8qCPvuTdAwooBLAl59GEkNURxu3/MLYuDXJU6yledisoKS6rWs
 M968R5mofHWflqwfLzUnHE66sSBcXMR8JyOwz24KNbtELW/7sYSHw2msMu83yoHtG5id
 UCQQ==
X-Gm-Message-State: AOJu0YwtLugrn/G2j1ChhnWEW7Ym7HpT02CJ2Q4ZcCnvzyt9N9JiyzhX
 BuGHHE6zy3vWxe5EQFiPOz1yTWID4P2YVANya/zUdovRnIAGktioVS9Vjb/Csp2pD+NSiU8/vjG
 wY8KSF5Q=
X-Gm-Gg: Acq92OG3HwUxgISgzheHDHJV5U38LVWxH6Fu8ZvBLtWIu+QbP842HBWlpEhJIMKGUiA
 kT7joGGeFGmeaUwnrtc9Cm7/jAb8q5F8FP46OV3VAUylV2VlhFfFf/cSNawfbb7nmnYW9z8o0rR
 yINvFuNjJAGryfmVUsblOKqIRDGRR1zFCsLyXwYp6yXj3c0jSkVEbUGigupPDHIHQCBewo7jQQT
 VHb6oa/ees5OZDyAFWssxhNJRlqE5HpV0S84WUy4P0iUxada0bqEfs0UACJE3lwsUPMBa6aVz6+
 DibX9VFce8P1FMiiRN2CxpwsD7shT3ZXFxX8zH+Qbc0ILjiCGk6N4uRbjhG0uiUNisOaUQSvG9L
 JKRb4xRqTi3Gz7O32lRHTKgNdVnnbXjmn+NXtfkkgEZsbWxDRliUYzM8R8kY8TVvY/BBAeUN9wM
 mwr01GUhtQJmJqGicz9C0y0g8SNhejoE0ajVee/OAMUwRsBPPI3si7ouNlhDcSmR6EdOfRAsaO
X-Received: by 2002:a05:600c:1d99:b0:488:c078:bfda with SMTP id
 5b1f17b1804b1-48fe631389bmr204591735e9.26.1779099772976; 
 Mon, 18 May 2026 03:22:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5e9d5d9sm284518705e9.15.2026.05.18.03.22.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] MAINTAINERS: Cover debian-tricore-cross.docker with
 TriCore section
Date: Mon, 18 May 2026 12:22:19 +0200
Message-ID: <20260518102222.80735-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f900123ce6..b15cc796a97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -458,6 +458,7 @@ S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
+F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
-- 
2.53.0



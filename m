Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E590EA811C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAB-0001zz-6o; Tue, 10 Feb 2026 08:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA1-0001vw-GL
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpo9z-0006JI-Ry
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so9780955e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731530; x=1771336330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kRnQjA9jSF81pcrYcyyCazxZX5v6kwI9Yceq4/A0UbA=;
 b=mFU8Hhplivkc0cojLcWM+36U0mikYcT2SpZKZ58LYz6eHtyVKPyWotI/aCJQYGdivJ
 mVHORUmu7p6cq031DccXqR2OgGjlVt/wrv3FDORj4ZJ8gBIsmMU5XhwtHxQOyrPWpv85
 u4F8iD6V5Aa0DbFmKmNROszhgXkb9o5CqaP/10VEunOg25OoxeDE3kau24RWbS2IUENj
 MBERhJAo8aW7Ciz7vVAAsUeg6rZ9T7OnuHfkbsLlrc54IojgAT1mvA/M+R+a8+8Z5mC7
 xde0ki41yRtbuRBvAjDYrYIKKEe3LgEzF0XhuDsOxJdz/BwF5Uv+O7SHCag/kdpIkIZw
 nxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731530; x=1771336330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kRnQjA9jSF81pcrYcyyCazxZX5v6kwI9Yceq4/A0UbA=;
 b=RtzPu5PxCPdoQuui6jNc4Zvu/AU5Cp/JAnMPZ7eCgnMAgS0/7IYsLyaqnb36msS1fs
 1/cBmOLeIYZ5dM5b1Cul+n5xiwRgd027/dT2Ktu62s9vHz+xR+gvpWxTUXSgQ9rFyss1
 8bZFZ8rU6PKA7aiQU/Nf26E+CHSmucs2c1+xX9N9luMyuvHFO/yTVo7ZlTFG07TvAUFG
 tsXq9bmnjK8pp6hiG2PbGFj4UbLnqj9eG1oHk06/81jlQ3FEFmZNSElWJUFbPhEbfyMM
 /EgxoljMWeTgO1XyA3C+l188EC/gkHuO/LeBebOP3SJMqG1g100N9sm8dx1T+4iOnF8H
 uRRw==
X-Gm-Message-State: AOJu0YzocIDuPV8aJFtTk0WjCT/QPmNy1JLO3RqIFs0F5DP5rNa0yIRL
 XkPhJqR94iBEofP0LN/dwE4adkoPzIAxAHWQrD3t84ZC9xi/ZCwSvvKzm3/OOUbUVq2WtEfqtlN
 tG4Cz
X-Gm-Gg: AZuq6aL34YaLxTNNTrKXn+QFBKMaYqHIJtajEjXsy8m2ab2kryH3r0FsH6Wf9wgZikO
 WTKJkJiw2Clgod3je5XHj3qBAtRoY+5x06ggAFT/EPfnhyO4Q7UKD9N6OI5iMxHGrP+egpTLjGY
 x1kIv44IN/ERMWtmh6TwPL3ehheWndvaYfiiGbX9MO1StObT330wBXpXREEYItcDv2sGwXwT95h
 2kNT+Z9pJyQX69qMwOAwuQ1sPNbYjbzKdAqSFiany+67KSxCfwqocaO/WByUhc7Px9qj8GSqSlP
 3uDBkOXZT04Wq8nNkeuHSsh3pquW/v9x7rC0/1t0mtQODKEUDf9a7W+dWuWPMARLz6G8MG/7pK9
 NKMW0cHZF0PRE7khByP00sAbXDlv39c1IzggeyQmjNjX6WTtKwTAKHkfEN3MAUWVbeZT6/tGuFy
 qI0rnCBDVTw5bZlUGpaa1dHoAHQOt1ZhHVNIWt9artfNgiSTLn9ENaQI2uhJz9yUkkKh9OAkS5K
 dSHZylwto6Vm5+E3JLLBb4jfGV1FdQ=
X-Received: by 2002:a05:600c:3f08:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-483201dd06bmr224740775e9.6.1770731530369; 
 Tue, 10 Feb 2026 05:52:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] qtest: hw/arm: virt: skip ACPI test for IORT with GICv2
Date: Tue, 10 Feb 2026 13:51:43 +0000
Message-ID: <20260210135206.229528-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..7acaf464dd 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-- 
2.43.0



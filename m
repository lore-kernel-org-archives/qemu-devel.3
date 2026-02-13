Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F782EDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvPt-0001u4-1P; Fri, 13 Feb 2026 10:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPo-0001qi-R3
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:08 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vqvPl-0007ws-Nu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:49:08 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8860d6251bso133660766b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770997744; x=1771602544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24mz/v1MryEIxNWCR/SjfC1f2r6mmgOqZAjVK6z4IWw=;
 b=TOJt8/MynDP/hOiKooIplh2YrgHBPChrSX40y6HM6gV7BQNe8b5VpVcSiPP5cbG147
 /DO+PzxPEc2EWcXVkex//oOWAehZrOGJluUlLazdmdziasXI6cHqWvo5E7LI9iSnGNt0
 xNo2Wubhc0exSCmLJvfTdAZy9MHayj90ippWuDT/3C9OIwQ96ilZpuMyse8yxD+C65OX
 3bBGqQUg4akgg4fA+WovC2+fAjhhUIZ6zWWbdnHnycWTKE8+Toq+976VHUXMiP6HQfvc
 4yoiyM/uiKvHn353utIgxFrSZiNSA/Z4cXqcDdtUJ1wG6DqD58Ga7Ff9hnkuvrARvKBb
 sW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770997744; x=1771602544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24mz/v1MryEIxNWCR/SjfC1f2r6mmgOqZAjVK6z4IWw=;
 b=m0+a0A6IvXyIEGlOc0kL43p40yq48I3jIkAcBnRd6jRBoRBwKdY602fadLH4VuJ2Ak
 zviFRtuFR/R/dLWE/HlATGUPaPUqlgBPunOHdHfH9TzrOytdsrZgjqJwcDzQUcfT4/Si
 S0snHN2Q8Vg0U2aFw7tyPttqPnAclkj9OSl3k4FxScW0xPnM9CIcImtX8nx69KHT1lE2
 AZD4uh1ITVqj/gKSJ2f4zBWsgPV3/gyQgyOZVOrpCzsua2KakV64dEfAh+75m/3eZnQp
 HEQVQAyauqy4xxJH5foZDNjYtWjXTY9IlVzCPz/ncRMdTMym3Y0EStDpXVAEVOXofe7i
 chjQ==
X-Gm-Message-State: AOJu0Yydk8AvfoVo+spr4fYZBIsNLjK7GtDO6jnBTffpsYh7R6l+oJ1P
 4m1M0IvGls9xNQLRd5pklQ9RL9D35yDa+xTPGGQlA6j+MzNxU4RmUT1GihE/vflwOSI=
X-Gm-Gg: AZuq6aJwKqpuvY2nGXg6VVeGe5ubq0r8imah9nStguJIVRKgI8dz8vb9WZ7Anw4gMkR
 5zUgNK6Gy9guxGbidH96s6vWunFutHXql//ZM28g2wsQ7xtL03n7hVhXUsUJkUCl66jA5P6BHLB
 F4/uhubqbAv8ExJJivJdbkDJS3ZKT/tPN0IWWFHyUvuuEn+NTPDNONzZFGpEjK3VKj9YeucAz6K
 a/V9blBqDjE4bSGgaNvp/XvES4ta2t0xnlCVIEpb9IJaG9J3gMw5u3RdpujrB6pW1YiyQF2X9vh
 Vx6MwFvwBtiwdYSZe7SSkeyBAIe7geH0uG59g/IzPPGJ2yOYjx2lIuQRtzEDJYbKoakXLHHs/HF
 q/LQSj7jXq/Ncf6Y3NXgyVAV98MqOqX9yxW9uCUG3VzBnTmV3WcGJJDyqIE32qmFdrX/L99bCWE
 OICCVQRzuYHZPF4NHmn/agMKw=
X-Received: by 2002:a17:907:720f:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b8fb42258eamr124000566b.24.1770997744267; 
 Fri, 13 Feb 2026 07:49:04 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fbe2dd709sm24104266b.36.2026.02.13.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 07:49:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26A7B5FC7A;
 Fri, 13 Feb 2026 15:49:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 3/6] tests/vm: remove unused import
Date: Fri, 13 Feb 2026 15:48:56 +0000
Message-ID: <20260213154859.1551283-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213154859.1551283-1-alex.bennee@linaro.org>
References: <20260213154859.1551283-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/openbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 88b31dd9b59..52565208965 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -14,7 +14,6 @@
 
 import os
 import sys
-import socket
 import subprocess
 import basevm
 
-- 
2.47.3



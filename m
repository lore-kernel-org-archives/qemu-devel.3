Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF20DECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzPi-0004Cl-IA; Tue, 10 Sep 2024 07:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPP-00044S-Uj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:51:51 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPM-0006Wj-IH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:51:46 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so77327466b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969102; x=1726573902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXVRH9YeP0ZiPm2lygL9nbSRmpHSfMI7+KyJVmSsa5o=;
 b=k20B9Ic2+PjXDq9gym96FkYd0llwBrvuVlwCBjcW6xIKhiaaJs2jLNWeqO9hGouCHb
 V8cD1gvRTAChtr1p0sqyBER4Hdmnx2e5SuUHSi6YV2jrGie3sLEZN4PlErIuXjZPU/9A
 pUYnT/zZS09mDwnkRLmyh8p+EXTJDWicvHLMy6BsmeAfn/V4r5CZ2L+QFhoqrgNCHNg+
 5lAxypdrqA8WZ+AZcsEwE35xqwUvFvaSQf8sBd1wyqv+4/qawwPYczvXbMP+nzja0I5S
 UuMPc1IwFpICYfnif+ru6i3BgSpa9OmvZjG5HZgDlcJ94PCWVmOXOSDAac0Wz7otC7IY
 OQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969102; x=1726573902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXVRH9YeP0ZiPm2lygL9nbSRmpHSfMI7+KyJVmSsa5o=;
 b=PZ3YArHfGaiLM+9asq3Ke+4BI25pUwVXJCtZaT2TsKID/hfJqJPrJu23JvbOVnVHpH
 vqGzQ5HZYMrtMRSGNaPWvJjxyvjIQj6DG2V/PFDriWUYywDVfhsO8smI7FJjL54GkiNV
 V4klB9wMBLvU9kOsxurf2UzFAYCyH/Fw/xB5HuMpr2jdC37LBsC+wKr+WIr0TprsmoTS
 BtPzjMp3agHNdWSdLwjZxAkrLFud7oCTsAAqIjX+wspJTwD+vu2TJAB+sf4hr6V28svr
 2JjlutppqXyxLcVUfkjRH03hrsw3xrKEG7JVSAEr/OrByJa+IVJnaYk5ylCyZj9qknmn
 fgmA==
X-Gm-Message-State: AOJu0Yw53dKMMnhu2SX7fGi79M/ORkFfgUoNtmFfu2hkYM0E5e/JLH+w
 ByCajUoCSk/ZyX5jNF+Wn6X4O9aBiGFi4YIwRrezGCfayRI4fFJt7l2w4Ri2OnuMV2ZKVRQk/pC
 M
X-Google-Smtp-Source: AGHT+IHANiqzoDhLHXkZ+7YDJTBf9QB5nv+4ZFl+FghKC5mMc1hNExSS+O15VQg1lfHahdvDTYlmIw==
X-Received: by 2002:a17:906:f5a4:b0:a7a:9ca6:528 with SMTP id
 a640c23a62f3a-a8ffaaad1d0mr44706766b.11.1725969101866; 
 Tue, 10 Sep 2024 04:51:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25950cdcsm474155966b.58.2024.09.10.04.51.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:51:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] NSIS: Simplify license description
Date: Tue, 10 Sep 2024 13:51:27 +0200
Message-ID: <20240910115131.28766-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910115131.28766-1-philmd@linaro.org>
References: <20240910115131.28766-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since the "2 | 3+" expression can be simplified as "2+",
it is pointless to mention the GPLv3 license.

Add the corresponding SPDX identifier to remove all doubt.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu.nsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu.nsi b/qemu.nsi
index 564d617d11..b186f223e1 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -7,7 +7,7 @@
 ; This program is free software: you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
 ; the Free Software Foundation, either version 2 of the License, or
-; (at your option) version 3 or any later version.
+; (at your option) any later version.
 ;
 ; This program is distributed in the hope that it will be useful,
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -16,6 +16,8 @@
 ;
 ; You should have received a copy of the GNU General Public License
 ; along with this program.  If not, see <http://www.gnu.org/licenses/>.
+;
+; SPDX-License-Identifier: GPL-2.0-or-later
 
 ; NSIS_WIN32_MAKENSIS
 
-- 
2.45.2



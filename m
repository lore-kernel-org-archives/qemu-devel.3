Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E63C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUS-00083e-7I; Fri, 08 Mar 2024 10:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUO-0007jt-Dy
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUK-0004U9-99
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so1556887f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913022; x=1710517822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xCyKHrVDgE4duKvrjOPXtlhJ/eSl12oKbAB88FqLRxs=;
 b=n2py2XLKL48r2h1l8Tg05eE8L0IzMaRqDsuVCVYHXPzavLiT23/xnrJAogNT2Kvm6p
 VkqeXmloPgpXdeTmJ4tsMc+8mQqSofiH7clZpj1ORqEm2P3qhlpIRiwkW1sW0Twt/qqD
 uaI8TncLEWTZy9zb/GQzOoqspJIvcCs/PmOokZN3ST/y0UOLKZySRSkJSE/VxRfiNW45
 o7MM0bjwPTeSQC28sso38hBzJeu2hhONengimG5ItbfPPbW+xnU/mBosD8iTk0qTHVcI
 p1yk5kj7PRxSaiHqKizV8Vf6+yVrZG2Cn1AIAMZ4E0JIDjFce6YDih7pzSl2ILrVVJTi
 tYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913022; x=1710517822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCyKHrVDgE4duKvrjOPXtlhJ/eSl12oKbAB88FqLRxs=;
 b=UI/WDX2h5A4tEHRu/ztqOMhU2Wu3OwftSsI73pwmJARp2jnt9C/+MLWDdUj2tqE+0e
 HLz2eYIruKBCkWunscrC6IAxGPMwEORS7YVkYa4NzLDChzpHkJ6Vr4CCadCm8PZDEGs4
 r/ssQe34OhC/QU5/2kh9ZSFdfUriUvH0N+LJdnVZa2GlOp9rBXR5J6tknz6u71Lf2BXl
 Viv1isYHdoCvZRFGdEDBt1GAJKue8+QHh2QGPVKVBYtgmU8HBZbpEv/q3IoAggzgWwS2
 XodgYMXRe2XfEK0SNxPgMI6juM9qgfDIB5gJFiZJcwOqzjieJh3JdBcPf/o+eK4Wp8PN
 4hFw==
X-Gm-Message-State: AOJu0YwE0p+wVhf7Kg5cZJ41PoDALURRA88nduaUMpyV3Hb/XEpX0cY+
 w8igiyKk4XUgGzoP46p5Y9zK60ePGR0RsJ9NNsxkfaYUx9XoF0GyGVOfrCg2P9+OvMfB6ZXGdN6
 Q
X-Google-Smtp-Source: AGHT+IEfkfBvQVWMgt8dCRSYT3dMtqU1gLjEAWOhwGXdkleyti3FAxugEJ1k4NZ1OYfbT2lvikohUg==
X-Received: by 2002:a5d:5a03:0:b0:33e:737c:792a with SMTP id
 bq3-20020a5d5a03000000b0033e737c792amr3943479wrb.68.1709913022592; 
 Fri, 08 Mar 2024 07:50:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
Date: Fri,  8 Mar 2024 15:50:14 +0000
Message-Id: <20240308155015.3637663-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
was unfortunately added with a license of GPL-v3-or-later, which is
not compatible with other QEMU code which has a GPL-v2-only license.

Relicense the code in the .c and the .h file to GPL-v2-or-later,
to make it compatible with the rest of QEMU.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini (for Red Hat) <pbonzini@redhat.com>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240223161300.938542-1-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/rtc/sun4v-rtc.h | 2 +-
 hw/rtc/sun4v-rtc.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
index fc54dfcba47..26a9eb61967 100644
--- a/include/hw/rtc/sun4v-rtc.h
+++ b/include/hw/rtc/sun4v-rtc.h
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2016 Artyom Tarasenko
  *
- * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
  * version.
  */
 
diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
index e037acd1b56..ffcc0aa25d9 100644
--- a/hw/rtc/sun4v-rtc.c
+++ b/hw/rtc/sun4v-rtc.c
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2016 Artyom Tarasenko
  *
- * This code is licensed under the GNU GPL v3 or (at your option) any later
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
  * version.
  */
 
-- 
2.34.1



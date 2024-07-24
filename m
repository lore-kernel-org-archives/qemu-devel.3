Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF32C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8N-0002L7-Kr; Wed, 24 Jul 2024 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8H-0001h6-07
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:49 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8F-0006fQ-Ai
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:48 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-816b627a7b6so11563439f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858806; x=1722463606;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYJVjZqOXEiJ+YQNx+XkrkSOeWdwAX68dW81gy1dzYg=;
 b=p5CmUrShRpFYoxMZRHsdg0U8AowhqNCq1m0f+xYJ+98p2GFKV4fs1feTeCjknjVeIY
 r/PtaV1dHDFhFs8dx/6FV3I5X6djjR2HaW1kjBtwrKP9mkIfCRhe2/YHK4b1gI5cZ4xF
 5+b1NI9+UTB1C3DBkv/B2IwDMw8SzGzNS0gBk0lKSAlIWIu/FxmQQ8HK9dHmziG/UnEW
 4QxbNP9MSixln5PolTTfMrDdcyO/EHCgWa36y587QT5hVZX9Y9oTsY8AP7POvUbikj79
 TsTqMRfwtPrmxcUirdzfSD5Rrr2KOI5Kk6UipEBXhyfZ0DDCeLQFb+QR+JIcWzcq4gRj
 /1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858806; x=1722463606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYJVjZqOXEiJ+YQNx+XkrkSOeWdwAX68dW81gy1dzYg=;
 b=Nq5/m9wEU5Fjhg3xXXQoYgpkJqGLXWcjhpBQ/972myhW2v89rt2obA5YYEITl6rbjw
 mvXDFxCsiyAyDVsy/jYK0yHG0FgU/2jYuUb8hplD8RuwJZoELZAplUNL9ELsudczzRPu
 d+nGPWqwDwpCPol4EDW1zwNltj4cFBSe+51nPhkKRp9xGjse1gPR/wkuAG70aIzqpoTu
 nUj/LVmfUf6n8NJZV7czQXd7TPwYLbrYZlNWevZMVuh2X3s1s4D6z28KqHIqV4PToUCT
 ir6oiuRj7hz529O3dgCCvNnF3kpOvP6CwU+ezHdiZBczFZ04Smt0D7JBR0aOIR5cYfWQ
 /H1g==
X-Gm-Message-State: AOJu0YxvFRl8Z9TpNSdPwW5kE1pYTdos5Jyt9WE+0pB4Z8yiX7gykLtN
 9Nst0St5bVQK47XEk1rvy26XhDLNHBMepa4lx8Bi4A7QTDr87jBGlr8Dcj13ylxQYwWGrP7Pcqz
 98pQ=
X-Google-Smtp-Source: AGHT+IF1fs6xm7NZeRcOfJN8VAgGfFJDqOkSx5P+hYIzovJkARiaW7A6EHwSUZmwMg6OSd/ETYikCQ==
X-Received: by 2002:a05:6602:27d1:b0:7f7:d2c7:3b7a with SMTP id
 ca18e2360f4ac-81f7e2f0af6mr22411639f.0.1721858805960; 
 Wed, 24 Jul 2024 15:06:45 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
Subject: [PULL 15/15] bsd-user: Add target.h for aarch64.
Date: Wed, 24 Jul 2024 16:04:48 -0600
Message-ID: <20240724220449.10398-16-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

For aarch64, it's a 64-bit API, so there's no pairing of registers for
64-bit values.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/aarch64/target.h

diff --git a/bsd-user/aarch64/target.h b/bsd-user/aarch64/target.h
new file mode 100644
index 00000000000..702aeb7fc57
--- /dev/null
+++ b/bsd-user/aarch64/target.h
@@ -0,0 +1,20 @@
+/*
+ * Aarch64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * aaarch64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.45.1



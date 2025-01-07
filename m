Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1645AE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3zP-0003EA-On; Tue, 07 Jan 2025 02:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV3zN-0003Ds-MY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:26:57 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tV3zM-000851-5L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:26:57 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so17914761a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736234813; x=1736839613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nC/KCyp8gmU+YReTB851uLzl2xRXM3EUGo7qwn0N76o=;
 b=KQ7TkBW29pt40b/SOzzJa5JJOMMoIIn3sNUlcrKcjCTrdvrYqUh3ad4J7zcUvhb6Am
 LIO06cHD+OxLlDcHqMFxrF0SejQrEMpISM+Rfnn8NJvjrUp4XPkGZPRxKTpkKf6uTo0m
 gACO1o2VGgrdIKwkRM74FEfFncgsB8N8xwPoSDxI0TFfi3U0Xsqk8jV0Qr2ARaXITjK4
 rU1uwONVTGGnzUwQB0xPcvQLpTzA/Uzx7h2z9xC6zeuRAnWgrAjCNkJSbtM+dDGyotJr
 2auXb+SPAQbjhNzZni6nCiBUSWUrjl9xSihnVY1v4bxmHX6HmKjT26defUXDE6DFHpBL
 ROMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234813; x=1736839613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nC/KCyp8gmU+YReTB851uLzl2xRXM3EUGo7qwn0N76o=;
 b=BRwW5KHPHuQfkm+ZwtnMYLQiN1pPbPdVqTKTvo4uMuIaraILJqz9T3+KR17TX5FvFP
 qAl/5br8wfkNmdmPFrlbDqp+2ikaGVIgHr4SE7v/rBC+/ZRQeJVSYyB0JZyhuTJAC5El
 60q+Jpx8FP7rIuU0Lt/nz8AT5PZ7wVJWRfhwERPAp2Nda1HplDQF9lbztvgwr7Enhld9
 66Smu3Qr3LzpJ9H1jZabXKy+1JiDIEJJ7fTholO66dHBIm/IildQB8JIB35YrJsSGmuV
 0AgyMAiYGSknpaPpeJr7YEhz3E6gSTIlVdO5+n7I9OExtVrjkWEWkltuAiadBbJXib5n
 0uzw==
X-Gm-Message-State: AOJu0YwAWTt+0u5vs8qyc9p20d/Q+EHsJFslEYGO4Np4UwXGyxpTeMl9
 kjGwfMcWYcKNeRoM1reg9qFCbP5woPg0lIO7mIVQr+l71sPLgmGK/lxqsA==
X-Gm-Gg: ASbGncvoo7sIKF4ry3Ne177+tg7X/7Ge7CFF1MkrrwGYq8qVm1jbGjhY/1XiT8KEe6f
 GX4U9C91X2c52knY0YicaGdbb2V9989U0CfbC78TVQoiUhfGgpdOe2upKC9NQvR4/MEQNl3evlq
 hYc9yNZA9iuSbq15n8eiltq9r5tKQwkbvordNv74T7HPjJ0R28rh2o61Zv8jqmc5u10rxAvfrH0
 m2NZFKvwCp7mcbu/u+zlGdvPLPyyyJn4QV7Eg4PlZ39T3bk5JJaSPRkX6GyTsk=
X-Google-Smtp-Source: AGHT+IFuTEa6zUNtA1zEObgQSXgultNEbbY9U++pe0R8KsSLMZsnkma3JLzjZhjtTBiEG+eCxamADQ==
X-Received: by 2002:a05:6a00:ac5:b0:726:41e:b310 with SMTP id
 d2e1a72fcca58-72abdec84b4mr77849640b3a.12.1736234812957; 
 Mon, 06 Jan 2025 23:26:52 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb851sm32756764b3a.132.2025.01.06.23.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 23:26:52 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com,
	keosung.park@samsung.com
Subject: [PATCH] hw/ufs: Fix legacy single doorbell support bit
Date: Tue,  7 Jan 2025 16:26:42 +0900
Message-ID: <e2b956a9412aedfa72c47a16870f524cffaf3cca.1736234046.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

QEMU UFS has supported both legacy single doorbell and MCQ,
but the LSDBS value was incorrectly set. This change corrects
the LSDBS value to 0.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 8d26d13791..a9b72f324f 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1635,7 +1635,7 @@ static void ufs_init_hc(UfsHc *u)
     cap = FIELD_DP32(cap, CAP, OODDS, 0);
     cap = FIELD_DP32(cap, CAP, UICDMETMS, 0);
     cap = FIELD_DP32(cap, CAP, CS, 0);
-    cap = FIELD_DP32(cap, CAP, LSDBS, 1);
+    cap = FIELD_DP32(cap, CAP, LSDBS, 0);
     cap = FIELD_DP32(cap, CAP, MCQS, u->params.mcq);
     u->reg.cap = cap;
 
-- 
2.43.0



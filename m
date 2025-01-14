Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4050C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfON-0004TH-80; Tue, 14 Jan 2025 06:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNp-0004KW-2x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNm-0006e7-LE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso56142275e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855213; x=1737460013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3xMvlplv8h0TbuE1B73gGvg3VD8+4dGq7BfJmandFw=;
 b=A4uu/dfqi8V1ERLh3b1R/rmsSr10AmVYvcVnUOoRdnEh15E1qs6h1s1MqMDErnPUKL
 VP91DOX2khFJ4jnja+149/85r4TIHXgeKpJ6dani6kvH5chIBUzLFyy81hss16gqqE0h
 DhXR5qmN2jtgHMGcFXl9tvMLuAMtU46YA56eyA78v6MM2IkZnQA8odZg7y3ylW3pVvHv
 ru77YmzdxpMzog0vnL7pdSzC4j02mDy4dEAahjS8PblWVBAjU6Tg+0LuV4Oj6v+Jw90O
 QJVICYk7zVeRj53b4se0WPhj2L6EtDVCgF9kLGVyb9xn3dtOqqzWkM9Iz1yFEwUQsa86
 utHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855213; x=1737460013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3xMvlplv8h0TbuE1B73gGvg3VD8+4dGq7BfJmandFw=;
 b=dmNFNRaGxhtu3dnCAuDfdgWMahd7WjVUPBWKY+ODZjaeBY8n3NI4nhO1DBmvRO0dcq
 duIeBLieIuEHrfZ6loLTN/HQirFCTi/468QBYNkFpQ4bxK4yku+YOJGIvHgWc0AgL/tA
 ekFLHlaFM29PXsucR0UnC7U7sRJRkOXU8c0RpYT0HDzleX5J2twjwfX2EvT1XZAfP2Dn
 54hCB92opZ1a/95tCqoQQWSwn7IxejrIIOLoykuG+Qg7jo2NYWxLjMn/wirKZMsX61gT
 YFiJ0rkfF2YK+EVZPLezt5MwD4Wyp7HUXwudIdeQVaMRTSkTFBq5Ycu96n6FN52j5JOK
 hKWA==
X-Gm-Message-State: AOJu0Yzeulv+f2ZFsj0p7BPSlkAuuDpVhHWsTnLNverUjI3WYLRO2crb
 mmknm3v2LWq8+CCfXKn6h+0eORUJ9ePsWMEcGUStUZZUcizpljsguyB7CdgLY1A=
X-Gm-Gg: ASbGncsGr1vnZUZblEU41JbYbureMfOHqFqYymTdTEkgcTaGF9wIQ6DU9W9PZAVZ9ih
 hyiCj6db1gYXCQ3JmTrfWADUu+SwSOv4FzSMhSxIBubU9Ja01B607lCwH1qqzOYR/4BT4MrcWra
 1ezFfeTflkcc1g93pMiixrruz59BqZKO3BonL9uFYI+Px7TJU6JlxY58k63aedXovLwSmlBku2O
 pjD5SRd31baLBzRpPdWcDQNu8Ho+VAI92bmBajUyDWXkfXnI00DUWA=
X-Google-Smtp-Source: AGHT+IFUT3M+mz7Xqr2YlxuoBSz2zgfUGCAKLX9oWysfJ5zEtul0hLok4fZKDOSO4VW+UJH2qvn2TA==
X-Received: by 2002:a5d:59ab:0:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-38a8733bf6dmr22328840f8f.53.1736855213325; 
 Tue, 14 Jan 2025 03:46:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm14902010f8f.52.2025.01.14.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B60AE5FBCE;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 31/37] docs/sphinx: include kernel-doc script as a
 dependency
Date: Tue, 14 Jan 2025 11:38:15 +0000
Message-Id: <20250114113821.768750-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

When we update the script we should rebuild the docs. Otherwise
breaking changes made to the kdoc script don't become apparent until
later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/sphinx/depfile.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index e74be6af98..d3c774d28b 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -31,6 +31,9 @@ def get_infiles(env):
         for path in Path(static_path).rglob('*'):
             yield str(path)
 
+    # also include kdoc script
+    yield str(env.config.kerneldoc_bin[1])
+
 
 def write_depfile(app, exception):
     if exception:
-- 
2.39.5



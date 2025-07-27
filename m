Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D954AC87FD1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpV-0003Ln-UA; Sun, 27 Jul 2025 04:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoo-0001qS-KB
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:18 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwol-0000DG-5h
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:18 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae9be1697easo818515366b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605187; x=1754209987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8cNDP0uMMXLsCPUuS+qFgEBBy2TpFu7q/ONUBOGyD0=;
 b=ZAwjV/V3XP7S4fuqJoF1tgIZ6zc1wu3COAnT33t5+Xwv+9rr1reP3kg6q3yAwyp1sl
 hDpKpWxIwf3mLwzGBmCGdLeECf49EwP3Ks6NPXTuzJaiEEwEw5utA2qrgvZMZ4yqzdkR
 Y0V0E34TVfq/TWSWySeKPSdxzd0wk9Mpgn1ewHdW4wJJe4+91HCtJBVV9Vwbt3Ha0UNe
 xi77l18GurGVDtnstdZGl7AfzLIRLCP8czYu3YYQNuLOSQ+fIrgFpE9BjX97KyGV7QLO
 B0Bu/sR25+k8MNoxHYuMY6V1WZ+gSiQyrrtUj2M3LUU2RTgjZMG9hnj9mKUqm7DmmraV
 77rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605187; x=1754209987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8cNDP0uMMXLsCPUuS+qFgEBBy2TpFu7q/ONUBOGyD0=;
 b=MNSVtAYr369kge9jR6dLNCfxoNiqludDdS0wjALNgq8MI7DvHtE0ki8cI/Ryy9gFdM
 gCkcYOQvDj8vCjSKSUgsR+vU0ssLWGGh2Df1Lf7BiSQvqyQA6z//TtQTZ/pnyk70zSII
 Pgqn8dnccFXd9NXaLv1sQ+J6EXwTXdPYkRBWdbTNyCMGKPUqzx9dO9Vnat8kSozIqOmF
 8jMhL1yMAxtJOneFeO9jYlBpQT9XgraL4s8J09JfPB1DtZ93jpV6ifzTOGT9s8cR+Qu5
 9WsXxl0Jivi15Kagd7knWUQJA2+GOha8BrEwpMRhbq8ijPimieWYM+N1/Uh5fTQ3JL1S
 B4Mw==
X-Gm-Message-State: AOJu0YyNQPMekaC2u4KtWCagRwqsZ8+8fv1ObIXL+S+7SCdOIw8E1KCL
 ZUwx0EsNjAgTuyn2ZjU2ZfH6XcMwriTGRn2lStMwQ4typ6U+4P9fSLS1XBvuEXiS4Sk=
X-Gm-Gg: ASbGncvTx2HDOcJ4jSEUP524SEPX74Uk+zi1ZzddZGNQ9T10E8j0wMdlenPt908Obtm
 5d8dUnTDVC/7vhnWOtIfBooKg0MtPBcLX9JE3Xu5C/GEuof/6NBbrnXRrn/aJE0w0la99XZp9fM
 Pws5RvLxsiN8l4sahQOdgaloMzzlNAuryg2598z7FH0/yBUEhSA97CrtnAV1rxibqYKXkcicE7U
 yGPGthYpru8eJW1en3HPgjej0tyaLylxOHRojN0fwBPQdY6/XgtOTw9lYOZC99r267zfc8OjxZ8
 dfUtvJfB/a94FDyAsPbYHaercpVV/gkqRQNVWeopr1jLhp5g/6zc+0KxvzooZLuja2GzUFaCVMr
 R5ayUFuQAaCS8mM5KokZqG+A=
X-Google-Smtp-Source: AGHT+IEVddTEBE48JQk0kxFwpWsZDgjMCrWBKw+6iNCLBAiGzPaTXQuA6xXS37oblJ4TFi6kOXhDwQ==
X-Received: by 2002:a17:907:968e:b0:ae2:3544:8121 with SMTP id
 a640c23a62f3a-af61c8ad26cmr899207966b.9.1753605187216; 
 Sun, 27 Jul 2025 01:33:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635b0317csm248700166b.138.2025.07.27.01.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BB9D5F8F2;
 Sun, 27 Jul 2025 09:32:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/14] tests/docker: add --arch-only to qemu deps for
 all-test-cross
Date: Sun, 27 Jul 2025 09:32:51 +0100
Message-ID: <20250727083254.3826585-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

If we want to build this container on non-x86 systems we might not
have all the cross-compilers needed for the ROM blobs we don't
actually build. Use --arch-only to avoid stalling on these missing
bits.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-13-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 8ab244e018a..5aa43749ebe 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -15,7 +15,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get install -y eatmydata && \
     eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy qemu
+    apt build-dep -yy --arch-only qemu
 
 # Add extra build tools and as many cross compilers as we can for testing
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.47.2



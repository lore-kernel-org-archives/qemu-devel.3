Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CC5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv8D-0003gr-Op; Mon, 18 May 2026 06:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7a-0003DD-Vd
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7Y-0004cp-Fp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so1951804f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099766; x=1779704566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEcf6N1MK4ofOLN9IBTOXBjDN7tY8BSgSiVib0hXDLM=;
 b=Q7Wy9lq1oeCKXxfV3soLFDqAIsuE0OnxcvoZlU4xp/OBfC9IV3W5Y0GEiccqonUnsh
 blqvHavUVktwqZcISUyFENGtYmnZEZ6f4lNaaGi8c1oyHmXNkRwgIlqrRpGKmoC0n4vB
 JvH+0us5y7zPP9vX2wATY/qcg5C56HXMBzHJh9YR4bfFizvmBl0GcNQ9YUmdsd59mTLL
 n42VICLn7cmDQbXMHfapas1qBs02VQxe27r1eV8ukSffrNZ6+YiSwM9DWLvRtxri7eeX
 lkhVG+K7b7pWhSXVuPkJ6w2100Xy3FM5XXvoeL7mi+4ADjt2LKakRsCsyYPtx2p6n1Ln
 HqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099766; x=1779704566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QEcf6N1MK4ofOLN9IBTOXBjDN7tY8BSgSiVib0hXDLM=;
 b=ZpHG4SNchrH3vChVFVdZ08y0Wv0MdbKii6gyps1xmr4mK5XEQvW5s+0NWSCMsYKtxN
 4Octsfw958AMOZ9TGlnrAgh+OOixjWJVgNGp/B9jToTlJsf0YX1lUFO3LudLAI/14qH4
 yha9totJroQccpfCbyUqHzvcY2VpOaH8aaaGdD0ukST9dbR7r78cpAfESHt4olNoj8wN
 J5BqQ8lfTcDGsVd7VhIzi+jxGLO/Lz4XgO4Vk6CJahy57GvGHfM+DwmDzAadl3r48Wqp
 cez/B79CWZw8my4T9B6DEAXU+YQjp6nPhq1WDnuDThHyOvYEAtTYNfj684jBO2QQ2huM
 JRBA==
X-Gm-Message-State: AOJu0YxDJh5a3r1QnkIH86lRMQxVqddHXbXAfhBaevLHIGGhMfCYV9Bj
 8NUAzLBH95t25pgiNjRaSNyE8ftKPDqOqDWpadkCVpeSgR8Ia92HYNzNqrK2pZqA1isjScopjOw
 JscxD4xo=
X-Gm-Gg: Acq92OFhtAnN/QoPKD3eReAP5Kkx7Ts2nvlZjv2N0QpuNSiYL1PtavQupVt42476XmF
 JNIh4XDgkGS5Yb5mLQEz8VdKUWESZuwf/X+4KT3KcafBxfdN+GhAS/b+UcF/RA2Q/QHFlwisIdP
 2AKNZXiSlSPtNumVCIl2qEj0nVg6hBoDQ917n9+BoRLVu+8rZ6lDJissh2mTZ3oq7YzzDriSw01
 pQc9N20DDfQUJuAEyZSSYG59tKGKR4sYrYkJUlI+SR9nMwBhPpOyCCt+1LF5ICQS19IS+QSY5pa
 s1P5iJeM8HGLXVXwyDZ9GBDr5RxKCGkDP9ELCPB4u6uLyHumn3m6KVQ609thfBrBJ7F6l8slHCP
 U1xOtNiv2uEZrlOEdnodxxipY4CUaLiHtMquq+XuwlITfWQ2t9nE840i7e4QuBVMWw0FW+ItACi
 s/zntnaj/vMmBVPSJm5MvmOuZIi04Oz+cBJJecRxW7yO8zreVURiPJITjoUDK9rN/08osFVAJl
X-Received: by 2002:a05:600c:34ca:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48fe60ee4c7mr229850125e9.14.1779099765953; 
 Mon, 18 May 2026 03:22:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feae166dasm90230005e9.9.2026.05.18.03.22.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:45 -0700 (PDT)
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
Subject: [PATCH 3/7] MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa
 section
Date: Mon, 18 May 2026 12:22:18 +0200
Message-ID: <20260518102222.80735-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17ceb0db349..3f900123ce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,6 +445,7 @@ W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
+F: tests/docker/dockerfiles/debian-xtensa-cross.docker
 F: tests/functional/xtensa/meson.build
 F: tests/tcg/xtensa/
 F: tests/tcg/xtensaeb/
-- 
2.53.0



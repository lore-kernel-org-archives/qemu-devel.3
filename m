Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61235109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YxT-000761-G6; Tue, 31 Mar 2026 09:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxP-0006wg-Sq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxO-0004Ch-8b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso35627415e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962992; x=1775567792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dti6A/GBxecY/Fd0dBjmfZlMwbqpD79lw/1/GSPDIy4=;
 b=l47NMNLHsRqjujiR12EiHgf9qOKp6ISC0UjmWsGmK6x0eDLuCiFQeuFoZdc3QbqABV
 vYUzwareTUuX0oDcp9yMN1E76lSYmSZxPa5T1B3GiW7qIdfODm1czLIcIB8dl2tUevE/
 xyPFjKU5SWCaeoP0jw3VHzM+Udu10Nf7JlLrpQoop/TMhfnsf8agni1qeLTRWYr09piS
 ColgSy7GSrG9r39CyLuePvFYSMGs1jXB35qqKMD2ZpK9Ih2xShrlpiQ3AMFguVciX9i8
 Kc1mzTPJhCMnP1iraU2+NWh7g/KPFcGulAry1Tu82hK7Az6fR3EUEyFRspVfQpNtbG/G
 yA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962992; x=1775567792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dti6A/GBxecY/Fd0dBjmfZlMwbqpD79lw/1/GSPDIy4=;
 b=VfGda8U/u4PQNDnwSvau7PkhjtzCuqozPxdP2Aff1XVcuYwxmfGGXvbwBBgmxiWave
 dXaNX1jL671Zo50tfPx0elQVb4f8sT8b/04Yv3xo7cbciobU6iD103M9B/qW4BqC0dcT
 Z2pyTe13krq12MjMPLMjtVnB7GiGOWG3lJzr6MeqAbsraXnfx99lOSBtVggYlmEspsn0
 rn7ICB+UGt8bzMCYeSpdWJYizMBGsgX7krcZTJuYwbcJr9UzHzLBjF0yYq4mLXQIfiVR
 qfCJT/+h3QDy69Ij0GnMoRCxJFaF7rw+RqciD5OB8Dop986PD+2oZs0l2seYi0xwDk7Q
 25uQ==
X-Gm-Message-State: AOJu0Yw3vw8Y6Hj3aC1zR/WbLtsqUPqZPDscqdkLkBG6zKNeUX3hqiKP
 O+C0pfv3SNljJs+OAtfBwJlRGUpdMv1nMKjPi6VBj1/ZMYtXtfTpKNx+jlnPUfz0mJbDyDk8yk6
 CjUs+gGI=
X-Gm-Gg: ATEYQzxL915WZMw4nvHc5yGV2YrkeHOQXCJOO3MeiYt1oGJ65tGpbL2YEIAIYdml6Xd
 7mhTVpgNiBoEqxOjYHuPr6o0WAYzRCwRKKE1oI8ab2ftq6re1gBP5fJZj7MRQznD6+iuH2C6Wx1
 DtsHieHPW7C24GG84982fhwIsy64zyMJndZbMKIqV3qqBiJNkQJa76KvWIz0wR6NoMlLqPgJ2gX
 CtAgrwCkjZ54DdGKhjIRONE3EYtnOm4zPocm+IQZ+wf2eiAEopxoc2vmC4+XGAwUVisTpor2VrS
 8VYMkBWX/dCQi8SeqGC7b9+5gWw3nShcW5woRPlBMD2/fxMrKo0MpTjKBpG31WYTQ9hj6QbDzON
 08q9uO/pfSShRLrzb96qW6fM9TXpFLzLMvEwf2lSse5ka0LXJLKd4TOGYz8MA7tbItHwSKzy70a
 hP1YYRwArnECNTF1lEapLYkydzVQEf9VSxXMOTC4sjiiENTCMizDLPRKe8JJTV7U1plqM=
X-Received: by 2002:a05:600d:8:b0:486:fb0b:ad79 with SMTP id
 5b1f17b1804b1-48727f7b951mr237003125e9.20.1774962992375; 
 Tue, 31 Mar 2026 06:16:32 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bc9dcsm25257285e9.6.2026.03.31.06.16.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] hw/pci-host/astro: Update copyright and documentation
 link
Date: Tue, 31 Mar 2026 15:15:11 +0200
Message-ID: <20260331131514.21152-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Helge Deller <deller@gmx.de>

Update the link to the documentation, which was still pointing to the
Wiki page. In the meantime the PA-RISC wiki was converted to a
read-the-docs website.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260330211859.19317-2-deller@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 6cc0b350701..59d8007a1a2 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -3,12 +3,12 @@
  * with Elroy PCI bus (LBA) adapter emulation
  * Found in C3000 and similar machines
  *
- * (C) 2023 by Helge Deller <deller@gmx.de>
+ * (C) 2023-2026 by Helge Deller <deller@gmx.de>
  *
  * This work is licensed under the GNU GPL license version 2 or later.
  *
  * Chip documentation is available at:
- * https://parisc.wiki.kernel.org/index.php/Technical_Documentation
+ * https://parisc.docs.kernel.org/en/latest/technical_documentation.html
  *
  * TODO:
  * - All user-added devices are currently attached to the first
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E3EC54E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VW-0006YM-NC; Tue, 27 Feb 2024 13:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VV-0006Xh-0F
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:49 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VT-0001U9-FV
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:48 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c1af1e8b7eso445288b6e.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059726; x=1709664526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYkpQqoaMHDWxrt9KPP15xrK5H9LSGOtZoW36Ee0L04=;
 b=VA8hDsFtP/U5ZrVOFtU3Ar9rJaOaPmhzPwUj6uOh0SB5bc7mAJN+uFnI0GiTccwyJ+
 mTrwRMP81OXovg9aYIRzXYnbsCZwerjMnyaDXi8X6URpMvgEAYI7znB6oV8brnJWdoWK
 rWtM64LlFJAuM8Cugkhvg6j4XRXLXi3NnqSC8YOdzxP3hgkcCuPhuI3H79Jk5Nobmw0s
 m3osep7lFdJ0eNTsZ9YO/SDtgq/RqrsU/jvWZHeiyrZAl6Ca8vu4JzsOAnm01LiFdDp5
 w7yRLACAqp5G7OedZWCpql1Br9VTY31BHWeofdTS6ZLRgP8x4kP/uSVwqr4zjw1SEse9
 u+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059726; x=1709664526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYkpQqoaMHDWxrt9KPP15xrK5H9LSGOtZoW36Ee0L04=;
 b=Ri5/wioFFVC8qKQ6eF9v5lUZ6s2QR3c4GG0NBse32ufmFYCjOS8I5zTMn4DJorgEdJ
 EtbnMaLRF5WaC3NxV90wrVbfKX64M7Nu0vaS8wABZn2O/3NWNrHdq3mcyoIYKY37gpKD
 R6tDRtJuaHQEQ+jw9ZRBKXy0jQjMtUCNjg2EGjfepSiGRebY2ahfk+hWg15svcLzA7L5
 iPD220KHKaGvXHfQn+R3w4dhEdzNeFhdL3cCkjXPLa28bH1WNs91Ygq6fxUxsKGIr2lS
 3SuloKwbLz7V5NN5bMa9l4t+qLBYV5+E3YaaYktjsjI8JH+7PI8nsNITQeO0jfOZ5aYK
 0RbA==
X-Gm-Message-State: AOJu0YwQs/HIi+oV10yYXGt8qP+rmqOJDj83+83yjitsZIEkbnfv2qNz
 iTP7iIwPacC2d8TjOvTYCvR2hEnzpsqIunbPml5xiXyYfFfD+xt0hpfwM2S0+5cEgWavD8Zah0G
 U
X-Google-Smtp-Source: AGHT+IGbroZPuT2hux0sBwLB5diBCFIKWAkiEFoVPCzX9kQ/QIs+F0lBbebIqJzQswjoifmIiV7/Dg==
X-Received: by 2002:aca:130f:0:b0:3c1:6526:1342 with SMTP id
 e15-20020aca130f000000b003c165261342mr2910324oii.45.1709059726331; 
 Tue, 27 Feb 2024 10:48:46 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 07/14] linux-user/elfload: Truncate core file on open
Date: Tue, 27 Feb 2024 08:48:26 -1000
Message-Id: <20240227184833.193836-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

While we usually create a new corefile, truncate otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 877799e9c7..16dd08a828 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4652,7 +4652,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
     {
         g_autofree char *corefile = core_dump_filename(ts);
-        fd = open(corefile, O_WRONLY | O_CREAT,
+        fd = open(corefile, O_WRONLY | O_CREAT | O_TRUNC,
                   S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
     }
     if (fd < 0) {
-- 
2.34.1



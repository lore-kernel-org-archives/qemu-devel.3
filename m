Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315EBCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXaY-0007r1-OB; Mon, 24 Nov 2025 09:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaW-0007qI-QK
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaU-00033Y-Aj
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:44 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso2511921f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763994640; x=1764599440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Un8pXP5Mxat1+68X7Xih9NDPU83dr95SPuETrl6GXE=;
 b=poTFk0gDB+QSTJIC22BmVtoHDV8/hcL2gnlT7Iz4yJkAaGZ+qlirCT9+VDKfyHM6wX
 KaSOm2++Qypxmwi+FaRnpUmziyBzCfWM1bQikfKPwcx8jZhW7Op9WL/qApP9m+ER9fi+
 G/tYbfu0M5rJccbAeIaYGsHUSjk1baQj8w26EwfEZxivTtIkdQ4nmQPw8TtuwR1bO5Qo
 gtG0h5PGehmEFkXBD3A6Wk+tGSQrF0+yF1f7zvghaCX3tZQpN0FnbLqvX/9muV/mSxDP
 QPBxoXRO7ZOjLtr/D55simyVFbG6MHBrTkylEFrtJI6DhmBEoF+KvTBGnqx7HxuIvAjx
 ppOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994640; x=1764599440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Un8pXP5Mxat1+68X7Xih9NDPU83dr95SPuETrl6GXE=;
 b=rbMHR9IfvHnsoW8O+PQ4UEeMu19uPp5Fgaq7kOsHzeoZTPC/K/aRrRyhs3/a2hrCr1
 NwRBsYvg946RMOpyLIDBlKoWIIc8V5HfOGFj6EXzipFTs7FqQRiiwEuUyZwUhqlLx0r0
 bdIjZYMY7eoKlZqPUoFSxt1j19gbpWhuh+r7ltTlSaO8270LlLiON5hj+vxYzafvMiIh
 HsBdoMEWk+iFhGE0BdxTS9YvT6PdEtJOvIVwLuNg4TOcdzPT+Gv8cKke+Zb78KWS0wRF
 sf0JEZZ45Psf0CBLfp0O5K7XePTE58j+NnF7OtRWWcs/GggOqarqyC03EMtpWFe1smnX
 DI3Q==
X-Gm-Message-State: AOJu0YyRw1nVaN1hGTBdl+1vWNfqhwXjD1VOZUfAExE8mva9gGP9TW8I
 7p94TUkbZKs3f+cK4hJGgxCv2ff+jWQGYzuisodR+QPFHSd/n+/+7m6U7XyXzDDMUdiKkXCaoqt
 EJRgB
X-Gm-Gg: ASbGncuSHzqBdmFsVY+dkP0f/PGvmgI4TKfIbOb4Eyty0YE5Zf/uTWD7YDZ75NpKzFJ
 SpllgyNMA0NRQ3MjB6SYDZDMjLtUqp7tAv6INvdyh8pItJLq6Y0nb6M33PGFIXD4xFFm2MME2uy
 GqxGaLhP/nnVNLe8OgJ9hxc2yeEtdu7ndu9FuLHTMQExkU7X2IHPbz+DmBkhHEplx10BeClhrV3
 /+rhwlpX3PGWiR6PKQeT+1dfn+L76Ft0ieCj2LZBOzYsl3YaRTfBONusJSWuhCO5g0kJb8/PIEM
 ckBQHtMjCZSLkH1XiV0W1HDM/7EroVmAajWPW3i385ZYx5ciz5uHYLWOkbTxuuAOqFqf8GGHE5T
 b2AL9I4jgRfhr57SunNi783MU/9uoyzB+mz4n5KA1O9CfeqHeIhE50m3Y++hrmf/O6givW5bnyW
 R9iQtYbejaCfpp+Oxq
X-Google-Smtp-Source: AGHT+IEB1DBE4ruYjHfF1wO3DLst7jDVDbPi03OiR90eS7o4naxsqFUb2Dfbnz/9cR6yh5q4D9xJFA==
X-Received: by 2002:a05:6000:230b:b0:42b:39ee:288e with SMTP id
 ffacd0b85a97d-42cc1cee3bfmr13197479f8f.13.1763994640371; 
 Mon, 24 Nov 2025 06:30:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm29408930f8f.16.2025.11.24.06.30.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:30:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] hw/display/exynos4210_fimd: Remove duplicated definition
Date: Mon, 24 Nov 2025 14:30:34 +0000
Message-ID: <20251124143036.4113886-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124143036.4113886-1-peter.maydell@linaro.org>
References: <20251124143036.4113886-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

FIMD_VIDWADD0_END is defined twice, keep only one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251121093509.25088-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7c..6b1eb43987c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -131,7 +131,6 @@
 /* Frame buffer address registers */
 #define FIMD_VIDWADD0_START         0x00A0
 #define FIMD_VIDWADD0_END           0x00C4
-#define FIMD_VIDWADD0_END           0x00C4
 #define FIMD_VIDWADD1_START         0x00D0
 #define FIMD_VIDWADD1_END           0x00F4
 #define FIMD_VIDWADD2_START         0x0100
-- 
2.43.0



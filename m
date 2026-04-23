Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8901AF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqui-0008HP-G1; Thu, 23 Apr 2026 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu5-0006Yv-NC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu1-0002KC-2V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso59728085e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938599; x=1777543399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5O50KkeZH/Cg0Cjwa49v6zuMPRfWLVp99KJcSLVDpMw=;
 b=ijLwUuZKhfcQLoEYPEjCTOVQvt/uiWxqO7iNHmm7Fg75LpPs+hp+HiTKyfFo/BwRvc
 Xwt3i9GU1sIdV0KYvbHuzhbYHkY5pduF8W5vB8p5pwBnCFpf6s1d+JBrLMb9bRyNxxHV
 OqrO6DjGc7unJAdOmnE8TNngGIr49JMD2HYMgmeXq341VdoytEJFnRBVwnsM8baUkQOd
 yVKpud5D7/H1h8d6fqlE9nq7wn2DyH8vuKxZAD1ngxBMH3KUSbnum8XdPOJc6DU4l3z4
 9MYvlpd4Td7wHfoX5gz7I8SKKAz0gtNNZfmLdQcxbcpX2XXQNEzOTarPUMmAXZOrWNvo
 rikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938599; x=1777543399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5O50KkeZH/Cg0Cjwa49v6zuMPRfWLVp99KJcSLVDpMw=;
 b=elVXqZZOxT44fb+6MxTzSRGZinOIl/pVmiPGpNGZ0OMLp36rgkoXTrdnFLIvkOqZqr
 Zii0NM0Z8bKoNkw2JdDB8vm+rccb0gqFSQ/YJJuSwXIDkjm4mRrODQUMDQot+w38S4Hg
 VYvTmtr02uz05Uvm6yPUw0g4yUdifNXNQB5bBwC4hfoDONI+2rJPkvnUKUzlwFr0xOa+
 I/WB6lh19Gz0hrfan/26DWig37N2/85UecEAt7wjE8zQ3ABZ10JmTXm3H1Mkb5a6fb0x
 xEG03v1NQpZ/5HNliSjPqbIWBgr4w3PeuI6Sv5gJRXCdNfxof3nP+LaPBY4zwGth4oFC
 e8xw==
X-Gm-Message-State: AOJu0Yzx6NqJCQ8hXhdknHw5yYfkv8Sifwj+Xc4gSWtPstGcypajLGdu
 fvzxnLz4oHqJxbMYmra3vDjhiDNIr9s8387Od8LcKkrcXtGQNaC+XXD4iEMzlBUR/WnLJLiVEXM
 jvylp
X-Gm-Gg: AeBDiet5D2IjDQFEBMU19ukY30sIrj/wIdqIW6trfMJKDAgPBfFtXd2YLwPxNzarVbJ
 rnnqnpvjJPz/fe4Fg318uLaYs72b4EeWIlBai6Mg+VstF2l7o5+PNvadx5BK/RWEsRRGRwQabFY
 GThoVB8+PEnLkzb7TjUJVf3WCXpDBSLT9R5cg+Ra9m4qnio70MsjHOlANEUl9JNFVJhXSiCTQtW
 szmr9nEMubU+ZIinqxb6oyKX49uytUCzgWPEgEvy4XLgegWhCiesTvvAwJ9xr8Lf7KsdZi9bu3t
 2+39ZNNI4ifL5pz7hXNG6kYiaH7eaJG1W0QAd2oU2OX4vSnTHaRiQjGJHSr5se4PXXkon9TeXpJ
 FylTMiNUASTnSaRsDe39mUBK/Jda1M6YpaR5E5vSJOk7J0SMFV1d+8DC/a6cES4Ygq4zkbOwd+O
 KeYg7f8aZ26IW3VPqyuUYR58RXT+CtL/d+Yk+mLoWSRM9mh+rfPMN89/Vw6FKrUa3Rufx8NbH1H
 l2MzI1eNehneQV0A5ekQgtPOFq4WOWkyx4c9G297aqu931AeK1W
X-Received: by 2002:a05:600c:1d86:b0:48a:53ea:1405 with SMTP id
 5b1f17b1804b1-48a53ea14f5mr176698895e9.12.1776938598794; 
 Thu, 23 Apr 2026 03:03:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/59] MAINTAINERS: Remove Magnus Damm
Date: Thu, 23 Apr 2026 11:02:14 +0100
Message-ID: <20260423100229.2941820-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Magnus Damm has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-14-peter.maydell@linaro.org
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 206ff228d3..065a18986c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1781,7 +1781,6 @@ SH4 Machines
 ------------
 R2D
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
-R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/sh_serial.c
 F: hw/sh4/r2d.c
@@ -2880,7 +2879,6 @@ F: docs/*/*xive*
 
 Renesas peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
-R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
-- 
2.43.0



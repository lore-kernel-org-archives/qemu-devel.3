Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C9EC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyc-0005YQ-LR; Tue, 28 Jul 2026 08:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyK-0005TW-VW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:48 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyJ-000386-Gs
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so2496549f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241906; x=1785846706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/+btoUFvJnYludKt04BGPGNvyArUqgIEFQfg3KfE53U=;
 b=aoyqlY5HoqApNCtSQOLuQeQRcTbTFRDq3AcwMVJdJcEwKHYTePgkBBiaHRrjGtsIV2
 l13w92awHIh1pdlHDJQMlwTqbOnxT3eHCFQjmQ++Z1qffcglA58uVdvzup+Kmx03P/Oa
 XTn7W71PLWxWMufqfbgPdYtEXuGBsdK4qLKfWV4lqRgjlnSkInBVpMzSmELMLbvDK36c
 USl3l6jkk/x1yLvPhqz9KZ05e7GlBtFBL3WS/zarmyeT8+x8j1Qz3dTUCzDG7EeKCGhB
 7u1xEob7+bGF77SyoSBzEbq8sSAWKo6wky6QTaSZStJXU2po8Ltx6WODUTYt8p3WUOSD
 Z6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241906; x=1785846706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/+btoUFvJnYludKt04BGPGNvyArUqgIEFQfg3KfE53U=;
 b=ZP5EfIpngIriumP/O6pEYuOjBxWdSNYvjCMPERfFmjea1hbphO2nIzYaSLkIrbewuy
 YMSISAZIvb83auIj5sD/NSTQwVvJbWveJGXRprHToSHzUmwkpBLWmg5TCpRXXvX31+nR
 8Ix1FdIBby3UKp5gxufnWJDmkHl9VZKct4oRzRGI48yRt6OILPxohlOWaUfBDF6Mayvb
 CzDm3x5cQjJPcMHMXe0ayjQ5PEc0IgBqy1Lz3q0+QaUDKvyOJE1u7XoCp3FIzz0EUHnh
 huWi2vUFB+vYQyKxGWnHC5OCHoSICAFsDBKE2ur8fBiWf+Wt5V0J1dxU3021zUQaSZGk
 NJ8w==
X-Gm-Message-State: AOJu0Yw3LN1w8tn6N1fOJCWR06fk7JTFmqTjRKgCkL98lASaCOhCkDrC
 sjN4QeY/AkYgvRz0BtVwTPXwRartjvd3ioxnLe+P1cXhSj4Rw08p/baQCouYV6ByJ9rwQ8SCKgh
 vs2Bi
X-Gm-Gg: AR+sD11rMDJ7btrueLLobh39N5iaXC141DszePsmP77KcVyl2D0VMn7qUQehJAEbYJn
 ZhFO6+wCkv+2PfJcJOkck9uk8xNlBSJ57nVRFGifelML5XRM0QPH+7AEWb1n7HkSbfTE+zf9az6
 K/Gx2JQvLr+N+NCvuwTwA1UjY4BeWaLPwmQd7nNmcD+CVUN0a3C/a7a9qjH4SoBLvxvmIi0mYc3
 s/PSRVcLPexfFjcUvBxClpACIrJIv/jdDCyqYoVam0WyBBceYIjivu0s6MTFJzBGBMcAsU0qR39
 rJ06/mt2+wS7s3jENFfRxaPNhEpF58h1KKvyHmDBLrH2W7Gsu0c3ubwRK8xr9j6eC6rlTxSx41Z
 nOVIhzoshDptaeIUgrZX4Ci8t8C0tb35Vr4P1OiVA5sbtE+sOrlLX8RZoBpHm+WFLsgDrU+0Yfn
 o+fWVMNS0inWZ6MqRsqa+RrmRMNu7Zfh0Ew6lcHPXtK9jFRR0OYIrmY7GLI+jOCL6Q41IXr2yMZ
 6OgSJCNboS1EdGIjnc0Zg==
X-Received: by 2002:a05:6000:430c:b0:47f:85d6:9e7f with SMTP id
 ffacd0b85a97d-47fb1ec9022mr2377442f8f.3.1785241906106; 
 Tue, 28 Jul 2026 05:31:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] hw/misc/mps2-scc.c: fix scc_partno field width
Date: Tue, 28 Jul 2026 13:31:23 +0100
Message-ID: <20260728123127.1711653-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Increase the extract32 length from 8 to 12. The Primary part number is
defined as bits[15:4] by the "SSE-310 with M85 and U55 FPGA"
documentation. For example for the mps3-an547, 0x547 is 12 bits but we
only return 8 bits right now.

Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260724160943.52509-3-simonxhy0404@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 1ecb2879e32..554b504c720 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -57,7 +57,7 @@ REG32(ID, 0xFFC)
 static int scc_partno(MPS2SCC *s)
 {
     /* Return the partno field of the SCC_ID (0x524, 0x511, etc) */
-    return extract32(s->id, 4, 8);
+    return extract32(s->id, 4, 12);
 }
 
 /* Is CFG_REG2 present? */
-- 
2.43.0



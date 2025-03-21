Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1666C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvelP-0008Og-7s; Fri, 21 Mar 2025 11:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvelB-0008La-QD
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:58:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvel8-00043A-T4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:58:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so20065705e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572688; x=1743177488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zJIKqcqwKhfvCB2m7BH5xanx5S5b/Y8o9jvPbTHs/+M=;
 b=AQp9HN+LxU1J/wd2mqjsy0zHI9/4Ss8sGicfMzIFtbgK6fWeR8TTWtsl9PrPF60QeS
 Rbp3OjvY8pswE8ep63ApRg6/kueWtQ5XHYK+fSIc5Sz9FahcamvMtiXIeY8T3iEUuGHU
 s2ZSgDSWr00L0Vyu6S8qmWpTY73gnyaneXalsu1EiAS0HZmaWe4B1zOsfuaCQcGAEtsd
 sbgqzCos2p+BUPYCzqVT0N+gFht8YWfL9pYUP74ketwkEJUAIsjfMexCMxuNjNXQT2jd
 whpzNRn2OHLx7x/Afg9wrBX4xvu9PjYpP85W/Rg+FkkYGalBh9YkO9pycYttG/lh6rSX
 mGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572688; x=1743177488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJIKqcqwKhfvCB2m7BH5xanx5S5b/Y8o9jvPbTHs/+M=;
 b=Kfx8Lir545vRxOFRRj5LnrqFsaQFzhqOvN8pPt2dmNyp2iw1GzMbr5ubHYP2H1+glU
 IhyIXlTEgkQBOUKBuc2eKBvjhz8ctLtjz3uo4mQMuA6lsx2V0INJbRSXpqhweih2sT5x
 SueXLabN8gRXVfDMhLbF50nS/pnpzDmXYR5VoWzGB7HYB0o6Mfe8Kd7xvwd7avKoXNFc
 VJ4wDzLBpKbu50UHL3KUmInXFVdYgWCob+iTFqe/1B+VmGi3f+7L14nDMIP3G0kFi4J4
 lCN6DjxskXFkLAeI8gw4r/xiQm+TWwJiz+kQy9oH3iaqGrr7NjhCltaym+5vC0icPlwZ
 e1Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU44R6GHxA0AYkW9J6ZHDqWGYjh3zYeJsnJI0AhdN7mRw9W1SlcIH7/ldsHzC0+3ntL1kDFbRASCfYT@nongnu.org
X-Gm-Message-State: AOJu0YwpvDsIuZkoLYUilUX4ePbGqqPvpf63rrcSA75oIQQ2UXSupBfB
 li9euCUqu+/ZHZvaQCXiKLh9kHo2UBhMmQlxmtwOEt85JG1G/rN+RM8eCmZkFoU=
X-Gm-Gg: ASbGncvwaZm5yEumnP7KdW3noiQhhCR9xBSZG0o+AyGS1S4BtUHP6x9jw17Y+JTdQPB
 UzsNLqovbuMmx1HVFgi73O8G4YTdWo77zcH63IvipwOZddCfld/gt16KkaZr189oqIz7Ak40uxS
 Cpm8peNXlZoF+Yi5JnG/VLTfBrvmFgUvgZJ4QIn5nFSRTr8Y+AFbqO+UDp6Y3qHP7ZkB/HrpTdx
 ifEbl81J7MmPs9HvVPTL8oB7PRz/13x1zRXnNYrnyc0jcr6qvPdAJMgYd1hMrv8AMzRFvcQC2/L
 RLb/8ZLntn/Y6F7WUP3G5MP4eSJ7OCdAoTxHWowS+1T2ph68plg=
X-Google-Smtp-Source: AGHT+IFS4wRx4rig41V4HYQbkIPU7AQmA9QLC9TgQNm7H6J3Uu+kYIDWoE+o48rrDqd7VqZiuxfytg==
X-Received: by 2002:a05:6000:1fa4:b0:391:952:c730 with SMTP id
 ffacd0b85a97d-3997f8f8c1fmr3686221f8f.11.1742572688435; 
 Fri, 21 Mar 2025 08:58:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efd61sm2731049f8f.91.2025.03.21.08.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 08:58:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/meson.build: Bump arm_aspeed_bletchley
 timeout
Date: Fri, 21 Mar 2025 15:58:06 +0000
Message-ID: <20250321155806.1888867-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The arm_aspeed_bletchley timeout takes more than its
current 120s timeout on a debug Rust config:

$ time (cd build/rust; PYTHONPATH=../../python:../../tests/functional QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3 ../../tests/functional/test_arm_aspeed_bletchley.py)
TAP version 13
ok 1 test_arm_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openbmc
1..1

real    2m15.536s
user    3m21.444s
sys     0m11.558s

Bump it up to 480s, same as arm_aspeed_rainier.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 96d28289279..0f8be30fe27 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -26,7 +26,7 @@ test_timeouts = {
   'arm_aspeed_witherspoon' : 120,
   'arm_aspeed_ast2500' : 720,
   'arm_aspeed_ast2600' : 1200,
-  'arm_aspeed_bletchley' : 120,
+  'arm_aspeed_bletchley' : 480,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
-- 
2.43.0



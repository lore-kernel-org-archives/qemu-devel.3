Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4763C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOLu-0003Gn-Nx; Tue, 06 Feb 2024 11:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOLd-0003CW-27
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:31:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOLT-0002BH-7h
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:31:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40fc549ab9bso39665095e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707237045; x=1707841845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vXWEV1+hfBGKxYf3DFDRYVhG93i/x2bW7FCe3SU165k=;
 b=jGNGAqVPCH3gOW+FXw+PNt5E0V8hb1v/NulHTY1ZsWC+gDap2zmQKE4Z9q3NWZ+QVK
 ODJrpAAcOFyjFG799Jnyn8aF41/P26H++0ZzDilsz8FtufvOB7mhgesxS385MmfhUrZa
 1HMG6GWRHwLswWXV278OOCgNaDsHzH3/hS3ubCg3KUVg17TXnxXb64v1AdbNyYDdXtqI
 E5itm+FKPMX2OfLK0M20QTSq3PRvCZDSJfNbO8c3XmocxQoh2ePRPlamJLHlLuVujsup
 T+e0g0Ra7uJR/RsSZDALrq9w+QvGb+7OoSJbGpqyptozxbDQWhW7nRU1aLBU45wAmfyz
 0DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237045; x=1707841845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXWEV1+hfBGKxYf3DFDRYVhG93i/x2bW7FCe3SU165k=;
 b=NPUVfGdoC0pRLlL/bsVd9ZTP6kI39nldw/1IRLzXyT8VgzMnuaPGXWlM7s7Kxf6Fc+
 Z5cEpl02rMo9b6IWmIfzR/0Jhi66hHaqoTd3bV/ljT3Qu4gq0hhfYTl2jqpW8D4R/FIg
 RmXfndjZRDhoyQgc8xFKjiaXxpQh7RMPqlHN8Mwoz76AzSt294TqJ/0+xsR/fN7BDS7n
 RvykS9ys7yx9z1oPP6XmoRvRtOD6JO339Cfzw0nUTSKqHxFYOjW/IXny8wCokme5XdB7
 7F2nH35DW0SKTeKiQF9A+TYFnwtee7CGs4d9/zEuKWm/6yplEWdmknAo7B/WjxQW3mIx
 rW1w==
X-Gm-Message-State: AOJu0Yy1CYamw2cgQNuD4Bx/LqBN09bi3O+zxKcaFBir8DYGqymimtA8
 bQZe4JQuQ2tMP359lXL6FdZDwJcDaYkJ5lHWwwLl2UnckqmN6gqNJ1r1zafcu+E=
X-Google-Smtp-Source: AGHT+IFXUK0sP/0vNPZZSJqR0KM7H+6oZ3jCXFUCA1FdK0cbNUD6xtWRb5aVLt4rf1ezmM1wC3Nq3Q==
X-Received: by 2002:a5d:574b:0:b0:33a:e808:31a4 with SMTP id
 q11-20020a5d574b000000b0033ae80831a4mr1530666wrw.55.1707237045138; 
 Tue, 06 Feb 2024 08:30:45 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXrDnJ7Q1LGq4WaVu5nPEtmTTwrMOb7FRuRRUSXRF689Eg9hcsH8Q9u1ol9VEy8ZSXCaJjGmLcUu6LKpWxZ8vDFQGO5yew=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020adfa1d1000000b0033b4b1d180esm371325wrv.43.2024.02.06.08.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 08:30:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nabih Estefan Diaz <nabihestefan@google.com>
Subject: [PATCH] tests/qtest/meson.build: Don't include qtests_npcm7xx in
 qtests_aarch64
Date: Tue,  6 Feb 2024 16:30:43 +0000
Message-Id: <20240206163043.315535-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

We deliberately don't include qtests_npcm7xx in qtests_aarch64,
because we already get the coverage of those tests via qtests_arm,
and we don't want to use extra CI minutes testing them twice.

In commit 327b680877b79c4b we added it to qtests_aarch64; revert
that change.

Fixes: 327b680877b79c4b ("tests/qtest: Creating qtest for GMAC Module")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 39557d5ecbb..663338ae124 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -231,7 +231,6 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C9F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqug-0007zi-JP; Thu, 23 Apr 2026 06:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtv-0006V5-JK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtt-0002Fq-Fm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso3901451f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938592; x=1777543392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rz2RDGAOR8MawEux5rl7pLypGNvjkcRoo2JRrLQsJXs=;
 b=vjEGV2hVhmt8C/+KY96INaCIRAx3KF50Ob40fRFd7+/2aiD8tP3mcQ/ytnJ4n9+cf9
 fdjnoecnEmmZBHeqKhs4tqgYxcwc1Iq6D7wrjOXAc3sKvIzNoyXVkcjoEe9CtvzgkTr/
 TwLoRgsKZFdVJNaYvpwL4mgObxCpvj2mZrTv5Zn+Qg2Q3D1uBAriwVtX843QFYDArWEq
 8BeDJsGNhSAcy2HpdrJ4ZcZtzNpIXZSWIpBAJiCHh+VVaU0SGbim1in0xOQ+P5TbUVs8
 X5nWi/+8aHNghEn1nAKahxeIly/HZLQDou+qZdo3pK450l9NrxPgAkw66UBRcE99U2CP
 B4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938592; x=1777543392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rz2RDGAOR8MawEux5rl7pLypGNvjkcRoo2JRrLQsJXs=;
 b=b6Mw5mcCVjnLSeJRIK72P6hKy2peTAqRhBgbiEss2g/narYLzIaAeqge3RB76qkbLf
 I/cCESzGKzepOrACs/Qh9PchJsRPe/iZ00UJn8jmQ6Yg3DoJGvYMGVZHMVDr81VBQhbz
 eL0sDPg8AXrr9O4j34wyMh4nNABBErYCWYI5v0jpOgXiYsprDwuaexerj1QbvKZkQM3F
 zWYtbh/P7HjcWEQByv84QuLuZbOmP2i7MiVHoemzb8nk28FHWB7L+6QPaE4DvCK576kT
 HwNmgm2kHkqpES6qhCJ/fLLUIY4xiT0FKviPDZkv5uZyy5Soi5iZrWCE2o/aQRZe9KS/
 7pRA==
X-Gm-Message-State: AOJu0Yz4YU3Hpl9pkmVbtGM/0w1VXial+PqmdrAAOzmiIzJal6vGXdEm
 xSB1oq/kmRr419XJF/3tw0MYAE8MJegeVnt0gyKVjgDuG7LBIO81E37ZVgYTKMog+BkIBfDMi3q
 DMPRp
X-Gm-Gg: AeBDiestMuRmlaokdVsJ1Cw3/w4VWQbiUZEbmHZ87FFumdJdnceLEzAcO+QIXVmCzSI
 aLpYTgfiVbawJaDapNhrdEsOwurelyfGRgG7BgieR7zVgyECm/EJDKVDbaMw5zo5GN+OgwTzCQr
 l1Q8F/mPapoYwqkVluyA4ueOlp2wgk+XE6v5AciB3fUknseESpoeLouRR32KQ9j+P5B9p+kHQvW
 BoUiOZIEMtLRWqjEkcigwvovogCWiPUZLbuMp2zLUqSCYPdw6ssSofS+20t33AjEr//QvQSCLwU
 o65w8/y69jPmQsObp84WEb0G1Gnq9pp+nELotbXyoltcMlfQ/7CKkTOhf5fzTBGATX6FGF8zmrN
 FZ4AzWzEZ1MMeHxebLiqyC+X27xYYISEgRaXP6+9Qifc8wUCkC6aTkX3XjASqrrq0QokJ1bNToG
 V5QZ5bVF9992IFlf+UJjJq3OriYd9CUOWmdEEr48hD+OG04fCyrsD0vrI1mkJ625nlBareebXDO
 /V59Q+g6trqaawW10yvoSDr/3F6CL2UhbVZwkVNVw==
X-Received: by 2002:a05:6000:26c6:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-43fe3df24f7mr39499525f8f.27.1776938591958; 
 Thu, 23 Apr 2026 03:03:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/59] MAINTAINERS: Remove Coiby Xu
Date: Thu, 23 Apr 2026 11:02:07 +0100
Message-ID: <20260423100229.2941820-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Coiby Xu has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Vhost-user block device backend server" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-6-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d86d7536e6..db894223ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4381,8 +4381,7 @@ S: Supported
 F: tests/image-fuzzer/
 
 Vhost-user block device backend server
-M: Coiby Xu <Coiby.Xu@gmail.com>
-S: Maintained
+S: Orphan
 F: block/export/vhost-user-blk-server.c
 F: block/export/vhost-user-blk-server.h
 F: block/export/virtio-blk-handler.c
-- 
2.43.0



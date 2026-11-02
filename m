Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11419606A337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tT0dDysX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDK-0003ZV-E8; Mon, 02 Nov 2026 08:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCq-00038q-IO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCo-0002GU-QQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso29916165e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626569; x=1794231369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UHR5pPlhzNS6d2N4JYeAXBVd4q10AtIsttmJIyl3IO4=;
 b=tT0dDysXPv3nr5KE6sz4j/S/Vw5dSUvpfa13WBv1YC3OyR/a2Q2k8WWH+D2GCrU822
 ZktuSWeYzHr86jt4V3ePdb0k0rV+tX7op64HeaDZUqbvixnwwP8BIYTDdCWSc2VTJ5X/
 iZVw+Ufc59l2LSRCGHqOAZePVyTUxYqkP7nICaclutSlEmaQffYnaciybRsR4ifqYNQ0
 SJ9demGlQH+kfRrTl99ZUrdlJ0r3+QaPWhdJTs/N7nnJMVTtx/EJMWdv+4QYfdq7bFTY
 UpBEcuKMHtZflun+uzJbvvrw5lJrUhWoqJaRWoeCqLQXUrQICKtqeIbrrpgZ/O0dEboD
 nRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626569; x=1794231369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UHR5pPlhzNS6d2N4JYeAXBVd4q10AtIsttmJIyl3IO4=;
 b=yo/3BqB72RbT99Otf7t8cQHJG+pQU4HEHuopP7BWBAg2m/Erkr9DXqWkZ29WEyVDa2
 g76GA/kF0Q9K6x6CtnxPu4PUdqH91bJBAlXXuEcTvNLekY73ybYTKckSqODtDWBv3oSc
 G1lQBS+STqyMV20mXxIRd6awJ9BLCyup5iQU/4+ZO7NfQdek49VffDSArckplmM8b7M7
 ja3Aw4guz8oSoWd1DhznUtAr4Y8HevZfP3l5JC2GQSDy8y/Uw15uiKpLZB0EZHFC9okk
 pBWOLwjGjEdGb3KXPXuExEGpidqByv3LvY7NvN+CVV3bwMq5DzvMNcXoxH8UlzRgn/dk
 JELQ==
X-Gm-Message-State: AFq9FYIXFS+uQDR4ulwfkLoJ8l+dNzacdpqJb4lszUnDg5+reSF4svOi
 fQP2dpT3UjSgLymmvTkmP2YLl/aCAj236Q68B0QP18UWdyxveBuSD4h6i8jsTM4XLq3BVY1lwcG
 iiao9sBQ=
X-Gm-Gg: AYBFou3hlF2gSUzLHpNgecMmiZjJdEC6VvvUu2jC2UUvFCLSnDfkpb2h4AgJw9YHpQH
 eCCDLLSmUN0T1dEDZ5B2+9vrsUhtJ5HaTxEVyzbh8Ueulw/85wy7D4Gv+mqDtM/gbZDKi6gZloE
 PyFUIJQ1S3WufEEsUbj8HizxLyKEFx+fVdyWU7EyHsVIYKfdgbeAFxyOJPnHL71Bvq0NfgaVbFq
 WX7yE10HS6P5g9ADJISEpc985kCHqO0rfLMvbYid0pkdty/FdHC/GzeR0f9BzyiLhq0pNP2PCLK
 IrSINpueNVfhq5uMUa85CF0StJvymikW4pP6/XJbGibgtPmmtlo8wvii1/ZFJkWelVRVgL6DAam
 dF91TDPC6z3DoGQZVZ7hpeANv974A7OmnpWV/hWZEP+oIfj1oEdiCkm0gfgh7V8pdxzfpoV2MsB
 nBSW0IDxpUV5rM+Pv1tDI43hVdHl7uUOXOjFvoahNboWM0eHy8K2yI2Vn/XlX+B7xUU6fWJiIlV
 nvx43Ugk1CP7n2N6O1nLWfvmCas9K2S7mbcw5W5vye/zxNoyRo2BLB4+IeCtzGgJk67ECitTQ6U
 Rvre3/nXaRmcQvllQR8O3IMAri5ZV4SfSBPPtBCF5lPnD5LopV85DmINWFrNFHMig4xtNubJwHl
 d4oOMrhy7IacD1eXvNF32Oy1Mq3r9dOlkQQ==
X-Received: by 2002:a05:600c:811a:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ac187a6b30mr218681405e9.28.1793626568406; 
 Mon, 02 Nov 2026 05:36:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/47] docs/system/arm/raspi: move PCIe/GENET from missing to
 implemented
Date: Mon,  2 Nov 2026 13:35:16 +0000
Message-ID: <20261102133547.1375701-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-17-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c33..a8fc37e9204 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.43.0



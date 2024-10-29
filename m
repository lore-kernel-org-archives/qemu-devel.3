Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1E1D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nt3-0001pm-K8; Tue, 29 Oct 2024 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns7-0000gS-7f
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns0-0007h5-E9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so55049605e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214655; x=1730819455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5gzoNBFS1PLdNZcKXEgXxV1vP4J/3wc0pQNMQSx1OQQ=;
 b=QCRyY+uDL00zLmayy4lwh8kK8/AAH5OdlWrdJttfqh/dsWqL7Mwg2XqxlI80j47/6Y
 8eSGsgjeF7WZD/XAXZZdzTLa5u4ZasPbha6v9CwjQYtrZyLnXXXUHhE8hnFtKykzvSp0
 RX3RDLZswZkhG73HEbivgqLgUSUEAt1+aX9LWkreAPerfv8o4NkDwZ2E47fYhVewjjh2
 k55naODQZ3J6zC0rh/JTtJegDEQgUAUuoGPAtstkH7XRZlyKqBAVLot35w9YzIAoRYAo
 5f22XNsGvN1gk7GEHkvFMr+oRg6aVrWoNFpIw/NaUTeaG0Dxr6w8MW7H9DAb5rHQeDLv
 t8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214655; x=1730819455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gzoNBFS1PLdNZcKXEgXxV1vP4J/3wc0pQNMQSx1OQQ=;
 b=N/Y7AQyK9kHdIZIYd4v4uHKAP9xsinuKSXQ+Wk045djWWBSUYtCbAWAGUt9Av3KAPs
 z6eZ7jr1MzomzbMpJWukZpRrQQl73jmQLVo3vDE6RH8RAUo62fsYvwLaX72p3hBVdlhm
 p6XtrMqDFaPbvAJlYY98WHNLhfNKVPfW5j3kk0rMC46Wm9VcGPqVJcRSPrxcRBncyaRb
 mKhc6naUlp4h5tOjGcpAT6cPGzpE2A1UuvN0qZPKtYeVxM3fR2RfnVuJ/dwak/kmlHT1
 GaaAon7SZ//dhhGH8C/zrOIaQNDXozGq1z8fvMy0Th2Yxp/nmzl+b9GfQP9XOLTu+G4t
 55/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyZO6yb+LljXSphC5ZeM/b3Z527GFmpOjla0o11vPAvxMI/yqjH9+U4WsnaT2TlGSabeZwIopT3zm2@nongnu.org
X-Gm-Message-State: AOJu0YxwPegeSOpHM1iyxrShfHJClB5XhBXGa/0dnB8SdWNizMZ582ZS
 TmeEHUszWVCsWgEGMns2i+njHotDWdcA2cSvWGc2nJqoAHtgqraLbWb+jME6laY=
X-Google-Smtp-Source: AGHT+IESzTEPICDYCgoR+XrEPcdLu7K8JvYYNE1diNIeXXgO7EKRF8btnCMKo9wAr0gfzDmBtXCK5Q==
X-Received: by 2002:a05:600c:4fc5:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-4319ac7427fmr102316295e9.5.1730214654766; 
 Tue, 29 Oct 2024 08:10:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/18] docs/system/arm/stm32: List olimex-stm32-h405 in
 document title
Date: Tue, 29 Oct 2024 15:10:39 +0000
Message-Id: <20241029151048.1047247-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

List the olimex-stm32-h405 board in the document title, so that the
board name appears in the table of contents in system/target-arm.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20241018141332.942844-2-peter.maydell@linaro.org
---
 docs/system/arm/stm32.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index ca7a55841b4..511e3eb9ac1 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -1,5 +1,5 @@
-STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``stm32vldiscovery``)
-========================================================================================
+STMicroelectronics STM32 boards (``netduino2``, ``netduinoplus2``, ``olimex-stm32-h405``, ``stm32vldiscovery``)
+===============================================================================================================
 
 The `STM32`_ chips are a family of 32-bit ARM-based microcontroller by
 STMicroelectronics.
-- 
2.34.1



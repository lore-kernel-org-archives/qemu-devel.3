Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3FCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXaX-0007qY-Ot; Mon, 24 Nov 2025 09:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaV-0007pz-JW
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNXaT-00033L-K5
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:30:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so4239750f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763994639; x=1764599439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e0arj6/+GjHd2Y+gOHfcK3DtKdClcd17JcleSNvlSMg=;
 b=U8doEiatZb5bD8E5VjKttU3sN+feVCb0DBAcDbn2/42lAQqizf1pDLctZjptCt1B/4
 YWRSylGnhnKQgEZE5Vr4LmV3bL0eZtM6b7Y6b0nAcafpXOXst9G7xbci0UuZRRgXCLKD
 A54CZV2pL+qC8X8f9GVhQRo4NmVdzLkrXDV2C38GG+drdcsYeP9U0AILH/uBf9u5GPRo
 ieCy5Eeuq/ByW/18YXkuotS6R31cRXgpF0LEH+gGCgw4A39lMwN0LI7gO/4NndabhahM
 tWbDDPSg1afidVm3F5vYeZXnLmat4z1bvzBVru3/bV4ffUwa1Tn6X2Yf5XgDbSxVq5OZ
 Mr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994639; x=1764599439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e0arj6/+GjHd2Y+gOHfcK3DtKdClcd17JcleSNvlSMg=;
 b=gmeF7YadA/yRiXBsMYbJxU9+3dmEs5DdzMHvcSrf1Y0SgKI+cShdijQ+uI7PR9iPTO
 8wv43pe2Vz51bJTmIWdkb2b7yLe/QDLOkXyBLJzL3+39puhEUtOsu+nCkKlJXDduV8tu
 ZJ+LkvyOyWxoQoVL72mu7BtPBUEDk5IZPAizMmDU4/xIgfWnA860mv/XddnJ0t+UKZca
 8CSXNISbSEFLQnn0c6j4buaagbsrrrgZrmGi5MnSL0quQ38ZcT8nwbJ+vpwoOL8Cuhel
 Je4tIgEkkNcv2D1OAzu1X2f8RfuhT/J92l0dKAma2r+MDqeDRZaL5rgYMTOgWZwMDBZA
 /xPg==
X-Gm-Message-State: AOJu0YwgqfPE36Orh6+1Qcxm24oUDZBV5RA0oJyfi4ZZlF+WA3M+SZxa
 Io+p43GuqIQbSudQierxUruA3v+z/tbu6YCu+VZW5Ah8HPntmnUY2Y/uXV5aTS7IqzWJ9vySQDR
 ODyAB
X-Gm-Gg: ASbGncu36gCDVwDbtO0gRNkPD8Df3AN2vjyWB966CtQ7bCnfutqq2e7RKE31jftC3cg
 r1+rjMXjooeiFcCMHmXjXZUYIu/flQEPHYhu6uPoNY1G0T22Dq+Wovrfc5qwg0KNb5SDj0byNnH
 X2E7P8dphhzv7jclmCvduKvpwA6CID3RjG3TXKqNW9ifgTD/oixtq8IW6Vma3XX4bs0o1wt0mlz
 AJk+SpPYZz+ybWMabIMAO/JROETnydFG9aDJUeFN3vVfVDRdK+VMQKYhX5++iFJMQJkH4qPDb4B
 vuqcuYzYuziokhNrpM7g9E/GIrCGKO4jBOPtPy35e+JFn8nEONu9wISDGCG7ge1SW+sQwa2ekbc
 Ef884mzsRR2OlElw/a9ZUBk4XusruLFUPBDJYtIdgU0qbRIQNHgGvniOSp/IP1ZlCGsMxPzTfiK
 jX/c995psYnCusQx0F
X-Google-Smtp-Source: AGHT+IEqjTg3ZUuxG1b6d/CuuuhRHu63VlKBwLNK1ltiTZONAtsAbywq1NDrGFGRco1SNrq2/jzIAw==
X-Received: by 2002:a05:6000:4304:b0:42b:55a1:2158 with SMTP id
 ffacd0b85a97d-42cc1cbd202mr12716861f8f.17.1763994639432; 
 Mon, 24 Nov 2025 06:30:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm29408930f8f.16.2025.11.24.06.30.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:30:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only
 build
Date: Mon, 24 Nov 2025 14:30:33 +0000
Message-ID: <20251124143036.4113886-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124143036.4113886-1-peter.maydell@linaro.org>
References: <20251124143036.4113886-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Bernhard Beschow <shentey@gmail.com>

Fixes make check failures on an aarch64 host when QEMU is configured
using '--enable-kvm --disable-tcg':
  qemu-system-aarch64: unknown type 'arm-gicv3'

Reported-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20251119203759.5138-1-shentey@gmail.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0cdeb60f1f2..78775063840 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -623,7 +623,7 @@ config FSL_IMX8MP_EVK
     bool
     default y
     depends on AARCH64
-    depends on TCG || KVM
+    depends on TCG
     select FSL_IMX8MP
 
 config ARM_SMMUV3
-- 
2.43.0



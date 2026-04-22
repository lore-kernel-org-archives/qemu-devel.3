Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA410FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdme-0005Fz-L1; Wed, 22 Apr 2026 16:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmQ-0004kd-Me
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmO-0003aS-Jj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so25910785e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888153; x=1777492953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWEL/s+Dn6GjmcyW4cY0cy+sqCBoimyQD7A/0asWuMo=;
 b=wtoVCpEhbokC9gv2Z3P767wjbThW3FBuAUzqdRXW6dCTgipqMxYIeA9PqsOYXlVnDd
 Egl5I+4FQWUzzLiYXyCCq8Nirevtl8K/Ay6zGBEs6zgzwusNIV2RFa8evePFOAt5PFq7
 MfyErKMx4OOek6v/j3ZFioL1ckbZvqJbwlw4+aEDAj1RNKEl+fjQNgZh1D9iIQFT1qef
 t9ybNI8RM0a8AUy/oOGy8hJkkGQ9/uRD+qs4PH/+OsHyVFGeJwaUg42g5u4ZnJAjfibc
 MXykdo3/Rl9jkamyKDPpnho1QRjBm9+8PMqbrRKNGHV5BycP3xMnGx71Vxui2oVfIncq
 VCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888153; x=1777492953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pWEL/s+Dn6GjmcyW4cY0cy+sqCBoimyQD7A/0asWuMo=;
 b=RGFrB6HYZsHq+OUKZsL8I1WRweq8x5JS4+2aJpXaxElKOQRi6TMb9pALD+1K4ASTta
 s1exVgxUUNGF3ziWaZRxbkw9AwsULPhVIeTs1X+SdStx5qDgcPO6xItFe1KShXwMP6oh
 nCRdwz+rUzxSpVGK9WKLs2hgzMDhq8jNyXxM9BNNxE4ceoHZl5S2q6OjYlIb+iz4pkve
 DXIXNMOQNtTVol81LReX6bDRAsYFeejeXt/YCZXNrk1A2olJrmE/B89CKilSMJpelxNF
 BQP3qFnlE7OUvwIVDTACreMRXo+lvLO2AD1PWv8tlDQBj/0nHt319RcyBvaaRqBF6rhd
 rkoA==
X-Gm-Message-State: AOJu0YykuqiOkTKeOALwCtuk5C5nyT2FGait2HwlzZUf+zGax/SWIhiY
 kIufG4ZKzJmvxyxWX1EmFoSs0n5oMRznWD4UXzqK42y0waImpdQLyMq2n3oRnLXeUy9uAONCkbQ
 xSx1HrHs=
X-Gm-Gg: AeBDieu38o0BITvMzLGutwMVUOrX/zRVSwz7UGpjtygYAoPCFAK9L5o/jtjcMY6zBwi
 r8PLPkiZFuM9frHiTb6FMi4bhdqbWXfy0cXnPE4wcvRKrVscPFOocgsYu8TuHoH4wkY7j6NjE9t
 zRymiiR5rSpyvoSkQaszw6kGxdKBJpLeiNDILTP7UIv1d/EV5sm1UwXhsb7G0XIBvOl3nr6RiHe
 WAXFDTckLr7vNul331cR5JSOYpTZh3PB554OAYRQoSmcMUINGHhGRbvuufH5ha9U51Mc0OSBfcU
 0YfpI/LaulKBFNWj2x75b37pEEZe/wxFwO2Vv40grPyeZugZgbN+DqgRLpttKYp9CaiLwJ9UpY6
 UnETPc4JgRuyc2t5bdrj9ZgMoD+5AA+v5eEbEUuxBxTVwSu4GJv3dFR2obZWb3j7hCIcVdXBqfP
 8zee66EXYlfvwSzc1HB8Lxsja5wtWKvB9QN8hMyb5odgi77M4RH7Vp0R4hKFpdMbruzcvUkRYNk
 GvU3msFRJr4bZu1Q3IHdQ==
X-Received: by 2002:a05:600c:3055:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-489032bae49mr160914755e9.6.1776888153330; 
 Wed, 22 Apr 2026 13:02:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4896c2a1804sm111881015e9.4.2026.04.22.13.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/48] hw/virtio/virtio-iommu: remove duplicate include
Date: Wed, 22 Apr 2026 21:57:38 +0200
Message-ID: <20260422195746.88865-41-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

qemu/reserved-region.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260420163050.321668-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4226a676d07..08f7e8b783b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -28,7 +28,6 @@
 #include "system/kvm.h"
 #include "system/reset.h"
 #include "system/system.h"
-#include "qemu/reserved-region.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-- 
2.53.0



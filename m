Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65825CD3425
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuO-000466-Da; Fri, 01 May 2026 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuM-00045O-GO
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuK-0000Kn-Uo
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso12611455e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630539; x=1778235339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hv7cYvxktwy54oula6sxtUsfnL7h+pinIsGYrJfHrDg=;
 b=EjWWXDG4LkrClItHHAsyn9zSmKkmhxTkmtWIsMFY+7hGbjQz9l0qqR4YshO0OBbaB+
 WVwH3b1c84XupvCAu/M2OuNstPsj/A7RnDRtStwGrtskcNUOjp/m9cfrHBg9oXDEtnit
 oN8rzYcl6r3IyTyU3Qy7ABxfse9orSFLTm+tQkrMRcf9w10n+b2t2EegMQyXq1eu99gZ
 L0dT7qlbu/xEtrogs+NCsPSQV42nH72xDcBZEgl9bXd+yk+B3sxweCdjE5NRCRaERvaF
 /vMd7Yd6uFh5bAONYf+F12JWqJPqhh1hV51PzFcnTg31bFfRrmdwFobBspUd0ftW7Wcf
 HcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630539; x=1778235339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hv7cYvxktwy54oula6sxtUsfnL7h+pinIsGYrJfHrDg=;
 b=DjfaSWY1m1tKqPG5Tt/qiatvGIEl1l9FKV3Sp0NRgvxSh5+nau12TzA/GLtQiDMiG5
 1cSMAwMarnduUnvJ38qVEzVp+P9xKoYmB7q6my2wQL+S9/QLWgTmCa7yayvpF/hpoybh
 aOzoKFUwqteZ2EKtwvFRSMM9sc9j2Zfjn9K1KeXFFunIfwV68p6/mFk8VkGjPqYTjaPy
 LETZsPlJjRmxd3Igo2GBmUySFbnoLrF9cYlFlmGllKjSK/iJFHAM2tT/MD+p3Sh5wWLi
 9W3GPI1NeiCs/GGC2fyblw+4oPG2FfgD7N73VDcc4xDzfIhkZKGPSL+ioyM25oIP2PjT
 yCKA==
X-Gm-Message-State: AOJu0Yw+Idq76Uod11Y0BiAaJ4FiTLg5ZU2s2so5S0+W7pw2C7owgIPy
 aw2XK4aS100aqDSDjt3zD7vV1ZiCn0wk5/ILWMqm+G7AaksUGxQwy1I7ftVIfGQnsON3IPgvvR7
 AVSFr
X-Gm-Gg: AeBDiesXcLrFp06Op0Wcj9NrfY6FlTE283OZpENFruv0U8izXbOHJVFtgGGsL3BoQiC
 8hSV8B+J9fyBCSkhci4p9qMyRt9DkQs+6sliRyQQHZ9JeGZD64iCLK6aAhXrHlfQCtfxeOMQMiZ
 INQTror2IRwmVbfyZY9G7E781ATX5+1arwqMO19rUFqFGuq+XueTMQgyCa8vFifIC55Bub2RBW/
 pCtjXIzB4X6IUfvYnGFjB5MGPuGtFbDPnZpps0si82CQ1rrP9ogcaQnflP3piJWQnI9tG/K0Pnn
 3ziU4+5E8eZnnrHvWZYbnp2elcSZKp9NLcWJ7a0AjMRiPbCYLLmP0TJoQlccIYiU8m287tlQcrZ
 /09zH2gCG/9TCqbkIPnCleMseAdPZZgv4u0cXrcPDUTrvR2H2n+5xczP7SHvGSK8FniHFD5r/UN
 BCWXdfrFGc0b0zZ8G2HAond5Yx0VnKsf1qE0Xu+aCoAKdsh4374NZUWqm5MfTi0zp+G9K9Hb+sJ
 OhzLeZv2nWLC25npO1jS3D0eEQePh+qJLWFHKotNQ==
X-Received: by 2002:a05:600c:1382:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-48a84458db6mr101313175e9.19.1777630539565; 
 Fri, 01 May 2026 03:15:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/28] hvf: enable nested virtualisation support
Date: Fri,  1 May 2026 11:15:04 +0100
Message-ID: <20260501101505.3485916-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260429190532.26538-15-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ca50411020..ad0a459987 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2719,7 +2719,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.43.0



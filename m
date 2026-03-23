Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CB8EC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvf-0001ql-Aa; Mon, 23 Mar 2026 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvd-0001po-Sq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvb-00064D-4r
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so39372255e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263274; x=1774868074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+/URoPeBMgtvWjGNg65E40k1JTN8WwGVrVlItgMakZE=;
 b=WHQkN4MpCHmmtq353ie1ebR7GkB4TfYH+02GF8CmBO/GRD/Lp2kpOjOk7BXA+vud4q
 3lqafN8gsp/6WwZfztRdQ+On9y2tfjRNiNG3tgbcEs9YuzUPMdh5aGwsuyHbqy5KKiPa
 duOe7bVOf0gYxBgAqV8jAaJo9QGfKAyQaKct5WkmYhONoZo81LXnyNeFXYup57z11XMY
 zr4hf7dnLZeu9IpMMlcO1TcUq8RXHSZcLbIS05MfA1fYSrTbWuErE9N6ITVFrEwk0OvL
 8wkteNwlwaV1CZxbqzfhTPRBPfFL3QepY5q3oqjz8BsKD+lWPNhC7Jc1xC2+eSYLhBNL
 5/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263274; x=1774868074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+/URoPeBMgtvWjGNg65E40k1JTN8WwGVrVlItgMakZE=;
 b=YLxchMyT8Sc2eBv+V6ADQ/lJdegsw7oz0eo3VfZzn1vRcUgZHXvWgfdEDw48/0REua
 bUqLLcpzui1Ncaj5JqtiYY60V1JKYVqcnY/0tXB+5Mil+wrO/ocCf40tpWRLXknJpZrZ
 X5ieZESY3wCW6PKg0ELx4jLrZFabV+RyQFH34oYd6p4qeU3srR/sBStOXJLsHRVz2hIC
 d5kh+jHkxdo3n1NEC64W8rPwvZmFIfO2NAZwW2AVa2BV4C56K9dxCyEAe9MFieKTlumy
 w0A8LQPcJTx+jAgUYlp3Uy5iaLy4BCEy3fSPZ3ncmJEXWTGonIEX2CXk/4UqPwhjkk2U
 MsbQ==
X-Gm-Message-State: AOJu0Yz9fxECZrfEmb0QT98pH/7RbAg7rFwlN/lPYu1jKJfwA8m0P/25
 VI0EzTfW3Idru5x1kI93ndPP+jOrg4+mY1tyNaEc+IRPjV1MH0ZtHSURLiBtMFY/VuwXhCTHtls
 7wxCxX7Y=
X-Gm-Gg: ATEYQzzfjppMNr681O9+AEW5eF9cHjbOU4LKrMZpNY1ndvNpVu9VpnTbXJpYH1dmyL1
 U7Vho7tmj72EeGOTsZq9YathmU0YIMypDS7kYiAVRPF5hGgDrmc+iSfeg+/KQWG05xSfU8tI76d
 igUHKvpGRqrq4Mg45tVh17WAMNSnxKY/lFuZtCJSVSEurr6nYhbzWTSpApsx+k8JoZMV9w0XQ9r
 vvf7QnTs8JWSflaitKQjAzBRLSrk/pydFX1PKW9eFwTjftYv9yZKrJfx0g5/AHrCXXxEwcVsFi9
 eH4bPYY7AaYi+HDOf6SLJGpc5ebYUnE9GP9ELckHMXTAbq+Qokb40a0QXLdX878/11S5LwyXbH/
 uM08T9UipRse/cWUbxhN6lI1fczrZaP0Li+jEMd90LPYJch3bPuU2dWcLI/gK/YleMfqqlU9nXR
 LvpLYRXe4qqEeGmnPcGRcdkLmPfljoG/XYIdRJRc+xJb7mK9nGPNzBOV+KwUFdrhRmJo5VgHiXW
 4elLX6uOufKRIkQnAe96GGISnNlBUU=
X-Received: by 2002:a05:600c:83c4:b0:485:4006:960c with SMTP id
 5b1f17b1804b1-486fee051bbmr155756355e9.16.1774263273608; 
 Mon, 23 Mar 2026 03:54:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] whpx: arm: fix -cpu host
Date: Mon, 23 Mar 2026 10:54:22 +0000
Message-ID: <20260323105429.4059580-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

"hw/arm/virt: Register valid CPU types dynamically" went under my
radar, so fix this for WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-id: 20260314221529.47841-2-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7456614d05..06798c6c0f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3450,7 +3450,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
-        if (kvm_enabled() || hvf_enabled()) {
+        if (kvm_enabled() || hvf_enabled() || whpx_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
     }
-- 
2.43.0



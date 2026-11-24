Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DECB606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FPmOziLm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnHG-0001Z3-DG; Tue, 24 Nov 2026 04:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHC-0001VF-TS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHB-0007sX-8R
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so55207295e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514244; x=1796119044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dy2b7R3Ww1yNmx2MWIYMlKJOHPnY7qg7ccW6MUtVekw=;
 b=FPmOziLmYTEHMqBOGhAysaUgy5n4oVuKHNN3TJ/SZBGyDPSOWrb0AdSHmDdzEcLOn5
 J2LA/cKM9UlizG1XdSAvTxUANVd6MQtoZO+H7XGdLvMtb2SUjYwPG5f6irK2gWQHy3rO
 L4ZZ1ZTRwE4q74FKLe8lIbCsTCXHJDTEe1f4NS+uRDPYRhnaSueE5QismgvNk0x1fdvX
 t8wOBGf2n40FjrPrg9suOsAph3mHSRGIo4unc5TN0XsxEZmuwH2Ju3NYGFCu6CKh9T1s
 8o0m+GYna+10N5b4tpE1wHiniMiv3ncR8DvgsZDO+s8piJynOtKTEfALcqpZmZGw9w7i
 m6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514244; x=1796119044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dy2b7R3Ww1yNmx2MWIYMlKJOHPnY7qg7ccW6MUtVekw=;
 b=nGnBp/vOwC5S/PQfY93b/ZOvjgu+tEn6ynE2iDGzGN4L0QgTM9cus6sVB/j7sQ3gWu
 v6NmdADvsoL4CMLpU7mAVFFc6MAr64TyOkgywYZYFCe8bPp2lHav//GzwHUjCYEvGpiX
 +a6NN2BwGKrQT1lVpQIllSl7luHNy1np7+2dFaqRDUjHojPt6xJpn7nf3LYN2KFk7QXz
 ffW42eJcOPle+TqudRgEayCiepfJQQNL6F05pqCpJgzeOH1VxyPWiP2OuXystLxtl62z
 lFNx0U01qPTTzallgcsJzpJAwcItWsb66InryI8raCDfg3ymiARtQ0L4mwPvcG9sJ2/Q
 V7aQ==
X-Gm-Message-State: APuU4Z+lUd3uP/fYTBaPL7Iof2eteUq5PjrqoOf1Ck5uq1n0+XQnsYa5
 M89SEPWvZkdgr9oltcC3j2UF8cLTxIwWa/tL2/ak2rybYHqtPQu/GEnNEvaGMJYXmPzvp3+xSg5
 75MhD
X-Gm-Gg: AZFdTZfQQ40LMAldVV6Saxe96nOxiQprsV0PChHDVOOJwDIvbgIUEPBG4H8Y5d+/KvU
 ToYgEQsUG+9b3lKwWisa8/xBj2ldDvON+5PIv0xEPfgmNZesyYldezJg+yhnhFkE9T3SKPHnT/F
 RpcWFjg0JtkCR05hWitxGZdy2U2WX7+GOsCLcTdMs9m3uQv9pOd4yNvW3UG7lAnpa7k55HAGZzM
 dT/H85mZf3XWEn1/lVZz59qEqc4I5iE1eL3/2W6qrPUjmYQtMCB9svcCbO8C6tphzRpJYwpZOrV
 yhXRRA/LzyfqtisRc7klYqHUvfpkQgF3nSiBgdf8WoV5zmVWpLq0LbYDfYY1chY/7cw7wWcWRXa
 4uUcBe3cmY9B/riDpnWjVuxlK4BaQcYB5mpbhJFtfqc1/jtjN6hVItcoYTvohNK6qVuMb2HuaBr
 7mGpSUzAlqOnzyXTmkuwepKcOoJ+WPDMq5OGmloYgZQIygW66KRPRJyU0SNtFS1Kuk94HEW7o4f
 QqSWKB2yDRlJ6+t9LUWK/y3BaptlNC+oG8eqpqR/YR1OasGYnf8orkUm/ZPvw6BFm7MW0h5+dO/
 jZxwAcc70EeOTJhu4mWQPeZgcAvGF2Z+vPIsd+mef0UJT3AA2jbgzZSAYLxe7pr/sYJIUtXAoaD
 ot3H32cY7mH/L2evFZ7/4Pu1exqeQYsAsOK0=
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb887fc396mr291505575e9.3.1795514243759; 
 Tue, 24 Nov 2026 01:57:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm783591885e9.4.2026.11.24.01.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH for-11.2 3/4] hw/display/vmware_vga: Reject attempts to set
 resolution outside VRAM size
Date: Tue, 24 Nov 2026 09:57:18 +0000
Message-ID: <20261124095719.4126146-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124095719.4126146-1-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vmware_vga device limits the maximum width and height of the
screen, but the maximum total resolution those limits allow (2368 x
1770) can be too large for the configured VRAM size, if the user has
set that to something smaller than the 16MB default.  We don't check
that, so we will set up a display surface bigger than the backing
VRAM and QEMU will crash when we try to draw it.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4898
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/vmware_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 49b8f94b6cc..263a08c9000 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1136,6 +1136,11 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
         pixman_format_code_t format =
             qemu_default_pixman_format(s->new_depth, true);
         trace_vmware_setmode(s->new_width, s->new_height, s->new_depth);
+
+        /* Ignore attempts to set a resolution too large for the VRAM */
+        if ((uint64_t)s->new_height * stride > s->vga.vram_size) {
+            return;
+        }
         surface = qemu_create_displaysurface_from(s->new_width, s->new_height,
                                                   format, stride,
                                                   s->vga.vram_ptr);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A4F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcva-0006qQ-Cz; Mon, 09 Mar 2026 11:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvY-0006le-5H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvW-00005q-Gn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso119560585e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071629; x=1773676429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a08Md/WAEudx0JjenTi/rWK/LNu3K4IFgDGEGMN+LTY=;
 b=a/Ah6703jQLsXv3zUUk288+UR3GK/4WsC2mP6hhvpkaYYzPRQ09fHdjj/eHibIUjn5
 yfnJ1ZLfGRrjCemlu70lxgzRXDygaaN+weFisi7bnm+IGH8K7nXapu+rKPhQ42EqAOaZ
 2vfk5ubS7zphzXQnzuJvtJYXfzYLHUnULzxKVvsL1lSZQIeZY2s9xkT6/6kwfFBiPm+s
 1odPrT5vKIsrtp0T3ddbKdGBnwsuXThBCcnSPzGu4B2H+Qv48TFNGjlTVCYBgwaa+haI
 E4nKqFkkVWCQfPZmLTzwdRDA5hyjq8jIuC+LnMISSIBhQ7RQUmqIUt7UH/MI8qZqi/KM
 qT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071629; x=1773676429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a08Md/WAEudx0JjenTi/rWK/LNu3K4IFgDGEGMN+LTY=;
 b=Ao87oQ+vfUuGLSencUzEspxPQNtOnX1OOsuM0fV8MY6z6jqc8RFsqx7gu8VVfIHJDy
 i+Ju/sHk+K9150BiFl8Ll2JXxHjRqeokNKKMFQPoWnImYmi+Sf9JnyRmiKXqZnIGBtK+
 XdIcqX7rnk5BSKOAjVizVVa7ISWYVXSI8qpzK4ed16GbutX6Z3z2IMOgEJ3WFeK9JbKb
 gDPwuYmYY9dkaeCTA5r1w3+XV36zNI2oLC4PxsLGDfccyENi/vcPO3ZKMAkbsf5QXOhK
 DRtx2zN7C7Kwu2dXa1Yg5ZEkb0OsxsMmG17kjBkGYRq3RpM3gW912DT7Njm0SoPrluPW
 Oh8Q==
X-Gm-Message-State: AOJu0YxjL2oVNEuIQU+oo2/nrHA3+Ga1+BHG4riZxwPksoQECatWVO2A
 rRfLodhhES3yMLUZj2MaUey6SrkhzgrO82QB2E9keq+fYbeunswM+kh9P5DgX/QQX5Rl7b2UkwS
 VwxvtizA=
X-Gm-Gg: ATEYQzxpwSRiGnb63eiTWdzfBIJhPINiy76aVMQ0q6HdVii2juQImj7uIs+sRoh3HQS
 6l29oSW/zqhAhXoCOAA7lC59D3o9avPjedfpzQzQMu+/YdMk4xK6o2WbzJsiBRU4G5sEnYv+6Ps
 xsfit/UMbAfNc9gz5SbYMQSWM/0jv+MetnKAdNdfu3wL37BW+Q2mjSXBzG7ZGpuk3B0aPTKdT/K
 ROmkG3afwYWEuXOTN3C0VugnvnkJSk+fOLNvS31F1RToOaHj0v8sP/tedC78tBpUCw8+5qJvI6k
 8BdtOfEKOEKuw+5r+69jsWy7ilNVjn5CteSj3T062uGZSmnHjQewm6TI8WXWGHCLo+yHfrcYWT4
 Pyn25ioVQ6/rNbJq6fp/qMKwe3uFh+ebnkuocFK6dNf6ZOlctDr8x0bYK2aSuk4a2q/H0974h35
 UcS3qLFRP9u2IPqhg0uVp66xSiJLtXexnLFSmV/j2LUCx95+8RP60u4LDZshFMoAmxo4n+Jptm
X-Received: by 2002:a05:600c:3049:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-485419ba021mr1005505e9.1.1773071628640; 
 Mon, 09 Mar 2026 08:53:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d840sm30513259f8f.8.2026.03.09.08.53.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/49] hw/core/machine: Remove the hw_compat_4_0[] array
Date: Mon,  9 Mar 2026 16:51:43 +0100
Message-ID: <20260309155219.62400-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The hw_compat_4_0[] array was only used by the pc-q35-4.0
and pc-i440fx-4.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307154202.86309-5-philmd@linaro.org>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 9155e0cc9ed..f85f31bd90d 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -864,7 +864,4 @@ extern const size_t hw_compat_4_2_len;
 extern GlobalProperty hw_compat_4_1[];
 extern const size_t hw_compat_4_1_len;
 
-extern GlobalProperty hw_compat_4_0[];
-extern const size_t hw_compat_4_0_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a3d826c3cb..a14ad05b9a6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -209,18 +209,6 @@ GlobalProperty hw_compat_4_1[] = {
 };
 const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
 
-GlobalProperty hw_compat_4_0[] = {
-    { "VGA",            "edid", "false" },
-    { "secondary-vga",  "edid", "false" },
-    { "bochs-display",  "edid", "false" },
-    { "virtio-vga",     "edid", "false" },
-    { "virtio-gpu-device", "edid", "false" },
-    { "virtio-device", "use-started", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
-    { "pl031", "migrate-tick-offset", "false" },
-};
-const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.53.0



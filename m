Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE53BF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwk-000137-GY; Fri, 06 Mar 2026 07:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwU-00011O-Le
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:11 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwP-0005Ml-Hv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso69103665e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798759; x=1773403559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yIh1Ulfg1xMgCgAifvP+5jVIcMgEnWDsZVPdkBfcyXY=;
 b=Yi14VvjU307BGisiAHtCCU/L1DCzxzI3IEtm4DLqqCleNDl8YBG76omN3glAnEl2yv
 SZz4dTHcVI0RE82n6y5+sR3D0ib1XuTzOVtmsD43ZXaWC0oFmM1jXG9Qlj87zyh+s99N
 +AneAt7kedvmjKYtSTHBH3xC/c8oEeahYnyHA0397bsc/eYA27B43h+o5L9zhPjtEKCI
 l8uvxDUt/gUUrOvvwHtXFRbfS8JupUg+hnWF1Ldu9uwGt3uuRIrglO95zJN+VBk6lXcA
 yhCr7tBvvvH1RuztqUszMG0oZogzrx6VsuBmRJ7WrBMXyDJ1r1odlKG3zMvIAThUJXjZ
 7TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798759; x=1773403559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yIh1Ulfg1xMgCgAifvP+5jVIcMgEnWDsZVPdkBfcyXY=;
 b=QZUFzam8JUOFDuvdiXV/acBexe13xRl+yVrQJCJEK/baPfBCOqtII7A0cKYX4mucVu
 rMUQgXxxY1KPaKz8roLSAus0fMpSeLY9yPYHObAl/lUg52anIS50LiFJXeqP/haOTpDI
 qORjsOyK2X2AOjeC7L7CyM06bYxrUAPvY127J0x+vjE2VdTZfFXOc0HHsoaqK9Xqa8Jb
 9I1W3+hQNOcZIWs8X2G1zAjCwR9aZhSf55BGtnRXVBjgMnzOHL87/s+vk/gNwdn5S4ez
 LOl6tZu0JDXgjv0ifBn32DOjIsPhf9sbf6nRaRjUpsAjJFM5hLFoE/efaEy3j7XzMBgZ
 DbVg==
X-Gm-Message-State: AOJu0YwtYaZKYVx4nnPHzcBznMHrvvNVa+Tw9eblWB7nudu8hu3f2M7H
 EcKxpqA0z9X3A/mbKpPjm2P0DVfT+fJU8dxAPrszrSbcjvRE7Nr8tvTHH8CQr3s3AncAbM1DT9G
 JHJv+
X-Gm-Gg: ATEYQzzG4YSCCXDOu9385lxI6ecq1RLhAedMCKNC4mQdQwXXQwvJpjuS5REhyx7exGX
 mD++3D/PBxEcpnH0G6VYjS7NC42Uv8qgI2JldbV/wGaG9nOXq85Jcah8ijfXEp62QJzOWedbXTe
 6G6zxI0GTIN8j62Bv36E5mGMSdXxbnzoPSQSbsKNlewPP5o+hmMMmjoubB1HWs1VpPSaiC0RbzA
 +vAxt5ewyDpNlS0mESOtOiCJxp06dcL3E9IApxUzmQwJhMZdOhdChQbxtsEzmDK4OfzuOggBCmC
 mIkMJHUD7X8/phLa53UAVbEzkgRXSb5It1z9A1cm66h+109Ym8UYWjWHRVKyYQTWmqqeEoTtInX
 iE9EnjAVVIGBHmq6wzT85BvXA8fcTr1d/0c9DAkQWbYFAmc48goBjYZEBNWxSVf4f2ORBtlQWBB
 EkAcQpuq3nOwUWrun3D9T4yTzHt8LjBnN0Km6q7bcMDH6yP4UIZmsx4/lLKVVEJSyGULvhkhLkD
 ruzw3GOfkaV39GBaFxnUxxwsnNKJ9g=
X-Received: by 2002:a05:600c:859a:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-485269188cfmr20241415e9.3.1772798758980; 
 Fri, 06 Mar 2026 04:05:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.05.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:05:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] MAINTAINERS: Remove Cameron Esfahani
Date: Fri,  6 Mar 2026 12:05:51 +0000
Message-ID: <20260306120555.2035421-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Cameron Esfahani doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75fd16695e..256859737c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -553,7 +553,6 @@ F: target/arm/hvf/
 F: target/arm/hvf-stub.c
 
 X86 HVF CPUs
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
@@ -561,7 +560,6 @@ S: Maintained
 F: target/i386/hvf/
 
 HVF
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 W: https://wiki.qemu.org/Features/HVF
@@ -607,7 +605,6 @@ S: Supported
 F: target/i386/mshv/
 
 X86 Instruction Emulator
-M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
 R: Wei Liu <wei.liu@kernel.org>
-- 
2.43.0



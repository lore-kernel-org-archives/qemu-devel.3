Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED348D711C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLcJ-0005sQ-T8; Thu, 18 Dec 2025 16:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLcI-0005lp-AQ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:58 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLcG-0000f6-Pj
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so649512f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093575; x=1766698375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUbiHT0RyqFYgFr9NfcAAGJaN25oGIkirGwEPCWoHzo=;
 b=SSf78KDg40K2iDrRCLvGhwW2vVkQNuiImBFrIs+8gCF3TBNQ7aCpmzYiXWlIbaFS8p
 DHTHiO2y2moPWmgGyWJ7/yQCmHkb5V5/4Bjtdm4V5rojPIMahPWZYFV/HKpdrp/+b585
 v59Tsrg1x/DgQMeAG16EnY3gyCl9gr94tLUNbqMfSwbCVotAGZ9tDHQ+H8nT/knF4PIi
 KgdZUkxUlUer0RaMMFiWvMvk4dhbxrncESew1i51c+fmZQ+wgVYTtqoobAHaqRBlwGLP
 3XaaaR3rvQ/5spTIMzYHjX9D1XAO75TjMQK1Z20BrK2gie3yJXWioGfAYcWFRS48dHWc
 8YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093575; x=1766698375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iUbiHT0RyqFYgFr9NfcAAGJaN25oGIkirGwEPCWoHzo=;
 b=r5UG4bfVxotAap8KF38vUjyycyE75r2fxW39K9R1aiSq0Mai/ODukk9Yil3tKnR4uW
 zPMjlTor65gRFgWxPnvrMjdOTnTwGr84UqSKIWU8ISbE3WOBIP1phbxJ+x2zczNAHm2L
 8PpIZ3JVLocd+i6zMFZxtsa6GMH0WL5OwVHFNhU/zUREyiOLdkAAgaIBWBk+nuOtoYd3
 +Th1mPItpsYJ0IDdnAlWsPZoo+ZWRZFqFYjgM0ubTZ5ZZC7TZwHyB+SMPGpgPrqoQluC
 wMeLTkSUFDkJcB9bl3bAr3MNdTwgeeSmO1F93AkJ4Y9bu6oGhsCXpwvPpvBbQ0fWoy6Y
 qOlw==
X-Gm-Message-State: AOJu0YwjZTz6byFZtxl4htmcB41hPc4VgcV6P0krBZmKnnrKX7/lEMXH
 uZeko7QPWshSOJCYWTizNtSS9rojJE1GnCJ2DXNzUEJ3Qv9NU8arAQB1sQuLl3FmxUjpLm9NKr7
 CGLQ0JO0=
X-Gm-Gg: AY/fxX7/7wCp7aO+cguounbNbGWHwf7u2aoTF3xC0llJKK5MriBzpI8JNeSJsrAAK7W
 pEfBIdNclK6DdoAfQ9qrleKcFzu9xvj9V9TpArhXjuvPAO/+SgkPnbS0V8MS+FeX6gl/hAliyVt
 wDNGJkFync1wNeTE0D7IOvanzQMH/WGD/pioWtyMp8Rr2D12iaA1x8JZrmV4mv5etltenx9giSs
 gBGjjfglq+aemX9Pox3oun0NgxNiQNUpzc/enkDdQ2Uy6uzLUr5GpRn4RyWfOV/TXbhZJFH0sac
 1SGDpA6iZZDD3wFaW9p65VZi+wo+zlqfe8hWrk0IzPC+I6NI1DjImIYgYqx3HIh3h9Kh3VJAvaB
 Oa/72p+Fb/WHUHuLXPeeEZtq+2MHK8M8iYTidh/d7q6EDoGBsxhqTeZ1a1ieoP84CebpydYmE4I
 R9qAgKQE1ljUoZWJdRvYJVMk4jzmuQBobmTVg5lgNQS1UlE4iAwhdOlN3+3rwk
X-Google-Smtp-Source: AGHT+IGxfl/HqsXbDJaEQQVbug+g19O2/lCNckZzgoHCACGdbAMPXJo07ztJDfm/WRHZWVqBLcLBPg==
X-Received: by 2002:a05:6000:22c8:b0:431:342:ad3e with SMTP id
 ffacd0b85a97d-4324e50dfe5mr916174f8f.49.1766093574899; 
 Thu, 18 Dec 2025 13:32:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm1106653f8f.5.2025.12.18.13.32.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:32:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid TriCore to use legacy native
 endianness API
Date: Thu, 18 Dec 2025 22:32:29 +0100
Message-ID: <20251218213229.61854-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218213229.61854-1-philmd@linaro.org>
References: <20251218213229.61854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The qemu-system-tricore binary is buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/tricore-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 63e040ccc2b..781ce49a62f 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,3 +1,2 @@
 TARGET_ARCH=tricore
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_LONG_BITS=32
-- 
2.52.0



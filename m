Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24225EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTgJ-0000Bd-Kw; Fri, 06 Feb 2026 16:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTf9-0006RC-62
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTf4-0002il-5Y
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f2599980so30661505e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414404; x=1771019204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y136swcxnZiXjHhhvITm6QfbNdPGlMW0NTFM67T6O3Q=;
 b=X2aX13WHSIgl2Pw/WaXKVgHCT+Fy0jg+afnIJMSsnsgnfCWtWKmGIkCdLpIPMGBg8V
 Ujx0ldFZ8q6YGKiko3CPVwO+RsWhWCO7X5WgfLQfjL2GVQuyU+3WPHIIZmLC9+JSOx2a
 9fcljuWlkMzjyoYK8IlqiYdzvzMt9CdBhbsnnJlq8j90hylBZcTKMmniADFqCiANrr/8
 6TbnJs82MpT6plV4TnCJioErBZ0DKTroOk2TX44WJZdiXGyVhzXqLhbufGuzCgN5+e4v
 5doXL8cQ7YSZoI4dcq4d49nDxgJxwR6hrLSnve6EF/Te4w0LzSK7SCSI5I68dWeWvyEq
 vnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414404; x=1771019204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y136swcxnZiXjHhhvITm6QfbNdPGlMW0NTFM67T6O3Q=;
 b=KI4MWxgXvZAKPkmbvxyz1a2ULNRKMW74jeXwvlNc+zgQymcRpkwcJAV3WxFi4AhRxV
 QiYiEHJKAHId2pgLXE76LSO4xR9ALKfEoYIDTPRV8Gny85LL276C5P0j/62j9zfJbv0/
 TJBH6s4l2t4FfTCFe6y6g7Gf8zDZz61dXcY0D9VGZdjPuEMU/yKtYDpfRq2dvWMxnsAx
 mf/STk4l3fF3/TVnVsNWeVj3Ynfo7DCLZKchDTD8iYb/XTTrXTcaPg8xZFL7PRt3Lg29
 aZMJ/CPAvb/it9pThmRqE6PyVkUpIK6qx5KpS8eZ1WUM0J4PjRYt6RIxjLXOyQsuhO8+
 ckNg==
X-Gm-Message-State: AOJu0Yzsmq9HWX145Q/p2KeDFPzTBfFN9hWpb+uKYNIDIgCFBJuEvhB1
 vjYTiWziGT6t2ZBSia5iUkGSeIP8vDleYfFrb17qAIR7OqiSh0jErF7B5rbrBBArKG47cLI0MXm
 VCQGYQkQ=
X-Gm-Gg: AZuq6aLWeL44YRjPVxE8fs3b1sG44RAdbVCz1lGZijbNj2MiwJ9MLkrxnYF9l3T68ZB
 44ddNrAvUFK4AqHd9mleUCA4Ah0dqSFJEzsR42YpYnu1Ys0BF4EqyWrhWpxKD1IbHp2SwDg68UG
 ZMtfygX6GCsyq4+BO1E8OIpY5S1uDcHYoKurZ/oTrPE0/R+iwtm4paOHWS9nAIhg/sa+KsqiFnM
 skcKzhO6xuPvzdUgI+w959ZT+Vv4J0mhOYFGmtLaBr93jAZBSq7GBYomoLj5daAGxlPewxATAxH
 4FA//+vbqxfq9matZtjpvQQVqb+svm9+GartuPfUWtfLfBhlT5rk2YgpK2VZZ4vP8uhzyEthRch
 aE2j7B+XXPcJM/Y+8OwjahuwIkX5AjxQ3392uTNeiJZ0rNL4b6zZbBE2anslAvO6Dg6KkSOziGW
 TnY1yoPCPIOg6+/QUYczuU6QWhoPp1TxUMXnOtmTa7AF2AOb3ZAdrjBuC3KDNb
X-Received: by 2002:a05:600c:4f0e:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483201dce33mr68547385e9.8.1770414404062; 
 Fri, 06 Feb 2026 13:46:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206cc543sm78322885e9.4.2026.02.06.13.46.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 17/30] configs/targets: Restrict legacy ldst_phys() API on
 32-bit SPARC target
Date: Fri,  6 Feb 2026 22:44:35 +0100
Message-ID: <20260206214448.22008-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since we removed the last legacy uses of the legacy ldst_phys()
API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to the qemu-system-sparc binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204215304.52757-3-philmd@linaro.org>
---
 configs/targets/sparc-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 272fd46f6db..c4c38946d54 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0



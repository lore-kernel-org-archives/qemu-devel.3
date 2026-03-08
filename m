Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9E7EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlY-00010t-Hy; Sun, 08 Mar 2026 18:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlI-0000VQ-Td
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlG-0003au-PV
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso120497655e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009488; x=1773614288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=47kyoNz4TXjQKO3OpO42aT92D29Nt88tammbySClZk0=;
 b=Q2+zlqu/Wwqfpio0BFEaMqncQ/49Vw84/PmutmbM1tJDlkgsOKEAJV/I5iTRDipryW
 EghL8TPwnJoWX7UIQakk+hcGibaU5TehmQaq9j75l6sVOBDPrKMBqAS2QS9Y5rIzJPsQ
 NKni6rc1xUVga7tajUBNXGLfChb5v2qA58VadBITvoWsNitVkcqWdZLF6pBF1pFkbgoQ
 SK8+P7UNZAB3b25piVWFyllHKqsdeFEqBRamRdM29bAHme5akNM+NRdba0UvX9efxNr6
 5KcUtYUBQorzsNdcXTQK2j2U+Db7D5Qag8p+aAdn0hZkzK+1hmmb+ezY5g9kzxdiGlRI
 gyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009488; x=1773614288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=47kyoNz4TXjQKO3OpO42aT92D29Nt88tammbySClZk0=;
 b=KB7MmTC5SJIeP8H+XzO/4i8JGcIEEes3V3/g2JhkbxJrd0C9+FdDZCUGyoplDQ1nWw
 JuGuAgpgb2TgLNuogNc6X8PCA7LyLq7hSZf3IwudrXIFUqqO4F9U81il4uGoUu9VLT/R
 lXYlr53KX+9Z3kdR6/rb7yACHrLudnNT0360PmgEe0jJINmKV5vOgqp8sV0PKMMob9Fk
 3OmvsSdh+XfP87R9X+27dWsmGUvMgICszBwQrwpCMd+Or7LOp+meOoeQhtewwKNRHLK7
 8gBj46ddLTOXOWF8W4+nnEGV2AKKWVALCTWW171FJkQOazltAXZmYMux7fiUlxQZYdva
 Hb+g==
X-Gm-Message-State: AOJu0YwAXYgz/kpdCimQCoLxiL6cksfduJzH/OXwsK69mJlIgMqyP81K
 6nL3Wy5fJyhbhQy98cL6aVRjtIZPQ9UBhPVmCt3iZlv/PQd/YopQWG3MK5j60FJjkHwM8DqDBJb
 fPqxzOYI=
X-Gm-Gg: ATEYQzxFOcgQejazBYThElEJLR54NRXg1gdUSCKO1Jd4nUNat9LrXmLnxGs9McLRWd0
 A/0wEYPEnwOT1f2XlS7o6d8tROhZbZHgmiSFtsoPXjz0/DfAGGDC/aPUeFuD3aTYF+X/IdJ0mko
 GTvYiV13SzdwjQ7txtk9N18cBnLnz2RsYI9ebZsG46WkohIVX62CC8bThMHjnC3h/+c68AqMcab
 6ni9NI14kNUIV6GY3f/2dPqCngppqyCPjK8V4Mx67QsTKWuvSv7g3XpJpRhQr8P2bRZWa3GEeIH
 vCkwn7x+DtBwR0Db7hUHy2io8kETe46tx3Q3N4egRmcvxuUnYY87KXLGqDQh2bwVWaH96e8/vwG
 IEjgm0Tm60mNTQKW7gDsbZvvN1GiySOU6ikLpE+kGRE/66sesZkHdod3Rm/K1AgQ06rMpbA9/yS
 QoPDIk6BmaEMS/9WWen0OiX/+dzAowX7oLcGFoiStcJ3cUPhKE6ig0aUH/P62VcANOxmOvbYGim
 f38xYjgVDsNi+4k
X-Received: by 2002:a05:600c:4fc2:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-4852692b621mr155025385e9.12.1773009487759; 
 Sun, 08 Mar 2026 15:38:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378e700sm123544225e9.0.2026.03.08.15.38.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/49] hw/arm/Kconfig: Fix serial selection for NPCM8XX
Date: Sun,  8 Mar 2026 23:34:15 +0100
Message-ID: <20260308223433.25503-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

CONFIG_SERIAL selects the internal TYPE_SERIAL device which is akin to
an "IP block" that needs to be integrated with glue logic. In case of
NPCM8XX this glue logic is TYPE_SERIAL_MM which the code uses already.
Fix Kconfig to select CONFIG_SERIAL_MM which matches TYPE_SERIAL_MM.

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305220911.131508-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 03aa2a03db8..4e50fb1111f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,7 +482,7 @@ config NPCM8XX
     select SMBUS
     select PL310  # cache controller
     select NPCM7XX
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
 
-- 
2.53.0



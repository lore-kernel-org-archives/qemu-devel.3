Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0B9C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoht-0007HF-IU; Thu, 27 Jun 2024 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMohr-0007Gs-RB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:58:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMohn-0004Ci-1N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:58:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso11494275e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719493104; x=1720097904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73SS87dz+l13yid0huWWEEIbazV5CC3N6HBTTrp4qaA=;
 b=m8HoGYBBavyEAkS8TYkhL5gMc+5bFE+rbsA/CzhSg0jzNA016FmPx/UrAaB08vHeys
 QZkCDGuOMpcW/E602c/sVrqxcCUV2vkWSGiowS2rA0iZLubm9AucUZp4yTq+EzZZ7Qqy
 LKVAu4zzbNFHDa70NFCmDC+7L/JMW6gjYiag6rRqezKcdbwQY6fwMlg0GozGC5Aee+Y+
 Dy3I8ICgpjuYVJvt1ffYkq6EiwNCJCSL2HOZL0mzafZUVWP/1YjatMflSNWRFWH7CYGN
 ViXEjtC3ae7JeTKU3FR0KorqJg/qMx3NiE999clejLgbR0x+88M0V4efCenV2xehNuWR
 2dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719493104; x=1720097904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73SS87dz+l13yid0huWWEEIbazV5CC3N6HBTTrp4qaA=;
 b=HgxKXl6mLId9PFaX62nkGFyWsSHF7da6POLBVQI2SXz7+dgng3oQYwYKguWlrVVzB3
 unnu/llu8cRzbz0xt6GKuxB+H7ZC9S1q30l+55WoSKCrmpp8znzSRqSmWoGa1CplahAQ
 DfAuxxt48d/QW9CoW/A7FJzMY/JjatvbiXLkdOguFQh+9SHLFOaUM/8DCvUXz9I6elet
 qZ445Vbq2K7WS937NUP/6R+abBOU76FybRhHqusOOZWXBchsmnwcgZPSoF2Stnq+Z/rA
 XrOhERBzXDMlT/GSlFqar77sJn9AlSJ7sCK+xP1aiMrB04N8v04wFn09hGB0vECLkHd4
 sJVg==
X-Gm-Message-State: AOJu0Ywasqpz1WNAyCw3sG1dRj4rc3fe56/K1JOHY/b/RZ51j9LmjOVO
 QdCz7X96VA1X8dAxFs6AZfXwOvh0ngG4PlktVz9EGB2TFRPbupFqiJxeQnYQmQ3HigsnWc4sqCq
 NNTo=
X-Google-Smtp-Source: AGHT+IE4KeGkIz0mDxH+068kWOYQRVFCmDygM8podYD25NhMzKxYXyRYQwF3h7NMHV8Y3WhoIcg/9Q==
X-Received: by 2002:a05:600c:2257:b0:425:6207:12b4 with SMTP id
 5b1f17b1804b1-425620717b9mr23741605e9.24.1719493103942; 
 Thu, 27 Jun 2024 05:58:23 -0700 (PDT)
Received: from localhost.localdomain (72.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.72]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bb6ce2sm25580605e9.32.2024.06.27.05.58.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 05:58:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 maobibo <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/1] hw/intc/loongson_ipi: Fix for LoongArch
Date: Thu, 27 Jun 2024 14:58:18 +0200
Message-ID: <20240627125819.62779-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

v2:
- Only skip mmio-related code in loongson_ipi_realize()

Jiaxun Yang (1):
  hw/intc/loongson_ipi: Gate MMIO regions creation with property

 include/hw/intc/loongson_ipi.h |  1 +
 hw/intc/loongson_ipi.c         | 16 ++++++++++------
 hw/mips/loongson3_virt.c       |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.41.0



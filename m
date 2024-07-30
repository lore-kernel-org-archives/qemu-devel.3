Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF28C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3G-0008Es-Od; Tue, 30 Jul 2024 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3E-0008DT-2j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:21:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3C-0005ib-Eq
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:21:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so24937775e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331304; x=1722936104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J2N6UK8uHbxi3eCn8ReorNNbyVuGWkhstFEP8svUNrI=;
 b=gsJfRToLFhpIWSHcxhuiW4hrbnJ7YygIxdWe9qKk3U0oQjlsTq4udQb7ZllD2h7OHP
 5TPW2CQqtGSMRIUwfKgisMCxtoc3/wK3yKuRRcZ7XHpcfR6m9+yqJ+jHRfJxCZkm+eyk
 NEnLYCMnVttoZTKHn58/wQ3ILkQP3OrKGWU1hkBVkONBNC38JRwThPdO9xG+PbJxeGhc
 6ASSZS4pyChQzAFP5qkp9h4tO3velQuPuCe4QP5vAeKCONK58dZ1o3kPAFFg97OwYkSx
 zk1aHgQSFLUdldCOgvmSwze8KfQyb2MW7dusm1cpgjmszhbZfyWThmRhXvOR/RrfKaH7
 NIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331304; x=1722936104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2N6UK8uHbxi3eCn8ReorNNbyVuGWkhstFEP8svUNrI=;
 b=ky85VFby3GgsaYYqlSUqDLfU92KfjFzCGikRYb8Jtf6Qi4SXBaOh8+BC776Dddv5hY
 TgfwVaArwLyoXVyDmEU6R6CXkaUvYyaFTm4QWsQQ3cJuNJacRgC9TEd43Hy7y1fHbStL
 Ns3rkHCoeast2RUjEGdnRrz781Fs1O7X4LTiwIwMhHn668HyCGKlQHuYmcss7aub1Pky
 Q5OribYpa5uXLJgdi5q+kEmtJXONOOIaQRmyYRy0QxjE0s15SPCpazHJoD45xgfQptKm
 ICy5nVxvBsTDfeNjFI3YFYYClkiOc7/nXc/4+yMyKJH2kBNvv2DbyUeQ6vVgqEgwaO4C
 qMuw==
X-Gm-Message-State: AOJu0YxnHDOfD9rnHGtxNO66ES8dSVrz3ADH1Q+U2DveGvBAXMJiFzCJ
 SQHg1xn6ckPV5TyU2JMm0rvQObSSQ7BViyG7tfceSaVQ7gFtG3kCPKORNGWnHyxhnQRRUN+4igF
 p0L4=
X-Google-Smtp-Source: AGHT+IERvs1+QqshudEcK1BZklQIlVUi7JraQJs/UXlJqnnWLq95+BIFmgFyYUV9AEqmm5frJrw64w==
X-Received: by 2002:a05:600c:19c9:b0:426:50e1:ea6e with SMTP id
 5b1f17b1804b1-42821a5e245mr21961295e9.18.1722331304318; 
 Tue, 30 Jul 2024 02:21:44 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857fe9sm14472415f8f.70.2024.07.30.02.21.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 0/5] hw/sd: SDcard & SDHCI fixes
Date: Tue, 30 Jul 2024 11:21:33 +0200
Message-ID: <20240730092138.32443-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

3 fixes (2 fuzzed).

Philippe Mathieu-Daudé (5):
  hw/sd/sdcard: Explicit dummy byte value
  hw/sd/sdcard: Do not abort when reading DAT lines on invalid cmd state
  hw/sd/sdhci: Reset @data_count index on invalid ADMA transfers
  hw/sd/sdhci: Trace ADMA descriptors
  hw/sd/sdhci: Check ADMA descriptors can be accessed

 hw/sd/sd.c         | 16 +++++----
 hw/sd/sdhci.c      | 89 ++++++++++++++++++++++++++++------------------
 hw/sd/trace-events |  3 +-
 3 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA23C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzif-0007Fa-7D; Thu, 20 Aug 2026 06:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzi0-0006xK-B3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:16 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhy-0008R8-Rh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso1751213f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220553; x=1787825353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WcmpiKwGOoXcyKKwlQmkccNObgR1BKUZnZ4d38IauyA=;
 b=K0tEx2E5iIpJkG3mITU3s7iJU96gXANJOSvjxa8SUYAg2ddg22WcaYhlw3SwrxzDZ9
 IfqjXMDRiW7kW0MN09JOd+meW2ZZS06rkCMv/ReAh0CPwbWawYia7X/kou+J1jix1rtg
 7ySpgUGk4gHqfjoYvJvzWJbUyjma5TqMOCj8M+Sd+bfchsGAFUoHwHArHGZ5Xzstx/MS
 MklmOYaPJ/vkjnyxCb69B0IFEUv9OuosRjVABmqnPq+THM7hdvAZPlU2X81kl0jdr12A
 oSrc5erxPDj0YNHYOTFNBR/DwFiL3MO1Yj6VYUWgLP8bIlHlTTz35vkDXg2kfpBO5vCZ
 EHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220553; x=1787825353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WcmpiKwGOoXcyKKwlQmkccNObgR1BKUZnZ4d38IauyA=;
 b=RNo9OSMIt2DQ1zRaHv1d3lrdQsuwPY0fQP0ymhPHEUh7TV2iNeRYA9/wFC2xWefa/n
 9kY01gDDQNPuLGWN7ZdSbr7P0nYI/8u4no3JA/sHgrwwReFAHfmgn7YipsVaEUbhWP38
 sIcN/TehRr2DkrIeL7hs7xJt3Ql7UVqOAmJJoLK1LP7gm5XWUhmYS3oJBpPV16zAR9cX
 O4YQ4rhtpaMGPVF1HYVPCiNWuG7TTYqzrchMu0FZauVo9ymZRFzaIotRmT4VHmpCvHph
 wBdDleKdpahCHPruj+RvJRGLrDH0OwuyYaFXMe+4y0aA1lAPn6LJunMHrBSLsk31yen4
 UoRQ==
X-Gm-Message-State: AFuF++kWf3GYeqjW/cGKim8GaDVJgCpSAq4qDkSELuYTUKo4MdCzxbFc
 F0IY9ORmpg7IkY377saGoVNrose8sjTnnYng7Cvd5yU2KbJXHcnz0skfdNQ2S1b3QWJmDD5QmeJ
 bpio0
X-Gm-Gg: AR+sD12jA7u4CvnyzcEeNXDC861upD5davAdt4URloM+D5IU5/2Bd7OhDwOf6cVhr2Y
 jxHH3ZdnA7mTdBw0/dPWd2JWab4N8reF81ZzgoXD+BtgPv996We1z4VkxVyNzJWBebJsiv1zM+D
 TJ0Wq+nibW1G7ghxyjqINsmnqt7TWVnvdwHJrPv1bFFB+jgajUXCBe9ZuJ2ITa1RcAP3NGTTcbb
 qV48yg+jNwUNEy9bmVBl0RWBPKZ6ydoHSPr5hM3yw//i47hBMr1V6E8cyTBTsjx5pI3FCod+0oF
 oGdUFk7PGmzSSTn6C3h5tZPPfhj8YpwLy98Ol/q77tnBkCfHhsBxU4lm0RpFyBYZqmA9RK5rfEp
 5ttVOCrfPS75Stxv33NenXrMMYbU4+IxmTdZXHvsc1aXBITKUmcy7Ptpsjb1IqNjZmZed6f+TuM
 e2v3V8MGfVeF9lg5c8cagYiSQQ/vtZSXUsczgStoiIYOccn7pu/8rs9iq++g==
X-Received: by 2002:a05:6000:2881:b0:481:5bce:4485 with SMTP id
 ffacd0b85a97d-482b1fdb029mr19822473f8f.13.1787220552989; 
 Thu, 20 Aug 2026 03:09:12 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:12 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 17/17] hw/ide: drop a redundant interrupt from INITIALIZE
 DEVICE PARAMETERS
Date: Thu, 20 Aug 2026 12:08:44 +0200
Message-ID: <20260820100844.411717-18-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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

From: Denis V. Lunev <den@openvz.org>

ide_bus_exec_cmd() raises the interrupt for every command handler that
reports the command complete, which cmd_specify() does, so the request it
raised itself was the first of two. The one from ide_bus_exec_cmd() is the
one that belongs there, being raised after BSY is cleared and after
ide_cmd_done() has let the bus master post its own completion.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 3716cf1b5d..8190549ee8 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1675,7 +1675,6 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
     if (s->identify_set) {
         ide_identify_chs(s);
     }
-    ide_bus_set_irq(s->bus);
 
     return true;
 }
-- 
2.53.0



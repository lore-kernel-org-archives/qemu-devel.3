Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B46CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoQ-0002SC-0Y; Tue, 12 May 2026 16:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto8-0002Mp-8e
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto5-0002LP-Sf
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso68800635e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618058; x=1779222858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=k1CltLWlpdRqeDsjwrhIyIZ+xlr45GHnVpmLg3jQEr8=;
 b=s3QFwdigzZzlDPENCG40wRnLXqUVQTWQk28crx7UBkTe57tFSSpC0iN7f8xzCPceX9
 47K+wOVs6w9eHe9prfrPp5oE0eNFkpBcQxFgk2nDKQjv5xJ5NXrlWiTw1NG40ZtJFZB0
 nqe6QcHj9AXL6ngK2Ha5JsjnszDUUklKHuY5MamgqHLyZbKVTbgPQDL+5JUP87K698EB
 esxC2ktpDydgHBaJkyHbp+3m5Q6Vt4/9O1DyzCvh0TX0KTfyzgUt6hG2MlqUznupr0HF
 JjyydaFkFeT4dMlZJ59Y1WrGsMaQOkIlrJyzV9/dTq0Or6t+7HEbtmcl2xab3YP4s+OZ
 kPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618058; x=1779222858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k1CltLWlpdRqeDsjwrhIyIZ+xlr45GHnVpmLg3jQEr8=;
 b=opauBWNRc1sAS9qt4KH202YXkD2lyuaDtQxhBLz+XX8esouvkNkuVBYwIClm1LcnVI
 SXIMI7epVHzxGf63WKZvEf6l5eC6t2AjbYRiFpAlEURnqUSI6MB5wqsO/42V8iyI+O8V
 K1NoMRJQC9YPluoejhAKiDyqmucUvOZOOPP0Jg38lXfY5feOqG+PAYW20JQYgDoSP3vH
 sc1I0wVcKWnHw62ZvFsVyoCPU3QpygTqd1mBlCyovGaBCYHX94CgbsEtBehtcdltjYlV
 TnfkYpgJK9aaFecJ4PniI9wl2hK9XTBATY8kiBohrJQEbYWZQb27afDG+/Mcc/YHz0LE
 /IZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i/SLZE+WUgCCybBAaFpJnGH05qmirZaTSxBTOFomSAqZAR0fJpy5CJUwx9iuuYpALP+8WP1OUlY+y@nongnu.org
X-Gm-Message-State: AOJu0YzzzOQMz2V63PY9YCnp9aP1afLKxtRTTfdJ3vrw1B9q8rkaqK8N
 oJXJGgpeKRgKBSf70d1bSz9fEHcPl63xAlDGm0GJBj389b2IpU1RopcCUIBID0wmLE/c3c7eNWv
 +4WwI
X-Gm-Gg: Acq92OGT+aeubuM3LALo7+dQFU9vDFVnPYAhCG65vyAa7ozwdXw5J/BjM0DfvPdqBg+
 x+Ikyv2g/i9a/r4QhN36gWfF9XEyoZd3CUwB8cbxA3YZKWiapUW1XUq3ZW05Le8j8nrX0P2pRAg
 wyRMxCq2A0qyn1F9EalHsdbbazBWgg2O9SgFo2iJuPWQ/H4uaUy7fGIsYNu535kSn8fc7xvoCYE
 wdPNM2ZJWApmaozVRDTIH9/uATjrE7HOzoyjdSJS1yHVtKCdcHY5AYUDt1UkZlQE5ADV9tv021d
 N14OLkngpMBnafVqfN07KtPAh04HwpVLFrNoE58fukUMDmHAyPQJzoOkMcBosmmf0O8lkfihEoK
 OEcLJV7GnG04vMnd1RinT9OjrcxX26RCJlWL01DCa96Kgfd70ugEP9m0mZhpHVXy/UtyV7NLHbO
 Vu6yQDmKlB06jCdVWCVLlvuK9wuFLYbtXNgjl412AJkwcburXACfBgCQe0uZxtCflgUgeFg3h/w
 4TIgwrmnJnIfL8+AnkFoKKQsC/5LxNbdFJJvIOtmA==
X-Received: by 2002:a05:600c:4689:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48fc9a0f84cmr5786085e9.10.1778618058054; 
 Tue, 12 May 2026 13:34:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/12] arm: OMAP: Remove some dead code
Date: Tue, 12 May 2026 21:34:02 +0100
Message-ID: <20260512203414.3633237-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The arm OMAP SoC code still has some remnants of support for other
SoCs in the family that we used to implement, and bits that were
there for features that were never implemented and we're hardly
likely to implement now.  This patchset removes some of that dead
code.  (I noticed this because I was looking at the hw_error() calls
and realized they were all in code that was dead or otherwise not
needed any more. Then I realized there was actually quite a lot
of dead code here...)

The OMAP code is still old and crufty, but at least this is
900 lines worth of it that we can just delete without even
having to think about updating it :-)

thanks
-- PMM

Peter Maydell (12):
  hw/arm/omap: Remove omap_mpu_model remnants
  hw/arm/omap: Remove unused omap_mpuio functions
  hw/arm/omap: Remove stray unused prototype
  hw/arm/omap: Remove unused omap1_dma_irq_map[] entries
  hw/arm/omap: Delete unused #defines
  hw/arm/omap: Remove unused wakeup irq
  hw/dma/omap_dma: Remove support for dma_3_0 and dma_3_2
  hw/dma/omap_dma: Fold omap_dma_sys_read() and omap_dma_sys_write()
    into callers
  hw/dma/omap_dma: Remove omap_3_1_compatible_disable flag
  hw/dma/omap_dma: Remove 3.1 mapping handling
  hw/dma/omap_dma: Remove unused ifdeffed out code
  hw/dma/omap_dma: Drop model argument to omap_dma_init()

 hw/arm/omap1.c        |  84 +-----
 hw/dma/omap_dma.c     | 666 ++++--------------------------------------
 hw/gpio/omap_gpio.c   |   6 -
 hw/misc/omap_clk.c    |   9 +-
 include/hw/arm/omap.h | 252 +---------------
 5 files changed, 65 insertions(+), 952 deletions(-)

-- 
2.43.0



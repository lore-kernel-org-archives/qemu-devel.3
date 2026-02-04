Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4FAEA7946
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 20:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnjgX-0006QJ-Kj; Wed, 04 Feb 2026 15:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgU-0006Pu-BI
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:11 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnjgR-00036E-Td
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 15:41:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so262612f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770237665; x=1770842465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x418UGz6aHZz9bMozaDu50konKX72Z/6SQtOhfvWzRc=;
 b=yhd4q32bO4mjfZuwI0qnE8h0aofqluVUW971shVU7VborMoD7TLR9Bg4O95OzKYrli
 7CmEWmDrV5QVouFfJyHapcDzmIjqYp+PHrVxHkeJpe9oIIFiHj5WrwmyzXU2KRks/ZSP
 pSfqsabUZO9CRrxtO+Osn8eeQr1QLNu1ANwCLXuB/1mYBCd6rATEJbI+f55/u76FF4lc
 ZAHJJipU1SH6zcp+ik0y5TxI1ftUc7Btdj8UIehFxP9IFmbgVTbEtTm/30rK/TSmOJfc
 2+rmkwCOlGoP2vxqX6uSA+bCtPqF0wvagJHuzTry8FRrLc61DwjXd65/dH/cEFJ4mV4s
 muJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770237665; x=1770842465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x418UGz6aHZz9bMozaDu50konKX72Z/6SQtOhfvWzRc=;
 b=uqQt+3Ic549pCzzqFW02zS0r6H7yg86vsuP0vw4f/ArL4NkFSb+bJHOTSHcxeF5qcL
 Zv/h9JbLWg+fEJW/aQNm17j5yOIoGIE0BiyYOLfk9saLMYXzPdBv7EGu9kESl914uHYZ
 umjezc7equFXBezqfPD6tdXHdWodpj+vrbzuZlFLlS4JDmqZm8wfNDnwf2llVvxydR49
 lEyYpOGFOF5FMFLJ0uiO03QGs9QuLl/L+mF5Axnl0yIQ1SoD5ia9Qzz+iggZ9wEOqQvt
 wHg0c02qLe7l7kaVkAxOyJ6oCn3n5GOP5nwepE0eh0m2sWGwpXuHM/uk9/LzoeJc+Xbr
 c6Kw==
X-Gm-Message-State: AOJu0YxdR4g86vVYWEDM447G8KcVCzo8PXK82Svwko1BSYdUc54ND/7s
 IW8q5zY8Q9dDrq8iJrv+FcxwPrCmlRCU14+DDMjngVtpfLZqWF7OReXPZ90XikoYw05yC5+a0oC
 F9gRBcNA=
X-Gm-Gg: AZuq6aKjMXSXWHJJNINJgeUmix9spkeeKapL6LU5Oz8RZiJxgM2By481Lb/ipZO7xIm
 X+ryfcYFfhTUBA0f+/kjR7kAqCZLGG/RqsGopJiN7nDNGTJi7aDcArQE+VThsT12E/2HYZtT3Z9
 4qJUq7mVeVsFW9bRo6qmjMFV0Am5gi50Qjr2j3pjp8LsWNo49k1X/FxJlHKxnCLbHmbHa46Gxv0
 /wBLx9lzyhF3+fTGTuhVfzBwwJT+s8IMH2nF1Uc6kocF3wUAhK/mY8CgPjoq7TCaT5bZP/5pMH3
 x1G34Ug/3sLwV9/WprMkWEU6UocTqLcearnwMYMqdWrq8T+yOybX0Fjvv7fuuvb18b6DS1cwalN
 1v5HzBxADpMqoVAGeJ0G684HBpduDli9sFGAtQrYpVzRDEzc7PA/k9Ho2LVBJmBfzYvS3C8Guf2
 peDCA4bW05mYPR1mhBdpN1UdKcJTAycwddJxfK8pYYorHbiXM4VVIFe7+0RxHs
X-Received: by 2002:a05:6000:1a8c:b0:435:ac03:f2ae with SMTP id
 ffacd0b85a97d-43617e3c6e8mr6497640f8f.20.1770237665490; 
 Wed, 04 Feb 2026 12:41:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805edcfsm8441494f8f.35.2026.02.04.12.41.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 12:41:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/i386: Stop using the legacy ldst_phys() API
Date: Wed,  4 Feb 2026 21:40:59 +0100
Message-ID: <20260204204103.46343-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Mostly mechanical changes to stop using the legacy
ldst_phys() API on the x86 targets.

Philippe Mathieu-Daudé (4):
  target/i386: Use explicit little-endian LD/ST API
  hw/intc: Mark x86-specific [IO]APIC peripherals as little-endian
  hw/intc/ioapic: Replace legacy st_phys() -> address_space_st()
  configs/targets: Restrict the legacy ldst_phys() API on x86 targets

 configs/targets/i386-softmmu.mak     |  1 +
 configs/targets/x86_64-softmmu.mak   |  1 +
 hw/intc/apic.c                       |  2 +-
 hw/intc/ioapic.c                     |  5 +++--
 target/i386/helper.c                 | 12 ++++++------
 target/i386/tcg/system/misc_helper.c | 16 ++++++++--------
 6 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.52.0



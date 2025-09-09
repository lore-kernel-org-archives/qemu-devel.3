Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3823CCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6a8-0007WR-4s; Tue, 09 Sep 2025 18:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CqbAaAYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com>)
 id 1uw6Yq-0007DT-Fi
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:36 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CqbAaAYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com>)
 id 1uw6Yj-0004yd-Dn
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:35 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-32da5dbbe9fso1097340a91.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455882; x=1758060682; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qh4BXgV/nXdiynC7DUscX6viKAu9f4DJiPyGvqyjCJ8=;
 b=JJa0ZZd6JcRLySRRp1uLQ6gmBlauB297iLESvqRx3rICLnnnpyLfKz2waklEdWMi4c
 DlG3Vx6zhj5H1u8+P0XLsTOFcASAkddLsWEHbxJAha03b/UUrBVdWhOWj3Ki0Qc6SQQN
 P/R2SaXFHp4vhL7SvoGk5II5Q5zO78Ioikhz+hDaYJ8w304csFVIrjYindPYkthQfNgI
 gqIy/P9jsIQ2biyDeC9IDFoF2yMz95CuUyOOCnFbTzndYzBj+Wgb3mOuBvpE25KR9Qld
 +7exex0bZCglaVev4PrRP2oJ6tCv802nwj634WAdb9qzuHwThjiWqGG6ToyIQfBO9M+K
 wVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455882; x=1758060682;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qh4BXgV/nXdiynC7DUscX6viKAu9f4DJiPyGvqyjCJ8=;
 b=DGulOVzBAu3ebzPRrA9ToDpjhw0i9qyvGlrDv+GF2JMvKOaXPhE2a2b0QDA6KEwWQ7
 hj4aInxtwj0xSnqlFx0ru14v8r3Uctl78J98moc7CzROLrs+C7G0AjywB4NfwmoS6Dhf
 pm6og/hxSHwTh1siOs7EQ5frMh3ywE5UkyRDr9zYfggUHO/TAw+x71BmcXMs5eN1ZwHu
 zjwaHF56K5ZVeEnrhk4JeCk4Psn4DLfG84bH65rTrnedyYPRnQohd+PNrnB7Eh6+IcSt
 vR3SPTDWp/En11k19oK+TlS8JsvzXDZAvFCPXJLynR0fzOThwKkNJ+f8yyKdr8xgC5Nc
 j3Lg==
X-Gm-Message-State: AOJu0YwJxjRNijikAjsVv856GA2j7GxPwKOpK30uXoOYWGEX2muSRpg/
 /c6eX7hE3G6ocx967ubbtv9FtYPKfo3bjuUILj1Pd3UP30kNmhSkmaeyRXlHb83QK6jXnsYHgvd
 BtIbczlT7/JTjDt5XOpG9237ab8N7SSQhjyOP3ROEZR9BHOuJls3ekmDmcEjeaVJhsBFXfTuyGC
 B0Q4RKVtZixevTApD2XA7ZX0GFY6o3azRxrsc=
X-Google-Smtp-Source: AGHT+IEG3jeJ2cfZ5eFegnHavQCzeq1hPn1gHz4aeTAemSRhg6YAML75fQZwYPTwfj8bpGW1jOH5sYxwD3I=
X-Received: from pjeu22.prod.google.com ([2002:a17:90a:c56:b0:32b:ae4c:196c])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b0b:b0:327:f216:4360
 with SMTP id 98e67ed59e1d1-32d43f1789cmr16669043a91.8.1757455882207; Tue, 09
 Sep 2025 15:11:22 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:10:55 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO+lwGgC/x3MQQqAIBBA0avErBvQMKiuEi3MpppFKmNFIN09a
 fkW/2dIJEwJhiqD0M2Jgy/QdQVut34j5KUYGtW0qlc9RseEEsKJV0ynkD1Qk7NmttoZ00EJo9D
 Kzz8dp/f9ALqpwQ9kAAAA
X-Change-Id: 20250909-pcie-root-upstream-1eca4ba1c448
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Subject: [PATCH 0/7] Introduce PCIE Root Complex on Nuvoton npcm8xx and npcm7xx
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3CqbAaAYKCqUdZGNSeLTTLQJ.HTRVJRZ-IJaJQSTSLSZ.TWL@flex--yubinz.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:47 -0400
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

Improvement to QEMU:
These changes enhance QEMU by adding emulation support for a new piece
of hardware, the Nuvoton PCIe root complex, which is prevalent
in both NPCM7xx and NPCM8XX Board SoCs.

Impact (Before/After):
- Before: QEMU lacked a specific model for the Nuvoton PCIe host.
Emulating platforms using this SoC meant PCIe capabilities were either
missing or inaccurate.

- After: QEMU can now model the fundamental aspects of the
PCIe host controller. Virtual PCIe devices can be attached to emulated
NPCM7xx and NPCM8xx machines, and the guest OS can interact with them
through a more faithful representation of the on-chip PCIe hardware.

Signed-off-by: Yubin Zou <yubinz@google.com>
---
Hao Wu (1):
      hw/arm: Add PCIERC to NPCM7xx SoC

Titus Rwantare (6):
      hw/pci-host: implement Nuvoton PCIE Root Complex stub
      hw/pci-host: add basic Nuvoton PCIe window support
      hw/arm: attach PCIe root complex to npmcm8xx
      hw/pci-host: add Nuvoton PCIe root port
      hw/pci-host: enable MSI on npcm PCIe root complex
      hw/pci-host: rework Nuvoton PCIe windowing and memory regions

 hw/arm/Kconfig                    |   4 +-
 hw/arm/npcm7xx.c                  |  10 +
 hw/arm/npcm8xx.c                  |  12 +-
 hw/pci-host/Kconfig               |   4 +
 hw/pci-host/meson.build           |   1 +
 hw/pci-host/npcm_pcierc.c         | 587 ++++++++++++++++++++++++++++++++++++++
 hw/pci-host/trace-events          |   4 +
 include/hw/arm/npcm7xx.h          |   4 +-
 include/hw/arm/npcm8xx.h          |   2 +
 include/hw/pci-host/npcm_pcierc.h | 155 ++++++++++
 10 files changed, 779 insertions(+), 4 deletions(-)
---
base-commit: 6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8
change-id: 20250909-pcie-root-upstream-1eca4ba1c448

Best regards,
-- 
Yubin Zou <yubinz@google.com>



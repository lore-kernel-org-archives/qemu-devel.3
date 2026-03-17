Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14037FD8748
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2T9R-0000G6-BG; Tue, 17 Mar 2026 08:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8K-0008J9-2R
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2T8I-0001SK-KK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:02:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so61792085e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773748964; x=1774353764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dE5icgovd+OPUBrKrylIWRcvijimshpmWjpYJgfo61g=;
 b=wdkuJiIqMUUYzTsxy5c50i8ssxUbENcL/tG/chCrY9WjNofX7FiGURI0PioE4YosBg
 iMo6/OnaRRw8CtNQce5p6ATjBGGfsi2e/Ek3j2/on/x5Ums8W0dj0NssHOTJ0/aC5H/G
 BxB2Lq/S4CodPO++lZSOQTkA5ZIMR6zQNQoM4jB0Piqr7umbdg6JcxjtBWdKFiI/lFxT
 522qdJZx33S1tPHxwkBZDGgQuVcNVq0ccl1WXmDMntzbj2HYNlj3z1bgpsqFYrf1/dQG
 /4i3jPRzkRxmoinISbMmJm6NQoJN7qFIiYy++N3PO/XeTtb363YXbLeFe0NT7gLzpL4l
 5YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748964; x=1774353764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE5icgovd+OPUBrKrylIWRcvijimshpmWjpYJgfo61g=;
 b=kzNTVGC8XmqKSjXBmZqHasIi+YM3kcq47heCwEV4j1lrtvgA1pgeKVXxqHwy7m73Kj
 btCMFrpy0ov1aIG3j3g4D/Ia5gllNBlpTbJMhb9vurBtWUe4UrI714Xst3p4R2/DiVGC
 No0QrBpV5pfktongedvrTouCJtFa34b9fNo6OS90ML1v7qIqyZHcTMa44qVfJI2+sSmq
 SHokgbIcjHb58ZEBaxIofHew0LqchaXJcaxbNcdqJsuIXkj/4LmmKe4UuMQCyp0+6c3W
 4qh48K39HmMsyNKr0KhkL1ulYWDsmRUfAxXd80iu6vmODSoc51jCqccnET58GaaKy1u9
 zLBQ==
X-Gm-Message-State: AOJu0YxwVavBMedKYfAMtwniAWMON9sh0MnyTlW2Oz6DM4RPU6/f1jh8
 OIKx+/w0dPimBw8voRcCp+fRet8dMdU3VmxVPDInjcnOxrAqOktHeErZfcdMEp3Zd1qe7ChsshG
 yY58r9Ns=
X-Gm-Gg: ATEYQzw7ZXeEZAtqbWa8cddMkF/23fB6ClfHg61dW2JXGhNNKfYDRt4qek9t1zEubVK
 Ib9weeblde7hREkO1H74qkxXkZTmuzjMxCWxOa241HoLo7FQzkvEdPt73rZ88N+IlHG//fRCM8o
 d5NqDOWc0TZN/uF4488TH1u+I0H2AU+iUU+wKh/tGUgqSEL40OswL9PVrlar/whzIpsN+qCPeUC
 XJhpfF1g3LmK+/NYmcF3iCOlESZMHbaeJzWRx7TEkXVi9lyiasSR0DQGqO3YchmIOAKhDEJ0aWZ
 HhkTkUSvTuAFncj1Nixyc8PLByqktyBF2GReOFTgACGTaImcoVU7SIPcj/EBxhNSTWYlFrML9xw
 FiR5YYslYQQ4QU3i8ibkFuo7Csq5+W8H/tFHB/xbGPh7zatDN+61QUkQSll2SlgWxWHZntszm/x
 4zWczSN2bEyoVPwF9VbZYqMpVhaMIM67BQ38aFDmQxzjtu214g5cjP8XOHtJe1Lxtvs6VLAls6
X-Received: by 2002:a05:600c:3b25:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-485567029b6mr294731615e9.23.1773748963847; 
 Tue, 17 Mar 2026 05:02:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b3b0e9b99sm27740537f8f.18.2026.03.17.05.02.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 05:02:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
Date: Tue, 17 Mar 2026 13:02:36 +0100
Message-ID: <20260317120241.16320-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The "ppi" property and @ppi_enabled field were only used
for backward compatibility during the 3.1 release. We
removed all these legacy machines: the property isn't
required anymore. Still it was how the ACPI subsystem
was checking PPI use by TPM devices. This series convert
the per-instance field exposed as QOM property as a
single class (actually QOM interface) one.

Philippe Mathieu-Daudé (5):
  hw/tpm: Factor tpm_ppi_enabled() out
  hw/tpm: Add TPMIfClass::ppi_enabled field
  hw/tpm: Remove CRBState::ppi_enabled field
  hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
    TPMState
  hw/tpm: Simplify tpm_ppi_enabled()

 hw/tpm/tpm_tis.h        |  3 +--
 include/system/tpm.h    |  9 +++++++++
 hw/acpi/tpm.c           |  2 +-
 hw/i386/acpi-build.c    |  2 +-
 hw/tpm/tpm_crb.c        | 13 ++++---------
 hw/tpm/tpm_tis_common.c |  4 ++--
 hw/tpm/tpm_tis_i2c.c    |  2 +-
 hw/tpm/tpm_tis_isa.c    | 10 ++++------
 hw/tpm/tpm_tis_sysbus.c |  2 +-
 9 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.53.0



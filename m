Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F537C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR6a-0004WK-Fo; Wed, 08 Jul 2026 08:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6Z-0004VG-By
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: from mail-wr2-x01.google.com ([2a00:1450:4864:30::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whR6W-0005oY-6f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:10:19 -0400
Received: by mail-wr2-x01.google.com with SMTP id
 ffacd0b85a97d-473b8c0fd5aso130606f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512613; x=1784117413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7i3QZfgQ2YURVa5xlJA1qCnEJ8Wgrh6V/tTEOY23CvQ=;
 b=Zf4YbgSU0G3Q1GuASmlj4y4C0n1q80OfGbbcjkM+gxI94UoHaS7f1VPEOqRr2jqzKC
 ktBhZWh/YOKhRKi9hECKlh34ubZJ8mwKfa3spkzdzDetaqbmrWhnA9BtooygntmvXQKj
 jQtKKU9HoGVAUE5ZeZD0Ok4n8xhxL6B0HAtqdHubLg2Uvf0xDBmK+ikP2wNRje7aFIGb
 emoKdND0xIrD9dER8hEAbswiPnXBl1FPK4tXy18bkqKulTS6AEMu2kBj53OJcXnWWVk8
 4yILSGW0wYz0NQTvUhgmE8SiQjVEtjib9VxOQGo0/NmrFRVytdgP5QOylOGY46flqwdc
 uA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512613; x=1784117413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i3QZfgQ2YURVa5xlJA1qCnEJ8Wgrh6V/tTEOY23CvQ=;
 b=UQ8jSw8Po1lveOIV7eK+vAFhNOXijGmCL0jhAY0ctOpUMwTudi/QadW6E7NYhSuZGp
 7PQpRP0DS2S0CO3/Bq9HcG4+208zj5eKIaGfydtcMwDuECzVl9oorikVMOuoAe8vxGsE
 kPzjGKdZ5BBPo/zLYqhvH4TRg4HAc0pcVjH3CEhMolIugmrlL30c9bu369DxYiL7RLGx
 KuWx79m3Pv2VK5H29unqbTauwoBVTIVzl8CQU69/z2+Mwu6b9Svp49zN42+s+pilb93Z
 Dr/5/hTU5bCS01JbA47LaPU+9TgiILEjvKly1H7yXCfmxujzLF4omcPhUse4AxyhIsZM
 nlEw==
X-Gm-Message-State: AOJu0YwFETzgvkLAgBIhtDTECqSQQUtIENaYVb/ksJmAW9EIWHOBQATr
 l5DjUKO+WTWkT9vyyRfV/22gqwtvaSPMJtR/KD9gpHwtzdlszX9coXjJ47Vd0eyO9YyOTDMH4/t
 IllWVLIBk1E11
X-Gm-Gg: AfdE7cmmNHtHMDvVWJlQ10yrlZtZGlWf47Q3UdcOuYfIRLH+P55A12gcw3dKWHb8YYe
 lO1Nxpit0BDtdCgZR1Jx9AkWkwTAcOEhuDrs0Q+tgbqAKhUT6FZONh7HhDZnrevoC5cAmfQWe8n
 CaoygDhyaOncSQxWx1agIWtk2gQvIuMl0WaC+08JRcFlKz8IuYDUFxJ0P8mfVBgKneQLHr8LEhq
 RU4Nwe4oNLNWhPXYIclg3AHU4Sn1zyARP0DCAMxscP781+FUsjPTy28qZJ8eJj6OtaFhnUa0mZF
 a1mt8hMRA3SwD7Zl9nr1jEtA9xjPLM1mUjJYLfFSKR7hbb04Y+LCGNOqVxPfMO8LH4L91rPejku
 i6rsvgsDCRu5wmsLcpXq/OhWiaz9J7WvkHdL4bxyd6soVBNkbxTZh4QX44sUZ1PB2NQbMr4tf0T
 9LL3qr525HQmJAUszlkKPK/q088xWScI+Q5RUSXvx5Sqk3FanvW4t5trD91fbIhT39ZlNcokmt2
 tfR112JX/sctQ6h3+joLQ==
X-Received: by 2002:a05:6000:1a8d:b0:46e:997e:b4c5 with SMTP id
 ffacd0b85a97d-47df07318ebmr2488865f8f.18.1783512613351; 
 Wed, 08 Jul 2026 05:10:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm43386298f8f.11.2026.07.08.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:10:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>
Subject: [PATCH 0/3] hw/pci-host/q35: Fix blank screen for VGA when SMM is
 disabled
Date: Wed,  8 Jul 2026 13:10:08 +0100
Message-ID: <20260708121011.1653365-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x01.google.com
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

This patchset is another attempt at fixing a regression that's been
around since v9.0.0, where
 qemu-system-x86_64 -machine q35,accel=kvm,smm=off
stopped showing graphics output from the BIOS since commit b07bf7b7
("q35: Introduce smm_ranges property for q35-pci-host"). This is
most obvious and bad for accelerators which have no SMM support
(e.g. NVMM, HVF, WHPX) because there smm=off is the default and
so you always see the bug.

The rough outline of the fix has been known for ages (the
MCHPCIState::smram_region needs to be set up even if smm=off), and
various downstreams have carried versions of that patch.  However the
early-return is also somewhat bug-prone because mch_realize() in
particular is a very long function and it would be easy to add
non-SMM-specific code to the bottom of it without realizing that the
smm=off case never executed it.

This series starts with the simple fix, as most convenient for
backporting, and then on top of that has some refactoring patches
which avoid the "return from the middle of the function if
has_smm_ranges is set" pattern.

A different variant of the fix was sent by Mohamed Mediouni
a couple of months ago:
https://patchew.org/QEMU/20260413170407.57574-1-mohamed@unpredictable.fr/
I believe that the changes that patch makes to other places
than mch_realize() are unnecessary (see patch 1 commit message
for more details).

thanks
-- PMM

Peter Maydell (3):
  hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
  hw/pci-host/q35.c: Factor out creation of SMRAM MRs
  hw/pci-host/q35.c: Avoid early return in mch_write_config()

 hw/pci-host/q35.c | 110 +++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32F3E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLefQ-0006hj-01; Thu, 12 Dec 2024 03:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefK-0006hN-Or
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:22 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefJ-0004I4-8R
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:22 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so267695a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992518; x=1734597318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3oSCqjTtVxZEumNXHF9tM+Tv013dequEyZK90MpRJVo=;
 b=RQ5U7pBnv8Htgg9VHfCNis7LDTIzwVXVH8KLb0yHJeyZBs84aURO82r7VH3mVhGDYU
 4ZkvLzwgOgTh9sC0eWIBcJ/VNq2GXUh3UfyDeG69ud7dGpvfy/EFH3l+aLIZmmHt/bD9
 jCZJO1TZ7CNTgX2tDBIsOdIEi3srrn5vPnd4nmuEWAfgOH0YEXfozICqeTwv/SvAPn8o
 00HRMT0pJ9sCy+0KEkhkaG/ZJIPlHwQyeLq6+xZuYn2IUXN9C88fvBrvlOzCZcAUqsiK
 4ZauooGPwOrlVh5dpA0dbcig0QPdXrLsv0Vg7bbVe/xfZpBkMZwwOoieg1vSgc3dPEUc
 ecmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992518; x=1734597318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3oSCqjTtVxZEumNXHF9tM+Tv013dequEyZK90MpRJVo=;
 b=nn6ShvCfkMLX5WvoHPhEs9JzWyRT5srg9iqlz5ClI6ZfhUkAOgBzO79ZbxKR6o5ZsT
 f7IAlTxOux1DQT4USLwHXTPLpgIiSmkh9/pTbGVAQcLJp+ZGzRbfyE4zlC9czZcZ+928
 gMvKkNXW92i59tPzua6damBDbhlzBZX5gZgimzoujSAaQzSE8PEbbscv2pfQ0PTrFG+o
 nQHSqgpqvu2UV5tS7WyBOnkzvBhvfaZY+HkxsIFCm0qZVb2gKpqqrWy7daE1O5hFZxpN
 nWLGX8PKpjmiAbiI4wbbZ3zCYGq1EyBXeMf/DDS5eNtX1Y0eqFhQTKNmkPXurF0z3GqV
 8W2A==
X-Gm-Message-State: AOJu0YwMZnbePxFXR3OvMjoLoqee+/X945xrEYP2UL0xElrBGZ2moonZ
 9sWJVqMSHk69DUtrFon+7qGVLStBg35//axR6NOG+RT3ovNAtuxUJq+dBA==
X-Gm-Gg: ASbGncs+EBIGUeVYpkFlT7Imvh5HuxNQhEkCRWw75xiGxfvQMAcKv5smZwhiFVvmura
 1lgoQt5SHnzGHrg5HaOvg1tEW8vqzk4zQWs7IaZgArGcuiKK8/CAC2fQkqp8nfYskRgoEa2LgM2
 bOPp+zX3qRm1yg368AkKPfyUslG9Cmhs0Vy3nIYzaQ25PeaghKL3mO65iERG/aHhSc3mW3cOZuw
 u+L1YcHQcm47EDE8RffpukOPSKtJ+pM+IO/8pmSxA/kqlLSkmkNUM6ek+w=
X-Google-Smtp-Source: AGHT+IH6Nj5U853AzlSWLTH5dCO/gwxyPak/CWIBsb3SFbpWgetR95W7X0jf1Aq7iPP/fHns7UKMWw==
X-Received: by 2002:a17:90b:5112:b0:2ee:ba0c:1718 with SMTP id
 98e67ed59e1d1-2f1280effe4mr9789039a91.37.1733992518256; 
 Thu, 12 Dec 2024 00:35:18 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:17 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 0/8] Add XHCI TR NOOP support, plus PCI, MSIX changes
Date: Thu, 12 Dec 2024 18:34:53 +1000
Message-ID: <20241212083502.1439033-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

This series adds XHCI "TR NOOP" support, but adding qtests ran into
issues with PCI and MSIX, and fixing those irritated what looks like
a bug in the e1000e/igb tests.

Firstly, the XHCI NEC PCI host has a shared BAR for device registers
and MSIX space, which is not handled by qtest/pci. Keeping track of BAR
mappings in qtest and allowing MSIX to use an existing mapping seems to
work.

For the XHCI qtest, I added a MSIX check to ensure interrupts are working
correctly, similarly to e1000e it polls the PBA bit with the interrupt
masked. Doing this never actually clears the pending msix irq, because
that is not implemented in the hw/pci code. So a test that waits for an
interrupt to be triggered multiple times will fail.

Adding the PBA write operations to clear/trigger pending interrupts
breaks e1000e/igb tests that wait for multiple triggers, because they
are actually buggy and only triggering the irq once, but the missing
MSIX write support was saving them because it made it look like the
irq had triggered.

My XHCI qtest caught that issue because it has some code which
asserts that the interrupt is *not* pending.

Since RFC I fixed up some checkpatch issues as Fabiano pointed out,
and also dug into the e1000e/igb test failure a bit more and hopefully
fixed it properly. 

Thanks,
Nick

Nicholas Piggin (8):
  qtest/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  pci/msix: Implement PBA writes
  tests/qtest/e1000e|igb: Fix e1000e and igb tests to re-trigger
    interrupts
  hw/usb/xhci: Move HCD constants to a header and add register constants
  qtest/xhci: Add controller and device setup and ring tests
  hw/usb/xhci: Support TR NOOP commands
  qtest/xhci: add a test for TR NOOP commands

 hw/usb/hcd-xhci.h               | 197 ++++++++++++
 tests/qtest/libqos/ahci.h       |   1 +
 tests/qtest/libqos/pci.h        |   4 +
 tests/qtest/libqos/virtio-pci.h |   1 +
 hw/pci/msix.c                   |  16 +
 hw/usb/hcd-xhci.c               | 318 ++++++-------------
 tests/qtest/ahci-test.c         |   2 +
 tests/qtest/e1000e-test.c       |   8 +-
 tests/qtest/igb-test.c          |   8 +-
 tests/qtest/libqos/ahci.c       |   6 +
 tests/qtest/libqos/e1000e.c     |   2 +-
 tests/qtest/libqos/pci.c        |  92 +++++-
 tests/qtest/libqos/virtio-pci.c |   6 +-
 tests/qtest/usb-hcd-xhci-test.c | 535 +++++++++++++++++++++++++++++++-
 14 files changed, 943 insertions(+), 253 deletions(-)

-- 
2.45.2



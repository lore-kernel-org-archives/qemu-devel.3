Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B824D5E126
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhb-0008Tx-Cy; Thu, 07 Nov 2024 22:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9FhZ-0008T7-0S
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:25 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9FhX-0001H4-3x
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:24 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e601b6a33aso1095972b6e.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036616; x=1731641416;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BGrNE/4XrgF8H9uZdF9RiVAPVCxcieNEKbR2LP4ytJQ=;
 b=f0VWlR4alOF7DlzKD2tx+Z6BXkbbP+qbjyAwlOqe8TN0PUCqruMkr1Esf2d+2RfwDy
 HAV30kQwlG50BQSJqB5djvWAjLJgYM5/AlkWg2QXMS1xRQMQZ9l37fK+S0eBzOOVbtLi
 r+0yG3ZJZcaCsHdu1CeA1Hlsdzz44TnX1bO71xWxnitrF9JpiwnZyzyHIf7rM5KyJxGy
 rIC5ztZ1z8qK0JZyejL8mPjJSOY3rn6oY3X86EILu6FJDJZyvUvMokjFgYp6LGTUNSrY
 e7bpdqIItVsx9z0rZFSVSCo9LCCN8AaeVxnvw8VFBDVInPtlKaJBuw79/NuPYnQYTkB+
 DutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036616; x=1731641416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGrNE/4XrgF8H9uZdF9RiVAPVCxcieNEKbR2LP4ytJQ=;
 b=shufqtIfxgrnY2YvWDZUSmOCV8k+h4CR3gdbT/kPPL1aiKzjOQ8Rur25b7KL9+fcW8
 5ijFx9CVr4qAWP1V+07GgZVEdt1NU2amKr193uzQlCKYawo2ij/rZ2aPedHpfTBu8pqW
 qQym++erjmbuMZIFUeaeBMKu9L7Ynr/aYxK/k6e3IdptF7nb4UDUuPzjWh75QgSqE4Nu
 plFyVyvHbebjRlNJ9l4rw+7WEJbx7GArhAo0b+GpvoJsmStQSLDhY8xKIECvYUWA2E5e
 Ujn2oK/s+v7Iz01Z59V9gLNMZMpljKpTaqSKx2LzMIwPrQSobOLfkJR3rYWzIsHilbSG
 CLPQ==
X-Gm-Message-State: AOJu0YyRpCquBMrMVy9TBQ1RFeyXxkQfFEAkaDU7FS2BuothRPa2/Bys
 hrYxaCI0NQR7tLx4nepxyzbyAFeqcrNMUdZxQs4Xjwnmn42mJWGhaafXPnRsFTE7ghr7xMcPuNR
 L534=
X-Google-Smtp-Source: AGHT+IHTB8VbFQuEgVGCEzanvwDY1h4gCDZiKTU9EeDLo+kbnDLVRYCi+MmXJYybCPMYj2WbXQR5bg==
X-Received: by 2002:a05:6808:300c:b0:3e6:37f7:5a3a with SMTP id
 5614622812f47-3e794737a5fmr1849168b6e.41.1731036616276; 
 Thu, 07 Nov 2024 19:30:16 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:15 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Subject: [RFC PATCH 0/5] support unaligned access to xHCI Capability
Date: Fri,  8 Nov 2024 12:29:44 +0900
Message-ID: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch set aims to support unaligned access to xHCI Capability
Registers.

To achieve this, we introduce the emulation of an unaligned access
through multiple aligned accesses. This patch set also adds a test
device and several tests using this device to verify that the
emulation functions correctly.

Using these changes, unaligned access to xHCI Capability Registers is
now supported.

During development, I required a lot of 'MemoryRegionOps' structs with
its own read/write functions for tests. In the QEMU project, a large
number of similar functions or structs are often written in '.inc'
files. I followed this approach for the test functions but would
appreciate feedback on whether this is appropriate.

Tomoyuki HIROSE (5):
  hw/nvme/ctrl: specify the 'valid' field in MemoryRegionOps
  system/memory: support unaligned access
  hw/misc: add test device for memory access
  tests/qtest: add test for memory region access
  hw/usb/hcd-xhci: allow unaligned access to Capability Registers

 hw/misc/Kconfig                         |    4 +
 hw/misc/memaccess-testdev.c             |  197 +++
 hw/misc/meson.build                     |    1 +
 hw/nvme/ctrl.c                          |    5 +
 hw/usb/hcd-xhci.c                       |    4 +-
 include/hw/misc/memaccess-testdev.h     |   42 +
 include/hw/misc/memaccess-testdev.h.inc | 1864 +++++++++++++++++++++++
 system/memory.c                         |  147 +-
 system/physmem.c                        |    8 -
 tests/qtest/memaccess-test.c            |  598 ++++++++
 tests/qtest/meson.build                 |    9 +
 11 files changed, 2842 insertions(+), 37 deletions(-)
 create mode 100644 hw/misc/memaccess-testdev.c
 create mode 100644 include/hw/misc/memaccess-testdev.h
 create mode 100644 include/hw/misc/memaccess-testdev.h.inc
 create mode 100644 tests/qtest/memaccess-test.c

-- 
2.43.0



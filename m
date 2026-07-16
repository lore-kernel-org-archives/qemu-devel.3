Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0757C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkM4s-0004Wq-1W; Thu, 16 Jul 2026 09:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM4q-0004Wg-OS
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:24:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wkM4o-0004wg-Sl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:24:36 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso637408a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208273; x=1784813073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4RZU0JMLqDYjhf52UqXGRbMX/EBibWo0iByrh3E9K9I=;
 b=Q74VEdDXHr9uXt2MIMRWEED9vRAZ2Vv5A+wprbfPcPz8C2zCiGYePUjrnnT2a6BlOu
 oRC+BIFkgA4MHgh0twrf+OmYuizg75jWh8Od5IhD0Ekda9w3eJP4OSGdGNhQipjB00vH
 1BiALFJ0MMBdgn4HjqPC8RdAL88xQWRzijJh49ux74fb7gfpgUhleRAMt57KVZL0YsVd
 pSu3kH1QQy83ivrzmE5m2bDVVyr1GHZWzomIM5RcWv3jHmn6niMRLJJwSLpEbaNaZnSV
 jk3bD4dO9SxEXdE4GwLe7BjV/YVFIAK+p8eDTd7QAQFl7P6UawlAwvBKVABbL6/S7rEf
 7VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208273; x=1784813073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4RZU0JMLqDYjhf52UqXGRbMX/EBibWo0iByrh3E9K9I=;
 b=QuXRGGhgNiYm1jS6qRFpk0ZaIYedaIAtUUQK7Njs+rTR+JzCboYJ15EqljNcasZCiF
 AjP3aN9iLfLGfa3LschuvDmigTQOKeAeh4AadJt8aeX1jFi+yAY0X3AFpaJCCeeWzfO0
 QJfrzqRlyT/mniMkpGg+DvZxEm+zuzRG22k0F2coFTgH+xYPj5cgoCMp5E+sFkMHPvgQ
 38PCaES6zoIRnG4VxGMphsMswaVoRICOKlNv5hYYloxjLjGI0Sd5umAyO0P1gSMWLC7s
 PQAH8uhj+zsStSNY0K3W2H5EEWRzq74IEJaRwf+DovNEFzpZs6kD2jCuV3WDQdcAbhuD
 OMRw==
X-Gm-Message-State: AOJu0YwhRJlcptocpet2UqLCmN6gjac0D07AbLZAW6sBcmtDcBGx0Nn0
 qNZCkP9E956c+EQXf7vxoNF81FFDx96heXfL05hp9RvOyyaMisNjf8mclksP2HWDARj3ZA==
X-Gm-Gg: AfdE7ckmj5E57j1oL/J6JYZXQsVJODAMT4porC2N7VmN08/N0AtWzoMCjuBqzP6UiXl
 yK/uHnJZC7UD8qTY8c805kwBsmygcRYrntVjvJMaqIZSgOm7XhDuXzzRc4U4wMqDYsIum07R2uc
 GwAGzOWiKc8gaV0LEikx/KdosulTn05V65HWqZiEFE4f0dnpeJob5hi18d+xdYY2dwdEl38xtYC
 soASnXfGh8qyNLnWVK0zOcpDgeFbRQlD5wvDEz7lgctnGKfCFlkTc1LaxfT/5cCFeAxjw4coAnY
 YFJX9Jv5HhxCiiiFti2i1KSaah8r/7bkwFrQVtlLkHhvb3uVPtEj/WTJQUsaDkr+BvBmxuwz3I5
 iTEOCcNHeWUh6Yg9sCML+gLoIQFoEgB9DD9oiTKp97aaX2SLtXoJEx/ntQsWPpPrfZKhWUIuu+7
 7e9mpw4qWB3RDSLhiwlv1rwjDd/Q5P
X-Received: by 2002:a17:90b:3b8d:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38dc7b2d49emr17119568a91.3.1784208272742; 
 Thu, 16 Jul 2026 06:24:32 -0700 (PDT)
Received: from DESKTOP-JUS09M1.tail12b54b.ts.net ([38.34.7.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4344b8bsm11336706c88.13.2026.07.16.06.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:24:32 -0700 (PDT)
From: Junze Cao <caojunze424@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Junze Cao <caojunze424@gmail.com>
Subject: [PATCH 0/3] riscv: Add K230 DDR controller and PHY models
Date: Thu, 16 Jul 2026 21:24:20 +0800
Message-ID: <20260716132423.931427-1-caojunze424@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=caojunze424@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The K230 SDK U-Boot SPL initializes DRAM by programming the DDRC CFG
and DDR PHY MMIO regions. The k230 machine currently exposes the DDR
configuration region as unimplemented and does not provide the PHY, so
the SPL cannot complete the training and DFI handshakes.

Add minimal models for the register behavior exercised by the SDK SPL.
The controller model provides reset values, register access policy, DFI
and software-update handshakes, and the Init-to-Normal transition. The
PHY model provides CSR ownership, the training mailbox, and DFI
completion. Wire both devices into the k230 machine and document the
resulting SPL support.

These device models allow firmware to complete the DDR initialization
sequence.

Testing performed:

* scripts/checkpatch.pl --branch upstream/master..HEAD
* meson test -C build --print-errorlogs
  qemu:qtest-riscv64/k230-ddr-test (6 subtests passed)
* Booted the K230 SDK U-Boot SPL through DDR initialization to its SPI
  boot path

Junze Cao (3):
  hw/misc: Add K230 DDR controller and PHY models
  hw/riscv: Connect K230 DDR controller and PHY models
  tests/qtest: Add K230 DDR controller tests

 MAINTAINERS                 |   3 +
 docs/system/riscv/k230.rst  |   4 +
 hw/misc/k230_ddr.c          | 544 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/riscv/k230.c             |  19 +-
 include/hw/misc/k230_ddr.h  |  59 ++++
 include/hw/riscv/k230.h     |   4 +
 tests/qtest/k230-ddr-test.c | 226 +++++++++++++++
 tests/qtest/meson.build     |   3 +-
 9 files changed, 859 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/k230_ddr.c
 create mode 100644 include/hw/misc/k230_ddr.h
 create mode 100644 tests/qtest/k230-ddr-test.c


base-commit: eca2c16212ef9dcb0871de39bb9d1c2efebe76be
-- 
2.53.0


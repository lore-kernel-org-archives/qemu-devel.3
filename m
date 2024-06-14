Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79C0C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHvkZ-0003IC-HD; Thu, 13 Jun 2024 21:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHvkT-0003He-P7; Thu, 13 Jun 2024 21:29:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHvkR-00060h-Vf; Thu, 13 Jun 2024 21:29:01 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so15250075ad.3; 
 Thu, 13 Jun 2024 18:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718328536; x=1718933336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DJWOYb4zi0IN06txnnmo5DHAi3kk0Ao/Sh+mCQwN/eA=;
 b=AJ5Be6t2Cbr3/jky/OB6AF4Rx8E+8ku2a18JVXwud1shjqBMGk4QR8gWSpfmdyBM6p
 L7QxLLbZoPXIFrBoxVroBFx05C0s5yWgQ/S4v0W1s2epyUvqbzOQk1CsFw/lDMXQfhRH
 iWZZ8FnKHmy8VmSiKdlmJOc0/SUC+eb0xRARgbDBXW+77eL7Q1CAKcHu4ROCQD8mYMgW
 klVBA18uRpAOT57VpLsNZ5N0jOMAtiXdgCJMYamAJtMnkRd3WdCtwJUdugcareq13r3f
 yMn7Vb9t+1j7baUbfYdvgiaFED69xs5l++DXJSAkYQe4k8tBE2mQOOjK48ixYvY0G37e
 p6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718328536; x=1718933336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJWOYb4zi0IN06txnnmo5DHAi3kk0Ao/Sh+mCQwN/eA=;
 b=Z7eX0IqBN544Y6g23P1JHTAYvgcOfCtoUTB3hFYQmghPHpMmJ3vUwsiCT2XQb1nT2Q
 RF0t+E7OKzhfXKfs0Ci1iWmKTjvWV5F+NF2Tr5QhIaMIhER6487t6NKng79s249ZzvYT
 6ed2Gv6O6BCz//UjkgAPsPvWmFqTT1evpGjq2/hwQwUQ2mkMGMHSlb0bYevuTX0YR31t
 Gzl9lTjc+1vNKej2plEBfy1JhyKicoLBPWJQlgCaSS5Ko1e3dH5f73C370qYsxGCpinp
 1vstRQRjAIwGrBTt8SyMwaEXEdjqSwMG3FV5ec1HpEVtCaFvOoUdrGHbMPcbCRW1s2SV
 X6QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGzSOMaWSYf4C72NPndiz1c5WlZ4rUW/hRE5qLJiP48YEJtkWG5G0gHAZeOZpMeAchWxC3mSVFSPUmXM1LAq/TMJIa3tu5wFeGLW4m4/dCmWFUWHC77real3W9sg==
X-Gm-Message-State: AOJu0YzlUYsdrIIiSRMfLu8r6VlkIItw8m2eN8WhFlFsLsU/IzDtTwpv
 C+MP97IRLhJX2d3kxwXjB2jvTEphaCCJVCKXVlyqqrw0i5vnz0HwY6+3XA==
X-Google-Smtp-Source: AGHT+IEZaqYDsJxE3EOleIDFXqe6sazG/WVzrl3FGgF2DTJvoBY1vEpH/b+jma2Tl/tUaQMJ4L0ihg==
X-Received: by 2002:a17:902:a381:b0:1f6:a96f:225c with SMTP id
 d9443c01a7336-1f8625db53cmr11198055ad.28.1718328536201; 
 Thu, 13 Jun 2024 18:28:56 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f13562sm20757255ad.212.2024.06.13.18.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 18:28:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: wilfred.mallawa@wdc.com, marcel.apfelbaum@gmail.com, lukas@wunner.de,
 qemu-devel@nongnu.org, mst@redhat.com, Jonathan.Cameron@Huawei.com,
 kbusch@kernel.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 its@irrelevant.dk, jiewen.yao@intel.com
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Jesper Devantier <foss@defmacro.it>
Subject: [PATCH v7 0/3] Initial support for SPDM Responders
Date: Fri, 14 Jun 2024 11:28:43 +1000
Message-ID: <20240614012846.1016856-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Security Protocol and Data Model (SPDM) Specification defines
messages, data objects, and sequences for performing message exchanges
over a variety of transport and physical media.
 - https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pdf

SPDM currently supports PCIe DOE and MCTP transports, but it can be
extended to support others in the future. This series adds
support to QEMU to connect to an external SPDM instance.

SPDM support can be added to any QEMU device by exposing a
TCP socket to a SPDM server. The server can then implement the SPDM
decoding/encoding support, generally using libspdm [1].

This is similar to how the current TPM implementation works and means
that the heavy lifting of setting up certificate chains, capabilities,
measurements and complex crypto can be done outside QEMU by a well
supported and tested library.

This series implements socket support and exposes SPDM for a NVMe device.

1: https://github.com/DMTF/libspdm

v7:
 - Fixup checkpatch failures
 - Fixup test failures
 - Rename port name to be clearer
v6:
 - Add documentation to public functions
 - Rename socket variable to spdm_socket
 - Don't override errp
 - Correctly return false from nvme_init_pci() on error
v5:
 - Update MAINTAINERS
v4:
 - Rebase
v3:
 - Spelling fixes
 - Support for SPDM-Utils
v2:
 - Add cover letter
 - A few code fixes based on comments
 - Document SPDM-Utils
 - A few tweaks and clarifications to the documentation

Alistair Francis (1):
  hw/pci: Add all Data Object Types defined in PCIe r6.0

Huai-Cheng Kuo (1):
  backends: Initial support for SPDM socket support

Wilfred Mallawa (1):
  hw/nvme: Add SPDM over DOE support

 MAINTAINERS                  |   6 +
 docs/specs/index.rst         |   1 +
 docs/specs/spdm.rst          | 134 ++++++++++++++++++++++
 include/hw/pci/pci_device.h  |   7 ++
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  74 ++++++++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  60 ++++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 10 files changed, 509 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.45.2



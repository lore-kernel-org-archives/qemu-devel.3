Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE581C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri26R-0000fn-Ld; Wed, 06 Mar 2024 19:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26Q-0000fb-In; Wed, 06 Mar 2024 19:59:18 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri26O-00083l-S1; Wed, 06 Mar 2024 19:59:18 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5a11dea5bbaso157892eaf.2; 
 Wed, 06 Mar 2024 16:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709773155; x=1710377955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PJRdTZAbO6gbxEb0T1+ByLlnMkr4u5Z3AoisKkRYfuI=;
 b=clx9d/snvuF4//mrxaATmm5cA/4/LEkJooEfWdGjErCHeN7W5y/NJnOVPbPUyt5GTo
 xt5xw8a5VBsvdem/oEKGaZj48Li6tF6OxrhOm+sCCc3ABvWR2wbpVEMTcem3eg3Ywk9N
 JbynGhMrBi5AA+Vvj1rMFWCRxMnfnD3eL1opnwZWINJ8rLVpnPjUJfUAKPL/a0G1H5e3
 f2Axz6kJWLVKvK2mityYgSxfpMXta+HStvUV3haNftdVrhCfJtqhTFGLuO+fLhgV6P8P
 c/KiDR2NgzOoMziBz1lLJJIYaFGUglilJ23Chm6wd1/eYpSQRhQZo1NYUW92ScFGC7dh
 7Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709773155; x=1710377955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJRdTZAbO6gbxEb0T1+ByLlnMkr4u5Z3AoisKkRYfuI=;
 b=lY+a9KELUNwqcldEBSyz2s9WKOjKkvivUXMhULywuTnSytlTZDjJE17I3Km+W39U8R
 wseojVpqUiqk0F7G6p1GSweT+lqK/QOGV01GqBWsbZwEf/yQPI+5/PilJdPB/iRXTbKK
 IJ/7w/Twe8BqLU2r5Sx/TBLSjSx5J99eV/t+kDBxs/AjT4cMwq5JAMjUSCW4NGH3kah4
 MRfyHfQGydmkR3bY/K94DZHpoAaRnWt8Plb60UbvPbQ9Qy9HFrdYZfyPEIPw1kRtnjHx
 RY3mxnLUnrVhdpldTnmOsOBBy45tHSJI4+PuSWvcImYNsv58vcfgSZ6kRUprY3+vQko7
 04xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL1nnBMumfS+4HG4IkhLgfEExXOI2E075q4lKzUO5aIdOmP/V1/I4EcojYAwTI8POMbn2hy79hk/205vhGeODPjaDdfGrVEQ1VMpqKcY0ONxlnESysU/qmZnvxlA==
X-Gm-Message-State: AOJu0YxXlR7sEv3ljjjmj01pB3ysEOTf/eCiEQ6vkZziN2iZpqwxL7nA
 mxQAz9Knvf/5O1jDgrAdSg4jLxKjV3/gGmQc0zZ+S6+3czNgp6ux
X-Google-Smtp-Source: AGHT+IF43FcMm1ra8FHJ4475cuSdABcCWdxrWf9CekDoMCUwbu5JaF7JeaDRybvA1NkhKZjqgpdUGg==
X-Received: by 2002:a05:6358:80a0:b0:17b:520f:8249 with SMTP id
 a32-20020a05635880a000b0017b520f8249mr7279170rwk.31.1709773154963; 
 Wed, 06 Mar 2024 16:59:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a63f815000000b005dbd0facb4dsm11420276pgh.61.2024.03.06.16.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 16:59:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: marcel.apfelbaum@gmail.com, Jonathan.Cameron@Huawei.com, its@irrelevant.dk,
 mst@redhat.com, hchkuo@avery-design.com.tw, wilfred.mallawa@wdc.com,
 cbrowy@avery-design.com, kbusch@kernel.org, lukas@wunner.de,
 jiewen.yao@intel.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com
Subject: [PATCH v5 0/3] Initial support for SPDM Responders
Date: Thu,  7 Mar 2024 10:58:56 +1000
Message-ID: <20240307005859.356555-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc34.google.com
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
 docs/specs/spdm.rst          | 122 ++++++++++++++++++++
 include/hw/pci/pci_device.h  |   5 +
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  44 +++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  53 +++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 10 files changed, 458 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.44.0



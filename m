Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE61C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 02:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZimX-0002Gi-C9; Mon, 12 Feb 2024 21:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZimU-0002GL-BM; Mon, 12 Feb 2024 21:44:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZimP-0003IJ-Gq; Mon, 12 Feb 2024 21:44:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d71cb97937so36816785ad.3; 
 Mon, 12 Feb 2024 18:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707792254; x=1708397054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G3F9Gd8U9ywd0P3vrvuvdWncBBtI5b2M3uWXWLuO70I=;
 b=R0lLcRtpPJS/rlKG2R/BuMBxRLowzm+GcN56QB2afhUZD9xyUMczi5Pl3oKiiUg/pa
 nReYVWYnrl8mIzEkWGEZyfleA7nb4xTxrfIG4A1Jg6Xwk0LnS0P6GdxfIndtOSbsCZE6
 Ga8n5j5c/lQtEUOJUkv3lxAoRlzndeo82lkd65/GPtVWYpqVzcv7ScKHC9ujTww4J5FK
 riuoU/1/01UFz1ZTJnEz53NRWe+GgO5zKHpOD90BelcCiL0RHNnun+20gFpbklNKroja
 aFC5hV8zqWl6kZAwLEuG9fzukR+K3JOxKcWB8VOdaGZJfAsfxx0ceLHMGTKFNM7xuxvk
 2Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707792254; x=1708397054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3F9Gd8U9ywd0P3vrvuvdWncBBtI5b2M3uWXWLuO70I=;
 b=bcqk0XuGEPmVATfLxG5vb2/9C8j17vYJ8h2kbn3IWP4id3HZG81NTQCflxYsqIvZ04
 oU2bmmn4fAV3qllnehBL/aKvgFyihm76rV4XTsoc4PSv3ykPiThnqToX0s+o4R+c3b81
 SrfA6M9GQlmqI+B1IoRsOgSjSVk3OX1RDrlNUmyS8+OngvRoxH/mjgTePzOjALAIs+Ad
 WO2ZsWuueROOaQd9au/kpZdJNhgOsRz4PAmkT1G4XWTgnWs0rbhEeleqqOje0N1xv9bK
 TP+PU9GMcDlAXh5m3+63HohAVcdRY0lHJlaOM4KLgZJ6gdmOn4I37mAdF23i0tSGh60p
 pb3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTxKqbInNYrZVsXIVjutcK+K7eudcC6hUti4gCQv81NBqsBzzExLMf4zcf8ow4zv0Cyy143adIFSuMCvsFWggT2osWVNrAIVbSXKufBEICwplm0L9HVZymaDmyXg==
X-Gm-Message-State: AOJu0YyTv1MvjdPCVsJLt64gykYsymCJ00RQqmAKOZpm783lp0voBwPE
 oqD3RQ3fH/cURg1FPygOrfLDASaW4Nd0qFKkLZoyISh9t27QSqTn
X-Google-Smtp-Source: AGHT+IH68HQ4kVAk5P1WyvaP1GVFTOjuR8zGLlxpcst8CCWf+ZfNS40sdMvSyNsFVR8xKy0DlbgFKQ==
X-Received: by 2002:a17:902:cece:b0:1d9:a601:798b with SMTP id
 d14-20020a170902cece00b001d9a601798bmr10981740plg.54.1707792254319; 
 Mon, 12 Feb 2024 18:44:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXhiLch5oCS6eHDFoT1MYFElrxinCZwM9m37fgmKzmZ1nZy2VfJzixuTsVXfgdYxqp2BovrX9cX78U0MuZFZIVloZoUyzYW9Lx7W6tP949HNwUPGhY/yAkHxDSQ8TmFcBeU4Za1J2vTCCerN/BLqzcrgEaE8Sh2T2f722h9Rrzj/LaTqEoWT+JH0DzSVgyW/oHfrG8nVuBIXBtkIV77sMGTOsGuu0WrXLjKpppK6z5UBi9xEapAu5ZzVuyQQyOxPDs3H+MVokgUy9pLGK+QunFrGYK+TLOxLNKq69xUkjZ9B6/1fjiuys6FNif5QLrraI/waz2DPbSYCoKn//kSxGCYYz4BaDTQULa650YoNrawMCTYVTPX/+4AeAOcYY9jwcA0Skb4Re/kBBtG7LnGpi5jZkguBxYwbx1re9KNONATFnlJRKJeiOMGr9tcacwUp7x3PNu+
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001da0a698095sm22852plc.282.2024.02.12.18.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 18:44:13 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hchkuo@avery-design.com.tw, kbusch@kernel.org, lukas@wunner.de,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, marcel.apfelbaum@gmail.com,
 wilfred.mallawa@wdc.com, cbrowy@avery-design.com, mst@redhat.com,
 qemu-devel@nongnu.org, jiewen.yao@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 0/3] Initial support for SPDM Responders
Date: Tue, 13 Feb 2024 12:44:00 +1000
Message-ID: <20240213024403.1060188-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

 docs/specs/index.rst         |   1 +
 docs/specs/spdm.rst          | 122 ++++++++++++++++++++
 include/hw/pci/pci_device.h  |   5 +
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  44 +++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  53 +++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 9 files changed, 452 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.43.0



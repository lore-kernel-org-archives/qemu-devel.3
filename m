Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE44C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 01:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjUGh-0000ms-SH; Sun, 10 Mar 2024 21:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGf-0000mU-KB; Sun, 10 Mar 2024 21:15:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGd-0004e8-HY; Sun, 10 Mar 2024 21:15:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e66e8fcc2dso2285667b3a.3; 
 Sun, 10 Mar 2024 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710119749; x=1710724549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zro8u6FVcypLkyyfYsTU7NuzRupgoFOUkIzN00+4ojU=;
 b=WUNxX01xyOrC52RRk/pTQRG7dUCBNW/4RnWh1540l1RiNo3OFsdQDLOrUaIXjthMJz
 dXgNGRAlyxJP935U7f/ieK/dgDw2y0QI1y0qEZS+7iBUwV2j4RG2XDEy61mFitPNu707
 vN9bTabLdSraMziAH6itYza//Jr1/9VH2FzT+lov/JG/oCPM+66N/d+vRIO9C0oaGymz
 urYolL9B7KufungkU93ldvASY8l8Wbl70HXWzALUTD6WWMVhYPi8yMRUqnYjHRJdCGkQ
 g9/4HQQLXibhTUZ1EKUo8S99/GiJhDpFzTW1cC55LnYyHRA2Q3cNMUReaigGrhQV0syi
 Oa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710119749; x=1710724549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zro8u6FVcypLkyyfYsTU7NuzRupgoFOUkIzN00+4ojU=;
 b=CW9+SeesRUUT4KzPiFI+t0OqXu+f2Ef++1yByKIKIBm1nyDC0NKjgnkFYFp4R08xlq
 pJA9OcsOeZW05VURGfbcngz9Uetags0ZDbqClWG29ecryM7j6xyFoVoD/umoChmpsVzy
 QUnCrrT6jlcQv63Xp2fNXSbCrMnuu25AEWGDFczlme90Zr2ahLBqOvJNCathTtjgQZYB
 Omi9F6/q7ClIbWRbSkDYS85+uloVgm3NDguHAONqZ2U0TUYjbJ9YVGnl+4EDJFMHAFlh
 Wq/zOcj78vG0Rd3Bt8qvkrN0nSP7wS2Gdozvy/jIfKjKxLiRlD4XmE1b9RbuGdzYvNTh
 oEnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOEFmgK/bVc826sLy5WjVIW4gFbw7fpiUbUxIrdCdZSno2+tOxp9SDZdtWMZwTEoZ2IxuQ2AwgIdN0/pmlGkLo5ISeewI=
X-Gm-Message-State: AOJu0Yyc7I9Ho1DzfiWFnNaVNggOfjJlMbtUvpDbFF7a3+GAmaFqjfAV
 q4shmnxF2uHdF5rmDOQ3Wfvsr64idDFKvyB+bnqcnjVF2+D1ewjxZ7xIzwEU
X-Google-Smtp-Source: AGHT+IEQyJ4u+wkGl+NkZSlXocF3edARYwIZvXFNnbahLnePQOB05/Xo+C36ggZDcG8inEY00zZRkQ==
X-Received: by 2002:a05:6a00:1994:b0:6e6:581d:adbd with SMTP id
 d20-20020a056a00199400b006e6581dadbdmr6172443pfl.29.1710119747455; 
 Sun, 10 Mar 2024 18:15:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a62bd08000000b006e68984419asm92116pff.105.2024.03.10.18.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 18:15:46 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@Huawei.com, jiewen.yao@intel.com,
 mst@redhat.com, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 marcel.apfelbaum@gmail.com, lukas@wunner.de, its@irrelevant.dk,
 wilfred.mallawa@wdc.com, kbusch@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com
Subject: [PATCH v6 0/3] Initial support for SPDM Responders
Date: Mon, 11 Mar 2024 11:15:34 +1000
Message-ID: <20240311011537.65043-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
 docs/specs/spdm.rst          | 122 ++++++++++++++++++++
 include/hw/pci/pci_device.h  |   5 +
 include/hw/pci/pcie_doe.h    |   5 +
 include/sysemu/spdm-socket.h |  74 ++++++++++++
 backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               |  57 +++++++++
 backends/Kconfig             |   4 +
 backends/meson.build         |   2 +
 10 files changed, 492 insertions(+)
 create mode 100644 docs/specs/spdm.rst
 create mode 100644 include/sysemu/spdm-socket.h
 create mode 100644 backends/spdm-socket.c

-- 
2.44.0



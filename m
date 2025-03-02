Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782E1C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 09:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tofN6-0001By-KB; Sun, 02 Mar 2025 04:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofN0-0001B9-V0
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:24 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tofMx-0003In-Pv
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 04:12:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349dc31bcso61503565ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740906737; x=1741511537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DN86mKl0zW+WcZeCQCQRUKlWU80EaiUKlPYzAriTbGw=;
 b=VwYKV44PAcGFnFBNDXCbpMEaIdc97nP26sjOamtOfrtMGu3tZsmA2MtwCHc++7xt7f
 60qWtjt/ZPg4deM16zQlvJRQrPrtNNx5gVMct+nuP+ZomSzD9v3fuZF9iwU1aKFKgTk1
 V1kg2bEaDu4kk/vSKZ3gnBFw3SR1pr4vB7kgTtAgPm4FvIF5tb0m2kA4oLghbu6xO8es
 0eOMH0KPRagwfN7pbdThCO7a3br6rss4xPeOEQCEkqiMrJQ3yBLkLlomXU5VP+JDUBnR
 tMFVadvx6uYY/EzGmQTyjcCF+fVo+witebG/zuOBVnm3d7XwT3OYTrV/gQlgDsXUlejj
 G7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740906737; x=1741511537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DN86mKl0zW+WcZeCQCQRUKlWU80EaiUKlPYzAriTbGw=;
 b=pJ7i8uvm4G7X9XrNjk1rITd0JoBPSgNxdf/3891jiJdyZwUpDxKSzNciOliADZ9qkN
 2TBXWBdTFU34aYXF4xvhylxRR6h89F/wrA50f49aRBpOToNZncyON2MHKpzXjPuUz94K
 vFV9c2eHqweNdNBcLmZsqcGx3+cnX53yWL/jlnOhR6Ql7IAaqsCK+RyCMnK+kY9vxaRY
 2xJIO444zaipXbgxFvayJuHG0T/N3uRw+ZKkxqL/0Df6hzdMiFGXX1VtmLuPySq4sOP5
 Q1A/1a7uldYMFW8Y0orT4E1zMpl3YJgAucEWtWGteauq01IcPCgikMl91cPqEAGHDHj0
 aasQ==
X-Gm-Message-State: AOJu0YwK5lACE1PnHOLIunVinxBJgm0quW7q2+Rrf628/5lUNGAYcSM1
 C6auPYrYrTEhDz8GWK8pyVEpvIqpMtEoqwSg+mmBQ7bR+wx+byuTxIjS7987wJZdZJY4vvFSgAL
 wxIYXYAfcegoxsGldLVsitxdMDC+gJWJ49QCQq/IQoe5iNMCZKkF78bUPfyM6QG6yCZfa4YPMW2
 0l6btuhKijMKg5WnZccC+8EJOCIAwX0/AbE8LW4OI=
X-Gm-Gg: ASbGncvCwWm2U+6p18bkyAXaW1zNJH4dBd8YWYlJeG4BM/l/LB+kMWiEtsszWD6DP7N
 4Y/YqGxDoFovx3alk9u2q6PvSPHtsPr0YAZ8UfWix1uVivOMoAczPvEX+wwcv1LizNtIo2cNlWL
 RSPct3IjpQpo7mpIDb2fYJ1scxThTsU5ZbmHQhQnz1kMjzfRVoJjFP+P5bo7x4o3seRswzVE53x
 /B51iK1xpoKVvB0vTWyrpMBGSizo3k+1KOXxLekJq8s7tdY46tEhwby3DIHg7gy6oGVmg4dYIRS
 qQ0dzhkBdNA0AIIiddN/az3B6KfzNp47f73OJB+YpbHRogH8lWlgHWJencK8XFeuQb6i2nkH
X-Google-Smtp-Source: AGHT+IEGrjImPNjdfrQ9WibLY+IfqFcYZErIXaAqJjnRR008HZ+pLE76qkA0Qo6ta0IbCxJv485kVw==
X-Received: by 2002:a17:902:f693:b0:216:31c2:3db8 with SMTP id
 d9443c01a7336-22369213455mr153550775ad.37.1740906737407; 
 Sun, 02 Mar 2025 01:12:17 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736310abc8csm2952616b3a.77.2025.03.02.01.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 01:12:16 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 0/3] Enhancing Device Identification in RISC-V IOMMU Using
 Memory Attributes
Date: Sun,  2 Mar 2025 17:12:06 +0800
Message-ID: <20250302091209.20063-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patch series enhances how device IDs are handled in RISC-V IOMMU by
leveraging memory attributes.

The BDF (Bus-Device-Function) is now included in memory attributes for
DMA operations, ensuring accurate device identification.

Since PCIe bus numbers can change after re-enumeration, relying on static
device IDs in RISCVIOMMUSpace may lead to incorrect Device Directory Table
walk. The IOMMU now dynamically retrieves latest device IDs from memory
attributes.

The bus property, previously used to set non-root endpoint bus numbers,
is removed. As PCIe bus numbers are assigned at runtime and vary across
endpoints, exposing a single property to pre-set them is unnecessary and
incorrect. With device IDs now retrieved dynamically, this property is no
longer required.

Jason Chien (3):
  include/hw/pci: Attach BDF to Memory Attributes
  hw/riscv/riscv-iommu: Obtain Device IDs from Memory Attributes
  hw/riscv/riscv_iommu: Remove the "bus" property

 hw/riscv/riscv-iommu.c      | 15 +++++++--------
 hw/riscv/riscv-iommu.h      |  1 -
 include/hw/pci/pci_device.h | 10 ++++++++--
 3 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.2



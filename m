Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF800107BCEE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1DXn-00010C-KP; Fri, 13 Mar 2026 21:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w1DXm-000100-IJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 21:11:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w1DXk-00059H-Vb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 21:11:54 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35b85613f3fso454879a91.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773450711; x=1774055511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NFPoBFJkK5i3DJKfu4yDGSGfVFxkXleFqejv/cpH+vU=;
 b=EjW1TCmBCdCZv6umI5H3yitzNw3LYhuu1etrgaI6BhxgG3VtT/k31OdH8yk8/AKpjf
 CzaoGHSu0TvgcBTcD45kdGgu/kyeDhsDB3ts5/RaA+gexukt1kPMUJbLBonjAOMLeLLP
 cszjdUxxubZ6lIwhqQMrG+Z0Bg73Xx2/ZeuLEddiDpmxx3T1qq3zSmP+uPZLZnjCgstM
 8jY/r8Ab5cDg4b2FjKdc5TR4H/NqqpJObQKgr6H6eXO8WKcP2ofNXPnU31hraocwQbKq
 kv3C0dv7BSt+dnUoaUrUWSsvgWz8Sq+ZNQBy6dikPIBCrGH7QOIHOB5T+CCYFwPrzK34
 GmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450711; x=1774055511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFPoBFJkK5i3DJKfu4yDGSGfVFxkXleFqejv/cpH+vU=;
 b=qvgHKK5CP35LD25IbVqkkJAmKmdYZxmgdRMq5s54nhMbHtttIDTojN7FnFo/iRu38B
 hL/nSn9Vxr/vSzITfgYw+Yxov4ioMBpGPO8Wmq7pRTZsyaE8HWIIAysH4MRNEOFBw8j/
 f8N6A28A57nyyzZ3f3/9FyFgXbUGLxHmRJVS37w1tEDp6MDjlOGtEwdC/8yF5/TYjuW7
 rcOXGIJmvm4UT4hjwH/5yVRN72Q/wEOrzi7dLhlHdaUCGjHvD/FQ/ATtr/Zlj24ZKrhk
 WILWPcl3rYrJlvj4A7tUuF6fWnOvKrQ8uMsHAyHtGsaXCOgupbLOzYdLDcCWhhWWJIMz
 zxhw==
X-Gm-Message-State: AOJu0Yxpyrhi/E/Pp7C/vRi91y4a5HRLInIMr0DdBhopKeo7mZj1m+KT
 bWOtwsDBycwuOGb2qOyhz5suEYlNSgbYtvaLtdwShHBlAehxKU3oizC0
X-Gm-Gg: ATEYQzySD1b3tX0P5oSvv56hifJxxQ49zKo/34tj8aatrxuJ6cO2QAIWtBFIg6FploI
 JBt0r+loY3IBdwz1r2K2O+l6TzFoNHtTwGAGg5pFT1xWHJGx/Wco0LyeKiVevdoXCWCbbjlqucR
 kGe3TRl4BMPyxs/dPmort3r57/XeGNWI5rMJReoKMu3RiiSEI7B3IylaBatCbvmCm6Rp0iBboFC
 gTDXASwCO0HaFBWdtEQtMQE5qTwWcdOvOep43fICWiJpuz9zQLlr6Z4JwmxUBzklUF1VtIZLTp/
 cAzWOLweKa8vQeXIdYGCnsLkyuaqcSuMe+ePmSVYkTYxr6UcSOqj7fpeGJPQmduWXq8Gtkxs7KL
 Il4kw9pjUsFfsZ7J0d3r0JEEKly8Bw7HVBLBadU2Ifmx7bh7hF/C8vWvw+tMjYB1OyHQxwlHELa
 Lqx/l6YL93HDMoQswSnu072EbxqfE=
X-Received: by 2002:a17:90b:28ce:b0:359:8190:eede with SMTP id
 98e67ed59e1d1-35a21e795e2mr4814748a91.9.1773450711122; 
 Fri, 13 Mar 2026 18:11:51 -0700 (PDT)
Received: from orion-o6.tail020997.ts.net ([2408:8352:441:f661::1008])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a2454a7bdsm1248545a91.8.2026.03.13.18.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:11:50 -0700 (PDT)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH v2 0/2] tests/qtest: Add Intel IOMMU bare-metal test using
 iommu-testdev
Date: Sat, 14 Mar 2026 09:11:35 +0800
Message-Id: <cover.1773450180.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=15fengyuan@gmail.com; helo=mail-pj1-x1029.google.com
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

Hi,

This patch series adds a bare-metal qtest for the Intel IOMMU (VT-d) using
the iommu-testdev framework. The test exercises address translation paths
without requiring a full guest OS boot.

Motivation
----------

The Intel IOMMU implementation in QEMU supports various translation 
modes. Currently, comprehensive testing of these translation paths 
requires booting a full guest OS with appropriate drivers, which is 
time-consuming and makes regression testing difficult.

This new test fills that gap by using iommu-testdev to trigger DMA
transactions and validate the IOMMU's translation logic directly.

Test Coverage
-------------

The new test provides:
- Legacy pass-through mode (identity mapping)
- Legacy translated mode with 4-level second-level page table walks
- Scalable pass-through mode (PGTT=100b)
- Scalable second-level translation mode (PGTT=010b)
- Scalable first-level translation mode (PGTT=001b)
- Root/Context Entry, PASID Directory/Table Entry configuration
- Complete 48-bit address space translation
- End-to-end DMA verification with memory validation

Testing
-------

QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
  ./build/tests/qtest/iommu-intel-test --tap -k

Changes v1 -> v2
----------------
- Rebase onto latest upstream to resolve compilation errors
- Add scalable translation mode tests (SLT, FLT, PassThrough)
- Add spec-aligned register field comments for improved readability

Thanks,
Fengyuan

Fengyuan Yu (2):
  tests/qtest/libqos: Add Intel IOMMU helper library
  tests/qtest: Add Intel IOMMU bare-metal test

 MAINTAINERS                          |   6 +
 tests/qtest/iommu-intel-test.c       | 215 +++++++++++++
 tests/qtest/libqos/meson.build       |   3 +
 tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h | 191 +++++++++++
 tests/qtest/meson.build              |   2 +
 6 files changed, 871 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.h

-- 
2.39.5



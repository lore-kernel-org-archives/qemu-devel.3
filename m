Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA91AE83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8p-0005wc-Tz; Wed, 04 Feb 2026 02:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnTDv-0000Io-JY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:06:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1vnTDu-0000tX-2I
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 22:06:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a76f90872cso33622125ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770174392; x=1770779192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mp2rfzKx0Kqq49FxMaXhsIyc0nkN2IqnShCc0+qyC2c=;
 b=ZRR6WG4IcpHu1i7zsyh5Niw5HNCWeQLp4SmefGs8qvf7eBmasLZXCfc9h5MIXs60q3
 soe9bdoNdgiaT07tSuLgjS44LiD9ZN6o0c1WjAyGPNNwSRwPS2R+ojrpLxqm9LCFboBN
 /Pq9x3Sj1Not+01TOF7YPlco+1RvvlYcrvnMWZA5kzFqH24nOsNcIZm/qyUHhfQafQct
 oOg6hx6jaAfC0xno9v0TiY8Zp5M6M83FGxFAaWYCz1rslLXStn7fznNgtwT3bJRWkzE6
 AZh8KL6AShDKXzjhg46i0eFvwToIglzpGdeTHZ3RTotJ0H+d+yufaH8rfSKH9OQTRmAs
 xWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770174392; x=1770779192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mp2rfzKx0Kqq49FxMaXhsIyc0nkN2IqnShCc0+qyC2c=;
 b=BpqmwM/9TZEiwPqDwP75YOtz9RViiv+Z0t3klpSbU31eGTBxdH0EcxqtNSW4Wf6FaQ
 aTFakL1FkciWAR54ikZ3Z9NNlSauNmz/5Rwxqpe63Tg16+MQ2LpBuGmRzT7+fBYVCOxT
 GPKn/Xwaabje/+0KKYltPXKAKVePNvCxIjd9zR9XEItsVrt4gAmlpMLls+7k9/buhcHj
 gICZtCwJVFk7+uDllWbAqO2VNaU3H0kBbquCeV6r5o7jRgHtNLMcaH8ZUd3kMOoEO5pZ
 7TPuwErW8ssgZJJtIVoLtJUfhBNeu6BIVndbqCEFUFrVzpR6oVe9yTa/CnI0Zyfr3sae
 pvtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwLpdZpTYisTbUN4wUJNK9F7XRiK7z7sHcXn07QJlsCOHiKGJcijbXDhxidDZrnxW/5Rfy2nXCOAMq@nongnu.org
X-Gm-Message-State: AOJu0Yx1P7+yAuUWOLaU9k6fDocpDDTuuGAh958vzekwyuuk46vINUSG
 +DEw8J3fyf41tU8F7RR8BRRSOiV08ml8ETQZdUd1HBOizXBeUg4rtUUn
X-Gm-Gg: AZuq6aIIdgsK7C0rte2au/OCiKWloyWmkXmDwqKEaKdQRMguHakTh2uTWGlaIIy+mFc
 +3E1pm3iHfbVmnh3z7wnYisC0D2ihG+3cRMl6EHNBkLVSkFsn3dzUma7Kts3Kk2yREO3zG3z1SV
 T0/Sy8RAI7ec7ko3gs14FPGSybq5Dkg5bJH9NpbT03mzjIU0TUi+px7Xn6+cT783YUJRS+ELDwh
 QaBa0ysPrcFrqUVdXAcni5E5gXA7FvLS/bq9682z6wEEiLEQE9ApdWQfvH0WIoDNf21pdgPPyzl
 7fCPjs3R5QaXTGRdnXmarnNKXuR84MZ/ptWIKuSXG4IHDisQ4+HU51VZTVTN6dahvVKL21JBgyX
 5MelagHdGt69Wd4RezOqtIrd0PnfY5ba6+mMhIJ9VhPSmS7fu08yDbgs/ExdTP7A0Zmk13Pe8Gr
 7n6H6FaNB4qikF+Esxs1wYuYN+5Nv8XQIF
X-Received: by 2002:a17:903:1a44:b0:2a7:c340:4c44 with SMTP id
 d9443c01a7336-2a934112594mr13975985ad.54.1770174391907; 
 Tue, 03 Feb 2026 19:06:31 -0800 (PST)
Received: from orion-o6.tail020997.ts.net ([113.247.230.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93388c7c8sm9156735ad.30.2026.02.03.19.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 19:06:31 -0800 (PST)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tao Tang <tangtao1634@phytium.com.cn>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Fengyuan Yu <15fengyuan@gmail.com>
Subject: [PATCH RFC v1 0/2] tests/qtest: Add Intel IOMMU bare-metal test using
 iommu-testdev
Date: Wed,  4 Feb 2026 11:06:18 +0800
Message-Id: <cover.1770172615.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=15fengyuan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

The Intel IOMMU implementation in QEMU supports various translation modes
including pass-through and translated (4-level paging) modes. Currently,
comprehensive testing of these translation paths requires booting a full
guest OS with appropriate drivers, which is time-consuming and makes
regression testing difficult.

This new test fills that gap by using iommu-testdev to trigger DMA
transactions and validate the IOMMU's translation logic directly.

Test Coverage
-------------

The new test provides:
- Legacy pass-through mode (identity mapping)
- Legacy translated mode with 4-level page table walks
- Root Entry Table and Context Entry Table configuration
- Complete 48-bit address space translation
- End-to-end DMA verification with memory validation

Testing
-------

QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
  ./build/tests/qtest/iommu-intel-test --tap -k

Thanks,
Fengyuan

Fengyuan Yu (2):
  tests/qtest/libqos: Add Intel IOMMU helper library
  tests/qtest: Add Intel IOMMU bare-metal test

 MAINTAINERS                          |   1 +
 tests/qtest/iommu-intel-test.c       | 137 +++++++
 tests/qtest/libqos/meson.build       |   3 +
 tests/qtest/libqos/qos-intel-iommu.c | 566 +++++++++++++++++++++++++++
 tests/qtest/libqos/qos-intel-iommu.h | 299 ++++++++++++++
 tests/qtest/meson.build              |   2 +
 6 files changed, 1008 insertions(+)
 create mode 100644 tests/qtest/iommu-intel-test.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
 create mode 100644 tests/qtest/libqos/qos-intel-iommu.h

-- 
2.39.5



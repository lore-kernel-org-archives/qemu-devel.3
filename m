Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE6606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KIjD11wM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSrVr-0002Sk-UW; Mon, 16 Nov 2026 02:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrVo-0002SK-HN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:52:24 -0500
Received: from mail-pj2-x08.google.com ([2607:f8b0:4864:39::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xSrVl-0006Me-KS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 02:52:23 -0500
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-3adc0ac3564so810321a91.1
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 23:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794815540; x=1795420340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6yPZXP1t+vVtD0mPvOEpQHJHUsiUdHW2IcAv18jj0gs=;
 b=KIjD11wM0f1sxXeiLxvMre85QYMSaI5YHXBRts32JP5X31Q5a290+0dMufaprp9yIz
 xp4jz15ODuQ7uzcUfc3VERrcjUQa7grll23YLeNiUhVMI6uLqlL8JeSK7E4ECthD/n8U
 VOnHmsOMJOjSVbjFi2a5LUNoQDI5BlII0zOoKyOif6vbBBsXAEBK+HcBmNmeF2NVyeEf
 7e6hSR83eFDXieZPA0mizdYjrX/KJ9H5SvF9DxydfIe29nbg7/TxYapu0/+oUSlG5UxN
 xwUoGaRubyn2dfHUm3dbGniuAtt+MnIWamuXhQIFe2kB2XafZmB58vYc+zkhlaegIHe7
 NYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794815540; x=1795420340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6yPZXP1t+vVtD0mPvOEpQHJHUsiUdHW2IcAv18jj0gs=;
 b=bypPLUIFg4I43MqxMrl1xlrMsGFKZU3ibQenGmF0o89Jo2+V/S7EZGiUjG9sB/KIt7
 xM/ZxRCPfxh6TiDNzBB3vGuEKJO+TzTuLzjI0Z1fAAww9K5OUiVcGOkhqxn/FIykAb0L
 mKMjmT26Pz66TKmqi0InbnW2OghE4kxvVVt206cnYLapmXqIxSScj01VudTtiwhT770n
 IYHU/H7aA1Ow2hFWNu2QP2+NGGgISfQhyNjVcpzbc7tjV//rMkQ6WkHVoDc/q79KgOIl
 rPKvljm4wc3lUSjyPcc+g15tEgLIRlIwqv0tTXCb3W/IZex7aOuJ75vXF6oTonyOlv9j
 r2NQ==
X-Gm-Message-State: APuU4Z9FNvXmqWqDjN9+GZXTRoT6SJtNMGjYfGQxoP/gDDe1rhocyjqn
 50lEb3xDufXUZHMKGcBdMdrxJ9TBTEPh7JZG5d7F3u9k+jxOPixUTIf+WU+mPUytp9tazDebVW0
 =
X-Gm-Gg: AZFdTZfmTONHTs6o0W0bTAninTak9i7vMV/yNhudGZeuXAw6Lo0k9LAO5w+iyeSieC/
 9V0OD9J71hJuwOSbrtzeC7aLOvVT2pcggWOgz/nmg44/H1U9HOnJaNnF8F1giiuKUXTj1Y+bus1
 4p6r/YGfpkfjRHo97I67WkkO4QcLjHDCGMd4RXFghjW5Y84AWnT1suqErcigxfCkHIwRbCLQCag
 jUxwdu4xKIt1GjFmYIZiLWMYfsWm+34Qx6JpV+Z/V3DzsMzprI8cIjffauCI8KzfWCCyosLJpFk
 NUeBccJhoNLu/b9JJp/gGng5gNx4PaRJyWFZ6HkxlRmJFZWFQckRK8oj4IUVY6U8sc5aOrZG8UY
 rksoJflZ/rbFKHsyKfA8SMmKadlfbVf04XwHFWsTYD6Aidt2yFYaKU+dxjtiLjlx5L47rRigunG
 qTc7zXhuu26fXQo8ZHuAC5lQMA/O9B/uazKX1hxt5Th/a7uyyXvCfqstIRgGePyaFltMrT4dSAp
 1bqSF8U6qDWNRtk5K+GgYAJ6sCthjWHFzptwoFT/kAqi++woFVLu3nxIZY4rBFXK5LFRqSC3Ssr
 FSPnV8wybs9gl9amCwkXoyFxdE/9wDHTZQMH/qN84HOci43DVlBcA/sY
X-Received: by 2002:a17:90b:3806:b0:3a8:f70f:2437 with SMTP id
 98e67ed59e1d1-3b1b0b53ad8mr8766331a91.50.1794815539215; 
 Sun, 15 Nov 2026 23:52:19 -0800 (PST)
Received: from Dell-WorkStation.localdomain ([152.175.67.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f6e0sm20745622a91.9.2026.11.15.23.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:52:18 -0800 (PST)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 0/3] hw/riscv/riscv-iommu: Correct MSI fault records and test
 trap handling
Date: Mon, 16 Nov 2026 15:51:38 +0800
Message-ID: <20261116075141.167317-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::8;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x08.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series corrects MSI fault records in the RISC-V IOMMU and adds
regression coverage for the trap callback.

Patch 1 preserves the original IOVA through MSI interception, recovers
the GPA for MSI lookup, and keeps internal recovery walks out of the
modeled HPM events. It includes four firmware-independent MSI qtests.

Patch 2 separately aligns MSI fault PV reporting with QEMU's existing
PDTV policy. Its PD8/DPE regression selects default process zero and
checks PV, PID, and the original IOVA. Complete per-request PID-validity
metadata handling is outside this change.

Patch 3 shares the private callback with nine deterministic unit tests
for recovery faults and ordinary-DMA fallback, without adding a public
API or runtime test hooks. The context stub uses a distinct release
reference so cleanup checks cannot confuse it with the context.

Patch 1 can be applied on its own. Patch 2 builds on patch 1; neither
requires patch 3. The refactoring and unit tests in patch 3 can be
reviewed separately if the private implementation fragment or test
structure needs further discussion.

The series is based on QEMU master at e9fa1f66f0d4. Validation covers
RISC-V IOMMU qtests, MSI trap unit tests, the MSI regression probe,
and an x86_64-softmmu-only unit-test build with -Werror.

The initial local series was also built and tested after each
individual patch.

Issue: https://gitlab.com/qemu-project/qemu/-/work_items/3562

Zephyr Li (3):
  hw/riscv/riscv-iommu: Preserve IOVA in MSI fault records
  hw/riscv/riscv-iommu: Fix MSI fault PV reporting for process ID zero
  hw/riscv/riscv-iommu: Add unit tests for MSI trap handling

 MAINTAINERS                        |   1 +
 hw/riscv/riscv-iommu-trap.c.inc    |  69 ++++++++
 hw/riscv/riscv-iommu.c             |  61 +++----
 tests/qtest/iommu-riscv-test.c     | 181 ++++++++++++++++++--
 tests/unit/meson.build             |   1 +
 tests/unit/test-riscv-iommu-trap.c | 266 +++++++++++++++++++++++++++++
 6 files changed, 525 insertions(+), 54 deletions(-)
 create mode 100644 hw/riscv/riscv-iommu-trap.c.inc
 create mode 100644 tests/unit/test-riscv-iommu-trap.c

-- 
2.43.0



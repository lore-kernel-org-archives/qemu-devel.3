Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FF7FEA803
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GM4-0005b1-IL; Wed, 25 Mar 2026 01:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GLy-0005Ww-HF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:00:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1w5GLw-00078L-Bv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:00:26 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35a288a2c00so917274a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774414823; x=1775019623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Dnt+PDDAZp/+TV963oEFZh4GPDRIAX7fgbJmYYOAko=;
 b=IuBGKRbBg8zVrtWJmtKQM+t0o/wZouY90oAOyUO2g+KTRkWIRsKLaciD79cSUf26wo
 nwB61Gn22FCb/gU/QOxVMMYtdOQ+d5rhRhq3dC7t2LlVWeKbIQB4J9fgtcS0flKuZmOe
 VtsWjmy1WCSnX0bUgP3LRds6UD/r+yKkwoa60SUOGA6ZsgsvOGDk/3NKgSkhsgHI78Vk
 UFGNfUrAe9gxItK/8CqZ6krEdIlZ+GOSuEb/Xs4T633WisLskJyTw59JxK0vdThpcyxA
 JmZVic6AfZL2//6ntmr5cDeKdiDE8NzTFkptT3KLTwFlk5MzVyWP02Y7BFC8oga4xMiM
 ceaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774414823; x=1775019623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Dnt+PDDAZp/+TV963oEFZh4GPDRIAX7fgbJmYYOAko=;
 b=oYpjd8+/EE1GezLIkQoCWRRWRhs7P9L2OlSp32PshXCxjzhsJ+UTLw6DV/LtLhArQe
 JQYiZ6BY1u8suDD4xhiZ7bzjQS/mgjXs/A4EvJP3aVArBcoB6RzCJ4TMZ/Ng1cWQ7SDv
 z+6Ud12F6q5mi3Dt7s7ftkNPTPdojU4DDa5jdVQSWjgHHhi7wii4Ge8z7staP7VJZWtg
 P/hdahqpXxWTO3bNkfz0b9qlw0lTyjeI/HP76/onVGGKAd7PySA+xGHT/DhBue73S+hH
 0fF/5IKknbU3cmjqu1JlllRWFmAKKCYxesmmcw+GgRmCvQcoVRjYXYxaBSLny3qZtokJ
 xHuA==
X-Gm-Message-State: AOJu0YzllomEa0QaT7Auu8peWiclv9lKtWWq1184M5+9FKBxUW6AE0ce
 s7eoCdGO2IAolYj4p+hiAqTbqmMGUIP5IL8OK4A0n+BtDCaNitljps3hn5wpdiidTkm9JCbalRv
 fu0qSWM63UOkcug6oySGlOcV9nV6US8DS31VQBegcRo7T/h0SDicgi8m5L6TIa/SQNQ09zJlJmk
 okoZxAyH0cHNvb9zTstS/VdydjNSQ3xtf1kCmkDkb35es=
X-Gm-Gg: ATEYQzy+BSxUoRYy18u9hw1sWq1iaEmvqtHXUUanzLiUn+JKnk3a9DAAtwXbxiUbksY
 wkOWva4xlI+uYg9dVuHRN4z3rSzTMeo5RyOKmnjggEuzFnN58TovquHuz1Gkt2crBd9Kh2ThEyU
 hkfHfWteK+dTl/rydOuSQ8+X2sXXD2k/pd3qbKr6Ez7gUTgWBqT+5OeV8nYjBn1L12zYhyayXIy
 eMsS5wuhwkeQYc/tF8/wkkJn5ifiIDY6LvncHdHfSwE3xV2UPkGe4kNAE3Yjb8917rmfJrCtKkC
 7Sn/Jd55YeCbp0InwsNcxH4Bz9BLIDEJS6KMnglKa+/4KVyRKcRd+ctuEo5+FqvXLZJWn8iZKNW
 ty8dtC9VUA3yIATRiGyqnzYAk9nVKDEp4Cc7l3x+chQ4P44btYtAWxwJccEGJi9wUAh3hZuDcef
 CcOAxsqlIHHmk6mOTg6v9uSIeiBK6XSvSJKzuozBvKubr+4oI6Pe3Q6kWeNJ9dCw==
X-Received: by 2002:a17:90b:164c:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-35c0ddc503bmr1804841a91.23.1774414817611; 
 Tue, 24 Mar 2026 22:00:17 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c03149db2sm4218866a91.9.2026.03.24.22.00.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Mar 2026 22:00:17 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 0/2] Bug fixes and IPSR.PMIP support 
Date: Wed, 25 Mar 2026 13:00:09 +0800
Message-ID: <20260325050011.66722-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This series contains two fixes for the RISC-V IOMMU implementation:

1. Fix a bug in the HPM (Hardware Performance Monitor) timer setup where
   irq_overflow_left was not properly reset, causing stale values from
   previous timer setups to affect new timer behavior.

2. Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
   (Performance Monitor Interrupt Pending) bit, which was missing from
   the IPSR register implementation.

---
Change in V2
  Add commit message

Jay Chang (2):
  hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual value bug
  hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support

 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu-hpm.c  | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 3 files changed, 6 insertions(+)

-- 
2.48.1



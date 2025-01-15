Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E704C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxCU-0002EN-RG; Wed, 15 Jan 2025 01:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXxCJ-0002D8-VP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:48:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXxCF-0000or-Tz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:48:15 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216401de828so105251625ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736923689; x=1737528489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TWkLrilyr6xgAqOGuDM3wLiIgr0K8L2HbMAIGQO6peE=;
 b=N+0ksGyoMmEzXz1To9WJRR0f7i9OkY+mAh9wJAiRVCBs7rWBqZiS5cr03bAGH7C3C1
 Zco6MldLU2J/RhUXb8zfjkjhZmmPqnEn39YRfpJJX92/+kkNcgCZyGckLZjgXuRckkPx
 YV0cW/bKzb6xhNtSEepErxodFKDh8qBLfQkcQ6+jD/4uI8kRL7j5A5YeexTt/oUWduCE
 HVa71MjGQ4MD23g8iPyXlSI+tstGNMl7vnsSAISumbrOi4fQ9wk4pDAQRlY3SQiFwSG0
 rIDE+6GoYJ/aFxWqGTcDzMcEY325em0LQQQSm29WNfyIvyMTQMIhlTN98c3QwD2/ucFS
 W58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736923689; x=1737528489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWkLrilyr6xgAqOGuDM3wLiIgr0K8L2HbMAIGQO6peE=;
 b=phJe7PlVxiDkpooHGzT68SLc+yYz40YbNohqhuoQQ4qI+D1zg0JQz7o0BQa9JBpqtl
 LHeB0eBA9UAlX9DRpFA+q5Wx8GCZlqdTi/5mhN0Y36j3KvqMxcrvbQxrC82jDs4aeDRp
 fX8hXMp2TBZBMyMa1HPm/mK5enXm3liqelzTovoBQkQy4Ol7eL10d98gdzEgE+uEmOvV
 76IIhxboPF4ceEttciRcN+KpYornguAr2HUNgycobwTfz2x6N8+gk3nuV2rf1vp87XRC
 dN+m65hqKDrX5e9yMYgAt7+yGTRNCK0ZLrpNRPWNVSQPxvoBSOB0Bf/w9d4Kkm4Ua2Fv
 dpEw==
X-Gm-Message-State: AOJu0YyVaptN/p0uA7+KElq56OH66Ed4VcPiQxE3YOwseLN1ieY/Ydwd
 Ox6S36ocj3fg1R9brI3HCYyWef+nd/TvhiZ4wQs0YvyFPzfawHWuNxpdpVMtVnOOcZccqmsJ9fv
 ZMVXCZralyzzdV1FUKalonMTsa84pU1FJAvimN8xtRUw4QoBg0IEBSjMO90QMGWdD00HRNaIRlt
 gunDcdP/zF213X65MOQZ8Z2wLBU5q0FRo0w/25Gqs=
X-Gm-Gg: ASbGncuxqbRjMWUeG18e/bheLgTqkwPJA75yKKOyaOYc7dll+ro+PiFSPIyjtYPtGOF
 7RAcTeOGknk0vjDX5kzdKfXP1bBx5zVbe/7AIzTweI0PadHuq9IHeSMGstOsqpxZ0wX4qjPmx+y
 cEoBbnBwXnz/vFhsTPflu4xThx9TXH9kV8PMhpgCiPl2R1rUO4evK+PESlS1Y+QzIo7y26Z29ki
 GDifw9/cHr36CNFzV5nTd/VEbRw2yg7VEPeo8CXXE4yoXzN7WGtdh30RK6g1CVBcOMI7NT5MyQi
 jYkOf8wx
X-Google-Smtp-Source: AGHT+IFtX0RfcuIqzT4HpX9o5JyJaamXw0DDwGxRPgtLRRJ+wL4Z+dE8eqJ9misaQMdEyocMJ2mqGw==
X-Received: by 2002:a05:6a00:2908:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-72d21ffd1f8mr35978605b3a.22.1736923688701; 
 Tue, 14 Jan 2025 22:48:08 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4067ee81sm8668470b3a.132.2025.01.14.22.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 22:48:08 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 1/2] hw/riscv/riscv-iommu: Remove redundant struct members
Date: Wed, 15 Jan 2025 14:47:36 +0800
Message-ID: <20250115064737.16350-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x629.google.com
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

Initially, the IOMMU would create a thread, but this thread was removed in
the merged version. The struct members for thread control should have been
removed as well, but they were not removed at that time.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/riscv-iommu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9424989df4..fa8a50fa24 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -58,11 +58,6 @@ struct RISCVIOMMUState {
     /* interrupt notifier */
     void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
 
-    /* IOMMU State Machine */
-    QemuThread core_proc; /* Background processing thread */
-    QemuCond core_cond;   /* Background processing wake up signal */
-    unsigned core_exec;   /* Processing thread execution actions */
-
     /* IOMMU target address space */
     AddressSpace *target_as;
     MemoryRegion *target_mr;
-- 
2.43.2



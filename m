Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B80E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdMS-0000U8-CB; Tue, 14 Jan 2025 04:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXdMH-0000T7-Gi
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:37:13 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tXdME-000509-HF
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:37:13 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so111545715ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 01:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736847427; x=1737452227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w/J421GUH7Mao74hk7jOCSi+yLl4BP1uUp1Mb4ir/rU=;
 b=Uol8f4mQYZ25V2K4DaE0M9oBhMeRhsffkvy61/KQBLBI44dIAyMHFwHJwGpyj0Cn6/
 BEh8EUe6HNp8f0p0bjh4rU+fS2WUo00wwEgH0YNGXGUdk2SaLvIzd7eLLUZKmh9Dj+CU
 WA89DM/YnGZv5MyaDV0whW5R6VwmxQpFas4sV1rlqtURXqxJwgZiQp5W2yxFRa+EMyWe
 r/TqCwfPooSiRx172fp6q/gL9S+PbQBLdFZU4vbrL5C2zv9aU+oLYeniI+XQx1r2HO9v
 OaiFmo+PvR3vosxXy1rFZ2eg9ebur6AT2SSUV/tOg6FLrhp8BVfABCtQWXiHWLT0QZJR
 d/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736847427; x=1737452227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/J421GUH7Mao74hk7jOCSi+yLl4BP1uUp1Mb4ir/rU=;
 b=k2zmjVRM4VgJJFIwtamzQi+tbTSlV2Fnw69UOwqfDhK9nrt6i28F+1yycxVOvU3NBa
 awzV/G8Jhcn+3SvAhmj5g3Y1zw2gNLoktm5s3oNwq/kCbEAl3Hh9IGhrDFWQbITqm5X4
 HOzROR1mCXMgkenYR5ZoRol60YRtdl72b+7cJHXFGFWCBPlqgVnrR7Aur9d5IN4NwxjW
 XT8qxnL7SMLLQ7Ej2PWVeXy15gvf9hHitWFevCjS0450KHiB6LN02V57K2Th31Blguvn
 H88KzzGVEkALBN8Zti/L1qzN7jbvBr7CfAlSCLcuf8nSwz9C7Xv+SwoJhGDHnQBVt536
 M6EA==
X-Gm-Message-State: AOJu0YyJB7ALuAvMmJhSrvvUdk9GchIedg2ppo8w7ORPID1G98005Z7Z
 OWRzxyuVN4zWeg5vvcDshjzwJTU/yOpAXBdyZduQ6qv4ts6yRanrauv/x8VyB50M1UnhDB3z6Ge
 hjx5EPJu7jmV7wGLgqsl1Vccb0vwrJzOn/ORbfEkP8fOgS2zF5GTZySJZ4NzzqIdK1Th/gv5QZu
 FafDbMXR4gXGeeusRoTfX26o9jUoyhZTlXkQJhC3w=
X-Gm-Gg: ASbGncueUmn3nzTDFbPJwWlkpqQcRJwwSSgcE2ch2eaB6HAcuNp7gqppfQfL1TJJxh4
 gP8oQLdg3cUcF7AKqqYEuGPkPTVyztHvhLTEIn6fxk57uAO9U70rguus/NcWepi+iJlOEZQXxNq
 0bGblFFFxhTqYd2s0RKbai46zi6sp3oTi4JQL4qqDkpTvv3Ybxy/GqYGD+URdIX37WZMbDEBYHb
 tts989Ix/d61MKBvnjCRqfiIaoiIWvajKQzJyJrtBEDw9wqQgSJHzlZRA441Jciu+2mHJE5nMk5
 0VPoVG48
X-Google-Smtp-Source: AGHT+IEfFytGMS3sZIXK8rwGevqErUOvVDSCaSQoav987u4WTQMho52KEY473oivczemVOQpz5iZhw==
X-Received: by 2002:a05:6a20:c896:b0:1e1:ad7:3282 with SMTP id
 adf61e73a8af0-1e8b13d1ed6mr27046085637.7.1736847427183; 
 Tue, 14 Jan 2025 01:37:07 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658dccsm7300718b3a.92.2025.01.14.01.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 01:37:06 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 1/2] hw/riscv/riscv-iommu: Remove redundant variables
Date: Tue, 14 Jan 2025 17:36:45 +0800
Message-ID: <20250114093647.4952-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Jason Chien <jason.chien@sifive.com>
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



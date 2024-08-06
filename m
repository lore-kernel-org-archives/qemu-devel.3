Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF93C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbK0k-0004Gx-S4; Tue, 06 Aug 2024 09:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0a-0003dO-4W; Tue, 06 Aug 2024 09:13:48 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sbK0X-0003Vi-9S; Tue, 06 Aug 2024 09:13:47 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a18ba4143bso348334a12.2; 
 Tue, 06 Aug 2024 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722950020; x=1723554820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3vOJHdBSCS5r7re3EDV7tdNgSsbH1n37vePYDuNuvo=;
 b=is+m2jKqj1iM9YGg0pFY857XIbdg5GnnR1vHCN/QTz193adeTrwJy3VKjYFkT0J8nr
 UAG4zJJF33/r8gTBdUdabCLYgKPGfgxvZ+nIGHgHwnRUcqOD4XhbA6SfpquAinLSbOps
 6SW/MEmGwmSE06JGmdCXwf9mHhpWSmVqbzhRfy1h0KW4OaIklnnVWDwQM1woNMSnf+LV
 N4ZvsyIz29+SYp/ZcTFpHLdNFSguouNa0oUiBDaZgUwDX15vR9nDSMLwnoJKRyzq7PjM
 sWDMSwaZdcVD5bGeKi/vCQUPxBSlg5N44A/GsL9+m2qZkpE16w/6WDP2mduotLmNZn3W
 cQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722950020; x=1723554820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3vOJHdBSCS5r7re3EDV7tdNgSsbH1n37vePYDuNuvo=;
 b=mv45OdlO+e0yjUfWXa345V9P7keze+yb9wZFbNNhWKOBMFIwbNDFr5PTTT8ZHrUbQI
 HdPaK8f7wkh4XiR7BW+SLzyFm30J/JoMXHG1wgYSn5IJhk+i7YVNLemenefT58XXXxwR
 s7Ld8wUKHJzinbUXmkMkR/wTg6vfbZz/yR1FHgfuSxDAzc6l1MFmr/JXR6q7Jx+iC+LK
 z3R4G0ffU5A09fNAdx0hyvnHhFLvrzVOXtOuhMlK1t9F0wpVCX4PPhD4Blr4iU2r5vMK
 W2Mwvz3HeOsy+OGPoImbNKrR59zHZIzRwesvoE3+65pTUoE8gnqbgsg6GFQOYASKfZoM
 I5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvJRYR4FEKAT7TmJ1fkXWkjFCJHALxuxbh0EWD4U1CtAdMKi5cbqjQnyk+WM4dK5jygLDdxFnG/WLuNsRiUB9L1pe0BP4=
X-Gm-Message-State: AOJu0Yy17Ibt/9JG5KFSEKThmDK5+JUBQIHZdyiYycgr0F1dTFTgjNVh
 o1sv4FvSllO7jNMt04VwhHaA77iyNTSNPd/ujGPL0PHsZfVBSYePEVm9VfD5
X-Google-Smtp-Source: AGHT+IGW5IBw63fnL89t7pHof4im9YaPlCM4KPYrf2wAncSb1N1oJYXR7tea7mLnB6tNmQJqekXJwQ==
X-Received: by 2002:a17:902:ce82:b0:1fd:a942:154d with SMTP id
 d9443c01a7336-1ff572c488dmr122962095ad.22.1722950020008; 
 Tue, 06 Aug 2024 06:13:40 -0700 (PDT)
Received: from wheely.local0.net ([1.145.149.136])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm87403425ad.173.2024.08.06.06.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 06:13:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/ppc: Fix mtDPDES targeting SMT siblings
Date: Tue,  6 Aug 2024 23:13:13 +1000
Message-ID: <20240806131318.275109-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
References: <20240806131318.275109-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

A typo in the loop over SMT threads to set irq level for doorbells
when storing to DPDES meant everything was aimed at the CPU executing
the instruction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 1b83971375..f0ca80153b 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -288,7 +288,7 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
         PowerPCCPU *ccpu = POWERPC_CPU(ccs);
         uint32_t thread_id = ppc_cpu_tir(ccpu);
 
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
+        ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
     }
     bql_unlock();
 }
-- 
2.45.2



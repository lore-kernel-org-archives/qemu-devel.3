Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BDCD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kou-0007D2-U7; Sun, 03 Nov 2024 19:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kot-0007Ci-Hs; Sun, 03 Nov 2024 19:19:47 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kos-0002IV-2h; Sun, 03 Nov 2024 19:19:47 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so2510155b3a.0; 
 Sun, 03 Nov 2024 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679584; x=1731284384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9T3Tbj+pHEEP02l1LsK9eDXYECtrkXHZOnBNH9gxVPk=;
 b=ZFx5K70HVZHIETKbDE1loK+rOh73VzvGt1NeF+INIw99LV+kJ5nunl/GjstSNoPU/M
 XbzIfxBYeHGil6dUXLycyJCQFOHxSwOdKzshk0zNWsdwCgYm8nDIAEnVKclKqUuZYZbJ
 CYXnp6vw8nZ8JbycisFjv0jbbxcuPmhLogF2pwoi2/cZLAI4sFzWiDdaCiLGNFUgzagB
 EaW52Iu58f48WQcdcHEXjNg6iWubMx/rx1bdPC2NofuXfwEfEpacCj/DOHcLoxbTdRcw
 YhA0hTns3m9DmtRglfNh6iHI9cY//ASqBi1uZI05BzXn9ecz4smfh2nIDf5pWbJdjXX7
 eO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679584; x=1731284384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9T3Tbj+pHEEP02l1LsK9eDXYECtrkXHZOnBNH9gxVPk=;
 b=kXejCDrgRX1Z/fVe3b7Ze6g5wijgh2aGa/weqRBot/5M20qjHbj/thhVsdCIpxaxer
 jU8nvyUQpbqTatSmKOv4jNslZKmOF060Us+0G2HJWKW9J8iRFv6i7q2nuxQj/u2a1IZJ
 JJz5PTeiE+eHIMUVszGjhErPJb08KWjtE7UhGEhwlWB013ckcLXP5PEdoHH3EEfx39pH
 kKfnjCE3vUvgR2CmIHN+7VfsEyFkN7wFQ2qjgFvcKh0GBdHK5yfyyS1468NjFy2y+Rm1
 yTYCgB2eQXbbLa4jP+rfSzj30FVXVbcoEZdEx/QBgRV4x+glhB2o9L3ujML8sWZCWnQE
 40vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLA4R7QYmWJ+lIx2kqWB3d50/MbxTeKebXzIjCHFLgIoQmxjk24TArNh4Wq5tBbCRf4UUHDkC7w==@nongnu.org
X-Gm-Message-State: AOJu0YxJ75635ycBTiqt10Q+d2jxYVOYyWaD0vG/dMIB1PQ/qhJpksTX
 pvuZadQI1LHn03QUWWygD6lubuksZ4EIEGm7GAxE+2LOiaQxxLqFkLtU2Q==
X-Google-Smtp-Source: AGHT+IGwgM3gcD0dWNMCJXK9PxJFqQ0d+gB71Fgy3IqSVaEzcXGQNbMf/xNqVmmGUZNiyNIha9POPg==
X-Received: by 2002:a05:6a21:999f:b0:1d4:f7b7:f20 with SMTP id
 adf61e73a8af0-1dba4232b33mr15011102637.21.1730679584183; 
 Sun, 03 Nov 2024 16:19:44 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/67] target/ppc: Fix VRMA to not check virtual page class key
 protection
Date: Mon,  4 Nov 2024 10:17:58 +1000
Message-ID: <20241104001900.682660-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Hash virtual real mode addressing is defined by the architecture
to not perform virtual page class key protection checks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5e1983e334..c8c2f8910a 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -993,6 +993,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     int exec_prot, pp_prot, amr_prot, prot;
     int need_prot;
     hwaddr raddr;
+    bool vrma = false;
 
     /*
      * Note on LPCR usage: 970 uses HID4, but our special variant of
@@ -1022,6 +1023,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             }
         } else if (ppc_hash64_use_vrma(env)) {
             /* Emulated VRMA mode */
+            vrma = true;
             slb = &vrma_slbe;
             if (build_vrma_slbe(cpu, slb) != 0) {
                 /* Invalid VRMA setup, machine check */
@@ -1136,7 +1138,12 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 
     exec_prot = ppc_hash64_pte_noexec_guard(cpu, pte);
     pp_prot = ppc_hash64_pte_prot(mmu_idx, slb, pte);
-    amr_prot = ppc_hash64_amr_prot(cpu, pte);
+    if (vrma) {
+        /* VRMA does not check keys */
+        amr_prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    } else {
+        amr_prot = ppc_hash64_amr_prot(cpu, pte);
+    }
     prot = exec_prot & pp_prot & amr_prot;
 
     need_prot = check_prot_access_type(PAGE_RWX, access_type);
-- 
2.45.2



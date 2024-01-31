Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5205DC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFHy-0003IC-Qt; Wed, 31 Jan 2024 13:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1rVFHx-0003HZ-3i
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:26:21 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1rVFHl-0001Wq-P1
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:26:20 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c229dabbb6so79807a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 10:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706725566; x=1707330366;
 darn=nongnu.org; 
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=xl8lOyhiLUDTPIVcSct4Ltd9837FiugwFKaP5eSD1yM=;
 b=X36sTfDAVVnHWtX50Wb2R6d7RjJPyWS7mVgEj9sDZ3GAZvk2cTOY9bJRuzLSCTsJUo
 8ztWPQpYObVIZff80uLtlqUOE7swZ2rdPIJaVMJ0rh4jGoFC2PvWyEKLK+whZo592MQJ
 fm087wVxcpQyZaxrmTvH6FePQe96Hw8GmbX0HDItIk2OCiZHuADa0pqx2n1hEe6iWqtA
 LRQIjy14LzBAmJx3EwBu0DvKxbhXLm+Dv35VtracN4M/vd09IQtVWJkqAex7xYgdXVM+
 XmCEoNob6BHcISRThwe8Co+O3DFd5MDJsv5CTFbfEIesHjpnulUpsLoTKrARlNbCGOzR
 fkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706725566; x=1707330366;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xl8lOyhiLUDTPIVcSct4Ltd9837FiugwFKaP5eSD1yM=;
 b=pzNttJSS6MxDgmDhTSqAR+h6dv9RbY5VGL5dGkUzppdBnafPMC2vwhYkw8QKjpo7Wg
 HUDyOQI6uFYZmPj1Wf39RmmjZl0J0m4H79C7Wq0qVQbkTEpTChM+dwfdAz9+vGb3Nga6
 kUddKCB+Jjv+dJXQ8VIq5iGtPFAji/eAKt4Y49HfL7pdcIpY6/mDs0s4klWq2bB+QILu
 urXJaKSxC3aT1PbzFRZA0pQ2iX93g3UWF782wgYFYgXp9yey7GIGBsK0uuVskGqTrMG4
 A1bvXQMMooJBp5dhj9sr09xzBvj5Xfmlx6tJ1I2vK14JnGhm2q8olw8QnOghhEU1P3JQ
 mxow==
X-Gm-Message-State: AOJu0YxkP0JCjrZ+ragbT/zULAsIUFPDkoZtxw6WQDojjUD4VeFbGfyx
 47a3VqRr/8t+j5yrWpRrZp8yoSAfShM+uHlc7c09aWTk2sV3rp+BSg/YDGOFSj/6AyaQGlbQHM7
 /
X-Google-Smtp-Source: AGHT+IH9XRp4PliDG4VbzcYWZ5osjMSIhTztVv1ivXGQ58iGHiM5di/MzXV1xl467UVW19DXXUhFQg==
X-Received: by 2002:a17:903:2286:b0:1d9:1df6:6e23 with SMTP id
 b6-20020a170903228600b001d91df66e23mr2040660plh.39.1706725566314; 
 Wed, 31 Jan 2024 10:26:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXlA59mGIs/P9GLVPqZqFwa5XBGd8AKQPv/pxU5t843Qr96+EX4zKgVODvZxUVr2LubGPQKxc9OahwG2tlkho3cq3lt
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 kr12-20020a170903080c00b001d8f82c61cdsm4740633plb.231.2024.01.31.10.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 10:26:04 -0800 (PST)
Subject: [PATCH] RISC-V: Report the QEMU vendor/arch IDs on virtual CPUs
Date: Wed, 31 Jan 2024 10:24:30 -0800
Message-ID: <20240131182430.20174-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: qemu-riscv@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=palmer@rivosinc.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Right now we just report 0 for marchid/mvendorid in QEMU.  That's legal,
but it's tricky for users that want to check if they're running on QEMU
to do so.  This sets marchid to 42, which I've proposed as the QEMU
architecture ID (mvendorid remains 0, just explicitly set, as that's how
the ISA handles open source implementations).

Link: https://github.com/riscv/riscv-isa-manual/pull/1213
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8cbfc7e781..1aef186f87 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -415,6 +415,9 @@ static void riscv_any_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
+
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 
 static void riscv_max_cpu_init(Object *obj)
@@ -432,6 +435,8 @@ static void riscv_max_cpu_init(Object *obj)
     set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
                                 VM_1_10_SV32 : VM_1_10_SV57);
 #endif
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 
 #if defined(TARGET_RISCV64)
@@ -445,6 +450,8 @@ static void rv64_base_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 
 static void rv64_sifive_u_cpu_init(Object *obj)
@@ -569,6 +576,8 @@ static void rv128_base_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 
 static void rv64i_bare_cpu_init(Object *obj)
@@ -591,6 +600,8 @@ static void rv64i_bare_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
 #endif
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 #else
 static void rv32_base_cpu_init(Object *obj)
@@ -603,6 +614,8 @@ static void rv32_base_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #endif
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 
 static void rv32_sifive_u_cpu_init(Object *obj)
@@ -672,6 +685,9 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zifencei = true;
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
+
+    cpu->cfg.mvendorid = QEMU_MVENDORID;
+    cpu->cfg.marchid = QEMU_MARCHID;
 }
 #endif
 
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..486832cd53 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -7,4 +7,7 @@
 #define VEYRON_V1_MIMPID        0x111
 #define VEYRON_V1_MVENDORID     0x61f
 
+#define QEMU_VIRT_MVENDORID     0
+#define QEMU_VIRT_MARCHID       42
+
 #endif /*  TARGET_RISCV_CPU_VENDORID_H */
-- 
2.43.0



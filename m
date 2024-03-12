Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE636C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5Vy-0008Ge-PG; Tue, 12 Mar 2024 13:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5U0-0005C3-Av; Tue, 12 Mar 2024 13:00:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tx-00083A-7q; Tue, 12 Mar 2024 13:00:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so612687b3a.2; 
 Tue, 12 Mar 2024 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262800; x=1710867600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hR5QAE7pCDJxhb5ipA2/sp4RETHxBXAwKTTkzbd/fU0=;
 b=G7e1Z9XRKVxPkjsJTQdJvjJom1sHIHmpmvquRvB7Gysu6RYTfp3tYM7nNmi78mxyS8
 1oDoFQktaOv8yqNSh8HWfLT5ZuxDXAFjcFMScDWCA1qzFs2z6Lsn7yN9ZJD+4Rg/Zefq
 omFbLWWy8PhwOKBVH76Kyb/QzHYNAdPiQHA17hAzVsANnZ39mS5q3VFuTQGXUOha59qf
 RkjfFE80rir6WN0RnjZ5opuwP4Ycm9tvVDRHkQM/JCyrGXwHt6yQnpoFZa6CGLYdFlaC
 dSZiCdkEvs0JtJ9SCYUzjfo5dRVWv4RRzr8c1huw5sXRK383p5t0VQ72lG418WCHeWIa
 984Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262800; x=1710867600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hR5QAE7pCDJxhb5ipA2/sp4RETHxBXAwKTTkzbd/fU0=;
 b=h5Nfv5cu5qUolKH8BOVM+Fu/86LVQKD2jYewu+PnTDh4sCwiEwvc7ufxuwMxjnDBfN
 5qfIPwRTX7Dg3cXJeGlhy8WAlUXrGx8K0oPDofCkSwPEHwmp09lE2yqF08oHX8G+KXwP
 Mh0H0fIo+AmAP7GXzLarZGW0UiaCZx7Lxuhmg5V7UHFIndlfVyy7Y6cKmPZnNAE0fHo1
 dNSFtAd054hr4P6eS93af3dLR3BT9MbJU2Z6T1cbQJrSUfBMa3+yhuo3aZBlPnqlkoSJ
 39W7nwjTLGZNnQ4ozbvHq53EiuBXTJQ3238hUCkAonHana79O32flKQI7rJA4yGEi2Sc
 YGKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjViF74hMGVkkh9EG4/DKCxz8ZsUVzVz0BUgjwwApk89kTA6mcJcALACoh1Ld3FbsYtlJw52Hj1YE0aT0yp5+lwatS
X-Gm-Message-State: AOJu0YzuL33Heg0WsdCjQhuI/Dy1oSrTseoPkS7gCRSLck95KM2bngoH
 qgCB016uZjS/kRutaUQvjF78bNqHv78MyIu/Ep8boq/maYsqHCnjXg9wySLl2Vo=
X-Google-Smtp-Source: AGHT+IGurJn5i/C18O+WR7QMOKE03Hp+sOkCLv5Zo/oNUMvjGngTH2RxLvbDgPm2iYoXqEi3PCIS7A==
X-Received: by 2002:a05:6a20:6f8c:b0:1a1:4879:1d72 with SMTP id
 gv12-20020a056a206f8c00b001a148791d72mr1022208pzb.55.1710262800046; 
 Tue, 12 Mar 2024 10:00:00 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PULL 16/38] target/ppc: Add power10 pmu SPRs
Date: Wed, 13 Mar 2024 02:58:27 +1000
Message-ID: <20240312165851.2240242-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Madhavan Srinivasan <maddy@linux.ibm.com>

Currently in tcg mode, when reading from power10 pmu spr like MMCR3,
qemu logs this message (when starting qemu with -d guest_errors)

	Trying to read invalid spr 754 (0x2f2) at 0000000030056bb0

This is becuase, no read/write call-backs are registered for
these SPRs. Add support to register generic read/write
functions to these power10 pmu sprs to fix it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      |  6 ++++++
 target/ppc/cpu_init.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0133da4e07..ed04351f27 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1951,6 +1951,12 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_TLB2CFG     (0x2B2)
 #define SPR_BOOKE_TLB3CFG     (0x2B3)
 #define SPR_BOOKE_EPR         (0x2BE)
+#define SPR_POWER_USIER2      (0x2E0)
+#define SPR_POWER_USIER3      (0x2E1)
+#define SPR_POWER_UMMCR3      (0x2E2)
+#define SPR_POWER_SIER2       (0x2F0)
+#define SPR_POWER_SIER3       (0x2F1)
+#define SPR_POWER_MMCR3       (0x2F2)
 #define SPR_PERF0             (0x300)
 #define SPR_RCPU_MI_RBA0      (0x300)
 #define SPR_MPC_MI_CTR        (0x300)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b160926a93..df31490b07 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5308,6 +5308,38 @@ static void register_power8_pmu_user_sprs(CPUPPCState *env)
                  0x00000000);
 }
 
+static void register_power10_pmu_sup_sprs(CPUPPCState *env)
+{
+    spr_register_kvm(env, SPR_POWER_MMCR3, "MMCR3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_MMCR3, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER2, "SIER2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER2, 0x00000000);
+    spr_register_kvm(env, SPR_POWER_SIER3, "SIER3",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic,
+                     KVM_REG_PPC_SIER3, 0x00000000);
+}
+
+static void register_power10_pmu_user_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_POWER_UMMCR3, "UMMCR3",
+                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_POWER_USIER2, "USIER2",
+                 &spr_read_generic, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_POWER_USIER3, "USIER3",
+                 &spr_read_generic, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+}
+
 static void register_power5p_ear_sprs(CPUPPCState *env)
 {
     /* External access control */
@@ -6502,6 +6534,8 @@ static void init_proc_POWER10(CPUPPCState *env)
     register_power9_mmu_sprs(env);
     register_power10_hash_sprs(env);
     register_power10_dexcr_sprs(env);
+    register_power10_pmu_sup_sprs(env);
+    register_power10_pmu_user_sprs(env);
 
     /* FIXME: Filter fields properly based on privilege level */
     spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
-- 
2.42.0



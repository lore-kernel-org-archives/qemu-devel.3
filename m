Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DFAC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxt-00041h-Cp; Tue, 04 Mar 2025 20:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxq-0003sQ-5x
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxo-0008Uw-3q
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22359001f1aso141908835ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139662; x=1741744462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wRQBPP4M3mDmMx29cX7WXCyD0+O+BRkzha9j1EPOB4=;
 b=TIB2BA0DLVj79BuRE9cDF2B7eLwMQVc5knyTQ9P92R/Z0ByyhfUU2ztDBGvo3hmQbq
 oMCnknV32N0LVUYsWM/3b4rRu6MXNqXDiin0uviSjdxslWvyJqMGFg8J1Ujj3ib4CORO
 Doa9nrXyetRcFRRSuF4B1vJvOlWOVcYbBhcbX63UmHLxn5S2ibt+boH0FFcx298XQJ5W
 X8/aS/5d+C7QADwRSZGTiUBOKUGpkvv4GT9vDfKws0sXxFOTb7REno2Snr+68UEKxaMB
 MsMLYpTwFMcU8FqPMCkJPwqy6+bG9eWBVePZG/g+JRSOcB5FIUoH24tuZy8WzwxoAo8E
 nmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139662; x=1741744462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wRQBPP4M3mDmMx29cX7WXCyD0+O+BRkzha9j1EPOB4=;
 b=nHhgzQjdpOpD2eUz/25cf+owctUExQefIttx0KHXHt+4ZVqdM7Ln9woRuSH+bySO+X
 kFTesT8ArJfcbl5GmRHCyvMklW/EKtapcdRsrQ8a4rQJSOxm2uus99LA45e3uu/b/1i4
 0729pEenOLRtRhSoWB8xIiwlMlfmeLXwYRZuRKT/o4pLHj1UXL7io8WNl1j85BQF/ut9
 x1Eg63/C0dQhoMZsQcnDJeYDN+XWnRKd0OB3PUSVKTSNszHuvpfp5ZMOee0L7BAp3pHY
 xQ6BcYZQL5bBPOq9xO+i8PrsJ+sxFcYaTp+TPrUlE9MCDXeKBTH8vG+HfNftsdyiBjkX
 CLlA==
X-Gm-Message-State: AOJu0YysqJQomMDg8hE5/EEf7jBBFRB+Fd7RU44kgv6lGvY3P4Mel7uc
 zc9sbh2LcUaCj/Y3pn2wbQFH3G9BK1QGZ2xkwVGZn/Vjj5ouQFpsBaSup+U16Pc=
X-Gm-Gg: ASbGncvYGU9s3pGL8s+quWhobJV1R/O0cLOPGtRS0xnczjnhBnd82+6g2ixvKJo2+be
 52YUFcLoPGTCPVLZBlPij+yqSKqK9BS1vQ6CX8RRr9SBT0cJ9lZRsgv+PxseKLjO8/p4WJ3c3Gr
 uXMH0qzKkizcKH6XB2q/2clvUGcR89SgSYvXlJzoAAIA1m2c2UChYlZ/GG811mfHi89fvqvy3cm
 qr9QNR6ng/Fs4Crp1SY1fKIcPHPJnzk1QLjkRmEt0gyAbHFMZGgJHWKF+U3dT2GyLZKc0DycVdv
 wlU0YIRiyToc13if3exSznUHJHflhVtTlBSbxJi5WCpRyE/7oW1l0+R93G8T3LPel4KkjkJ6bC1
 UlkS43cXyhIeh+uZWKKWK51eqHZhW5SQetuvRvJb3y4XrIl4dO3w=
X-Google-Smtp-Source: AGHT+IFw6WBZ3pk7wD+BlF0kU5ZaXKdUVxoYsf8/QisTdLDXF44aFi7usTnWXaclTG5jcskb4j55BQ==
X-Received: by 2002:a17:902:f545:b0:21f:35fd:1b6c with SMTP id
 d9443c01a7336-223f1d3a33dmr22119255ad.45.1741139662528; 
 Tue, 04 Mar 2025 17:54:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/59] target/riscv: Add Control Transfer Records CSR
 definitions.
Date: Wed,  5 Mar 2025 11:52:31 +1000
Message-ID: <20250305015307.1463560-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

The Control Transfer Records (CTR) extension provides a method to
record a limited branch history in register-accessible internal chip
storage.

This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been stable and the latest release can be found here
https://github.com/riscv/riscv-control-transfer-records/releases/tag/v1.0_rc5

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-2-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 145 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index f97c48a394..70ef443c99 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -247,6 +247,17 @@
 #define CSR_SIEH            0x114
 #define CSR_SIPH            0x154
 
+/* Machine-Level Control transfer records CSRs */
+#define CSR_MCTRCTL         0x34e
+
+/* Supervisor-Level Control transfer records CSRs */
+#define CSR_SCTRCTL         0x14e
+#define CSR_SCTRSTATUS      0x14f
+#define CSR_SCTRDEPTH       0x15f
+
+/* VS-Level Control transfer records CSRs */
+#define CSR_VSCTRCTL        0x24e
+
 /* Hpervisor CSRs */
 #define CSR_HSTATUS         0x600
 #define CSR_HEDELEG         0x602
@@ -344,6 +355,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_CTR      (1ULL << 54)
 #define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
@@ -825,6 +837,139 @@ typedef enum RISCVException {
 #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
 #define HENVCFGH_STCE                       MENVCFGH_STCE
 
+/* Offsets for every pair of control bits per each priv level */
+#define XS_OFFSET    0ULL
+#define U_OFFSET     2ULL
+#define S_OFFSET     5ULL
+#define M_OFFSET     8ULL
+
+#define PM_XS_BITS   (EXT_STATUS_MASK << XS_OFFSET)
+#define U_PM_ENABLE  (PM_ENABLE  << U_OFFSET)
+#define U_PM_CURRENT (PM_CURRENT << U_OFFSET)
+#define U_PM_INSN    (PM_INSN    << U_OFFSET)
+#define S_PM_ENABLE  (PM_ENABLE  << S_OFFSET)
+#define S_PM_CURRENT (PM_CURRENT << S_OFFSET)
+#define S_PM_INSN    (PM_INSN    << S_OFFSET)
+#define M_PM_ENABLE  (PM_ENABLE  << M_OFFSET)
+#define M_PM_CURRENT (PM_CURRENT << M_OFFSET)
+#define M_PM_INSN    (PM_INSN    << M_OFFSET)
+
+/* mmte CSR bits */
+#define MMTE_PM_XS_BITS     PM_XS_BITS
+#define MMTE_U_PM_ENABLE    U_PM_ENABLE
+#define MMTE_U_PM_CURRENT   U_PM_CURRENT
+#define MMTE_U_PM_INSN      U_PM_INSN
+#define MMTE_S_PM_ENABLE    S_PM_ENABLE
+#define MMTE_S_PM_CURRENT   S_PM_CURRENT
+#define MMTE_S_PM_INSN      S_PM_INSN
+#define MMTE_M_PM_ENABLE    M_PM_ENABLE
+#define MMTE_M_PM_CURRENT   M_PM_CURRENT
+#define MMTE_M_PM_INSN      M_PM_INSN
+#define MMTE_MASK    (MMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | MMTE_U_PM_INSN | \
+                      MMTE_S_PM_ENABLE | MMTE_S_PM_CURRENT | MMTE_S_PM_INSN | \
+                      MMTE_M_PM_ENABLE | MMTE_M_PM_CURRENT | MMTE_M_PM_INSN | \
+                      MMTE_PM_XS_BITS)
+
+/* (v)smte CSR bits */
+#define SMTE_PM_XS_BITS     PM_XS_BITS
+#define SMTE_U_PM_ENABLE    U_PM_ENABLE
+#define SMTE_U_PM_CURRENT   U_PM_CURRENT
+#define SMTE_U_PM_INSN      U_PM_INSN
+#define SMTE_S_PM_ENABLE    S_PM_ENABLE
+#define SMTE_S_PM_CURRENT   S_PM_CURRENT
+#define SMTE_S_PM_INSN      S_PM_INSN
+#define SMTE_MASK    (SMTE_U_PM_ENABLE | SMTE_U_PM_CURRENT | SMTE_U_PM_INSN | \
+                      SMTE_S_PM_ENABLE | SMTE_S_PM_CURRENT | SMTE_S_PM_INSN | \
+                      SMTE_PM_XS_BITS)
+
+/* umte CSR bits */
+#define UMTE_U_PM_ENABLE    U_PM_ENABLE
+#define UMTE_U_PM_CURRENT   U_PM_CURRENT
+#define UMTE_U_PM_INSN      U_PM_INSN
+#define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
+
+/* CTR control register commom fields */
+#define XCTRCTL_U              BIT_ULL(0)
+#define XCTRCTL_S              BIT_ULL(1)
+#define XCTRCTL_RASEMU         BIT_ULL(7)
+#define XCTRCTL_STE            BIT_ULL(8)
+#define XCTRCTL_BPFRZ          BIT_ULL(11)
+#define XCTRCTL_LCOFIFRZ       BIT_ULL(12)
+#define XCTRCTL_EXCINH         BIT_ULL(33)
+#define XCTRCTL_INTRINH        BIT_ULL(34)
+#define XCTRCTL_TRETINH        BIT_ULL(35)
+#define XCTRCTL_NTBREN         BIT_ULL(36)
+#define XCTRCTL_TKBRINH        BIT_ULL(37)
+#define XCTRCTL_INDCALLINH     BIT_ULL(40)
+#define XCTRCTL_DIRCALLINH     BIT_ULL(41)
+#define XCTRCTL_INDJMPINH      BIT_ULL(42)
+#define XCTRCTL_DIRJMPINH      BIT_ULL(43)
+#define XCTRCTL_CORSWAPINH     BIT_ULL(44)
+#define XCTRCTL_RETINH         BIT_ULL(45)
+#define XCTRCTL_INDLJMPINH     BIT_ULL(46)
+#define XCTRCTL_DIRLJMPINH     BIT_ULL(47)
+
+#define XCTRCTL_MASK (XCTRCTL_U | XCTRCTL_S | XCTRCTL_RASEMU |                \
+                      XCTRCTL_STE | XCTRCTL_BPFRZ | XCTRCTL_LCOFIFRZ |        \
+                      XCTRCTL_EXCINH | XCTRCTL_INTRINH | XCTRCTL_TRETINH |    \
+                      XCTRCTL_NTBREN | XCTRCTL_TKBRINH | XCTRCTL_INDCALLINH | \
+                      XCTRCTL_DIRCALLINH | XCTRCTL_INDJMPINH |                \
+                      XCTRCTL_DIRJMPINH | XCTRCTL_CORSWAPINH |                \
+                      XCTRCTL_RETINH | XCTRCTL_INDLJMPINH | XCTRCTL_DIRLJMPINH)
+
+#define XCTRCTL_INH_START         32U
+
+/* CTR mctrctl bits */
+#define MCTRCTL_M                 BIT_ULL(2)
+#define MCTRCTL_MTE               BIT_ULL(9)
+
+#define MCTRCTL_MASK              (XCTRCTL_MASK | MCTRCTL_M | MCTRCTL_MTE)
+#define SCTRCTL_MASK              XCTRCTL_MASK
+#define VSCTRCTL_MASK             XCTRCTL_MASK
+
+/* sctrstatus CSR bits. */
+#define SCTRSTATUS_WRPTR_MASK       0xFF
+#define SCTRSTATUS_FROZEN           BIT(31)
+#define SCTRSTATUS_MASK             (SCTRSTATUS_WRPTR_MASK | SCTRSTATUS_FROZEN)
+
+/* sctrdepth CSR bits. */
+#define SCTRDEPTH_MASK              0x7
+#define SCTRDEPTH_MIN               0U  /* 16 Entries. */
+#define SCTRDEPTH_MAX               4U  /* 256 Entries. */
+
+#define CTR_ENTRIES_FIRST           0x200
+#define CTR_ENTRIES_LAST            0x2ff
+
+#define CTRSOURCE_VALID             BIT(0)
+#define CTRTARGET_MISP              BIT(0)
+
+#define CTRDATA_TYPE_MASK           0xF
+#define CTRDATA_CCV                 BIT(15)
+#define CTRDATA_CCM_MASK            0xFFF0000
+#define CTRDATA_CCE_MASK            0xF0000000
+
+#define CTRDATA_MASK            (CTRDATA_TYPE_MASK | CTRDATA_CCV |  \
+                                 CTRDATA_CCM_MASK | CTRDATA_CCE_MASK)
+
+typedef enum CTRType {
+    CTRDATA_TYPE_NONE                   = 0,
+    CTRDATA_TYPE_EXCEPTION              = 1,
+    CTRDATA_TYPE_INTERRUPT              = 2,
+    CTRDATA_TYPE_EXCEP_INT_RET          = 3,
+    CTRDATA_TYPE_NONTAKEN_BRANCH        = 4,
+    CTRDATA_TYPE_TAKEN_BRANCH           = 5,
+    CTRDATA_TYPE_RESERVED_0             = 6,
+    CTRDATA_TYPE_RESERVED_1             = 7,
+    CTRDATA_TYPE_INDIRECT_CALL          = 8,
+    CTRDATA_TYPE_DIRECT_CALL            = 9,
+    CTRDATA_TYPE_INDIRECT_JUMP          = 10,
+    CTRDATA_TYPE_DIRECT_JUMP            = 11,
+    CTRDATA_TYPE_CO_ROUTINE_SWAP        = 12,
+    CTRDATA_TYPE_RETURN                 = 13,
+    CTRDATA_TYPE_OTHER_INDIRECT_JUMP    = 14,
+    CTRDATA_TYPE_OTHER_DIRECT_JUMP      = 15,
+} CTRType;
+
 /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
 #define ISELECT_IPRIO0                     0x30
 #define ISELECT_IPRIO15                    0x3f
-- 
2.48.1



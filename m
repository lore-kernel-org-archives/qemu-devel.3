Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA11C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsQ-0000st-OL; Wed, 29 May 2024 12:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsP-0000rq-2W
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsC-0003MH-Lk
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso2160086f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716998995; x=1717603795;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/Haw6h0NMogk0m9baqrbppzlik8qxWnPEs/BFAYo5E=;
 b=N8SpopgT7WpkDru55GIVV2ZwcwtIaIDErH45NKpJHOUBO+9r8aCvqDtxTQ+wlBNH51
 xbYpXRP0zW/x9lfvSSAjRCTYZ07PnruM6QY2enD8hGhYabJ7H7OLxqR9WN+9swff2GBY
 K7vcWJid3VOWYo5nT8KSoBpQ/I6VMcax357ckdkr8pwL4d9/bcLIY8IIyYzPVMhYpQvT
 uloUP6V8EqGGKSYIjg9o6QJPlusSgnIU0fhbk+r18t1naHmka+0ipq8e2yCWxJxblnc+
 R1ZXKhVEVr7rMUVAVSXBofpc9xgBdh/FROkRKs73m5T7XQVjS6Rwz2MtR4J6PzGnlPAv
 UkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998995; x=1717603795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/Haw6h0NMogk0m9baqrbppzlik8qxWnPEs/BFAYo5E=;
 b=tR7j/tfIwJnCDlha24fAWl6/MufsjgJc8tq2sGmeQYdpphOvmVQoYz1rm1m6B+PUaF
 TFepXBEqGq6pu6BYb7Xc2A4xigySo79aUyBC02YkziPSkIhRlQ1eaM0sCca76pRZkwPM
 9uvoIfO4cT1pZcQq6iEEsN7C1bDR11Yp0P4tvbb/tKvNgrIY1Y+87R9RIiiMgK6oEqZU
 +6X47bCGQCrr46jlpdEYoNUsVQBEeUccO2aWlw5rBOHvTokoeZCqototfOC4zKmbKL95
 YsYkSIrIH/YsS/QAu44Cfj1QT44/bkRq5jR6nY5mKwUbWgKVy+ti46+L7WMkRi8yqnkF
 jqzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOdORcDIk+25Clu6bpchVTxYBSd6ZHQF66dOMG+/DlGozta1FEt6AUeg1Q37f+o7WQE92yj8lleLrVvJSwnO1YXlw9t4E=
X-Gm-Message-State: AOJu0YyDweR37v4uvCqmHHctp5z518qPUcYa224oafsgZIlVy1bqB6wD
 JxvQu2893/oStzhFkcOlHtBS8TsMAdTwG6+jv0ULDoUX9v8Epp2QRhHGGdQmvto=
X-Google-Smtp-Source: AGHT+IEiufWSbAkjmpuVHVrPKRcweyO9rRDNrtTrCFPME8UQyAO/o+aFp45yLwNpbvIqoSInw4dyGw==
X-Received: by 2002:a5d:6aca:0:b0:354:fa6e:7ae2 with SMTP id
 ffacd0b85a97d-3552219cfa0mr10202094f8f.36.1716998995162; 
 Wed, 29 May 2024 09:09:55 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm15228213f8f.107.2024.05.29.09.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:54 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Subject: [PATCH 2/6] target/riscv: Add Control Transfer Records CSR
 definitions.
Date: Wed, 29 May 2024 17:09:46 +0100
Message-Id: <20240529160950.132754-3-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

The Control Transfer Records (CTR) extension provides a method to
record a limited branch history in register-accessible internal chip
storage.

This extension is similar to Arch LBR in x86 and BRBE in ARM.
The Extension has been stable and the latest release can be found here
https://github.com/riscv/riscv-control-transfer-records/release

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu_bits.h | 154 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 86e15381c8..71ddccaf1a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -242,6 +242,17 @@
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
@@ -339,6 +350,7 @@
 #define SMSTATEEN0_CS       (1ULL << 0)
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
+#define SMSTATEEN0_CTR      (1ULL << 54)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
 #define SMSTATEEN0_AIA      (1ULL << 59)
@@ -854,6 +866,148 @@ typedef enum RISCVException {
 #define UMTE_U_PM_INSN      U_PM_INSN
 #define UMTE_MASK     (UMTE_U_PM_ENABLE | MMTE_U_PM_CURRENT | UMTE_U_PM_INSN)
 
+/* mctrctl CSR bits. */
+#define MCTRCTL_U_ENABLE        BIT(0)
+#define MCTRCTL_S_ENABLE        BIT(1)
+#define MCTRCTL_M_ENABLE        BIT(2)
+#define MCTRCTL_RASEMU          BIT(7)
+#define MCTRCTL_STE             BIT(8)
+#define MCTRCTL_MTE             BIT(9)
+#define MCTRCTL_BPFRZ           BIT(11)
+#define MCTRCTL_LCOFIFRZ        BIT(12)
+#define MCTRCTL_EXCINH          BIT(33)
+#define MCTRCTL_INTRINH         BIT(34)
+#define MCTRCTL_TRETINH         BIT(35)
+#define MCTRCTL_NTBREN          BIT(36)
+#define MCTRCTL_TKBRINH         BIT(37)
+#define MCTRCTL_INDCALL_INH     BIT(40)
+#define MCTRCTL_DIRCALL_INH     BIT(41)
+#define MCTRCTL_INDJUMP_INH     BIT(42)
+#define MCTRCTL_DIRJUMP_INH     BIT(43)
+#define MCTRCTL_CORSWAP_INH     BIT(44)
+#define MCTRCTL_RET_INH         BIT(45)
+#define MCTRCTL_INDOJUMP_INH    BIT(46)
+#define MCTRCTL_DIROJUMP_INH    BIT(47)
+
+#define MCTRCTL_INH_START       32U
+
+#define MCTRCTL_MASK (MCTRCTL_M_ENABLE | MCTRCTL_S_ENABLE |       \
+                      MCTRCTL_U_ENABLE | MCTRCTL_RASEMU |         \
+                      MCTRCTL_MTE | MCTRCTL_STE |                 \
+                      MCTRCTL_BPFRZ | MCTRCTL_LCOFIFRZ |          \
+                      MCTRCTL_EXCINH | MCTRCTL_INTRINH |          \
+                      MCTRCTL_TRETINH | MCTRCTL_NTBREN |          \
+                      MCTRCTL_TKBRINH | MCTRCTL_INDCALL_INH |     \
+                      MCTRCTL_DIRCALL_INH | MCTRCTL_INDJUMP_INH | \
+                      MCTRCTL_DIRJUMP_INH | MCTRCTL_CORSWAP_INH | \
+                      MCTRCTL_RET_INH | MCTRCTL_INDOJUMP_INH |    \
+                      MCTRCTL_DIROJUMP_INH)
+
+/* sctrctl CSR bits. */
+#define SCTRCTL_U_ENABLE          MCTRCTL_U_ENABLE
+#define SCTRCTL_S_ENABLE          MCTRCTL_S_ENABLE
+#define SCTRCTL_RASEMU            MCTRCTL_RASEMU
+#define SCTRCTL_STE               MCTRCTL_STE
+#define SCTRCTL_BPFRZ             MCTRCTL_BPFRZ
+#define SCTRCTL_LCOFIFRZ          MCTRCTL_LCOFIFRZ
+#define SCTRCTL_EXCINH            MCTRCTL_EXCINH
+#define SCTRCTL_INTRINH           MCTRCTL_INTRINH
+#define SCTRCTL_TRETINH           MCTRCTL_TRETINH
+#define SCTRCTL_NTBREN            MCTRCTL_NTBREN
+#define SCTRCTL_TKBRINH           MCTRCTL_TKBRINH
+#define SCTRCTL_INDCALL_INH       MCTRCTL_INDCALL_INH
+#define SCTRCTL_DIRCALL_INH       MCTRCTL_DIRCALL_INH
+#define SCTRCTL_INDJUMP_INH       MCTRCTL_INDJUMP_INH
+#define SCTRCTL_DIRJUMP_INH       MCTRCTL_DIRJUMP_INH
+#define SCTRCTL_CORSWAP_INH       MCTRCTL_CORSWAP_INH
+#define SCTRCTL_RET_INH           MCTRCTL_RET_INH
+#define SCTRCTL_INDOJUMP_INH      MCTRCTL_INDOJUMP_INH
+#define SCTRCTL_DIROJUMP_INH      MCTRCTL_DIROJUMP_INH
+
+#define SCTRCTL_MASK (SCTRCTL_S_ENABLE | SCTRCTL_U_ENABLE |       \
+                      SCTRCTL_RASEMU | SCTRCTL_STE |              \
+                      SCTRCTL_BPFRZ | SCTRCTL_LCOFIFRZ |          \
+                      SCTRCTL_EXCINH | SCTRCTL_INTRINH |          \
+                      SCTRCTL_TRETINH | SCTRCTL_NTBREN |          \
+                      SCTRCTL_TKBRINH | SCTRCTL_INDCALL_INH |     \
+                      SCTRCTL_DIRCALL_INH | SCTRCTL_INDJUMP_INH | \
+                      SCTRCTL_DIRJUMP_INH | SCTRCTL_CORSWAP_INH | \
+                      SCTRCTL_RET_INH | SCTRCTL_INDOJUMP_INH |    \
+                      SCTRCTL_DIROJUMP_INH)
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
+/* vsctrctl CSR bits. */
+#define VSCTRCTL_VU_ENABLE         MCTRCTL_U_ENABLE
+#define VSCTRCTL_VS_ENABLE         MCTRCTL_S_ENABLE
+#define VSCTRCTL_RASEMU            MCTRCTL_RASEMU
+#define VSCTRCTL_VSTE              MCTRCTL_STE
+#define VSCTRCTL_BPFRZ             MCTRCTL_BPFRZ
+#define VSCTRCTL_LCOFIFRZ          MCTRCTL_LCOFIFRZ
+#define VSCTRCTL_EXCINH            MCTRCTL_EXCINH
+#define VSCTRCTL_INTRINH           MCTRCTL_INTRINH
+#define VSCTRCTL_TRETINH           MCTRCTL_TRETINH
+#define VSCTRCTL_NTBREN            MCTRCTL_NTBREN
+#define VSCTRCTL_TKBRINH           MCTRCTL_TKBRINH
+#define VSCTRCTL_INDCALL_INH       MCTRCTL_INDCALL_INH
+#define VSCTRCTL_DIRCALL_INH       MCTRCTL_DIRCALL_INH
+#define VSCTRCTL_INDJUMP_INH       MCTRCTL_INDJUMP_INH
+#define VSCTRCTL_DIRJUMP_INH       MCTRCTL_DIRJUMP_INH
+#define VSCTRCTL_CORSWAP_INH       MCTRCTL_CORSWAP_INH
+#define VSCTRCTL_RET_INH           MCTRCTL_RET_INH
+#define VSCTRCTL_INDOJUMP_INH      MCTRCTL_INDOJUMP_INH
+#define VSCTRCTL_DIROJUMP_INH      MCTRCTL_DIROJUMP_INH
+
+#define VSCTRCTL_MASK (VSCTRCTL_VS_ENABLE | VSCTRCTL_VU_ENABLE |     \
+                       VSCTRCTL_RASEMU | VSCTRCTL_VSTE |             \
+                       VSCTRCTL_BPFRZ | VSCTRCTL_LCOFIFRZ |          \
+                       VSCTRCTL_EXCINH | VSCTRCTL_INTRINH |          \
+                       VSCTRCTL_TRETINH | VSCTRCTL_NTBREN |          \
+                       VSCTRCTL_TKBRINH | VSCTRCTL_INDCALL_INH |     \
+                       VSCTRCTL_DIRCALL_INH | VSCTRCTL_INDJUMP_INH | \
+                       VSCTRCTL_DIRJUMP_INH | VSCTRCTL_CORSWAP_INH | \
+                       VSCTRCTL_RET_INH | VSCTRCTL_INDOJUMP_INH |    \
+                       VSCTRCTL_DIROJUMP_INH)
+
+#define CTR_ENTRIES_FIRST                  0x200
+#define CTR_ENTRIES_LAST                   0x2ff
+
+#define CTRSOURCE_VALID                    BIT(0)
+#define CTRTARGET_MISP                     BIT(0)
+
+#define CTRDATA_TYPE_MASK                   0xF
+#define CTRDATA_CCV                         BIT(15)
+#define CTRDATA_CCM_MASK                    0xFFF0000
+#define CTRDATA_CCE_MASK                    0xF0000000
+
+#define CTRDATA_MASK            (CTRDATA_TYPE_MASK | CTRDATA_CCV |  \
+                                 CTRDATA_CCM_MASK | CTRDATA_CCE_MASK)
+
+#define CTRDATA_TYPE_NONE                   0
+#define CTRDATA_TYPE_EXCEPTION              1
+#define CTRDATA_TYPE_INTERRUPT              2
+#define CTRDATA_TYPE_EXCEP_INT_RET          3
+#define CTRDATA_TYPE_NONTAKEN_BRANCH        4
+#define CTRDATA_TYPE_TAKEN_BRANCH           5
+#define CTRDATA_TYPE_RESERVED_0             6
+#define CTRDATA_TYPE_RESERVED_1             7
+#define CTRDATA_TYPE_INDIRECT_CALL          8
+#define CTRDATA_TYPE_DIRECT_CALL            9
+#define CTRDATA_TYPE_INDIRECT_JUMP          10
+#define CTRDATA_TYPE_DIRECT_JUMP            11
+#define CTRDATA_TYPE_CO_ROUTINE_SWAP        12
+#define CTRDATA_TYPE_RETURN                 13
+#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP    14
+#define CTRDATA_TYPE_OTHER_DIRECT_JUMP      15
+
 /* MISELECT, SISELECT, and VSISELECT bits (AIA) */
 #define ISELECT_IPRIO0                     0x30
 #define ISELECT_IPRIO15                    0x3f
-- 
2.34.1



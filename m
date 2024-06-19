Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F53C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJxDq-0005bZ-Fd; Wed, 19 Jun 2024 11:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDi-0005UO-8C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sJxDg-0005si-8a
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:27:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f7274a453bso58027905ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718810851; x=1719415651;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/Haw6h0NMogk0m9baqrbppzlik8qxWnPEs/BFAYo5E=;
 b=dWiLHDaJl1hiasjw6zbvuh5nt+WoRFdcWV1GL5HEhPm+KqbioRbqGzZJ47mCm0HqE6
 PD7VOSOLM5QBJMHpJnuiDCfkibRZJMrGdNO6XQHswBXvmr9irdKDJNHZRO+etjduWA6Y
 eDdZpFOyzrCnglfQymKOmg/KAQqHyolBmovqVO66WsZG6oZfzgOP4cLSbw7OD6pH8wM+
 McXfqqvpIYC86wLwU22un05xfIl6QpVHjfKbYJ7j+CVFrtc7Vr4n+7AKLf4srmaV/ytT
 cj762AISzxVlYvmlSSx48hks1ZCX1W/bqL0Fm7ZunKKlxdOuCYSIu9AYSDw0TgFnhPId
 9BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718810851; x=1719415651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/Haw6h0NMogk0m9baqrbppzlik8qxWnPEs/BFAYo5E=;
 b=UlRyQxAQtweqk/h8hHY1n8rcYWPUmGXtM4mYlyAmvN1X/OMlke3uYKENjnbQZ5NmJD
 A0UyIG8vO56SPNDBEIemD9SXfEBIFSpArIEjehkZvWVr+Jh062BH4OUsfhOHDKk7sibu
 i9UvKWejAdMlV0LbKofj01NZbBscBUdfySyFae2/5PZEszAOXan2zOMG/ZwYM7JLygSp
 7IvgBF2C1DNRRapzx1coTNbt9zTXZkw7pxxooFAeqzEC7cKvEQuZlRG1FOiAFJ8XDT0P
 zDPsqgEwBlBPVGfgNtG41z1pt3NXinnEzYPCj4ZSFEh8WslftIWLmKiITYlHSj8DNKQg
 8aww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbsxC9r73K8xYEamFcIe8UAsDPtdDOpezoaSjjd52yVC5M+J6C6nNbl8Z8TO1ihO0eBQsw4qkxF9XJiTWzz5appduNb3U=
X-Gm-Message-State: AOJu0YyRke5D+ljBVZsimnrlQqQYDflYy8902r3Yn1MTH1X0NvRHJNK5
 82uZ1y8E8ApLOq9OF1AkXYlAuRtiGHheMUsPfNeQlpd/oFUBypS9NemazQ/Du2o=
X-Google-Smtp-Source: AGHT+IGUKaLnKwRXjEJuncigv0CARgVoclQHkRuRVYEsQIXFBvtYetH9P9hyy605UTKKra7ja7K+Cw==
X-Received: by 2002:a17:902:dad1:b0:1f6:fcd9:5b8d with SMTP id
 d9443c01a7336-1f9aa3ed915mr34381915ad.9.1718810850880; 
 Wed, 19 Jun 2024 08:27:30 -0700 (PDT)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9afada50dsm15956865ad.166.2024.06.19.08.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:27:30 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org,
 jason.chien@sifive.com
Subject: [PATCH v2 2/6] target/riscv: Add Control Transfer Records CSR
 definitions.
Date: Wed, 19 Jun 2024 16:27:04 +0100
Message-Id: <20240619152708.135991-3-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619152708.135991-1-rkanwal@rivosinc.com>
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=rkanwal@rivosinc.com; helo=mail-pl1-x62e.google.com
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



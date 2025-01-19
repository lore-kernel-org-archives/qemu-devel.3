Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ECCC02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJth-0007oX-5O; Sat, 18 Jan 2025 20:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtd-0007ao-Gx
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:37 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtb-0003NM-5N
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:37 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so5810612a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249273; x=1737854073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjFgLXJTNPL7LIfFy+UwZC0rUQm4Hrp+JgiARqOxvyM=;
 b=gwmrnPTmqZjtRdSqbghhW2G8XV2dQbwZWuzukbpox3shT2QvhZlFleW3OFT/vC94bE
 6PN0gUW1gMcW18fdnmH+DCfYx5khmotxkT782cu0yM6TZVkzR9Nj6NbFCu0JzpXDchvE
 ljUz3qGELmyECZ4xebhh15SaW0rAZZaDpAOHA7j76sOj570JVolRWZi+vsIMkLYE/Dw9
 zjeyfT13n9UKqx8D2v//tLgK+m/UYLTKxuN3PxhqjiUtMh/atIKVKOTctGJuURJBNDD/
 p71Fx6fb89r7k+w4guR9URM2QNoEX+BMvo9+JSRlFnnzB8ntljJXgKmVzpE976YldaIG
 OP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249273; x=1737854073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjFgLXJTNPL7LIfFy+UwZC0rUQm4Hrp+JgiARqOxvyM=;
 b=ed/VhVnioV6yBQM5bXdc4XP39S+Gzbu7gVM8lZXcA/GjMd13I5qkNY9bAf0nK2QIC5
 g0d8NcJWc60nNBnqWz9R+waMDUJvBio+D63TAX9Qo+773pxIGSEWnQNg8MaQjuudsIcd
 w6N2+TZAQIOKEfYScmyzdN4nONJGOze8DAAF4rKejaCVrJD8P8Qbn+lATv7PMdKF24EH
 OasVI2FpfNI++d6wD57gLMLQAVgn72W8jF+IX1VyTVg15Gde56tSoZLfovXXQuIKjdlu
 Ja7JnS+Ehi21beoBauwsXuWqX720MpHElJsxL0FmLAKLfnzKGuuW/fzXVPvwBRo4nRWc
 71Sg==
X-Gm-Message-State: AOJu0YxdikOpmed0u3XYzGDdLBALSjDES3hTlYkdLif91/4A762vF6f6
 XYwXGl22o8bWfIoxQj39t6Uwg5CIEsXK7Iw7Tlm9OYAfqjYjMPqA+++GPZ1V
X-Gm-Gg: ASbGncvS9xkfEa8VI7Kt9kP6wRIg7cRR6OP/apuxxOnz1YNFVwrevpAWrAXYlKLahi6
 tpfMaLGIW1kdEpl+dQkh0SYOd4Dibn/sVsDdECSFSTES449MFE3baPyAZ62lHTv+bk0MyN3CeBB
 Hds3UVobOU6eT6fjq70aAahNfhhjG/6LiVOyfCtvZAcnGsAtYDP6nwN4L9DOQTxOHSnl83wrWm0
 +9IzH1xzlhYhvutcatLID0XTAzqNynvJHCqEDlpbHEPWlsiQd8iKAyshxc1pAZK+1lZinyOQfLh
 SrcXtbBQMGqOw7erp6Letws8mJFHUz7vlNsMsuLn4mGC6JDJY+xsO8Vn+oDUFBn96Ijvx6ZvvA=
 =
X-Google-Smtp-Source: AGHT+IHcW927mZQ6WciMXk401LRbEwz1574jtxdyiLqNjsk/gD1nYAoSeJ+bhugLwSHL7JPJ0RR0AQ==
X-Received: by 2002:a17:90b:5211:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2f782d4ef70mr11422373a91.27.1737249273611; 
 Sat, 18 Jan 2025 17:14:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PULL v2 33/50] target/riscv: Add counter delegation definitions
Date: Sun, 19 Jan 2025 11:12:08 +1000
Message-ID: <20250119011225.11452-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions for counter delegation, including the new
scountinhibit register and the mstateen.CD bit.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-6-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h      | 1 +
 target/riscv/cpu_bits.h | 8 +++++++-
 target/riscv/machine.c  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 08215efb09..a936300103 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -392,6 +392,7 @@ struct CPUArchState {
     uint32_t scounteren;
     uint32_t mcounteren;
 
+    uint32_t scountinhibit;
     uint32_t mcountinhibit;
 
     /* PMU cycle & instret privilege mode filtering */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 6b1446fb7e..73f7d37d80 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -210,6 +210,9 @@
 #define CSR_SSTATEEN2       0x10E
 #define CSR_SSTATEEN3       0x10F
 
+/* Supervisor Counter Delegation */
+#define CSR_SCOUNTINHIBIT   0x120
+
 /* Supervisor Trap Handling */
 #define CSR_SSCRATCH        0x140
 #define CSR_SEPC            0x141
@@ -779,6 +782,7 @@ typedef enum RISCVException {
 #define MENVCFG_CBCFE                      BIT(6)
 #define MENVCFG_CBZE                       BIT(7)
 #define MENVCFG_PMM                        (3ULL << 32)
+#define MENVCFG_CDE                        (1ULL << 60)
 #define MENVCFG_ADUE                       (1ULL << 61)
 #define MENVCFG_PBMTE                      (1ULL << 62)
 #define MENVCFG_STCE                       (1ULL << 63)
@@ -826,7 +830,9 @@ typedef enum RISCVException {
 #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
 #define ISELECT_MASK_AIA                   0x1ff
 
-/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
+/* [M|S|VS]SELCT value for Indirect CSR Access Extension */
+#define ISELECT_CD_FIRST                   0x40
+#define ISELECT_CD_LAST                    0x5f
 #define ISELECT_MASK_SXCSRIND              0xfff
 
 /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d81621010d..d8445244ab 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -423,6 +423,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINT32(env.scounteren, RISCVCPU),
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
-- 
2.48.1



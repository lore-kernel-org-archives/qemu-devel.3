Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4018BD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krk-000757-9B; Sun, 03 Nov 2024 19:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr8-0005OX-0J; Sun, 03 Nov 2024 19:22:06 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kr6-0002kd-7O; Sun, 03 Nov 2024 19:22:05 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so2620363a12.2; 
 Sun, 03 Nov 2024 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679722; x=1731284522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3MEKvteMsJO9gub1u2YO3fvm/n2k8+R2+Pv63fB2zM=;
 b=PuskgmFGPMCL2ehr232AMS4vjdck4bL2qx3oBBECkj/NjKSf5fhKLWRXBhOW6ERd+r
 mcfpANsri7kcIt3QT1LIVHxrtgweitSSAcCdM829qcWEzOwlUko0uVHMtMS6ELqPj+VH
 UZfs5dG4XijHODO6LYEwsoudoiARFQQOAhKFlFtg9I/XYGjglSmm7JWs/88/sneJiqFi
 fxvtjsT7KTVmy/bQxHsV7rb3Pq39yMPO8x/6iUbkY8sDkmOSctf6mJYymyTmbC80DCMg
 TfCZtAF+XuX3gdNj07ojlp5aoDrSF6V9a18wXu4HKfOXI4TtnqNZt5X72IvoK/Lhu8Ae
 Acsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679722; x=1731284522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3MEKvteMsJO9gub1u2YO3fvm/n2k8+R2+Pv63fB2zM=;
 b=EgUc5GN9En8dAT2iGa2p2Rgl6w+OELRjMkpLvrApwS3KfoC4MnNaVmu72jQouOfhl1
 8T+BdmLL0d49PS9jBRaCd3W4Ui9YOycfZvvEi8e+1tbDUIqQTl2rHrl7vdnHh434s8yw
 NRyxiONF2Kudzz9uqTEDpXLLKo3bqtU0gWDq4sXdpHhgEFSWqx0TBaJjY+jHZJqS9ROG
 6pmufpBbIQ4MwvOitvyyXt/dVBLXnaY6hbPkXHF6o8fx7aidDPYbSQfgRxjYXK8yrvpV
 AoTX9uUA4EfgSaRCHPrSi8jybSCiGdDqF5Mb/XXZOfuf1SyrV+I69KUxbMSV91b5u6mp
 859g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3R5RhHkxAh6h8+YKUxDf3qwjpfCqJbhMBhV3b++M9W1V7QHKactTmkS0eY5/EoqZCccuIA8jczw==@nongnu.org
X-Gm-Message-State: AOJu0YzhOFwf2SOsGB/P5chZ463CwufSFYYpEAH0IGgybL8AUxBN0Uco
 zcN0+F6MEoUfsPXGNGScLqD78M+GxdoXJRDDAC5ch2hzb7PgITMNcgN3cA==
X-Google-Smtp-Source: AGHT+IFQq9UMS3vCv9msj5eYBw3B/6v6CpnuH2tH2v3mntImqxktVWDtdEQin5WqoSikJcqNZz8XMw==
X-Received: by 2002:a17:903:40c9:b0:20c:c694:f6c6 with SMTP id
 d9443c01a7336-210c6c52417mr404540205ad.49.1730679722242; 
 Sun, 03 Nov 2024 16:22:02 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 48/67] pnv/xive: TIMA patch sets pre-req alignment and
 formatting changes
Date: Mon,  4 Nov 2024 10:18:37 +1000
Message-ID: <20241104001900.682660-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michael Kowal <kowal@linux.vnet.ibm.com>

Making some pre-requisite alignment changes ahead of the following patch
sets.  Making these changes now will ease the review of the patch sets.

Checkpatch wants the closing comment '*/' on a separate line, unless it is
on the same line as the starting comment '/*'.

There are also changes to prevent lines from spanning 80 columns.

Changed block of defines from:
   #define A 1  /* original define comment is not
                 * preferred, but not flagged... */
   #define B 2  /* Newly added define comment
                 * is flagged with a warning */
To:
   #define A 1  /* original define comment is */
                /* now fine, no warning...    */
   #define B 2  /* Newly added define comment */
                /* is fine...                 */

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c             | 72 +++++++++++++++++++++++++-------------
 include/hw/ppc/xive_regs.h | 32 ++++++++---------
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b600546e78..dc86a7a3be 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -488,20 +488,32 @@ static const XiveTmOp xive_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,     4, xive_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -509,20 +521,32 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,  4, xive2_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b9db7abc2e..9d52d464d9 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -114,23 +114,23 @@
  * Then we have all these "special" CI ops at these offset that trigger
  * all sorts of side effects:
  */
-#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
-#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
+#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg               */
+#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg           */
 #define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user context */
-#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
-                                         * context */
-#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit */
-#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS
-                                         * context to reg */
-#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool
-                                         * context to reg*/
-#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
-#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd
-                                         * line */
-#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line */
-#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even
-                                         * line */
-#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line */
+#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
+                                        /* context                            */
+#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
+#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
+                                        /* context to reg                     */
+#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
+                                        /* context to reg                     */
+#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
+#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
+                                        /* line                               */
+#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
+#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
+                                        /* line                               */
+#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
-- 
2.45.2



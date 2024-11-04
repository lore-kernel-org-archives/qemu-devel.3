Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D48D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krx-0000M8-MQ; Sun, 03 Nov 2024 19:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krZ-00070C-8w; Sun, 03 Nov 2024 19:22:35 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krX-0002nH-2F; Sun, 03 Nov 2024 19:22:32 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso3124786a12.3; 
 Sun, 03 Nov 2024 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679749; x=1731284549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wt9sdYER6slUStoqyOAXgzU/BryYr6CLR9YuB/Abd7M=;
 b=fOcIms3B6J85R3gfpWJMyLLitJ/55Te7f7wyytxtz2NrzstAkYx5g4M5vptMIQOIUx
 wya0hBCP/laoVAwD0D4Bbl1AGS3cqYoc6qaHs7GfB/XdAuaIQapkmTNtZvZQTpAW/Fel
 XEX+SbIXkFKLS2M6g7JKNx5LyyieXo+/ntdPvq+dEU1EJpCXQbxLEPXRtDeRz73BGLJ2
 4K3RJQC711BvGyXrGufkuLfcLnKdZZ0AnWBO/uf15JYPLAiP28TqAx9qt+uziLtBC8Vu
 cvGcmNJrZhHoSs+HmbO4BgkZNVhdqI6KKeiE2BV+KWSq2k7LjUIfRjoFzSBRrJMkjNWI
 oX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679749; x=1731284549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wt9sdYER6slUStoqyOAXgzU/BryYr6CLR9YuB/Abd7M=;
 b=ONE2pg1ZxMQJ6Auzc9NCLqweu8rXIt5S8fBeSnYxABqGALANMJjH5QqJ5Y87bcLr43
 NKzqHvq2MHwA1uMYdoml3hzZWlquoVXzAP8504u/XjMLdLliarPMibceMxrHUguLwGSx
 Bj5VhwMth3pKgRQxslK7cTS6UgEu0koj6uOXZYk7OjZAarejwMJZPQ3TDDY20R/vcbjH
 z+jcY05Gwdw+rNFgnD/cOmzwBoDr0VNM61WKKuw38HswGw7HOTUG0V/5sgkUiVvtxbd4
 z/6L5YcBAmAbG7QtCHIbWSIjJloCPjZbNOy4nP0swBmsWEtYLLA60sVu3AcndvnZpNX2
 R9Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEFETx8eSQBfXIC9P6KymrjzyHRU3t/WUBnvHxGYw6vgAu54eQg2Ih+jBU7dk34Tod4cyP4gXSBg==@nongnu.org
X-Gm-Message-State: AOJu0Yy0tgsXlgbQbPkE6R5GWGnFNbaww8Qlzas9rnccC/SU605nSbrB
 3EZYmtGCMuK8Cz6jN2BPixcaZyMPYIuSOK7mJODkQVRnLO9ibWxqSYJhdA==
X-Google-Smtp-Source: AGHT+IF6yFW9UGSiGayhSuk4WOEDSLWB8TnTnMA5XOqJhktXAMpbbi7cYHror7armlc6hzLOMnJv8w==
X-Received: by 2002:a05:6a20:db0a:b0:1d2:e81c:adc0 with SMTP id
 adf61e73a8af0-1d9a8506e15mr43299036637.46.1730679748992; 
 Sun, 03 Nov 2024 16:22:28 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 55/67] ppc/xive2: Support "Pull Thread Context to Register"
 operation
Date: Mon,  4 Nov 2024 10:18:44 +1000
Message-ID: <20241104001900.682660-56-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte read of offset 0x838 of the TIMA address
space.  According to the XIVE2 Specification, this causes the hardware
to atomically:
  1. Read the number of bytes requested (lbz or lhz are supported).
  2. Reset the valid bit of the thread context.
  3. Return the number of bytes requested in step 1 to a register.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c             | 15 +++++++++++++++
 include/hw/ppc/xive_regs.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 574ac685c3..774e624160 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -179,6 +179,17 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return qw2w2;
 }
 
+static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                      hwaddr offset, unsigned size)
+{
+    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    uint8_t qw3b8;
+
+    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
+    return qw3b8;
+}
+
 static void xive_tm_vt_push(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                             uint64_t value, unsigned size)
 {
@@ -527,6 +538,8 @@ static const XiveTmOp xive_tm_operations[] = {
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
                                                      xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
+                                                     xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -566,6 +579,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
+                                                     xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index f8f05deafd..558a5ae742 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -101,6 +101,7 @@
 #define   TM_QW3W2_LP           PPC_BIT32(6)
 #define   TM_QW3W2_LE           PPC_BIT32(7)
 #define   TM_QW3W2_T            PPC_BIT32(31)
+#define   TM_QW3B8_VT           PPC_BIT8(0)
 
 /*
  * In addition to normal loads to "peek" and writes (only when invalid)
@@ -128,6 +129,7 @@
 #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
                                         /* context to reg                     */
 #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
+#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
 #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
                                         /* line                               */
 #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
-- 
2.45.2



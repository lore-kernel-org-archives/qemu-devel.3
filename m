Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00D3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCB8-0005De-8x; Thu, 06 Jun 2024 08:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCB6-0005Bn-JM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:12 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCB4-0007W9-Pe
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c1b542ae9eso675988a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676709; x=1718281509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=I5/+6fR1jIEoFdCA2qGCzqVO4gxoa88kyiD2DVMK2lRiJhzVdRldPmlJgwtjsjVKK8
 8jHe094Ya0l0hLJf7yjSdMQXlGvR1EUOed9sNqHuN2JP4oyo8ewDbDz2S6RTfodE7q3w
 LR9Y8JkT0QODmsKI96iT7uxlrI76wrq+avw0MUOvgJFwwA6kAfy4ZgCcHTo7KmpTevmV
 OtNqNaOfx4LWQEIXr3gL1FcpmO/Gr+tWLewuIFJax7DCfIMUPsOqqRo8EHnjzXmLGTB8
 t+gXoi1ViEehiQUjzTRGLAwumRZCqNDTq4nqMArFv+Kbu9XT/M52bHeqVVRvf9eIxRcz
 w7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676709; x=1718281509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=U5hXCs48C3xgw2YozZ+7E7uQ8pVZEVdrnQuFw6MjJiUSL7f4sm8YberlAD7xEY0tHu
 3LKK2GAVdHD4McDFy14QSKeuj5PAkRtD4AUOdSw4AxDhcc1Goum/T5yAf0t1qPnAyKUd
 lcCCirqwJXE667XzX0l4E2tCtDrry/QTrC+YxWKGy1ne2H+COa8YS6+NQYnZ+U7qiR7q
 ETUqfTOQK6ngNL4vjC+1xbT13K48CrDpdmk4CZQ/rIXebTxAFrTOy2mucDAEBcwylGzl
 IzYUnbD8kQjexqAB+KdLQ731B7x81l7GIyi/TED8nn36CLr8gOFedJ6ZoC4POzfdbkX0
 rkiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmBHFoX027koYvD0RxTVqEW7iGgUnLB7aKFWRrZTANkbjadyori2g0tUpNViJvgTg5cLgBjmprEnF1qJcU9hOafNJgNIQ=
X-Gm-Message-State: AOJu0YzHmOsFsqub4EOl3hZCkc7oVyv2lSXVbgMw1rYFhdcIUZA6FkGh
 1ArAFw0V94+NnO5abeSIjPn5CiBkq8XEWVnlwdzTgsBaFvUdd1h4rX8LC09FmRY=
X-Google-Smtp-Source: AGHT+IG4EmeuEAOsaNckXoYQ41Ai8ke+uadDKjLEkaRpTh7E1liMzb/x5ebamUZ/p4s45fPm9RzFdw==
X-Received: by 2002:a17:90a:1287:b0:2c1:a183:c61c with SMTP id
 98e67ed59e1d1-2c27db5b4b3mr5183505a91.33.1717676709065; 
 Thu, 06 Jun 2024 05:25:09 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:25:08 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Thu,  6 Jun 2024 20:24:37 +0800
Message-Id: <20240606122444.2914576-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add constants for the persistent reservation in/out protocol
in the scsi/constant module. The constants include the persistent
reservation command, type, and scope values defined in sections
6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/scsi/constants.h | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 9b98451912..922a314535 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -319,4 +319,56 @@
 #define IDENT_DESCR_TGT_DESCR_SIZE 32
 #define XCOPY_BLK2BLK_SEG_DESC_SIZE 28
 
+typedef enum {
+    SCSI_PR_WRITE_EXCLUSIVE                 = 0x01,
+    SCSI_PR_EXCLUSIVE_ACCESS                = 0x03,
+    SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY       = 0x05,
+    SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY      = 0x06,
+    SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS        = 0x07,
+    SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS       = 0x08,
+} SCSIPrType;
+
+typedef enum {
+    SCSI_PR_LU_SCOPE          = 0x00,
+} SCSIPrScope;
+
+typedef enum {
+    SCSI_PR_OUT_REGISTER                 = 0x0,
+    SCSI_PR_OUT_RESERVE                  = 0x1,
+    SCSI_PR_OUT_RELEASE                  = 0x2,
+    SCSI_PR_OUT_CLEAR                    = 0x3,
+    SCSI_PR_OUT_PREEMPT                  = 0x4,
+    SCSI_PR_OUT_PREEMPT_AND_ABORT        = 0x5,
+    SCSI_PR_OUT_REG_AND_IGNORE_KEY       = 0x6,
+    SCSI_PR_OUT_REG_AND_MOVE             = 0x7,
+} SCSIPrOutAction;
+
+typedef enum {
+    SCSI_PR_IN_READ_KEYS                 = 0x0,
+    SCSI_PR_IN_READ_RESERVATION          = 0x1,
+    SCSI_PR_IN_REPORT_CAPABILITIES       = 0x2,
+} SCSIPrInAction;
+
+typedef enum {
+    /* Exclusive Access All Registrants reservation type */
+    SCSI_PR_CAP_EX_AC_AR = 1 << 0,
+    /* Write Exclusive reservation type */
+    SCSI_PR_CAP_WR_EX = 1 << 9,
+    /* Exclusive Access reservation type */
+    SCSI_PR_CAP_EX_AC = 1 << 11,
+    /* Write Exclusive Registrants Only reservation type */
+    SCSI_PR_CAP_WR_EX_RO = 1 << 13,
+    /* Exclusive Access Registrants Only reservation type */
+    SCSI_PR_CAP_EX_AC_RO = 1 << 14,
+    /* Write Exclusive All Registrants reservation type */
+    SCSI_PR_CAP_WR_EX_AR = 1 << 15,
+
+    SCSI_PR_CAP_ALL = (SCSI_PR_CAP_EX_AC_AR |
+                      SCSI_PR_CAP_WR_EX |
+                      SCSI_PR_CAP_EX_AC |
+                      SCSI_PR_CAP_WR_EX_RO |
+                      SCSI_PR_CAP_EX_AC_RO |
+                      SCSI_PR_CAP_WR_EX_AR),
+} SCSIPrCap;
+
 #endif
-- 
2.20.1



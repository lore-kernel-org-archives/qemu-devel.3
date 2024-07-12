Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4088C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS6AG-0004Qe-JX; Thu, 11 Jul 2024 22:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS69z-0004Io-Ev
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS69x-0003P6-BP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-706524adf91so1328302b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720751839; x=1721356639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=QYbC++oLrSiq3Y3GblixObQGwtfcuRRe3A+LD424IynkK+bL8y3P6B6jFJ/Qg5W9Sd
 zvUrGdpIUvIp7s6GYTl4Cf+BAgOlX8w4tfW/hlPinnAJvSLDrEORjwWVUgHQzCTn3Af6
 LVPLmbZGJdUuQ+jxqLdCs2wB1/5dv6dpnjv3eLO+7KXZixeZRXyWncBsznjpw7EFIPKl
 BKmX4eyyc6BPbHP3mTqs4zzNZCSc5753A3+b1zalvj27pAIqHs5Nx1l2eOPcLj2zylgM
 C9n+AuDxL5zA3j9r+zRPh2YMfvyfFsr14TuqeSc32+9ZZrQ07NQ2ookI0Qqv40WwRz2A
 C7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720751839; x=1721356639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=fftsXJutgrnRBfb5YE8+sif8WWW23IyBVla0q9YYA/EQmQNyD00fvCUm2cyZABYcAL
 +QFUXEQPZpulmj7N10tYKN+rgKBM17JzffgcMjtuJ+gB4/8uZEc4QMEWcxne+Qy2dQi8
 ZNCfijFYV9gechpZuas+29kdgHtTWCrhms4X9e4Ogtupp4VO9sxZj9xpa7/QyEPtXc6i
 vC2/t5mxkxKnFX/6Kg/1fD3mm3TbZnxfTzKpBOGb60or/67mGVhFebDSgi+Mrq6ThlDy
 jl1bLKNHQ8DWbyj1lJ97Z5ZvSYji2Myjyeh1jLTsXXlEWfP8+YubVj7vJwn7nCcwdKRi
 lBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFASNcZgxN+TSrJmm0E/VguaX6prAxjNO5j7DsFk/od0eWsGcfiHv4/jat6SaP6/NqtM8RhPFGya7flyD3asUBE8t2Adw=
X-Gm-Message-State: AOJu0YzHfK0O1LWdCDgceL5cIY7hReJbNDLUySZPB090GHq5mBaoA1e3
 /HXIVw4MVweTGnh4CXu0y8UuKapE70lXCUfVnmjT+ugO329z72l/Ep30fbCqIk4=
X-Google-Smtp-Source: AGHT+IFr5cFzqVwGH+hY+yqnMaoSJ2MXHGJ+vjXGoyege32am1zot5D82ZkMaoB4q0n2ZZBNPdF/bg==
X-Received: by 2002:a05:6a20:841a:b0:1c2:8a0e:6f84 with SMTP id
 adf61e73a8af0-1c2984d8e25mr12231751637.51.1720751839344; 
 Thu, 11 Jul 2024 19:37:19 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd65fc43sm297453a91.39.2024.07.11.19.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 19:37:18 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v9 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Fri, 12 Jul 2024 10:36:43 +0800
Message-Id: <20240712023650.45626-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240712023650.45626-1-luchangqi.123@bytedance.com>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add constants for the persistent reservation in/out protocol
in the scsi/constant module. The constants include the persistent
reservation command, type, and scope values defined in sections
6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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



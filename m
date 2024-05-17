Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB530C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uGf-0002Be-P1; Fri, 17 May 2024 05:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGd-00028h-MY
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:47 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGX-0006NE-5f
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-61f2dc31be4so823949a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939560; x=1716544360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=SFxTmRVCpYN1NcfIFIlmBTbyaWFUJiYK3H9Lv7mYp4HbQvgfeuihWZO4JTm6YKupLt
 55LULvcOpipKt/nrLR3wNIiG4lC+4i1StD9aau3Pr07B/AONYtl5i8gxog79JViasl3Q
 zWMoYYkwpGCb4zJDE5CEYp2e/jM4XlLAeUeKHa8VVuTzAFmSObOW7n3L1A7ftALFTYTy
 WNfmbSICtOUkJfpk8QE+VxlqFZu8BuRjCYdPqgo+R9jhrFrn/uJspKAgp8wWu0gsymsV
 Vtof8grQdx8eOQQX9+P/4FSwdKycn7EZw+QqYER+QTFmrECqAOk4xYtfMTEkqPdzojxN
 wAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939560; x=1716544360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=YsGJXgOjh1/by/PcqEF6zanDULZRPJqDfbL+GI+i4//A9y6zEOTCPGyaBteCAiJEyk
 /HfJ0cC549eGHmlnHcw4Hx0sfUo5Bq/c84r+fg0VVP769+d4Rww0orwW39G4ThGkIQ7/
 pe/R56yUFkXrz/4rpxXZGZ9ZEts3pe9WWrhHNMBOGHAwUrb+GwteE9F1dXO4r3rW1naZ
 XR4PjCg0z2iR9N+47GfjbaiL4/0HO+Y4IC/myQeGirL4tU8wj4p/3YWQvpmKtcA1r2VQ
 o3JceVr58teZhRk4/lXv8E4fGJFANM8VbxWXSXgUNE06aOFyYh3RLPbnF3eVhkFUhX4J
 u3Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtTzyEyo0JiXZ8F/9EWaPM1tt9HXcT6i0pkowVjPx8qlNd1JDVswKbXkoK/woQfwADO/ZvFFjEQ5PIcbRZbU0YIaoe+IY=
X-Gm-Message-State: AOJu0YyRxd7yFP1XO6fsGNhmwBX6WW2lHsVecO9QreXDzB+ZLICYn9d5
 GXu1gxcdF4KnoI3q5uJN5ld2siHCYag+uXlGT7TbqUn30BZdNt2MrSdqf+D0nfg=
X-Google-Smtp-Source: AGHT+IEC5axh6Jfs+14z/ZMiYWpWqVQVZyNhqJ1NZDUGBsP4nPftrVP0UeGRr1kIBTBwAFdzbEN+bw==
X-Received: by 2002:a17:90b:1051:b0:2b4:35a9:65fc with SMTP id
 98e67ed59e1d1-2b6c75dce41mr31357948a91.17.1715939559710; 
 Fri, 17 May 2024 02:52:39 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:39 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 03/11] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Fri, 17 May 2024 17:52:10 +0800
Message-Id: <20240517095218.3107672-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52a.google.com
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



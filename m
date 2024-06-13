Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05852C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeef-0007UV-QJ; Thu, 13 Jun 2024 03:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeed-0007Tu-4a
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeb-00073w-8T
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:13:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f6b0a40721so5113025ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718262828; x=1718867628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=ZjDuXeqHM3/hqj7I3JaVxhzT3RARDq1gPmvYYpP1/M7H0VNZyMTLvrkeaOnmx2vwj5
 VmwJ47CX8BNDnJ9XwmDAcfqToVCTfhKS3yc45J+Z38358yxQVpu6HUp5A5VqnR70j7lO
 urrvvW+mp5e+2irqukDEFxieqlfcUfENjaPWWRoJPQICzD6E25Cfd+m6gr7/1gsVWaHY
 yK+OXOBuCoPvdKMQ6DWgMOlz/E3kVnG67m9YP3136uGBn/nbrKrDMSpAZJT6enlKABGn
 bZVJtf0R4VgD/dVr27jqv/dosl6131bzZ9m4d66UxO5mHuo49a61s40Qh+XozuLnkB5Y
 klXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262828; x=1718867628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=Nd/Snbi6GvMqk3jzxc1fn4crVis2qSjKnapDL5CS8zF5ZpRvIcQrNEMkIh/N6MeLdB
 ZcoyN6fpjFspvDTV3nsZVCg1p3eOSJLFTJFin2DmjOh10VJdlCsK/s61dimLH9Fn8mwb
 M2TibkLRQpZdcX/DCz7Zz7XW+BKsw3ySGQvyEn3seU3saAhHh6VYGhFYKIuUO7oRPhs1
 3ZIqFjQlf2dszneXZgDbLadEYaMJDLYd3/lYZ9GWJ4uwmvwa7zX5BqASKk1fSaWM0A13
 na0uiH7fmg0RSP+zULCN6BiXyPzFcmWC6LlFBniYMrlkpDAjqAr2BzGxPq+xgE+zIRGG
 lb8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/DMToJ+GHFs2ohziqaIygIYXoTw22X2fjoFbpPV6y20ZqPOM/4UFDtOgq41gnQ0j3xVF93SgiYx6P4fxj8DJjwhBylD4=
X-Gm-Message-State: AOJu0YzU3TqFMNeKQH8r3WbfINLs6UJRYKpztH9kePNIE1E/xagbLuXF
 ELADeS2cvfHVE82gKjGmtMMlocnq2C/pyt097HF7Hgg5AHV+8bWvPkTRZe2+o1k=
X-Google-Smtp-Source: AGHT+IGFILRovtezFAtcnKYtXW81eeEO0CbVBlsS8YaTgf8Q75fpu6GEr+y5PMe3O65dpzw180934A==
X-Received: by 2002:a17:903:983:b0:1f6:39d8:dc4f with SMTP id
 d9443c01a7336-1f83b55f8ccmr46620145ad.10.1718262827862; 
 Thu, 13 Jun 2024 00:13:47 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6e7esm6378345ad.139.2024.06.13.00.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 00:13:47 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v6 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Thu, 13 Jun 2024 15:13:20 +0800
Message-Id: <20240613071327.2498953-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62a.google.com
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



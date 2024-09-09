Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA59ECE586
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncg6-00028d-7z; Mon, 09 Sep 2024 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncg1-0001yJ-D6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncfv-00013N-Q1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2054feabfc3so36522655ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725881718; x=1726486518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=JP2XZ4GjZbdbkaIXIekRLSULgSKdf9Aku/fL/FnY6Ipm8QOU0+ySY9yntg0kskpCle
 KJz6NRblVzPQauqFXaFD73lhy9cj1QNLVYSj9JDo0LGJZrwlenHm2FKS5VUOizYbCiBo
 hJEnLe5z5ffKVNbNC6zwERQ0/CJpbFhMEfo7GIwyakkuKGReBhKH5KlSGY1BTpdOkiui
 sdyX3iVHmYL3/wLBQqixXRylv3mTdo5DugDKT9H24TgPD1BPDT/0Q/FRRc/yWCAoeP+x
 QuSRHdWMmAugnsBt0vAWTO9KyL1rfWrsGgTzwUjsfn0fe5jBHt5Sdkxb//UT4UruXjlq
 +GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881718; x=1726486518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USEpHR6NMIBW3vxaZJ60aZgKZIewwnVEOQkR5GTNazo=;
 b=oc+NF3E9hpWcF7gVPPimFwGl/aK1QhpR0cXynuE+w8s9GSKlRvnsj9HuFcpaqnjtLU
 7UeTq/KRmCC6eAPwrWyI5IDIACmnuO6e1x9iIkBFwDjeSBbnEqcnTbl0era/j97NIiwt
 BKTolXdrmcyghRVg2wqlYi4e7fuImd3Wi3IeAbNBIJE7TbZxvagS35ucPaTrkioX4ZYk
 ujRLnyVZh4ykrk6xoTfAT+klb/wqV2GyHWnd7LaA3o2BBmN9U4ZaLT6sMUjVSxjorMau
 gEtsWasnRw7SIT+BCGNUZBoncb6IPGQvOt3xaDE4kHUkzw6zWsEApiUCd3Du9yIizDPt
 rsxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV853g1wHsErqvUQK5zZCd1Cjv6JTg8GzIkEOCjgdi6xUl3yqV/kweo+YzqsjcMEVeL5MpqeibnzP+x@nongnu.org
X-Gm-Message-State: AOJu0Yx/C2OpUpSFDZkCeSlNAt0YYsa4wLcK+gH2ZvGVKvK57cnvaxqM
 FFxInhU3myB8kZLI78yLfP7ZgvdYMrRot1uk96JSZhmozj5WkyeOlLO2ROZYRU4=
X-Google-Smtp-Source: AGHT+IF4u2r8jc/ySjk9tbBcVQuGPJpDIYV31OkXT0HAqiRm6+2gltpQyFrlyQngubgBn9WsTLimow==
X-Received: by 2002:a17:903:234d:b0:205:5dfe:7be with SMTP id
 d9443c01a7336-206f05439dcmr144246965ad.26.1725881718358; 
 Mon, 09 Sep 2024 04:35:18 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e328aasm32378605ad.91.2024.09.09.04.35.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 04:35:17 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v11 03/10] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Mon,  9 Sep 2024 19:34:46 +0800
Message-Id: <20240909113453.64527-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240909113453.64527-1-luchangqi.123@bytedance.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62d.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40D5C3DA51
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS6AS-0004zN-H7; Thu, 11 Jul 2024 22:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS6AN-0004e6-Iv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:47 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS6AE-0003Qu-2d
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:45 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-75ee39f1ffbso1013207a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720751857; x=1721356657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=MUq+z1lj4rsgk8Mabuqie3P+M0bZwS4kKIANJ1+HVCqDrZ9j/eQ4NTffmo5fryn1Fu
 UMAsZpPy4XoWEfQajxxEMurBkV8yhQHojX+LygmIejbFEyLLvEt89+gFOokfGXJJ/wG2
 /zJ98Z1k6HXCqZZ89wmQvPjyu7W6Hy5oW/5mUsicME+zHDmctmyts1/sVrumDETt083L
 khBszrls3NygMyZxgYltjcrwo/yKBcVomdAxXkcD6NUYIlGuccwQRR8JMKS2ltLuJhqc
 7gqifTyDunXXkxu4X1rSrXy7VNQT9/KTV4oK+fg0jNNQhlC6pQZEAMQuhRCAYaNFCyDn
 qJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720751857; x=1721356657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=ae+XvOLt4tWlXQCJmlLQXfrN2TVV54CjmvpjmBsdzbEHhOnMWbsD41BipqTQ8qsHLD
 4lWMExyHER5PYSuS72q36dpU33DFezxLdG/3q1dmKgm0jkvUkir4brYqwtTJdQdq1maz
 sMAGNVTZSKV0tQnXnRUys2lntc1eQIRxbpsuQ6VEHHJ9p9UorZD5opPdh6jtMNNcOqnA
 pJZH8FbKuZuhvUQpB/EnwWB/H1v+w+turkAZFA4ttNosexMKyqfBsG4Vbhz/fJpA5eTm
 XI/SFcXE14vRbNorB/OVA6PneHz6BKKz6YfKUNsvF7XeJts1Qq8b9d6ojZulEwPNkXAJ
 jxnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp9+kQTSYWlUxHXpVgnnXLjzwcF9peKsv2NnZ9bHaW/Zd8rYXwoSTFpiGObZl1t3rDNV0Lz25tP6Fr7FpQOQQ0PMX/8dE=
X-Gm-Message-State: AOJu0YzvosNx4t5yOL0Op3WcEFUjif/L8VYmYpNbId4xQC4ZayFhWoS8
 GsnuA5xpf4ymWYRA62oDkquTpSUvIT+fyn/e+tbQb58MgzeV0vn7M3y72SXn8YE=
X-Google-Smtp-Source: AGHT+IHrOjeMOeGMsDE5hwd49+kybxcOCkNefd7P7UUcxPATIsO6ph2787Z6Lb952i/f/D8JaP+6ig==
X-Received: by 2002:a17:90b:2b4f:b0:2c9:5c63:29f4 with SMTP id
 98e67ed59e1d1-2ca35c6cbc9mr8031846a91.25.1720751856651; 
 Thu, 11 Jul 2024 19:37:36 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd65fc43sm297453a91.39.2024.07.11.19.37.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 19:37:36 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v9 06/10] block/nvme: add reservation command protocol
 constants
Date: Fri, 12 Jul 2024 10:36:46 +0800
Message-Id: <20240712023650.45626-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240712023650.45626-1-luchangqi.123@bytedance.com>
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add constants for the NVMe persistent command protocol.
The constants include the reservation command opcode and
reservation type values defined in section 7 of the NVMe
2.0 specification.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..8b125f7769 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -633,7 +633,11 @@ enum NvmeIoCommands {
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
     NVME_CMD_VERIFY             = 0x0c,
+    NVME_CMD_RESV_REGISTER      = 0x0d,
+    NVME_CMD_RESV_REPORT        = 0x0e,
+    NVME_CMD_RESV_ACQUIRE       = 0x11,
     NVME_CMD_IO_MGMT_RECV       = 0x12,
+    NVME_CMD_RESV_RELEASE       = 0x15,
     NVME_CMD_COPY               = 0x19,
     NVME_CMD_IO_MGMT_SEND       = 0x1d,
     NVME_CMD_ZONE_MGMT_SEND     = 0x79,
@@ -641,6 +645,63 @@ enum NvmeIoCommands {
     NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
+typedef enum {
+    NVME_RESV_REGISTER_ACTION_REGISTER      = 0x00,
+    NVME_RESV_REGISTER_ACTION_UNREGISTER    = 0x01,
+    NVME_RESV_REGISTER_ACTION_REPLACE       = 0x02,
+} NvmeReservationRegisterAction;
+
+typedef enum {
+    NVME_RESV_RELEASE_ACTION_RELEASE        = 0x00,
+    NVME_RESV_RELEASE_ACTION_CLEAR          = 0x01,
+} NvmeReservationReleaseAction;
+
+typedef enum {
+    NVME_RESV_ACQUIRE_ACTION_ACQUIRE            = 0x00,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT            = 0x01,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT  = 0x02,
+} NvmeReservationAcquireAction;
+
+typedef enum {
+    NVME_RESV_WRITE_EXCLUSIVE               = 0x01,
+    NVME_RESV_EXCLUSIVE_ACCESS              = 0x02,
+    NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY     = 0x03,
+    NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY    = 0x04,
+    NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS      = 0x05,
+    NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS     = 0x06,
+} NvmeResvType;
+
+typedef enum {
+    NVME_RESV_PTPL_NO_CHANGE = 0x00,
+    NVME_RESV_PTPL_DISABLE   = 0x02,
+    NVME_RESV_PTPL_ENABLE    = 0x03,
+} NvmeResvPTPL;
+
+typedef enum NVMEPrCap {
+    /* Persist Through Power Loss */
+    NVME_PR_CAP_PTPL = 1 << 0,
+    /* Write Exclusive reservation type */
+    NVME_PR_CAP_WR_EX = 1 << 1,
+    /* Exclusive Access reservation type */
+    NVME_PR_CAP_EX_AC = 1 << 2,
+    /* Write Exclusive Registrants Only reservation type */
+    NVME_PR_CAP_WR_EX_RO = 1 << 3,
+    /* Exclusive Access Registrants Only reservation type */
+    NVME_PR_CAP_EX_AC_RO = 1 << 4,
+    /* Write Exclusive All Registrants reservation type */
+    NVME_PR_CAP_WR_EX_AR = 1 << 5,
+    /* Exclusive Access All Registrants reservation type */
+    NVME_PR_CAP_EX_AC_AR = 1 << 6,
+
+    NVME_PR_CAP_ALL = (NVME_PR_CAP_PTPL |
+                      NVME_PR_CAP_WR_EX |
+                      NVME_PR_CAP_EX_AC |
+                      NVME_PR_CAP_WR_EX_RO |
+                      NVME_PR_CAP_EX_AC_RO |
+                      NVME_PR_CAP_WR_EX_AR |
+                      NVME_PR_CAP_EX_AC_AR),
+} NvmePrCap;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1



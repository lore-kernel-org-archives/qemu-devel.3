Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCE4C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeer-0007Yl-QG; Thu, 13 Jun 2024 03:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeeo-0007XI-UJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:14:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sHeen-00076v-7l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:14:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso6773375ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718262840; x=1718867640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+Wolbl1WfWkEWcOSIA0S4HH/bAzChpwJhJKAa1Hf2Y=;
 b=NaR/ztng/v/9OXWE9QmwSuVFl5yKXAPmM0LK6S1P8Apg78cuZgOAlVYjaRi6WG6NwU
 Nr8xMA335d+9IfhwaMN1ePTnqJszGoZb7rclAKKZ0jkoj4BEKVCehNCGZb7XEkRyd2kK
 F5Gtk4IoU4sOCfJXW6DmxgPbko0b7jeqJr+NaSxVwWk/9gtWuRE2VFeiFBsi2begf3eC
 uoweoE6mP34dPADe6FdQgYHaYJrx+Aekb4HbkV23lYG/U7u5rzSBF3lr3vk8dQut9gb5
 UG5oozmE+CT55x1HWQ/A61faFHW7IC22Y6yaeHDBKOvgfjQWmOVF5Z3q6pjY65sLBs0j
 Py3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718262840; x=1718867640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+Wolbl1WfWkEWcOSIA0S4HH/bAzChpwJhJKAa1Hf2Y=;
 b=lSmzMhis5EnYRyoZ81SEAYTl1xPRWg5jzjiKRG+2niW9f9tNRAbxwawZMLgOblgr2b
 ytdUHXMZlomcbquPVVodC6TINX1aCsV4+dllNjwLqZqxqtDXQDQQzPfSwZGu9d7uvZ/A
 y5DXIkBTSJVDyPWm09aU9zPyOSLj3oFknD5vhIUh6buvZyAXPlc/laVXzvPeguQpY8yM
 zV1k30NKDhZ+W4szyYbY7aBF6yfV/XjZsZ030YsCMeQi4kbay1pExQ/twoi3NPA4RfzP
 qkxleO5T/ly99FOluPKlRYVLWLdkC87OFs5Icag6ku+s/a8iKvXUTmeEkaBB9IflP6WF
 3ELw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBXioxyuaXRAisYwumIxkZqnatIL9bNwIfPXq8/d5rhzT7B75nIbCrYpxB0GqPEhNxZwHwGQI+8sUlKKHs8B0elT/B1zA=
X-Gm-Message-State: AOJu0YwbGTswje38qY2HaXB12uXlG4I8ZA6rqyRRnbGfR+8YeQ3XiDN+
 CFJQm80+ti34RQuk2fV2apw6FNCrwEJ1lC0GfwMXxjIOj8diw0+8qR3qgrj+buw=
X-Google-Smtp-Source: AGHT+IHspVcLLsfY9eHfr8RNWfDO/itjB/0GOmEkPXphkyuDEbNRGt4W4KpOuB/tY1BxUMhbhp8Pqw==
X-Received: by 2002:a17:903:2287:b0:1f7:1a9:bf09 with SMTP id
 d9443c01a7336-1f83b6eb7fcmr46858105ad.51.1718262839755; 
 Thu, 13 Jun 2024 00:13:59 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.84.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855ee6e7esm6378345ad.139.2024.06.13.00.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 00:13:59 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v6 06/10] block/nvme: add reservation command protocol
 constants
Date: Thu, 13 Jun 2024 15:13:23 +0800
Message-Id: <20240613071327.2498953-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x633.google.com
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

Add constants for the NVMe persistent command protocol.
The constants include the reservation command opcode and
reservation type values defined in section 7 of the NVMe
2.0 specification.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..da6ccb0f3b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -633,6 +633,10 @@ enum NvmeIoCommands {
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
     NVME_CMD_VERIFY             = 0x0c,
+    NVME_CMD_RESV_REGISTER      = 0x0d,
+    NVME_CMD_RESV_REPORT        = 0x0e,
+    NVME_CMD_RESV_ACQUIRE       = 0x11,
+    NVME_CMD_RESV_RELEASE       = 0x15,
     NVME_CMD_IO_MGMT_RECV       = 0x12,
     NVME_CMD_COPY               = 0x19,
     NVME_CMD_IO_MGMT_SEND       = 0x1d,
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



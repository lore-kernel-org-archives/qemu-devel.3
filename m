Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93D8C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5u-0005FA-UC; Wed, 08 May 2024 09:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkv-0007f0-GH
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkt-0000aE-TU
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ff57410ebbso3329570a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161110; x=1715765910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFPFIrQSwbonOV1Lxc6f0KhdGy2FCqSxIxef8n97aRY=;
 b=D/uBsBmkWjLRrY/iME4smJluXXkpSMzSb4fprqPvDWpbb0h7T4ZERihkmB+VLtRH2d
 uLrSq/lzeFXDZLMs475ICN13OIKtb4O4jlxUuPuADskSH0c7jWWgcHiPecGQYAM6RN1q
 GcxdjFiDFbSOMHG36Fdsd/mOf1JVBBdXxxoXG70egBRgyk0uV6TDctDvyi/VqdDML6O7
 UMSDGTPgbyX7PC5+7Xk4jhmr6PArO4OJ7eKmo2rgpcVjoMdY2/V1KnKWXGZWsMpgn+8r
 IjGmp95+Gmn7dZO9Ao7CHS0S+LbBuekNkE5unQ/5x1pOXz6rmXtrXJqHUrwg+zYgUMZK
 yY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161110; x=1715765910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFPFIrQSwbonOV1Lxc6f0KhdGy2FCqSxIxef8n97aRY=;
 b=ajXwAnhyBKggDgUDdHA5/ykQyb7ZZyBBz5EUGJAXcBHKIkYFj/sMbHN9+znV3I/yaO
 6VzYBGuTdUuSmnfqmetyxSM3bctN3Qo6oJzw01vD33i7waq7jwNKAKiSbY1M28sWIqYn
 HaKFDq9BHr5kzmo29QGTz4lUo3kdqjjDHleKQBQtnRsYfgscKkhmU72hzYnvb5AE9c5j
 ny8wsgS/a5exDYUM9ya0KVcOEpMTnJK1SLwh7e+T6dOexMLJyFf6hsvxAauKenTIyIFj
 uXYPJNj0S0pxJ+mJ7q7OUqOOwspiMKjlL0xzeqMCAa4qbX0T2BeB69C88cA+A4RTF0Fz
 A7KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqXLQ0iW6QnEDCp8IK2WB+z2HBOaYIl+YjzFxoem2IZ1CQ4QnbeYFoOen4OmMcjMqd3C4Y7FTseQpYqfD7enUBWX05pqg=
X-Gm-Message-State: AOJu0YyABDR5qVCBe3XvAZTMPuuQhjWyR0jqoCMf8zl8zktzRoP+ihQ0
 3Wr/PUQ+aztCiIbjjVFgp904h9xA6j9x59kj8m7ltLQsKJv3W8pUtjsWNELqNrA=
X-Google-Smtp-Source: AGHT+IHVkAh3WR5P0kjIKVVEosIeAvI3hhDd1eD4VvY/gSFtVxjx9dZbAysNNXqL9FWwiXwOSv9HfA==
X-Received: by 2002:a17:902:b48f:b0:1e4:4000:a576 with SMTP id
 d9443c01a7336-1eeb0795f3emr19156935ad.43.1715161110685; 
 Wed, 08 May 2024 02:38:30 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:30 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 6/9] block/nvme: add reservation command protocol constants
Date: Wed,  8 May 2024 17:36:26 +0800
Message-Id: <20240508093629.441057-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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
 include/block/nvme.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..3409fba762 100644
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
@@ -641,6 +645,32 @@ enum NvmeIoCommands {
     NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
+typedef enum {
+    NVME_RESV_REGISTER_ACTION_REGISTER      = 0x00,
+    NVME_RESV_REGISTER_ACTION_UNREGISTER    = 0x01,
+    NVME_RESV_REGISTER_ACTION_REPLACE       = 0x02,
+} NVME_RESV_REGISTER_ACTION;
+
+typedef enum {
+    NVME_RESV_RELEASE_ACTION_RELEASE        = 0x00,
+    NVME_RESV_RELEASE_ACTION_CLEAR          = 0x01,
+} NVME_RESV_RELEASE_ACTION;
+
+typedef enum {
+    NVME_RESV_ACQUIRE_ACTION_ACQUIRE            = 0x00,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT            = 0x01,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT  = 0x02,
+} NVME_RESV_ACQUIRE_ACTION;
+
+typedef enum {
+    NVME_RESV_WRITE_EXCLUSIVE               = 0x01,
+    NVME_RESV_EXCLUSIVE_ACCESS              = 0x02,
+    NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY     = 0x03,
+    NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY    = 0x04,
+    NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS      = 0x05,
+    NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS     = 0x06,
+} NVMEResvType;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1



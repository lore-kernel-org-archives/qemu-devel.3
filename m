Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48644EEB591
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 11:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sohs4-0007Ya-0a; Thu, 12 Sep 2024 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrn-00077k-S9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:20:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sohrl-000842-Po
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:20:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so652596b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726139999; x=1726744799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=ESGVLW3/EAv1MPj5qCmRL41JG3cZ5gpMbLsTNvJZ3mbc7QzsL3p52M9viQAv9Iy5ia
 DQ3SSUTaDY0TB/T7EA7By95dq/II0AZ+lYDzggRxpACRPwOvUj8srIav4xKiA2GWE+Fc
 0JU1zjm3vtgGqo0AsPqz/s+gLECinIIiBRKCz0AL5auwQqyMTmZp2YXqd/Wp5fll55tT
 xWBSrI9lxykCfzSff87Y2uiz3hxVRz0y5ZlKvhKGNyyYVTpJCVt4S4JQM0jknvnlZ3no
 VcTVz4byG0ABGkdaCsauXq2c2tln0EZH3D4+Jrc05QDHkxzamNgLL5SV3bmpt4OoGS1Y
 /wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726139999; x=1726744799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=IMHuarL8ZCshza7Xi3es7JDsog6ph5epndqXSN+rDgIW1+ptkOSFb1+BvWUMfVe+Cn
 N26Sz1InTNIsCTSOI1Z/+0oK41+dWckCTu3qe2IBNLupp2XWIzBZR2R2l7QOEi1/yZfV
 3GGrhk8XnO/oJNhH/lGqHJJcW+Eg+CMlCzE9B5wFNgINdyq3teqTjItvTgaqDsd52B/J
 OfsSdcBRgqoabyfgatCStU1qc95gHjrHuJEIjCQ28tkveI3b93zfgDRhgF8IVtZqnWRe
 dx8LA8bf8T2vgH2/m7BkuDm8lD7B8d2yP0sVwXKz61ax5zzHmV9313KR/VIGBXhdzW+P
 xJ9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoUD17OSmHpCev2HUIoFhWWr9w+PjWL8sisr0TrnbGRwjRr6FiFJeSvdNlE/csSsOykDBKWA6Q25BM@nongnu.org
X-Gm-Message-State: AOJu0YwN5LR74Kk8ROcxrIIPunp/a2IwFJfRmpovr3ISu05lMnn5N8IZ
 4AoK1lw2bTz18ydnsnjKH5bAk55V9WtJ6MdZvJXTAdEJ6ASL1hwnL+QaeMWp7FE=
X-Google-Smtp-Source: AGHT+IGXqW+WqTad8X8WzDE2ff232T3CDa942zxCkp2+bfSoSRkOXUT7amPRa5FW5bJthS7/jyRIFg==
X-Received: by 2002:a05:6a21:4d81:b0:1cf:241d:6024 with SMTP id
 adf61e73a8af0-1cf75ed3cd0mr3707992637.18.1726139999354; 
 Thu, 12 Sep 2024 04:19:59 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090afadasm4552072b3a.177.2024.09.12.04.19.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Sep 2024 04:19:58 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v12 06/10] block/nvme: add reservation command protocol
 constants
Date: Thu, 12 Sep 2024 19:19:13 +0800
Message-Id: <20240912111917.81477-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240912111917.81477-1-luchangqi.123@bytedance.com>
References: <20240912111917.81477-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x429.google.com
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



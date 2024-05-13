Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC9CC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkR-0001Iv-JU; Sun, 12 May 2024 23:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkO-0001H0-MI
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkM-0008KX-7f
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f44881ad9eso3103068b3a.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572384; x=1716177184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i465EnGDyfK44C5+363nJTlY4s6kuihcAa9kkbF3sbw=;
 b=Yap4EG2QNang1Fq6S4IftSijNrsNogw1lnrYLPCwYxLVYRCxBGebyNV4d1hP2IsWnn
 M3z/OI5InbwSvoNSXLvpLwHrtXIQucFz7NmAfnR4TpgLgIdeMCo+u4D4H4reCLpqY7EK
 Xd/00/QjwQ4ONtOw/EuxCc4Vt6qHD/1tTkGLQFryIvvJK5QsoTrTv6b8+wrz/k7nTCOj
 HXj43kLfjkTrw6O2pIOB9a7vZhhS+Kh7sjI63U1ERbue9TRjRvhAsMGOdgziYXA6vU8/
 uywhOJ9FBDTZtJAr8ENBiF6OexjdyrwIgdD9nSmwCNpERc1WqyBHjWx4dw4DD8WlXkUo
 ua7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572384; x=1716177184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i465EnGDyfK44C5+363nJTlY4s6kuihcAa9kkbF3sbw=;
 b=nWx0Osw5yxLJOQXRWq+byCvG+rQVcM5uHoUQ/y0GLJ8/ZMJBX0PgaAb5eqvZzbRnlD
 0lGtSpCXLVL1mS4853AjwXAnLVr3GCJs5Hiz9tyesutfXENj5E7JNQ41xhSD9Qjxok1W
 t/DXlcfdQS4JXganm4P4DSHIbx7snSumzopTXcLR6aQRR0yCdMsQn/FVujPWPorX17/r
 jhTY6FaN4bXQs9cuJsWmmQ6gDYQZuON9QK2GAMF5LysYLnCaxGHJLPWXatp/d3Ix9xyM
 pM6J8D07+hhX6hgufufOdBFSOVs0teQhG31r33VTKCuPYcnNiXPjow2rTpxaaHvFoNxe
 uXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9uo3PgubqJi/LxfTpcUWBzkwQ1uwYqQiPXI7A8ltHKtCNJ6Tv9ag3RZGR3TAO6lbOIH7nWSE1HZZzYjm9+UvrS0Z/7M=
X-Gm-Message-State: AOJu0YwpYBUhBKeSBzHA2WcGZ4CZfC+0LAmuhNeZYxyKrSFukCCMbn0R
 kU6oq8+l26S734hzOhL2HkywPfhtbwtp2MlTADRZNUzucBH1k0NdSaxf09SMcQE=
X-Google-Smtp-Source: AGHT+IFrFmmxjFUHwdvbmXYbm2KpHaVERq0+z393gt3uGz6Y/fI8gPaECVxD4pU8uB6aICqzm5hqpg==
X-Received: by 2002:a05:6a00:1992:b0:6f3:eaa2:53a0 with SMTP id
 d2e1a72fcca58-6f4e035d46cmr10127885b3a.24.1715572383840; 
 Sun, 12 May 2024 20:53:03 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:53:03 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 06/11] block/nvme: add reservation command protocol
 constants
Date: Mon, 13 May 2024 11:52:25 +0800
Message-Id: <20240513035230.60162-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/block/nvme.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..42e8b43408 100644
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
@@ -641,6 +645,57 @@ enum NvmeIoCommands {
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
+} NVMEPrCap;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1



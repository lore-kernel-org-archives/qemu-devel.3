Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54CD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJEj-0003FI-Nm; Fri, 11 Oct 2024 13:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7h-0003l6-Px
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEWI-0004um-6D
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:13:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20caea61132so2622035ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648801; x=1729253601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=frgDzAB+UkIhdo5oCQWUCKNVZBwL3F0qNfeEF1ub6k90zBP3m3ICkv3NrVVIDPeH9C
 AKZFfRoe0woQ0cNWnSp9JbbwZ0cK8X71BK0OQmxAq1Uq9C+iIxM1t0KV9/Uv8GC78V1U
 hoEhVYNNnjkTSMWgqKQicaPehitE65IPnCpmnl8Y+AdDJF+HxOYg+yLgiz3YHfsRVwmd
 dz+hoXoFJv21e1/L3oGLrD7zM+iP2eWIz5ityXQ6A58+yTAUoppfadamQycuLT9vdt51
 6N4DN5O/4MwczlynNJEfa3YLNosO1VXtmQTJ+q04fwuoTjTn+0jdeU9elyZx0m/eU5lT
 NIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648801; x=1729253601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=fwuxPcuZKWCIfuSAVQ3siSibb9aVl2Xh33ixJKIRpho4pxylNqy1cFIWDRNGKhWDud
 jl1MX5PyGC/W+Nfc4kflMHmiB4avh8Od8R21osJukPrhoVxPB6fYpPH6r/clSsUfNfSQ
 XBa9elAy/GAGWinx4eNz6UnwkBloHzO+p2BOl5RUd95gF9tdb8ExXYCxGnYj9mWq3SMJ
 0CQieLGoJSkDaqbFsaalqU5Gw634oSyw86nYxaBRC7X813bS/+Jlf2PPHhgai3XW7alz
 stnTJjT2OrGROn9krTYMw3WDz01969k757Ih9GwB2Y4V+iT5dcn9FpdKUa1uz2P0rm7n
 JiJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf1Q5CBMqEW2YbILhymIixIZBAOZB6pITP5xJ8378tgR3Yv67LuiNcCT7xUzDRpKGruDjjmQ4rf8Bm@nongnu.org
X-Gm-Message-State: AOJu0YxFqlmMbhBfsfGyWaXsmtHmN+ICA8gTEXmPAXacgomJ1vEBbCuo
 DTY6kcULprzk6HZhDmlIZ0QN/y27ZZnr8eY+vfFjUx+4nIJ/anz/zA0JkRMjUg3Lx2fkGpN2RuH
 JRBU=
X-Google-Smtp-Source: AGHT+IEh4LLc/+bqY6X2nvxu4aasx8ocawMKkkbF/iDndQ0VGJj1wrdQKntd1Rko8JvCmZqGM+N92w==
X-Received: by 2002:a17:903:240e:b0:20b:a89a:1d3a with SMTP id
 d9443c01a7336-20ca14661b7mr46470025ad.28.1728648800931; 
 Fri, 11 Oct 2024 05:13:20 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.13.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:13:20 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 06/10] block/nvme: add reservation command protocol
 constants
Date: Fri, 11 Oct 2024 20:12:27 +0800
Message-Id: <20241011121231.18333-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62f.google.com
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



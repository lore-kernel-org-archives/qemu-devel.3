Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C9C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uGl-0002Hg-QG; Fri, 17 May 2024 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGk-0002Ge-87
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:54 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGi-0006Oo-Df
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:53 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so998045a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939571; x=1716544371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JplQ5qj67P49Y5AF8nSVl4ZNNoWAybsZ+YxZb8PorK4=;
 b=fiYzdU8OhwefuaUiHF2MUZeTG3PzKYcnoUQXBeHlouaTsZiAoru7Bq3ckWtJj/HXR7
 cpxy3V/HgVaOuIIx/Sy1E2om10JwQONOq574d/gA474AcCc0CFxweANkyjS8vkQQPzWa
 hAwvTPHBjrDs4u95+U9UkoYyFI5rm7Ts17BIoPrM4883Jnmrx/A9J6j8V0HVThc/eOlU
 4afr7y61mUJB/dKEM8DUwCJ1FoynbYcoSSmkTWPoTb1dhXkV12sKrLK5v7ROnx//xrR6
 aaJnCIaJY42eAmueWuEc05/umPlXWSxgGyrv4kACUeZpzR1OZvEMXry3uBkPQtGqT+ry
 lB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939571; x=1716544371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JplQ5qj67P49Y5AF8nSVl4ZNNoWAybsZ+YxZb8PorK4=;
 b=OE18ya2dPAOQ7gKdhmaMy6ui6O1uuj1rflnUxgYEszJTzu0khVwrhYCCpBR3X4y0eW
 I0a3q1YC8tYxa6gt1HO1iCafj5dZ/gGdkl0NMwyUaze6prEoNLTH9gPN9zCq8kBWsTXw
 CL2pe5NM+mdyUvc4bU0eZ8A0VDWxyyVkhbsTC330hkbTtHVqAMbLJELy4KAquFfvEvky
 2LOyKL7GYPA/rg8HZxdLp5tRBL7sQfNRbC23qVbn7FS9xTLfumXtUttD8ch+Ur4Wq3kN
 8j31qwlktyyg2A4OKaVeo3nwBs8Yw+iNageswU7TZY1LoTApg1Qyjfpp2WZKnrsHPFNy
 z8bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2sHAvf0T8nezpP9DyfNs9brJfG29KTTzhGwBo9Xfo3YNFlJjAaJqyQlezOOSSs1lJ6rPcD811ZMGEBliG4RjckkgzcI=
X-Gm-Message-State: AOJu0Yz6XeLflZvBboVSO1jE1QRM8cWczKZ9AL4bzVisdu3JUspHbAtR
 cUGPw1tpjEVpkAqlo1H137e1AJYBWEw2RR+c9GpawDbxlAs2qun+wGdNdeAX1tQ=
X-Google-Smtp-Source: AGHT+IGPh1DL18dU8gs93xM2EoYFB+wxruxudwE7bZX/b9wl2M/zF3y5FRECiEvRI3GNIv9IC+1r6A==
X-Received: by 2002:a17:90a:3dc7:b0:2b2:812d:f06d with SMTP id
 98e67ed59e1d1-2b6cb6c2a4cmr20821388a91.0.1715939571163; 
 Fri, 17 May 2024 02:52:51 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:50 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 06/11] block/nvme: add reservation command protocol
 constants
Date: Fri, 17 May 2024 17:52:13 +0800
Message-Id: <20240517095218.3107672-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
index bb231d0b9a..84e2b2e401 100644
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
+typedef enum {
+    NVME_RESV_PTPL_NO_CHANGE = 0x00,
+    NVME_RESV_PTPL_DISABLE   = 0x02,
+    NVME_RESV_PTPL_ENABLE    = 0x03,
+} NVMEResvPTPL;
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



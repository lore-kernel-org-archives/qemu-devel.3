Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE10C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBq5W-0002op-4u; Tue, 28 May 2024 02:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBq5T-0002m8-Uy; Tue, 28 May 2024 02:13:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBq5R-00043A-Qx; Tue, 28 May 2024 02:13:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so3406435ad.0; 
 Mon, 27 May 2024 23:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716876808; x=1717481608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI3aQe+3NCl7TYdk0QhMrQ77IoRzmkb0sJWAqE2N5M8=;
 b=JIz8biBE3DiVKVEZgukGMDJm23XHjPgKXEzdOjyciE2VpzzGrqqbfN5OiaGz74hjUZ
 YK9KwwG+CoQmTX99yB7yBpcgNBW5l0sT05XYHj5rRJtQTeoUMewhvrq0saqjrP4x7KCR
 /BwWBGuwfnm/Endk1deMRMSb6BMSsNIw8fMZzWv21C6ETqn8r5dAlgUxVShWNzF1keCf
 jaSQiiu6YZrAwBY8UAeD5WoPc/vmdw5YUNKgR8xnT/MQnyY+U+JO621yT2iwp6D1IIs0
 keLDHJ4v+4xEsvGMsIABxCfCv0ApBOd6NLQTXxtNIGdZ2K5Nc11kzIbW4Pcz08Rnm5i/
 JutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716876808; x=1717481608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZI3aQe+3NCl7TYdk0QhMrQ77IoRzmkb0sJWAqE2N5M8=;
 b=fyjlsDQLWefkag7LspP2iNYz/w8dDSiSsm8Q9gl77LysPT3vCfBzCMaLHn1PIsVn/O
 tmLGYw3lqxF6O7FHgx6SCNwLe48Vgr+oQss/MVov8bDNZIypZoQjkKI7RyHQC0PD022I
 pRN5aam4aDASCk7Eat8+f3nEtfWlAKsuf0OBUoD9HMxXI+06bXlM26HaO1rOA1yh6Xrc
 nOMF8Tz6ftDwasI4BKYD3h0ui5ZX4qfo1FTQSC/Ep+65ztAUdwyuR938cvFTC/XHibx/
 yd+DqGHFsdYp6kcrmegenEDQrUNnrRsxY9vCJ1wp1FjJI3NDvr1G6xseJyaCmUi8DmO/
 VhjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyyCQti6FM/0KBudQ5zj/KmuiZqxrJbmNCg7VRmluEgMvOvAkIv402e6S4YlswebNHYA3h7vaPWhus+qFzF6a/+UKTA9w=
X-Gm-Message-State: AOJu0YyI1UVaQGvaw8B8oDANiyAxX4rm8e8TFXgex28iK++i980yao4b
 h7xRX2P8jzaSg1sWRWT2FIusStmrufc2tob9LUjP/kzi8trGFcVmzvMNvA==
X-Google-Smtp-Source: AGHT+IEXxXrLWkQBouZoVp3Z6Y+wTi+yvwfKGZd8z83J4IA7kP3tDAwSm/uJoT75zBSm0BBEDsp64w==
X-Received: by 2002:a17:902:d50c:b0:1f4:bb5c:b7bd with SMTP id
 d9443c01a7336-1f4bb5cb9c1mr27123365ad.61.1716876807533; 
 Mon, 27 May 2024 23:13:27 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9c2a65sm71780415ad.272.2024.05.27.23.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:13:27 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
Subject: [PULL 1/2] hw/ufs: Update MCQ-related fields to block/ufs.h
Date: Tue, 28 May 2024 15:12:31 +0900
Message-Id: <694ab9e84f20974fd764e672f2689afe93508772.1716876237.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716876237.git.jeuk20.kim@samsung.com>
References: <cover.1716876237.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Minwoo Im <minwoo.im@samsung.com>

This patch is a prep patch for the following MCQ support patch for
hw/ufs.  This patch updated minimal mandatory fields to support MCQ
based on UFSHCI 4.0.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-Id: <20240528023106.856777-2-minwoo.im@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 include/block/ufs.h | 108 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index d61598b8f3..3513b6e772 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -7,7 +7,7 @@
 
 typedef struct QEMU_PACKED UfsReg {
     uint32_t cap;
-    uint32_t rsvd0;
+    uint32_t mcqcap;
     uint32_t ver;
     uint32_t rsvd1;
     uint32_t hcpid;
@@ -46,6 +46,13 @@ typedef struct QEMU_PACKED UfsReg {
     uint32_t rsvd7[4];
     uint32_t rsvd8[16];
     uint32_t ccap;
+    uint32_t rsvd9[127];
+    uint32_t config;
+    uint32_t rsvd10[3];
+    uint32_t rsvd11[28];
+    uint32_t mcqconfig;
+    uint32_t esilba;
+    uint32_t esiuba;
 } UfsReg;
 
 REG32(CAP, offsetof(UfsReg, cap))
@@ -57,6 +64,15 @@ REG32(CAP, offsetof(UfsReg, cap))
     FIELD(CAP, OODDS, 25, 1)
     FIELD(CAP, UICDMETMS, 26, 1)
     FIELD(CAP, CS, 28, 1)
+    FIELD(CAP, LSDBS, 29, 1)
+    FIELD(CAP, MCQS, 30, 1)
+REG32(MCQCAP, offsetof(UfsReg, mcqcap))
+    FIELD(MCQCAP, MAXQ, 0, 8)
+    FIELD(MCQCAP, SP, 8, 1)
+    FIELD(MCQCAP, RRP, 9, 1)
+    FIELD(MCQCAP, EIS, 10, 1)
+    FIELD(MCQCAP, QCFGPTR, 16, 8)
+    FIELD(MCQCAP, MIAG, 24, 8)
 REG32(VER, offsetof(UfsReg, ver))
 REG32(HCPID, offsetof(UfsReg, hcpid))
 REG32(HCMID, offsetof(UfsReg, hcmid))
@@ -78,6 +94,7 @@ REG32(IS, offsetof(UfsReg, is))
     FIELD(IS, HCFES, 16, 1)
     FIELD(IS, SBFES, 17, 1)
     FIELD(IS, CEFES, 18, 1)
+    FIELD(IS, CQES, 20, 1)
 REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, UTRCE, 0, 1)
     FIELD(IE, UDEPRIE, 1, 1)
@@ -95,6 +112,7 @@ REG32(IE, offsetof(UfsReg, ie))
     FIELD(IE, HCFEE, 16, 1)
     FIELD(IE, SBFEE, 17, 1)
     FIELD(IE, CEFEE, 18, 1)
+    FIELD(IE, CQEE, 20, 1)
 REG32(HCS, offsetof(UfsReg, hcs))
     FIELD(HCS, DP, 0, 1)
     FIELD(HCS, UTRLRDY, 1, 1)
@@ -128,6 +146,10 @@ REG32(UCMDARG1, offsetof(UfsReg, ucmdarg1))
 REG32(UCMDARG2, offsetof(UfsReg, ucmdarg2))
 REG32(UCMDARG3, offsetof(UfsReg, ucmdarg3))
 REG32(CCAP, offsetof(UfsReg, ccap))
+REG32(CONFIG, offsetof(UfsReg, config))
+    FIELD(CONFIG, QT, 0, 1)
+REG32(MCQCONFIG, offsetof(UfsReg, mcqconfig))
+    FIELD(MCQCONFIG, MAC, 8, 8)
 
 #define UFS_INTR_MASK                                    \
     ((1 << R_IS_CEFES_SHIFT) | (1 << R_IS_SBFES_SHIFT) | \
@@ -157,6 +179,69 @@ REG32(CCAP, offsetof(UfsReg, ccap))
     ((be32_to_cpu(dword2) >> UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_SHIFT) & \
      UFS_UPIU_HEADER_DATA_SEGMENT_LENGTH_MASK)
 
+typedef struct QEMU_PACKED UfsMcqReg {
+    uint32_t sqattr;
+    uint32_t sqlba;
+    uint32_t squba;
+    uint32_t sqdao;
+    uint32_t sqisao;
+    uint32_t sqcfg;
+    uint32_t rsvd0[2];
+    uint32_t cqattr;
+    uint32_t cqlba;
+    uint32_t cquba;
+    uint32_t cqdao;
+    uint32_t cqisao;
+    uint32_t cqcfg;
+    uint32_t rsvd1[2];
+} UfsMcqReg;
+
+REG32(SQATTR, offsetof(UfsMcqReg, sqattr))
+    FIELD(SQATTR, SIZE, 0, 16)
+    FIELD(SQATTR, CQID, 16, 8)
+    FIELD(SQATTR, SQPL, 28, 3)
+    FIELD(SQATTR, SQEN, 31, 1)
+REG32(SQLBA, offsetof(UfsMcqReg, sqlba))
+REG32(SQUBA, offsetof(UfsMcqReg, squba))
+REG32(SQDAO, offsetof(UfsMcqReg, sqdao))
+REG32(SQISAO, offsetof(UfsMcqReg, sqisao))
+REG32(SQCFG, offsetof(UfsMcqReg, sqcfg))
+REG32(CQATTR, offsetof(UfsMcqReg, cqattr))
+    FIELD(CQATTR, SIZE, 0, 16)
+    FIELD(CQATTR, CQEN, 31, 1)
+REG32(CQLBA, offsetof(UfsMcqReg, cqlba))
+REG32(CQUBA, offsetof(UfsMcqReg, cquba))
+REG32(CQDAO, offsetof(UfsMcqReg, cqdao))
+REG32(CQISAO, offsetof(UfsMcqReg, cqisao))
+REG32(CQCFG, offsetof(UfsMcqReg, cqcfg))
+
+typedef struct QEMU_PACKED UfsMcqSqReg {
+    uint32_t hp;
+    uint32_t tp;
+    uint32_t rtc;
+    uint32_t cti;
+    uint32_t rts;
+} UfsMcqSqReg;
+
+typedef struct QEMU_PACKED UfsMcqCqReg {
+    uint32_t hp;
+    uint32_t tp;
+} UfsMcqCqReg;
+
+typedef struct QEMU_PACKED UfsMcqSqIntReg {
+    uint32_t is;
+    uint32_t ie;
+} UfsMcqSqIntReg;
+
+typedef struct QEMU_PACKED UfsMcqCqIntReg {
+    uint32_t is;
+    uint32_t ie;
+    uint32_t iacr;
+} UfsMcqCqIntReg;
+
+REG32(CQIS, offsetof(UfsMcqCqIntReg, is))
+    FIELD(CQIS, TEPS, 0, 1)
+
 typedef struct QEMU_PACKED DeviceDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1064,9 +1149,26 @@ typedef struct QEMU_PACKED UtpUpiuRsp {
     };
 } UtpUpiuRsp;
 
+/*
+ * MCQ Completion Queue Entry
+ */
+typedef UtpTransferReqDesc UfsSqEntry;
+typedef struct QEMU_PACKED UfsCqEntry {
+    uint64_t utp_addr;
+    uint16_t resp_len;
+    uint16_t resp_off;
+    uint16_t prdt_len;
+    uint16_t prdt_off;
+    uint8_t status;
+    uint8_t error;
+    uint16_t rsvd1;
+    uint32_t rsvd2[3];
+} UfsCqEntry;
+
 static inline void _ufs_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x104);
+    QEMU_BUILD_BUG_ON(sizeof(UfsReg) != 0x38C);
+    QEMU_BUILD_BUG_ON(sizeof(UfsMcqReg) != 64);
     QEMU_BUILD_BUG_ON(sizeof(DeviceDescriptor) != 89);
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 87);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
@@ -1086,5 +1188,7 @@ static inline void _ufs_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(UtpTaskReqDesc) != 80);
     QEMU_BUILD_BUG_ON(sizeof(UtpCmdRsp) != 40);
     QEMU_BUILD_BUG_ON(sizeof(UtpUpiuRsp) != 288);
+    QEMU_BUILD_BUG_ON(sizeof(UfsSqEntry) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(UfsCqEntry) != 32);
 }
 #endif
-- 
2.34.1



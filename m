Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37233C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5u-0005Ek-Iw; Wed, 08 May 2024 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkq-0007ah-8T
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dki-0000Y6-11
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ec4b2400b6so35623515ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161099; x=1715765899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhrpNoHqPwXJhHSVuGspRrhBd9WnIeflRDPD7nuJ1Zo=;
 b=exp6Dl0IDz2RWJEePf1/KcH4nKmJLDLtStACvtU8rQdsI2zAil1WRapLCIsmGDmweo
 FiypOIf7oX5gnsHMefaqfx6zFL6tIugh60c2JPATazJGKJA0i53ke43ZaTbjHz3m/Fn/
 oPXwyiKCUg8xFaeKHBzhpKCVTf0/WS925xoZK3W6Zrf5vvRe4jLopBzY0accBXCrPbQB
 /pxdgu1oshEERHfS1oNnwlfUJhy/8stnuagdOzTV6AC2+PK9L/PrH07c99iWi+k3OIiy
 +az3rJunWKyPKDOXYy2NtfUMNeR48jRGKm1lGrHjK+iM2yEWn7iDAOT7cAo10XF1pi09
 ppKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161099; x=1715765899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhrpNoHqPwXJhHSVuGspRrhBd9WnIeflRDPD7nuJ1Zo=;
 b=Q41GC+e+LXSkhw9LSVknliIdyBWlJXYusKvOQLbBNGLzLx+NK9tlDpVonekNbB0ec+
 fI/xKqn9EG7bfMFr9R7dLSd8huJfrGqL+p7V9JiWsRvm8mqhDW7JTv0LRkqmcy2/jy19
 oFwz92/r9Ou2mVUcGnbF35pzZ2zlahSx74J4Q4U6VUns/Srmoa8ia/2ny6i7qwHiJuqZ
 coH0TDUYu1ENwe3IFTlOX1xWSiQlxMELcuIC0a5S/x9EaUq0P7jXP/8wjNIClB/OAcPL
 90Y12HxWBGDylxOqZQSDaH2iepknlKjPujoO6RDsAGd2jb1S9YByEUGgmklX6QHrgbBE
 V55Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXa7GBkhZ09xyBkpraFcr44qq3t2SRHDvEVRTQs4M0rEQ6j5XVyd8ZxO2OdXr7LDNCFAbj/AF13qK4q7vHaQ9hXxdok+0=
X-Gm-Message-State: AOJu0YwsuHOmjZRuCXlzhRMGoXJoetcicqG3QXzZXdAyXYGrIrfkA2Tt
 1ZaSVsbk7DSFSvLxEUmnXFBA8Cg9gks49Dv6xT+SUnk3Lkdw2Xi0A1pNU3nh8dJQfQglrYUI/R+
 X2MhPPA==
X-Google-Smtp-Source: AGHT+IHuv82rlHUqmBIPjbAKlsSpJcJLczPqPyT0rZphivePCLpG7UW77iGG4TP6LmFX8wyD3F/71w==
X-Received: by 2002:a17:902:988c:b0:1e2:6bcd:e64e with SMTP id
 d9443c01a7336-1eeb059326emr18545125ad.16.1715161098788; 
 Wed, 08 May 2024 02:38:18 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:18 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/9] scsi/constant: add persistent reservation in/out protocol
 constants
Date: Wed,  8 May 2024 17:36:23 +0800
Message-Id: <20240508093629.441057-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add constants for the persistent reservation in/out protocol
in the scsi/constant module. The constants include the persistent
reservation command, type, and scope values defined in sections
6.13 and 6.14 of the SCSI Primary Commands-4 (SPC-4) specification.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/scsi/constants.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 9b98451912..511cb3d03e 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -319,4 +319,33 @@
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
+} SCSIPrInAction;
+
 #endif
-- 
2.20.1



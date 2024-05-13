Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD7CC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkL-0001FV-QM; Sun, 12 May 2024 23:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkJ-0001FC-HZ
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:03 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkA-0008Jh-EB
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:03 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c99c66a40fso1418700b6e.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572372; x=1716177172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=eNfONu7fKCeN2EGr/xjudF71uSSVf+Ddfkte9eyo2KBsdoReieqBgEy+YQi1ncgsy+
 TJNFsJb70MpYQ872v1Q6AtWhcgC2I81tC3uXcY5Cj/iYJLr9cw8XSvOsLleCehSHmEUp
 Q+0+BpO2rTGJfOzq4XKhy0MS9UhMtNwykKhWgrcED28gGct8unsNga3G7/JnN8QdUZOc
 O4xL6Kt20PsWogwTuqFIf9QJD7BipkHiVPwcL8E+NLx+xdKyMVo2lI7OvBkPtuQVdwAQ
 phO2hF0Fj/bJ3SRiQtPz7wi0T5i0zITJjvUdPP1AokIbjvUDi9y8QzxviaT1zXWw86hg
 FNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572372; x=1716177172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBe1c4jIkfsliWme3g4HTOmn9856JIh7QYN+Y7HLgGY=;
 b=XvW/2Zd3Iw+LL/cp6Mc7EX3GbHkaUc9wg+/G+ucIJezS4GhZ5a2NGj3AqVgphlaxzM
 Hjd3cce1ThkbSQqzHQNGm+Kcmu3F2Ek3APtkbTaQX54pryRo9TBKTrCD+LTd14x3ewEs
 zCtlTyjza8FdY0J0RPhBl7l8gmnB4yuQypK2woT5rmWvVQGpcQnUsLM/Us3Bkk+TP2Dn
 9pz/oPZglAV6mFy8rJgv7ra/pw4EyEBbkHloUl2YW3S/E/pHQkZdHfz8JRg+fPb7H9wn
 FWRcJtUbPwZrZRmAZxfXQyxY6YmC2njMzsgeF6c08PRoyEkK65tE9473Jog773KkKCpk
 kouw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFbsLIXY7F1ziJwMWX3HoGp+yyZpEmJfAxXSVUJtFBv2e2Eg7u0nZTGKSj17RlbNVGGJkx3IV+KvR6rtdtBjfNQIkSAS8=
X-Gm-Message-State: AOJu0YxmsRUOMMRus0y0JsGHj9uJQBb0CqFKWK44Kvb+eNfqoZRiFMBb
 2d2aefcjJ3nacD4dDgIxptJgYRWv4AoHmRmPBzN6reEnHILHsw6Pkxy3zcM6Mjc=
X-Google-Smtp-Source: AGHT+IGIz0EZtF137y721+nz+6WDLEFc/KY0dUNiw34s+KMY2jfqD+ZYGXnBQVBY6nsI6rkXobFLZw==
X-Received: by 2002:a05:6808:a92:b0:3c9:95e1:fa7b with SMTP id
 5614622812f47-3c9970cdcf9mr8879430b6e.46.1715572372516; 
 Sun, 12 May 2024 20:52:52 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:52:52 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 03/11] scsi/constant: add persistent reservation in/out
 protocol constants
Date: Mon, 13 May 2024 11:52:22 +0800
Message-Id: <20240513035230.60162-4-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-oi1-x22b.google.com
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



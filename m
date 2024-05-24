Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290AC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOSx-0005wr-7f; Fri, 24 May 2024 02:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSi-0005vJ-GD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSc-0004M4-Rb
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so3707138b3a.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716532164; x=1717136964;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGVLNMBHkQ5+D6nW02UCHZNEO8isGdb4ZADdHG9gnvI=;
 b=N4oeiA3mq6gCM2eVOYZKi57hUD9eSwjCTnLB1UKRRDZ9RNDMcFDbxff9NBtAFQ3me1
 Z6MQuJBHmR/ZzDdk2w12sIBKwQaZhmSInfEqJupFKUdHUbDcdmqNfZPonKlxEwK20Q8w
 p+/xiKhdYvQEukhF0IpdqgwjUb4zNbGv1MoJ8IZenqwpyjz+L11aPXKk4UX3ibFDd3w9
 fyJP9yqxpnzPoW4Hn/JinOhTibxdguhncRc+bpCwHo9bB+tf71O0Uq1hdXaWEYO+v2f3
 Gmk1rMiirmURU+BVgSlFaBqMgk7Nez13Jd0M9sN4XwG0/I11cDOFwE0slfkGm3T4jMf4
 D/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716532164; x=1717136964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGVLNMBHkQ5+D6nW02UCHZNEO8isGdb4ZADdHG9gnvI=;
 b=EG1nmOEXUx3+05dJ7QBYbuPUsdj6kz86Qyz9ezUZTTFN3Dm3b3GSRd9il/kQUAqzhE
 70d8lQENiMe0S3CucS4DUu/cRf4QAOVIwZ54YQPZuO/8DeuPb9Rl3tKsCPXw7uhjDvlh
 hZ9xtxPbFTLPFbz3To2LDa6S8y5MVxUNXuL7YjFT1Mf7ES5CgNz7JnMB+J917hJazW/e
 ZuyayQqb2yejUuZGHDnn9COWSVKDnPRx3+wsopPknoIatqScrwPUz0fALFwhTCywMz4D
 z6sBm8heqwZgINWWlayGBb2EdjZH9JBOIM+BXIwWVeMOl+rTWFmD1sI5QRyswA8Fq3vo
 V3tQ==
X-Gm-Message-State: AOJu0YxUn2Zxdsm7dmyc2HNOwJs+V+lThlD4pCk7HVmd1R7zFYvk3ZF3
 N930c1hlvGR/cRYSjYSMmmZZAq8XbIW+qLJojIORgQ1LLzwXJj1kdjR+eKnyMGoa0yX07qAaNy2
 7ec3Q+g==
X-Google-Smtp-Source: AGHT+IG9wMaEvAwO+9PARBCQYNcTodtuVFfMS4y1s1Pcv3B0v1lcK6jpeBO4TTBKfnF0Qt6Mq1kPlQ==
X-Received: by 2002:a05:6a20:72a6:b0:1af:f64c:b795 with SMTP id
 adf61e73a8af0-1b212d398c4mr1934564637.30.1716532163326; 
 Thu, 23 May 2024 23:29:23 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682274bbbe8sm497918a12.93.2024.05.23.23.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:29:22 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH 1/2] scsi-disk: Introduce the migrate_emulate_scsi_request
 field
Date: Fri, 24 May 2024 14:29:15 +0800
Message-Id: <ef0bb84397f261f6fc64045c27287e84f6d70fb2.1716531409.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716531409.git.yong.huang@smartx.com>
References: <cover.1716531409.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

To indicate to the destination whether or not emulational SCSI
requests are sent, introduce the migrate_emulate_scsi_request
in struct SCSIDiskState. It seeks to achieve migration backend
compatibility.

This commit sets the stage for the next one, which addresses
the crash of a VM configured with a CDROM during live migration.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <2da3a08785453478079cfd46d8293ee68d284391.1712577715.git.yong.huang@smartx.com>
---
 hw/scsi/scsi-disk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..0985676f73 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -111,6 +111,7 @@ struct SCSIDiskState {
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
+    bool migrate_emulate_scsi_request;
 };
 
 static void scsi_free_request(SCSIRequest *req)
@@ -3133,11 +3134,21 @@ static Property scsi_hd_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static int scsi_disk_pre_save(void *opaque)
+{
+    SCSIDiskState *dev = opaque;
+    dev->migrate_emulate_scsi_request = false;
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_scsi_disk_state = {
     .name = "scsi-disk",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .pre_save = scsi_disk_pre_save,
     .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(migrate_emulate_scsi_request, SCSIDiskState, 2),
         VMSTATE_SCSI_DEVICE(qdev, SCSIDiskState),
         VMSTATE_BOOL(media_changed, SCSIDiskState),
         VMSTATE_BOOL(media_event, SCSIDiskState),
-- 
2.39.3



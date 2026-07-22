Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F362C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWSl-0005Kt-0P; Wed, 22 Jul 2026 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRT-0002jA-KF; Wed, 22 Jul 2026 08:53:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRS-0002W9-1X; Wed, 22 Jul 2026 08:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=hegvjN5u07X0tI6Sh+JSFjFf+1iP+8GgZkKx6m2isBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W23OvSuOKcPS47Y+aEZjP8uEHdfwSKIC9WtLDKJVi0+4HflUV7OBEjgMf7WVdBUf1
 s0Ng0Eese+nHcgad1j9DIZk88FPCXmdXci9PXRQHGb9nsukNK2MI/0KLa5dfAHupmW
 K4rMFSZkTNta5KqUh2GlTwEyY69sd4EKKnfQUD5RuXf7l32tEJinQ4sYMQq1RSxIgc
 aVgn+fBKCpYZ680rfbn9SxfLAcHZD0+sfc0E40HZuU9qwq0Ydg2I/8O/LBOgJtD8S7
 zWpYQmo0x/ivBh5TM1+0nqytAJTE/2UMmJbPQts5jQmurpGiqughRJuiHTQP53bM6n
 N0i6B9pXGAzmA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA3131C3B40;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2E3FE3F3790;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BC9AB17F55; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Miao Wang <shankerwangmiao@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 099/127] hw/scsi/vmw_pvscsi: add a comment to
 explain the endianness
Date: Wed, 22 Jul 2026 15:48:24 +0300
Message-ID: <20260722124859.32371-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

Add a comment to explain the endianness of the pvscsi device. We have
no information about the endianness should be little-endian or CPU
native endian because the current driver code is designed to work only
on x86 and is not endianness aware. We assume that the pvscsi device is
implicitly little-endian.

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710-pvscsi-endianness-v3-2-27fe1c4d1f6e@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit ecc569639aeb5b702f1098d3eb5b28d3168604c8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/vmw_pvscsi.h b/hw/scsi/vmw_pvscsi.h
index a3ae517e199..defff9e179e 100644
--- a/hw/scsi/vmw_pvscsi.h
+++ b/hw/scsi/vmw_pvscsi.h
@@ -108,6 +108,20 @@ enum PVSCSICommands {
 #define PVSCSI_COMMAND_PROCESSING_FAILED     (-1)
 #define PVSCSI_COMMAND_NOT_ENOUGH_DATA       (-2)
 
+/*
+ * About endianess for the below structs:
+ *
+ * These structs are used to describe the data that is exchanged between the
+ * guest and the PVSCSI device. The endianess of the fields in these structs
+ * is not defined by any standard. The current implemented drivers are designed
+ * to only work on x86 architecture, so there is no endianess awareness in the
+ * drivers and thus we have no idea whether the fields should be in little-
+ * endian or target native endian format.
+ *
+ * Considering the above, we assume that PVSCSI is implicitly little-endian and
+ * expect the fields in these structs to be in little-endian format.
+ */
+
 /*
  * Command descriptor for PVSCSI_CMD_RESET_DEVICE --
  */
-- 
2.47.3



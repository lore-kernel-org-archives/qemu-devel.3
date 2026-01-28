Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB690D35697
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl2kb-0003VI-Hl; Wed, 28 Jan 2026 05:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vl2kU-0003RY-5S; Wed, 28 Jan 2026 05:26:11 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vl2kO-0007gq-J5; Wed, 28 Jan 2026 05:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fOvoeItDOQvM/8NhsfwPwdakSAmQSq02eKgbrwaZfD0=; b=FyThLBdzScwKa2yMp5N0mRLqed
 OTDq5y6pB1FQj15zrh7STi+Mc9T2Lf/y73Z/rc4pz2IENI6Sz41vl/SZnSINnkq4XHN1gjPHDLkqV
 3mqdNaemZzaNgOc7/toyB0E0WIrdlW9f8VdN6yiu89WEs8FWM1dgPeMOHhkRNyGeKfJa/wm518XsS
 OOv71rIdvmV8Ef2PEQuVyZzDgxcvOdcCd1wr3PHfPS2s2S9rqY1p8mcTL+kmB1CYctvUAd6MGFNYe
 EEFxsf9oQXEj2M/oAOEkoGuGA/Z6qfH0NDac8aFxsBAqwvRPLM6yHXK9cbPEXneDn7znjZOQUQALo
 a/tBcqMQ==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vl2kF-00Api2-Og; Wed, 28 Jan 2026 11:25:55 +0100
Received: from berto by zeus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1vl2kF-00000000wL2-2bdu;
 Wed, 28 Jan 2026 11:25:55 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/ide, scsi-disk: Fix typo on the rotation_rate documentation
Date: Wed, 28 Jan 2026 11:25:46 +0100
Message-ID: <20260128102548.224237-1-berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Correct values according to the Medium Rotation Rate field from the
Block Device Characteristics VPD page (B1h) of the SCSI specification.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c      | 2 +-
 include/hw/ide/ide-dev.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0f896c27f4..db7d04119e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -117,7 +117,7 @@ struct SCSIDiskState {
      * 0x0000        - rotation rate not reported
      * 0x0001        - non-rotating medium (SSD)
      * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
+     * 0x0401-0xfffe - rotations per minute
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 617e8159c7..f5eaaf68e6 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -160,7 +160,7 @@ struct IDEDevice {
      * 0x0000        - rotation rate not reported
      * 0x0001        - non-rotating medium (SSD)
      * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
+     * 0x0401-0xfffe - rotations per minute
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C280C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 06:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJnib-0006iA-Sn; Tue, 27 May 2025 02:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dancer@debian.org>) id 1uJniR-0006hw-IF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:23:12 -0400
Received: from mx2.netfort.gr.jp ([2401:2500:102:3002:153:126:132:118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dancer@debian.org>) id 1uJniP-0005Jz-4R
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:23:11 -0400
Received: from localhost.localdomain (localhost [IPv6:::1])
 by mx2.netfort.gr.jp (Postfix) with ESMTP id B46205FACE;
 Tue, 27 May 2025 15:23:00 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; s=selector1;
 t=1748326980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGMDmbtQ8UaCk9EvT941LLKKCCXUMjMOrCLiTn0R4R4=;
 b=mFUfyBrlNTJYk9h3V4QaqbIbD7IzbNGMDTfqto90C5pAaMkBGG8NQ0aUGI7SrxV/r/xOqm
 Ug1skgAWlbS8zYcjvWUQstHaYVLm9fQ/sLZurwfyDYsogHhuEXfo4oieE2V5dOPwUROfXv
 Bq6BKNWi+S9uzGoaeVPuRDsWeOMxzbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
 s=selector1; t=1748326980;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGMDmbtQ8UaCk9EvT941LLKKCCXUMjMOrCLiTn0R4R4=;
 b=M7qXdmnyWEvmeexh8I7ySZu9vqr4UkO8BIbrY+j6vig5jM06qfJyk77DS9RacKQLrsDM/c
 KeJ/hVozQM25rW0GsNGmZu0kOj8IbGMKJRA8rK40C2lKuCIda7PX7gorA7ASbotZlHWYg1
 OucYilvUGkxEiVA/PZjWy06fnH4QImE=
ARC-Authentication-Results: i=1;
	mx2.netfort.gr.jp;
	none
ARC-Seal: i=1; s=selector1; d=debian.org; t=1748326980; a=rsa-sha256; cv=none;
 b=YUi1nPkzrWD+LjXyEDLgaYPL+YrG98/n23tPt63I5hWd2ZBryMtYc7yXE5pRpTt63epAZU
 sPmzE6LNdwIt5RDu7BUowH9Py7i3KjBr3YXTMQpaCPRhvAvOEJtcfC52OimZcY8tqMXyKg
 Hq1f76R0taTNtX6Ve2V5TMTzz4NzVHs=
From: dancer@debian.org
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, adelva@google.com, uekawa@chromium.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Junichi Uekawa <dancer@debian.org>
Subject: [PATCH] Fix comment for virtio-9p
Date: Tue, 27 May 2025 15:22:20 +0900
Message-Id: <20250527062220.842342-1-dancer@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527041123.840063-1-dancer@debian.org>
References: <20250527041123.840063-1-dancer@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2401:2500:102:3002:153:126:132:118;
 envelope-from=dancer@debian.org; helo=mx2.netfort.gr.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Junichi Uekawa <dancer@debian.org>

virtio-9p is not a console protocol, it's a file sharing protocol. Seems
like an artifact of old copy-and-paste error.

Fixes: 3ca4f5ca7305 ("virtio: add virtio IDs file")
Signed-off-by: Junichi Uekawa <dancer@debian.org>
---
 include/uapi/linux/virtio_ids.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..747e93a91920 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -37,7 +37,7 @@
 #define VIRTIO_ID_IOMEM			6 /* virtio ioMemory */
 #define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
 #define VIRTIO_ID_SCSI			8 /* virtio scsi */
-#define VIRTIO_ID_9P			9 /* 9p virtio console */
+#define VIRTIO_ID_9P			9 /* virtio 9p file sharing protocol */
 #define VIRTIO_ID_MAC80211_WLAN		10 /* virtio WLAN MAC */
 #define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
 #define VIRTIO_ID_CAIF			12 /* Virtio caif */
@@ -79,6 +79,6 @@
 #define VIRTIO_TRANS_ID_CONSOLE		0x1003 /* transitional virtio console */
 #define VIRTIO_TRANS_ID_SCSI		0x1004 /* transitional virtio SCSI */
 #define VIRTIO_TRANS_ID_RNG		0x1005 /* transitional virtio rng */
-#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p console */
+#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p file sharing protocol */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.39.5



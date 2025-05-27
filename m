Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE05C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJm9l-0005n9-R6; Tue, 27 May 2025 00:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dancer@debian.org>) id 1uJlf5-0007mo-E1
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:11:35 -0400
Received: from mx2.netfort.gr.jp ([153.126.132.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dancer@debian.org>) id 1uJlf3-0005Fu-LS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:11:35 -0400
Received: from localhost.localdomain (localhost [IPv6:::1])
 by mx2.netfort.gr.jp (Postfix) with ESMTP id 3FD1B5FACE;
 Tue, 27 May 2025 13:11:25 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; s=selector1;
 t=1748319085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3v7be1f/CX26xwm33bkMhE4PM2rqH6kLl8sWw3wQMng=;
 b=yYnS8vmNPhh6e4ObGS8nOaNmgubtvDv3hyYS9NbQFe1oAfmImln9146Buas7qEAdwd7o8W
 IdeJIfkc0GzML5Gv9o09wdkAfUrOPsnFhxnbhS7jnkXzO99rSmz+LxfepsC6E4ipxG8Qp1
 BVN+sOZ6maEiDjo/SlY1/IdaImYeS8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
 s=selector1; t=1748319085;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:references; bh=3v7be1f/CX26xwm33bkMhE4PM2rqH6kLl8sWw3wQMng=;
 b=JYClznlIQ7csvSvFJ3NaFAADvvywCvtVBgCMb1GnITrwb21qkWlquWot/baXhE2EhV5FHp
 7jJa4zYZ/gdlmERx0G9pqeozJgK+hlovRrj3DfZia6Ei/xuMpecryCMjRIRbeVXF0Noyl7
 Gm937LIte9S3JTHLxS8IVhU5VjHr+G8=
ARC-Authentication-Results: i=1;
	mx2.netfort.gr.jp;
	none
ARC-Seal: i=1; s=selector1; d=debian.org; t=1748319085; a=rsa-sha256; cv=none;
 b=jT2pSYX+oNqT0xrqXfCfTd5QfZoLdU0lTXT+TL5Y3Yb0GN6gukNJWHZ4H0+aq5fEighz06
 2q4qvxU/ZPafxak8Azrc5wWVyeTUGm3pR4nNowQjXgg8jeSpk1yauWpAni11sIdcVcG4tU
 A0XC/amUvDK3L+K/lw8XtaPEZ6Gzi9I=
From: dancer@debian.org
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, adelva@google.com, uekawa@chromium.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org
Subject: [PATCH] Fix comment for virtio-9p
Date: Tue, 27 May 2025 13:11:23 +0900
Message-Id: <20250527041123.840063-1-dancer@debian.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=153.126.132.118; envelope-from=dancer@debian.org;
 helo=mx2.netfort.gr.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 May 2025 00:43:16 -0400
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

From: Junichi Uekawa <uekawa@chromium.org>

virtio-9p is not a console protocol, it's a file sharing protocol. Seems
like an artifact of old copy-and-paste error.

Fixes: 3ca4f5ca7305 ("virtio: add virtio IDs file")
Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
---
 include/uapi/linux/virtio_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..deb9dfa52944 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -37,7 +37,7 @@
 #define VIRTIO_ID_IOMEM			6 /* virtio ioMemory */
 #define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
 #define VIRTIO_ID_SCSI			8 /* virtio scsi */
-#define VIRTIO_ID_9P			9 /* 9p virtio console */
+#define VIRTIO_ID_9P			9 /* virtio 9p */
 #define VIRTIO_ID_MAC80211_WLAN		10 /* virtio WLAN MAC */
 #define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
 #define VIRTIO_ID_CAIF			12 /* Virtio caif */
-- 
2.49.0.1164.gab81da1b16-goog



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C1AC44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJJg-0007R9-7W; Mon, 13 Jul 2026 12:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjJIv-00076i-Id
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wjJIo-0007Pq-5g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783959261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTOMK3fcmMCkp4dhDMZgh5tSVKGqnbXYTq2/OhZjHXc=;
 b=N0UlcAv/MFseH0ujww6IjATbJ/0hNkOgRQj5GzjKsp62K7dP+GvTnPXCCvWR0rNpB9mrFd
 xa5jEAts+hHnyOWk7nlJrZAWhIBQKRTWXj2Sk6sjwbgw/ODSlaKqGotOmdp3Oa6j9BNBLl
 Ef/RvawanPrfI51tajp8UjeWngYx6EY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-w8V0s9PHNxSxcLdb2Zl3Pw-1; Mon,
 13 Jul 2026 12:14:19 -0400
X-MC-Unique: w8V0s9PHNxSxcLdb2Zl3Pw-1
X-Mimecast-MFC-AGG-ID: w8V0s9PHNxSxcLdb2Zl3Pw_1783959258
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951061955D50; Mon, 13 Jul 2026 16:14:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.15])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E372F765; Mon, 13 Jul 2026 16:14:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 2/3] hw/usb/hcd-xhci: Remove the FIXME macro
Date: Mon, 13 Jul 2026 18:14:05 +0200
Message-ID: <20260713161406.361197-3-thuth@redhat.com>
In-Reply-To: <20260713161406.361197-1-thuth@redhat.com>
References: <20260713161406.361197-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The FIXME macro is only used in one case, which should hopefully
never trigger: The containing function handles all the USB_RET_*
values except for USB_RET_ADD_TO_QUEUE and USB_RET_REMOVE_FROM_QUEUE,
which are both internal return values for when an async packet needs
to be queued or dequeued, and which shouldn't still be the status by
the time we get to this function. Thus let's simplify this spot
and use a g_assert_not_reached() instead (and remove the DPRINT()
in front of it to avoid that code analyzers trip over unreachable
code here).

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/hcd-xhci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f5bb7d25600..cc61e28d33b 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -39,8 +39,6 @@
 #else
 #define DPRINTF(...) do {} while (0)
 #endif
-#define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
-                                 __func__, __LINE__, _msg); abort(); } while (0)
 
 #define TRB_LINK_LIMIT  32
 #define COMMAND_LIMIT   256
@@ -1673,9 +1671,7 @@ static int xhci_try_complete_packet(XHCITransfer *xfer)
         xhci_stall_ep(xfer);
         break;
     default:
-        DPRINTF("%s: FIXME: status = %d\n", __func__,
-                xfer->packet.status);
-        FIXME("unhandled USB_RET_*");
+        g_assert_not_reached();
     }
     return 0;
 }
-- 
2.55.0



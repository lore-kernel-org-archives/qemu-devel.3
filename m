Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C404C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq6FL-0002GL-9a; Thu, 06 Mar 2025 03:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq6FI-0002AN-1F
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tq6FG-0007JD-1j
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 03:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741248376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=24/i6R28gOY2ALrMhsN1jbLEPG+5/bm6EgWMo7QJFOY=;
 b=BPYtNuaEdQ01DMJjkbyPxXkru+ghDfqvBcRYznFzTiiuxfp8rxZPJSkkA+iof9tN3UbrD9
 eYQoJecK9FZIdLAbx8t3F/0NX7/hBjrtV7LVQwrnXkGVWyMqJYyM7YUtRrFd6LScxXPqBm
 8/zToOMJFW2iiAbGadCyD241MBgDH4E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-xeWkQwTYM12kSH69BkzABg-1; Thu,
 06 Mar 2025 03:06:04 -0500
X-MC-Unique: xeWkQwTYM12kSH69BkzABg-1
X-Mimecast-MFC-AGG-ID: xeWkQwTYM12kSH69BkzABg_1741248363
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55367180AF6A; Thu,  6 Mar 2025 08:06:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.88])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20995300019E; Thu,  6 Mar 2025 08:05:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Weil <sw@weilnetz.de>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [qemu-web PATCH] download/windows: Drop link to 32-bit builds,
 add aarch64 instead
Date: Thu,  6 Mar 2025 09:05:57 +0100
Message-ID: <20250306080557.681538-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU does not support 32-bit Windows anymore, so we should not
tempt the users to download old builds.
OTOH, there is now interest in Windows build on arm computers instead
(see e.g. https://gitlab.com/qemu-project/qemu/-/issues/2850 ), so
let's add a link to these builds instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 _download/windows.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/_download/windows.md b/_download/windows.md
index 8ce3f0d..f97d216 100644
--- a/_download/windows.md
+++ b/_download/windows.md
@@ -1,6 +1,6 @@
-Stefan Weil provides binaries and installers for
-both [32-bit](https://qemu.weilnetz.de/w32/) and
-[64-bit](https://qemu.weilnetz.de/w64/) Windows.
+Stefan Weil provides 64-bit binaries and installers for Windows on
+both [x86](https://qemu.weilnetz.de/w64/) and
+[arm](https://qemu.weilnetz.de/aarch64/) computers.
 
 **MSYS2:**
 
-- 
2.48.1



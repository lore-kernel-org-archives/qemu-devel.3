Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E29F9B60B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4T-0002LF-7U; Wed, 22 Apr 2026 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3k-0000C0-8X
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV3i-0003Bg-2O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hD5gD/YRIqGPhayh5+r9+HyXtgwsfZi/SfYhctDI+0Y=;
 b=AmAZii7i9rq/4w05TA7kIOQvP8vrrUmEZWX8gRcRi3Am0Dbg7nVEHs6Y/2Awmebiqq8eFM
 0dCzMrC7Nl8EVzmC+TJMkrG9IKydw2urBvW5493/JFEhat9hJmoCMO8W1InCf/XwkEzMD2
 XKrfAHbRFRT9Yx2a7yGkX5ymT/OX/Fs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-WITSL_w8Mwqjs96It9Eg8Q-1; Wed,
 22 Apr 2026 06:43:50 -0400
X-MC-Unique: WITSL_w8Mwqjs96It9Eg8Q-1
X-Mimecast-MFC-AGG-ID: WITSL_w8Mwqjs96It9Eg8Q_1776854629
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC4818005BC; Wed, 22 Apr 2026 10:43:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F3C83000C23; Wed, 22 Apr 2026 10:43:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 29/40] ui/vgafont: add SPDX license header
Date: Wed, 22 Apr 2026 14:40:30 +0400
Message-ID: <20260422104042.3936506-30-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The vgafont was added without source origin, but it can be traced back
to Linux kernel, which used
GPL-2 (https://github.com/mpe/linux-fullhistory/blob/master/lib/fonts/font_8x16.c).

commit c6f37d0e4feeb264a699eda289d3cc69405100b0
Author: Fabrice Bellard <fabrice@bellard.org>
Date:   Wed Jul 14 17:39:50 2004 +0000

    virtual console

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vgafont.h | 3 +++
 ui/vgafont.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/ui/vgafont.h b/ui/vgafont.h
index 4498ac4e07b..54aeeb7d192 100644
--- a/ui/vgafont.h
+++ b/ui/vgafont.h
@@ -1,3 +1,6 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #ifndef VGAFONT_H
 #define VGAFONT_H
 
diff --git a/ui/vgafont.c b/ui/vgafont.c
index 708c845a6bf..b9b9a7016f0 100644
--- a/ui/vgafont.c
+++ b/ui/vgafont.c
@@ -1,3 +1,6 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "vgafont.h"
 
 const uint8_t vgafont16[256 * 16] = {
-- 
2.53.0



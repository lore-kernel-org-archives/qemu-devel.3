Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39770C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXVj-0004eI-4b; Wed, 24 Apr 2024 03:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVh-0004e4-LM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVg-0002zx-0b
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkDQrEcHKJpV+hxLhNqrfuusTcWm11FaiAMPdJy8T6c=;
 b=Lz75fVypMKZyu2CwBQZ4Vzd8cklhlloMDULh8imrm8hHi6AVY6W7isvOWSHiWpf2hkMBmz
 u8VRwzjCJCBMDsKUPI91V4tlLoBFL3ACxmDzm5bOwXlKr/t2/QNFcAUiX6MtN8N3Em5LOm
 WjrZQryO91FGEz20iGYwFkI00NbHJ9o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-rKXzmSkKNR2pnLim3YIhQg-1; Wed,
 24 Apr 2024 03:57:39 -0400
X-MC-Unique: rKXzmSkKNR2pnLim3YIhQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1051F29AC018;
 Wed, 24 Apr 2024 07:57:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB0D143FAD;
 Wed, 24 Apr 2024 07:57:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Lieven <pl@kamp.de>
Subject: [PULL 01/17] MAINTAINERS: update email of Peter Lieven
Date: Wed, 24 Apr 2024 09:57:19 +0200
Message-ID: <20240424075735.248041-2-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Lieven <pl@kamp.de>

I will leave KAMP in the next days. Update email to stay reachable.

Signed-off-by: Peter Lieven <pl@kamp.de>
Message-ID: <20230105095039.182718-1-pl@kamp.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f6922025..b8b058909b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3818,7 +3818,7 @@ F: block/vmdk.c
 
 RBD
 M: Ilya Dryomov <idryomov@gmail.com>
-R: Peter Lieven <pl@kamp.de>
+R: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
@@ -3844,7 +3844,7 @@ F: block/blkio.c
 iSCSI
 M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
-M: Peter Lieven <pl@kamp.de>
+M: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: block/iscsi.c
@@ -3867,7 +3867,7 @@ T: git https://repo.or.cz/qemu/ericb.git nbd
 T: git https://gitlab.com/vsementsov/qemu.git block
 
 NFS
-M: Peter Lieven <pl@kamp.de>
+M: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nfs.c
-- 
2.44.0



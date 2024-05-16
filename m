Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805BCC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Zq6-0005CD-8V; Thu, 16 May 2024 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpz-0004qh-5f
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpw-0002Np-3d
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ6DqocZIUj2ZsNc+DRMGi0kEP3qsENlV3OgiOfu0yY=;
 b=GzU/r6K+FUB4c60NxuAdk58XtdYM65wnsVkDB+4TQpIlPIrdr9+obV7sWqEZIObbF4UwPg
 5novrGlafWDRvceGErQHKmqHDM3tGfyALJMEY2EhxkDIEC1rZMRwpuNleFeDky3CAtAp4c
 fkw5GXT4tz8aOFChjmRvZ4ZhOYhFzuk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-t3siDbozNGWmmMhp7iPH4w-1; Thu,
 16 May 2024 08:03:49 -0400
X-MC-Unique: t3siDbozNGWmmMhp7iPH4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 728443800096
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19CEB40C6EB7;
 Thu, 16 May 2024 12:03:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 070161801012; Thu, 16 May 2024 14:03:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/4] MAINTAINERS: drop spice+ui maintainership
Date: Thu, 16 May 2024 14:03:41 +0200
Message-ID: <20240516120344.531521-5-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-1-kraxel@redhat.com>
References: <20240516120344.531521-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

Remove myself from spice and ui entries.
Flip status to "Orphan" for entries which have nobody else listed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d9f4fd09823..d5b6a1c76abb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3042,8 +3042,7 @@ F: stubs/memory_device.c
 F: docs/nvdimm.txt
 
 SPICE
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: include/ui/qemu-spice.h
 F: include/ui/spice-display.h
 F: ui/spice-*.c
@@ -3053,7 +3052,6 @@ F: qapi/ui.json
 F: docs/spice-port-fqdn.txt
 
 Graphics
-M: Gerd Hoffmann <kraxel@redhat.com>
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Odd Fixes
 F: ui/
-- 
2.45.0



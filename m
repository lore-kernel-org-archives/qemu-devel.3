Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFB2C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlpg-00063q-W2; Tue, 30 Jan 2024 05:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpc-000625-0m
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUlpa-0006th-Ce
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706612345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SS0JWQXZlNALIXUy1t70ZB8BC5t8JZiFF/gSwb9PbiY=;
 b=KMOJWQrXWpzX0YO4N+qj1zyWQiSJe/xaK/gVXXzNCcnepSw0nQoj09ouVJlrlRJ0r7tFRG
 hB6rCUzBzHVrBabCnEojyM5Bti+DNae0JAKKghoMFzaBkDDR8FAPX/9ngZNEkALMVhcWfF
 UQdByUz9TjseDDtxa+Jb/rfc0K9HU4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-DZTc4_4fMk-ZkYy9zMojng-1; Tue, 30 Jan 2024 05:59:03 -0500
X-MC-Unique: DZTc4_4fMk-ZkYy9zMojng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF4B78350E8;
 Tue, 30 Jan 2024 10:59:02 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28947494;
 Tue, 30 Jan 2024 10:59:02 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 4/4] qga: Solaris has net/if_arp.h and netinet/if_ether.h but
 not ETHER_ADDR_LEN
Date: Tue, 30 Jan 2024 12:58:56 +0200
Message-ID: <20240130105856.27178-5-kkostiuk@redhat.com>
In-Reply-To: <20240130105856.27178-1-kkostiuk@redhat.com>
References: <20240130105856.27178-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nick Briggs <nicholas.h.briggs@gmail.com>

Solaris has net/if_arp.h and netinet/if_ether.h rather than net/ethernet.h,
but does not define ETHER_ADDR_LEN, instead providing ETHERADDRL.

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..26008db497 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -45,9 +45,12 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#if defined(__NetBSD__) || defined(__OpenBSD__)
+#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(CONFIG_SOLARIS)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
+#if !defined(ETHER_ADDR_LEN) && defined(ETHERADDRL)
+#define ETHER_ADDR_LEN ETHERADDRL
+#endif
 #else
 #include <net/ethernet.h>
 #endif
-- 
2.42.0



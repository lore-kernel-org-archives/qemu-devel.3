Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0455DC10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOo1-00048P-1k; Tue, 23 Apr 2024 18:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmV-0001Qw-Kq
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmQ-00065j-Ht
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Gv2ze+DH5z8/6YTJMF78HsxLvKiWjs9ByVuDww7VIY=;
 b=bQgesmrGZGrQitAE2DLaln5n9y/ULKSvLGi8zH0ud6oJlZbRbIDgpxoAibCN0SGEW8rAcX
 +BQfAvg3csmlHzIXR1FhfyYXceGpP6aoyMRbrhBDHAhvyzmUoWXBOU6zZoEDAC52HmSRpw
 RaS30nRt4EV+E1E5xACSxkEZdy8KBnU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-vlnlP7_AOqyVbC9sAyezaw-1; Tue, 23 Apr 2024 18:38:24 -0400
X-MC-Unique: vlnlP7_AOqyVbC9sAyezaw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-479d52894a3so245037137.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911904; x=1714516704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gv2ze+DH5z8/6YTJMF78HsxLvKiWjs9ByVuDww7VIY=;
 b=ouKHwzS8T7rIxXHGUO64W/bBEyuQI20h9n3RgsnKO6triU7o4IYRxyLjvoKNUyRpL5
 ssibnYx0Y1SJyQ92OjQGOeKD25SgqjI04Whl4lSqfGfXRfyGbjN73OUrdKAm0RO0PQS7
 8U1Yx7nvPyWHZ9VhkGnoP4IqyQiYZWCU66l822UIouGXmJOIpHsY41rQn13ld0+93qSZ
 ZphpCZu5kihQW5R5yrFs/8SpkcPUrrwNNQJYx35CEZrqxgsVB/pZPaLJ+LdBQHXSSUCv
 h0KpXS2CgFrqon6w4etsKiBwVizE8KENUMGXk2lCYhxxfWadPV5uF4BFpEmUZaNZmx/i
 PNQQ==
X-Gm-Message-State: AOJu0Ywa6Da+Sa6bVvpvJ8MpEJvqTvBWY0LWgNe9uf5SbCguTtVxCLRg
 ypooI7ZEV4vyIi05e4Gc4cDBU3t3SVu8Rj+pDR7MXSGqqenEPs0OLXrtayxkHw2ydMAY2e/8eja
 z43ahdxUnIUiJhCizHjc+GkoCnqXCqN7JTnIAq2MtE4rHOcR0WAnKZsH6D4ANMGYtIqwOGjfEcV
 rwevkAWe2FiZhEJu7Et58D8LGsfSR8/t7BNQ==
X-Received: by 2002:a05:6122:984:b0:4da:a7fb:67c with SMTP id
 g4-20020a056122098400b004daa7fb067cmr1064598vkd.0.1713911903650; 
 Tue, 23 Apr 2024 15:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiMN5ivqcp+spTPgIFiVwFfp7BaGTa+DMJbSZtw4pxb/2QtN+6weW7T6mNDrArZ+l4p3DCAQ==
X-Received: by 2002:a05:6122:984:b0:4da:a7fb:67c with SMTP id
 g4-20020a056122098400b004daa7fb067cmr1064572vkd.0.1713911903102; 
 Tue, 23 Apr 2024 15:38:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 03/26] tests/qtest/migration: Replace migrate_get_connect_uri
 inplace of migrate_get_socket_address
Date: Tue, 23 Apr 2024 18:37:50 -0400
Message-ID: <20240423223813.3237060-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

From: Het Gala <het.gala@nutanix.com>

Refactor migrate_get_socket_address to internally utilize 'socket-address'
parameter, reducing redundancy in the function definition.

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-4-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3e8c19c4de..8806dc841e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
-static char *
-migrate_get_socket_address(QTestState *who, const char *parameter)
+static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
-    char *result;
     SocketAddressList *addrs;
+    SocketAddress *addr;
     Visitor *iv = NULL;
     QObject *object;
 
     rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
+    object = qdict_get(rsp, "socket-address");
 
     iv = qobject_input_visitor_new(object);
     visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
+    addr = addrs->value;
     visit_free(iv);
 
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
     qobject_unref(rsp);
-    return result;
+    return addr;
+}
+
+static char *
+migrate_get_connect_uri(QTestState *who)
+{
+    SocketAddress *addrs;
+    char *connect_uri;
+
+    addrs = migrate_get_socket_address(who);
+    connect_uri = SocketAddress_to_str(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_uri;
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, "uri"));
     if (!uri) {
-        connect_uri = migrate_get_socket_address(to, "socket-address");
+        connect_uri = migrate_get_connect_uri(to);
     }
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573D9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOna-00035K-6w; Tue, 23 Apr 2024 18:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmb-0001Tg-5H
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmT-000665-7T
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rXx572ZGHTrHckkJHCqne5ifXRW3oSu4KC6y5PaVE4=;
 b=OT/lV/oMt+k/lNJrlDwxcPwv2AWMW0mkKwpEDbTcT2iVxPolNcGlmCo0JwIGnKpLPdlFYL
 JwXQpUTejpiUZb2+c6tRZZP6NHg8w9tSMDVsi1uqbO80RMg6nnUm8pfSNRE7v7lPEAjLQu
 uj+GMT3D6pNk/6/vMDmBNXJbHcUByIc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-TCYaPVtEM0O8QRlGy5jFGA-1; Tue, 23 Apr 2024 18:38:26 -0400
X-MC-Unique: TCYaPVtEM0O8QRlGy5jFGA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-437972269edso20720801cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911905; x=1714516705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rXx572ZGHTrHckkJHCqne5ifXRW3oSu4KC6y5PaVE4=;
 b=oQ6b08MDG/vkuX+IB13fMxOctAYwtMddVMEyi8CQUe4OYKY0mesXef7Umrv6MaIYMn
 ajD4CBEIW22Cv/5XoBONHFU9SaFAu5V5Gy2IyhVu/GcmoXhxBKc0F9TXIqlYSDuNn4+l
 SIEdXyaKTS0dkAIfBenIysNftuwpnll3NELTUfXo/hY9E9NxjHsBZQQqGMldAqQp5rxK
 AyEonMNKcolmBgd9EGwpCO9nOoJMvdKA7endrKt4DJIRHfFZfl4BCpV+wnLfYeULNqcv
 0LsAw5i/ktYifezcZByHz2j9cN8NhP1jEOlNj8T29guMis9tuK+plGAVquCiU3xQgHAN
 Ya3g==
X-Gm-Message-State: AOJu0Yzw3bBLZRoNBpW8cqQqV/Vmxr0ow5M1/N89LpUOSmdItuJWOWuo
 u9x1tTDg+ObvoogSHDex9/V71nGkAtiXunk+EH/13iydSBYaoWg2B6OEKz6jcWdK/8Z0THrfmTm
 EiZCdxfD2UNEf2Y/LB3a5PtbY7OLxMjuiB7O5mgPlt6Sbu8ugjpHzo0lnIPe7eAlCXXp5oliPAa
 0xDpc85sq4cOGDFXbXFNJxqDsL6RwjNUPJfQ==
X-Received: by 2002:a05:620a:1a8e:b0:78f:199c:ece8 with SMTP id
 bl14-20020a05620a1a8e00b0078f199cece8mr935400qkb.5.1713911905434; 
 Tue, 23 Apr 2024 15:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFkw15iTDgZUeoTDIJzxXVqOuTJxfKQ4pm6Sy2qxeTp4dVDa4J3ZuuVucKqlp+n1oH9snw0w==
X-Received: by 2002:a05:620a:1a8e:b0:78f:199c:ece8 with SMTP id
 bl14-20020a05620a1a8e00b0078f199cece8mr935366qkb.5.1713911904746; 
 Tue, 23 Apr 2024 15:38:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 05/26] tests/qtest/migration: Add migrate_set_ports into
 migrate_qmp to update migration port value
Date: Tue, 23 Apr 2024 18:37:52 -0400
Message-ID: <20240423223813.3237060-6-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

migrate_get_connect_qdict gets qdict with the dst QEMU parameters.

migrate_set_ports() from list of channels reads each QDict for port,
and fills the port with correct value in case it was 0 in the test.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-6-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index f215f44467..a330ef9c7f 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -16,6 +16,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/cutils.h"
 
 #include "migration-helpers.h"
 
@@ -48,6 +50,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
+static QDict *SocketAddress_to_qdict(SocketAddress *addr)
+{
+    QDict *dict = qdict_new();
+
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        qdict_put_str(dict, "type", "inet");
+        qdict_put_str(dict, "host", addr->u.inet.host);
+        qdict_put_str(dict, "port", addr->u.inet.port);
+        break;
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        qdict_put_str(dict, "type", "unix");
+        qdict_put_str(dict, "path", addr->u.q_unix.path);
+        break;
+    case SOCKET_ADDRESS_TYPE_FD:
+        qdict_put_str(dict, "type", "fd");
+        qdict_put_str(dict, "str", addr->u.fd.str);
+        break;
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        qdict_put_str(dict, "type", "vsock");
+        qdict_put_str(dict, "cid", addr->u.vsock.cid);
+        qdict_put_str(dict, "port", addr->u.vsock.port);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    return dict;
+}
+
 static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
@@ -81,6 +114,46 @@ migrate_get_connect_uri(QTestState *who)
     return connect_uri;
 }
 
+static QDict *
+migrate_get_connect_qdict(QTestState *who)
+{
+    SocketAddress *addrs;
+    QDict *connect_qdict;
+
+    addrs = migrate_get_socket_address(who);
+    connect_qdict = SocketAddress_to_qdict(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_qdict;
+}
+
+static void migrate_set_ports(QTestState *to, QList *channel_list)
+{
+    QDict *addr;
+    QListEntry *entry;
+    const char *addr_port = NULL;
+
+    if (channel_list == NULL) {
+        return;
+    }
+
+    addr = migrate_get_connect_qdict(to);
+
+    QLIST_FOREACH_ENTRY(channel_list, entry) {
+        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
+        QDict *addrdict = qdict_get_qdict(channel, "addr");
+
+        if (qdict_haskey(addrdict, "port") &&
+            qdict_haskey(addr, "port") &&
+            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+                addr_port = qdict_get_str(addr, "port");
+                qdict_put_str(addrdict, "port", g_strdup(addr_port));
+        }
+    }
+
+    qobject_unref(addr);
+}
+
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
@@ -139,6 +212,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 {
     va_list ap;
     QDict *args;
+    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -149,6 +223,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     if (!uri) {
         connect_uri = migrate_get_connect_uri(to);
     }
+    migrate_set_ports(to, channel_list);
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
-- 
2.44.0



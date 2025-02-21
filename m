Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E8AC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5H-0001Bt-RM; Fri, 21 Feb 2025 07:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5A-0000ou-MP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS58-0007ED-UJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUA67lnlZ1kgDiClFh7mIAizVWuXk4KUx2uXWAEi+j8=;
 b=gfkt10voKh1mUR+42iI5bR0vW8/4pzXdd81+nzRbFO9eAF3/o5xRRAsinetD/YipH+N2fN
 22yL6CGLxcPe5nMq14HOEuEI0zGDurq0nOC6GqrCgmXKjUb2wH4EAxtzH0lA38grIJPKI+
 UnC/sNKV37lxhjdBIOOPiGIH55dt370=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-yb7I_n_fPLK_PvltGKh_Yw-1; Fri, 21 Feb 2025 07:24:36 -0500
X-MC-Unique: yb7I_n_fPLK_PvltGKh_Yw-1
X-Mimecast-MFC-AGG-ID: yb7I_n_fPLK_PvltGKh_Yw_1740140676
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so10250195e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140675; x=1740745475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUA67lnlZ1kgDiClFh7mIAizVWuXk4KUx2uXWAEi+j8=;
 b=GROT38UovHmNCJYFHBWvcI5XLBnnZelpxyg3Li+cazqzz0w/Dht9xN5uIEX29ZV+zA
 Sr/7fEPhhm2dghdvtn8Q1SuaBufdDxP4X9C86oMAkXmZu4ORv8VaCPJLVNiumJ7Bh8FR
 nsLcscFj8DApiz30nRIdET3LAjnfXva+KGlEUNkuSTKH5fz9l88gFg7fqkOUqH+HhC4w
 shB/iy2qGnS5aSzY2+sb658XtpaFRT1Q9vTY25i4CaE51JpDfNY+l2HMqyXnRivDYj7J
 pmHu5V7j8as2NyKM9jW7ZsuNYLe6LUxeCo9NHzWD+/d7a5RzLOjK3vFJbCjm4EE1HkYz
 cc4w==
X-Gm-Message-State: AOJu0Yx/L4FeMJx6CRDe4optSPjP+2j5ZiYqUEBj0+gfxHyUNPXEg3jw
 JrIwyjUtbZHc2lZTOlShWmI+zIOY6XnrjjRGx0JJqzxDpZk5+6uyLOu36qFnd1uxb9dJwa/EIX2
 WwOoYT/Mlsc6RMR7hgOGOdEOMSNcFqUBodegxThIfdwAuVYiPrTaGVGwrKdZLhK0CrkC9i7En4V
 fG5Esf0eOClqODw5NnGScsnMJFEBUrtw==
X-Gm-Gg: ASbGnctH2zKzz1fqhU1HxqTRAgEyKwjkvFgd9Lh8BdyTnrAgrkOKLnMS5Gmb7UyfSXP
 ScHcNPecwTdTsYzlU66EXUTfcLO4Y2XugRdOLEZfy1ljwWLpyknlYlcVo4TXIaxD4nH1uxm7S3m
 ijdqUjTT66MlHvwLcp9YWF6ndAAhXlosVTaXN4VkSefod0Q+m5OetkU9CyV3ZboijNSz4iew4WZ
 X5d6RmCZ6u8igK+TZxJK4cNVB/eQ7Jp48nj+BZ8gboZz0abkIl1+dC59CrfHoC7O5ien2Xv0eU7
 uJmRTQ==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id
 5b1f17b1804b1-439aeb2b5d6mr21742975e9.15.1740140675316; 
 Fri, 21 Feb 2025 04:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaeWRFRYfK0x7iyzRUjEsi1+KVod4N7DA9MqcsiQt7qtKUTUTdG4OFv4H8GnVPFQ1EiCCwVQ==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id
 5b1f17b1804b1-439aeb2b5d6mr21742685e9.15.1740140674931; 
 Fri, 21 Feb 2025 04:24:34 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4118sm23865508f8f.18.2025.02.21.04.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:34 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 35/41] net: vhost-user: add QAPI events to report connection
 state
Message-ID: <02fd9f8aeeb184276b283ae2f404bc3acf1e7b7a.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

The netdev reports NETDEV_VHOST_USER_CONNECTED event when
the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
when it is disconnected.

The NETDEV_VHOST_USER_CONNECTED event includes the chardev id.

This allows a system manager like libvirt to detect when the server
fails.

For instance with passt:

{ 'execute': 'qmp_capabilities' }
{ "return": { } }

[killing passt here]

{ "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
  "event": "NETDEV_VHOST_USER_DISCONNECTED",
  "data": { "netdev-id": "netdev0" } }

[automatic reconnection with reconnect-ms]

{ "timestamp": { "seconds": 1739538638, "microseconds": 354181 },
  "event": "NETDEV_VHOST_USER_CONNECTED",
  "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }

Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20250217092550.1172055-1-lvivier@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/net.json    | 40 ++++++++++++++++++++++++++++++++++++++++
 net/vhost-user.c |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 2739a2f423..310cc4fd19 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1031,3 +1031,43 @@
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
+
+##
+# @NETDEV_VHOST_USER_CONNECTED:
+#
+# Emitted when the vhost-user chardev is connected
+#
+# @netdev-id: QEMU netdev id that is connected
+#
+# @chardev-id: The character device id used by the QEMU netdev
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
+#          "event": "NETDEV_VHOST_USER_CONNECTED",
+#          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_CONNECTED',
+  'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
+
+##
+# @NETDEV_VHOST_USER_DISCONNECTED:
+#
+# Emitted when the vhost-user chardev is disconnected
+#
+# @netdev-id: QEMU netdev id that is disconnected
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
+#          "event": "NETDEV_VHOST_USER_DISCONNECTED",
+#          "data": { "netdev-id": "netdev0" } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
+  'data': { 'netdev-id': 'str' } }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 12555518e8..0b235e50c6 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -16,6 +16,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-events-net.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -271,6 +272,7 @@ static void chr_closed_bh(void *opaque)
     if (err) {
         error_report_err(err);
     }
+    qapi_event_send_netdev_vhost_user_disconnected(name);
 }
 
 static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
@@ -300,6 +302,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
                                          net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
         s->started = true;
+        qapi_event_send_netdev_vhost_user_connected(name, chr->label);
         break;
     case CHR_EVENT_CLOSED:
         /* a close event may happen during a read/write, but vhost
-- 
MST



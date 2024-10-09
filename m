Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34AECEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1p-0004jV-VM; Wed, 09 Oct 2024 08:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1p-0004jN-4A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1n-0005Sd-2y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/0kDNEZEHcHY+mJQf631i4X5DtZp/zqgZgP9eV3P4g=;
 b=NQ5YuJUQQUMnlDZB3U8pVe9iuqvBZqnh7hkPYKYJxO5wFcYBz6JG4Pn05AfOzbbuVKLov6
 Dy9GiIpAnkKcjD45m1a72YEK+S66QEnTxTWSbNwpOdIyfmtT0ZnFJf/IotkrpWGoI9/9du
 PwCDsvc/1uDyHXOT7rx/pOVbUPsGw6s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-6TsXy6sfOBa6X7zAQjtOmw-1; Wed, 09 Oct 2024 08:42:53 -0400
X-MC-Unique: 6TsXy6sfOBa6X7zAQjtOmw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-82ced069d94so638574639f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477772; x=1729082572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/0kDNEZEHcHY+mJQf631i4X5DtZp/zqgZgP9eV3P4g=;
 b=lQJ3jpAfbJnDWJLYrkHrCWwMWPV5EE9aqaAB06+hEkEv424rXk3nif+8jn1tYBtR7C
 EJjh8EPpBLG/Gqs5fpO2yYZQlHguVAQdpoS4N9H/NArHoyUmNN+kqh63ZyKNbA523fzc
 /rDrl31IK/JCY+uMAR/2YUWneTzMclkoQjvdGv/9z0BSOoY1MoT2McAr/iLL+9vQ0skA
 DX6+W18V0fTVMLcZhQ3dBF7sNZmXjU8vphqn9XCXkKp0dwLxGIetgIEHKBtJyHD8tWx4
 8+f041UhZIqfG77fmRb93bAXhMCkJtkD7Lx79TkLniY7d3Xlc4itFv5+TbC9/5aPdyt2
 XG7w==
X-Gm-Message-State: AOJu0YxT0fbLtYLCjd7+gzYM3IOWaOKP6AoGLlK7NHHXsKILKYUeKra9
 COAZt9UOv4kq9CykJciiM+flHCq4iuJyeNhNzktGPY2wprlkJIPIuI5hfoLqhnaHwKrl64h/Y9A
 H56X6m3Y30/Pp5UzSbGGLbkQFci2XPUkci6v7ais6rFrK5veNTwPmLje3QvuPYFyBoc36YI5kwX
 AXdVcQ/vtNjueZ8fokIZ2DZdBHv5Oa2+kXUw==
X-Received: by 2002:a05:6602:2b83:b0:834:f744:d067 with SMTP id
 ca18e2360f4ac-8353d4a7cdamr298917939f.8.1728477772430; 
 Wed, 09 Oct 2024 05:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6H/uWXP97Zaa7s2yDrynU93ec9ZX+eQE1V3QcJlP4ZilTQQlWrAhVddifAnr37JCd0+MmJg==
X-Received: by 2002:a05:6602:2b83:b0:834:f744:d067 with SMTP id
 ca18e2360f4ac-8353d4a7cdamr298914939f.8.1728477772015; 
 Wed, 09 Oct 2024 05:42:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 06/12] migration: Remove unused socket_send_channel_create_sync
Date: Wed,  9 Oct 2024 08:42:32 -0400
Message-ID: <20241009124238.371084-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

socket_send_channel_create_sync only use was removed by
  d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240919134626.166183-5-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.h |  1 -
 migration/socket.c | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/migration/socket.h b/migration/socket.h
index 46c233ecd2..04ebbe95a1 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -22,7 +22,6 @@
 #include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
-QIOChannel *socket_send_channel_create_sync(Error **errp);
 
 void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
diff --git a/migration/socket.c b/migration/socket.c
index 9ab89b1e08..5ec65b8c03 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -42,24 +42,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
                                      f, data, NULL, NULL);
 }
 
-QIOChannel *socket_send_channel_create_sync(Error **errp)
-{
-    QIOChannelSocket *sioc = qio_channel_socket_new();
-
-    if (!outgoing_args.saddr) {
-        object_unref(OBJECT(sioc));
-        error_setg(errp, "Initial sock address not set!");
-        return NULL;
-    }
-
-    if (qio_channel_socket_connect_sync(sioc, outgoing_args.saddr, errp) < 0) {
-        object_unref(OBJECT(sioc));
-        return NULL;
-    }
-
-    return QIO_CHANNEL(sioc);
-}
-
 struct SocketConnectData {
     MigrationState *s;
     char *hostname;
-- 
2.45.0



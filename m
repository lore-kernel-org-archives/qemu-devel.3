Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA32DC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2K9-0004iN-OX; Tue, 27 May 2025 17:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K7-0004hz-Ro
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K6-00086X-Hk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBPJYh4awj1/1POQMjqRYxwnju5UeXUDjsTRvIqFEdk=;
 b=U61/7GmXyhR7rP0S31tjw4u7SrWojHvq5J6wfMk65jFnZHSly6COgefNt7iJFo74cVk56B
 r/ujdq+8xW8S4TyrvqKwVwYHbqxcj2BvZAohekKeCjw18vQ5Jefgac0f9Wejt7m1u7stIw
 ZNPttNMA5/TNUMb3iHYephgVeJQuCyI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ou4VulYHMlOdX4DZRZI3gw-1; Tue, 27 May 2025 17:59:00 -0400
X-MC-Unique: ou4VulYHMlOdX4DZRZI3gw-1
X-Mimecast-MFC-AGG-ID: ou4VulYHMlOdX4DZRZI3gw_1748383140
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f0e2d30ab4so66377326d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383140; x=1748987940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBPJYh4awj1/1POQMjqRYxwnju5UeXUDjsTRvIqFEdk=;
 b=J7Ynsucknqf2FHYqANIxvxc4PlY00BMWS2xF3QghAsuAdxeN5TQRFMWZjkCC8tWfQ3
 eenqW4fhC7NwhczrqfB/KIS4bUSZjPj7zLDKjE3l1iongWgYBH5wdvAMySQFr07dYrN4
 9hpclmdG+V+ft89jq21drnpiA4biM4wWzjA6RWy0GNjM16jqeh8MK3bncJg1LWmzMSQB
 TcnMxPHIdEkp4x+rSFkZlqLQzdZ3hR2BAYYs8J8UwLOnq2MKQxmIJFdTiJTV7ZJpGBaI
 tS2bbnHZtINASHCpPszgxuhwJ7FRuKhwn2jiPIYTrOZqZdR+srtUzQbcQYGnDOFqLs+O
 Z+bg==
X-Gm-Message-State: AOJu0Yw+6+0f3nl7D8mm4AWvfiz2Le9ZfWHD2LrZPeftHk53w5k0QQFC
 +yXKuMhGc/MmtasfP7wDHgqbsStMzcNaLUiAEsRvD6wEfQBbtFu9d9utvznrVys+NzwiTfm/3US
 vzqTD6Elq2yJd7ZWxZb36e1NJzoKnE/foHyjAvy/dZCSrzIeMWd1FOEkhcGrdEdisxcDxb7qbjk
 j5rnGIzVBfmPHtdknKjbqTZR9I9SDZRLaU03ZsjQ==
X-Gm-Gg: ASbGnct5/VUsHtSl7Y1XvcLZi0NU9UWMC0a8zVAHXDjG60EtDmNzkJ4CegF5pj57H1D
 Y+2OrYGBdz9I1SVlfviUu44+lTNNLoILEKWP6h90ZRmHWaVazhcLjE0PqqDTq12SGJb4qpHctYD
 E8PHg4VaxKvsj5wRzyrrMQEoADfYlMVPqIcJtVf63sXjdAujQwVvIijGbjSl9KqTT09bcmDKBbx
 9jPJ4tbtV3TZ3fK2qzVj8bAhj9/10xVS1a0rSJ3xIoktv9HJddBA6x37rvvSLH2/gO06hdGYaph
X-Received: by 2002:a05:6214:401b:b0:6f5:4214:774a with SMTP id
 6a1803df08f44-6fa9d29d04cmr236353816d6.41.1748383139844; 
 Tue, 27 May 2025 14:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdBLAP9+XbvCDFi2G91SWkxCE6UJmzNXjFE1YF7NK6Tqpmyw5An+o9qlrZH2SkofZANoRiDQ==
X-Received: by 2002:a05:6214:401b:b0:6f5:4214:774a with SMTP id
 6a1803df08f44-6fa9d29d04cmr236353576d6.41.1748383139542; 
 Tue, 27 May 2025 14:58:59 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:58:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 04/11] migration/bg-snapshot: Do not check for SKIP in iterator
Date: Tue, 27 May 2025 17:58:43 -0400
Message-ID: <20250527215850.1271072-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

It's not possible to happen in bg-snapshot case.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef..7bd78dd524 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3890,9 +3890,8 @@ static void *bg_migration_thread(void *opaque)
 
     while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
-        if (iter_state == MIG_ITERATE_SKIP) {
-            continue;
-        } else if (iter_state == MIG_ITERATE_BREAK) {
+
+        if (iter_state == MIG_ITERATE_BREAK) {
             break;
         }
 
-- 
2.49.0



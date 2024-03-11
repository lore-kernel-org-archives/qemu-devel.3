Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9B8C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngH-0000B9-MW; Mon, 11 Mar 2024 17:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngG-0000AM-2N
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngE-0003xg-2j
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TJ0h7ZMVfo2zcsyyzL/oW195rR/axwQDT3wJxhwttk=;
 b=AUc0+x7yMvGEKO70CkvmsfwWCr+bkG28rOor6l8icirOvMjlWBUKkO8kztNOmPOkBrc8XP
 QFCdmNylz46C7uH/qHrcuThweMTaZk0KzcDZavKVurZIBWyDOFXPS/cKeUqcs/UOaU9sky
 TQJy35aQi7w93RQcS9rti/35p50owCg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-wCeX326cOMurQZvGDF7Z_Q-1; Mon, 11 Mar 2024 17:59:31 -0400
X-MC-Unique: wCeX326cOMurQZvGDF7Z_Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690becce69eso10936526d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194371; x=1710799171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TJ0h7ZMVfo2zcsyyzL/oW195rR/axwQDT3wJxhwttk=;
 b=NhBlXXT9h/aUejgCM8ZIlwNO6Y9uzC24ZG7QFFaB6LuSnrfm5RYo1/RqTRuJhHHZlQ
 df1kWZBj4eQe+8reLU4Q47aoWLNhH8zv2obDl+x7r6FowgmFsX+9PqaQjOWjnPAQB2vX
 NCkRKX72wec2A4iB3tr+WpAlskTc1uWdhPqqlI83Nl+9p7VpzKOGGSSv6F0O25IZLv2b
 DTw890IUiwxWRO3Lo/5txHFf31zRPEgv5AQHjs864Siz0oAB/RnRIsq66JR8KKAz7BBO
 fURK7e3RiK6Ya5Uzw76v5Lt6Oz9pqGHZI4Rgg3gXslK/LsOt1sDNERU3LHi9eykDxw5M
 TB/A==
X-Gm-Message-State: AOJu0YxejqTMXD8UvFdo4rH9O7HFnBw/asb8YBUy8StKnD98eKHFMmo6
 +n8UEon71ZaAJLT9cZkPOTqlcWXLOIH5aQuu9PI0MDc78UjzbfxgxWs6nhjLHiWdDV3PFXWuLyS
 83C/F1YG07nDTrKbIEbmrch/XXRuZqhfrH5NvQ2M2E7cPZBh58OJafI9O7tRFuHBBUD4GIZ6CyK
 7pnimzJmRwbwVG9y43Pm1SupA+EHBqdD+Cjg==
X-Received: by 2002:a0c:fc10:0:b0:690:b5a9:84f1 with SMTP id
 z16-20020a0cfc10000000b00690b5a984f1mr7585190qvo.1.1710194370740; 
 Mon, 11 Mar 2024 14:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGZ9XVkV0tZBQ1ickch4q5CoKHbNhHKlJ9Blyvyu7wlZIm52bMY6pK7Qr6N9S0JMG1cp2zKw==
X-Received: by 2002:a0c:fc10:0:b0:690:b5a9:84f1 with SMTP id
 z16-20020a0cfc10000000b00690b5a984f1mr7585166qvo.1.1710194370305; 
 Mon, 11 Mar 2024 14:59:30 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:29 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 02/34] vfio/migration: Refactor vfio_save_state() return value
Date: Mon, 11 Mar 2024 17:58:53 -0400
Message-ID: <20240311215925.40618-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Currently, vfio_save_state() returns 1 regardless of whether there is
more data to send or not. This was done to prevent a fast changing VFIO
device from potentially blocking other devices from sending their data,
as qemu_savevm_state_iterate() serialized devices.

Now that qemu_savevm_state_iterate() no longer serializes devices, there
is no need for that.

Refactor vfio_save_state() to return 0 if more data is available and 1
if no more data is available.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240304105339.20713-3-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 50140eda87..0af783a589 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -529,11 +529,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     trace_vfio_save_iterate(vbasedev->name, migration->precopy_init_size,
                             migration->precopy_dirty_size);
 
-    /*
-     * A VFIO device's pre-copy dirty_bytes is not guaranteed to reach zero.
-     * Return 1 so following handlers will not be potentially blocked.
-     */
-    return 1;
+    return !migration->precopy_init_size && !migration->precopy_dirty_size;
 }
 
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
-- 
2.44.0



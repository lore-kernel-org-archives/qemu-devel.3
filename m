Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730ADE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7N-0004Ls-5D; Fri, 06 Dec 2024 17:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7H-0004Km-OY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7F-0002PI-Uc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=st2vOIgs8A0o+X0EEzA+Hhgn5ZdqD6a20MPWzcMAv0s=;
 b=gVW/iST5Al2MDjZ3lqh390j06ER32yBZ9WHIIuK4ZMGDjsqJeT5AYAyNBGkGvDRaTLDz+W
 85HikFVp4knFn0sx/PSujwGwtZjmF9l31tz86v1SgKGa9UjIywXqkDwMLT0Kz6GeQCJlD2
 +r5ywrMhZeyVjqfr2ah6EUp8YXwv4cg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-9ZyUuV1jMtysXOIlThy7cA-1; Fri, 06 Dec 2024 17:48:01 -0500
X-MC-Unique: 9ZyUuV1jMtysXOIlThy7cA-1
X-Mimecast-MFC-AGG-ID: 9ZyUuV1jMtysXOIlThy7cA
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841aa90930cso237554739f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525280; x=1734130080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st2vOIgs8A0o+X0EEzA+Hhgn5ZdqD6a20MPWzcMAv0s=;
 b=TJCC0PKlvCJN/AMNrVBRUtnDxcRdsD2UNE17qzQQrUCrxRY16E2AVAcRkv+UtO2zYW
 EB821xcN3rTL2+jKU1nWtfKWiTmCWt14HXHRZNE/mjUnk+X11QJ/1+7xKSgu0YOpWabI
 fgN9gVFQt1BdHMBrFLGdwUbi7Jpwj9DBsso7/z/50Gh3UoihWGoZ3JEOBGte3k+1hjtG
 WdHR/Pk0mExVlGSQKYXW0Qrcv6ifSn629eO8ljo2KoXQZWPdpsFlAQ/uLwEFNXN9y/Fz
 KjH5Ly3DEsKvTTRURZVgrAOwY7tDJPq0Bt7VW+gVRAXN/0x4Xvcxw1mx66GT6k0DeIGx
 iOlQ==
X-Gm-Message-State: AOJu0YwxTYUgs1lhZb68LK5qVCrpZR3me3AFIggEBAa5Sq1UItCsD++N
 OynCOYmLxRCWDZLAWI8f4yHY6oM9Vy/xXzVY2cc8yZy22S8ho6qqMAK8tw7GnxMioPIS6zP0P9i
 n/XOyNWNB0W+sAODvwrA2cOsegGoouZ/bxscyKq52xEOryxpoxUnFvxsdSLthj7hx0Y7A8Q3nmg
 F5ymdMfUpCJjvZyiF/N0BoeGB8yzoGZ0+ghw==
X-Gm-Gg: ASbGncu4F2P0xgbF1yPgEocLLSCBAjfswfY+U2L+vn3MYytshoHTj1Fxl0XBwNM4xXj
 ShgL5PsgUocP/3Sf2MnSn3n0aq9afqdboGE0dJRA3ok2WSgXQIJt0JDtQc6RgBCDRuvr/JYB9WA
 1Ta9G6ltXhqOtkrEU9bHoMPSu6X4xN46K6ioIOHKu8lXz9CKOu3ZsX9MOOTPRV4ziU7WBGRL1I6
 RoQVEuC7vGJ/RW2/uqGeNuIWj3r8izsVWYdnH5A5yQCdweFyoRMkrbSg9X8OppcIsYt8Xt3OzfB
 7MdstYt6dL78eZTd85kYjJrldQ==
X-Received: by 2002:a05:6602:6b8c:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-8447e21faa8mr730657839f.5.1733525280392; 
 Fri, 06 Dec 2024 14:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt71zdrodR2Kwojdh8cwWyWrQ7qPOAo2hkK6TCT0xhiBm2HPMgH/ncrLLvL+Sma5LIEVZ9xQ==
X-Received: by 2002:a05:6602:6b8c:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-8447e21faa8mr730654839f.5.1733525279941; 
 Fri, 06 Dec 2024 14:47:59 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:47:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 1/7] migration/multifd: Further remove the SYNC on complete
Date: Fri,  6 Dec 2024 17:47:49 -0500
Message-ID: <20241206224755.1108686-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
complete()") stopped sending the RAM_SAVE_FLAG_MULTIFD_FLUSH flag at
ram_save_complete(), because the sync on the destination side is not
needed due to the last iteration of find_dirty_block() having already
done it.

However, that commit overlooked that multifd_ram_flush_and_sync() on the
source side is also not needed at ram_save_complete(), for the same
reason.

Moreover, removing the RAM_SAVE_FLAG_MULTIFD_FLUSH but keeping the
multifd_ram_flush_and_sync() means that currently the recv threads will
hang when receiving the MULTIFD_FLAG_SYNC message, waiting for the
destination sync which only happens when RAM_SAVE_FLAG_MULTIFD_FLUSH is
received.

Luckily, multifd is still all working fine because recv side cleanup
code (mostly multifd_recv_sync_main()) is smart enough to make sure even
if recv threads are stuck at SYNC it'll get kicked out. And since this
is the completion phase of migration, nothing else will be sent after
the SYNCs.

This needs to be fixed because in the future VFIO will have data to push
after ram_save_complete() and we don't want the recv thread to be stuck
in the MULTIFD_FLAG_SYNC message.

Remove the unnecessary (and buggy) invocation of
multifd_ram_flush_and_sync().

For very old binaries (multifd_flush_after_each_section==true), the
flush_and_sync is still needed because each EOS received on destination
will enforce all-channel sync once.

Stable branches do not need this patch, as no real bug I can think of
that will go wrong there.. so not attaching Fixes to be clear on the
backport not needed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..7284c34bd8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
-    if (ret < 0) {
-        return ret;
+    if (migrate_multifd() &&
+        migrate_multifd_flush_after_each_section()) {
+        /*
+         * Only the old dest QEMU will need this sync, because each EOS
+         * will require one SYNC message on each channel.
+         */
+        ret = multifd_ram_flush_and_sync();
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (migrate_mapped_ram()) {
-- 
2.47.0



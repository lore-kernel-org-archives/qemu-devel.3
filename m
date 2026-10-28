Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22348606A33E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRoT+0Ip;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZZOm/wF/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FC-0006Id-J4; Wed, 28 Oct 2026 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F6-00062O-Te
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F3-0003jo-Vi
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pa/+WgI35gvoVbMnP+MVomV3WWlRrtK6Sx0Os9RhTP4=;
 b=RRoT+0IpSC7rhIrX9VEoqPzmpV47FL3GiK77mBmW/lbIUIbej5b3P/Jp9vKtwcNvJFfieg
 m+TylYwTZEwu5dTlhlsO/NAvrD5txSSsukw5Fvolpp89ARHYQDQLaRtZYAqKpSseWrYNZ3
 q35H31I5+F5dv7TwV+xGsGS79fbbSUc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-DP-vSA0sMmqC21YkToUemQ-1; Wed, 28 Oct 2026 13:15:10 -0400
X-MC-Unique: DP-vSA0sMmqC21YkToUemQ-1
X-Mimecast-MFC-AGG-ID: DP-vSA0sMmqC21YkToUemQ_1793207709
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so1000160f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207709; x=1793812509; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pa/+WgI35gvoVbMnP+MVomV3WWlRrtK6Sx0Os9RhTP4=;
 b=ZZOm/wF/3VXwbnE2jj1IlchqouuAa1mDqsTCpi/2O/GOooGTtaN/YwvkRme8DPS+Z4
 zzZzVoZ+H8SNn0kX/yp23yWBoxYoKb8Bcmp91C0PpGvywbGbgdgqkRmI7xlFCzxXGAc+
 E1QwcBRsVsjwWZPc9hA4nhCOZA2Xoqaap1xOA8SwkjOgDrOZ3dtgJ4HJZjtx3AKnGIUu
 sSqzmnXgDAE5HP9gB+8QXaG0LSjH3w7QvntG3e9ruWEd45d+Pv9qg8uomHdoO96lE6Ug
 qcWH00NqC6u2Gc5f3CtxcBJkB2XZV3XDnwiVzUis1TG6zFVUDBVgOtF8ZS5dEN6STWna
 bBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207709; x=1793812509;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pa/+WgI35gvoVbMnP+MVomV3WWlRrtK6Sx0Os9RhTP4=;
 b=C9wNm9QRhKlaKRVDtmrv5JXIYMVjFEE5qKB3nxXkzzq8xpPxSb388ulIcXJA20F1ce
 kJy1egrHCpC8SOk2v4JEkV2jt2cYT5xGq+Uw2a6OT268tKz4RhxfJTSM9h0/rihslwwc
 tLZADD0Z6YADlrJhZlbDdbWVHXtrqJAHXebQNBrAT6h+OW47zIhd5rxoMBolNWG6XvS7
 eLW5Rm/yUj7H1vBt8lHdtM5e8ZLZvx5g6HRCPEu8nP+MP5r7O+SW68sSCTfknkSRFJ20
 /LPyKbn7JyRlIJItQFols/Lr5iQVnywbgJyvufYtRhA79+0JL3aJlEN+sMvkgEurO571
 KH7Q==
X-Gm-Message-State: AFq9FYJ49O87MqGQ01vie14hVKDhvbwZOaFDWXJLrPADofnsxTWvKrk0
 Ammiz65aD66lIwZyOWxih4k8rq4aZfn2PM+xaMJTdndhrY+SvNbrG3/xvSheu1p+r/+1Ya25Ta9
 voiNGJPHIhufJoWPosdpXHhLqsgrKWXpmHEwEDTr1lP3p8KaThAkghdMv/G4iS84Xy1NhkMHroE
 CwaKbhLORORP4bE0YPJvW4NTM02i+DjyMHuQ==
X-Gm-Gg: AYBFou3XJuZTSq6RAlLMgDRKfM34bnIeAIDhaCXKd76v2o8RIpCExMYGME094R4xNxB
 1CcN5qvarGjKOMW0FMUEqG8Q4b18A6BB1j1zKPjsFrlvS6Qe6aPO+6HtPZgBWQhXaExkrDhy7Tz
 4rvptuu6tMHeDy67OusGuaS8KANmhrdEYBvHgsJ3zOM4OX2V9cYByAam+s84chTfJEuvR0ka4mX
 eaON4GgIsQLHadWeu/fCIVr5UdjuNM2qaUFYN0HcVfHgYn0xgTlcpwB3i6qETyirKido+fJqopz
 kL9ZW/OSRcj+HgTUlOZPUMuiRpjUVz0M2OC4oZCKuFuEmlJyZVxKDGYm1PBetQtNBAln1ipDAc6
 gCV9GG/wAqrBqoDAqTe0UznDAZcfE9Wslm+gDh7KK
X-Received: by 2002:a05:600c:19c8:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4a967201e9dmr68826625e9.27.1793207709107; 
 Wed, 28 Oct 2026 10:15:09 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4a967201e9dmr68825685e9.27.1793207708412; 
 Wed, 28 Oct 2026 10:15:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm6267875e9.11.2026.10.28.10.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:07 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 26/78] vhost: release ownership when the incoming migration
 fails
Message-ID: <7db39afff601ec66d92ba692441901067f96b6f1.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

Releasing the ownership at exit isn't enough either: with the
return-path capability the target reports the failure to the source
before exiting, and the source resumes right away, racing with the
target's exit for the ownership.  And with exit-on-error=false the
target doesn't exit at all.

Add a migration notifier to each vhost_dev, registered for its lifetime
for the CPR modes, that releases the ownership if still held on
MIG_EVENT_INCOMING_FAILED.  It runs before the failure is published in
any way.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-17-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h |  6 ++++++
 hw/virtio/vhost.c         | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index efe1eed260..3b9ef86bac 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -122,6 +123,11 @@ struct vhost_dev {
      * when this vhost_dev goes away.  Set by the device.
      */
     bool owner_handed_over;
+    /*
+     * @migration_notifier: releases the ownership when an incoming
+     * migration fails, vhost_migration_notify()
+     */
+    NotifierWithReturn migration_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 085e2ef6f1..7fd2883504 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
@@ -72,6 +73,23 @@ static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
     }
 }
 
+/*
+ * A CPR target takes the device ownership in post_load().  If the load
+ * fails afterwards, release it before the source learns about the failure
+ * and resumes, so that the source can take the device back.
+ */
+static int vhost_migration_notify(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          migration_notifier);
+
+    if (e->type == MIG_EVENT_INCOMING_FAILED) {
+        vhost_dev_try_release_owner(hdev, "incoming migration failure");
+    }
+    return 0;
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1842,6 +1860,10 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_modes(&hdev->migration_notifier,
+                                 vhost_migration_notify,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1891,6 +1913,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    migration_remove_notifier(&hdev->migration_notifier);
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
-- 
MST



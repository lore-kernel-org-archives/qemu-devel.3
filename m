Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825C6C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeBh-000575-EI; Tue, 02 Jul 2024 10:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBf-00055D-8l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBc-0008EQ-Tg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZkfnrsmrcpCA4paPRwjE2CzS2LM1h/03EC8/LUs/AI=;
 b=WZXMuYhBkGT3sbkZJvMXyGkT9tjDo9r0BwZL1nOwxO5ylAkLOu43ZATtopLNZFN0B08BZS
 du+0O0Tut+fsU2q0RnBfGyHEyNY2sOViv8Uv5KlbMHfKrpoNgp+8a2AkjXznWD7xhYQbc/
 0pjXk22N4FWpjRyzQbBijPaHaCmPt2A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-TNUpZdfsP4-TlMjRcVicoA-1; Tue, 02 Jul 2024 10:08:44 -0400
X-MC-Unique: TNUpZdfsP4-TlMjRcVicoA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4256667ebf9so29778225e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929323; x=1720534123;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZkfnrsmrcpCA4paPRwjE2CzS2LM1h/03EC8/LUs/AI=;
 b=RhkXxDxfxwZ4CecIR7rqZowaS3VeZoWieKY/zFo762cdmbz4UDiW1alc3hS7Xv5F5j
 DNX4HrZWbYbH50whVO8TS+2Dizej5/3ji49/GJQZV/3N2vkWy4X1kLYUHRw2quEgBH6q
 LC6fZHPhs0REgff4ycFoRIe+YyNowiy63LLq7Q+DUlZ0JF6vwt8D4J+mr8HDVm3W9s92
 tuLvhpev0/u2jp+q6AYKAq75hbYKwByDcGEuGWG2xzysEnmnsBnEJEZAnXGmgRb06SzW
 R9JNhwoH/OM51/2p4jc2CRUgGXFg2rN4/HQpxfsNTxUBLzuyK47XC9Om60uQKKT2ty8K
 wQwg==
X-Gm-Message-State: AOJu0Yy/qx/kRvDKlbQdKZyMygUwmrAcdkw7SXLNNMRlZKiThI463mop
 sir8WuIHNSX3Y+ZNN1xXmKOvu3LAvRXSbzyH3Xj0LWRXmGN4TsSU8sMthL93CaHOjiaKPQVhVX/
 J7DuqR2xwqgFiQIrGPZzBHUWhdstnvqbU6E1g6EZCaVIdQV0tKEBWQafLXz2FEQqGefxdsys39V
 hOAQq7VNfl9tvydrUIKpv+y9QggcjGZA==
X-Received: by 2002:a05:600c:480f:b0:425:7ca2:68bc with SMTP id
 5b1f17b1804b1-4257ca26afamr61510435e9.34.1719929323129; 
 Tue, 02 Jul 2024 07:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwEwdqqCIGB/U31YgBC3pW0iSqSJSSCcieC0L/ueIKRAE23+V08HPF1gLd8tQ065sP4jEahg==
X-Received: by 2002:a05:600c:480f:b0:425:7ca2:68bc with SMTP id
 5b1f17b1804b1-4257ca26afamr61510085e9.34.1719929322460; 
 Tue, 02 Jul 2024 07:08:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8df0sm13422689f8f.29.2024.07.02.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 33/91] hw/misc/pvpanic: add support for normal shutdowns
Message-ID: <6269086b0179e3d70750672174ed7fbd29ac7eaa.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-5-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/misc/pvpanic.h | 4 +++-
 include/sysemu/runstate.h | 1 +
 hw/misc/pvpanic.c         | 5 +++++
 system/runstate.c         | 5 +++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1e5b20e4ed..9a71a5ad0d 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,7 +20,9 @@
 
 #include "standard-headers/misc/pvpanic.h"
 
-#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
+#define PVPANIC_EVENTS (PVPANIC_PANICKED | \
+                        PVPANIC_CRASH_LOADED | \
+                        PVPANIC_SHUTDOWN)
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0117d243c4..e210a37abf 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -104,6 +104,7 @@ void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
 void qemu_system_guest_panicked(GuestPanicInformation *info);
 void qemu_system_guest_crashloaded(GuestPanicInformation *info);
+void qemu_system_guest_pvshutdown(void);
 bool qemu_system_dump_in_progress(void);
 
 #endif
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 4b2307d2c2..3b893340c0 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -41,6 +41,11 @@ static void handle_event(int event)
         qemu_system_guest_crashloaded(NULL);
         return;
     }
+
+    if (event & PVPANIC_SHUTDOWN) {
+        qemu_system_guest_pvshutdown();
+        return;
+    }
 }
 
 /* return supported events on read */
diff --git a/system/runstate.c b/system/runstate.c
index ec32e270cb..fc49fd3e61 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -584,6 +584,11 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
     qapi_free_GuestPanicInformation(info);
 }
 
+void qemu_system_guest_pvshutdown(void)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (reboot_action == REBOOT_ACTION_SHUTDOWN &&
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED39C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZWW-0000nP-6Y; Tue, 04 Jun 2024 15:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWU-0000dH-GN
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZWR-00013B-Mz
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnECcJhOM1bFNsQiTjayj70I6F2El0gKTbsx9XEyPm8=;
 b=JlB9tuRJFtezEzdfjtbpVKR16tWexPMRo/ljLhIWpjs3NPZhGLQ2LJ8fajtlbFRTKIOzaU
 pKEHS82vuI8QnHwmZuPHuPKh+JGpyK9/buXEBIPgZbZjr3HAxy35vvCln6xIguCV8Mdd8J
 Xg+AIHF6vaM5qoeXk86DUIflwWnlzWo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-34O-fepoMBWPEade60oh2A-1; Tue, 04 Jun 2024 15:08:34 -0400
X-MC-Unique: 34O-fepoMBWPEade60oh2A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so3576732f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528112; x=1718132912;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnECcJhOM1bFNsQiTjayj70I6F2El0gKTbsx9XEyPm8=;
 b=nohW4MMxMK36HG5geskkfg2VPVzGt9qR6QdTzl6P6/2q+eN9w3u3LhXkD8Ae42zA2g
 5eBQTSlC/pVqwLSR5Hhg2oRm8MvQ4rik6xo5YLjp8+GOowuJsSrjDjOOX/3DeowtdC58
 0G+cgsDF2q6R0ZwbNkySYygdmf3IX+/FzR6pttIBPT53920/7ZuSUo9YFPrcshclSLsb
 314cAwIP0QEXnX6aVvSKRuHswhIDLGtL1DH6t/lPOGDk3Qreh28xSf54ZXVOOh6iRm6v
 NPKIGdEibm30iF2vrIOxW+tUwcksddvUTvY5bIcXIOTZoVZCoG3Jt38g6T1RkYX4M3cY
 3dAQ==
X-Gm-Message-State: AOJu0YxH9yWhjw0MFfvBftGKlupJGAd2OdtNKIca989dnFlQbT5mgaTC
 +ik1U9hVpFf6epr/vExi3k1pNa1NGTI4yZV3W4nDydGnzDZT81epIk9igZsb5dT3xGCvZ+tATtP
 bHlyOlwm5WOyG8bNLkazqdJDVEvf6rgvrsHYmosQ+2ykxreoM39Ux1KzyI55jpssJgMqhveyvrx
 ompwLh6n3lQgh5oGRxwnC8jblmpDblNw==
X-Received: by 2002:a5d:5547:0:b0:351:c2c1:3682 with SMTP id
 ffacd0b85a97d-35e8ef88819mr219858f8f.62.1717528112574; 
 Tue, 04 Jun 2024 12:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUe/05riaI93Tr7ecHCnVKR9zamdf7wFxYfyvAJQv2XgwMbtYFffNwBaY+vF+715VTnaboQ==
X-Received: by 2002:a5d:5547:0:b0:351:c2c1:3682 with SMTP id
 ffacd0b85a97d-35e8ef88819mr219835f8f.62.1717528112070; 
 Tue, 04 Jun 2024 12:08:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04cb1e7sm12358946f8f.43.2024.06.04.12.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:08:31 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:08:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 41/46] hw/misc/pvpanic: add support for normal shutdowns
Message-ID: <cd9439cc0fad8234d078ef119eb9a361ac7163cb.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 947468b81b..04986537af 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -20,7 +20,9 @@
 
 #include "standard-headers/linux/pvpanic.h"
 
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
index a4982cc592..0e9505451a 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -40,6 +40,11 @@ static void handle_event(int event)
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
index cb4905a40f..83055f3278 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -585,6 +585,11 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
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



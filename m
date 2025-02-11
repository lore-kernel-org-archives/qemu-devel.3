Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C138C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz69-0005eB-OQ; Tue, 11 Feb 2025 17:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz63-0005cW-Is
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz61-00053c-RO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNdOQtXSD/YnuXud8aU8SilNqnqdx7h5sqLzM9zGUhg=;
 b=XIz4NttMNWifwKLwv1OGKOf+2P7qPIMwB0A9ABLHk7167oEWs82bgXxLQQC+oYMzP8/Exk
 E0xHfkl+Ku0s/AenFf8hdxLcB9R+ZNglQZ9UAO9inT8oIiJ4esmI/DHs6xvMvP/ytPG8/a
 oUl3jeYJkV10vWXbhehxCCoukktsROk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-hmyZV6MlPWq03kcOmR3iJg-1; Tue, 11 Feb 2025 17:51:12 -0500
X-MC-Unique: hmyZV6MlPWq03kcOmR3iJg-1
X-Mimecast-MFC-AGG-ID: hmyZV6MlPWq03kcOmR3iJg
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-726d5bafe5cso954111a34.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314271; x=1739919071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNdOQtXSD/YnuXud8aU8SilNqnqdx7h5sqLzM9zGUhg=;
 b=CBACywkvaI/dZf4al1vFLhzACFSxH+7/Qdzb6Q2lqvO9qVvfeUOApHahWNQS/EnweY
 88tV7HFNtd9pEHXhtvtAqqhk+J8b+mdkvZuaa235b3Pr6EHtZFPqxrO7O/fPAvSXCk6U
 mFGr7Cj4yg3HGZjuP/kMrulGGC3f6RNs+Owd2MBLFrPr9hX6gppzFoqvPIqg2MJix3Ah
 /6QQsBogWf4g8n3PtRfZPuWV/pWm3RbEl0SnI2+Gg5g/U2DQISa8ExsQqPoshGLsu2u9
 l0GPe4w0M1ihBHl19lwkn0OAEQ3pJ2BXuEqZTWDkTDhb9AObGHccJaI47nE9yF+M2mWK
 eRng==
X-Gm-Message-State: AOJu0YwRSrYZUxuekoDNFgbM2rUjrbz1OVZG2Jyl/WssulBcskGYfJlK
 lqqqhMslTQWLWAvgOADNyP37lsrt1TSKvCEBkLCXkNiD/1/K6h1qwJd3l4hzlQUrfH0+9eGcSdT
 hhEOqIt2rsyBJuvcdXGRBbxF/cS3yDOva0F+lAW9duqMTaEageJUs8x80zjiS7HWxLE1kFmDmTT
 Pz2qkoKVt5gKW8wPG1XhVgewmY9FUcJzduTw==
X-Gm-Gg: ASbGnct8zRN1f3c+jkeHONgsx/HbFJ7dJ3haWvRR5a8xMtyssidtQmTNxYBgCFlqxW4
 zmVDu33tObMUFCn+YB/JKNzI94xTaCp2rhgOYEy+mjrpDLdnF0TPsOxLAJry+YyYhgwWh6slu3p
 fzR/x4JIeaiVfKMGFedLfBxvNP3/F5BMdRj9XcqbgAnt3QbEtd9xiv9W+Bq7NWwy0Jnqfm1vJO0
 nFABEdFNggpgXmvYL79tpHOSW1lt5IG4gUZqbHPh2mmpdFCjVRlQKUM
X-Received: by 2002:a05:6830:6d85:b0:71e:1c5:4f7c with SMTP id
 46e09a7af769-726f1c47a12mr846461a34.14.1739314270817; 
 Tue, 11 Feb 2025 14:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXgyCV7ZKA+fjyxoQXVJDw2kFDFr8i8zE2S2cyXg140jCZbOwWKhQFZVhBhjrEaDi8yjBa5Q==
X-Received: by 2002:a05:6830:6d85:b0:71e:1c5:4f7c with SMTP id
 46e09a7af769-726f1c47a12mr846443a34.14.1739314270367; 
 Tue, 11 Feb 2025 14:51:10 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 04/14] system: introduce a new MlockState enum
Date: Tue, 11 Feb 2025 17:50:48 -0500
Message-ID: <20250211225059.182533-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

Replace the boolean value enable_mlock with an enum and add a helper to
decide whether we should be calling os_mlock.

This is a stepping stone towards introducing a new mlock mode, which
will be the third possible state of this enum.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Link: https://lore.kernel.org/r/20250123131944.391886-4-d-tatianin@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/system.h  | 10 +++++++++-
 hw/virtio/virtio-mem.c   |  2 +-
 migration/postcopy-ram.c |  2 +-
 system/globals.c         |  7 ++++++-
 system/vl.c              |  9 +++++++--
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/system/system.h b/include/system/system.h
index 0cbb43ec30..dc7628357a 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -44,10 +44,18 @@ extern int display_opengl;
 extern const char *keyboard_layout;
 extern int old_param;
 extern uint8_t *boot_splash_filedata;
-extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
 
+typedef enum {
+    MLOCK_OFF = 0,
+    MLOCK_ON,
+} MlockState;
+
+bool should_mlock(MlockState);
+
+extern MlockState mlock_state;
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b1a003736b..7b140add76 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -991,7 +991,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         error_setg(errp, "Incompatible with mlock");
         return;
     }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fc4d8a10df..04068ee039 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -651,7 +651,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_fault_thread = false;
     }
 
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         if (os_mlock(false) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
diff --git a/system/globals.c b/system/globals.c
index 4867c93ca6..adeff38348 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -31,10 +31,15 @@
 #include "system/cpus.h"
 #include "system/system.h"
 
+bool should_mlock(MlockState state)
+{
+    return state == MLOCK_ON;
+}
+
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout;
-bool enable_mlock;
+MlockState mlock_state;
 bool enable_cpu_pm;
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
diff --git a/system/vl.c b/system/vl.c
index 72a40985f5..2895824c1a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -796,7 +796,7 @@ static QemuOptsList qemu_run_with_opts = {
 
 static void realtime_init(void)
 {
-    if (enable_mlock) {
+    if (should_mlock(mlock_state)) {
         if (os_mlock(false) < 0) {
             error_report("locking memory failed");
             exit(1);
@@ -1878,13 +1878,18 @@ static void object_option_parse(const char *str)
 static void overcommit_parse(const char *str)
 {
     QemuOpts *opts;
+    bool enable_mlock;
 
     opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
                                    str, false);
     if (!opts) {
         exit(1);
     }
-    enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
+
+    enable_mlock = qemu_opt_get_bool(opts, "mem-lock",
+                                     should_mlock(mlock_state));
+    mlock_state = enable_mlock ? MLOCK_ON : MLOCK_OFF;
+
     enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
 }
 
-- 
2.47.0



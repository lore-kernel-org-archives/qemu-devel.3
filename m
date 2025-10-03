Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD70CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huL-00050h-0D; Fri, 03 Oct 2025 11:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htY-0004lP-Ku
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htI-0007aq-5G
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUAG8VWvxwhXQ02nBq6hxNJFTKGhpPmcCRapw0hlqLU=;
 b=Hu7TQHBzB9afcOJKR54WZqmXn5daCvasPX1SkJo5V6WFBGMqZXj+4TDDAELkwahCX0OAph
 nDOeUOKk5PapHRJI5XAuRlGFPFVN1rMD69BvBjMkr309Gji/8ybQxpPbsX3gg+g5goQsoU
 N+v/kkafhNvFXn38AujxvQPHicaTSxY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-sEHo1ZyAPviN7eruqHWvHg-1; Fri, 03 Oct 2025 11:40:05 -0400
X-MC-Unique: sEHo1ZyAPviN7eruqHWvHg-1
X-Mimecast-MFC-AGG-ID: sEHo1ZyAPviN7eruqHWvHg_1759506005
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8741223accfso49080536d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506005; x=1760110805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUAG8VWvxwhXQ02nBq6hxNJFTKGhpPmcCRapw0hlqLU=;
 b=DWNSV4hZkqErJyvqIu2loSaOBaPi3yLh7dyH/ZlyplOaJFS67/HqnQd9UQuMC+l+iC
 fZzQtlX9z+YIHarPFmdd9XGwvU8iXaXxrbFmhrRuB0nEVQkLN0IsLa9ctrLacxUXyo4d
 nWCuznikewRxO2eEhfKKEnPSQq+zqx4Qc59Yglp+t66aum5YLHfaM9SG5hqx7daXO82i
 eijWkMW7xWdxZgYmKASqFd2zj8q7K7Hba80T++jtE4A8L5PddJx2H8LGfdgpbFm02uU1
 K9mEHK6OEwK4ZgKYCJdoSEM+dT11iWncY8xjVUAffaiepEep7VUw0Q1BZktu1YE7o7pi
 I6eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvgmSQgzZWacI4bE+ZmxmpASGKzQ9CnkUYhjYi3bNXliwXOWQi+81tVAQCRUcz7JDiey9KkAiwyqTT@nongnu.org
X-Gm-Message-State: AOJu0Yztg2QfNU7uUGQmtdLV7HzNj/q5WzALkqhInRpgC1u/ls2b17B8
 SB+cby6D4R9CVCw1h4NS7YE9uUJ/UFogkSqdJvyYPGBkKmjoOsYGnRaVYxroCPsQ0oKvUXdTXov
 Il2wCEsTjjVgxxfoh4/8czlGuopALR/nrzTAHoppaKRsZjNGTgaoadzJx
X-Gm-Gg: ASbGnctGbtzRRFepXnIcJ+SHhLxZxJXKuF6erORahoI8ZnfVhdeGxLAkHtDBBLiQdfv
 8od4nViGVDL2jse2VfgLbeQN+VkI+nznH0GpZFbmvglMn4d6TGFB57FsScmRcpR0Egk9wBfdqcJ
 ruPPGg5ulFhs4kBWZwqlAKjZ8O2njqq93Kh4HGsDTo5qCzHmvj+uBmpjy7NUuG7DCTCMXF+YK/9
 FNi/SpgHxunIDwCWEBJcjLjLHc+W9nK/29kL99jgeRF+hkzazIgLVeuKPcuPgH83Vs45l6IFgFP
 eqHaBmwLWV3ku0QLezMPUneQfP8SLf7vmCfqgQ==
X-Received: by 2002:a05:6214:da7:b0:7e9:bba6:511c with SMTP id
 6a1803df08f44-879dc77c3f0mr46511226d6.5.1759506004915; 
 Fri, 03 Oct 2025 08:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/KARgAXi/APAZXZ59HqRHVZfRcxk5jaQgeNwvBvknWUTUDeOZidF6JrAF2glQlntSlA4O5w==
X-Received: by 2002:a05:6214:da7:b0:7e9:bba6:511c with SMTP id
 6a1803df08f44-879dc77c3f0mr46510806d6.5.1759506004388; 
 Fri, 03 Oct 2025 08:40:04 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 08/45] migration: push Error **errp into
 qemu_load_device_state()
Date: Fri,  3 Oct 2025 11:39:11 -0400
Message-ID: <20251003153948.1304776-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-8-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h | 2 +-
 migration/colo.c   | 3 +--
 migration/savevm.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index b80770b746..b12681839f 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
diff --git a/migration/colo.c b/migration/colo.c
index cf4d71d9ed..a426ec5b60 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,8 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 88116ed278..9e30718995 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3264,7 +3264,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
@@ -3272,7 +3272,7 @@ int qemu_load_device_state(QEMUFile *f)
     /* Load QEMU_VM_SECTION_FULL section */
     ret = qemu_loadvm_state_main(f, mis);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_setg(errp, "Failed to load device state: %d", ret);
         return ret;
     }
 
-- 
2.50.1



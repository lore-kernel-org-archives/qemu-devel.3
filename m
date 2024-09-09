Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE25ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snelH-00017q-4L; Mon, 09 Sep 2024 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelF-00013E-Bk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:57 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snelD-0000B9-QZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d8815ef6d2so3153166a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889734; x=1726494534;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDNjzZDuWCBsPbd7tcy7/yK9DFVnmavsqu74xEof5CQ=;
 b=jvVOkDGIq1Z0mzWc9HIvoQ24DF+wTSZBcrZAJoE5shwkoj6XRGKXBNAyiyWbPex+Tv
 4w+4GNhdPP5iDvd5rV3HE1wAgALqyqUTcRdVYoNLkk2NWA3PteE6Gx/Drw7/qLDaOGr8
 9Ow7ljJ4yTyJEUzU+PJsJ2tk29MlM8gvOD9DWCfkCpQybcFK53j2oJQjxTWcYUAMY/dl
 SJTOqQCBSYTvjIKIi6JXkEXS79UgpfcuHxsggCQkxiYgJAwDkDKfAmFfoIDx/HM0Z2nz
 aYU39U9PQtpgN5X359Lo6Y9fg0mqQeWGPKSHOiwwYNprZGUfgI+WMqvIG8LuUxIRuOBT
 0Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889734; x=1726494534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDNjzZDuWCBsPbd7tcy7/yK9DFVnmavsqu74xEof5CQ=;
 b=GSUPopTM36adQwaSd/B99+hsodwYh8IgRiKNJfeosmU98FrdBShMESlVVDABK8NFxB
 s4DLSgvyie7nWUQ6WtMa3xYILV/Vrul+U/7Z3pxFjBWjdVr5SctxotbYcyOCMwcfJW+/
 MQJrJwa9Qcy3geNClMK7PQl+VPnT6m70q7E8APEskqNOZQjgQ31NChB7H2iobhqnUZPq
 gjilat0HMdo3MONFB4ATfJVeaLFWuHyfCIdcRg/UjGeAdZri77wCWymgYX4d0TFObS4h
 5Hns15VzqjIeReN8Mdp/OMbOOqOZSg/nDddfq91pZl0uFXFw5ojP0jVca/D4H9qpiob+
 2RgQ==
X-Gm-Message-State: AOJu0YwrpXdCDMfN0lykaIr2EFbfqXfqeOQko14QIXWECQj/J2GcFdyg
 f7yaJFDZaSXxIO/bRpzd+aNVqgJN+5OsaK/TsnWGVAXpb97rcZljJ8AykBOs6l8zvJAIlKkVxh/
 vbrDxSg==
X-Google-Smtp-Source: AGHT+IFTdRMIzH1GiH5spX+qhhyuT6ezfRw/SFBJVv8ypkWM/WD1opAIgqASUIbTxg3nBRqN6tsj+w==
X-Received: by 2002:a17:90a:7c04:b0:2d8:9255:396d with SMTP id
 98e67ed59e1d1-2dafcd5c767mr8829709a91.0.1725889733775; 
 Mon, 09 Sep 2024 06:48:53 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:48:53 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 06/10] migration: Support periodic CPU throttle
Date: Mon,  9 Sep 2024 21:47:18 +0800
Message-Id: <5ee66750057034adba99696a450aa676fd0cedb3.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725889277.git.yong.huang@smartx.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When VM is configured with huge memory, the current throttle logic
doesn't look like to scale, because migration_trigger_throttle()
is only called for each iteration, so it won't be invoked for a long
time if one iteration can take a long time.

The periodic sync and throttle aims to fix the above issue by
synchronizing the remote dirty bitmap and triggering the throttle
periodically. This is a trade-off between synchronization overhead
and CPU throttle impact.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 055d527ff6..fefd93b683 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1420,6 +1420,9 @@ static void migrate_fd_cleanup(MigrationState *s)
             qemu_thread_join(&s->thread);
             s->migration_thread_running = false;
         }
+        if (migrate_periodic_throttle()) {
+            periodic_throttle_stop();
+        }
         bql_lock();
 
         multifd_send_shutdown();
@@ -3263,6 +3266,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
     if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
+        if (migrate_periodic_throttle()) {
+            periodic_throttle_stop();
+        }
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
@@ -3508,6 +3514,11 @@ static void *migration_thread(void *opaque)
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (migrate_periodic_throttle()) {
+        periodic_throttle_setup(true);
+        periodic_throttle_start();
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-- 
2.39.1



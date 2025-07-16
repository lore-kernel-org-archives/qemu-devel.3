Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F8BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfl-0003aJ-9o; Wed, 16 Jul 2025 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcf-0006lZ-RK
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcd-0000Jt-Dg
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2a5tw8IqJQkx1W5/iPw1LFqBppqgHUzfT4VAAtADvY=;
 b=f7/xFNGP1Tus+I1I3rLwcEbOGbeIkavCkh72OYCNlBqfGddQyKDPUpMg/uSf3UNH5m/v9w
 8wv6TKfnSf/JDwVji4TXNq+12AyOIX3pm99HF9Gn+rHkKsu0upAAa/KO24L2VfrZDAQGr/
 wqI3BtVzhGsdCx/BX1kJ4+IRuxibGWY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-lXHJbm-JMLqOvmY_499ylA-1; Wed, 16 Jul 2025 06:44:20 -0400
X-MC-Unique: lXHJbm-JMLqOvmY_499ylA-1
X-Mimecast-MFC-AGG-ID: lXHJbm-JMLqOvmY_499ylA_1752662659
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2369dd58602so62880425ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662659; x=1753267459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2a5tw8IqJQkx1W5/iPw1LFqBppqgHUzfT4VAAtADvY=;
 b=kQuSGr9ZFDAZ+otmfb2mmDLEJLUgBpwziySncRdx07C75VTARCOunngp2sXh/GHi4C
 x0v0HkH4GlKpERn1QhGVPVjM82aDaskdLxw6O9jasM1vh3NQTpUuoU9JABqUUuZjKsJJ
 TzSMmVtkO1npDvm2gKsSz6T6VCScOdxfNKmp5rhqvlkQcprLE6M5mQ3NwVOXTFktwALA
 MSrIkcQh9SOQ3J909IlOTddnjj7zBtztfmW+vT1S9smFHSsZxstkwT2k0KwtI+ePejFn
 saVA5mGQWWsvL62ZbcLGJ82nu+xUi5J/CyjfRnV+9gHW3mCM5SUOrwnyD0Npzx3UdKRA
 RBdg==
X-Gm-Message-State: AOJu0YxUf1LfKFsenqbc7PgsSpCrrM0lGaZhuNKwQGCYEpxA6mXeNUfY
 HJHmkx+LIBMhtwRZ/J7GNiJ7j/rRt4mu2GiTVh1W/lXxMQEVNJvDTzVX12+p3BMVdynUD889inN
 C/KH5SOxYuxNxY+lpL2w1sawD6r2x7/ZPF2DXsfJE/16FaUGYSoPGJuIY
X-Gm-Gg: ASbGncvPGcqFvwiXc2Au5TFFwF0tplN5I5Z6a9GdBTCtXjsL7VjfB0/eRUkXGmcxTFa
 iIn4lo16BN6rbjEzNkKg9+xKIZw1QhN0fruYPPTVIeFVK99Dl34BNEI2Ui5jBhXW982NjUdkf4z
 1qiD8C6w8DDm8Jr80spL9Kewct5syKmnoeK+DJv4LQQ7m59PAaE7Oz+ayEpX/MC6QHBWHWI/CpS
 W44t0/riYMMMY2iPS8KeQ7wfLVNUZMdN6OIE+TdRSoXRZU4yS454CVKwtXKfXSK8HyzB3izzhF4
 VFmJoqpL+40MAjstKJ/R/GXVy2eloCTloARQ25sa5MtCQFnK0g==
X-Received: by 2002:a17:903:8c8:b0:236:94ac:cc11 with SMTP id
 d9443c01a7336-23e2566b0d9mr31442045ad.7.1752662659470; 
 Wed, 16 Jul 2025 03:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX/NX0a/DcLZP0ru60DXbcoablpNSaTwXO8u0ozgxChj1iB3TOoNoRQBxZBbBnHON1LSfrug==
X-Received: by 2002:a17:903:8c8:b0:236:94ac:cc11 with SMTP id
 d9443c01a7336-23e2566b0d9mr31441325ad.7.1752662658848; 
 Wed, 16 Jul 2025 03:44:18 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:57 +0530
Subject: [PATCH v4 07/23] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-7-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6916; i=armenon@redhat.com;
 h=from:subject:message-id; bh=D9SdWZhMHR9koECrEazRfKMv4X4h0TvPBviqsW0QvPU=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k73KokNz3bj+Hg1e8TJCsfXw1P4fXXtm/gw5d+HV9
 PwfO3crdZSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZgI13SGfypNF95snOMnNNnJ
 6uzRC7JM99P+R25gMDq+TtdeYtLhy1qMDH/K2EvWf191umn1RU6XSPnjU1Yl/9uw0u9ggcelTbe
 nKzIAAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_process_command() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 95 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 24 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 22d73999595384519c755c9416b74ba1263a8bb9..e40e67b43166d11cd417c17d1c387a1effad41b7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2540,32 +2540,35 @@ static int loadvm_postcopy_handle_switchover_start(void)
  * LOADVM_QUIT All good, but exit the loop
  * <0          Error
  */
-static int loadvm_process_command(QEMUFile *f)
+static int loadvm_process_command(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     uint16_t cmd;
     uint16_t len;
     uint32_t tmp32;
+    int ret;
 
     cmd = qemu_get_be16(f);
     len = qemu_get_be16(f);
 
     /* Check validity before continue processing of cmds */
-    if (qemu_file_get_error(f)) {
-        return qemu_file_get_error(f);
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        error_setg(errp, "device state stream has error: %d", ret);
+        return ret;
     }
 
     if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
-        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
+        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
         return -EINVAL;
     }
 
     trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
 
     if (mig_cmd_args[cmd].len != -1 && mig_cmd_args[cmd].len != len) {
-        error_report("%s received with bad length - expecting %zu, got %d",
-                     mig_cmd_args[cmd].name,
-                     (size_t)mig_cmd_args[cmd].len, len);
+        error_setg(errp, "%s received with bad length - expecting %zu, got %d",
+                   mig_cmd_args[cmd].name,
+                   (size_t)mig_cmd_args[cmd].len, len);
         return -ERANGE;
     }
 
@@ -2578,7 +2581,7 @@ static int loadvm_process_command(QEMUFile *f)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
         if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
+            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
 
@@ -2588,11 +2591,10 @@ static int loadvm_process_command(QEMUFile *f)
          * been created.
          */
         if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            int ret = migrate_send_rp_switchover_ack(mis);
+            ret = migrate_send_rp_switchover_ack(mis);
             if (ret) {
-                error_report(
-                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
-                    strerror(-ret));
+                error_setg(errp, "Could not send switchover ack "
+                           "RP MSG, err %d (%s)", ret, strerror(-ret));
                 return ret;
             }
         }
@@ -2602,39 +2604,84 @@ static int loadvm_process_command(QEMUFile *f)
         tmp32 = qemu_get_be32(f);
         trace_loadvm_process_command_ping(tmp32);
         if (!mis->to_src_file) {
-            error_report("CMD_PING (0x%x) received with no return path",
-                         tmp32);
+            error_setg(errp, "CMD_PING (0x%x) received with no return path",
+                       tmp32);
             return -1;
         }
         migrate_send_rp_pong(mis, tmp32);
         break;
 
     case MIG_CMD_PACKAGED:
-        return loadvm_handle_cmd_packaged(mis);
+        ret = loadvm_handle_cmd_packaged(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        return loadvm_postcopy_handle_advise(mis, len);
+        ret = loadvm_postcopy_handle_advise(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        return loadvm_postcopy_handle_listen(mis);
+        ret = loadvm_postcopy_handle_listen(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RUN:
-        return loadvm_postcopy_handle_run(mis);
+        ret = loadvm_postcopy_handle_run(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        return loadvm_postcopy_ram_handle_discard(mis, len);
+        ret = loadvm_postcopy_ram_handle_discard(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        ret = loadvm_postcopy_handle_resume(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_RECV_BITMAP:
-        return loadvm_handle_recv_bitmap(mis, len);
+        ret = loadvm_handle_recv_bitmap(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis);
+        ret = loadvm_process_enable_colo(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_SWITCHOVER_START:
-        return loadvm_postcopy_handle_switchover_start();
+        ret = loadvm_postcopy_handle_switchover_start();
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
     }
 
     return 0;
@@ -3071,7 +3118,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            ret = loadvm_process_command(f, NULL);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;

-- 
2.50.0



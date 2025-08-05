Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C9C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMOv-0005hD-Sr; Tue, 05 Aug 2025 14:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOu-0005ZM-6F
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMOs-00040Z-17
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0CSvOMmMk3IlQEx5JPsVH2du0++r9yoOjuPUwP+vLk=;
 b=AN0vq0zAGwTmSgFgdsdHgmePfAwX464th3Lf2DV3mquuYBRlR5uR1YDy8Yxv1lX7uYCizP
 BaNM98yHIOsKhV2Bp7zXzJTaWPJg/dOSjFF4YkuWpMvMbV7yRru6a21LkFcQcJPKO9KjLP
 4A/jpfTRGTN/L2EFz69PyfjDc8Aij9c=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-_3uFC-KuPFq4bJzy82chHQ-1; Tue, 05 Aug 2025 14:28:36 -0400
X-MC-Unique: _3uFC-KuPFq4bJzy82chHQ-1
X-Mimecast-MFC-AGG-ID: _3uFC-KuPFq4bJzy82chHQ_1754418515
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2405fdb7c15so83966795ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418515; x=1755023315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0CSvOMmMk3IlQEx5JPsVH2du0++r9yoOjuPUwP+vLk=;
 b=O2GtLY9XDQN3XXBwtDRrJcyWg3VV1Cg8f73MlH/0QDajt80UDZLz/1ku3wIpqXOkBv
 QQNaH7q8w+Ir5jxz/s/PAy5lzYC+4srUQwGj5GwYImIbasJj0EhNPqnoezQU87yuPA1f
 3j/dV2HWS+wxMiDSQK5aYfT4rMn5hL6I5ZECLppwfFJypP+xry68Evde3XyucaDSDKvJ
 b8CP/1SDxxbvf50pr9Em40Pd7vy4q5zYN8rJ3d6VGXkCqdTfWxqAsmaqtGOXAX+pdQXO
 LVKegqwphhgMmIzzyYRf9vz5fITWhyDK34yrEXS2h6VCZmibmlRT+aN0svZxcipQaGor
 SbNQ==
X-Gm-Message-State: AOJu0YxG1ThHjDuQ5DzIZbcGMSRjTsjigbX4/Qd7Dj6O66TtAcl+dmoQ
 YZJOhUT//sXRIfg/Y80hfzyXEm2+n7SA9J+5bFg+vKJ6/niOgn1G5Ggk42EhxHVrWU9/4zHAtkV
 6MhnOWB3hvCz69y+/PlCDUDK18hrH0m74H0MpdEntz/V45txM3mIlcWs/
X-Gm-Gg: ASbGncuLgNBjE1/4dU2bPbS89TMF50KiUX4SXsRbwfiU/OTReBYydmVbVRRLdTyiIK2
 qc/GexGP8kd8LVaSn8jifkLX00V0aoetU3expStcPDdO/Eob1G467jUoZOU98XTDAAyT+R3z9Iq
 ghjsjjr+omQ9oPqnG+/Sb9WJpK+yY+rVgMWSWWMJYI79ISI3vrsDW2goieKjOBiRzEy5U3qiStL
 sZmA6dkE1naeutmX14u/sSK0VDPQYOX+MbsuUtXWLoqLEpgYUG3xHXErUs2+W0JA3odhyicOAu8
 DgJLO76UEhiupNAtjCATENxNdl+XNw0f3/Y7R0PlNJXfNQ9VJw==
X-Received: by 2002:a17:902:fc8f:b0:240:6d9b:59ff with SMTP id
 d9443c01a7336-2429f5339b5mr921055ad.33.1754418515010; 
 Tue, 05 Aug 2025 11:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJo4zYf6NpXRqsPctwOgU3C0xkrN1SOKVanbdvkFnt25uMF/pL2eT082Mgu1u280yzx45s0g==
X-Received: by 2002:a17:902:fc8f:b0:240:6d9b:59ff with SMTP id
 d9443c01a7336-2429f5339b5mr920665ad.33.1754418514453; 
 Tue, 05 Aug 2025 11:28:34 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:28:34 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:12 +0530
Subject: [PATCH v9 05/27] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-5-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5991; i=armenon@redhat.com;
 h=from:subject:message-id; bh=UIqb3XXgYCscHZa+E3ALtPgpyS8rgvx+ZLuTMghjItc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+nQo13nKvVLz56K6il0MjDS9Dp74t3Ji5vVU9ruO
 8w9wn6vo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQ2CDMyvPeb6LWhyGnSqm62
 /NlKkWJfkrJMxeOyM3bMTW+IqfJ5y8hw94C95x+TU7cWqE1ae1jl3oFCoZDjDNtf/+Jm6s9yzZV
 iAwA=
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 72 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f37c4455dcf839d46f026fc7c7ff02e2dfffe7b4..cb673f43b174249ff1525dba41284de2e5a70735 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2546,12 +2546,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
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
@@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
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
 
@@ -2594,11 +2595,10 @@ static int loadvm_process_command(QEMUFile *f)
          * been created.
          */
         if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            int ret = migrate_send_rp_switchover_ack(mis);
+            ret = migrate_send_rp_switchover_ack(mis);
             if (ret) {
-                error_report(
-                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
-                    strerror(-ret));
+                error_setg_errno(errp, -ret,
+                                 "Could not send switchover ack RP MSG");
                 return ret;
             }
         }
@@ -2608,39 +2608,71 @@ static int loadvm_process_command(QEMUFile *f)
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
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        return loadvm_postcopy_handle_advise(mis, len);
+        ret = loadvm_postcopy_handle_advise(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        return loadvm_postcopy_handle_listen(mis);
+        ret = loadvm_postcopy_handle_listen(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RUN:
-        return loadvm_postcopy_handle_run(mis);
+        ret = loadvm_postcopy_handle_run(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        return loadvm_postcopy_ram_handle_discard(mis, len);
+        ret = loadvm_postcopy_ram_handle_discard(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
         return loadvm_postcopy_handle_resume(mis);
 
     case MIG_CMD_RECV_BITMAP:
-        return loadvm_handle_recv_bitmap(mis, len);
+        ret = loadvm_handle_recv_bitmap(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis);
+        ret = loadvm_process_enable_colo(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_SWITCHOVER_START:
-        return loadvm_postcopy_handle_switchover_start();
+        ret = loadvm_postcopy_handle_switchover_start();
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
     }
 
     return 0;
@@ -3074,7 +3106,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            ret = loadvm_process_command(f, NULL);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;

-- 
2.50.1



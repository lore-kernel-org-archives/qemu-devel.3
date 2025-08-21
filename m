Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BB0CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0wA-0003PF-Ps; Thu, 21 Aug 2025 04:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vW-0002kx-Gn
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0vN-00012G-1e
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755765930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDzZ3jLmjLq4zR5L7CS7sNKY+qcglyAmxa9VpMAftIc=;
 b=R7fsNAJRRjc16B6g6VBOarWVuQVmWQu5VXOBBQXrT4vEGtWHUi384hozV5I/x+b3INW+Bj
 QgKLWlf/Ww00BNDVE/lVQcDowjpg8KJn9PPNitX1TrncRnuQ/Gndfa1Befi9b0pm54vPIZ
 adF6xxnKx9muNn3aBZqinrYz8AD+0js=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-bZcwWxxbMoyg-BgEm2sK_A-1; Thu, 21 Aug 2025 04:45:29 -0400
X-MC-Unique: bZcwWxxbMoyg-BgEm2sK_A-1
X-Mimecast-MFC-AGG-ID: bZcwWxxbMoyg-BgEm2sK_A_1755765928
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24457efb475so9836235ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755765928; x=1756370728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDzZ3jLmjLq4zR5L7CS7sNKY+qcglyAmxa9VpMAftIc=;
 b=Mwl0jLGWIzGS1yXP3byjKXUU2bpCE3QnobxSzWaP9SBK4J7XyCne+VuJVKsxR9t3S8
 Y1/EpZZkozt0UpTCp6M9bhHncmKiymQKiftI/UozcGD2bLw4Jnnrcxpw1UepMzwUirPf
 /Hw+HSl77vXd6VAvck2adSGVsyfxHlb2wBX42jTtLBXOfoW4gerS6f+Yhs+U4zXS4z+h
 /zOqLE73PfCglVOknORll7quCSAS0Nol+sFGoSD5BH+pVyq1BCROiABUEAAoougJ/AVT
 p3nAicyHbnyD0vOTc8hzjnFBCbGayRlWy8JLZDKVdmnw7ZqeQRY0gfsnG3GDuSGqQIP6
 flxA==
X-Gm-Message-State: AOJu0YzdyvhSfG1YGOfhZbPX5BBzVtCgqRoOKygIjw3q1eS1ooenhCbJ
 3vO7/OzlGL3GwX0e1S37wzlxM4qRYPI63YCXHKfmGtKgBG5ZNTlPNrZEdjxZY9qBk6llUnFHWlx
 O0EsfCj4Y7vFrovpcds5g25mUnqdu8WSK9rHz31tsZEC2eSotCuiUgdxP
X-Gm-Gg: ASbGnctReGZ252xHEArAvU31/kre63xabioHkBWu/9BQ5M8rAQ/mhzU6dK6mnZwVR/K
 wxWACNaj59Y/XyD8z6mg5IgMZr6U/VLROps7WhphQFBiIUw/KDfvGCLHgE3CaKefzKxr+svl9oT
 CZto/gw3fVWHNGDmllaIRE27OA/FJG1LvUlbr8NdPkaNLpFNxI3/+bRNKqAF/EQj5BzYL5poY+B
 qoMGmZkeVprLOcKQNFuVqmr3zHQQoT0pqAZdAxoKEhAzGLAaCDuA/E7asLV9bpM3GDs3a5JPx2q
 U8zr8ztfuelcwu7wBIVled4n+X4Eo6vhVekPVVusYtP0v4kPSfYG
X-Received: by 2002:a17:903:247:b0:240:640a:c576 with SMTP id
 d9443c01a7336-245fec05bdcmr29220485ad.15.1755765927797; 
 Thu, 21 Aug 2025 01:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/wTb8526bwoblrp05BKf/Mgks7TIcaPhesZoRxuJyHVFg5bB9PtHysDc3h8sInCKTBGAnhA==
X-Received: by 2002:a17:903:247:b0:240:640a:c576 with SMTP id
 d9443c01a7336-245fec05bdcmr29220005ad.15.1755765927399; 
 Thu, 21 Aug 2025 01:45:27 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:45:26 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:13:59 +0530
Subject: [PATCH v12 05/27] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-5-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7107; i=armenon@redhat.com;
 h=from:subject:message-id; bh=9AH9P1l6e8SvKKjcLovofmYalIjfvAfotsil7imy8QM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayO8kBTd3KRs1BZkkXlKZonwv56eDVu2i3QcWL+4c4G
 OZX7xftKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBEONUaGTW2Vtx8F3PmzS3yZ
 WcRz8XP31r6OnGiVbDj3kv/TizG8pxkZJv39Kvam8KX/jmdBurEnzI45rWD7wcbzak3y3aeanvy
 LuQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The errors are temporarily reported using warn_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 86 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e19156a280c00c5aead9ca84e143e6c7a7de7501..7575063ad3d421fccc041146891d9bd6f074e128 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2546,32 +2546,37 @@ static int loadvm_postcopy_handle_switchover_start(void)
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
+        error_setg(errp,
+                   "Failed to load VM process command: stream error: %d",
+                   ret);
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
 
@@ -2584,7 +2589,7 @@ static int loadvm_process_command(QEMUFile *f)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
         if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
+            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
 
@@ -2594,11 +2599,10 @@ static int loadvm_process_command(QEMUFile *f)
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
@@ -2608,39 +2612,71 @@ static int loadvm_process_command(QEMUFile *f)
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
@@ -3051,6 +3087,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
     int ret = 0;
+    Error *local_err = NULL;
 
 retry:
     while (true) {
@@ -3078,7 +3115,10 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            ret = loadvm_process_command(f, &local_err);
+            if (ret < 0) {
+                warn_report_err(local_err);
+            }
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;

-- 
2.50.1



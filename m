Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87696C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPr-0005QK-Hq; Fri, 25 Jul 2025 08:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPa-0004Wm-Ng
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPW-0000Ij-QC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBqn++2MW5CgMsUoX7jUMy5QHT44+8nhu2yUYnBnsck=;
 b=Aih2zvtrdd20Uym464+lcOotagvjprOUeyjJz9uo/7NhLYclOjapC5+6w90kaC5dCp9IbM
 HSQpjQ0O1DgTpiVctKrgZK7VmWrDAHBBZaPnhjRml1TwzWj28dYNfs50YJOrDKCBFivLFn
 3bbVo44oliPU2TeKSYYdKfZFozixioQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-9iKy4ARQOaGppFtXfkh13Q-1; Fri, 25 Jul 2025 08:20:22 -0400
X-MC-Unique: 9iKy4ARQOaGppFtXfkh13Q-1
X-Mimecast-MFC-AGG-ID: 9iKy4ARQOaGppFtXfkh13Q_1753446022
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b350d850677so1494994a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446022; x=1754050822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBqn++2MW5CgMsUoX7jUMy5QHT44+8nhu2yUYnBnsck=;
 b=FGC7PMl7rSxnncardesiI1P0ssHThZNJXI8lwC32p9vOXVmOALIfsd9Rx6hBeOhq5L
 X+Px3q3m4zKcchj7QUJhs4+wmFx6WoUJ9dQS+O7+83hTCx+Fto9ay2ms+C/RIC08zaxq
 ARS41uBqYg3wnLd+0QMN8ATM5Z/qCUtAURZsXDovDkvPQibGf6awzT6AQw06hBYYPsgn
 q16JV22cKkAiO97x0LRToP3l0PdK4C3/SRUTXJAgPoWrnCbkTjGoxcwOGEDMXhFUG1q2
 /sZa8rcerJ931PXdf413343AyT3TmtDjWrCAnwP4GA21zbkRK/HK6iJW1Bx/4hmLzGN6
 oQjQ==
X-Gm-Message-State: AOJu0Yx1rC0wndVF9pxiAze50+KuHzq6TTx3T6oaolOt6sHSzKl5f2KA
 eN5NHbEv0TZgozzi5kwCPEJ6SI9McfCQT0fFYl8MuWkfWCx0knQDKPuCVLTfVGp+ojLa8PUKE0z
 ent0JEdvRtW9iVI8kXx46f8Qcuy2s1Zm/tJM8Rolz6doVITCj8dygTpMu
X-Gm-Gg: ASbGnct902QzUHD3/68h0Nz4coAUjzgys/KBrnO6hejvRnnMI0SglQd7oNPHTVJ0osn
 peJyeUIQwnSLPXdipAsyAFyjdGGND9bvoFxqRCb2uv2DI6OdliCIK0YvHSghlAMzScfT9UNDmvz
 zz0nwWznmQ3Hn8G/p0Rzo+0/8Tqsxb1D7P5ZQ+VNsZwIJ51VKb13YIY0Ob7qGFJll8EmTVBM+kK
 njYpfqRZQG4Yqq+auNpv/Qh5WEZXVhLrNOoVplJov+ceGDftDyzlfhgGyGzTjDLutBAJRSLxxWF
 FkyMmIcBBzyO2WXLDbl2ajRXG+dALqAvaoegGA9hFHncgjTfo59ZKg==
X-Received: by 2002:a17:90b:1c85:b0:311:e8cc:425e with SMTP id
 98e67ed59e1d1-31e77a244b2mr2164691a91.31.1753446021436; 
 Fri, 25 Jul 2025 05:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZWG7KflaoWj8U9+Ck4vGNwXw8y9l0suX81jZ2TC7mNGMF6qGGTFZ14Vph+Hz8XgEefUYEg==
X-Received: by 2002:a17:90b:1c85:b0:311:e8cc:425e with SMTP id
 98e67ed59e1d1-31e77a244b2mr2164636a91.31.1753446020962; 
 Fri, 25 Jul 2025 05:20:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:48 +0530
Subject: [PATCH v7 09/24] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-9-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5986; i=armenon@redhat.com;
 h=from:subject:message-id; bh=FprjTTX7nqgDlqnlT/KZ4D6i55ecWLyKSTmKqntEOgs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc7fZx7laS9zDFTYnki3eqqv9E7zqThuqV+xwn9ai
 eiVc+IdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJvLXjpGhzSDkyx0OBe0zn1uU
 3UPcnvEma/xPOix1tUN+rUKk+55/DP/r1thc6loUIyvy+G11k8prBaapgk90lrd7Pvacr8P+9D4
 zAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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
 migration/savevm.c | 73 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ad96da3651b89023e4b70ffeecab46d176bae6f5..d40b25d74be46b209be8f28d10b7538a5ff2e3dd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2544,12 +2544,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
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
@@ -2560,16 +2561,16 @@ static int loadvm_process_command(QEMUFile *f)
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
 
@@ -2588,11 +2589,11 @@ static int loadvm_process_command(QEMUFile *f)
          * been created.
          */
         if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            int ret = migrate_send_rp_switchover_ack(mis);
+            ret = migrate_send_rp_switchover_ack(mis);
             if (ret) {
-                error_report(
-                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
-                    strerror(-ret));
+                error_setg(errp,
+                           "Could not send switchover ack RP MSG, err %d (%s)",
+                           ret, strerror(-ret));
                 return ret;
             }
         }
@@ -2602,40 +2603,72 @@ static int loadvm_process_command(QEMUFile *f)
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
         loadvm_postcopy_handle_resume(mis);
         return 0;
 
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
@@ -3075,7 +3108,7 @@ retry:
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D290CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rqp-0004MW-Ir; Tue, 30 Sep 2025 00:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rqf-0003sX-BO
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RqU-0002fH-7R
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVaUYKAjLKiIcqyYW2GBCIl4tQ6+if28k0KcXdOXb/w=;
 b=Eja7V9NKUNrP8Vw6S90omYGLomqLrRs56t3oRcBu6vHbluzWYgIVim08qMq34nbSdCoHAD
 2HxeBbFpDkh2TdmyhJL1YYqrF5I8DP/COWctS2on6SfcN3RWu1VhlXKyoesaHmuzy7HJJT
 ZPrJVQxeE8vNVOI2FqHZj40fM/c8wy4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qOVIYuh0MuOrAnSHEWJPRg-1; Tue, 30 Sep 2025 00:20:03 -0400
X-MC-Unique: qOVIYuh0MuOrAnSHEWJPRg-1
X-Mimecast-MFC-AGG-ID: qOVIYuh0MuOrAnSHEWJPRg_1759206002
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-78117fbda6eso4126981b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206002; x=1759810802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVaUYKAjLKiIcqyYW2GBCIl4tQ6+if28k0KcXdOXb/w=;
 b=oYgw1nkvjvd7OYIEk2yBUHe8U2eGtizaVcBQNBSNguLFgosOOzkLJs32Fb+00xgsrX
 gVc7EIyf714fPJHU9S2Ow7SXP/a6n0lZIXcISC96dYM/OvObikiWnNyYpynAeQUGFgWC
 AnQkhuzpbdCU6ooyj3PGrZyWRMRPTnnZ2E43bTGjPkymnpdEOEi4m2FLO7VBE+3yeMSO
 SHUMZTtNgTWzuLEUS+gYD/kLUnlQeotm9w0womSFX3n/9y/ZKPt+nUfrBV0DHy3HkH4I
 MWM0YRKTOlK6VQGPS1Q1s5nUvXN0fS5b15nsCB7Ag6CAtHdzsdmUsSrD4oyG5kqUPCxp
 ylXg==
X-Gm-Message-State: AOJu0YxhGLJG9s2Lcdcm6IGLV8UFHDknD+WvLU/j7G8F1Cw2HoYZIBoQ
 OQcosUSbTgOJUY13Fw6K+xICE9zWG/eYcQrNFUCmzp74Etqx3x9L13x8C0+5jRnjsByvUYWIOcF
 M9lJD1QjfPguiBz9A8phnwZXcqmt9qjNlH3LG+rMRATHqw532NOwpvgJL
X-Gm-Gg: ASbGncs2J2uYA0vHlC+qFxXdKE+LW7sA/++xU7KWi3cuj4Z5pMGL6AAbPgi6aIawJXr
 e3Vvg9h/0HPfxv4vuUaVIQi/Io80Aqgg83PlmTWi4jN1sTn0VGaM9yVo6obnocfHBVRxAvU8zDn
 58UrrVVtdQNIaoSfFXXPuvmWyQYGk65SvNst2+90FUdk4RYciGWYiwWABwxwyqCtYTue2UM/C9v
 URTokinlpIjdTIDwxeMX8SFrxvFNZnea2z5iRLmLR3FFOpBnscFDhI5Mk6mgYITzxSJCZo6+e21
 3YTfegHqTgTYk9/LvKRu/ExiHPIvtz9fw08nfvHaOYS3GTzI9mDGXr2JpA==
X-Received: by 2002:a05:6a21:3397:b0:245:fb85:ef58 with SMTP id
 adf61e73a8af0-2e7d184ddcdmr23755492637.40.1759206002331; 
 Mon, 29 Sep 2025 21:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiyd515mPLCVv4xeJdaYwKGXiGFNHNFvFrrF7Q54+uYJseldJyBC4i7YGkXsnwE3Ks1D6Ydg==
X-Received: by 2002:a05:6a21:3397:b0:245:fb85:ef58 with SMTP id
 adf61e73a8af0-2e7d184ddcdmr23755457637.40.1759206001937; 
 Mon, 29 Sep 2025 21:20:01 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:20:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:18 +0530
Subject: [PATCH v15 09/26] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-9-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6443; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Wl23waoC+6Nky6xZOSW0idcC0HXTEiZdkMCv+c5PL94=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMG92zoXdodPf+Z6o59zovGDOo5FxS4LDEt7MrpWb
 dwV94Cno5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwES4uhj+Z80LiuBjkjZR35L2
 00xMoLFNiW2rStFuhrVL1dfmbJurz8jw1sNqe6rm9QXijqt8o6QK9i1fuCQtxm75IbnzwYbffTj
 YAQ==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
It is ensured that qemu_loadvm_state_main() must report an error
in errp, in case of failure.

Set errp explicitly if it is NULL in case of failure in the out
section. This will be removed in the subsequent patch when all of
the calls are converted to passing errp.

The error message in the default case of qemu_loadvm_state_main()
has the word "savevm". This is removed because it can confuse the
user while reading destination side error logs.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  3 +--
 migration/savevm.c | 36 +++++++++++++++++-------------------
 migration/savevm.h |  3 ++-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a426ec5b60b8e929afe281c89be4e934fef40143..ad50a3abc9cfa544819a79b9c75a4f538249e6c0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,10 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 9e30718995ec9a6dddcfb3dd9e9e1dc2d9d17aed..f1338f5cf6d983c73ce8388c7f899b45fd3980aa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2456,10 +2456,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
-    if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -3080,18 +3077,22 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
+    ERRP_GUARD();
     uint8_t section_type;
     int ret = 0;
-    Error *local_err = NULL;
 
 retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp,
+                          "Failed to load section ID: stream error: %d: ",
+                          ret);
             break;
         }
 
@@ -3112,10 +3113,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-            }
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3125,7 +3123,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3133,6 +3131,9 @@ retry:
 
 out:
     if (ret < 0) {
+        if (*errp == NULL) {
+            error_setg(errp, "Loading VM state failed: %d", ret);
+        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */
@@ -3153,6 +3154,7 @@ out:
             migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
+            error_free_or_abort(errp);
             goto retry;
         }
     }
@@ -3186,10 +3188,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
-    if (ret < 0) {
-        error_setg(errp, "Load VM state failed: %d", ret);
-    }
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3270,9 +3269,8 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "Failed to load device state: %d", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
 int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

-- 
2.51.0



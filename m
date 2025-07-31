Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE5C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUAk-000208-Is; Thu, 31 Jul 2025 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHZ-00006k-IW
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHT-00006v-TN
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/t4LS9DI4/JXxAHi9YcggnXg5YIOZWzVlbe7P6h3LY=;
 b=cJWA5eNBADWJYPicMBc+FcAxCk0rF42n+mqI+FH4hU9VmGR+eufOgr7oTIWNZ3H3De0kPp
 FF0m/RdEjBtyfoLLg88qA2t+ZlLs1ahaMfUmO1/BuhMV6kNdoqd9yGvszbd5xq175Z1GFO
 B8yU53dDWSX4DZmh4TWXbrH3IrnAXyo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-N5kP44LxML-j7QRBnzCc6g-1; Thu, 31 Jul 2025 09:24:57 -0400
X-MC-Unique: N5kP44LxML-j7QRBnzCc6g-1
X-Mimecast-MFC-AGG-ID: N5kP44LxML-j7QRBnzCc6g_1753968297
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b31ca4b6a8eso306607a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968296; x=1754573096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/t4LS9DI4/JXxAHi9YcggnXg5YIOZWzVlbe7P6h3LY=;
 b=PMq9A+kQpMu0lFdxcjNtHRk85XWDPFSaa59whKu+3NsJjUyK4Za/dwMo8mQYkZ8L/g
 BuxOoAAG/CaochfEUI4mFtL7gk2e3Wk/XtpjYjZdjiCqrkQbKnqplGkO3gznAH2eXdpk
 8yaENbFxZGOOpr1tO88BYscnz9KexFayDOFMuHRSGYnm1UdYX1Y+7aRnC38t2PZM/ajq
 ulADJ3It1E0C7OFar7anDyfUEuO0C5lamw3KSS2qukQh6GmjcdeqZlGm9u7G/gQts0LJ
 FJEzfPnuqlzgGW66GsM7DcoQgDrE0elnRekgTezpJh1RjrKyYhsLFSr1bcHGw6Z4sq7G
 CyNA==
X-Gm-Message-State: AOJu0YwWwlxPquQDaaJCq+abUulAyzP59Dg6BmdRu6z6nBONmt94PvOd
 rsJqcJCoELyKvS4qfIbSQ7KaAVZ9UjlPIuRBEFkH/y3EK07B81b/MGvMM50eEhTrjU5XNCHFAdn
 jBJiaDcZP0jgK6NnaqVFLCPFT2Ual3JDuRVWqf1JfUB+80uqsuHO7TLDOHAIuKmj7OMG0VuwMnt
 EjakQYeK9PB2cdUWD1RhH5ttJSoB+HAkz0lTfCmn6N7A==
X-Gm-Gg: ASbGnctxJOryJSRB8gnT0O5mJZbBciNi68XH5rKQP0ULHRs36Rtoo6NwfFbSeaXUMCw
 Vxx/i4CRM/C6Cgm8NdtrKMOk8GYjHrZ10D2JjvuhT8s2dg49rPyo0MhGdxrddRfsvV5G5NRjVi0
 zl5h3/OsuFVW5Wvrof/z+VBsAwIec3uSNoY6whE8/ehdDLaGJd4tNlSag/G0x9BqSPs6bjuMsBe
 wfXYyHepkreT9/r6dMALZYJCoxrhjMEY+DY8N9nd1naTv7W2NT85wws9gsUjsm+KRN4e1MVnEGj
 RsH/23AdMQ5g+gV4JyjOnyEb15oAjS+iI43FYNYIRMkiA9wViH38
X-Received: by 2002:a17:90b:48cf:b0:31f:28e5:1792 with SMTP id
 98e67ed59e1d1-31f5dd6b55fmr10226555a91.3.1753968296452; 
 Thu, 31 Jul 2025 06:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKSsYYFL6VdoL3n0qieHccbmw4gYnJyKKowNus5rWnBE+sWv7UryYYLg9VC3wbxafslOBQ0Q==
X-Received: by 2002:a17:90b:48cf:b0:31f:28e5:1792 with SMTP id
 98e67ed59e1d1-31f5dd6b55fmr10226468a91.3.1753968295795; 
 Thu, 31 Jul 2025 06:24:55 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:59 +0530
Subject: [PATCH v8 19/27] migration: push Error **errp into
 qemu_loadvm_state_main()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-19-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6440; i=armenon@redhat.com;
 h=from:subject:message-id; bh=lWU+GjdNSyURPgn6NOkpKRQeeZ4WAQUDj0MOi2Wj6qw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rMox/j9Tw5Nkn3Uv2+hlOvmpYol37c42B3fcPjg+
 0L5ZpeAjhIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNJvMzw3XFl+aRtn+arZ7xa
 0XzGaFPr1CV5b1gbIx/FvXf6oPN+JsNfyZBq8V2PhW7ktu60OxhTPFHleZnx1MIz9Z4814NEp8/
 gBgA=
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
It is ensured that qemu_loadvm_state_main() must report an error
in errp, in case of failure.
loadvm_process_command also sets the errp object explicitly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   |  5 +++--
 migration/savevm.c | 27 ++++++++++++++++-----------
 migration/savevm.h |  3 ++-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 981bd4bf9ced8b45b4c5d494acae119a174ee974..529794dfc8d943b8ba3a25391ee2132c0c3f312e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
 static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
                       QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t total_size;
     uint64_t value;
     Error *local_err = NULL;
@@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
+        error_prepend(errp, "Load VM's live state (ram) error: ");
         return;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index e885f1724f223771d60081fea199320abc549d2f..f5903995edd2b4c4f6c1a214c7126d831f10c9f1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2111,7 +2111,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, NULL);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2412,6 +2412,7 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  */
 static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
+    ERRP_GUARD();
     int ret;
     size_t length;
     QIOChannelBuffer *bioc;
@@ -2461,9 +2462,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, errp);
     if (ret < 0) {
-        error_setg(errp, "VM state load failed: %d", ret);
+        error_prepend(errp, "Loading VM state failed: %d: ", ret);
     }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
@@ -3066,8 +3067,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
+    ERRP_GUARD();
     uint8_t section_type;
     int ret = 0;
 
@@ -3075,8 +3078,10 @@ retry:
     while (true) {
         section_type = qemu_get_byte(f);
 
-        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
+        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
         if (ret) {
+            error_prepend(errp, "Failed to load device state section ID: %d: ",
+                          ret);
             break;
         }
 
@@ -3084,20 +3089,20 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f, NULL);
+            ret = loadvm_process_command(f, errp);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;
@@ -3107,7 +3112,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3171,7 +3176,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3245,7 +3250,7 @@ int qemu_load_device_state(QEMUFile *f)
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, NULL);
     if (ret < 0) {
         error_report("Failed to load device state: %d", ret);
         return ret;
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c716686f06720325e82fe90c75335ced1de..fd7419e6ff90062970ed246b3ea71e6d49a6e372 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

-- 
2.50.0



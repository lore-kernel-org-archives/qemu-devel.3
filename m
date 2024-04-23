Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BBFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnd-0003Rd-8w; Tue, 23 Apr 2024 18:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmg-0001UA-24
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmc-000678-RV
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGxS7LCL/5K9k+9dnL920DkEl9Edx2Ut8erkfY3BTxI=;
 b=ELeBuxxvpEpaX3RF37e15LQ8KGzNjnEkB2oEMlJ15rrDwNtHGnANBxdlhhs7evqVhnGk7n
 +Gt0EzspTLkJkziIVm0mtszrFVyACBZZE0xQj7aABGWUx22A/ZKY6bySDkEZIJFWzEsGVC
 1I1Wx+EQPppdChq9yKeyA9mP3I16Q4g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-B3VVR-MhPx-u-k467frJug-1; Tue, 23 Apr 2024 18:38:34 -0400
X-MC-Unique: B3VVR-MhPx-u-k467frJug-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4379bbdc9b4so26299011cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911914; x=1714516714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGxS7LCL/5K9k+9dnL920DkEl9Edx2Ut8erkfY3BTxI=;
 b=bCm98YOQs72cCr8BNjJBWauOlhP09mjgNqAQZTlO1tdwXnZfbwct3uzaS6xE3xa0vQ
 +CmPnt2J9maT55gOHv3Shu4ST3JKhlLRIMadKs8hXaXA0Y4B2UwaqOSUvQZXRWn5SEMq
 Pa0JaX+delIZDk/t9KcX5wz8fwWEQ2XhAIQyayvvvWo5v5So/3c/V67wvAAL3n/zInR0
 kGX7X9IAXeM0KZ4aQuuJlDiguhRsvMBCFRIWMJbeVFjWIVPkw6y6oRui6XJQuiOJew6V
 kvGleM8dNg2m8KaTEcHyDNjEEI/dZ4ym+gR08FER4WZ2YWhH1ffUkHDRzjitxD3cua76
 QZKA==
X-Gm-Message-State: AOJu0Yx+JVt6vSnm2UWGx4mYs0VDzbRMCu+YZYUVrSS6zfPNsNolmDGs
 LYA0auSENoR5b96QG+wdxXfQzjZTF32HNj2ywbDtQiw/tsMLrHzX3DUmPdr4ZWzSavulHMDfxEV
 C+PdWhaMw+bO96mQc4J+8FVBbB/SVnN36QIfZP0dohXT8MMblVVRspmIB1eM0SmgyzH2ELrwCmC
 uLW6fqssjYLhYyEpUWJ0EkJAdR1fyFqASeRA==
X-Received: by 2002:a05:620a:1790:b0:78f:19f7:ad9e with SMTP id
 ay16-20020a05620a179000b0078f19f7ad9emr930479qkb.7.1713911914014; 
 Tue, 23 Apr 2024 15:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEc3dEpDjW5HwACJqrNHPLOPLilXFzeHLVJnEEPZzf5FgBJhGG9tnAo1sOQbCHqPP4CT3+8g==
X-Received: by 2002:a05:620a:1790:b0:78f:19f7:ad9e with SMTP id
 ay16-20020a05620a179000b0078f19f7ad9emr930446qkb.7.1713911913176; 
 Tue, 23 Apr 2024 15:38:33 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 14/26] migration: Add Error** argument to vmstate_save()
Date: Tue, 23 Apr 2024 18:38:01 -0400
Message-ID: <20240423223813.3237060-15-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

This will prepare ground for future changes adding an Error** argument
to qemu_savevm_state_setup().

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-6-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e7c1215671..6252fc37b7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1009,11 +1009,10 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
     }
 }
 
-static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
+static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
+                        Error **errp)
 {
     int ret;
-    Error *local_err = NULL;
-    MigrationState *s = migrate_get_current();
 
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
@@ -1035,10 +1034,9 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
+        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
+                                          errp);
         if (ret) {
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -1325,8 +1323,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->early_setup) {
-            ret = vmstate_save(f, se, ms->vmdesc);
+            ret = vmstate_save(f, se, ms->vmdesc, &local_err);
             if (ret) {
+                migrate_set_error(ms, local_err);
+                error_report_err(local_err);
                 qemu_file_set_error(f, ret);
                 break;
             }
@@ -1542,6 +1542,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     JSONWriter *vmdesc = ms->vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
+    Error *local_err = NULL;
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1552,8 +1553,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
-        ret = vmstate_save(f, se, vmdesc);
+        ret = vmstate_save(f, se, vmdesc, &local_err);
         if (ret) {
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
@@ -1568,7 +1571,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            Error *local_err = NULL;
             error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
                        __func__, ret);
             migrate_set_error(ms, local_err);
@@ -1764,6 +1766,8 @@ void qemu_savevm_live_state(QEMUFile *f)
 
 int qemu_save_device_state(QEMUFile *f)
 {
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
     SaveStateEntry *se;
 
     if (!migration_in_colo_state()) {
@@ -1778,8 +1782,10 @@ int qemu_save_device_state(QEMUFile *f)
         if (se->is_ram) {
             continue;
         }
-        ret = vmstate_save(f, se, NULL);
+        ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             return ret;
         }
     }
-- 
2.44.0



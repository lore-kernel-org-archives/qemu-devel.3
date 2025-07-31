Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A232C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUBR-0003UO-Ip; Thu, 31 Jul 2025 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHm-00023g-L6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHk-0000OE-PK
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q41CbZyk6EWJwfzlItcJnMM+40hpq9ZWZ11m7GyTZac=;
 b=TD7rxkrbHRGUdKJ1QRr3F8QTk7poHVxFrFUK9CxmL1f+SgXRdTQDWoFU2he5hfQyl3nRhz
 nmwAMRMVGDbnm19/1nhSR2xkpy94qnbjHYzlEpW6qzcTlZM0RLG1j0glWCmYnxqoVfHSEq
 6iGB5pCk5VBYZeQbMfXGeyhg0PAMj/I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ugZcmNlFPmOWctz_4z2whQ-1; Thu, 31 Jul 2025 09:25:26 -0400
X-MC-Unique: ugZcmNlFPmOWctz_4z2whQ-1
X-Mimecast-MFC-AGG-ID: ugZcmNlFPmOWctz_4z2whQ_1753968325
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31ea10f801aso741195a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968325; x=1754573125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q41CbZyk6EWJwfzlItcJnMM+40hpq9ZWZ11m7GyTZac=;
 b=VNed5T4BChJq4ft44DldhpZoaSMCByA4TBpTe5xnMj+7SqfyiMOiodhAreSvyv3u5X
 VbGiePOAJ/Cu6/C5AQMmeQBxipPELMBYlt2hEAkDpjrF4Ufay/8xJnP9AP+v/fboRN8g
 Hw44CDVkhPVeL4f/0+B1+dWvSQe9TMDxq4aByLchXrV7RUzLKF6eYTmzxR9IwZaPt1BY
 HCki/O0WUr8L7/r77iCIe9v9UljlygSnzmJ7mIG3RMHRPDR1i8lNTwtieyWmxc/z4hkN
 m9bju9h9YVM+qp0SlTeiX3Fw8SEb9iVlmYpg95sz0FO5ng1/9/8hWzTVqCE5uDPZUO4V
 Fhxg==
X-Gm-Message-State: AOJu0YwdDR6gViMirbY6Wx7Kf4d8KqzbpycYtv+dh0/N2DgT+hr6A0tR
 9ZXqYMgot2UoDC9eywk8qE5XmKnPqEMDJkM3Ltbqa/dClRzG8GD/eP+GiJT5OQgWvKn0zsr5Syp
 DT2aoObQPmG1UcjzGlktE8nTSyrZEAjt9bvkwk4SOefP0eXzvDj/q5PDwF+tjC7ghleT/lZhMTc
 3ibtjRk1Lv7L6bBlOk3yYiJ/+yONHE/qpu2AB9ANMqEw==
X-Gm-Gg: ASbGncvwouZ+09Slx76x2/PhgeiKEPweEpOn5P4kUwmpUOQD7lgBwiFlaF9ihC2TrH0
 pmdM+k6B9xVa89FePN8aS+8E0q/YeIe17l2XvY+6iLhTrTKh1Mtj4RVm4HDXf2TIvHi0g2sbjf2
 NPWfZ0G2o5KlyB6daPLB6M2fRLatt7DwToP3Yzfs2Ram14OtnS1qo5ytGlVm2UT+sSv7LIdh91r
 OpLpFjcMbuMkeTcDAANjJ80TUb+s+osE5i1zT8xiQ/ijU37gJd9XImwwG4CweWuTK+KieqcvUYO
 DbODQWuFWc9724DwSDelPj4HxuTjwRHW8Wuy1z0NfyzOuHkm1kD9
X-Received: by 2002:a17:90b:248a:b0:31f:104f:e4b1 with SMTP id
 98e67ed59e1d1-31f5ddb7eb9mr7072053a91.7.1753968324845; 
 Thu, 31 Jul 2025 06:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMvUmxZwZJLMuA+dYDR6MP0W6BsqFWBcJvd8vioaCyBKzR8fJIC9kAOiV8swIYDOq+Fs3Zw==
X-Received: by 2002:a17:90b:248a:b0:31f:104f:e4b1 with SMTP id
 98e67ed59e1d1-31f5ddb7eb9mr7071995a91.7.1753968324336; 
 Thu, 31 Jul 2025 06:25:24 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:25:23 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:02 +0530
Subject: [PATCH v8 22/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-22-28fd82fdfdb2@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3026; i=armenon@redhat.com;
 h=from:subject:message-id; bh=fBBcHspeBvHFbaQktvvk5fZdIluN9yDL2XhMjVwsdbM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rO34SG2n88nrXh9f4H0+Y3dq6cXzFu61039zdWCR
 IvQ8v4/HaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACZiJsDIcOUP6+I/06UXaDka
 py8JfhJ69lfvo70xgg+dOLb9yy/9EMTwP+7vqtQjT5km5qhOMFh+RlRo8Zr01bZp9m3q/lcjjoT
 NZAIA
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

When postcopy live migration runs, the device states are loaded by
both the qemu coroutine process_incoming_migration_co() and the
postcopy_ram_listen_thread(). Therefore, it is important that the
coroutine also reports the error in case of failure, with
error_report_err(). Otherwise, the source qemu will not display
any errors before going into the postcopy pause state.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0a5a8d5948b2b0a3f85163795e84f71903870d25..4a76d7ed730589bae87115368b0bf4819f8b161e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -925,7 +925,7 @@ fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, local_err);
-    error_free(local_err);
+    error_report_err(local_err);
 
     migration_incoming_state_destroy();
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 3bc36b92dcfb7c65ef0d312d6340dbc73caa6ada..071044921bed02f027571b2a832f339990e547ee 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, NULL);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err,
+                              "loadvm failed during postcopy: %d: ", load_res);
+                migrate_set_error(migr, local_err);
+                error_report_err(local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.50.0



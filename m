Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F03C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUDJ-0002rI-3S; Thu, 31 Jul 2025 10:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHg-0001aR-02
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTHe-0000Mw-3K
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2tdGwnYvDb9XOQql1y99JooK+eg1CMI9JdS5bG1ZsQ=;
 b=gIDVHMInX2AO/1B1w/mO+ONJFitD6lKFjitpkLvGBh326rIhOj5s3FPKQqOnTvZ8Lh4KPy
 OpYOcBU4CSbKPmrc/5gS04V3t1kO3Cj9jDQRclQocoyMJoytt6bOf3TKXPfSWdDYa3Gjyp
 UotAaQMTDezmsetjqo8jqdxusGA+n28=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-5MTFgvD7N4mzO7S9WhqbGg-1; Thu, 31 Jul 2025 09:25:18 -0400
X-MC-Unique: 5MTFgvD7N4mzO7S9WhqbGg-1
X-Mimecast-MFC-AGG-ID: 5MTFgvD7N4mzO7S9WhqbGg_1753968317
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31eac278794so1013672a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968316; x=1754573116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2tdGwnYvDb9XOQql1y99JooK+eg1CMI9JdS5bG1ZsQ=;
 b=VvMy8AWv+mG+V4o4hSnIA1bw1sDnyAVA6RoVak4CffaSsySDw4+121cSyhClIFgKVJ
 vjnreiJ9ob5sEx4kymxIUKrQNIP8DWZaK1xGDGLmOeZEGO+yOdC9scrchh10X99DTQVV
 wiSd5FpciEKwEY7qC56ew0JG/+9zNzU5LgnPFqHKbriDAWEwzySJ/4eS3qVtvc4VHH6h
 Wk9XFRycuOaSL/A6yj+HUqvRMviau5U189D9aPR86meWEJs4mSaWv60aUSYreA90tPNO
 Qpwj+g5z/J4DVJgeODIqcFRl6gzo8DmRPg9iCeUYkpGXXrPKwAqRBlj59I3UjbnQgwLb
 d5lg==
X-Gm-Message-State: AOJu0Ywva21llmdBIlLbSENZtLFdjCZC2YEP7U+L3e5BQU6iytgTd5Kq
 /Mbn2KTWbv01LSKZNMt9K8M/wL/yHQSogZwR2jmGkTsrKuRNCCUn2+4Xv1Y8V6zxHkMviqnQKaf
 YOMaAGy2sFnwE2l+6lKZmFFE0+/lMFPN2mYHJR1qH28tPHsDo4utottWxQ0ufgrNY0m9xIb6+Nd
 241XYTPJmc7WwxZcUieFBGUI8JyuLNMFz7dpj2Xh4Dww==
X-Gm-Gg: ASbGnctWGrAxcABNqSx5UQevtR6Ik020u70bBcobwkTKppzHhGf3aBMXjcUiqx1GVKo
 Zdi/qlBastJYM4SlLVZNw3mq6jyzU5ILHynnGce/ANXY1eO2sfYfBWpOKxKijnemXfJb2/0kWtQ
 9Yg/4PxT3vWSHNA8v9IxWTAsiwp1dYhCbZ9CBMlLFQSxLuo3U2fzHkUxPO1Y77UKM7QFlIkpO9d
 s310hkhEitS8IdKQiqAFWngG/ZMdXqETjJbhthTx5f1wMNs7ykIcR6umo5Ey9splggjGXv9kAhq
 OwJhjit8k9eH4dqOSHo6+TA80qdqwjYW1hfRNOf4tb6l20HHQCXe
X-Received: by 2002:a17:90a:dfc6:b0:312:39c1:c9cf with SMTP id
 98e67ed59e1d1-31f5dd7f4e2mr9317176a91.7.1753968316236; 
 Thu, 31 Jul 2025 06:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt+6Rc+NUWBMHtiDdazxUJha459O4+HeE8c1Y9oGsMRHFR76JyojR+cOdvGQgfNZD6F3T6bw==
X-Received: by 2002:a17:90a:dfc6:b0:312:39c1:c9cf with SMTP id
 98e67ed59e1d1-31f5dd7f4e2mr9317100a91.7.1753968315534; 
 Thu, 31 Jul 2025 06:25:15 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:25:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:01 +0530
Subject: [PATCH v8 21/27] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-21-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682; i=armenon@redhat.com;
 h=from:subject:message-id; bh=VZWo92MSWBEQmawCHTpfJOnPbor5WfeU0jM5DJ09Evc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rOkTbNsBEU42yWCg3w2ClRL+r0RsvmXu2Nx7Bvuk
 KlVxjkdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJrK6g5FhRUDQRJa8xXbpwQq3
 2mrrGx/c4VwV+/9tM+/7vomT5qp2MjIsX9h8UdO1euLH7EsHxHdJN4ktqM4P/bFgyiy3Q6+aVqx
 jBgA=
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 4 ++--
 migration/savevm.c | 7 ++++---
 migration/savevm.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 529794dfc8d943b8ba3a25391ee2132c0c3f312e..71842c798a1dbbea6a7ccf8cb64e2c836c0f574c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -730,9 +730,9 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_prepend(errp, "COLO: load device state failed: ");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 2ac341ed627c4a8db7ba7676363d305c82ee3437..3bc36b92dcfb7c65ef0d312d6340dbc73caa6ada 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3247,15 +3247,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d: ", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -68,7 +68,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);

-- 
2.50.0



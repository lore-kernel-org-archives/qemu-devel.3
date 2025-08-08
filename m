Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887DAC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMs-0004Ze-3Y; Fri, 08 Aug 2025 03:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMm-00048F-QJ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMg-0007bb-LH
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbMZj+sBG4f9RIqMEyWNKSRMh91cMhuYSoiYPz9zI4U=;
 b=GIk9fn1lNi4xajrQfdrGw1jFqx/lNVGjxffYk/ziD4xCTuThe5KjyNDZ2jNu+0GKqAJFoP
 PYjHnQHoH+w8mviGUQC1ET6ABvekN8OsyUFh47NtoCH3F0htRe0bBPZY7Irafdn9p09iCR
 UWvhlMYsr9eaG/PXU6A8e2zsQugvukY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-tmfBXtRgM2CZawv4oceVnw-1; Fri, 08 Aug 2025 03:18:07 -0400
X-MC-Unique: tmfBXtRgM2CZawv4oceVnw-1
X-Mimecast-MFC-AGG-ID: tmfBXtRgM2CZawv4oceVnw_1754637486
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-240012b74dfso14846995ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637486; x=1755242286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbMZj+sBG4f9RIqMEyWNKSRMh91cMhuYSoiYPz9zI4U=;
 b=ERttwn4e/QxlYXTq/jjHWYEIm803v+2utBbV9SuGFRUqXAJuFhr4NoNkNazO8qY+fc
 BoBiJeRBsME3Cz0rKrp6OFc0NSgQixWdA75YIzIKi4gvY7XxQIMKt1RbZ7nz+WQG4tQ5
 zNZFH+05+BJ0RA+4ZcCDxwjOzLVGxDqWdJ4sdHsCGkTdOdIZp6S1eoSeh8s3inBYbTDM
 8Gp5d/ezfN3xn05KVBKReY6nJjcf+dglQ09h6bxIdLJpe/lp5hT7M2yvZtWe2QvLcfbF
 hnEIDf0tMU3RSj5qLTwnbTRz9XkE/2z4R3C2KhacFbDSZXYoZqO/XsjKSp1aeB0rdRnr
 dmWQ==
X-Gm-Message-State: AOJu0Yxfj2F3eXHjcvWXCELQGWXYz4SffkQbsoF8n9pVak/Z/XqclQrR
 S8ixg517JJJDjofJCC8zczkXg8zKNI7Yl64kxw+wO6iReD+heoWFCSPl8l5c9wGETa2Zdc53Tlh
 1k3TOCoJUdlltO1TRklNh658FgdCEMGvuzNCwT+2MUyofoTi/ALngZbm93RDSTS/c
X-Gm-Gg: ASbGncs5VK9nm3tecDCABBRHYaYJ3jqnmyZsfPyIATLxwcDfGi6obdopLOin6u6p78g
 Dyo7w6b0qxdHpVIgyubMeMG3YNe4ZCnV7H8g4Kq5Z+Tgb2B1w6prZx+0mzdUYfLula7Gee1hZEs
 FWsPqe99mo7UfkMlksxMP3YnkHxX0CtmeIm1gUdg+6Qi58RJGDSkFHfeMKKzyjJF2w3JP4r6Bsi
 lWDK6hQbHzEbnxXh8Ss9zy7Y2It7B0JQdNS2wd1IRatdO2W8G3oomnRvH3qJAV0UXS47UY+MD3l
 pWaJ/0YJAlgfgC3Qwl03UWFMgE2tG3eFx04+2Aw/IkcjcWKIVpQoTA==
X-Received: by 2002:a17:903:2345:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-242c1ec9e7cmr33543585ad.7.1754637485818; 
 Fri, 08 Aug 2025 00:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGhebWRhTxzJ61E3LzQpVxhx97OwHa4NdAGxpl8PL0ki8SKqV/cZCGTMYY0EwFJHTElZINOw==
X-Received: by 2002:a17:903:2345:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-242c1ec9e7cmr33543155ad.7.1754637485410; 
 Fri, 08 Aug 2025 00:18:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:18:05 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:49 +0530
Subject: [PATCH v10 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-23-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=armenon@redhat.com;
 h=from:subject:message-id; bh=t7X0faJK5S0/xZxPw69RJ1/qcJmmzgO/i/W5ZA7JsoM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdemd8xRZYu2n6LCF/zq8f93a/dP4dNpUTDf78x2l
 6vwUYBBRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIkITWdkWDPrZ4XOFNeHIUYO
 dy/GeKj6BmoKR/8sjb7cxNkTlrJDgJHhqv7eLb3pBuGdN1OYPAOmyNVOuH2xf9mqHw+EGBsdPvZ
 yAwA=
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index de2bce276faa863a0f25deedafb0b784f10559d7..c3187ca9ae8534870d47056fff0511426ed08fb6 100644
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
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
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
2.50.1



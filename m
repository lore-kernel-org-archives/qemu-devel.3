Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B141C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzfl-0003bj-BN; Wed, 16 Jul 2025 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeR-0001A1-68
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzeM-0000no-T0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQDVkh0bj083qN9CjBSO0WSVA0XkDcSylaUeJoviZn4=;
 b=fAdb7QtufCwn+Z7/ntRoBs5w9wMuoat2G0fW/DC9B/HJMbWptGPKff6L4Nl3S9VjdRsgPs
 QlkoDICxtgnmoXQZiN8pG1yOkGHxntDE8wilxeNhxzD0fpZhX3x2QGJQhtWVqypXi0tewC
 GOsDOvEkuk0gAkXnp59I0uCJ8H5OABM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-UMjIas7NOy6y_LNdpH1S3w-1; Wed, 16 Jul 2025 06:46:09 -0400
X-MC-Unique: UMjIas7NOy6y_LNdpH1S3w-1
X-Mimecast-MFC-AGG-ID: UMjIas7NOy6y_LNdpH1S3w_1752662768
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23827190886so75493605ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662768; x=1753267568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQDVkh0bj083qN9CjBSO0WSVA0XkDcSylaUeJoviZn4=;
 b=d4nYX4a6HL1jn//mzn+YuA5DQ4sNvms15huoQ8cILnSfvEMSpo0hXRoN3kB0gFnF+J
 2ktrMnszzQcQb5QQc/2RIZllPh6K70ZtSZpcaUvHhy/sPKZT7ynwoWeomv8R1iMQD6bu
 hloUDDqbL956pYMMj51WYvuxfYOK60x/Imk0CbrWRXqiX7M4h+4ahTfr6/R+3bUE/k2q
 sXJ/f1j7AEQnusD3oWJhcZm7QKLWPUGAFcQVpWnSwe1Y+II/6H18IdD/oQzeeWG1bqLo
 gJyUMr1FI50QiR3QeXPsAvS/LND7oVEwwni+NBdewAlXwagKXsM7x3a5mekpges7RTii
 rJzg==
X-Gm-Message-State: AOJu0YxnewqH+oNh7Dm1WKpydNSD/oSlkltgeZy33F+acDaJVK5dAiXQ
 eS17fE+mtc0szkpD+0f8pAFM3QhOraAud6EJ/RbP/iLimKt1P8ZTTwdDJFc/s9mbie24nnt04f4
 B0bKsxPdrkY7G/x7QkrrjEHq5W3ulca/o3NSrnQ+vcJpeqHWXV7fSKLAe
X-Gm-Gg: ASbGncvY0wlnDses2gZNh/rxKjDw4n8vo2NkKAc0x405CTs56az1/Vh6c2SgJbzEVor
 l0mOm9qP/nUlMbxZG+BAeApGSNXGmbO9Ni61pc2/eMqHhmxSNVbTGViUXF6mbidYoiAlSvYOT6w
 rEl0T/ggUwNguJe1Pj8RH32cZqN8KQgEfhe0D8/j+M05IYwLQOKftW34N3mc2ZQoAZUY9vlzQFb
 btQGJ6Ld66aJCWky1FhMRs7MkCy+rxzln6xlkcFJ2TF5ytRZzwDJBkck94xS/TerAure0UwXZSm
 a1xbl3zkIB0PgppNUEt1+YueX5SCPTsbfudwUpSpVapf88Ub/g==
X-Received: by 2002:a17:902:f650:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-23e2566b058mr31793235ad.7.1752662768048; 
 Wed, 16 Jul 2025 03:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg9hJoOVzLCWiQlq2mZ3FN5NrnJdp5k5vdrqXwaHDnqXqMMRRK1flfCV0P3gpb85mbTRwLfg==
X-Received: by 2002:a17:902:f650:b0:234:a139:11f0 with SMTP id
 d9443c01a7336-23e2566b058mr31792775ad.7.1752662767678; 
 Wed, 16 Jul 2025 03:46:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:46:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:10 +0530
Subject: [PATCH v4 20/23] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-20-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2721; i=armenon@redhat.com;
 h=from:subject:message-id; bh=NHQbtE1Z+gXKZUt1s0S5v1y6t2YxU3nOML37/1rvyfk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k0Mih7h/z/wPCcp877uMpodIyc7mXzCfa+8ne8EJW
 eqV3406SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATGTvIkaGEwwsgezrtA33zfwT
 /n4B05I9Rbt+6jM3LaoXbp73UD6NgeGf1s3Y1QctndV5zA7cWJM6L/VJhIHLxsV/tnzUOHEz6mU
 kAwA=
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 5 +++--
 migration/savevm.c | 6 +++---
 migration/savevm.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index ddc628cab4194b3cb82388c5e878286c820004b2..7291df0d47d8e308f8b71973c908b5a05ec7f4d7 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -730,9 +730,10 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, &local_err);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_propagate_prepend(errp, local_err,
+                                "COLO: load device state failed");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 7bdcf0f808fb07543fd62a679e359bcb18c4ad35..71cf69ffeb754c1657256ed9f025aa257e82c00c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3234,15 +3234,15 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d ", ret);
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



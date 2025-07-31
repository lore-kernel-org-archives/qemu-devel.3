Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C5DC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7h-0004Eh-Vm; Thu, 31 Jul 2025 10:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFY-0006aC-Dn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTFU-0008Dt-Os
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWJg29Nx6GQ1ehptzza8ixurpbv7NTpS2owOU8T44PI=;
 b=RyHKF9fWJVJ4TglzlKO4be+26ltuQtBRCx9SzW1xMCd1QzQiCmctJ2if3LXFvOttPdiRTE
 ls1OQuN+PoRSjg7qBtYNZhDGujujcYckMAS5NbkYPRCAEK3OYEgqy3Zk5MORK8xODMYasu
 Pu6frfXq5J9ngy+GbIT+djUq2bzf/4w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-bdrWVZDnObmhjseeCzDlqw-1; Thu, 31 Jul 2025 09:23:06 -0400
X-MC-Unique: bdrWVZDnObmhjseeCzDlqw-1
X-Mimecast-MFC-AGG-ID: bdrWVZDnObmhjseeCzDlqw_1753968185
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f3b65ce07so750420a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968181; x=1754572981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWJg29Nx6GQ1ehptzza8ixurpbv7NTpS2owOU8T44PI=;
 b=dE3caUxMfcBodhGxSaA7qSbG/KnlqqrqcBc8LEunkDm5QVQI4vW44FF5bIa8IRfXAc
 LJ1Www1sOqb9yVHE0NMFAaHDkaZbPhx2h4R0DqUs62T4J8wBUBsbqo3tjfMyLwyM+CDT
 rKAm5hd63Qz2RTeOkcg8Q9v3F4sbb7W4pqdPRg0jApsa3KLJvRujMjgZm9/zsO/VJW6h
 UJRvhtnOTKeASf8nYLh24s6p3iGd4twXBxBqURhP0xZbBqdQ3liaz8h6yuKp/zhXDbZ+
 3Xbyi/S3e9RoYlAC2Y2yMc04Ri5rw8N+tQyrk6kmvduEUCKjSAJzrxiXYOolnCR/E+um
 Smmg==
X-Gm-Message-State: AOJu0YzEiNhnwYV+yhlsvFV6/EZTAT+QT81MD7MlzLdoY5wvDzeWM39+
 DMuV0zNnH26PxlRR+lZaJIBt9oU1eWP5ojyGno2uKnecaMxmsRampfH2lwdz4ft93xiBccvAPsB
 ZtAzA7AQFAf7tHYIeDqVgjXmpm/hrB8jjZA8qcOlrOtsPHP3ybqe1XzgDqvfgI7DRMWMzx3TAwG
 P1dEcBi1e0aJFBagrtgEVfkjuu7aSzaoVLY8N/0dLZWQ==
X-Gm-Gg: ASbGncusIwzOEC3I6Slg+uoHsvXaGdK3bJq/HwSVQXbZVKsMSb1FwEO9A7BfgWhzkMc
 MlArH7FGVzFLxZW5uaJeuHwIbLtWZT8C8uWYuUTUtyfUhGnCHNH5YeXFn/gV99Xz/xITyWSJz4p
 s4HRTJznxFV49Oi/1wwO4I4oHGUhTet/cVLKxwdlBSGAnqXtlZGh72GCXZmdbVdS3wUBHGZ+bHJ
 34WNydel/8VEHMbH3LFGWajARuqVKuN3/BLYFUlqfVDwpJxok3AHqhxnZNti8EcxGGP5t2jYbvF
 oY7H6PlfOTVJ/extZRcz4WEquBVPFml0UJNrNyFQlRxSd0eZkIBS
X-Received: by 2002:a17:90b:4a:b0:31f:42e8:a8a8 with SMTP id
 98e67ed59e1d1-31f5dde8a3cmr11108100a91.12.1753968181617; 
 Thu, 31 Jul 2025 06:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4kAeC10yMczQRYtdbGt76/eomwbuZsmPWJSVmj7eZdJUuUBWT5Gb8FH628oUNgVjFUEArzw==
X-Received: by 2002:a17:90b:4a:b0:31f:42e8:a8a8 with SMTP id
 98e67ed59e1d1-31f5dde8a3cmr11108026a91.12.1753968180976; 
 Thu, 31 Jul 2025 06:23:00 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:23:00 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:47 +0530
Subject: [PATCH v8 07/27] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-7-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3844; i=armenon@redhat.com;
 h=from:subject:message-id; bh=/AWe+X+/WeRjGQrEoVl4cRFi5sWN/sqcOL9pzGajTZ4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tMp9+77Fs6M5DeoF33XP/+HoJTw0T7+6Dk8LAfSz
 uU3fPTtKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJFjJgw/GafZsma//xYrpX+H
 VW2v8azvka/qrsR/PFPD9np3gIRoCiPDcSGfJHOTG9q9kjyy60NL+W0C/3Fu8682P3theeyG80E
 8AA==
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..981bd4bf9ced8b45b4c5d494acae119a174ee974 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -849,10 +849,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25dec01f206eacad2edd24d21f00e614c..b3bccaeaee806abd01595863f6475057049b0688 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2646,12 +2646,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2660,8 +2657,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4010,10 +4005,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081a4446442b544d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index 9ed842eb87a019666d4409e1213c41643a173447..39d6fd5b832971f23afc08100a20bcac045f3904 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2583,10 +2583,6 @@ static int loadvm_process_command(QEMUFile *f)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.50.0



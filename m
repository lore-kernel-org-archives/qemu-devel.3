Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27BBC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtm-0000QO-G1; Mon, 17 Jun 2024 14:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtd-0000EH-6Q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtb-0006JN-6G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HAnuiEXSF9coRI1TVtgqNjLkt+KmjbXV8lGXJ3b5PMs=;
 b=YTmSO1AWCUEFNAw7veBapQDVZladyd2NBHzYrx5NbXqdv7yS0gbyXz+/UNAQN6NJOMhsa7
 AQ5i4iYYwvuTLb12UstgQwEWIubkK1kZ5P3FcvxsUoxr91oSw9YtFqiIg8y2JhhmL+8CWO
 PhzNMK6IDfx7bU7z1aUws/YSTPO0SfE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-tLB3RpMQP0mmo4Xn8IrPdA-1; Mon, 17 Jun 2024 14:15:54 -0400
X-MC-Unique: tLB3RpMQP0mmo4Xn8IrPdA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-254ca2a8e97so1213379fac.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648153; x=1719252953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAnuiEXSF9coRI1TVtgqNjLkt+KmjbXV8lGXJ3b5PMs=;
 b=eDLpggMVPd91bfw5CscVUdhjNkwH79XpI9uMVJ5aMmnDNbApfNGZ2rDHndv2toR4t/
 Z1bJpDllKmP6dRGVHSnxULwOOaTh8G2PoydwfB6BJrKGmWWm9zCSzyTqmNblHTGKiCv1
 kVV2602birUOd4TVEa+0TDZ3cXz0q94D+3Es4rlA15Ih0/pSQmvYlt/qDX1wXfYxLiUX
 5+75/HkNz4TfHY9KkdfbGq7+aqK/m9A2jB2nCFbmhjZXdZla8COEkd3LLVs/sOq1iC9H
 q4tutyW20Gz/w7l0mB5eBuRazkrwoWt1nXL9/4S4AwY9S7y0aSdqfYKcBk2slDUHBsx4
 hEPg==
X-Gm-Message-State: AOJu0Ywnl52muoqYlz182zsVj3yN3EBwuwTyzSEcXjTnOisxLuTnR5SS
 Y9IbMsnKIstzyh0SLoALT7aZYmmLs0ang80/CX7456Cv+SuPJvEB4nSkUg1vb+UETplfMnzy5jK
 pS02jAVpGdmhcumDFQYuvTWyzKNIzFKTeSVDkpxEeDy/IKElrpIEN9T9tZ5DoFHMpGIVPSYNwkZ
 Td+09bBOvCaMKVgWPIggguhtcFb40vVFOlMg==
X-Received: by 2002:a05:6808:1a03:b0:3d2:199b:63dc with SMTP id
 5614622812f47-3d24eace698mr12638674b6e.5.1718648153464; 
 Mon, 17 Jun 2024 11:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAeO8jXXRBbhyU/4+58cdWQulRUkGrQw0VQClMfhb9z9TDqPrWvRGYogZMT2B/eHHUVHtKw==
X-Received: by 2002:a05:6808:1a03:b0:3d2:199b:63dc with SMTP id
 5614622812f47-3d24eace698mr12638643b6e.5.1718648152924; 
 Mon, 17 Jun 2024 11:15:52 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 09/10] tests/migration-tests: Verify postcopy-recover-setup
 status
Date: Mon, 17 Jun 2024 14:15:33 -0400
Message-ID: <20240617181534.1425179-10-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Making sure the postcopy-recover-setup status is present in the postcopy
failure unit test.  Note that it only applies to src QEMU not dest.

This also introduces the tiny but helpful migration_event_wait() helper.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-helpers.c | 20 ++++++++++++++++++++
 tests/qtest/migration-test.c    |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 1339835698..356057b4a0 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -55,4 +55,6 @@ char *find_common_machine_version(const char *mtype, const char *var1,
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_event_wait(QTestState *s, const char *target);
+
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index ce6d6615b5..c0e2066270 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -473,3 +473,23 @@ void migration_test_add(const char *path, void (*fn)(void))
     qtest_add_data_func_full(path, test, migration_test_wrapper,
                              migration_test_destroy);
 }
+
+/*
+ * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
+ * migration status changes.
+ */
+void migration_event_wait(QTestState *s, const char *target)
+{
+    QDict *response, *data;
+    const char *status;
+    bool found;
+
+    do {
+        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
+        data = qdict_get_qdict(response, "data");
+        g_assert(data);
+        status = qdict_get_str(data, "status");
+        found = (strcmp(status, target) == 0);
+        qobject_unref(response);
+    } while (!found);
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9ae8892e26..a16b1a4824 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1402,6 +1402,12 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     migrate_recover(to, "fd:fd-mig");
     migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
+    /*
+     * Source QEMU has an extra RECOVER_SETUP phase, dest doesn't have it.
+     * Make sure it appears along the way.
+     */
+    migration_event_wait(from, "postcopy-recover-setup");
+
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
      * kicking them out using migrate-pause.
-- 
2.45.0



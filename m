Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609D9C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mt-0003RE-II; Sun, 12 May 2024 06:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mm-0003KD-G0
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mk-00065L-Fe
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gg0/8OEdOJATol7CmuQ+nthGOZbWRnfNOiRj2A7n9c0=;
 b=CprhyGxWGXB7x8HyIvvHCfW8M3w2sOxn5OYX1LTE1LslGZP1HlE8OD3SPaEnDV/JBL59oZ
 EA6RLf1tHIYvHybU5C7/vJbpAwGu6zD3N0LGKtCVlu4prCYh+3WqLXqplBwavp3ldmJ0my
 TnVE6kWjAWv5sPhtRFEPt5qBtRlpono=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Fps4fZjaObyOM-SADQkSmg-1; Sun, 12 May 2024 06:50:25 -0400
X-MC-Unique: Fps4fZjaObyOM-SADQkSmg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59c69844aaso207767266b.0
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511022; x=1716115822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gg0/8OEdOJATol7CmuQ+nthGOZbWRnfNOiRj2A7n9c0=;
 b=IWAXO8NQHl1BBpA1JQUIuKg8ZkY4uItNkJu7AUugC19maTFWTfMZDk8RvJoaKgA0/2
 OxOnFRtGZtihIJcGtWL/TZzNeXyfr07vnU2tOdhL8XxJxm7mm3Dz6OT+2C8fCIt8ZxAp
 1qcwKJrNky83txj/7qsfTuJ4oaKl3vIajYaGGCOBBQPZKiuVI25hPVkzXyRNTC6t9EYt
 Ud3iZwHQ7pAqPcsvXQLGxEUq0iFMBkXIlqVfRqoI5nHgb7ijQMUPQLexRPUOeVik3EKr
 uaC2gY3QRClhc/vTKOB10kUr6TxSgIy4ICM6aDOxhB2Uo8xGhXnhjdfGnr3WZIBdgbrY
 j9Ug==
X-Gm-Message-State: AOJu0YzhsePxCDgxF0ScSwynUENImK1AkRZvh7syD0ZAXr3WRhNn3OCL
 nYIfLboY5WRWlHQf0cF/5Tjh+YVfDscqkfcnIp9M5IyzrV0ZPnDF1wRTAEhqPE/eA8ViVer3vdd
 ceZce5+woDs9sMz3s51h9736QVS5AppKAqCS8Gwf4GC+X+dgxVJyFXsvrePx5pqP2+l3i6+fOeV
 pYQMLhDiKXUtbTGZ5+opuU7ImAzxq8xQd9hJNY
X-Received: by 2002:a17:906:2dd0:b0:a59:cfe5:947d with SMTP id
 a640c23a62f3a-a5a2d5f1569mr497867366b.40.1715511022458; 
 Sun, 12 May 2024 03:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdvYhROVrS9O6mAElgd92Jwz+1YgT4jc4eaASbcgNxqMgpMZSL9LubZksugO8ZbR5SmTcbmw==
X-Received: by 2002:a17:906:2dd0:b0:a59:cfe5:947d with SMTP id
 a640c23a62f3a-a5a2d5f1569mr497866766b.40.1715511022106; 
 Sun, 12 May 2024 03:50:22 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d6dsm444472866b.71.2024.05.12.03.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/27] tests/qtest: s390x: fix operation in a build without any
 boards or devices
Date: Sun, 12 May 2024 12:49:31 +0200
Message-ID: <20240512104945.130198-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Do the bare minimum to ensure that at least a vanilla
--without-default-devices build works for all targets except i386,
x86_64 and ppc64.  In particular this fixes s390x-softmmu; i386 and
x86_64 have about a dozen failing tests that do not pass -M and therefore
require a default machine type; ppc64 has the same issue, though only
with numa-test.

If we can for now ignore the cases where boards and devices are picked
by hand, drive_del-test however can be fixed easily; almost all tests
check for the virtio-blk or virtio-scsi device that they use, and are
already skipped.  Only one didn't get the memo; plus another one does
not need a machine at all and can be run with -M none.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240509170044.190795-6-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/drive_del-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 8a6f3ac963d..7b67a4bbee4 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -173,7 +173,7 @@ static void test_drive_without_dev(void)
     QTestState *qts;
 
     /* Start with an empty drive */
-    qts = qtest_init("-drive if=none,id=drive0");
+    qts = qtest_init("-drive if=none,id=drive0 -M none");
 
     /* Delete the drive */
     drive_del(qts);
@@ -192,6 +192,11 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QTestState *qts;
 
+    if (!has_device_builtin("virtio-blk")) {
+        g_test_skip("Device virtio-blk is not available");
+        return;
+    }
+
     snprintf(driver, sizeof(driver), "virtio-blk-%s",
              qvirtio_get_dev_type());
 
-- 
2.45.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9942CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNHD-0003VO-SS; Wed, 10 Sep 2025 12:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGr-0003AL-DG
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwNGo-0004Vs-6B
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757520125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk2p/fZ62GE+HVK96dUx6wUZhpLCmZYAlpZ+g5YJz3U=;
 b=iXQ+jE+CAAaH8qRrVcZnGiyIFkTM+mQzPwXDT+cyw0QuiILrlqKfMo+tAg93hdEuqB6SSr
 l3Ej6nCw0+rJkS1Mam2Rc8xVx0bCJoLLO8S0INUiPWl9EHovwZl8wt0fSSkeCZW/f1f6hB
 DvuYA2PL5t2buLCkOZzwntcmf1NCoKo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-qt1OKEMJOa6zm2FYoEVGSg-1; Wed, 10 Sep 2025 12:02:03 -0400
X-MC-Unique: qt1OKEMJOa6zm2FYoEVGSg-1
X-Mimecast-MFC-AGG-ID: qt1OKEMJOa6zm2FYoEVGSg_1757520122
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ff94e5c251so225352385a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757520122; x=1758124922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pk2p/fZ62GE+HVK96dUx6wUZhpLCmZYAlpZ+g5YJz3U=;
 b=ZeCpm9JUnQrGxgSFNKg3UDTXor3EDbWKkcIXAXkNI/pRigHzCODuT2XFUf//vUecnk
 vlwqaVfVUQGrT8PBUP4HY+sGR8ZomhBIqF7zflcUT7y4xs7XG73hT9P5LhlQRnzxj6L2
 Rqsa5tmA7uUza8OIrB1hU3YZYTHUFTt/34zeNnF1cG46hZSWCXiUv+cRwnwxb7UyPLaV
 xPPei2uZL0K17uJcThdZsCJ2lSGRmqpwVjxUCN6RFIY6/iJtkqSYxwvj5h/URjpvv0KZ
 QsRYwvbhsx7UDdY6P1/mA9xV37oqmmuHVepov4Mg80M0NDRA0OyMnsbxHd5CMwBNOVdt
 HPug==
X-Gm-Message-State: AOJu0Yy8k5z/SxgtUBUQKc1la0wPoHIGclesm47tsPbY7Xvx8OB1smCp
 bt2Tx8vIX7x3ndHmVNJpVPOZ+OBEtslQbh/o3evfhomla4xI/DMLMNh+aU4n/2uzGng9PwjxM8h
 LypwjUMHz2JqCYLUo7mSDrm+bo1Rp5pRMpCd/8+VVHPhjXVOoJmZ/pqUA7OVHoI6MT96uFiRTfp
 z+RZFkOs0GKzj1D00jYuOpKVtFN7HYFKFEXQ+P0w==
X-Gm-Gg: ASbGncuZLgXNceO/i7IKFQXIQkI4iR6Rh5BdzBeNrD17z2udoeR/T8TOwtLLfgt9U8S
 Bckq4YYwLuGg5g1WkrTZS5GvIttIMpjwcG6e3wuWtREIkhRWgb99zjt6gqvGPo4rv8DPmazKRpc
 K2xhsFFbKB5VUtsPI4as76Rbq1hNxWhmx2IR4jgAaE8yt+iAJsZzv/OhtU4i8xxp6AxHK3jZzXn
 0fVmjD82WLeJoN5EyfUGul/8KDhBYmEJQT0IQadIn1TNG1f5Fwx+MOehja0DgUlPi529qtacmKD
 odkebe6XzKokX6d5R30nhM/Oh7HDmA==
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id
 af79cd13be357-81ff181374emr16849285a.2.1757520122065; 
 Wed, 10 Sep 2025 09:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQx2xOVSmqUjrjn0K0j5L7e36/Uc3be7+P8Puidgf2AUD9TXTqBozLNygj0SCKXPJhPx9Veg==
X-Received: by 2002:a05:620a:414f:b0:7e8:8f35:1d2b with SMTP id
 af79cd13be357-81ff181374emr16832185a.2.1757520119930; 
 Wed, 10 Sep 2025 09:01:59 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61bbe0a85sm26655281cf.42.2025.09.10.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:01:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/3] migration: Make migration_has_failed() work even for
 CANCELLING
Date: Wed, 10 Sep 2025 12:01:43 -0400
Message-ID: <20250910160144.1762894-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250910160144.1762894-1-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We set CANCELLED very late, it means migration_has_failed() may not work
correctly if it's invoked before updating CANCELLING to CANCELLED.

Allow that state will make migration_has_failed() working as expected even
if it's invoked slightly earlier.

One current user is the multifd code for the TLS graceful termination,
where it's before updating to CANCELLED.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7015c2b5e0..397917b1b3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1723,7 +1723,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 
 bool migration_has_failed(MigrationState *s)
 {
-    return (s->state == MIGRATION_STATUS_CANCELLED ||
+    return (s->state == MIGRATION_STATUS_CANCELLING ||
+            s->state == MIGRATION_STATUS_CANCELLED ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1772D74943
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZm-0002N4-Ua; Tue, 29 Oct 2024 17:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZe-0002Lu-VE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZd-0007cc-EI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQg2SOV+gtaMkPFPn63KBHnXYSyfJvjfUv1rUTqt8SY=;
 b=ZOemug29mD5g5GBl6VbPIERzK1xBPwjFuC5A61/M+b3arMa3p3oqkXzNUXbhdqVhsh/AJk
 kUsuw8xhu4vlLPaIKxBs3tYhKBujMwYXq5ctGOfNXlnyP9Eat8Qzyu0ySgChMl0ndrennG
 z+OuIQvJTcKwJ1SQt9edSLdAPieDZ5I=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-E9RBDmIBO1u0I1Jjfxa4zg-1; Tue, 29 Oct 2024 17:16:19 -0400
X-MC-Unique: E9RBDmIBO1u0I1Jjfxa4zg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-6e36cfed818so96380897b3.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236577; x=1730841377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQg2SOV+gtaMkPFPn63KBHnXYSyfJvjfUv1rUTqt8SY=;
 b=PEki2zKATaVkh4JVI9WkGseN1UGSpSPAyvNHKtb34YDh3afkkgW7urF+iQkJN1cI0B
 N6ow4JgzoQg3AFiPvqEDAL4pC8NCkbbPPVHOK/0th9Ut73zSioUZJ0bXy1g7ediK+5YI
 IInrSQo6sNp1gjwUCijjz5COLdzZZmif2NcwmIS3TqUA8YJU+xKK8C2Fja2XbMjoxWtp
 Xy+r7TqdKS94T3cXiZEBM3ru/JGhzUg+WNpH5Wex1Lzy7HnoCuoCGKqCohfFiAJ1JX1X
 b00L14visg5TKiFBQsDtcCif1QjlwKLSgo1sQOPocvrqbL5m5thEvLl4t3TiVQ400tuV
 9i6w==
X-Gm-Message-State: AOJu0YwL6m8szPdNuhyXOTnbM1ruEvo4EqVkbhsG2CAfju0p1nag0jqk
 pe7X3cRGYo5SkzWg34Zjo9SXX8OSHlHHO8Hlp380mgpYt2WVy9XDLKVm3gFvN2n0Sf/71WWL+i/
 4k25w46cYsfCWcqHGyALJX8GfZo9ACw5kG+/WGEJCnpdd8kbon/t+/Qow2iV/BLm853logHJGdY
 xpDKZeIwE0E6timx+JrRsVfl7fRgsxNOa0YQ==
X-Received: by 2002:a05:690c:6409:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6e9d8a67b92mr140606747b3.20.1730236577557; 
 Tue, 29 Oct 2024 14:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzwTbs7FQjp0FYvD+rG65rEiZuh+usOEHFF1wFPh2XZe/AXARhV0v4XxIS9qqQL079XSuevA==
X-Received: by 2002:a05:690c:6409:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6e9d8a67b92mr140606357b3.20.1730236577122; 
 Tue, 29 Oct 2024 14:16:17 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 3/7] qdev: Make device_set_realized() be fully prepared
 with !machine
Date: Tue, 29 Oct 2024 17:16:03 -0400
Message-ID: <20241029211607.2114845-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We're going to enable qdev_get_machine() to work even before machine is
created.  Make device_set_realized() be prepared with it.

Currently, a device can be realized even before machine is created, but
only in one of QEMU's qtest, test-global-qdev-props.c.

Right now, the test_static_prop_subprocess() test (which creates one simple
object without machine created) will internally make "/machine" to be a
container.  Now explicitly support that case when there's no real
"/machine" object around, then unattached devices will be put under
root ("/") rather than "/machine".  Mostly only for this test case, or for
any future test cases only.

Note that this shouldn't affect anything else that relies on a real machine
being there but only unit tests like mentioned, because if "/machine" is
created as a container as of now, it'll fail QEMU very soon later on
qemu_create_machine() trying to create the real machine, seeing that
there's a conflict.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d91..5c83f48b33 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -490,9 +490,17 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
+            Object *root = qdev_get_machine();
 
-            object_property_add_child(container_get(qdev_get_machine(),
-                                                    "/unattached"),
+            /*
+             * We could have qdev test cases trying to realize() a device
+             * without machine created.  In that case we use the root.
+             */
+            if (!root) {
+                root = object_get_root();
+            }
+
+            object_property_add_child(container_get(root, "/unattached"),
                                       name, obj);
             unattached_parent = true;
             g_free(name);
-- 
2.45.0



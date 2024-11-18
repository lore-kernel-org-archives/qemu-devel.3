Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC83D60CE7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0H-0002ca-Gs; Mon, 18 Nov 2024 17:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA08-0002ap-96
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA06-0006a9-Qi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZKkIwjXMhfrstNwcJpim0+ZzeendomwDPK3S0mS1Ds=;
 b=KFJ3O7TsKKTL5GLTvg3PG3YVGHXLc13Qu58NLYct6sKk/KaefHUFXL0uardIlASnhnru0W
 YnOY5VvrGHi3Q/5QGKeWjR6sUPWyNzfyQsykjSZiU9yqL2OG64XKbiGGj1jpnI1LIP9b29
 NSoKtu/8vEBmQgBzPw16AJt/ODZdDKo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-72EtpsCAMny7D4Clk7ZMSA-1; Mon, 18 Nov 2024 17:13:40 -0500
X-MC-Unique: 72EtpsCAMny7D4Clk7ZMSA-1
X-Mimecast-MFC-AGG-ID: 72EtpsCAMny7D4Clk7ZMSA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83acaa1f819so34427839f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968019; x=1732572819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZKkIwjXMhfrstNwcJpim0+ZzeendomwDPK3S0mS1Ds=;
 b=D61uJ/Mgw4kT7/4hi9vwNUVckwOR+D/m6dIDzBuKBIAHVLbFZrgQQkVHP3aGbO8ajA
 JRJc/Ihci4bsheo4d+eQnGgkd/KihSeEro+IeoizsPv2fF7W/4XwWzZ/LrXrZSnS7zrR
 vZ3Z8tzxPXoshrA4psdzet9W+jwRrCgO4pPfFxF1nHqoXdtGtcG2CEXNVHikQ15hdxqc
 ywjWWDFCDPm/VOqpeyrZ/sQlKyXas0xXt6Xi61Bybbo21bUfbSd3XXIRLaVkdGhuddBA
 ZUoBxK2KFF1JJ3u/YW0RQyL80AhBvue4/aKXkweRb5cN9GCx15SBLc0BhMCyWdRn+CAf
 eJ9Q==
X-Gm-Message-State: AOJu0YzXFJyZu4lgijJ6GzB7R+zyZ2YfgU7O596/6OczNLmBSzu4QUFu
 fUwwZGhMkbajeowH4a0Ets2X8oR0CJD2n8SrYg9wyWzXRIsObjfEqyurKHRxFY/C2dkLQgRjDo6
 HE+lECH7Se078y0gYZtaO3X0Im/HEtLczMHkL6tfCMZ8qBWS97srAan/NwwLXeiUA5kYsweOFS+
 NPNbdFzGONu2YcVaU6neUIVoSeZObVOx1mSw==
X-Received: by 2002:a05:6602:140b:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-83e6c2769a9mr1428673339f.5.1731968019059; 
 Mon, 18 Nov 2024 14:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHj5nCsTmeS8gUs5fyoGl0mMlhiXeuHMQ9rPbQUbR7m5YXVG1fBsFXz7tNpxK62x5m9xXjeQ==
X-Received: by 2002:a05:6602:140b:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-83e6c2769a9mr1428670439f.5.1731968018702; 
 Mon, 18 Nov 2024 14:13:38 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:37 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] qdev: Make device_set_realized() always safe in tests
Date: Mon, 18 Nov 2024 17:13:28 -0500
Message-ID: <20241118221330.3480246-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241118221330.3480246-1-peterx@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Currently, a device can be realized even before machine is created, but
only in one of QEMU's qtest, test-global-qdev-props.c.

Right now, the test_static_prop_subprocess() test (which creates one simple
object without machine created) will internally make "/machine" to be a
container, which may not be expected when developing the test.

Now explicitly support that case when there's no real "/machine" object
around, then unattached devices will be put under root ("/") rather than
"/machine".  Mostly only for this single test case, or for any future test
cases when some device needs to be realized before the machine is present.

This shouldn't affect anything else when QEMU runs as an emulator, as that
always relies on a real machine being created before realizing any devices.
It's because if "/machine" is wrongly created as a container, it'll fail
QEMU very soon later on qemu_create_machine() trying to create the real
machine, conflicting with the "/machine" container.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77..eff297e584 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -475,9 +475,17 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
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



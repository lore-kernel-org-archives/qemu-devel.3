Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE7BD743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshV-0008N6-TF; Wed, 20 Nov 2024 16:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshS-0008HG-CM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshM-0006Nc-0y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pICttktoPXP0o0Y91pyX8XPxkopJ/YUp6Q3y8ZWPysw=;
 b=Yz5HZiZFsL94Nk0YkAX3/+KnCkMf+WpxMDpND2hREMLxf1QmtIqvQtFnU2tIpwV5dBawZX
 zZOYiamq/9p/KxIfVEbM7FID5+jm3E9BB9vB2rs6+BVcWlnVq6eoIcyJ/wbhFFrowGWrIE
 YIZHE2p4ezNAyDM0nh/nz+SVyQosfRA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1IY-uPhtNOSdKosa8ao_-g-1; Wed, 20 Nov 2024 16:57:16 -0500
X-MC-Unique: 1IY-uPhtNOSdKosa8ao_-g-1
X-Mimecast-MFC-AGG-ID: 1IY-uPhtNOSdKosa8ao_-g
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e3810bac8a7so381404276.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139835; x=1732744635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pICttktoPXP0o0Y91pyX8XPxkopJ/YUp6Q3y8ZWPysw=;
 b=hAB1nmOCPuBCpXaE5K5f0ZnyccsadtHxg34fMTN0RZzUqZkkc9ChX2th3ZChPYFsFg
 YyTWw8mOi27tro3JMs33VK3jtbbhZsqX6UPZDp1HjiYEFfnt5lbh726nH5Z4B1MKGvVh
 /uF74OVlxfASDs9SiI8hyBpjAkWCmRg+K63sVzi0JkJ+K+EqtoVD1zwPkzWXZbe+589K
 yYQMCSl44O4daqvOsm5MSSi8BGvjYFPYGvcvyCZmiW3HInqw0BVg05FOr98q6suSi1ER
 L/EsuhPhOF607+nKZZ1nq9kEjl1Dk96rIkk1lJW7FJ3vi6MJX1J7KVhF6+ZDTJfpE83o
 10gQ==
X-Gm-Message-State: AOJu0YwevQqnp5L9cxGOtiSeyUiCjwxqPUAWaegOrxEQHuIlPGPWLzGM
 3i5E5ImSLC9TmpKMnEnxlP8jZYEYQya2LIVBWDjemb0MW/DUKIGTUGWDoIWsUiWDig1kpDz3VBT
 lNV41UgC85AzTdiCkp244WA9USgElWuym3s3jiHRIQdfs1KvqFJDZT9HEl+LXhz/okqky8hS52S
 ffQL4McPNPtzyEYAsMHddJPA9LUg6v6AUZ7Q==
X-Gm-Gg: ASbGncvOEeuCeebhbzqvAZY0tUxgKrqT4jbELIkoOLZBAX6knqOrAaYiGRnCk5FptbP
 CANWyddG5lkgb42/yLEivpGgwPdbGSzI9gfQFnHGQw0whWUqinIZUjDo9bhbLjenu78Et7OMBwV
 rUBQXzRPRZ3VO+z/NkZqQ6oGPjtDcKvH+Ov2lbF8ewexTPjNGiYWC69b33f1ivglRgcJr8G0y1i
 8TuzCqkCBn2B9AqxoLrH3YMWDPdPXRIBAj4DQbAHmctFm1SVuEF8yd46Azf6u3DxBNrLFWA4/1h
 UUkvX+udKAZy5PINFCW8s4XT+g==
X-Received: by 2002:a05:6902:2e0e:b0:e38:93af:4133 with SMTP id
 3f1490d57ef6-e38cb6066e9mr3863420276.41.1732139834941; 
 Wed, 20 Nov 2024 13:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUWF+4Xxud9q4OD9MX2uvolLtY/o7drR2XN10wxtEIDYuzVPDAw9ukLzatAzW5nqDVdIbuVw==
X-Received: by 2002:a05:6902:2e0e:b0:e38:93af:4133 with SMTP id
 3f1490d57ef6-e38cb6066e9mr3863392276.41.1732139834639; 
 Wed, 20 Nov 2024 13:57:14 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:13 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 04/12] tests: Explicitly create containers in
 test_qom_partial_path()
Date: Wed, 20 Nov 2024 16:56:55 -0500
Message-ID: <20241120215703.3918445-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Drop one use of container_get(), instead switch to the explicit function to
create a container.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/unit/check-qom-proplist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 79d4a8b89d..21b1e167ca 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -610,7 +610,7 @@ static void test_dummy_delchild(void)
 static void test_qom_partial_path(void)
 {
     Object *root  = object_get_objects_root();
-    Object *cont1 = container_get(root, "/cont1");
+    Object *cont1 = container_create(root, "cont1");
     Object *obj1  = object_new(TYPE_DUMMY);
     Object *obj2a = object_new(TYPE_DUMMY);
     Object *obj2b = object_new(TYPE_DUMMY);
-- 
2.45.0



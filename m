Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88653D60CE7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0G-0002c6-EX; Mon, 18 Nov 2024 17:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA0D-0002bQ-GF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA0B-0006b5-BB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXzfw9o4nT7WUK2zu/6zAHs2gJrz7J7+TmVnzn6XJeY=;
 b=d5MJCAACqs3cVn1fHndOx1DVn/CtG4rLwFaY3wO1XQIEBf4/09GEpb3HomwautjtkTmrb3
 EwJuBBgVgUzSxNzzme2Lwoc3kjSwMvkECseX4Sa9yKfQP37luHnUGU09CAzQ8U5UNHt+lT
 5/qQ3dKbAnIf3mRL5FJamwoKiBvBJP8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-P7z2U-miP3SzZiYGt3dLaA-1; Mon, 18 Nov 2024 17:13:44 -0500
X-MC-Unique: P7z2U-miP3SzZiYGt3dLaA-1
X-Mimecast-MFC-AGG-ID: P7z2U-miP3SzZiYGt3dLaA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83aa904b231so368088139f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968023; x=1732572823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXzfw9o4nT7WUK2zu/6zAHs2gJrz7J7+TmVnzn6XJeY=;
 b=w70aVvaNoblgxHFimMZIXNfjLTA4rV1rv4rztPP0JcAcVK9GCSGJjJSSqLZ/ROH8jY
 XgFofSBcr8lC+wFbmVBkBHoxGfcn48/NEFpP5yLGvmqbEWVbXt7efT+L+XpBSAA+se/J
 iMRbEQRT6w0OPw+6qyp8hLrgjnP74gH4LxtCdTr01R9RbkdcEALWNivTdzdSAemYYwpR
 nahxanSfjYzGmc3zBHlSzpS2iuHYVdq7syc+VJ1aV5ZLw29MmtgNGb+DFW3lU6mentGY
 ZER9Lzu36t2CHLCpIlqvxhx6lITmxU7HQkg3E2y4sUg74BxVTJG3JpzxWIlHq2+N9E/a
 r1ig==
X-Gm-Message-State: AOJu0Yy/b4S8ttBsE/Agl0UMpuRvFLbq1nBKe4fCDyzUe1ja8Crgd3lZ
 qeF7qcueXT3lu9nyVp1AdlxV4MvafAA1EhdCBuFnTdE/s8YU77rA6dM98EzGHt25KihOgQs9Iva
 8ONDJ7bQpjaRydxcjEzLaNKt8q5vdGH0nQ3ohz4uExHb59tg+5qZfKVAKFx+Yg+jxShWLEAM0Xg
 tuRimMz32mEZhfVw40t+nkRTqD6d1IBM+X6g==
X-Received: by 2002:a05:6602:3403:b0:83a:b52b:5cb5 with SMTP id
 ca18e2360f4ac-83e6c08a89emr1487552739f.5.1731968022706; 
 Mon, 18 Nov 2024 14:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA7MEJQ/DGJhF7+S9e34svPxUSv0zqWUNK/n6ePKLJkeb/aFkdoDjcHze7TbqvrdjYe7CSuQ==
X-Received: by 2002:a05:6602:3403:b0:83a:b52b:5cb5 with SMTP id
 ca18e2360f4ac-83e6c08a89emr1487549439f.5.1731968022358; 
 Mon, 18 Nov 2024 14:13:42 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:41 -0800 (PST)
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
Subject: [PATCH 5/5] qom: Make container_get() strict to always walk or return
 container
Date: Mon, 18 Nov 2024 17:13:30 -0500
Message-ID: <20241118221330.3480246-6-peterx@redhat.com>
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

When used incorrectly, container_get() can silently create containers even
if the caller may not intend to do so.  Add a rich document describing the
helper, as container_get() should only be used in path lookups.

Add one object_dynamic_cast() check to make sure whatever objects the
helper walks will be a container object (including the one to be returned).
It is a programming error otherwise, hence assert that.

It may make container_get() tiny slower than before, but the hope is the
change is neglictable, as object_class_dynamic_cast() has a fast path just
for similar leaf use case.

Link: https://lore.kernel.org/r/87pln6ds8q.fsf@pond.sub.org
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qom/container.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/qom/container.c b/qom/container.c
index cfec92a944..ff6e35f837 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -24,6 +24,20 @@ static void container_register_types(void)
     type_register_static(&container_info);
 }
 
+/**
+ * container_get(): Get the container object under specific path
+ *
+ * @root: The root path object to start walking from.  When starting from
+ *        root, one can pass in object_get_root().
+ * @path: The sub-path to lookup, must be an non-empty string starts with "/".
+ *
+ * Returns: The container object specified by @path.
+ *
+ * NOTE: the function may impplicitly create internal containers when the
+ * whole path is not yet created.  It's the caller's responsibility to make
+ * sure the path specified is always used as object containers, rather than
+ * any other type of objects.
+ */
 Object *container_get(Object *root, const char *path)
 {
     Object *obj, *child;
@@ -31,6 +45,7 @@ Object *container_get(Object *root, const char *path)
     int i;
 
     parts = g_strsplit(path, "/", 0);
+    /* "path" must be an non-empty string starting with "/" */
     assert(parts != NULL && parts[0] != NULL && !parts[0][0]);
     obj = root;
 
@@ -40,6 +55,12 @@ Object *container_get(Object *root, const char *path)
             child = object_new(TYPE_CONTAINER);
             object_property_add_child(obj, parts[i], child);
             object_unref(child);
+        } else {
+            /*
+             * Each object within the path must be a container object
+             * itself, including the object to be returned.
+             */
+            assert(object_dynamic_cast(child, TYPE_CONTAINER));
         }
     }
 
-- 
2.45.0



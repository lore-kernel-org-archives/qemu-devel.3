Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70BBD743E5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshS-0008JW-W8; Wed, 20 Nov 2024 16:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshQ-0008DK-6K
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshM-0006NB-0a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkBr4/YGRnjJuK64Ii4EqzW3873kCqGgygaLDsnSuN8=;
 b=ilErEUMwsK83t+U9kO1+g4nS7eNXK3Z1WjLj8Hlx8FfnkwHCQRu+LzB93/4qPY4K9NlRDS
 CWIWRkR6th/HPKieI4yTVu6fjV/Brt+a6a5S6DdCLAdGhNwn4FanGbSydSwN8zVwZMW68V
 5R59/1u8UHojAKpk8CJTp031ic9TajU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-9-aAGFOhMCWGCs0jJBBhZg-1; Wed, 20 Nov 2024 16:57:12 -0500
X-MC-Unique: 9-aAGFOhMCWGCs0jJBBhZg-1
X-Mimecast-MFC-AGG-ID: 9-aAGFOhMCWGCs0jJBBhZg
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5ee2aa2335eso259823eaf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139831; x=1732744631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkBr4/YGRnjJuK64Ii4EqzW3873kCqGgygaLDsnSuN8=;
 b=u7XtJCWkl1amvWvKZCMxguQp+Rvfu2dIHEFRtcT3qMPEiloo8pRUC2d2XKavkeZq9b
 KQ5OcitV2jsOUTWim9IUgkNbSaKrZ5GAhhVshgj2byfoo+EOdeZgnQHnVDiu7ZSA6MRT
 jDf8eD7e9hEXrqtSGuRvTae0xIM/rXYZ2GvWbaSTe5xz8XFRk0H4qWxYrkC2cQ22nsrM
 CVg/OojhPiVal4gPSqu46L8YHZQ8rYaK0qp5EbI0Y958rqm9Or9lN04qS8K6QlWQIX2u
 qhjfSd2ZXT8QYlvWSuujGnpSB9xsZ6OtHol/Ao4LijSryJuHlVQPUf36xgTuH9wNFb+J
 hwdQ==
X-Gm-Message-State: AOJu0YyEl3g90ATn5H5T0hwKoI3XLoJsNSucpUq6JagMWmhwOGwW29+G
 Dxzl2evrJCaPrErJxa/+kLz/9RkzBPT9KCVwy63CLnOTyhWQx2he1lRuldL5zTe50EmMWp6+0xA
 2WVGtTn03xhZWpAk9RulYCd4lNt7pfuoswL8CRWCv7D8NuJpbdp0282djkur9OVQ+WwUo1dWuUG
 U9JYFx+4YG8XmedLB1+jTR9YP6TczD7F9vlA==
X-Received: by 2002:a05:6218:2882:b0:1b8:5e16:1a07 with SMTP id
 e5c5f4694b2df-1ca6649a9d7mr311131655d.12.1732139831635; 
 Wed, 20 Nov 2024 13:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL8RcWCANarTbMKguwXKmUyYUxfovP7K0iH2wS0BWp/YCbkB2tDPZE6j3kXW9Rgvycno6XMg==
X-Received: by 2002:a05:6218:2882:b0:1b8:5e16:1a07 with SMTP id
 e5c5f4694b2df-1ca6649a9d7mr311129355d.12.1732139831330; 
 Wed, 20 Nov 2024 13:57:11 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:10 -0800 (PST)
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
Subject: [PATCH 02/12] qom: New container_create()
Date: Wed, 20 Nov 2024 16:56:53 -0500
Message-ID: <20241120215703.3918445-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

To move towards explicit creations of containers, starting that by
providing a helper for creating container objects.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 12 ++++++++++++
 qom/container.c      | 18 +++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3ba370ce9b..41ef53241e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,18 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *container_get(Object *root, const char *path);
 
+
+/**
+ * container_create:
+ * @root: root of the object to create the new container
+ * @name: name of the new container
+ *
+ * Create a container object under @root with @name.
+ *
+ * Returns: the newly created container object.
+ */
+Object *container_create(Object *root, const char *name);
+
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/container.c b/qom/container.c
index cfec92a944..da657754a4 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -24,6 +24,20 @@ static void container_register_types(void)
     type_register_static(&container_info);
 }
 
+Object *container_create(Object *obj, const char *name)
+{
+    Object *child = object_new(TYPE_CONTAINER);
+
+    object_property_add_child(obj, name, child);
+    /*
+     * Simplify the caller by always drop the refcount directly here, as
+     * containers are normally never destroyed after created anyway.
+     */
+    object_unref(child);
+
+    return child;
+}
+
 Object *container_get(Object *root, const char *path)
 {
     Object *obj, *child;
@@ -37,9 +51,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new(TYPE_CONTAINER);
-            object_property_add_child(obj, parts[i], child);
-            object_unref(child);
+            child = container_create(obj, parts[i]);
         }
     }
 
-- 
2.45.0



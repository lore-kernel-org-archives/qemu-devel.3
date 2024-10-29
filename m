Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9033D2AB33
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lJB-0006Ap-7I; Tue, 29 Oct 2024 08:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIm-00067s-FJ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIj-0000Ta-Ss
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730204781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=45MBX6aNgqsN2wiv/WXqRIpWZQdipkdsz1mMqox8E0Q=;
 b=RN9nhNFfaFIhY+TjzaM5XY6UgYCo8PAPNC6hjcVy2P+vB9AYlFa93XKbOqZ1jYuCdvNa/k
 taXUThM8lmEgMBi6u+6jJHhmuAuMUHQW6b6/KS1A/Cwm6yNUWDi/mGTN4VWtoQBYtyF9JB
 fgcwjgzdBtCgprAX5hM8h8mLabJhSwQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-QlWBdyfOOpCEbDQUWjGgzA-1; Tue, 29 Oct 2024 08:26:19 -0400
X-MC-Unique: QlWBdyfOOpCEbDQUWjGgzA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539e03bfd4aso4297215e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204776; x=1730809576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45MBX6aNgqsN2wiv/WXqRIpWZQdipkdsz1mMqox8E0Q=;
 b=Lm1WTuQyJh/HEHfLu06lK3ichMaWqYrjEb80bVJSB8lCK9ObDdqCSCtNz49IJgQ+42
 ZDxUr3w7D0+sQdYeTc1+hKWZ1RRG/r7lF3B7i3t8gTT/boK3m4+DR9PWf6LavffXJFpz
 Vjpv/uTFMX7JljSS1AEDJggzSMp6KQCZfO04prnoSSyGR6uKFxNJpXmNLDnyGdykmgq2
 s00Osb6wi0D27Js5afjo01WZuNxdfrfxIMBXFa+dU2YyCa30YJdV6JOZFDfTgn7abPWA
 cBzd4QIlUCChBLHn6xd3spiliJzzDmkROQv/Fd7Qj9odeiqrhE3Xqz0g0Pxig89l1CbL
 H/MQ==
X-Gm-Message-State: AOJu0YwWM0T+i6ydIv8gwap0POvEK6OyMmGj+1Syqj6CNjlo9eKZ2zyM
 9zMyI0RbEGcz9M0EF5p6j7R9HiiDbxkr5zDd3zQFpgQHMz+IdgVmuyyh5F72hzTJyYtk8jFo1Dj
 Wxpr88yzIg1pRqbgsL5e5bf54yYEiA4PGKwFQmmOJsdkFE5oi9tHxJHgjSFYHBeO3mPnxtPQ9I9
 uFITwRGUCvuk+bSryQDpou2RVfse9qilx0ElPxxKs=
X-Received: by 2002:a05:6512:ba2:b0:539:968a:9196 with SMTP id
 2adb3069b0e04-53b34a2d6e3mr4928774e87.48.1730204776198; 
 Tue, 29 Oct 2024 05:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1vsDurwYa4Uy/mtUm3yRQiII7PrCndzfPuDQG7Dtn7vMEkeTE6OxRtmKJDnL87risDM8mbA==
X-Received: by 2002:a05:6512:ba2:b0:539:968a:9196 with SMTP id
 2adb3069b0e04-53b34a2d6e3mr4928756e87.48.1730204775709; 
 Tue, 29 Oct 2024 05:26:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm176900505e9.42.2024.10.29.05.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:26:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 2/5] qom: use object_new_with_class when possible
Date: Tue, 29 Oct 2024 13:26:06 +0100
Message-ID: <20241029122609.514347-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029122609.514347-1-pbonzini@redhat.com>
References: <20241029122609.514347-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A small optimization/code simplification, that also makes it clear that
we won't look for a type in a not-loaded-yet module---the module will
have been loaded by a call to module_object_class_by_name(), if present.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c          | 5 +++--
 qom/object_interfaces.c | 2 +-
 qom/qom-qmp-cmds.c      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 17c454334c6..5f13111b77c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -151,10 +151,11 @@ DeviceState *qdev_new(const char *name)
 
 DeviceState *qdev_try_new(const char *name)
 {
-    if (!module_object_class_by_name(name)) {
+    ObjectClass *oc = module_object_class_by_name(name);
+    if (!oc) {
         return NULL;
     }
-    return DEVICE(object_new(name));
+    return DEVICE(object_new_with_class(oc));
 }
 
 static QTAILQ_HEAD(, DeviceListener) device_listeners
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe4..1f2aa133066 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -108,7 +108,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
     }
 
     assert(qdict);
-    obj = object_new(type);
+    obj = object_new_with_class(klass);
     object_set_properties_from_qdict(obj, qdict, v, &local_err);
     if (local_err) {
         goto out;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e91a2353472..69a8e17aa80 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -141,7 +141,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    obj = object_new(typename);
+    obj = object_new_with_class(klass);
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-- 
2.47.0



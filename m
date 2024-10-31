Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C487ED767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLm-00084v-9L; Thu, 31 Oct 2024 13:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLk-0007pw-8P
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLi-0007GQ-Os
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfba/UHETDOvAkP4r9RhYwdVIJo0wsPVpSzZlR5EAfU=;
 b=UByFgnmdIke8JKztm62tABr2XOsslZ5+46vPKNqRD4rCqyuTpsHTJkUX3n0P2fJ0InqQti
 C70nXMqY9xRarmQnarVCSpJwvH1tfY2FRrNuoT7SSD/g4ZVmtpYMegi8gSmrUq2LWNn/vl
 Fxl7VPx3Mld31OJ7elXMCIQi3etz6Lw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-QywuBUjcOLiop5sYu8DBaw-1; Thu, 31 Oct 2024 13:52:44 -0400
X-MC-Unique: QywuBUjcOLiop5sYu8DBaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso7606855e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397163; x=1731001963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfba/UHETDOvAkP4r9RhYwdVIJo0wsPVpSzZlR5EAfU=;
 b=Myt37Gy4GBNDnsOwRbJl9OF79Yj2lBivjX3h9DwkF6sAHX2nn1lOYrY/py4cF+Z3oy
 A7r+HQeVgzZ0k6DptObxmej4Td1vy0KyUGByeJEAzGfeiFy6b6+cwqsPIp/5in49Lsu0
 i0ek6lF7+jb7zv+WPuSIZgyzCm5dpS6OYc1yWVMiHU2uH/kNTls/VuxCsTB0UWNmITRo
 pMl+v8ag1scVuxSZhe/fTSJDwxyVs6hsxjjo9Y2ZQ4YwCiNLaLoL0CU6d4cbwmWKy3to
 AokcH2phWz4y0gZFXUn8Kn4uY/GVv7nTCebyOGJUgHtNeBfJ3wiiT1dYjqvsOcU4RM6W
 5tOg==
X-Gm-Message-State: AOJu0Yw3q+AB8ZeS9oyj0eDyR40Y+Sf3YULHUHwOekbdrU4FcvsFuf83
 R8tBWd7w29jq3oZd7NP2H5N7XRAc/x9ZvK33MUT1E2ns4Ut5KJuiZDHOCOHF+D3z8IVWTLFlaNa
 PXn3D0odNGVPj9wIG0mTWaPn+LBVIaqv9OQMDUwWF1wwUqfqgs7AnCju2Te+AxIXTwjc8WEW4yx
 iB+dnN1rTO6DfiURtd5lwHRhghWcxfZ3v4PBVtK00=
X-Received: by 2002:a05:600c:3ca1:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-43283255489mr6241855e9.16.1730397163021; 
 Thu, 31 Oct 2024 10:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHR0nkJXTSEU7LAOrZrsrL5L8F/2CAA43KKld69FmMeetTVNZjTVk5eR1bXW3nTZAeEfjd3w==
X-Received: by 2002:a05:600c:3ca1:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-43283255489mr6241665e9.16.1730397162605; 
 Thu, 31 Oct 2024 10:52:42 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab2aasm33638185e9.6.2024.10.31.10.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/49] qom: use object_new_with_class when possible
Date: Thu, 31 Oct 2024 18:51:36 +0100
Message-ID: <20241031175214.214455-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

A small optimization/code simplification, that also makes it clear that
we won't look for a type in a not-loaded-yet module---the module will
have been loaded by a call to module_object_class_by_name(), if present.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c          | 5 +++--
 qom/object_interfaces.c | 2 +-
 qom/qom-qmp-cmds.c      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d914..2f740fa55e9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -167,10 +167,11 @@ DeviceState *qdev_new(const char *name)
 
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



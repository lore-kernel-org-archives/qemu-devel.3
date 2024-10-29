Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596DAD2AB33
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lIz-00069T-SP; Tue, 29 Oct 2024 08:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIn-00067y-OI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIm-0000Ts-6x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730204783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIaIDBHybs/Pj/BvXJs4xMHmbif5r8zGkXPmre/ozZk=;
 b=YTZaT8f+wAswkyGFpK5bFfrm2Mkh7MvnOcnUFI4DI9delbRl9G4eATi3Sn3zifIND2PGEx
 7AZZKt/BnqBnoOCAQ0dBLZvolSByzIEL1oSNF24fdmCyUgMf8GGEvk9jRV/7AHQh08U3p3
 SkLTzkvEqrFLPyIFV+RPuRSJFYb1Wvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-cYBvY7w1PvKlck1aBcJA9w-1; Tue, 29 Oct 2024 08:26:22 -0400
X-MC-Unique: cYBvY7w1PvKlck1aBcJA9w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so2693472f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204779; x=1730809579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIaIDBHybs/Pj/BvXJs4xMHmbif5r8zGkXPmre/ozZk=;
 b=tebK4BbIr4vVQ19qzcydk5+fRCQxoCqnjCABPJoIYoc9jK6BqTDXewj/e/msqqKc+8
 tEMiq7BnxBgI4qr4MaLvblHuUCR+mg2ZgEmG2qIVwOL9aUC1Zr5dxsXCGj2txDIcqb8t
 49/TbnlqNkfIRyp+BmegIMnj2aCT+nJSwVtYGVpKU8wxpKHrcib3XvcH9wWJkjllo7nE
 SueQ8BWqgIxno2DclU0WivfeJU4TzwrsU1s6tpZJ8GOpbK1NShuU7EsMx1hmFPJnIPew
 HCUUgLUP37wLRuMQES2O/tzTDj7zU4H7pJaXNdrGof3kGMCoArBQEZMZ+o60WRFP+ymJ
 paLA==
X-Gm-Message-State: AOJu0YyO5KennN4E6gZqPvDKw1LSG9qEN5B6YQ7KFzOAxvKnuHx44QlG
 g7cuBKACpNSUgRNl69OYkyettIPW0Z76TAfwbQUzAG/w1Y8ifdvWDN4z5kGED4mLleO/zZoIVF4
 166bvKK4ENc7oR7aacnAlThqo1sADkGEzG5K8UD/JQjYOIzX+KTB+t7xJPk1sCDOi4RFV9Nd0Ek
 WFhDhfxe6JB/IfQWhsRECAXnJGQI6l2+1iivtkhOk=
X-Received: by 2002:adf:a15b:0:b0:37d:4ebe:163e with SMTP id
 ffacd0b85a97d-38061206a7emr8724412f8f.53.1730204779329; 
 Tue, 29 Oct 2024 05:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLP5N+rEfoScK8OaHnyA4RUwo24MRf15noKsQRNED2KkE38vJeVxufErPK55eAb7acO3lnHQ==
X-Received: by 2002:adf:a15b:0:b0:37d:4ebe:163e with SMTP id
 ffacd0b85a97d-38061206a7emr8724386f8f.53.1730204778891; 
 Tue, 29 Oct 2024 05:26:18 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47a41sm12367568f8f.52.2024.10.29.05.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:26:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 4/5] qom: let object_new use a module if the type is not
 present
Date: Tue, 29 Oct 2024 13:26:08 +0100
Message-ID: <20241029122609.514347-5-pbonzini@redhat.com>
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

object_initialize() can use modules (it was added there because
virtio-gpu-device is a child device of virtio-gpu-pci; commit
64f7aece8ea, "object_initialize: try module load", 2020-09-15).
object_new() cannot; make things consistent.

qdev_new() is now just a simple wrapper that returns DeviceState.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 16 ----------------
 qom/object.c   |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d914..17c454334c6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -146,22 +146,6 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
 
 DeviceState *qdev_new(const char *name)
 {
-    ObjectClass *oc = object_class_by_name(name);
-#ifdef CONFIG_MODULES
-    if (!oc) {
-        int rv = module_load_qom(name, &error_fatal);
-        if (rv > 0) {
-            oc = object_class_by_name(name);
-        } else {
-            error_report("could not find a module for type '%s'", name);
-            exit(1);
-        }
-    }
-#endif
-    if (!oc) {
-        error_report("unknown type '%s'", name);
-        abort();
-    }
     return DEVICE(object_new(name));
 }
 
diff --git a/qom/object.c b/qom/object.c
index 29155c64639..9edc06d391f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -790,7 +790,7 @@ Object *object_new_with_class(ObjectClass *klass)
 
 Object *object_new(const char *typename)
 {
-    TypeImpl *ti = type_get_by_name_noload(typename);
+    TypeImpl *ti = type_get_or_load_by_name(typename, &error_fatal);
 
     return object_new_with_type(ti);
 }
-- 
2.47.0



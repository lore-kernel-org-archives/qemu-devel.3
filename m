Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B80D767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZOw-000827-Ub; Thu, 31 Oct 2024 13:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZOm-0007rJ-IA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZOj-0007r6-36
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/tt1SqqlB8D25bYmN5xYX/10Qo5xVW9NDVEd5fn2uc=;
 b=Si06bMlzRIw7YsCwfhuoqh9wUfqQBzODRp9wxmC+cogRDv5HYWL1uYcg8kroLU8XrOly5q
 UMXbijEExjo3C6uxE3T83bRyNO8lv/Ot7Rlray0KJYQZ8yZ5VN9PUvPdilfCqwAiUWIiyg
 +W4E6RsDVzXPF72D6SfG+GTWFEzZma4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-smfmtXyhMG-9BKuhus3L-Q-1; Thu, 31 Oct 2024 13:52:49 -0400
X-MC-Unique: smfmtXyhMG-9BKuhus3L-Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e13b8143so1297822e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397167; x=1731001967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/tt1SqqlB8D25bYmN5xYX/10Qo5xVW9NDVEd5fn2uc=;
 b=TCbXekujd7vfk2JJOwRkDZpH/imt/ngax9xAiPC9sMHNYtUjcgffQbdDwh/OURO+Px
 NoJONSAVoz2laN0zphovyUrOFe015Qjh5J+pykwuqmDfcGuvjYpkE1zjm1hJU8xk9crZ
 Xt68cPetusLvUYmViHVJVvgKXprsmfViii9p+xrR66eS1OgekRr92PXGArSkcz59B8oZ
 qYYtNK+Ldy55pheYLt9Xce4JXU+GQzK1NZ9O+YPJGqmqKITRsJxYtcykGtXLEVSp8zC0
 P2DTE5NCv84kINnSg8tPElqPLBIJXl1JXpeprIjFOsp5glImSAAdVnOQCS84dV7ZPaAG
 upKQ==
X-Gm-Message-State: AOJu0YyoRolrhXx9vchluQ5Mvy1ASLkN1VuYU4SPKHyoW2uqqJVt0plL
 hg2i74ntVkIEa0tas7TGY49xvi0aRx0jfC64+7xncfW1eR6qKpMM0O7j5gWC1r2xUWyFxOYt+Dh
 AMn656hWkUplgWxEjZG/qBFc9EldXU2mMCUoWqBa/rVeJzXbI6RVJo4TYNr9wM8Y2dkTKeUVW17
 0S0ADxiAGEzpdd8+5SoQOo37s0IxZS7YibIi0qzd8=
X-Received: by 2002:a05:6512:2211:b0:539:fcf9:6326 with SMTP id
 2adb3069b0e04-53c79e159c2mr2595768e87.6.1730397167176; 
 Thu, 31 Oct 2024 10:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKmtxxF0OpvT1OXJnK39G4TArnNRvO75s6fpV2sNE76ySrbKp/qr0z0YUXcPR9BUZd1LBhCg==
X-Received: by 2002:a05:6512:2211:b0:539:fcf9:6326 with SMTP id
 2adb3069b0e04-53c79e159c2mr2595750e87.6.1730397166589; 
 Thu, 31 Oct 2024 10:52:46 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7a9esm2807084f8f.21.2024.10.31.10.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/49] qom: let object_new use a module if the type is not
 present
Date: Thu, 31 Oct 2024 18:51:38 +0100
Message-ID: <20241031175214.214455-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 16 ----------------
 qom/object.c   |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2f740fa55e9..5f13111b77c 100644
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



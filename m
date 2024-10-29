Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A67BD74941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZm-0002N3-UV; Tue, 29 Oct 2024 17:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZa-0002Lh-LV
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZZ-0007cM-34
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kY+kbURi2Pxc2UnQSzuDl6KSUoQC+SP5OP047RlJNdA=;
 b=cbomNCfFVD1AFHSAaYXds2R5bR2LxZydIrUNBDSDCrRFOz2OovB6BdJdddb/sO7IFnxR97
 ND+xTY5wpwT2fuoC31T6vgy5KBSX0rovLUbOAVM1uC86Mx2lXeZsZ8HVdyebnsnHAV2n5f
 cGD8Y3ec7mIqYHrxXo6pkk5u1fOIKn0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-XXRtcpj2PMaKvtFwaHe2dA-1; Tue, 29 Oct 2024 17:16:15 -0400
X-MC-Unique: XXRtcpj2PMaKvtFwaHe2dA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7181a10a0bbso5006147a34.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236573; x=1730841373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kY+kbURi2Pxc2UnQSzuDl6KSUoQC+SP5OP047RlJNdA=;
 b=gw8A7H9sNjC/ov+1Pmrw0NLzjY5ehQbNrB853oqD2cEl1KW+HIwoFBkKUmDGEjHObA
 evHeBjm/VaBMYzzVUsFzf2mm2DwhvR1Y6IV+ifLWDDvlVCvTkBHkkGnsOIdkad4pmBU5
 DOhSGUVghqNBMtWnfck0YL8kH5H+Ix8pRQrK9oLZ/hm+PL+11JhghOBzyvSlEXFmES4w
 exVhGcyJhc5OpSOBIJ7DCt07Xngor5U6wCmhRGEoMenFLfcQuZFVnzXhAnZI+EaKICm/
 k2cSDOs4XcXTdntVlubshfgS9D4WGZYayMNJPPMMF2fwjoducyo8fXT0gWmuFFjVUtQ5
 Bk7Q==
X-Gm-Message-State: AOJu0YzfmnoXYayllHtfq/hJpVoI0jbnQZw7010yZSfzIPXdSEI2cqcn
 4/1N1Zyjued8IzKtzz5Pq5LgCq2tFpFRoUYF2HsPD1ru5y61fR2Uu1G89wowqnhhJahQODXl7V/
 t0N0KlQ/BIgB+pRKUlZibXs+OiO7G7UjTkUHQBQWA81TjwETfpGekr9WCPX2vpDlwNn21ZPVLR6
 I2QE9OGO70CrDtDsLwu0gX2CEJGWnGJ3htVA==
X-Received: by 2002:a05:6830:6001:b0:718:fcc:cf76 with SMTP id
 46e09a7af769-71867eb1b81mr14233948a34.0.1730236573431; 
 Tue, 29 Oct 2024 14:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo1LujMOyCXcfV15vIuQeNgLjRPkQ7LJc5r34HjPDZ/VLz4YMl2Vxa8htGQxlOEKsCoX+dSA==
X-Received: by 2002:a05:6830:6001:b0:718:fcc:cf76 with SMTP id
 46e09a7af769-71867eb1b81mr14233915a34.0.1730236572869; 
 Tue, 29 Oct 2024 14:16:12 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:11 -0700 (PDT)
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
Subject: [PATCH RFC v2 1/7] qom: Track dynamic initiations of random object
 class
Date: Tue, 29 Oct 2024 17:16:01 -0400
Message-ID: <20241029211607.2114845-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Add a helper object_new_allowed(), use it to track all the places in QEMU
where a new (and especially, random) object can be created.

Currently, it is some form of a cleanup, just to put together all the
errors where QEMU wants to avoid instantiations of abstract classes.  The
follow up patch will add more restriction on what object we can create.

A side effect of the cleanup: we could have reported the error message in
different ways even if the reason is always the same (attempts to create an
instance for an abstract class). Now we always report the same message,
could be different from before, but hopefully still worthwhile to change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h    | 13 +++++++++++++
 chardev/char.c          |  4 +---
 hw/core/cpu-common.c    | 13 +++++++++----
 qom/object.c            | 17 +++++++++++++++--
 qom/object_interfaces.c |  3 +--
 system/qdev-monitor.c   |  4 +---
 6 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2af9854675..32f1af2986 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -627,6 +627,19 @@ Object *object_new_with_class(ObjectClass *klass);
  */
 Object *object_new(const char *typename);
 
+/**
+ * object_new_allowed:
+ * @klass: The class to instantiate, or fetch instance from.
+ * @errp: The pointer to an Error* that might be filled
+ *
+ * This function detects whether creating a new object of specificed class
+ * is allowed.  For example, we do not allow initiations of abstract class.
+ *
+ * Returns: True if new objects allowed, false otherwise.  When false is
+ *          returned, errp will be set with a proper error message.
+ */
+bool object_new_allowed(ObjectClass *klass, Error **errp);
+
 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076..7fa5b82585 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -533,9 +533,7 @@ static const ChardevClass *char_get_class(const char *driver, Error **errp)
         return NULL;
     }
 
-    if (object_class_is_abstract(oc)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
-                   "a non-abstract device type");
+    if (!object_new_allowed(oc, errp)) {
         return NULL;
     }
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c7903594..1815b08ba0 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -154,12 +154,17 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
     assert(cc->class_by_name);
     assert(cpu_model);
     oc = cc->class_by_name(cpu_model);
-    if (object_class_dynamic_cast(oc, typename) &&
-        !object_class_is_abstract(oc)) {
-        return oc;
+
+    if (!object_class_dynamic_cast(oc, typename)) {
+        return NULL;
     }
 
-    return NULL;
+    /* TODO: allow error message to be passed to the callers */
+    if (!object_new_allowed(oc, NULL)) {
+        return NULL;
+    }
+
+    return oc;
 }
 
 static void cpu_common_parse_features(const char *typename, char *features,
diff --git a/qom/object.c b/qom/object.c
index 11424cf471..4f3739fd85 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -797,6 +797,19 @@ Object *object_new(const char *typename)
     return object_new_with_type(ti);
 }
 
+bool object_new_allowed(ObjectClass *klass, Error **errp)
+{
+    ERRP_GUARD();
+
+    /* Abstract classes are not instantiable */
+    if (object_class_is_abstract(klass)) {
+        error_setg(errp, "Object type '%s' is abstract",
+                   klass->type->name);
+        return false;
+    }
+
+    return true;
+}
 
 Object *object_new_with_props(const char *typename,
                               Object *parent,
@@ -831,10 +844,10 @@ Object *object_new_with_propv(const char *typename,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", typename);
+    if (!object_new_allowed(klass, errp)) {
         return NULL;
     }
+
     obj = object_new_with_type(klass->type);
 
     if (!object_set_propv(obj, errp, vargs)) {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe..d68faf2234 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -102,8 +102,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", type);
+    if (!object_new_allowed(klass, errp)) {
         return NULL;
     }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..5609e73635 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -255,9 +255,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
         return NULL;
     }
 
-    if (object_class_is_abstract(oc)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
-                   "a non-abstract device type");
+    if (!object_new_allowed(oc, errp)) {
         return NULL;
     }
 
-- 
2.45.0



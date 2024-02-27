Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94141C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret1J-00076g-Av; Tue, 27 Feb 2024 03:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1F-0006ue-CR
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:58 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1C-0007uD-DK
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:40:56 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so56117771fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023252; x=1709628052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6yWLTnbIVuSgabgdZE6+CbUi7y4Wg3nnktwesa/iZ0=;
 b=U65eYhk/PeJFL3WAaAxf++ol8F/5rQmNlsZZoFL1XHn4A7pow6IfjSM2JwwiQDiBb6
 HaumDhAr1eDA+SadYXdEnMRb5U+WPyWh9XAy/h+UcmrOcSfYRA3s6MOiowtUI4DIbQx/
 ufKT0t7MhlWmoqiUon+nRPODYVCNhQc2Q826me1wY4jNdZcM90zRrlYRN/1Vx+lQGFbX
 FaYV4ccVxEpqbjaQFjUIy0W81clbHa9m69/012jK7P9/b2FozHkqP7OdLXa8hIUiap94
 G+DaExg+TqTz4LthBm78JZjGUF56iEUqrVGtunZ/v5hxtH2WTeiZHPnQrGMQ3ShdW9rJ
 bWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023252; x=1709628052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6yWLTnbIVuSgabgdZE6+CbUi7y4Wg3nnktwesa/iZ0=;
 b=RZPCuDNYVVPg4xyL2V/VyBzyfzq+YQHhvVu1O+dqXnIvYjzRATGVBwL/pprW1IjtGn
 dloxceXjU2N1p0AZF1GPDleWBVR1hQ0VsYp1So5bZ3xf2WHeQUbZ282R5poagZZ40F0o
 iD5uQ4v6TMdtCO288jx7U8uJzYQS3PYrXogdKxLuENuAsY8FYURzWIPbeFDiymd/7j/u
 LVcsIXQwlqX8DT6vCtbjvyfEuqCKYUr3gU+dPuxCP2TLt64SPFGyQE7e9M4vaNqpYl5y
 yHPvMJGPbLDqnLR5hkSnogRl19hiY5UrGwCCxBc9HXoe+P7o3MioFGHmnru5uO2Y3NvF
 viYg==
X-Gm-Message-State: AOJu0YxeR5DjD4Pcj9egsECidTROtyeU2dmjhWD0lbNXaTJKL/rQF2M+
 qfxbyAdsxrJKaqyWcvJ1In3+ZhbalslrYYtlCq6WvY4anS0ULdpRU35/IbwpG93kW+Vlscl1Tyg
 S
X-Google-Smtp-Source: AGHT+IERriWrOmUZd6CiDb7F6TpFnr9Nj6guJjU0ve4EhUBPrD+c8ZRWTz+Z6wvVFxhPZtpPJvKLYg==
X-Received: by 2002:a05:651c:786:b0:2d2:a38c:d706 with SMTP id
 g6-20020a05651c078600b002d2a38cd706mr300847lje.17.1709023251896; 
 Tue, 27 Feb 2024 00:40:51 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 t6-20020a2e7806000000b002d2607e6d29sm1152340ljc.70.2024.02.27.00.40.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:40:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/30] hw/acpi: move object_resolve_type_unambiguous to core QOM
Date: Tue, 27 Feb 2024 09:39:26 +0100
Message-ID: <20240227083948.5427-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

object_resolve_type_unambiguous provides a useful functionality, that
is currently emulated for example by usb_bus_find().  Move it to core
code and add error reporting for increased generality.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-2-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 13 +++++++++++++
 hw/i386/acpi-build.c | 20 +++++---------------
 qom/object.c         | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index afccd24ca7..e9ed9550f0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1550,6 +1550,19 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
 Object *object_resolve_path_type(const char *path, const char *typename,
                                  bool *ambiguous);
 
+/**
+ * object_resolve_type_unambiguous:
+ * @typename: the type to look for
+ * @errp: pointer to error object
+ *
+ * Return the only object in the QOM tree of type @typename.
+ * If no match or more than one match is found, an error is
+ * returned.
+ *
+ * Returns: The matched object or NULL on path lookup failure.
+ */
+Object *object_resolve_type_unambiguous(const char *typename, Error **errp);
+
 /**
  * object_resolve_path_at:
  * @parent: the object in which to resolve the path
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d3ce96dd9f..896ff87519 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -192,21 +192,10 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
     *data = fadt;
 }
 
-static Object *object_resolve_type_unambiguous(const char *typename)
-{
-    bool ambig;
-    Object *o = object_resolve_path_type("", typename, &ambig);
-
-    if (ambig || !o) {
-        return NULL;
-    }
-    return o;
-}
-
 static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
 {
-    Object *piix = object_resolve_type_unambiguous(TYPE_PIIX4_PM);
-    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
+    Object *piix = object_resolve_type_unambiguous(TYPE_PIIX4_PM, NULL);
+    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE, NULL);
     Object *obj = piix ? piix : lpc;
     QObject *o;
     pm->cpu_hp_io_base = 0;
@@ -1428,8 +1417,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
            Range *pci_hole, Range *pci_hole64, MachineState *machine)
 {
-    Object *i440fx = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE);
-    Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE);
+    Object *i440fx = object_resolve_type_unambiguous(TYPE_I440FX_PCI_HOST_BRIDGE,
+                                                     NULL);
+    Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
     CrsRangeEntry *entry;
     Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
     CrsRangeSet crs_range_set;
diff --git a/qom/object.c b/qom/object.c
index 2c4c64d2b6..d4a001cf41 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2229,6 +2229,22 @@ Object *object_resolve_path_at(Object *parent, const char *path)
     return object_resolve_abs_path(parent, parts, TYPE_OBJECT);
 }
 
+Object *object_resolve_type_unambiguous(const char *typename, Error **errp)
+{
+    bool ambig;
+    Object *o = object_resolve_path_type("", typename, &ambig);
+
+    if (ambig) {
+        error_setg(errp, "More than one object of type %s", typename);
+        return NULL;
+    }
+    if (!o) {
+        error_setg(errp, "No object found of type %s", typename);
+        return NULL;
+    }
+    return o;
+}
+
 typedef struct StringProperty
 {
     char *(*get)(Object *, Error **);
-- 
2.41.0



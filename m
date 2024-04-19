Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FD1C071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqgW-0002nf-Cz; Fri, 19 Apr 2024 12:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001HM-CR
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeb-00019n-Gs
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-343f62d8124so1671013f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542396; x=1714147196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGiNId90k9KX3SXTPJi6tPTMfWtWfQF5tgGXpkmGlP0=;
 b=FrqCxC/NjLQLs/Gbie6xtXVMdAz7dcs83qPHEWSN4OR83iPUZL9ag+YDW+ffW+Dv5I
 n0XijXanJMjHoA0TaaqbzH3vd1fxZz/Cd7+Gjqbp/LHrIG3epytgYhzyz3JOGKRks+RL
 6fnvREsC+FzRpPFG4knSjNgT6mlAWxJ0ZnDhA015tgon8SIvfX11cVJw1WGmripldQwp
 BVc34e7ERoUd4IygyN3+sZTQPPSVvqC2zsvlaWOrmPHdlgeMdJ58PgyJ6SXvdtddGJfG
 dHezuNjg+20aFNoPBX8kAb0Jii9zZlno7EVYArvSIbmbmtmikW0wqtXMZiJHFOxtlppQ
 VVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542396; x=1714147196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGiNId90k9KX3SXTPJi6tPTMfWtWfQF5tgGXpkmGlP0=;
 b=dPx+JsXuc1KeZhDtpmWX7CtGVQDbucWNfHvYsynGcurKN18NorKPFreziTdG7fyclZ
 wKrwTlYTSgcVtRodl/5jRLHEYyaUXH5kRqbRQCjVfcuWbO7PvxDktY4eJtoz3FXuww4s
 nln6Z0FRKXqG858b8rBwnaRh/AK/slawIhme1SnQztIbtG7HuVc9dmDmIEWdlXn5O2ni
 vNO1ePSg4DfWBIw0hq6C9VSs2HZlYcvmhUmZbgLfb0SWoJZWoHEhDQFD49Sjz8dClwUF
 KmxyzVySmMtDVuEQg0Pyuws2Qaqlhhx5MXMAGFjwWcLBmm8y+JoiPgnOkCYzQWx4bDyW
 qCCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjskbTYkf09xQMSWXufyOkroyda7G8XAwPpV4j1pFkV1Y/abQjLxTysN0MDSMC29j6M/aAlM7V3/mTRON7CtHGfRkcWWE=
X-Gm-Message-State: AOJu0YzyUXi00NNrtSbSiT1we1f0w6elRHA1DAxPD//SaMq2jVJw48oU
 5dTZ5hcNfiR5xslq3NWRyuTB75M8L+mzjytw9pPSnBwxKKqX6+Yf9CfnPSquZbY=
X-Google-Smtp-Source: AGHT+IEhdxtppP9kmHLrBdgwLon9GtWvTfBqcoN9AEI8D9tYjvYBXXyC8l70AMes/yWD0DhD/oFlrA==
X-Received: by 2002:adf:e68d:0:b0:34a:4eac:2e43 with SMTP id
 r13-20020adfe68d000000b0034a4eac2e43mr1716233wrm.68.1713542396105; 
 Fri, 19 Apr 2024 08:59:56 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 14/22] target/arm/kvm-rme: Add Realm Personalization Value
 parameter
Date: Fri, 19 Apr 2024 16:57:02 +0100
Message-ID: <20240419155709.318866-16-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Realm Personalization Value (RPV) is provided by the user to
distinguish Realms that have the same initial measurement.

The user provides up to 64 hexadecimal bytes. They are stored into the
RPV in the same order, zero-padded on the right.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: Move parsing early, store as-is rather than reverted
---
 qapi/qom.json        |  15 +++++-
 target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 623ec8071f..91654aa267 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -931,6 +931,18 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# @personalization-value: Realm personalization value, as a 64-byte hex string
+#     (default: 0)
+#
+# Since: FIXME
+##
+{ 'struct': 'RmeGuestProperties',
+  'data': { '*personalization-value': 'str' } }
 
 ##
 # @ObjectType:
@@ -1066,7 +1078,8 @@
       'tls-creds-x509':             'TlsCredsX509Properties',
       'tls-cipher-suites':          'TlsCredsProperties',
       'x-remote-object':            'RemoteObjectProperties',
-      'x-vfio-user-server':         'VfioUserServerProperties'
+      'x-vfio-user-server':         'VfioUserServerProperties',
+      'rme-guest':                  'RmeGuestProperties'
   } }
 
 ##
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index b2ad10ef6d..cb5c3f7a22 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -23,10 +23,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
+#define RME_MAX_CFG         1
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
+    uint8_t *personalization_value;
 };
 
 typedef struct {
@@ -54,6 +57,48 @@ static int rme_create_rd(Error **errp)
     return ret;
 }
 
+static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
+{
+    int ret;
+    const char *cfg_str;
+    struct kvm_cap_arm_rme_config_item args = {
+        .cfg = cfg,
+    };
+
+    switch (cfg) {
+    case KVM_CAP_ARM_RME_CFG_RPV:
+        if (!guest->personalization_value) {
+            return 0;
+        }
+        memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_RPV_SIZE);
+        cfg_str = "personalization value";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
+                            KVM_CAP_ARM_RME_CONFIG_REALM, (intptr_t)&args);
+    if (ret) {
+        error_setg_errno(errp, -ret, "RME: failed to configure %s", cfg_str);
+    }
+    return ret;
+}
+
+static int rme_configure(void)
+{
+    int ret;
+    int cfg;
+
+    for (cfg = 0; cfg < RME_MAX_CFG; cfg++) {
+        ret = rme_configure_one(rme_guest, cfg, &error_abort);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static void rme_populate_realm(gpointer data, gpointer unused)
 {
     int ret;
@@ -98,6 +143,11 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
         return;
     }
 
+    ret = rme_configure();
+    if (ret) {
+        return;
+    }
+
     ret = rme_create_rd(&error_abort);
     if (ret) {
         return;
@@ -231,8 +281,69 @@ int kvm_arm_rme_vm_type(MachineState *ms)
     return 0;
 }
 
+static char *rme_get_rpv(Object *obj, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+    GString *s;
+    int i;
+
+    if (!guest->personalization_value) {
+        return NULL;
+    }
+
+    s = g_string_sized_new(KVM_CAP_ARM_RME_RPV_SIZE * 2 + 1);
+
+    for (i = 0; i < KVM_CAP_ARM_RME_RPV_SIZE; i++) {
+        g_string_append_printf(s, "%02x", guest->personalization_value[i]);
+    }
+
+    return g_string_free(s, /* free_segment */ false);
+}
+
+static void rme_set_rpv(Object *obj, const char *value, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+    size_t len = strlen(value);
+    uint8_t *out;
+    int i = 1;
+    int ret;
+
+    g_free(guest->personalization_value);
+    guest->personalization_value = out = g_malloc0(KVM_CAP_ARM_RME_RPV_SIZE);
+
+    /* Two chars per byte */
+    if (len > KVM_CAP_ARM_RME_RPV_SIZE * 2) {
+        error_setg(errp, "Realm Personalization Value is too large");
+        return;
+    }
+
+    /* First byte may have a single char */
+    if (len % 2) {
+        ret = sscanf(value, "%1hhx", out++);
+    } else {
+        ret = sscanf(value, "%2hhx", out++);
+        i++;
+    }
+    if (ret != 1) {
+        error_setg(errp, "Invalid Realm Personalization Value");
+        return;
+    }
+
+    for (; i < len; i += 2) {
+        ret = sscanf(value + i, "%2hhx", out++);
+        if (ret != 1) {
+            error_setg(errp, "Invalid Realm Personalization Value");
+            return;
+        }
+    }
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_str(oc, "personalization-value", rme_get_rpv,
+                                  rme_set_rpv);
+    object_class_property_set_description(oc, "personalization-value",
+            "Realm personalization value (512-bit hexadecimal number)");
 }
 
 static void rme_guest_instance_init(Object *obj)
-- 
2.44.0



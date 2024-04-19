Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqiC-0007rk-54; Fri, 19 Apr 2024 12:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqem-0001H9-7w
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqec-0001A6-D4
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-349c4505058so1530454f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542397; x=1714147197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TiMKcfhWWVprWCCg72qipd7OlTmHhGexnpkTMCgpYM=;
 b=ohvELi5kF2Z7//dporjkfMKx3eCNpH+Ju7hR9pSWRsUEMZMnViZLx2Qg0Gzv6DhTOl
 NwHAiSAiSzG2dO3GiuSLVaiF8gqRRo3FQC3Rq0BJ+tnp0/s8K8/PlUxIOd8wQ1wN9VNT
 dkm/Xl0rwOpThzIlkDss+bk4d7219VZryM01odhu++5HpZCJB76DHHIkx4I56Nv/Uqep
 zzsz0J1eolpO38MSbwJXc2q8x4cypfAW916zQeIA0fpMLI9yFFqfXukyC1hSHuX3k3NB
 blCqMPyjM66BymljfgGYlwMCoaKlpg6U/2Yu/DOmoBU/IKug1/DEp98XcY8qofPW1Be2
 YzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542397; x=1714147197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TiMKcfhWWVprWCCg72qipd7OlTmHhGexnpkTMCgpYM=;
 b=CLEsiwOQ07uOTjaK6pRchtSgpoVy8W406PrNh4wAz2hB8pE+GVwobkqyBEw2b9KVco
 Djk8vcxdc6cALOs/VdWdZQfw4WS+Ar/ERgNBGKgCG2thd9jI0o2hp+qwt9p68rv/wZuJ
 mDXGMvt88l99IVEjqsDyMgp/J8ZYGYlAfJnwpu3BXmzFMC2yqxJwF4pH7yjl42coHLNn
 KED1AIrtrLUkHQ7V2dtZmomoJ3mCiL2zi6KtEKSTqWA3uMT4QY0G/we9aSjhS81eeYHM
 azwO27vtxbstE809uk8SJCP36du8R8M3aIA75oOaDCehbyKBYC0msCr2O+5ODr68s6Jw
 aZYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb0TGUAx0ptp+RF9YA4clAZ8JnNkoA9uWqA3cWoce01m1STsrPBQfIBbNk6kQaRcdBr9RVKEBD2rRIDxigujADITs1Fbs=
X-Gm-Message-State: AOJu0Yxbzvak+YB5BgLL9JU5uvf5jth9LmbwiEM8es9hLeIgqY0dwEKU
 HmUrVqTfFGIaG0UTglUWojjm6V633qJZDfQ1CZcDXNDwmPjn5+vsRBcMwxI4XG0=
X-Google-Smtp-Source: AGHT+IEwMNMLMdwWzlmJIUijREc2Qf1Prq2dWY2hHTVBkRybeXPJsUyb6aSDemSmIpD+IWAfnVHXvQ==
X-Received: by 2002:adf:ce11:0:b0:343:3db9:6602 with SMTP id
 p17-20020adfce11000000b003433db96602mr1749385wrn.66.1713542396911; 
 Fri, 19 Apr 2024 08:59:56 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 15/22] target/arm/kvm-rme: Add measurement algorithm
 property
Date: Fri, 19 Apr 2024 16:57:03 +0100
Message-ID: <20240419155709.318866-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This option selects which measurement algorithm to use for attestation.
Supported values are SHA256 and SHA512. Default to SHA512 arbitrarily.

SHA512 is generally faster on 64-bit architectures. On a few arm64 CPUs
I tested SHA256 is much faster, but that's most likely because they only
support acceleration via FEAT_SHA256 (Armv8.0) and not FEAT_SHA512
(Armv8.2). Future CPUs supporting RME are likely to also support
FEAT_SHA512.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: use enum, pick default
---
 qapi/qom.json        | 18 +++++++++++++++++-
 target/arm/kvm-rme.c | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 91654aa267..84dce666b2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -931,18 +931,34 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestMeasurementAlgo:
+#
+# @sha256: Use the SHA256 algorithm
+# @sha512: Use the SHA512 algorithm
+#
+# Algorithm to use for realm measurements
+#
+# Since: FIXME
+##
+{ 'enum': 'RmeGuestMeasurementAlgo',
+  'data': ['sha256', 'sha512'] }
+
 ##
 # @RmeGuestProperties:
 #
 # Properties for rme-guest objects.
 #
+# @measurement-algo: Realm measurement algorithm (default: sha512)
+#
 # @personalization-value: Realm personalization value, as a 64-byte hex string
 #     (default: 0)
 #
 # Since: FIXME
 ##
 { 'struct': 'RmeGuestProperties',
-  'data': { '*personalization-value': 'str' } }
+  'data': { '*personalization-value': 'str',
+            '*measurement-algo': 'RmeGuestMeasurementAlgo' } }
 
 ##
 # @ObjectType:
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index cb5c3f7a22..8f39e54aaa 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -23,13 +23,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
-#define RME_MAX_CFG         1
+#define RME_MAX_CFG         2
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
     uint8_t *personalization_value;
+    RmeGuestMeasurementAlgo measurement_algo;
 };
 
 typedef struct {
@@ -73,6 +74,19 @@ static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
         memcpy(args.rpv, guest->personalization_value, KVM_CAP_ARM_RME_RPV_SIZE);
         cfg_str = "personalization value";
         break;
+    case KVM_CAP_ARM_RME_CFG_HASH_ALGO:
+        switch (guest->measurement_algo) {
+        case RME_GUEST_MEASUREMENT_ALGO_SHA256:
+            args.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA256;
+            break;
+        case RME_GUEST_MEASUREMENT_ALGO_SHA512:
+            args.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA512;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        cfg_str = "hash algorithm";
+        break;
     default:
         g_assert_not_reached();
     }
@@ -338,12 +352,34 @@ static void rme_set_rpv(Object *obj, const char *value, Error **errp)
     }
 }
 
+static int rme_get_measurement_algo(Object *obj, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+
+    return guest->measurement_algo;
+}
+
+static void rme_set_measurement_algo(Object *obj, int algo, Error **errp)
+{
+    RmeGuest *guest = RME_GUEST(obj);
+
+    guest->measurement_algo = algo;
+}
+
 static void rme_guest_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "personalization-value", rme_get_rpv,
                                   rme_set_rpv);
     object_class_property_set_description(oc, "personalization-value",
             "Realm personalization value (512-bit hexadecimal number)");
+
+    object_class_property_add_enum(oc, "measurement-algo",
+                                   "RmeGuestMeasurementAlgo",
+                                   &RmeGuestMeasurementAlgo_lookup,
+                                   rme_get_measurement_algo,
+                                   rme_set_measurement_algo);
+    object_class_property_set_description(oc, "measurement-algo",
+            "Realm measurement algorithm ('sha256', 'sha512')");
 }
 
 static void rme_guest_instance_init(Object *obj)
@@ -353,6 +389,7 @@ static void rme_guest_instance_init(Object *obj)
         exit(1);
     }
     rme_guest = RME_GUEST(obj);
+    rme_guest->measurement_algo = RME_GUEST_MEASUREMENT_ALGO_SHA512;
 }
 
 static const TypeInfo rme_guest_info = {
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2404C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 22:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1uc-0002CO-Ew; Thu, 11 Jul 2024 18:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uY-0002A1-7S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:10 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1uO-0000KR-J1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 18:05:08 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d93147ac6bso774956b6e.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720735498; x=1721340298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duRwLvK2JsLh0/v9rntXL0ihMvEEQ5jod3rzDyBUOeM=;
 b=G5zFqvQkCDvMNA05B7nw3rJFbT8AWeo7K9LU8lQYIj2oQRtuNzGS7gpKSdaerG+DfL
 dm+X4n20IDZvRg9wrb/qDIp3wx1YkLZA6fihDYJU2k/TQlk/DUPsZpWUA+rp1ROvwWi0
 3ghnNMy3hFtWrmS/aurkEqrFrUeGGAkNvAaiQARUv3gJpd/BaKQ4jjWHUfuwQgJloKCv
 4/Y67Dw+6xFylsFDnKM+X9cNxWBcgDKd+/yLR1xNwvQBmX6ofekYleU0J62Gct30XJbj
 YjodyjVxh9ULRql8KtU+Snr9i/e2aiGrh6NEJVGZsyg29/4Nr8emkBoe46cXHAuiVuF2
 p8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720735498; x=1721340298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duRwLvK2JsLh0/v9rntXL0ihMvEEQ5jod3rzDyBUOeM=;
 b=v27FXIDyq8O+Y0UUm3eF6sbfEn6q+hRz+MvO3Ucx8KM9EuGIeF6UkJwfdUNZPSRCap
 pHDy2GJEPKv6/rxjsjPXhfgnIp2meTX627CJy8r158dYy+t2ENbm3IOhYqP2+3uOLi5M
 yHhc7TVKT9f0QpyZJ3Ti+dhymJwOm7VpxBLeuMa6XbS/wYjgtPmFmhm/5dwA9W3O2CnG
 X8vr8cXlPhJWamHIu1KjGy0gbvhc8fNmynDlAbIFOSJohSjo41wQGozOADdWTQn7inF6
 atzWnwKx6NgXXb7oMuiGHQarTnQaMr/kX92e079E0xgYPV1fT91ETLT9fhtsEdaQ7bXl
 ZFlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5MTrfTuaMzrZ52i8upnsiMN++82HLRFrEuECuTH1AdumjgC7CODmMEwyWbSAJ1VhmM+Sb1PmOPQZj5ANLZnYC4oqecIc=
X-Gm-Message-State: AOJu0YwmeLKLzdtXzaX8TXS0nQW4r6gBMHHpLRwTszOEqpFABWwZ4OSv
 yyU1HSuaxMmYYTgMy0Vz3opyXJmefymwwnD6crl6KC1GTxfuj042/Jb6B7V2vZw=
X-Google-Smtp-Source: AGHT+IHyJk5T5vJ5C6FD4TFWC96IsECCCnb7x/G9UilZvOQr87ajc5FezEQqYiq9KoXOXkBDs8TBwg==
X-Received: by 2002:a05:6808:1312:b0:3d9:243a:7ae8 with SMTP id
 5614622812f47-3d93c08c8cfmr10753026b6e.39.1720735498480; 
 Thu, 11 Jul 2024 15:04:58 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d93acff4d9sm1218578b6e.5.2024.07.11.15.04.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 15:04:58 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 11/13] migration/multifd: Add migration option set packet
 size.
Date: Thu, 11 Jul 2024 15:04:49 -0700
Message-Id: <20240711220451.19780-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711220451.19780-1-yichen.wang@bytedance.com>
References: <20240711220451.19780-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@linux.dev>

During live migration, if the latency between sender and receiver is
high and bandwidth is also high (a long and fat pipe), using a bigger
packet size can help reduce migration total time. The current multifd
packet size is 128 * 4kb. In addition, Intel DSA offloading performs
better with a large batch task.

This change adds an option to set the packet size, which is also useful
for performance tunin. Both sender and receiver needs to set the same
packet size for things to work.

Set the option:
migrate_set_parameter multifd-packet-size 4190208

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 migration/migration-hmp-cmds.c |  7 +++++++
 migration/multifd-zlib.c       |  6 ++++--
 migration/multifd-zstd.c       |  6 ++++--
 migration/multifd.c            |  6 ++++--
 migration/multifd.h            |  3 ---
 migration/options.c            | 38 ++++++++++++++++++++++++++++++++++
 migration/options.h            |  1 +
 qapi/migration.json            | 21 ++++++++++++++++---
 8 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c422db4ecd..27ba0ce79a 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -292,6 +292,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u ms\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
             params->x_checkpoint_delay);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE),
+            params->multifd_packet_size);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
@@ -576,6 +579,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_dsa_accel_path = true;
         visit_type_strList(v, param, &p->dsa_accel_path, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_PACKET_SIZE:
+        p->has_multifd_packet_size = true;
+        visit_type_size(v, param, &p->multifd_packet_size, &err);
+        break;
     case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
         p->has_multifd_channels = true;
         visit_type_uint8(v, param, &p->multifd_channels, &err);
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 2ced69487e..bd900fe575 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -49,6 +49,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
     const char *err_msg;
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
 
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
@@ -58,7 +59,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         goto err_free_z;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         err_msg = "out of memory for zbuff";
@@ -200,6 +201,7 @@ out:
  */
 static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
@@ -214,7 +216,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
         return -1;
     }
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         inflateEnd(zs);
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index ca17b7e310..8aaa7363be 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -49,6 +49,7 @@ struct zstd_data {
  */
 static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
@@ -68,7 +69,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
         return -1;
     }
     /* This is the maximum size of the compressed buffer */
-    z->zbuff_len = ZSTD_compressBound(MULTIFD_PACKET_SIZE);
+    z->zbuff_len = ZSTD_compressBound(multifd_packet_size);
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeCStream(z->zcs);
@@ -188,6 +189,7 @@ out:
  */
 static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    uint64_t multifd_packet_size = migrate_multifd_packet_size();
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
@@ -209,7 +211,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     }
 
     /* To be safe, we reserve twice the size of the packet */
-    z->zbuff_len = MULTIFD_PACKET_SIZE * 2;
+    z->zbuff_len = multifd_packet_size * 2;
     z->zbuff = g_try_malloc(z->zbuff_len);
     if (!z->zbuff) {
         ZSTD_freeDStream(z->zds);
diff --git a/migration/multifd.c b/migration/multifd.c
index 014fee757a..87ed421364 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1189,7 +1189,8 @@ bool multifd_send_setup(Error **errp)
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
     int thread_count, ret = 0;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
 
@@ -1600,7 +1601,8 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_recv_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count =
+        migrate_multifd_packet_size() / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
     uint8_t i;
     int ret;
diff --git a/migration/multifd.h b/migration/multifd.h
index 871e3aa063..63cec33c61 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -44,9 +44,6 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_QPL (4 << 1)
 #define MULTIFD_FLAG_UADK (8 << 1)
 
-/* This value needs to be a multiple of qemu_target_page_size() */
-#define MULTIFD_PACKET_SIZE (512 * 1024)
-
 typedef struct {
     uint32_t magic;
     uint32_t version;
diff --git a/migration/options.c b/migration/options.c
index f839493016..1417fa6ab0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -73,6 +73,12 @@
 #define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
 #define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
 
+/*
+ * Parameter for multifd packet size.
+ */
+#define DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE (128 * 4 * 1024)
+#define MAX_MIGRATE_MULTIFD_PACKET_SIZE (1023 * 4 * 1024)
+
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, capabilities[x], false)
 
@@ -167,6 +173,9 @@ Property migration_properties[] = {
     /*                    parameters.dsa_accel_path, qdev_prop_string, char *), */
     /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
     /*                    parameters.dsa_accel_path), */
+    DEFINE_PROP_SIZE("multifd-packet-size", MigrationState,
+                     parameters.multifd_packet_size,
+                     DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -777,6 +786,13 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
 
+uint64_t migrate_multifd_packet_size(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->parameters.multifd_packet_size;
+}
+
 MultiFDCompression migrate_multifd_compression(void)
 {
     MigrationState *s = migrate_get_current();
@@ -898,6 +914,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->downtime_limit = s->parameters.downtime_limit;
     params->has_x_checkpoint_delay = true;
     params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
+    params->has_multifd_packet_size = true;
+    params->multifd_packet_size = s->parameters.multifd_packet_size;
     params->has_multifd_channels = true;
     params->multifd_channels = s->parameters.multifd_channels;
     params->has_multifd_compression = true;
@@ -957,6 +975,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_max_bandwidth = true;
     params->has_downtime_limit = true;
     params->has_x_checkpoint_delay = true;
+    params->has_multifd_packet_size = true;
     params->has_multifd_channels = true;
     params->has_multifd_compression = true;
     params->has_multifd_zlib_level = true;
@@ -1038,6 +1057,19 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 
     /* x_checkpoint_delay is now always positive */
 
+    if (params->has_multifd_packet_size &&
+        ((params->multifd_packet_size < DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size >  MAX_MIGRATE_MULTIFD_PACKET_SIZE) ||
+            (params->multifd_packet_size % qemu_target_page_size() != 0))) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                    "multifd_packet_size",
+                    "an integer in the range of "
+                    stringify(DEFAULT_MIGRATE_MULTIFD_PACKET_SIZE)
+                    " to "stringify(MAX_MIGRATE_MULTIFD_PACKET_SIZE)", "
+                    "and must be a multiple of guest VM's page size.");
+        return false;
+    }
+
     if (params->has_multifd_channels && (params->multifd_channels < 1)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "multifd_channels",
@@ -1219,6 +1251,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->x_checkpoint_delay = params->x_checkpoint_delay;
     }
 
+    if (params->has_multifd_packet_size) {
+        dest->multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         dest->multifd_channels = params->multifd_channels;
     }
@@ -1344,6 +1379,9 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         colo_checkpoint_delay_set();
     }
 
+    if (params->has_multifd_packet_size) {
+        s->parameters.multifd_packet_size = params->multifd_packet_size;
+    }
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels = params->multifd_channels;
     }
diff --git a/migration/options.h b/migration/options.h
index 78b9e4080b..b37cffc887 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -86,6 +86,7 @@ const char *migrate_tls_hostname(void);
 uint64_t migrate_xbzrle_cache_size(void);
 ZeroPageDetection migrate_zero_page_detection(void);
 const strList *migrate_dsa_accel_path(void);
+uint64_t migrate_multifd_packet_size(void);
 
 /* parameters helpers */
 
diff --git a/qapi/migration.json b/qapi/migration.json
index ff41780347..1a9dc5d74c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -839,6 +839,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -864,7 +868,8 @@
            'vcpu-dirty-limit',
            'mode',
            'zero-page-detection',
-           'direct-io'] }
+           'direct-io',
+           'multifd-packet-size'] }
 
 ##
 # @MigrateSetParameters:
@@ -1020,6 +1025,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1061,7 +1070,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*dsa-accel-path': ['str'] } }
+            '*dsa-accel-path': ['str'],
+            '*multifd-packet-size' : 'uint64'} }
 
 ##
 # @migrate-set-parameters:
@@ -1231,6 +1241,10 @@
 #     only has effect if the @mapped-ram capability is enabled.
 #     (Since 9.1)
 #
+# @multifd-packet-size: Packet size in bytes used to migrate data.
+#     The value needs to be a multiple of guest page size.
+#     The default value is 524288 and max value is 4190208. (Since 9.2)
+#
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and
@@ -1269,7 +1283,8 @@
             '*mode': 'MigMode',
             '*zero-page-detection': 'ZeroPageDetection',
             '*direct-io': 'bool',
-            '*dsa-accel-path': ['str'] } }
+            '*dsa-accel-path': ['str'],
+            '*multifd-packet-size': 'uint64'} }
 
 ##
 # @query-migrate-parameters:
-- 
Yichen Wang



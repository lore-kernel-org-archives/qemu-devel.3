Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FCE606A330
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a4afrHPO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3WY-0001YE-AM; Sun, 22 Nov 2026 04:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W5-0001W7-Nz
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:48 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W3-0000y8-UX
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:45 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c51373ae637so350607866b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338342; x=1795943142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tyEg9+jxsUTBODeKM/OLzOBVCxUT43M9pEiybpUpXeQ=;
 b=a4afrHPO2EWZIgmfKyPRiS0werrcEbifgA0UPCeEXsCqBNBuGd4buby7fRnpcfXzrO
 sJBo75c0NHYDQI0Ka/zWuJYv2bDnkBla2Rzy1Sl0/STsJlAcNjnXv55zTVzbW/07E4sJ
 7ZnxVQLcO55by1VrSv/tF0tku5TAmDL9p8zmgCSaglPGcwECgZojPqNcEUx1m+ytPvwD
 eV8c/19376jpypq+ittcHr+vtMdBDANpgt9Gxg4TwOBVAWL9P0Jb5PgiL/GCDUDk9n5r
 wqQWe5S9Odl7hT40R+JQbN7lGAUgAA8P8yC99cPhHIO7WXFZlAXRs080hwKY+bfrdhw9
 aWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338342; x=1795943142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tyEg9+jxsUTBODeKM/OLzOBVCxUT43M9pEiybpUpXeQ=;
 b=JW4MbHjyQIZBazlnNfINymXvYmErCQYTibl53ipggReLDKxHKzkUzhM3ICXYIwzQnv
 LMsid9ntQxWkyODigfvni3He1Z9ZmkaOP+XcXAPaYjda6tmuItmtvjdRJlV5TtuHkeM3
 xItqQnX8nscpfdkst5a/JYelLxnMVfqSVJAzmeBzZfd//1uQEIlL2mYklADggkNeXmjP
 bTb0jmkokdmemZKyVfveLRr5a4OcezqNhrW13Ku3VntgDhItvsreZh5RHZLy7YCaJDMX
 brwjGq5N2w+Zvn10llfwJIvebRwzqj1PEGrkjHEPTj1GVEzeSh1TUaLkS3cgnehAIc1N
 mDUA==
X-Gm-Message-State: APuU4Z/njtAeE2iNTfcjC4wurtrwZKI7OuX6gz850shr2ISeTl2x0ugK
 Mh2BAK/41bG9wVnOODJhoJLyjM2x3v1y0icFVa+p4uc7+Hli0p4aypSw0rsEqqX7
X-Gm-Gg: AZFdTZdFtGaeJg2NtO7pWTVMo9yrTtF2rfNundT4aB32+Yq4USEyVeluR5FJsjDDwd/
 W1B1JCS4g132uEROMyl3m9xCyxppW+jCvuvBIoFZu35dtRA9iv04Gev7JHmfxjI0zcP9cdlUrol
 J4Kaf1a2gt4ZmWs5zvYhBLDP2VOzBRoYlYJz21YSiijZ+Uo4vVbRBOM9334W+1Rm9cnaWc4uqkM
 u8zkuTy9zIY7Y61FL4HsBUxcCIi/fNxWGx6mjKpZznutqUpy42wBKaq5ErSRcQUX0rUAOGrgliz
 NY/ypC86OLMyorhwLRJqwhs4qWHp5UFifmdS3C8GKwl2J876qptIF81YQz+SifbfMATLkkqLOxx
 M7oU6zDufTRa1KjVY+fXI/mNR83FhPoyGjaKFXgcdNnvX9br0Hi9PcnJtKFVqUx3EqsLazAUj6h
 Zn8Hk+rs6yZIDAIcbrns1m8/WuQ2Q0lGRXGEKk13lO7eO9yPIZst1lp9Y8N+w6TFGHZB1zeHjqV
 7TVMghWlp4rRyVk4lh3KbkUQWbNVTUpasDCoZENjieDl8/KZgNvLPoAOItiLccb1wd3ZYJsl2IM
 QsZBIwg0xpv0peDUAdex8JeTrh5F7OtqAexjvbyaf9pauDSEsfSBR5CIGp6MHKF8+3a5nUb7f1H
 dUGjEx3NX5EVE2YQuPm3fvsgIEw0US+5y6+wfRZ8=
X-Received: by 2002:a17:906:8316:b0:c40:b59:f with SMTP id
 a640c23a62f3a-c513ab2c7admr545109066b.47.1795338342284; 
 Sun, 22 Nov 2026 01:05:42 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 3/5] qga: implement 'guest-get-disks' for FreeBSD
Date: Sun, 22 Nov 2026 10:05:08 +0100
Message-ID: <20261122090511.15121-4-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122090511.15121-1-bogorodskiy@gmail.com>
References: <20261122090511.15121-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The implementation uses the "kern.geom.conftxt" sysctl.
It resides under the "#ifdef __FreeBSD__" block as
other BSDs do not have GEOM.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-bsd.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 13 ++++----
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 0f97427d8b..f8b4ffd175 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/queue.h"
 #include "block/block-common.h"
 #include "commands-common.h"
@@ -620,4 +621,80 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     }
     return head;
 }
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *ret = NULL;
+    GuestDiskInfo *disk;
+    g_autofree char *buf = NULL;
+    g_auto(GStrv) lines = NULL;
+    g_autoptr(GHashTable) providers = NULL;
+    size_t len;
+    int i;
+
+    if (sysctlbyname("kern.geom.conftxt", NULL, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctlbyname(kern.geom.conftxt)");
+        return NULL;
+    }
+
+    buf = g_malloc0(len);
+
+    if (sysctlbyname("kern.geom.conftxt", buf, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctlbyname(kern.geom.conftxt)");
+        return NULL;
+    }
+
+    providers = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+    lines = g_strsplit(buf, "\n", -1);
+    for (i = 0; lines[i] != NULL; ++i) {
+        g_auto(GStrv) tokens = NULL;
+        bool is_part = false;
+        uint64_t mediasize;
+
+        if (strlen(lines[i]) == 0) {
+            continue;
+        }
+
+        tokens = g_strsplit(lines[i], " ", -1);
+
+        /*
+         * kern.geom.conftxt format:
+         *
+         * 0 DISK ada0 8001563222016 512 hd 16 sc 63
+         * 1 PART ada0p1 8001563181056 512 i 1 o 20480 ty freebsd-ufs xs GPT xt <uuid>
+         */
+        if (g_strv_length(tokens) < 5) {
+            continue;
+        }
+
+        if (g_str_equal(tokens[1], "DISK")) {
+            /* nada */
+        } else if (g_str_equal(tokens[1], "PART")) {
+            is_part = true;
+        } else {
+            continue;
+        }
+
+        if (qemu_strtou64(tokens[3], NULL, 10, &mediasize) < 0 ||
+            mediasize == 0) {
+            continue;
+        }
+
+        /* Filter out duplicate providers, for example for mirrors */
+        if (g_hash_table_contains(providers, tokens[2])) {
+            continue;
+        } else {
+            g_hash_table_add(providers, g_strdup(tokens[2]));
+        }
+
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = g_strdup_printf("/dev/%s", tokens[2]);
+        disk->partition = is_part;
+
+        QAPI_LIST_PREPEND(ret, disk);
+    }
+
+    return ret;
+}
+
 #endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 4856a549a6..35aaa040cf 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -947,7 +947,7 @@
            'media-errors-hi': 'uint64',
            'number-of-error-log-entries-lo': 'uint64',
            'number-of-error-log-entries-hi': 'uint64' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestDiskSmart:
@@ -961,12 +961,12 @@
   'base': { 'type': 'GuestDiskBusType' },
   'discriminator': 'type',
   'data': { 'nvme': 'GuestNVMeSmart' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestDiskInfo:
 #
-# @name: device node (Linux) or device UNC (Windows)
+# @name: device node (Linux, FreeBSD) or device UNC (Windows)
 #
 # @partition: whether this is a partition or disk
 #
@@ -987,7 +987,7 @@
   'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
            '*address': 'GuestDiskAddress', '*alias': 'str',
            '*smart': 'GuestDiskSmart'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @guest-get-disks:
@@ -995,13 +995,14 @@
 # Returns: The list of disks in the guest.  For Windows these are only
 #     the physical disks.  On Linux these are all root block devices
 #     of non-zero size including e.g. removable devices, loop devices,
-#     NBD, etc.
+#     NBD, etc.  On FreeBSD these are nonzero-size GEOM DISK and PART
+#     providers (since 12.0).
 #
 # Since: 5.2
 ##
 { 'command': 'guest-get-disks',
   'returns': ['GuestDiskInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV', 'CONFIG_FREEBSD' ] } }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.56.0



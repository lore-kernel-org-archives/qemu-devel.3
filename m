Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EE3CEFC53
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 20:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syGtO-0000NR-Sa; Tue, 08 Oct 2024 16:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1syGtM-0000JI-PN; Tue, 08 Oct 2024 16:33:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1syGtL-00047M-1K; Tue, 08 Oct 2024 16:33:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso589827066b.2; 
 Tue, 08 Oct 2024 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728419589; x=1729024389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WKHQqAVQXP8yXPg4plZGZRCJIY5OBCA4ZjFI7GYtxcM=;
 b=Ab4sh4aZLkASNt4rMO9wf/VkyeJLz1NbgFeQ1XYdxlqkTTISQmIg3gKbitVk4niDDW
 nBKAeV0usnSyx/eVP1HPnKX7f2BdKkLs8FOhQlEgJpl4PKBwGPkGXaGeJEeU5MoShCEx
 PUR1F7oxbEwiTvu7WTz6UTYDc+xzDTevbjJSunkCXHfnej66ogo2tnElXyFvJTt57vix
 ZXFR3aUMCCBDExHH9FPQjRWzT0CPPLNmXglpPnTEAR0NhwGaa4gGYcY4+yPnI5NXZtm0
 EVSs3e3wBaUWN9fUHaZnUap0uhP0aolnPLSop3p8qYZvtygw5h46vPH4DV/hUN0cF2ag
 XFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728419589; x=1729024389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKHQqAVQXP8yXPg4plZGZRCJIY5OBCA4ZjFI7GYtxcM=;
 b=otR5Y1rU0AsyT5j2Vuew3iiLlJPBx3E6XGgmxTgBMPyRbiy9daexcqgZ+7q8KEfGq5
 byG2di+EI4gm/J9WDQACHFD6XeOdy1ef+57zNmBp0VGd0GtuIuT+10EiCuT1sg/Rdc0z
 uSX7wDE/WR6Y3/LlGICv0MkCsg0DF/7/ptUqfcmU3jAXbHJ7W9x4B5nDyaOD42phhZui
 2KUtMZ4PksR1SqkVTmVNzmKOQRviuEniP34y8JgtGtjIgx4+d3Qhfy9Vz2euuuQTVv3u
 Fy+i4bGcEiOWAek1zETLUxrcAQ44NGRR6yjyma70prjcdfi2cOn7aPkVY8AKPCum+5aO
 KXKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2+ifS9dBIk56D8TWL15Hwyh1Zx9/MSHD7TQXHAoMZp69OpbN/EumY4AITwRWX5QVHh+TJ8J9LYNnSNw==@nongnu.org
X-Gm-Message-State: AOJu0YzbkGLpfecP6C9xkPHxghJD94lijQ5y/+tmOhsKJY0NlGhWMRKK
 Rdkce26PmE9oPyw5K1YKxAZ0WeUCm38U8+LzhBgvgVt9EFyePB0VDUCHuQ==
X-Google-Smtp-Source: AGHT+IHtZBpyVevvy8d9P+jCWMtRJW6xZEvCS5ed+TQinGaOWa164L+7m6MuTx1F3hifT14bls+QqA==
X-Received: by 2002:a17:907:724a:b0:a77:f2c5:84b3 with SMTP id
 a640c23a62f3a-a998d1a0015mr2088966b.22.1728419588317; 
 Tue, 08 Oct 2024 13:33:08 -0700 (PDT)
Received: from archlinux.. (dynamic-077-183-017-071.77.183.pool.telefonica.de.
 [77.183.17.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996167411csm213503366b.14.2024.10.08.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 13:33:07 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Bernhard Beschow <shentey@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] net/tap-win32: Fix gcc 14 format truncation errors
Date: Tue,  8 Oct 2024 22:28:42 +0200
Message-ID: <20241008202842.4478-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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

The patch fixes the following errors generated by GCC 14.2:

../src/net/tap-win32.c:343:19: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 176 [-Werror=format-truncation=]
  343 |              "%s\\%s\\Connection",
      |                   ^~
  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
      |                                       ~~~~~~~~~

../src/net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347 bytes into a destination of size 256
  341 |         snprintf(connection_string,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  342 |              sizeof(connection_string),
      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~
  343 |              "%s\\%s\\Connection",
      |              ~~~~~~~~~~~~~~~~~~~~~
  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

../src/net/tap-win32.c:242:58: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 178 [-Werror=format-truncation=]
  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
      |                                                          ^~
  243 |                   ADAPTER_KEY, enum_name);
      |                                ~~~~~~~~~

../src/net/tap-win32.c:242:9: note: 'snprintf' output between 79 and 334 bytes into a destination of size 256
  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  243 |                   ADAPTER_KEY, enum_name);
      |                   ~~~~~~~~~~~~~~~~~~~~~~~

../src/net/tap-win32.c:620:52: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 245 [-Werror=format-truncation=]
  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
      |                                                    ^~
  621 |               USERMODEDEVICEDIR,
  622 |               device_guid,
      |               ~~~~~~~~~~~
../src/net/tap-win32.c:620:5: note: 'snprintf' output between 16 and 271 bytes into a destination of size 256
  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  621 |               USERMODEDEVICEDIR,
      |               ~~~~~~~~~~~~~~~~~~
  622 |               device_guid,
      |               ~~~~~~~~~~~~
  623 |               TAPSUFFIX);
      |               ~~~~~~~~~~

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2607
Cc: qemu-stable@nongnu.org

--

This patch was just compile-tested (which fixes my issue). Testing TAP
networking under Windows apparently requires extra drivers which I don't want to
install (not my computer). So it would be nice if someone could give this patch
a test ride. Thanks!

Changes since v1:
* Use g_autofree and g_strdup_printf() rather than fixed size arrays (Peter)
---
 net/tap-win32.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 7edbd71633..671dee970f 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -214,7 +214,7 @@ static int is_tap_win32_dev(const char *guid)
 
     for (;;) {
         char enum_name[256];
-        char unit_string[256];
+        g_autofree char *unit_string = NULL;
         HKEY unit_key;
         char component_id_string[] = "ComponentId";
         char component_id[256];
@@ -239,8 +239,7 @@ static int is_tap_win32_dev(const char *guid)
             return FALSE;
         }
 
-        snprintf (unit_string, sizeof(unit_string), "%s\\%s",
-                  ADAPTER_KEY, enum_name);
+        unit_string = g_strdup_printf("%s\\%s", ADAPTER_KEY, enum_name);
 
         status = RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -315,7 +314,7 @@ static int get_device_guid(
     while (!stop)
     {
         char enum_name[256];
-        char connection_string[256];
+        g_autofree char *connection_string = NULL;
         HKEY connection_key;
         char name_data[256];
         DWORD name_type;
@@ -338,9 +337,7 @@ static int get_device_guid(
             return -1;
         }
 
-        snprintf(connection_string,
-             sizeof(connection_string),
-             "%s\\%s\\Connection",
+        connection_string = g_strdup_printf("%s\\%s\\Connection",
              NETWORK_CONNECTIONS_KEY, enum_name);
 
         status = RegOpenKeyEx(
@@ -595,7 +592,7 @@ static void tap_win32_free_buffer(tap_win32_overlapped_t *overlapped,
 static int tap_win32_open(tap_win32_overlapped_t **phandle,
                           const char *preferred_name)
 {
-    char device_path[256];
+    g_autofree char *device_path = NULL;
     char device_guid[0x100];
     int rc;
     HANDLE handle;
@@ -617,7 +614,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
     if (rc)
         return -1;
 
-    snprintf (device_path, sizeof(device_path), "%s%s%s",
+    device_path = g_strdup_printf("%s%s%s",
               USERMODEDEVICEDIR,
               device_guid,
               TAPSUFFIX);
-- 
2.47.0



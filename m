Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776EBCFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3g7i-0001ja-QN; Wed, 23 Oct 2024 14:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3g7f-0001iz-Gg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:30:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3g7d-0008RO-AK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:30:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20caccadbeeso320955ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729708214; x=1730313014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JOUjdxu6ULRCkZ7RZmLpgQ6XNl+9tI81JQfXhSF/yew=;
 b=KjugOZLnOu362S//PFDHIG3MyowBy1coy+FLdjmrEeFlnkSTP4X3S5rmP05U3j0jVP
 vfHlaBfQbg02php4XAwoTRd3XDFlUmJ5sKHDgS3MwmvaWoKEgewduNjEnWCyY8/s2zlS
 9gTmQRdgjdlkecu+lumAN72MgPE6NTnQmRp9Flx82EAhWNO/m88K9tvqqs82Y9l/qKuC
 iXDybMvlqBZRNn1by7T7Im4WIwRFIZ1qi96NT2JJkcxh4QXl+Q9reJplY9pMR9+awZIr
 ohv3nF0sp4i+p6v+xbZpiIuviRvwQTa4ygEDAHqjxh26OJULLcJu9q5O/A03Hst+dxvX
 eHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729708214; x=1730313014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOUjdxu6ULRCkZ7RZmLpgQ6XNl+9tI81JQfXhSF/yew=;
 b=bPn4ajtgzMQ/vPXFSCaAlkrbfgmLr7fyce13SZhQyFqjpnjSNNoXIfma7NPiGLiPVe
 LhgHpPdIwQ4NA623CV43YSSRrwFKjzbzTxJI6jHB79dXvCmIET5UCUzyBtiwfbzV8eCX
 DEn1SyDCqu9sGcviJYsgS8S+3DGz56cgRKt8LzvjxrUKYsEXiCBVnojVBMV24vAOqpMB
 SGRmIkeqz/P00iPG7ZnjygMhIbeB5b5pJkRLsJEAob/1yphQafZOVWNfbLfIQj+uPZnp
 rAVEkzMkJzC0UrSk1piqd1Oyo0BSSaj3fA7oEcVNndWuVHVtJhRUoym+5MC0gOSUwKiC
 Lzqw==
X-Gm-Message-State: AOJu0YxFONG+qD0jSb6/uft7TooQAyDfafS6C3sNwL4yGfbby7GqfWyY
 npOMLptRlyvgEs2kxy9w6W5Ftn0VrAFg7NdLcsKhmSPJEa0FxHglBc2HclHE6nFb8yZSoF9/j7G
 /Jrh6CQ==
X-Google-Smtp-Source: AGHT+IE7UW8t0iJm0seXU/7ZAip4RxZjVvqR6PrW6H9Wmvo+cMueS8MxSgnxGfJoPJ/ZSUchxtVOWg==
X-Received: by 2002:a17:902:c409:b0:20c:bcf1:c70e with SMTP id
 d9443c01a7336-20fa9df99f8mr43981265ad.13.1729708213909; 
 Wed, 23 Oct 2024 11:30:13 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0db2bcsm60436985ad.191.2024.10.23.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:30:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tap-win32: fix format-truncation warning
Date: Wed, 23 Oct 2024 11:30:09 -0700
Message-Id: <20241023183009.1041419-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Simply increase destination buffer size so truncation can't happen.

"cc" "-m64" "-Ilibcommon.a.p" "-Isubprojects/dtc/libfdt" "-I../subprojects/=
dtc/libfdt" "-ID:/a/_temp/msys64/mingw64/include/pixman-1" "-ID:/a/_temp/ms=
ys64/mingw64/include/glib-2.0" "-ID:/a/_temp/msys64/mingw64/lib/glib-2.0/in=
clude" "-ID:/a/_temp/msys64/mingw64/include/ncursesw" "-fdiagnostics-color=
=3Dauto" "-Wall" "-Winvalid-pch" "-Werror" "-std=3Dgnu11" "-O2" "-g" "-fsta=
ck-protector-strong" "-Wempty-body" "-Wendif-labels" "-Wexpansion-to-define=
d" "-Wformat-security" "-Wformat-y2k" "-Wignored-qualifiers" "-Wimplicit-fa=
llthrough=3D2" "-Winit-self" "-Wmissing-format-attribute" "-Wmissing-protot=
ypes" "-Wnested-externs" "-Wold-style-declaration" "-Wold-style-definition"=
 "-Wredundant-decls" "-Wshadow=3Dlocal" "-Wstrict-prototypes" "-Wtype-limit=
s" "-Wundef" "-Wvla" "-Wwrite-strings" "-Wno-missing-include-dirs" "-Wno-ps=
abi" "-Wno-shift-negative-value" "-iquote" "." "-iquote" "D:/a/qemu/qemu" "=
-iquote" "D:/a/qemu/qemu/include" "-iquote" "D:/a/qemu/qemu/host/include/x8=
6_64" "-iquote" "D:/a/qemu/qemu/host/include/generic" "-iq
../net/tap-win32.c: In function 'tap_win32_open':
../net/tap-win32.c:343:19: error: '%s' directive output may be truncated wr=
iting up to 255 bytes into a region of size 176 [-Werror=3Dformat-truncatio=
n=3D]
  343 |              "%s\\%s\\Connection",
      |                   ^~
  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
      |                                       ~~~~~~~~~
In function 'get_device_guid',
    inlined from 'tap_win32_open' at ../net/tap-win32.c:616:10:
../net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347 bytes =
into a destination of size 256
  341 |         snprintf(connection_string,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  342 |              sizeof(connection_string),
      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~
  343 |              "%s\\%s\\Connection",
      |              ~~~~~~~~~~~~~~~~~~~~~
  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../net/tap-win32.c: In function 'tap_win32_open':
../net/tap-win32.c:242:58: error: '%s' directive output may be truncated wr=
iting up to 255 bytes into a region of size 178 [-Werror=3Dformat-truncatio=
n=3D]
  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
      |                                                          ^~
  243 |                   ADAPTER_KEY, enum_name);
      |                                ~~~~~~~~~
In function 'is_tap_win32_dev',
    inlined from 'get_device_guid' at ../net/tap-win32.c:368:21,
    inlined from 'tap_win32_open' at ../net/tap-win32.c:616:10:
../net/tap-win32.c:242:9: note: 'snprintf' output between 79 and 334 bytes =
into a destination of size 256
  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  243 |                   ADAPTER_KEY, enum_name);
      |                   ~~~~~~~~~~~~~~~~~~~~~~~
../net/tap-win32.c: In function 'tap_win32_open':
../net/tap-win32.c:620:52: error: '%s' directive output may be truncated wr=
iting up to 255 bytes into a region of size 245 [-Werror=3Dformat-truncatio=
n=3D]
  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
      |                                                    ^~
  621 |               USERMODEDEVICEDIR,
  622 |               device_guid,
      |               ~~~~~~~~~~~
../net/tap-win32.c:620:5: note: 'snprintf' output between 16 and 271 bytes =
into a destination of size 256
  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  621 |               USERMODEDEVICEDIR,
      |               ~~~~~~~~~~~~~~~~~~
  622 |               device_guid,
      |               ~~~~~~~~~~~~
  623 |               TAPSUFFIX);
      |               ~~~~~~~~~~

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 net/tap-win32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 7edbd716337..4a4625af2b2 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -214,7 +214,7 @@ static int is_tap_win32_dev(const char *guid)
=20
     for (;;) {
         char enum_name[256];
-        char unit_string[256];
+        char unit_string[512];
         HKEY unit_key;
         char component_id_string[] =3D "ComponentId";
         char component_id[256];
@@ -315,7 +315,7 @@ static int get_device_guid(
     while (!stop)
     {
         char enum_name[256];
-        char connection_string[256];
+        char connection_string[512];
         HKEY connection_key;
         char name_data[256];
         DWORD name_type;
@@ -595,7 +595,7 @@ static void tap_win32_free_buffer(tap_win32_overlapped_=
t *overlapped,
 static int tap_win32_open(tap_win32_overlapped_t **phandle,
                           const char *preferred_name)
 {
-    char device_path[256];
+    char device_path[512];
     char device_guid[0x100];
     int rc;
     HANDLE handle;
--=20
2.39.5



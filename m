Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77ACD2A544
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19mb-0007mT-LX; Wed, 16 Oct 2024 15:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t19mY-0007Rd-MI; Wed, 16 Oct 2024 15:34:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t19mU-00042c-Rq; Wed, 16 Oct 2024 15:34:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so1996015e9.1; 
 Wed, 16 Oct 2024 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729107230; x=1729712030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbmICVGtbM1/BADU4IKUlFjLhiURvx6edLLRS7oUaKc=;
 b=BRO/wUgullIhj+q6N+fHhL6t2Ib6EHqgg/1Ry4ZwQk13mnJtWmyTR8sOwl7cM1cM5G
 R/9eYVgbtSR8s72DHBGiQcjBxvhbPt/yCVLUaRzchf0Re6QQuAy9BbjahKA4YQM+e+OF
 IQwbuKOFukHcl02KlbJVDwQBW+TvGq1vzEXeU+hlEUz6XluAPDXoPfS5T0u6jBqAq677
 GpXBh0ONwvYLAVweSG63NfLMSh1MQXWYjOE9a56cS6gEmbZC/fqJ5oc6ZZm9aMJoagOG
 0L4IHuiSHegI9q+G7kdAiyKRWPQ9hPKd3C/QidUbVHnVcurPSqnPbBRnqPr47LJCcJ6u
 lIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107230; x=1729712030;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbmICVGtbM1/BADU4IKUlFjLhiURvx6edLLRS7oUaKc=;
 b=Yn0dk5itJwBon1hYRutMW9QWpePIhzPfV77t9YoNvbM4RqmSffDd7CyqaC8X+Z40Nu
 9awIfXe6+qTfQqD5tl5Jbpu1PwSZIPX6AeGV6fjMOyvgLQAt55o9vc1ta31B3oaLkRVI
 tcvkK2m/yc7ineIxUWJXBGBSqf3AoQ8YkcdMbzTKmjXkfVx2wYFmJiXlsgyfO3tf5rL8
 MaX8f+IiWcz/rlqR5Hc8qpjG3VG6SiBU/DLB61Cn5YXwGfB/fU9shltPqZRmZGTHiWeB
 YTwc3chjMaDbRK+3sFLUlZMnuNWDT7DFAb+RZXwq6BisOu3S3QCEqmu92hOkDYqr2bdx
 SuSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf4qyoU46BBerIKV529JGv0iDQetmtYRDWW1HyhMJXX/6ylEPsyUZVebI4Hmc4A1/g9Yw0zXj1SEAfdw==@nongnu.org
X-Gm-Message-State: AOJu0Yz8sX8QYjmQ+coAFOayrwMhja6rGO4q9ZONW9Ry5zm2d/V/WnkD
 VO+ckOLlvHUplII+Rl/L3ZiOCZHeoecyemttHfgT8iSSp83vh5cyoHWtxQ==
X-Google-Smtp-Source: AGHT+IFGm0Wkf+rVT3+0vpUh3FPdLhg4cw+TqX6QexmtHwXC0y2vaaflQdNmQApmEg2IW2ydA4gEeg==
X-Received: by 2002:a05:600c:5110:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-43159ab1711mr508545e9.19.1729107229305; 
 Wed, 16 Oct 2024 12:33:49 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a1c8sm5025246f8f.21.2024.10.16.12.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 12:33:48 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:49:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2] net/tap-win32: Fix gcc 14 format truncation errors
In-Reply-To: <20241008202842.4478-1-shentey@gmail.com>
References: <20241008202842.4478-1-shentey@gmail.com>
Message-ID: <ED3A009C-15F4-47D0-8E67-65BAE0510A95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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



Am 8=2E Oktober 2024 20:28:42 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>The patch fixes the following errors generated by GCC 14=2E2:
>
>=2E=2E/src/net/tap-win32=2Ec:343:19: error: '%s' directive output may be =
truncated writing up to 255 bytes into a region of size 176 [-Werror=3Dform=
at-truncation=3D]
>  343 |              "%s\\%s\\Connection",
>      |                   ^~
>  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>      |                                       ~~~~~~~~~
>
>=2E=2E/src/net/tap-win32=2Ec:341:9: note: 'snprintf' output between 92 an=
d 347 bytes into a destination of size 256
>  341 |         snprintf(connection_string,
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>  342 |              sizeof(connection_string),
>      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  343 |              "%s\\%s\\Connection",
>      |              ~~~~~~~~~~~~~~~~~~~~~
>  344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>      |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>=2E=2E/src/net/tap-win32=2Ec:242:58: error: '%s' directive output may be =
truncated writing up to 255 bytes into a region of size 178 [-Werror=3Dform=
at-truncation=3D]
>  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>      |                                                          ^~
>  243 |                   ADAPTER_KEY, enum_name);
>      |                                ~~~~~~~~~
>
>=2E=2E/src/net/tap-win32=2Ec:242:9: note: 'snprintf' output between 79 an=
d 334 bytes into a destination of size 256
>  242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  243 |                   ADAPTER_KEY, enum_name);
>      |                   ~~~~~~~~~~~~~~~~~~~~~~~
>
>=2E=2E/src/net/tap-win32=2Ec:620:52: error: '%s' directive output may be =
truncated writing up to 255 bytes into a region of size 245 [-Werror=3Dform=
at-truncation=3D]
>  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>      |                                                    ^~
>  621 |               USERMODEDEVICEDIR,
>  622 |               device_guid,
>      |               ~~~~~~~~~~~
>=2E=2E/src/net/tap-win32=2Ec:620:5: note: 'snprintf' output between 16 an=
d 271 bytes into a destination of size 256
>  620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  621 |               USERMODEDEVICEDIR,
>      |               ~~~~~~~~~~~~~~~~~~
>  622 |               device_guid,
>      |               ~~~~~~~~~~~~
>  623 |               TAPSUFFIX);
>      |               ~~~~~~~~~~
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2607
>Cc: qemu-stable@nongnu=2Eorg
>
>--
>
>This patch was just compile-tested (which fixes my issue)=2E Testing TAP
>networking under Windows apparently requires extra drivers which I don't =
want to
>install (not my computer)=2E So it would be nice if someone could give th=
is patch
>a test ride=2E Thanks!

Ping=2E Patch is reviewed=2E Any testers or shall we just merge?

Best regards,
Bernhard

>
>Changes since v1:
>* Use g_autofree and g_strdup_printf() rather than fixed size arrays (Pet=
er)
>---
> net/tap-win32=2Ec | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
>diff --git a/net/tap-win32=2Ec b/net/tap-win32=2Ec
>index 7edbd71633=2E=2E671dee970f 100644
>--- a/net/tap-win32=2Ec
>+++ b/net/tap-win32=2Ec
>@@ -214,7 +214,7 @@ static int is_tap_win32_dev(const char *guid)
>=20
>     for (;;) {
>         char enum_name[256];
>-        char unit_string[256];
>+        g_autofree char *unit_string =3D NULL;
>         HKEY unit_key;
>         char component_id_string[] =3D "ComponentId";
>         char component_id[256];
>@@ -239,8 +239,7 @@ static int is_tap_win32_dev(const char *guid)
>             return FALSE;
>         }
>=20
>-        snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>-                  ADAPTER_KEY, enum_name);
>+        unit_string =3D g_strdup_printf("%s\\%s", ADAPTER_KEY, enum_name=
);
>=20
>         status =3D RegOpenKeyEx(
>             HKEY_LOCAL_MACHINE,
>@@ -315,7 +314,7 @@ static int get_device_guid(
>     while (!stop)
>     {
>         char enum_name[256];
>-        char connection_string[256];
>+        g_autofree char *connection_string =3D NULL;
>         HKEY connection_key;
>         char name_data[256];
>         DWORD name_type;
>@@ -338,9 +337,7 @@ static int get_device_guid(
>             return -1;
>         }
>=20
>-        snprintf(connection_string,
>-             sizeof(connection_string),
>-             "%s\\%s\\Connection",
>+        connection_string =3D g_strdup_printf("%s\\%s\\Connection",
>              NETWORK_CONNECTIONS_KEY, enum_name);
>=20
>         status =3D RegOpenKeyEx(
>@@ -595,7 +592,7 @@ static void tap_win32_free_buffer(tap_win32_overlappe=
d_t *overlapped,
> static int tap_win32_open(tap_win32_overlapped_t **phandle,
>                           const char *preferred_name)
> {
>-    char device_path[256];
>+    g_autofree char *device_path =3D NULL;
>     char device_guid[0x100];
>     int rc;
>     HANDLE handle;
>@@ -617,7 +614,7 @@ static int tap_win32_open(tap_win32_overlapped_t **ph=
andle,
>     if (rc)
>         return -1;
>=20
>-    snprintf (device_path, sizeof(device_path), "%s%s%s",
>+    device_path =3D g_strdup_printf("%s%s%s",
>               USERMODEDEVICEDIR,
>               device_guid,
>               TAPSUFFIX);


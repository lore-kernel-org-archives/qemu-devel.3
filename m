Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BB5CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsJ-0007qO-En; Sat, 02 May 2026 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsE-0007oT-66
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:27 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDsC-00073M-HS
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:25 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcdaf06498so2066150a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741883; x=1778346683;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A+mCXscX/ZXQdeivAZC6BeYLBLYIClDlWCGA7GSoYYI=;
 b=kB3oH8O8aaZWn+FzF28G1QN6odtCUJfbMfoI0xffJKFtj88JdHdfx/BYsknhR4BGqj
 FPxdHubc5o4Z5B4P1zpxJqqIMHRss5/TDfFN1DUtOTV//wZB5hnuJP/nO0rBcwTAGypR
 1mt1GXaJDxWE4y5dXHGkd3dRfY5jnKTjghMPoUpwNwFUmulJUMBweJAItWrNSQu3Es5p
 jbcZj5G/2jk01qhU8OOzzmZiXUjARD8pxc6ElTMCd/xZTZ3n/36DecrWHqnF8OyODbKb
 NLB4Ahim8uFFzzZW9FPedz0t4JRaqEOgaF5xssdayyWu8alC4zlkraQc97StVvp4bIsk
 Ndlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741883; x=1778346683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A+mCXscX/ZXQdeivAZC6BeYLBLYIClDlWCGA7GSoYYI=;
 b=ZZoQmMG6lHZcETIsPrzJ1rFXsn4lbqQcKu8AUWEE0yTfYlKyIjih+SFNzR11p2fVh3
 ktIIxYqU0bGI9TY0TJgjXewwxWRJfWEmpdgfpOPMrR6b+kSqIkTYGzSa0QNL9j//yv6b
 FoZPEXkpHDtJOcS3FmMm+RwvwiewxSmmC7eBaALC0y4OrIrvPI8ZKaWpXeyx57191i5C
 OkOz+joaLk29faiEAmRoqPfJCrp2BTkfjp9eJisk5Ui28floJHySWjm9+05egHQh/m8D
 hXR6h9m/0DlYryV4PP1POanS8fdC6FapIAWrIQJbtb/xTbyH9KN4Z4gsif7RSdt+ere3
 RxGg==
X-Gm-Message-State: AOJu0YwZFpsDeKfJ/lMGq5c28rHl0X6uDmWLvccI6+k0sK/UeJpuV2j6
 /Hn9Gl7ISqzNn1rgfrr3dTGIdwATgasnEk/AsMkvllV88QXkv8xSxH+iayYWvAWsVVN110zMnc6
 50l4Po68=
X-Gm-Gg: AeBDieua9TzpqZuW95D5m4PocykjcoMqvykVTlbHknc3vOqv7Ojvqufj7FHRXnIL0qq
 V1T8WPGyod901AjLdlM9VKlNv8apz/UEi0IhBuM29vaWM8bfvxCUpWL/vANmBkxfWphEd3vawu2
 9UW3oT4xvfag/Q/ec2F3hAGGklaYHDy1G8QemePO1n0aXv58C1moBWssnHvntGJy4U2Iesfhrbc
 l0zq7+WRv3G3HmDSqiOM1BcPV6FVmzO2DUadx7kSRGaGOc+/2ww+qqHmnl2PJgGpiZP/x8B/+7d
 X3wOr9pXUWwXoK3KTlOqbFoglHQr7xGgyYqo3zfYOtx1Jrrst+R3IWnHF9CIYgPpIwkhnQNr27V
 joWGQTipYfbM5CfMKIp0j3O1kPgVFDNH+2nNJODvJVEv5OuVLkQYRBlYYPhbCrpOQcXL2LWuemQ
 P6ri4r/CkGYg6tG+H/z/45
X-Received: by 2002:a05:6830:4901:b0:7de:c6b8:2349 with SMTP id
 46e09a7af769-7dee13e34a7mr2176028a34.14.1777741883094; 
 Sat, 02 May 2026 10:11:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 02 May 2026 11:09:27 -0600
Subject: [PATCH v3 06/19] bsd-user: Add FreeBSD disk ioctl definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-ioctl-v3-6-a05d4cb1bdff@bsdimp.com>
References: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
In-Reply-To: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JIVYg58ib9lLk94KqYpsU7AJq+fP+Cd19JDWd7O58CU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/PM/qxyMLLaHGlzWavXX8Mh9fipA0pPsoex
 6v3CMYGiqaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvzwAKCRBsHNEofbAR
 AHXcEADBnYa+IYSrpOELRWZgxzhcrW7yCiJWVLT2ladMvlkaGfytYuu0wBpGzm4w1nQvroED+HG
 MwkUDnZvwZvZt8nVjAn9dP29htBAnDoKLBY+sc6sYv3G0uaLcTBG0PzroFJN/Fle3ULN+0U8V0x
 RNc+Zn5BdIltdAfJSZuf5AuSBWa3sGrEER9/nqNTrTta0/rp35r6T/3M0jKI7Y8HvUaL0yCPl9R
 qEziG6J0S/gnk0/vM3O/R4Mf+RBJj9SipwSixyK2+1hIg1W/PTxqV1wJcO19WvcfBb3QlE4Gs3P
 pfRZPGzFHoEWCGteCHXaucOd205WcHcB48qpoQNYWQXV+42ePyEGxnajw12GgJiEZQJVm72uZfP
 LAipsxn+z26nl0R45OX2nt8odPJkrbZ7LF9qri3MiSYyBlJeq6h4Oe6NLfYqF7Jp3uqXB5scQXa
 S0xqtEpnvHYGp7nYYdjGpiK4mDBFMAJq2Pu3C5QulbwC4794sCvVjuu/HZ7PsO08xaiSsx7xSLn
 fUHOvbdqXVq/MxZMzAWI4dXNshLHP4bChrbV+p9tngf8dHcF7pPTeh0eQsimlZ9o/oi1UFcgg9U
 VPv9zjk7SbDZ8wwKzRZyZ0rYeYyPb8WhOXrNbrGevnrbI7UXjkIaaMYp3ukj8uWwdS2fOQGwQ+5
 /a6GRn0eIkBYzgw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Stacey D. Son" <sson@freebsd.org>

Add os-ioctl-disk.h with disk and storage device ioctl definitions
including DIOCGMEDIASIZE, DIOCGSECTORSIZE, and related disk
management ioctls.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-ioctl-disk.h | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/bsd-user/freebsd/os-ioctl-disk.h b/bsd-user/freebsd/os-ioctl-disk.h
new file mode 100644
index 0000000000..8f4dddc7eb
--- /dev/null
+++ b/bsd-user/freebsd/os-ioctl-disk.h
@@ -0,0 +1,52 @@
+/*
+ * FreeBSD disk.h definitions for ioctl(2) emulation
+ *
+ * Copyright (c) 2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef OS_IOCTL_DISK_H
+#define OS_IOCTL_DISK_H
+
+/* See sys/disk.h */
+
+#define TARGET_MAXPATHLEN 1024
+
+#define TARGET_DIOCGSECTORSIZE      TARGET_IOR('d', 128, uint32_t)
+#define TARGET_DIOCGMEDIASIZE       TARGET_IOR('d', 129, int64_t)
+#define TARGET_DIOCGFWSECTORS       TARGET_IOR('d', 130, uint32_t)
+#define TARGET_DIOCGFWHEADS         TARGET_IOR('d', 131, uint32_t)
+#define TARGET_DIOCGFLUSH           TARGET_IO('d', 135)
+#define TARGET_DIOCGDELETE          TARGET_IOW('d', 136, int64_t[2])
+#define TARGET_DISK_IDENT_SIZE 256
+#define TARGET_DIOCGIDENT           TARGET_IOR('d', 137, \
+                                        char[TARGET_DISK_IDENT_SIZE])
+#define TARGET_DIOCGPROVIDERNAME    TARGET_IOR('d', 138, \
+                                        char[TARGET_MAXPATHLEN])
+#define TARGET_DIOCGSTRIPESIZE      TARGET_IOR('d', 139, int64_t)
+#define TARGET_DIOCGSTRIPEOFFSET    TARGET_IOR('d', 140, int64_t)
+#define TARGET_DIOCGPHYSPATH        TARGET_IOR('d', 141, \
+                                        char[TARGET_MAXPATHLEN])
+
+struct target_diocgattr_arg {
+    char name[64];
+    abi_int len;
+    union {
+        char str[TARGET_DISK_IDENT_SIZE];
+        int64_t off; /* Want abioff, but this will do */
+        abi_int i;
+        abi_short u16;
+    } value;
+};
+
+#define TARGET_DIOCGATTR    TARGET_IOWR('d', 142, struct target_diocgattr_arg)
+
+/* Unsupported, target_disk_zone_args is complicated */
+/* #define DIOCZONECMD _IOWR('d', 143, struct target_disk_zone_args) */
+
+/* Enable/Disable the device for kernel core dumps. */
+/* #define DIOCSKERNELDUMP _IOW('d', 145, struct diocskerneldump_arg) */
+/* Get current kernel netdump configuration details for a given index. */
+/* #define DIOCGKERNELDUMP _IOWR('d', 146, struct diocskerneldump_arg) */
+
+#endif /* OS_IOCTL_DISK_H */

-- 
2.52.0



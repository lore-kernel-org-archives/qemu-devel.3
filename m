Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196BCD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe9C-0001Ex-JG; Thu, 30 Apr 2026 23:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe99-0001EI-RF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:31 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe97-0005X4-T0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:31 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4232323a7daso727342fac.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604548; x=1778209348;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zXWcqieCQQGOx6uu0Rw2ijLJDJTmXXLiFYw3UPpcYgE=;
 b=TG0Y0vM3uUUC+/MizVfOX7cqw/tbnIfBd7cK485KNP1Q4+Sn7kko0dd0rFcI81Rl0F
 AS9SxXg1iN0tGijQ7F9Dzvu1Z7S67qRKTpMY/j/7sP3stojVKfcWQFJ+/QwBF0XikrS9
 Icfh78sPYcgEEtkbtnxTnaCBTXPvIuYFhdHKChJtB3plkYhO0VQv29NUgJHxvm0URq12
 cUzvAk8ydLIcHXCXh9GX63GGTOd0h1V6iMHN/9GZS9dOz8VIjSxZTm1n4+J3vF5iTJ/L
 vPIQgt+nXdjNu2ENI8ojUGK2qyL15PNr6wH90E2XjykOEyaK9giiBaFYugzyYjXGQNkB
 Pbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604548; x=1778209348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zXWcqieCQQGOx6uu0Rw2ijLJDJTmXXLiFYw3UPpcYgE=;
 b=WEiHLBjevVrS96V7HQHq6bJU61gIdLhN3LZbwQM9p1fLNRhQzPmjnJ+GddmKFeMKsp
 auhLJ+afcZU/MSzbVNsO2VBP2DBEiP2oWO67ojvy/5w91+bpJFIsSXPimK/oBpWBAYYW
 LFjzvLufYJ7xzWcSXU9KBJr1pX/ap6Ep4eVGaaBZIdRemoauAjHoUAlvf4nAHcgv42WX
 /ldzauH5ABifxBL8Up15Dkw72v25sKkfqRPZBKXV6sp//6GjB3qyF/lu9x+bfE8qWdrp
 1XmV/69OSS9KUQ14NS8p+eBD6zokfIAjHyvej/qWzFo0CzQt6hEJb5LPBMqKY56Y49Vl
 JQTQ==
X-Gm-Message-State: AOJu0YyP7wOQkqac3gMWYgLVN/jLGJhGzzuU2QBw9xdyJsKLj+Nyf3iF
 F4dTTCi6ckCP1O+y3YK+XepkI8/S5VNCFJKRkUjH8msx9bvH3NHZWkogu+XE9YbvdIk=
X-Gm-Gg: AeBDieto6L88lZwQnwqmylfW/FLuHG/2IIbqkt8h0BusMrnpozkoz5+QO9AI/2AX3mm
 92ja5z4V64FnueONMcXhx+aLANotYC+FlN0xKiIykajF1VZZJJCyt0EGC9HFTatPObm4gHS2U4i
 XOAh1x8e36HrM5rQr4fSPnBCH4U6z4CHIb3Jw08VkdIDKP2Qc00w/JdVhadEb1KbmoUTK2xU/1w
 RpXli0BPzm2TXRMIvuka1bv1YVxMRwrrTX23+SCn2tKmnNnvbzi7azJFL/KDKYsayMoCsXRFHLS
 pyelQzjJbDBnRw2PwkXKuFiGEz71tj8RGpgkI8EdMJY6uphVDOfyR5+O5tZjXB03Jxg9JqzsAU3
 Hv0qOFj1I6pikkxIMmom4sel872i+mzvuqmbigMYKvioiPvjP8ApjQ6RjzYbjXoikm1CbLG6o1s
 j3sR8yN3c4CQZe2KukKfdB
X-Received: by 2002:a05:6870:d87:b0:430:3591:26cc with SMTP id
 586e51a60fabf-434337221d1mr3252350fac.8.1777604548530; 
 Thu, 30 Apr 2026 20:02:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbc3c7sm1550875fac.12.2026.04.30.20.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:02:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 20:59:30 -0600
Subject: [PATCH v3 1/4] bsd-user: Add syscall header generator for FreeBSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-syscall-nr-v3-1-4b1b2445e28f@bsdimp.com>
References: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xEPjNFAagt+hU6d3LgpAiHD/UMD+gdHHXHPFBAUagE4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BdiB2tvPraB7AEKmxDEXkuu0WfX+WpLa69QM
 u+2vyQsclqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQXYgAKCRBsHNEofbAR
 AKJJEAC5ochC+1mM/sBJv+HiHHUNhDKwifx+MZrVPPzvYQIHHpGcyb0Hbt3Z0f3gJj7uXdJbrsi
 FqS77EoQVW7/0SbZT8C1anP68Y4N4ad0ZNjqBhkUQveEx2lF20vdMTVa9MKrJlGTm6rWvw9tIXh
 YvJ1cymzfu3M5BcDYaaoUMItL9EaoJjSUD6zAaSf7+HmQa1nutBTIzgnDkCBp4MMKm1NDSBhWv2
 La43GqqNuXuXcglNANvA4lRVc1TQEgrT4AZKBppgHhgrbasZ9b+aabYfpJ5xryf96lbl8VCAO9e
 S/FdrvMC19tDFiYwxU7PezmSuq7YBy559okq0qBMyW1+/e+DhCSapVWy0W+D+kUAq6Qj5xztE4H
 kA3M+JoKTIaP4MHE9kNUS8aToH60QBNX1tvyQQ62JOLIHLm4gDvgHlCWtTTUeE12MgUL9GXnxuK
 GNvB4HadJ+zp5YYIzeZGVjIhZmbl+FVzNPgmqko//PiU0zzp1aV3KAXKMm5wjmqkDpwsQZ/4ngc
 l9VXq7arnKpAVTmVXq5fgF5kr1U2n/xBPpBC2xR83txj16xKF5uVDr38sW+SRCpsD1x7U74rKQq
 QESD8BVOW++5N9ocT6P69LjNzUJXX5CtaMvXyDe2HkJTswQTCOiBXf362jNX54HnZAiKmi4OnQR
 h2/MrOg/pI5vwbg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x33.google.com
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

Generate the syscall numbers from the installed header that has them.
Ideally, we'd use FreeBSD's lua infra for this, but that requires that
we have those files installed, and they aren't quite the same across
supported versions yet, so use this simple, but effective hack. Add to
meson build, but unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build           | 10 ++++++++--
 bsd-user/freebsd/scripts/syscallhdr.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 8fd6c7cfb8..38f2debf7e 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,6 +1,12 @@
+bsd_syscall_nr = custom_target('bsd-syscall-h',
+    output: '@BASENAME@_nr.h',
+    input: ['/usr/include/sys/syscall.h'],
+    command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
+
 bsd_user_ss.add(files(
   'os-stat.c',
   'os-proc.c',
   'os-sys.c',
-  'os-syscall.c',
-))
+  'os-syscall.c'),
+  bsd_syscall_nr
+)
diff --git a/bsd-user/freebsd/scripts/syscallhdr.sh b/bsd-user/freebsd/scripts/syscallhdr.sh
new file mode 100644
index 0000000000..fa38500775
--- /dev/null
+++ b/bsd-user/freebsd/scripts/syscallhdr.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+in="$1"
+out="$2"
+bsd="$3"
+
+awk -v bsd="$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $in > $out

-- 
2.52.0



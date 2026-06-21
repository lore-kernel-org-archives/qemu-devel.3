Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2430BCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hd-0003Bc-E0; Sun, 21 Jun 2026 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hW-00036I-C9
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:31 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hS-0005Ja-Oj
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:29 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6a0edfe29ecso749684eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015745; x=1782620545;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3TxSIc//KvRCBTt8ON7Rqf9qcKkBcCSTr5Rkj6ICkpE=;
 b=eL2I5Ttr4RUda/rCIhBVOCn5xgB/0Dlzpl+AgQc2k2PU/vn6ArQmSBI8nvrpE7A6La
 tC+ts1A6YFI5YYKPm9ZKlZ+hWbIFHMv+dUtPZuOhECtmfzES+ceUskNSQV8y+Qpa43dQ
 G+H/eFQK5dfFPptV8hqKYYy09HlLhQtmfmoE5l+6PuWrctdHEf5adplr7nBMw8SXPOJ+
 kwzcW06opJ3I1lsvzH+xWZXKx+1wAXeMV2CjLpwI5ncJ/H6+C56aSv8fJoKBM8CDalLu
 iFBHxeysfKQfjTE4xYt4wxl4Mb1CVHrm1sc5QzaWxQnBPOzYIgpDLTI7VZAxN53NOVPO
 iC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015745; x=1782620545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3TxSIc//KvRCBTt8ON7Rqf9qcKkBcCSTr5Rkj6ICkpE=;
 b=WOgPHwcnhZTir7n3gBo+srFdBASQnUuF6I+9JAnrl7J+T+jzmZ0yTVb/MZvwxMZLu1
 lYSdsyaTtFnwM1fPp8pjX9odQTKdjxNErNONifBrNfwGw99vxUcxYc2Fvvqc09tFnXsS
 DVTrL5Q6VhDZZUfhiyZIEJB1qr/h3CrV02ZMSpFFXqKkM5HTPxHY5F+iTSaYD5YnvodY
 0Fxu9lP3CB9+7BHmokcqtX4dnUSc+EUbKv+xPk7A6+vWbHV0Iq6hYlHT/S0p54iNXms6
 tFNBlh4mjKijTncMJfVOSx5M+pvgaf2eK1j3m+TKFb7fVdZqt8wfBYJmFDDgC77dQ6Pj
 sAkQ==
X-Gm-Message-State: AOJu0YxfjptJKoNs4fl4ingRxx+MTR0Tm4EHWQncxElp24GSbdJEKj/O
 T0bNaCoHB7xtLmIExnEUahRTmEcVtXtc8k44nHWhicoh1amyivmAmpAcpGF2hu0fSP0=
X-Gm-Gg: AfdE7cnd1vUraofc/zmL57BcgvyOw1XZr17Yt191Or54aC/wdfoP18kWgZhJ77XIcAV
 AEf0nh/veYOZFJijsYC7ZB2B/AnekShFSYBxy8ykyEzDB6K2YKbL1yAWp8FSKGDANHAY9LI3w+d
 ycvqSlXCryNnf9Zb17rro3M4ad0S9hcfo6gY5HMvIziW3qaGSfmD44ERFXcZX0gRcae0Gq7wtdL
 lm0YBB8w5ZxScq0Yy3WWqIX90kZ913uDHuuQpN4vr3/r6LRbF4C+zHeAQ+E3pbAyE6Rbjl5fNur
 mvkzeQdTVs+rr1qvMNe+JGfhV/mKvR4EBw3AAouxoBmdDFszsqtNdrTqxdXFKTA8kWJbrVrRc4C
 7I/CsTtItmvwMzI631XfHOW+6CDvLjU5WM+nwtarCJXI4iZtewBf3XblAaMl5gSIW+J6v49yA14
 w=
X-Received: by 2002:a05:6820:1899:b0:69d:ff0f:bf00 with SMTP id
 006d021491bc7-6a0d8d4fd48mr7633446eaf.49.1782015745645; 
 Sat, 20 Jun 2026 21:22:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:18 -0600
Subject: [PATCH v3 31/40] bsd-user: Add os-extattr.h with file and fd
 extattr functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-31-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6717; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=LUey6wJVSpmvZsd6fK9YF3w3PJFg68bn7AeYGLCH9GQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aA4PBdruLNNyczRlUuQgyJP3oMoT0w5eCh0
 KapjVck3rWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 ANECD/4jKAK5NHd44XReTT9y7LmYcl5VSHf4h1QN9dEw5oL0yJnVtipWO0dzCyKoe605KxHaosR
 Co47XZqAoTxlIzJ/9AYNJn8IJ+lhbWgFC5/Hec3wnOjKKEAAPSIUoPcOV1NAH/oqGop+jV0/EFa
 9FpZPbBHYKe6030fMnZiuVpAysmboMbDOT2g1YatUrSrk+MNwu03GXB3jIwepEMTRMble3BXvBB
 i79TLmzmzTqhtPS+R0JOMF+cX/56xAnYnaplCQiHIfn4agEMjmri8pwKcS216b/V/MzkAqucao2
 QKd7XDFsXuYjyJiwbpSrBwh00KzcBl2Np/+hBa7vt9ewZ6HDPgmGUv6dtBuReoNMjn9YU8nBH5r
 WZjqoqXuzIYsRqN65lh3sVxG0IeTCg6GHTl9EAYBsXAQ7RYp+qpPDAWr4mosQeoq+Y8kyU8NofD
 ijAZw1i2Lx2cd7Jdn0lPoPnAAEj8GnzV0Lg74swfeMIUT4z0oP4+ZDgVHoD1eHBayRnOAn+5at/
 qouVSiDXeHHTUQEWoxE7hGmiJnfohEWFY1XgtKC+7Kpk3oAesoRrPdv4VcZDn5+Bkxo/JlP3fPa
 1JjJAbIQgoa+w0VpPHeXig2Wji6yDF4pj6eE2GOMiDR9ysn9m4BDP5fIjbRKwjMsJxyIpEosbh0
 RFe8YpggL3Vgd2w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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

Add the first part of extended attribute support: extattrctl,
extattr_set_file, extattr_get_file, extattr_delete_file,
extattr_set_fd, extattr_get_fd, and extattr_delete_fd.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
new file mode 100644
index 0000000000..fb3ef27346
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.h
@@ -0,0 +1,208 @@
+/*
+ * FreeBSD extended attributes and ACL system call support
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/extattr.h>
+#include <sys/acl.h>
+
+/* extattrctl() */
+static inline abi_long do_freebsd_extattrctl(abi_ulong arg1, abi_ulong arg2,
+                                             abi_ulong arg3, abi_ulong arg4,
+                                             abi_ulong arg5)
+{
+    abi_long ret;
+    void *p, *a, *f;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    f = lock_user_string(arg3);
+    if (f == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg5);
+    if (a == NULL) {
+        unlock_user(f, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattrctl(path(p), arg2, f, arg4, a));
+    unlock_user(a, arg5, 0);
+    unlock_user(f, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_file(2) */
+static inline abi_long do_freebsd_extattr_set_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_get_file(2) */
+static inline abi_long do_freebsd_extattr_get_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_file(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_file(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_file(2) */
+static inline abi_long do_freebsd_extattr_delete_file(abi_long arg1,
+                                                      abi_long arg2,
+                                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p, *a;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_file(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_fd(2) */
+static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_get_fd(2) */
+static inline abi_long do_freebsd_extattr_get_fd(abi_long arg1, abi_long arg2,
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_delete_fd(2) */
+static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
+                                                    abi_long arg2,
+                                                    abi_long arg3)
+{
+    abi_long ret;
+    void *a;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_fd(arg1, arg2, a));
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+
+#endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05177CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hc-0003AW-73; Sun, 21 Jun 2026 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hY-00036r-5T
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:32 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hW-0005Nc-9Q
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:31 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a0d414f71bso1165481eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015749; x=1782620549;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cdGgw9J2TjefPWshhJlLv/nPFfs6MeB5pR26lmCLgWE=;
 b=vFN3NT7NyY9i4Lvakw9RrPr4lth1kdDi48GK7kHY5GBmropwUCpOtvkXPTdb+yDhfU
 zSrDHgUzZ39iJJP2A2sywxvVY6ZHxmkhbohfeUrgnbghfVVTsn6H25KjACLrJ2mjEZcz
 cf68O8Folwp2pCQb18fKPIH3qZ4ufEJKfq2+gqhhJEzcl2TwqWa296zBfjhB3amtJmcZ
 LAd7aEGssrR9eiiufyQP1I8M69GUthAoe30nLJXM6Bv0xAYVa1kn5Tb5WPBLwxBcq2LD
 y44Gb4EIRMvRZvw6ujBUzJGw7L7zJ08ObeEdn0ys2jznMcTmNmXJNI4DpEQGlxif2D3z
 FwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015749; x=1782620549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cdGgw9J2TjefPWshhJlLv/nPFfs6MeB5pR26lmCLgWE=;
 b=mqjCM/58O6GghM0luqIPVAsTRAmZLWAgtaIwNbI+ovaLmvKXgotyN4I4gqLb1e2Sui
 SkYtr3titMOogEPYkV19zbvWp0HDtPwvV3eIR5hx+AuYjrlLhLfUpdx43YmYLufZ9Eff
 IXI0iaGCZ/YFljglk/N8FZYkn6GHPyV1dxdsds46SYd34qETUUOBbb87/Y6Z6EB+4CL/
 7g9nmdqz+0fN46luhd+X8FG9ROIui4joLaawRpj1D+eR0OSM1FsnRbgdTJ/gzp/IKKX8
 2iqz9ytO5GUKAqcAIZoCblRT25e9XlRAdncm7hyea8Hdb1i9zgGk72n28C9F74zKV9Rx
 Qwnw==
X-Gm-Message-State: AOJu0YysQj4SsdyFC2/01rAAqfDhg+yyz5CLgv0FBcD2gK4diBGt64vl
 bBkaTad8bhoCfLBoiKhLRrtRXODM+osC2XqzlZX4T9oNHzOEnUr2Ks7/yMs7gLFWMQo=
X-Gm-Gg: AfdE7cmzL/C3WkE5QL8ZeIRJnmvKWMb/ZuOBGy8rzfy/CR0WnPRrRsLfjf68jL74mmR
 D/ijVCCJ3mcpvRA9LikHuHh2g5L6yqmBqP0+li5zZnvSBz/q8hwfN4bif4chX7yhLVe13hLY/tw
 viRWD1rTBzXyco4TEbDaSM5T5G1FiTSfEOKv6Avc8Y6aDqMLaOCJEa9v2Wer10iqNKJNhtzEn/X
 wX7SgI194KBNVvebuJZNoZ0AgcKO4ixrcJQ76PbuZqx65ts7okBTo+U3HqiVWMP1QkqCIkyFo4E
 uoq11vtYY38PXrpUTL/5WnDULyjRyeC3AAEU/iDybQ3fMn+8e72yrHTiVwSUbPZCGkmJUnqniXf
 1XsEcih9bbS+7TaT7gvLqBWeIsMYf/7UZzgRqwAdazqfgfap32iGxcKZCeNh6f7Jy+JrIL+Vupv
 o=
X-Received: by 2002:a05:6820:60c:b0:6a0:e2f5:3b04 with SMTP id
 006d021491bc7-6a0e2f53f33mr5062202eaf.20.1782015749069; 
 Sat, 20 Jun 2026 21:22:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:20 -0600
Subject: [PATCH v3 33/40] bsd-user: Add ACL system call shims to os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-33-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9909; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Fes1JZRpOKohxHTDoJ0In8LBoQveGPHkqA4NLSjPKwI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aASdymR+SnXBZ5H7+ZR6XzxFb4FJ4qGoIJa
 h/UnlpyaPaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AHWVD/9XveP4AzjpxwQGF1VdgVjPOasY/S7OhbCV6HyORlvO9HUgDduZMrbNRNgaTmNEXVd4bY2
 uAMzIGPFOP/eCBMgGkqccgPkNn+5jmecwmjC9leOemaYJ9WeMkw+bwG3wUt0kFkar+ok2qvLEw3
 KNxkBkdyEildkIHxUST9AIUN1t//H3SpI36muO0VNnhICWhPFHyWXwapsHXf/Y0LpQw0unQUvtk
 4IwQSuVEO8KBaJ51KCPk4LCUovTMXsoaFDHuqlisQwHavbaaUv8WofcyBABggThukbSfd3UJp4W
 4uo1ovsQdbtNYQbnO4SEgqx1AbpIiR4P5S1+T72uh7KA1FnCrdGqYropBsQ3nB7YMR3Nku5JEPc
 9H66EXNFto00m5AcVGGgVEhqDYb/HA6pGF0vXhsXkkz/IZje5Lgczo06brqKxr/B2MIF7HnxCfD
 aaGLIBdJ+26exH37W9B6KiOK5bNzkt9tg1H58mi4yifIYBUkwOaD5Iw6SGsXqm86TCOo841HZ58
 o3JYh6BXqO7z1caP9FkRnCgCX10q6QExvKuKzoJDYpXoedzcGwQ9OdajnEsfVqHMskfFBz/5mVq
 Q19/Mi4ZTSTAzEutmyFFMw/A8cufIP2ODn34mg0JT1K9MDnxE7JkxVI6Wnjy8gQXCPLMNm2xJEq
 mW07NBA5edwKlfQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Complete os-extattr.h with ACL operations: __acl_aclcheck_fd,
__acl_aclcheck_file, __acl_aclcheck_link, __acl_delete_fd,
__acl_delete_file, __acl_delete_link, __acl_get_fd, __acl_get_file,
__acl_get_link, __acl_set_fd, __acl_set_file, and __acl_set_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 289 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 4 deletions(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 90f0c64c93..b6fe9051f1 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -65,7 +65,7 @@ static inline abi_long do_freebsd_extattr_set_file(abi_long arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -151,7 +151,7 @@ static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
 
     return ret;
@@ -267,7 +267,7 @@ static inline abi_long do_freebsd_extattr_set_link(abi_long arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -376,5 +376,286 @@ static inline abi_long do_freebsd_extattr_list_link(
  *  Access Control Lists
  */
 
+/* __acl_aclcheck_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_fd(abi_long arg1, abi_long arg2,
+                                                   abi_long arg3)
+{
+    abi_long ret;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_fd(arg1, type, &host_acl));
+    }
+
+    return ret;
+}
+
+/* __acl_aclcheck_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_file(abi_long arg1,
+                                                     abi_long arg2,
+                                                     abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_file(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* __acl_aclcheck_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_link(abi_long arg1,
+                                                     abi_long arg2,
+                                                     abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_link(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_delete_fd(int filedes, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_fd(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return get_errno(__acl_delete_fd(arg1, type));
+}
+
+/* int __acl_delete_file(const char *path, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_file(abi_long arg1,
+                                                   abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_delete_file(path(p), type));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_delete_link(const char *path, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_link(abi_long arg1,
+                                                   abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_delete_link(path(p), type));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_get_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_fd(abi_long arg1, abi_long arg2,
+                                              abi_long arg3)
+{
+    abi_long ret;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
 
-#endif /* FREEBSD_OS_EXTATTR_H */
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(__acl_get_fd(arg1, type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+
+    return ret;
+}
+
+/* __acl_get_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_file(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_get_file(path(p), type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_get_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_link(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_get_link(path(p), type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_set_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_fd(abi_long arg1, abi_long arg2,
+                                              abi_long arg3)
+{
+    abi_long ret;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_fd(arg1, type, &host_acl));
+    }
+
+    return ret;
+}
+
+/* int __acl_set_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_file(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_file(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_set_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_link(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_link(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}

-- 
2.52.0



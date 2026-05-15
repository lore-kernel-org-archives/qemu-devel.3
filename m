Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E075CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxZ-0002D5-1x; Fri, 15 May 2026 17:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxW-00021d-51
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:38 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxU-00032z-1V
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:37 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so332493a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880034; x=1779484834;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/Pm983+RalHXEJdvhTE1ujaaD6WPIIdOj3PbrYoEDY=;
 b=w/hTTCD7PqSbPKVP1wcU61KyDBV3XAJFt9BzKEMdI3BTBDKOoRtlQ8IFhNEo7Bkct3
 U+UM9/2rimjBEN0VSF0H4Wtj6aUV4szD47bq3A+Ew1NMqeoPuyYKtG9ausDJQniQgMPp
 A2n6ao8xC1mpgkdrD1m7OiGPRg8PtIkBuGqZkMQZEBdodZ3YyfLDROdS9xTsyiP8MeV8
 P8AzAAmOFc89LCj2ZoHrlqHZK1bW19DPmrpJl1ALIw4f2l5Bv1Bu85+K9SVHt75k/AIc
 wZtf30HdXDQqAZdSTwQvelogRmVBAU0Gx4qLipoNU1MULEKD3KmEG17ZY5WvLvZAPMR3
 Tmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880034; x=1779484834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9/Pm983+RalHXEJdvhTE1ujaaD6WPIIdOj3PbrYoEDY=;
 b=BJe4FASIZS3slfpzxlDX9D/XPXkxxpyG9qHotBgpHiI4J1NnD5xF3e4Pu0zzZcRhgk
 D9raEAz18WwuEPxMpCkDltXjYgX89uK2eWuOzZb+F6ldEmszX3HTFx67TsCY6QK/bMBB
 t8zVSBUABQvb5jF3NFsYaWIohGYYhXOOkx86o4oJUPRN5MFCUNOaQpAoUFofSJBqiO2r
 fDc5XGI+3g/oiZrkurCgrbXn7xaWp3hUATyc0HRruWeRnlKLUKAtGjQSP68tOC8/1Bl2
 S0SL24D1ZjWSpaml6V0IPzXppkxEQM0FMmFjAbGzIlvdqIQkWFJNGC/9t5L+GsFPo8cJ
 Ewaw==
X-Gm-Message-State: AOJu0YzEvvQ8/aGPKcowQiE9ZYsI+OpFyW4sDJRRMJ6Xw5Y/0T9beXfA
 LW6h8WvB0MGz/sWJdGRxhpctlUmGsYkzpultikMyxy7bNWkZ1pbUzn7eoCEgPGfz5a8=
X-Gm-Gg: Acq92OGyaqiBRbTWIXVdL9+wSTB5ATk/myomI7A9dD9835WXO6V/dMJ0bFBSchGIcNK
 6i6NMb8r7uS2wyNcSDFCL2VHwpnvi/LtyLiV8QVLac04H2Wf9bzq4oUwcXpiSy2fIROEToXPl/s
 Xd/DIa6euUj1UEM4HYsulvlqGI9g0FCWHZCjyQ/l4ua9wveGwoMJyuQvBg7gABPbWM8jaWCs3Cs
 sX6r+ABdz0v5ZEJegxtt54Q9A95HVDoSc/siOyfHMsnAQjrnoKBOqvvGuEiuVUIAx4eileuiDfI
 IKjwZj2jHWDhi0KhL9kqLt/imkT/Dv+H+TlLlhgKQRdYM76khiD7h3wofAO3vh2z/kqWQpP2KgC
 /rYzeaLN0QJFpzlXQ/nlo4uKdqSTNCwxkzf/zxeGys0G6dckAsEeL+f7PM3dKME1kcJ4ziMtszk
 Zl75F9GKwjGg==
X-Received: by 2002:a05:6830:4c04:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e4fa06446fmr3965295a34.24.1778880034467; 
 Fri, 15 May 2026 14:20:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:30 -0600
Subject: [PATCH 31/66] bsd-user: Add link and list extattr functions to
 os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-31-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=PPbhfZAlz9FxOpn1hoNZ1jrd9DPBmOMpHGkAGZveSpc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43kZmdlzxUwwxCsBRRp5nEzZUe0YCh8dmY+q
 O0lsq19aDOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 AMjzEACLOr12epv26/BVVZn6bW91utDSfDrWoR04qv3Y2ugccezm3Cru2IdHuzl1ww6w8btfU1R
 18Vb4S+H7YygVeifVuEikmf08ddsL+cBLHXYq28fbs/E8DISQVus9Dgf9+kzNcqRsmH4P+gz2S7
 wBP1Yg4gEVh6x4HiiLnAU8lMpH/UscIGVtHyhdsXz17IF2BVs3ZKOCvxIowow6F3Ax8W5WysVoD
 mzJzR+riPnbYYVNgjk59sRPk6jSCpxJODuZEBgkiKrOWP8kDNayTbBeMq7rilft+mEg0lMm+TX/
 xF7Mv73v7Xr5CG3gaEEwxnBPNM6w0NX4ULeXsP7yKQT/+2l4z4jvCbJd9u05QvHnAuGY9h31FNV
 CIybZvr6McY3tYNk0KaYvaU1yFQcHpCAaDRxCPT6+H2QMKUUZ7Fw1QFDXQew9AqaaMZDqUMogEA
 0JW8irh/YoFCp0xuWViNl5U8UlvUJs+eaFhUtVoFnGTZ+F1lbdwU5B4UhUDPkjAXsHWMdzZCxIr
 BBhFniWohT3QqMQhAMm/2RnOpesI/hp5xULMQ0P2ST0brp+HHN6RJirfd7MkKh/zq2Ss68jQd0I
 Z6WzvD64SY9DeMIaXse8nA0u5Puq07h6rqbWiX3qrOMkc3FrZn0kcpa05RLSHhPl0i6sKEvies9
 4syv8bSHPz5nTGQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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

Add extattr_get_link, extattr_set_link, extattr_delete_link,
extattr_list_fd, extattr_list_file, and extattr_list_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 172 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index f1dfa344cf..788e40ef30 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -204,5 +204,177 @@ static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
     return ret;
 }
 
+/* extattr_get_link(2) */
+static inline abi_long do_freebsd_extattr_get_link(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void  *p, *a, *d;
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
+        ret = get_errno(extattr_get_link(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_link(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_link(2) */
+static inline abi_long do_freebsd_extattr_set_link(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void  *p, *a, *d;
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
+    ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_link(2) */
+static inline abi_long do_freebsd_extattr_delete_link(abi_ulong arg1,
+                                                      abi_long arg2,
+                                                      abi_ulong arg3)
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
+    ret = get_errno(extattr_delete_link(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_fd(2) */
+static inline abi_long do_freebsd_extattr_list_fd(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *d;
+
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_fd(arg1, arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_fd(arg1, arg2, NULL, arg4));
+    }
+    return ret;
+}
+
+/* extattr_list_file(2) */
+static inline abi_long do_freebsd_extattr_list_file(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_file(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_file(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_link(2) */
+static inline abi_long do_freebsd_extattr_list_link(
+    abi_long arg1, abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_link(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_link(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/*
+ *  Access Control Lists
+ */
+
 
 #endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.52.0



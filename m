Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8E7CDB46B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9he-0003Bo-00; Sun, 21 Jun 2026 00:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hX-00036a-RK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:31 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hW-0005M4-2T
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:31 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a0d414f71bso1165478eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015747; x=1782620547;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6fL90qm028cjo/IJBtUKpLhGo6bIOnKXzc7SndzN8JA=;
 b=iC5sDqX8/H69VqCE+o7ezYDD79Ulhs1HLu9DJnrIk/SYpgVtc3xgTY5kRuL7BktZ0u
 +sQvEO3T++Z/AXRFEqAmLGAUUfKa45qlwLAIsGMBJoBqEEeTNYZeMeTZvGSxBahr95qD
 F/ue06CqVLAsMPP5AM3ybbl7asZAYrgALIInVuAx9llAEZm89hdgKvdnkM/lzzEExwiy
 yC6OyMER9lwhgYEXABxG0PbUEImwnwU+IlrJoU5n/pDFX/ImA+7Hj6hCRtg1ZU8XnN8R
 ex3rSaMyOX3D4NyB+aCXyw7fXbfuFW/TJJ0+NS6HiaOI1caxOI9ci29ncHd763KyL5mq
 ci7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015747; x=1782620547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6fL90qm028cjo/IJBtUKpLhGo6bIOnKXzc7SndzN8JA=;
 b=JL16ZTAPCk2mf2mMnJV8R0QXfdrEgeLDaVUb9bEKeg1EG8UOf8HysLVT5ZmszcOdgT
 kIMJbO1L90GLt1pAcdjvSwEX+XkapEJNI1Mu62Z1JJ1ez7vma7G19P/z3aIFCgaOnmzw
 Plul1ZpQRQRw9TF0C4Ef7JwN4f/Bpw7VWq2FX8vH38a2GzsDIo4Q5EfZp/QCq7J2d4z9
 iCvjJSl+BLTM86Gud4VwGC3vTLO7T6KW/WPkmHFFE3mwjHjL6XbMlue9u/3KbyUirOS7
 owrESgwfgNcsjbU6IOWm9E6IZLBuRZ47tQ0EGf5PpphIcxv2EMbbfAybUrcVj7QyDitg
 khJw==
X-Gm-Message-State: AOJu0YzudbVHMYQcQ566vxS49dFeGnzX8/rvMUz4dXBBBp6bF9ncDvZb
 mWiWN1RIUYIVMx4yGHK/THOYeINnYWxHsJGLi+PKmRT+vl83WzOJQSsws+7BUjfh91s=
X-Gm-Gg: AfdE7ckYTGaMRUWTlbron5czBkJNw5PZ81eaOB+U/65V3+u9bVaxzhkKUqhluYuQ1in
 HaLtL4xKpPJaeoyDg4S3QjeveYCmzYyKmQ/tumhyN7+tpnVwt20jRmrLYVT5QgxlnbI0ZCwXmoy
 hhtPcVm3SndxTL3q3v8KLh7m5LbHRIUmKa+DkXlYmOf2GAjMpJL65oGDBaiZI/D8wus967GGaww
 TmwMz/IqrIjyqNRRY27lUgQJghJOV+oqfUHT22kAHVSqDexZ+ca4LWLs4i87dwwazK5c4xqgZ3y
 ntehk0mqUZ0mG8F9bS3kn9QMTQkZPTF/RToor95wB1LDEwPGkodixqV/gFCze/tOOq8IEGhgl+z
 lVFJmsl8kXcv0vKo0OyEWPrJUcRJBSTUsl4LQcDd+MwZdMEAIWV4RLHY1HtUZfvFHAq+Mj+Y+9K
 4=
X-Received: by 2002:a05:6820:2212:b0:6a0:effa:f806 with SMTP id
 006d021491bc7-6a0effaffafmr3463934eaf.50.1782015747363; 
 Sat, 20 Jun 2026 21:22:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:19 -0600
Subject: [PATCH v3 32/40] bsd-user: Add link and list extattr functions to
 os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-32-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5740; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=b4SJfc5NVhpHg6uMrnU4XB/74u64XqiuNxTge050gMk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aAsskoKfesAfHcF/iC5NmTA3Cb7xnj/1o+W
 JIZrJGxWQ+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 ADPUEACbaukbMg3KZ4OJyc8+n6qcAMu8UPFPuCb3W4YeqyRq7jD62PrIk1Ye/+mw4DbBpA4a17K
 IfzjRKbARsKYyp9CqMCysUutKlSc09LE62EAlT70TM79c3uOXYfhx8/aXsiMsj6YCi38I9M4Za0
 bTD+dC0zP1D6A5CyXHoGM8eoi+1tvt5lg3VDUOTIE2Rp8F6dhdgLvkB9oOMHNc+SGj5NEjPFfr2
 UinEEGST9qgI5Ze7kfX7sOrHEYUlw/cvZLTC6x5WTH7uba9SqZASEUmj44sfxRMUgQhy6/hlM85
 aa71mh+JuZbJ3zkc31/AteBsFKOgqd1HF6KbQytNYd1iqTYb72zxSVFeS8ek/ilawodYXU2OqEY
 jVihMBEt0s+EiCEu+cdTINliJUqOep2NlFAeuX4ybC2DOUV5bjO6SBfr0oiHqDTXw1hm0+5EfiR
 xGGt9oinIsIghvy93krcsygVt5Qgiz56L717Is6mNqntuL/m3wCzxTAzyYuhG8AefMTc278wWwp
 PdYnkf5Cg6x8kZ/lB2sei6P0luRJbqvFyu7gOS5bgP22o86yZIiJQwugSz9eTQeiPb3fMstTe7y
 fev6Ocsh27HL30afZww0KW7CaND4k8DYlvL1oDo8LMVruUN/oNhl10pNSnUFAdq2zOQs0cEjH8h
 O9gxZkxBkj3wxTw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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
index fb3ef27346..90f0c64c93 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -204,5 +204,177 @@ static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
     return ret;
 }
 
+/* extattr_get_link(2) */
+static inline abi_long do_freebsd_extattr_get_link(abi_long arg1,
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
+static inline abi_long do_freebsd_extattr_set_link(abi_long arg1,
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
+    ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_link(2) */
+static inline abi_long do_freebsd_extattr_delete_link(abi_long arg1,
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
+    ret = get_errno(extattr_delete_link(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_fd(2) */
+static inline abi_long do_freebsd_extattr_list_fd(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
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
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
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
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
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



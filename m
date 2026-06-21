Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C63CDB46B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9ho-0003TO-DD; Sun, 21 Jun 2026 00:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9he-0003D1-U8
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:38 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hc-0005Py-I0
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:38 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so1489246eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015755; x=1782620555;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tg3YHlLuXAcVGsKv4xJCZeoXsfp500/2TPyxlVqzIuw=;
 b=pGeOeQxtAFwuKRpd24Vh8HbJU1ZmBy/3d9pab9cWnYM9MO/VOLH7ulkx2wbVkWB2uw
 3MOsPyiNvIpXd8SGjAHXXzBT7royQ5djPgA3kCxQzAcHy301gs7Fxq5qoe66G3c5uu9i
 R6N4/AMG2YNdbbei2kx5dxcdpgW8fQluQWHPI8MYQWqI4W0pNCbG1I2Vk/HGiE6KNXYy
 yOZLnirc0eDWdll2+XSwXtO1/FraLpbzSYF/4a7cnfhrPDlbrgZLt52Wtw0X9k9OAlFF
 QjDGcyUwI7BhKCJvak4zm1B1cYojbKAgwfc33eJA4wmyptFXba1WQcr6XWfg/Bzk7LkW
 MaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015755; x=1782620555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tg3YHlLuXAcVGsKv4xJCZeoXsfp500/2TPyxlVqzIuw=;
 b=CH3ikcGtjbZkAU++ZLUrVHCkWL0OksYe6H9k4bvssUEfSD22ObvXKUgaCJP4EZIT+w
 HVRfknEN/y4WNSiGCji1aHqk3WuPc+5L29rfHBs2yQUIRY98kN5fPx3OZYc2O+Bp0OI9
 0mGAkbp7HYDsVjEhzj//Ys2chc7/GFartf4k5cy8JDwKT9fyRhk9EzDfsPzt4I7sOuC9
 J6tUT/R4SlJGkdvD4Olz/oxy6YdGx+0e+kVKVBNbGqgJGshpoD9pl7xWMWfjW+M67Hfh
 FxrIBN145THMMSyBKDYlBWnbVOrfk6oQbeczQVKHuv3NDZUgWuGSquFx5pyEfrGzDdam
 Yv0g==
X-Gm-Message-State: AOJu0YwQUUDHfxb1dFN5mo+CmMRRYA5t9xC5Q20Mifz5pHsYxzd4MfiY
 RmORVuUQoRSWD61hTJeMZwGwyG+qYMjuNr1XQFnULUbQfITqG2gS4i8d1W7nw+/mhhw=
X-Gm-Gg: AfdE7cms/mBGtl0ulWWkKRIzVjovkM7KAHnyk8V7PiYfWEY8phYkHgrFw5KTd3uDJTZ
 atfLa+5l+9zRlAmlloYu2p8lpBBF/IqMyumPfE77elkBi9xVmLOyPC9X1il384edwtiWzQs38MW
 n10XisZj55vPVZCCDLLlwLk83NXqdRzzoLHnlj7Bt6ijDcgwnL+kQ+aXl+iFrhvqekI1Pr04hbf
 nw2rt1HxqTAyp5k6LuRclfUqW2Wf6ID/rQFJxCb8wq6GNjutRh4+GXB0kGUhq+al9G5W5SGZ2N/
 20zk3x3c3TA5SRVgJbU0vYJ8R9ijkZi7s9ebeEpFs11EHqr6UPYvUGj0O8Wd4AgL6BvIh7Gl0vH
 8vTl0/fQYgD0o9yQx38FdFjDjKzzoUdsdkVWFrLWUaSerfNFadFwwZA2o8utJZB/8Quab66ObP0
 w=
X-Received: by 2002:a05:6820:8105:b0:69d:e3e7:332b with SMTP id
 006d021491bc7-6a0d8936481mr7486196eaf.35.1782015755417; 
 Sat, 20 Jun 2026 21:22:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:24 -0600
Subject: [PATCH v3 37/40] bsd-user: Add kmod, posix, and misc functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-37-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Karim Taha <kariem.taha2.7@gmail.com>, Sean Bruno <sbruno@FreeBSD.org>, 
 Alexander Kabaev <kan@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8178; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=iBp/lsj1fOvExflvuYEfJAp650GGJg0tE0FYQ1wXsmQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aBe6iRG2B+sAs8W1fOb49B2peacafHdssIG
 9y3G2Up9VGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 AG5jD/9ewzUQCbgHl5nV/LyPIn/5A80WK6XMz8awZxflG2Y4cnusfJl0oFr/AeKYef4Ae9uMyAt
 juqJKJz4q4BgMXA1DRj/V+Dr+2B0aN9FITtsrYxQCuFgNvmUoFhkdq0vwmQ/IJtyupI4invOXmo
 TrIB1ml0sENl2iw1fV4ZTH84kBdWpkRD4LPNQyaiyf2J/ht6Cdjeg0Gqbp9uMglHeOuhfi4wGHb
 dbYWm0gwMq50cQeUMKHRE7EotAv1segarxK+WlvnAwMq2NsCPMKf9ZyyohqaEVI3om66yiCL1Ow
 N/ctPtcMRj0bBLCnIjF/MQqdAeW9AUhst4yMjqvnbT6Vs/oQpnqzfNxoSW2+UyWsSZIVeqW/I4v
 7dqX9Kr18dnWYCd1i9GqaIGY+VYUg2cvrI4fCf448gTANdVS5z0mBFjR31//YxWWSi8jrs5R0PP
 j5S+sLxKl/I+8bK3Gec+9mWKNZiXQ1R9g0mc27tWuBIITaYRlgClEWNXr05LL/dmU1ABgbatTOZ
 GC8dcgliKA586vhV+3vaByl2H9n/x4EPd+jtpGUNjf1oA01XQlMuqeOIEctAmkA5nu3fUbv4pML
 5a6E7mFsWLSBfy4qPQd5+6x50mEeoFmuJcqjI1K7UwRV+rpo+sgqg4XIQdc6UxBKl43APnMN0MK
 r3rGhxWLvDIto6w==
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

Complete os-misc.h with kernel module functions (modfnext, modfind,
kldload, kldunload, kldunloadf, kldfind, kldnext, kldstat,
kldfirstmod, kldsym), POSIX functions (posix_fallocate, posix_openpt),
getrandom, and kenv.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-misc.h | 274 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index eea6371163..0f87b21cc8 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -266,5 +266,279 @@ static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
  * care. Will reevaluate if examples are found that do matter.
  */
 
+/* modfnext(2) */
+static inline abi_long do_freebsd_modfnext(abi_long modid)
+{
+    return -TARGET_ENOENT;
+}
+
+/* modfind(2) */
+static inline abi_long do_freebsd_modfind(abi_ulong target_name)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldload(2) */
+static inline abi_long do_freebsd_kldload(abi_ulong target_name)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldunload(2) */
+static inline abi_long do_freebsd_kldunload(abi_long fileid)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldunloadf(2) */
+static inline abi_long do_freebsd_kldunloadf(abi_long fileid, abi_long flags)
+{
+    return -TARGET_EPERM;
+}
+
+/* kldfind(2) */
+static inline abi_long do_freebsd_kldfind(abi_ulong target_name)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldnext(2) */
+static inline abi_long do_freebsd_kldnext(abi_long fileid)
+{
+    return -TARGET_ENOENT;
+}
+
+
+/* kldstat(2) */
+static inline abi_long do_freebsd_kldstat(abi_long fileid,
+        abi_ulong target_stat)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldfirstmod(2) */
+static inline abi_long do_freebsd_kldfirstmod(abi_long fileid)
+{
+    return -TARGET_ENOENT;
+}
+
+/* kldsym(2) */
+static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
+        abi_ulong target_data)
+{
+    return -TARGET_ENOENT;
+}
+
+/*
+ * New posix calls
+ */
+
+#if TARGET_ABI_BITS == 32
+static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+{
+#ifdef TARGET_BIG_ENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+#else
+    return ((uint64_t)word1 << 32) | word0;
+#endif
+}
+#else /* TARGET_ABI_BITS == 32 */
+static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
+{
+    return word0;
+}
+#endif /* TARGET_ABI_BITS != 32 */
+
+/* posix_fallocate(2) */
+static inline abi_long do_freebsd_posix_fallocate(abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+
+#if TARGET_ABI_BITS == 32
+    return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
+        target_offset64(arg5, arg6)));
+#else
+    return get_errno(posix_fallocate(arg1, arg2, arg3));
+#endif
+}
+
+/* posix_openpt(2) */
+static inline abi_long do_freebsd_posix_openpt(abi_long flags)
+{
+
+    return get_errno(posix_openpt(flags));
+}
+
+/*
+ * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
+ * static version, but to dynamically link we have to use the sys version.
+ */
+int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
+    const char *);
+
+/* shm_open2(2) */
+static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
+    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+{
+    int ret;
+    void *uname, *upath;
+
+    if (pathptr == (uintptr_t)SHM_ANON) {
+        upath = SHM_ANON;
+    } else {
+        upath = lock_user_string(pathptr);
+        if (upath == NULL) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    uname = NULL;
+    if (nameptr != 0) {
+        uname = lock_user_string(nameptr);
+        if (uname == NULL) {
+            unlock_user(upath, pathptr, 0);
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(__sys_shm_open2(upath,
+                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
+                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+
+    if (upath != SHM_ANON) {
+        unlock_user(upath, pathptr, 0);
+    }
+    if (uname != NULL) {
+        unlock_user(uname, nameptr, 0);
+    }
+    return ret;
+}
+
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+
+#if defined(CONFIG_GETRANDOM)
+static inline abi_long do_freebsd_getrandom(abi_ulong buf, abi_ulong buflen,
+        abi_ulong flags)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, buf, buflen, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getrandom(p, buflen, flags));
+    unlock_user(p, buf, ret);
+
+    return ret;
+}
+#endif
+
+static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
+    abi_ulong value, abi_long len)
+{
+    abi_long ret;
+    void *gname = NULL;         /* unlocked in cases where set */
+    void *gvalue = NULL;        /* unlocked in cases where set */
+
+    ret = -TARGET_EINVAL;
+    switch (action) {
+    case KENV_GET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        gvalue = lock_user(VERIFY_WRITE, value, len, 0);
+        if (gvalue == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        ret = get_errno(kenv(action, gname, gvalue, len));
+        if (ret > 0) {
+            len = ret;
+        } else {
+            len = 0;
+        }
+        break;
+    case KENV_SET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        gvalue = lock_user(VERIFY_READ, value, len, 1);
+        if (gvalue == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        ret = get_errno(kenv(action, gname, gvalue, len));
+        unlock_user(gvalue, value, 0);
+        gvalue = NULL;
+        break;
+    case KENV_UNSET:
+        gname = lock_user_string(name);
+        if (gname == NULL) {
+            ret = -TARGET_EFAULT;
+            break;
+        }
+        /* value and name ignored, per kenv(2) */
+        ret = get_errno(kenv(action, gname, NULL, 0));
+        break;
+    /* All three treated the same */
+    case KENV_DUMP:
+    case KENV_DUMP_LOADER:
+    case KENV_DUMP_STATIC:
+        /* value == NULL -> just return length */
+        if (value != 0) {
+            gvalue = lock_user(VERIFY_WRITE, value, len, 0);
+            if (gvalue == NULL) {
+                ret = -TARGET_EFAULT;
+                break;
+            }
+        }
+        /* name is ignored, per kenv(2) */
+        ret = get_errno(kenv(action, NULL, gvalue, len));
+        if (ret > 0) {
+            len = ret;
+        } else {
+            len = 0;
+        }
+        break;
+    default:
+        ret = -TARGET_EINVAL;
+        break;
+    }
+
+    /* Unmap everything mapped */
+    if (gvalue != NULL) {
+        unlock_user(gvalue, value, len);
+    }
+    if (gname != NULL) {
+        unlock_user(gname, name, 0);
+    }
+
+    return ret;
+}
 
 #endif /* OS_MISC_H */

-- 
2.52.0



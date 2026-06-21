Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FC6CDB470
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hk-0003FM-7m; Sun, 21 Jun 2026 00:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hd-0003Bb-AA
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:37 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hb-0005Pc-0z
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:36 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6a0e3a9c3a1so585044eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015754; x=1782620554;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fgR9FqPxblaEbcpvXd6GbMYejR07Cu4OXenM9QjNQvw=;
 b=c4JYSjoBu1HA+8REMnLdXwlRrjcQG9NbhFTlbXne5oM+DocFt4vBRMuKkqgVTcQl2c
 pATvhIoFS2k/nFFKDxWQCb2lUWu45Ya6l/d0Hb/J0pHGZ0tOtErEi6GYt0LQE+x6SsL/
 2nXf/PHhq2w60BFV8f5EC2E3FGz25mssCfSrSgbBXxwjWEsCW6wH8w/PeDFeLyHEMbdy
 0TazYEY4gHlXnht/2SlPuX+1sK0Dg5+Ztt5zf76tcD7CuPLBM4gxk+6hBqqRXxiS3/B6
 20xbHlWFasKC/fbSbjO8J90T1wAApbU1OMfJvDgg3I3WlD+Fe7OXlVk5Hk73Uu4eGKda
 +Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015754; x=1782620554;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fgR9FqPxblaEbcpvXd6GbMYejR07Cu4OXenM9QjNQvw=;
 b=JC0eKesDvLptrGRgyBq1JKaYGGxOPVA20n+Baiu059jZ2kBDy+12l1vZWjGBM1/umI
 1jBKQaf1lSloVYXXxvsBwNljd3XUumLtbk+1mwBN0RPqp4iFiRemX1Buc6x/nMI66H/i
 yW4QjqQ2R4akZt61nNt28jREVDejAjcPFoH7Bou0a3FudYUYqBt4wevtIEND1b06QAHT
 CC/C2HT2XPZZ3bsxp8y4c8dJSO2HN0Wm9e+dkKn+CZyZwIxvNDXHTmaE0/zIghFf8blC
 2XMBjwDmewPlNF5WohRuQllXK2a22OehpoZf8iwyYLke+ySXRdCgY93Ph36avvM2M7hk
 r+kw==
X-Gm-Message-State: AOJu0Yxf4MjlaQ0uUEzxVx0Rt1JhO+Aoj3ruH6OTpnwzxsxdZoSsyNTK
 45i2ROVGlm33b3nCeq2Wav6XGlZiXcItbDLNdpKbY40Msy96BosyDj/jdrQzpYdczfU=
X-Gm-Gg: AfdE7ckVAkckduAaJbrpznA26Xs8pV6NTcltgYkiH0Dh//DcEcFGhI0pv8FSEX1BQHX
 93XXB+zq9nV71hf/uW0cDstTgAG/auBe2mZiCK8AN+6Ft8eYTnAYBcAojodK8A1OA03cgEkbq+8
 OWvpwxZo32RNz+Nno2MdDDYHLo3NFu4HNjNWf/siOYUtRYZ+HfUiUObL0+n+TdJSDxI6SsfW02y
 ubreWRUt88OwxWngsK2A1j3fa+2AGfxTAq/Y6y36H6TfyEzCfrs6rK33EvUw5FOl32SH3cqajRt
 N4p5eMN9ZsMsayyYQxhaUpdOK1qwbKkXfYmhHsM9qSLCApcMm6aQYpgO9Wicwl5U7C5EM1c4A3/
 tnJEZq1ioyHdBKV4VQdl/sZXuyKZvcOqefeaYATbESGQJHaNu5rMDZDASJeVMqrEZZo2851bgF1
 8=
X-Received: by 2002:a05:6820:150f:b0:69e:41bf:fdc1 with SMTP id
 006d021491bc7-6a0d887e3d7mr8708991eaf.19.1782015753866; 
 Sat, 20 Jun 2026 21:22:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:23 -0600
Subject: [PATCH v3 36/40] bsd-user: Add scheduler and cpuset functions to
 os-misc.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-36-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10894; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=XqNZN2WsIzF97DyTlAXvg4woiy38ebLtVxbk1rVC1bs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aBftezF+WJKpJuLCxGCzJ6lQScz93RjozYM
 6IN/ONztwmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 APOrEACgswzrvVIdi0PzydHKaAA6kI88bGE8GHnMxqZMUhJw15qvNRtI8HFgM8fKm0kqb70lEKH
 WRpsB6bDsV4i1zTPKThNz2s6kmSHZnrBKm4fefA3gctsj1vMj+kgRfXPCx9qv9Aj3flKMdfQPfq
 xUDr5ery6KFJEnqTy90kygbXiZ+DIC6SFiYPmIeKxTYYv2QfCdKpiONr5l49dw8KSB7Hkc/PtCu
 YVxI7v8imeILOzqz2idTvdSwnz+Z3i4MxEIzIv+LEYliBysy9WuEJ1+OwHUVm5SEouEbCVWKV8M
 cUvgu+vnnQZDSVqa3UK6AKtxitnnfMdP99C7aGaJt2InT/YHQDv4KpD8dMQCE+m5GZgn1dn6xhs
 fymqiM2fJt8XMMy2guW8rPzJ5xgGDDfXd1AxdIZAe38ggvN0kR+pSd7HnbWo0btDtSxuGYYs7tO
 hKPGFbbExQq7aECzV7T4phpqn2O95GHniPPjrhRrSLVk0WFa9fg6C+Q2BMnaRzMKA/UCmh5CLO+
 HyyIUcK8BitTw0DNgnLOP2PO783w3NQyBaR83fP7tznUQxKc5inbW6WoA/pqHiE79/O0aQdj1mA
 T8dMuWKPxW+id/Fa25pNJWGf2TEWSW9+iyKgzAAlfhejIonpff7tWrJH1iN7LVN+4/LJbYzHbLF
 qi1PGtRECVJe8Mw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc36.google.com
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

Expand os-misc.h with scheduler functions (sched_setparam,
sched_getparam, sched_setscheduler, sched_getscheduler,
sched_rr_get_interval) and CPU affinity functions (cpuset,
cpuset_setid, cpuset_getid, cpuset_getaffinity, cpuset_setaffinity).
Also add sched_yield, sched_get_priority_min, and
sched_get_priority_max to bsd-proc.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-proc.h        |  18 +++
 bsd-user/freebsd/os-misc.h | 284 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 252 insertions(+), 50 deletions(-)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 7efc5b4c92..b9973dbedf 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -400,4 +400,22 @@ static inline abi_long do_bsd_setpriority(abi_long which, abi_long who,
     return get_errno(setpriority(which, who, prio));
 }
 
+/* sched_yield(2) */
+static inline abi_long do_bsd_sched_yield(void)
+{
+    return get_errno(sched_yield());
+}
+
+/* sched_get_priority_min(2) */
+static inline abi_long do_bsd_sched_get_priority_min(int policy)
+{
+    return get_errno(sched_get_priority_min(policy));
+}
+
+/* sched_get_priority_max(2) */
+static inline abi_long do_bsd_sched_get_priority_max(int policy)
+{
+    return get_errno(sched_get_priority_max(policy));
+}
+
 #endif /* !BSD_PROC_H */
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index d9979b2a8b..eea6371163 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -11,76 +11,260 @@
 #include <sys/cpuset.h>
 #include <sys/random.h>
 #include <sched.h>
+#include <kenv.h>
 
-/*
- * shm_open2 isn't exported, but the __sys_ alias is. We can use either for the
- * static version, but to dynamically link we have to use the sys version.
- */
-int __sys_shm_open2(const char *path, int flags, mode_t mode, int shmflags,
-    const char *);
-
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
-/* shm_open2(2) */
-static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
-    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
+/* sched_setparam(2) */
+static inline abi_long do_freebsd_sched_setparam(pid_t pid,
+        abi_ulong target_sp_addr)
 {
-    int ret;
-    void *uname, *upath;
+    abi_long ret;
+    struct sched_param host_sp;
 
-    if (pathptr == (uintptr_t)SHM_ANON) {
-        upath = SHM_ANON;
-    } else {
-        upath = lock_user_string(pathptr);
-        if (upath == NULL) {
-            return -TARGET_EFAULT;
-        }
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setparam(pid, &host_sp));
     }
+    return ret;
+}
 
-    uname = NULL;
-    if (nameptr != 0) {
-        uname = lock_user_string(nameptr);
-        if (uname == NULL) {
-            unlock_user(upath, pathptr, 0);
-            return -TARGET_EFAULT;
-        }
+/* sched_get_param(2) */
+static inline abi_long do_freebsd_sched_getparam(pid_t pid,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
+
+    ret = get_errno(sched_getparam(pid, &host_sp));
+    if (!is_error(ret)) {
+        ret = put_user_s32(host_sp.sched_priority, target_sp_addr);
     }
-    ret = get_errno(__sys_shm_open2(upath,
-                target_to_host_bitmask(flags, fcntl_flags_tbl), mode,
-                target_to_host_bitmask(shmflags, shmflag_flags_tbl), uname));
+    return ret;
+}
+
+/* sched_setscheduler(2) */
+static inline abi_long do_freebsd_sched_setscheduler(pid_t pid, int policy,
+        abi_ulong target_sp_addr)
+{
+    abi_long ret;
+    struct sched_param host_sp;
 
-    if (upath != SHM_ANON) {
-        unlock_user(upath, pathptr, 0);
+    ret = get_user_s32(host_sp.sched_priority, target_sp_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(sched_setscheduler(pid, policy, &host_sp));
     }
-    if (uname != NULL) {
-        unlock_user(uname, nameptr, 0);
+    return ret;
+}
+
+/* sched_getscheduler(2) */
+static inline abi_long do_freebsd_sched_getscheduler(pid_t pid)
+{
+
+    return get_errno(sched_getscheduler(pid));
+}
+
+/* sched_rr_get_interval(2) */
+static inline abi_long do_freebsd_sched_rr_get_interval(pid_t pid,
+        abi_ulong target_ts_addr)
+{
+    abi_long ret;
+    struct timespec host_ts;
+
+    ret = get_errno(sched_rr_get_interval(pid, &host_ts));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_timespec(target_ts_addr, &host_ts);
     }
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300048 */
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
-/* shm_rename(2) */
-static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
-        abi_ulong flags)
+/* cpuset(2) */
+static inline abi_long do_freebsd_cpuset(abi_ulong target_cpuid)
 {
-    int ret;
-    void *ufrom, *uto;
+    abi_long ret;
+    cpusetid_t setid;
+
+    ret = get_errno(cpuset(&setid));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return put_user_s32(setid, target_cpuid);
+}
+
+#define target_to_host_cpuset_which(hp, t) do { \
+    (*hp) = t;                               \
+} while (0)
 
-    ufrom = lock_user_string(fromptr);
-    if (ufrom == NULL) {
+#define target_to_host_cpuset_level(hp, t) do { \
+    (*hp) = t;                               \
+} while (0)
+
+/* cpuset_setid(2) */
+static inline abi_long do_freebsd_cpuset_setid(CPUArchState *env, abi_long arg1,
+        abi_ulong arg2, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5)
+{
+    id_t id;    /* 64-bit value */
+    cpusetid_t setid;
+    cpuwhich_t which;
+
+    target_to_host_cpuset_which(&which, arg1);
+#if TARGET_ABI_BITS == 32
+    /* See if we need to align the register pairs */
+    if (regpairs_aligned(env)) {
+        id = target_arg64(arg3, arg4);
+        setid = arg5;
+    } else {
+        id = target_arg64(arg2, arg3);
+        setid = arg4;
+    }
+#else
+    id = arg2;
+    setid = arg3;
+#endif
+    return get_errno(cpuset_setid(which, id, setid));
+}
+
+/* cpuset_getid(2) */
+static inline abi_long do_freebsd_cpuset_getid(abi_long arg1, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5)
+{
+    abi_long ret;
+    id_t id;    /* 64-bit value */
+    cpusetid_t setid;
+    cpuwhich_t which;
+    cpulevel_t level;
+    abi_ulong target_setid;
+
+    target_to_host_cpuset_which(&which, arg1);
+    target_to_host_cpuset_level(&level, arg2);
+#if TARGET_ABI_BITS == 32
+    id = target_arg64(arg3, arg4);
+    target_setid = arg5;
+#else
+    id = arg3;
+    target_setid = arg4;
+#endif
+    ret = get_errno(cpuset_getid(level, which, id, &setid));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return put_user_s32(setid, target_setid);
+}
+
+static abi_long copy_from_user_cpuset_mask(cpuset_t *mask,
+                                           abi_ulong target_mask_addr)
+{
+    int i, j, k;
+    abi_ulong b, *target_mask;
+
+    target_mask = lock_user(VERIFY_READ, target_mask_addr,
+                            CPU_SETSIZE / 8, 1);
+    if (target_mask == NULL) {
         return -TARGET_EFAULT;
     }
-    uto = lock_user_string(toptr);
-    if (uto == NULL) {
-        unlock_user(ufrom, fromptr, 0);
+    CPU_ZERO(mask);
+    k = 0;
+    for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+        __get_user(b, &target_mask[i]);
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            if ((b >> j) & 1) {
+                CPU_SET(k, mask);
+            }
+            k++;
+        }
+    }
+    unlock_user(target_mask, target_mask_addr, 0);
+
+    return 0;
+}
+
+static abi_long copy_to_user_cpuset_mask(abi_ulong target_mask_addr,
+        cpuset_t *mask)
+{
+    int i, j, k;
+    abi_ulong b, *target_mask;
+
+    target_mask = lock_user(VERIFY_WRITE, target_mask_addr,
+                            CPU_SETSIZE / 8, 0);
+    if (target_mask == NULL) {
         return -TARGET_EFAULT;
     }
-    ret = get_errno(shm_rename(ufrom, uto, flags));
-    unlock_user(ufrom, fromptr, 0);
-    unlock_user(uto, toptr, 0);
+    k = 0;
+    for (i = 0; i < ((CPU_SETSIZE / 8) / sizeof(abi_ulong)); i++) {
+        b = 0;
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            b |= ((CPU_ISSET(k, mask) != 0) << j);
+            k++;
+        }
+        __put_user(b, &target_mask[i]);
+    }
+    unlock_user(target_mask, target_mask_addr, (CPU_SETSIZE / 8));
+
+    return 0;
+}
+
+/* cpuset_getaffinity(2) */
+/* cpuset_getaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, cpuset_t *); */
+static inline abi_long do_freebsd_cpuset_getaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+    cpuset_t mask;
+    abi_long ret;
+    id_t id;    /* 64-bit */
+    abi_ulong setsize, target_mask;
+
+#if TARGET_ABI_BITS == 32
+    id = (id_t)target_arg64(arg3, arg4);
+    setsize = arg5;
+    target_mask = arg6;
+#else
+    id = (id_t)arg3;
+    setsize = arg4;
+    target_mask = arg5;
+#endif
+
+    ret = get_errno(cpuset_getaffinity(level, which, id, setsize, &mask));
+    if (ret == 0) {
+        ret = copy_to_user_cpuset_mask(target_mask, &mask);
+    }
 
     return ret;
 }
-#endif /* __FreeBSD_version >= 1300049 */
+
+/* cpuset_setaffinity(2) */
+/* cpuset_setaffinity(cpulevel_t, cpuwhich_t, id_t, size_t, const cpuset_t *);*/
+static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
+        cpuwhich_t which, abi_ulong arg3, abi_ulong arg4, abi_ulong arg5,
+        abi_ulong arg6)
+{
+    cpuset_t mask;
+    abi_long ret;
+    id_t id; /* 64-bit */
+    abi_ulong setsize, target_mask;
+
+#if TARGET_ABI_BITS == 32
+    id = (id_t)target_arg64(arg3, arg4);
+    setsize = arg5;
+    target_mask = arg6;
+#else
+    id = (id_t)arg3;
+    setsize = arg4;
+    target_mask = arg5;
+#endif
+
+    ret = copy_from_user_cpuset_mask(&mask, target_mask);
+    if (ret == 0) {
+        ret = get_errno(cpuset_setaffinity(level, which, id, setsize,
+                                           &mask));
+    }
+
+    return ret;
+}
+
+/*
+ * Pretend there are no modules loaded into the kernel. Don't allow loading or
+ * unloading of modules. This works well for tests, and little else seems to
+ * care. Will reevaluate if examples are found that do matter.
+ */
+
 
 #endif /* OS_MISC_H */

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09943CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vt-0000mL-3i; Mon, 18 May 2026 17:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vq-0000hO-3q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:34 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vn-0000lR-8P
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:33 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4824176bbbeso839779b6e.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139710; x=1779744510;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IjtYKiTslteh1AqUlT8SGFsxQA2/06AYOpihNDH2hQg=;
 b=IbswSeUmnpg3CkEJ+OdDDJPRM3fEeGcudxSnHAzsCwq9KZir0A0xtfWwYmhrqte8li
 pQOwtVBGtanE+b8Csx4PxHYWauo/HRj89vZrVfiIVMnvM0fqKfKm8o7yMNCCycALY8xD
 ONl/epAp3YrWbjo/zxVoHzxJc39PqX9dby8r1pVswHumIdKkAvOommsKtRHxKoFVflF5
 8+O9q/NKHXzVWWUaDCepNh8Ql0FO0zXOMHXHv2RR2GnbeERQHboGa2/Udw+tXh/B7xtl
 ZoQQydXL93C6FQ97hMOCcC814hsnPrprNvFBqFXfU/Bse5sid1qg+qB+fcYgQSuD4+ux
 gcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139710; x=1779744510;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IjtYKiTslteh1AqUlT8SGFsxQA2/06AYOpihNDH2hQg=;
 b=HwDhpUNE3yDcM/asHfGzwvhr3hvsx4HVX1wPAEOuZ2aWQs/UKJMTurpiF6hX7RE/GE
 yIClsXviyyb2pTJaXZe7crgcOhUFVa1Zm2h84ILQWpZtS3BJ7wGsCA/8ry7PM5C+Kthn
 LCa1Zu8eKspy9rHNn49MqU4kV2Sul8IYUCHKf5h4X36yurend1kxj/Mj9SBHECOwfF76
 FTIMemy1CNiiQon4f/SxBi5SrJAIfhY5juCwU79QyDC4GrAvwSUZTSe5snWtSkmR2AgR
 1tvaSw553plS+SKWQQiX6YsRkXcmgsV4eSocz0UyoEBM+gU7ywK+smw5NnxIPQ78P56U
 t7ew==
X-Gm-Message-State: AOJu0YzDdNYXFRSYAhU1byUb8rNfCySfxKY2J67XUw7Ybm0JqxbgyKlF
 8K2m9mA2m/f1rpECgsDusJjRs3q5eCNm1oybCL2YTD47BMtR5iVFXwwEaoLqsNhEFZEz79SofZU
 uqhzXjFo=
X-Gm-Gg: Acq92OGKEsnfNa+SC5H5V08sHV790Ro+xwaL5g0DL91n7otLVQcmJn9d4xcarhXtVV7
 77RpiY7KRJOxIHDGha9RcUfJqsSGHRinaWtsX0CeGX7W6uToOM0iGOKKg48FjKo7m8zNO3UpEeh
 6D+FvnvrqYrADwVAZWVyM0nXlLmxlevSkoTnWnrS37QiLA7JP29uivr/EZ3f5Ii1iau0WoJ1qsM
 zTewkrSzpzJNtacZMs8esfymMU4l4InpQYZOUwH1Rh8No5BYpisYlTsL8aeO2W6IGhzp0Gz59IY
 xh1f3RoJVdqbsjr/stpQVh5xuawc0DxiBH0y4LMRN2v+CxbUg23hLYgyAYdMRnUMTFqDrxd2NjY
 C6s/g8vUw02fWqcquvvcScM1fHlxZ3rE9MEC+woHsdDUuRNQK02z5pZRwbeD4mjwWBQ+1L+iPuE
 9p95lAZ7EPKg==
X-Received: by 2002:a05:6808:2f0e:b0:482:4dbd:4fe8 with SMTP id
 5614622812f47-482e58dbf6emr10815574b6e.46.1779139709916; 
 Mon, 18 May 2026 14:28:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:55 -0600
Subject: [PATCH v2 37/37] bsd-user: Add scheduler, cpuset, kmod, and misc
 syscall dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-37-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23108; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=75INCCR67WngC+LgfJZw3jtrQDBBgN+N/9/tttTIEPk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJ1iac9mh4GX3RFCxyyaaF6+SRdGOX1G7Ic
 5PAf3WAOcyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 ANDNEADZMaUAl1WEgt05iiuBzGwHIxrumTR+ijRzbGCk9x+YPBXXnos28lfwIpVvFHlfdubQdA2
 1pykTuHeiN3E9jWopaLeqmTdz+wmR0lh3de9tu7OhLKVz2SBvxvnEoxxQjkurzx4FjYGsUO52Bh
 Qk9mzW83lJEdsIcYoTGkTsSjdEE9EK8lVeh5XIyVrKJ34CXjtADMlr5qQy4PRP4q9Csdx5c38be
 RcXXK7MFFfT820jKUVxNYMIPCDxGZj9iUazyvJZHuaB8Hsjf21/OV6l00ZlLmJd66S6IprwIzxb
 +liytqJC1+vvc0s7kXve1WMkHNBaMo7uwxrKTqFoOcDtRzMphEW5Y7hUZSbt32xjIpLPofxFspY
 ZC/EEBtSl4loMSPfhotUw8QH6L0JS4tonE8ySKZ7gyt1N3BS92h4SOPXzi9wT0ckkfz6pUaSjU0
 I/hVen7khAkEhDy6mTA3BmmMfmPfHJc4AfaTBTOKBpoX6dE0CGV9Hegw6MZibx5zPWlJ2aJ5T07
 xmFhb2JwWYrMqDFbTCrWIpaZva9XxVcBu8QkwsC7wWCU/2rsKDP8+QsY8qGKpD76vYtNlesME3g
 9bjyvzXLyYXdtpg5gFQoD2C4kHwk2Apu6TWY5NzKdD/fYHMrkFdiFyWbEgG95t1oXnAMDD7C5d6
 6aioZgzxcEY3jQA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22b.google.com
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

Wire up remaining system calls: sched_setparam, sched_getparam,
sched_setscheduler, sched_getscheduler, sched_get_priority_max,
sched_get_priority_min, sched_rr_get_interval, sched_yield,
cpuset, cpuset_setid, cpuset_getid, cpuset_getaffinity,
cpuset_setaffinity, modfnext, modfind, kldload, kldunload,
kldunloadf, kldfind, kldnext, kldstat, kldfirstmod, kldsym,
posix_fallocate, posix_openpt, getrandom, kenv, cap_rights_limit,
cap_ioctls_limit, cap_fcntls_limit, cap_enter, syscall, and
__syscall.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-proc.h           |   2 +-
 bsd-user/freebsd/os-syscall.c | 522 ++++++++++++++++++++++++++----------------
 2 files changed, 329 insertions(+), 195 deletions(-)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index b9973dbedf..70a72a6a94 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -418,4 +418,4 @@ static inline abi_long do_bsd_sched_get_priority_max(int policy)
     return get_errno(sched_get_priority_max(policy));
 }
 
-#endif /* !BSD_PROC_H */
+#endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7825e042b0..c8f88efc6f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -532,6 +532,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_closefrom(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
+        ret = do_freebsd_close_range(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_revoke: /* revoke(2) */
         ret = do_bsd_revoke(arg1);
         break;
@@ -696,6 +700,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_chflags(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
+        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
+        break;
+
     case TARGET_FREEBSD_NR_lchflags: /* lchflags(2) */
         ret = do_bsd_lchflags(arg1, arg2);
         break;
@@ -740,6 +748,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_poll(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_ppoll: /* ppoll(2) */
+        ret = do_freebsd_ppoll(env, arg1, arg2, arg3, arg4);
+        break;
+
     case TARGET_FREEBSD_NR_lseek: /* lseek(2) */
         ret = do_bsd_lseek(env, arg1, arg2, arg3, arg4, arg5);
         break;
@@ -766,14 +778,6 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_swapoff(arg1, arg2);
         break;
 
-    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
-        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
-        ret = do_freebsd_close_range(arg1, arg2, arg3);
-        break;
-
     case TARGET_FREEBSD_NR___realpathat:
         /* __realpathat(2) (XXX no realpathat()) */
         ret = do_freebsd_realpathat(arg1, arg2, arg3, arg4, arg5);
@@ -787,125 +791,12 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd___specialfd(arg1, arg2, arg3);
         break;
 
-        /*
-         * ioctl(2)
-         */
-    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
-        ret = do_bsd_ioctl(arg1, arg2, arg3);
-        break;
-
-        /*
-         * stat system calls
-         */
-    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
-        ret = do_freebsd11_stat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
-        ret = do_freebsd11_lstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
-        ret = do_freebsd11_fstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
-        ret = do_freebsd_fstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
-        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
-        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
-        ret = do_freebsd11_nstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
-        ret = do_freebsd11_nfstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
-        ret = do_freebsd11_nlstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
-        ret = do_freebsd_getfh(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
-        ret = do_freebsd_lgetfh(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
-        ret = do_freebsd_fhopen(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
-        ret = do_freebsd11_fhstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
-        ret = do_freebsd_fhstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
-        ret = do_freebsd11_fhstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
-        ret = do_freebsd_fhstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
-        ret = do_freebsd11_statfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
-        ret = do_freebsd_statfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
-        ret = do_freebsd11_fstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
-        ret = do_freebsd_fstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
-        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
-        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
-        ret = do_freebsd11_getdents(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
-        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
-        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
-        break;
-    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
-        ret = do_freebsd_fcntl(arg1, arg2, arg3);
-        break;
-
         /*
          * Memory management system calls.
          */
     case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
         ret = do_bsd_mmap(env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
-                          arg8);
+           arg8);
         break;
 
     case TARGET_FREEBSD_NR_munmap: /* munmap(2) */
@@ -952,17 +843,13 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_shm_open(arg1, arg2, arg3);
         break;
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
         break;
-#endif
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
     case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
         ret = do_freebsd_shm_rename(arg1, arg2, arg3);
         break;
-#endif
 
     case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
         ret = do_bsd_shm_unlink(arg1);
@@ -984,68 +871,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
-        /*
-         * System V Semaphores
-         */
-    case TARGET_FREEBSD_NR_semget: /* semget(2) */
-        ret = do_bsd_semget(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_semop: /* semop(2) */
-        ret = do_bsd_semop(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
-        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
-        break;
-    }
-
-        /*
-         * System V Messages
-         */
-    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
-        ret = do_bsd_msgctl(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
-        ret = do_bsd_msgget(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
-        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
-        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
-        break;
-
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;
 
-        /*
-         * Misc
-         */
-    case TARGET_FREEBSD_NR_break:
-        ret = do_obreak(arg1);
-        break;
-
-    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
-        ret = do_bsd_quotactl(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
-        ret = do_bsd_reboot(arg1);
-        break;
-
-    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
-        ret = do_bsd_uuidgen(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
-        ret = do_bsd_getdtablesize();
-        break;
-
         /*
          * time related system calls.
          */
@@ -1133,10 +962,6 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_pselect(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
-    case TARGET_FREEBSD_NR_ppoll: /* ppoll(2) */
-        ret = do_freebsd_ppoll(env, arg1, arg2, arg3, arg4);
-        break;
-
     case TARGET_FREEBSD_NR_kqueue: /* kqueue(2) */
         ret = do_freebsd_kqueue();
         break;
@@ -1350,6 +1175,119 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
         break;
 
+        /*
+         * ioctl(2)
+         */
+    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
+        ret = do_bsd_ioctl(arg1, arg2, arg3);
+        break;
+
+        /*
+         * stat system calls
+         */
+    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
+        ret = do_freebsd11_stat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
+        ret = do_freebsd11_lstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
+        ret = do_freebsd11_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
+        ret = do_freebsd_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
+        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
+        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
+        ret = do_freebsd11_nstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
+        ret = do_freebsd11_nfstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
+        ret = do_freebsd11_nlstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
+        ret = do_freebsd_getfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
+        ret = do_freebsd_lgetfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
+        ret = do_freebsd_fhopen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
+        ret = do_freebsd11_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
+        ret = do_freebsd_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd11_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
+        ret = do_freebsd11_getdents(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
+        ret = do_freebsd_fcntl(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
@@ -1365,19 +1303,25 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_syscall: /* syscall(2) */
+    case TARGET_FREEBSD_NR___syscall: /* __syscall(2) */
+        ret = do_freebsd_syscall(env, arg1 & 0xffff, arg2, arg3, arg4,
+                arg5, arg6, arg7, arg8, 0);
+        break;
+
         /*
-         * extended attributes and ACL system calls
+         * extended attributes system calls
          */
     case TARGET_FREEBSD_NR_extattrctl: /* extattrctl() */
         ret = do_freebsd_extattrctl(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_set_file: /* extattr_set_file(2) */
-        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_set_file(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_get_file: /* extattr_get_file(2) */
-        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_get_file(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_delete_file: /* extattr_delete_file(2) */
@@ -1397,11 +1341,11 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_extattr_get_link: /* extattr_get_link(2) */
-        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_get_link(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_set_link: /* extattr_set_link(2) */
-        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg4);
+        ret = do_freebsd_extattr_set_link(arg1, arg2, arg3, arg4, arg5);
         break;
 
     case TARGET_FREEBSD_NR_extattr_delete_link: /* extattr_delete_link(2) */
@@ -1413,7 +1357,7 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         break;
 
     case TARGET_FREEBSD_NR_extattr_list_file: /* extattr_list_file(2) */
-        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3,  arg4);
+        ret = do_freebsd_extattr_list_file(arg1, arg2, arg3, arg4);
         break;
 
     case TARGET_FREEBSD_NR_extattr_list_link: /* extattr_list_link(2) */
@@ -1468,6 +1412,196 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__acl_set_link(arg1, arg2, arg3);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+        /*
+         * FreeBSD scheduler control
+         */
+    case TARGET_FREEBSD_NR_sched_setparam: /* sched_setparam(2) */
+        ret = do_freebsd_sched_setparam(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_getparam: /* sched_getparam(2) */
+        ret = do_freebsd_sched_getparam(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_setscheduler: /* sched_setscheduler(2) */
+        ret = do_freebsd_sched_setscheduler(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_getscheduler: /* sched_getscheduler(2) */
+        ret = do_freebsd_sched_getscheduler(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_get_priority_max: /* sched_get_priority_max(2)*/
+        ret = do_bsd_sched_get_priority_max(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_get_priority_min: /* sched_get_priority_min(2)*/
+        ret = do_bsd_sched_get_priority_min(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_rr_get_interval: /* sched_rr_get_interval(2) */
+        ret = do_freebsd_sched_rr_get_interval(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_yield: /* sched_yield(2)*/
+        ret = do_bsd_sched_yield();
+        break;
+
+
+        /*
+         * FreeBSD CPU affinity sets management
+         */
+    case TARGET_FREEBSD_NR_cpuset: /* cpuset(2) */
+        ret = do_freebsd_cpuset(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_setid: /* cpuset_setid(2) */
+        ret = do_freebsd_cpuset_setid(env, arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_getid: /* cpuset_getid(2) */
+        ret = do_freebsd_cpuset_getid(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_getaffinity: /* cpuset_getaffinity(2) */
+        ret = do_freebsd_cpuset_getaffinity(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_setaffinity: /* cpuset_setaffinity(2) */
+        ret = do_freebsd_cpuset_setaffinity(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+        /*
+         * FreeBSD kernel module
+         */
+    case TARGET_FREEBSD_NR_modfnext: /* modfnext(2) */
+        ret = do_freebsd_modfnext(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_modfind: /* modfind(2) */
+        ret = do_freebsd_modfind(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldload: /* kldload(2) */
+        ret = do_freebsd_kldload(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldunload: /* kldunload(2) */
+        ret = do_freebsd_kldunload(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldunloadf: /* kldunloadf(2) */
+        ret = do_freebsd_kldunloadf(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kldfind: /* kldfind(2) */
+        ret = do_freebsd_kldfind(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldnext: /* kldnext(2) */
+        ret = do_freebsd_kldnext(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldstat: /* kldstat(2) */
+        ret = do_freebsd_kldstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kldfirstmod: /* kldfirstmod(2) */
+        ret = do_freebsd_kldfirstmod(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldsym: /* kldsym(2) */
+        ret = do_freebsd_kldsym(arg1, arg2, arg3);
+        break;
+
+        /*
+         * FreeBSD additional posix support
+         */
+    case TARGET_FREEBSD_NR_posix_fallocate: /* posix_fallocate(2) */
+        ret = do_freebsd_posix_fallocate(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_posix_openpt: /* posix_openpt(2) */
+        ret = do_freebsd_posix_openpt(arg1);
+        break;
+
+        /*
+         * Misc
+         */
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
+    case TARGET_FREEBSD_NR_break:
+        ret = do_obreak(arg1);
+        break;
+
+#if defined(CONFIG_GETRANDOM)
+    case TARGET_FREEBSD_NR_getrandom:
+        ret = do_freebsd_getrandom(arg1, arg2, arg3);
+        break;
+#endif
+    case TARGET_FREEBSD_NR_kenv:
+        ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
+        break;
+
+    /* XXX */
+    case TARGET_FREEBSD_NR_cap_rights_limit:
+    case TARGET_FREEBSD_NR_cap_ioctls_limit:
+    case TARGET_FREEBSD_NR_cap_fcntls_limit:
+        ret = -TARGET_EINVAL;
+        break;
+    case TARGET_FREEBSD_NR_cap_enter:
+        ret = 0;
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         ret = -TARGET_ENOSYS;

-- 
2.52.0



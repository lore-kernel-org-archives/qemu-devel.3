Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729D0C561E6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfE3-0004lS-OQ; Wed, 05 Aug 2026 13:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfDv-0004ep-Ax
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:16:11 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfDt-0006KB-K5
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:16:11 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8200b55dc47so17890947b3.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950168; x=1786554968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZxK2wYRYXP/raSMAV2obkROqgTG/P9VKDs+8YIBq+6k=;
 b=Hp9mgD4ME2iyezccWEzaTozOVcXWS+/uSlMEKg1D0IXEoPuRFOUPufDBHV+4BxacQO
 1IWfP3seaYZ56WfOnNgL5IzAw08cjHj9HumkCmO4rS4rjFXe7OrQe4ZoL5NORiwud9ML
 aVsP4QbYnTK9aiTM7LRpx/pGoikZS6cBiMHnRqrhiBnKxQUBxH2lPOQgbbZxo12lNnvg
 kG1yEnToutBicH5DJIKSMte8P8ZqzDIAz+fpu1t2anDk12yRtRzbIeUH94neYHhQccf8
 ONaE85u2kDb9GMNftvLvRgb1ZeFKVQLZINP16DqZGjBp1+9hgOy9uClhSvc7IMrYnjGw
 xBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950168; x=1786554968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZxK2wYRYXP/raSMAV2obkROqgTG/P9VKDs+8YIBq+6k=;
 b=gctRn+qARPBzn0V+is3GZF4S3LAQAik7Gv601iAMij/77yQpo4Zyz3nMS3pEBbfmVm
 Mui8R4MMauxAP7BND9qQ3bKjGKmXg6izw4Pf96pTbOewdKGveHFFOW+byL69cJDCze9d
 +USH6nikYWCwXHFoEQ83AbkFvwoLvrhN5FBXTuKq7nGDsoRV6D68KmuGvLbAmk9ZP3ry
 g+skxcoOx6sIPyVX6oDb3vQDSMXKT06BxNfDOZPT+HuwrPicjvL5MuOltrSmB310rMtr
 nwbHFoJSDH0LFs7vzEQdXzL1yeCTcSTyF56WjbY8l0HxRPD/AiXkeFlYpHhiD2c0SbUZ
 H3XQ==
X-Gm-Message-State: AOJu0Yxfwq9jCs/vQzC+XWBTSKf6+6k2YeoYNNEI3iQBqIp6l2PzFb+5
 e9H3fNsfuPTzAd3AILqW9JB3gnplTphI8wo1r+5O5A2ZMh5Pn0BttBzoVj4A7hZnEQA=
X-Gm-Gg: AR+sD13WWYPiDpTdpJ3Nt5XXb6NFrjWOuABisDfj5HFVOREOvl52K5lJ4SGj11A4PAq
 /7nD0S4nbODzpYOadpwRyAXWW82rxKGWKp38+cNhP8cEorgJ71Bbp8ojcWWYZrL/7CBiGXqUxuC
 5Z6lHWyiW/Qi+fo83BYJHheHU8HejSqwJcpiHGS4kW7fWE6L97PJwO908xy/s8VNtbZN7NVG8YZ
 el7SmDC2hfBwgpOpwkGJAbULszLZIa+KHLoyaNSyjiCDA1xaO2W95ZyGNWswUBw6m/CAFGioRPb
 TBVdyLCJNrJ3vEwiAG6DWpa4GivXs0q1zkCU9dl9DgQdi/JTTAgUqwzDNWWJMHoY4Hu2jWUBdAb
 L4oWwjw0oK4SI4TK9GeBMRtWdNqRZze7sr2lQqNipps1tuC273YuX3wu6FPtYFBSBgac0GRZ1nf
 oDFG24QUx23IDKFojUYUHKMgBi1ME3sPjz1UEV/XrfQ9Jexuu4x5gIji7hHKwl
X-Received: by 2002:a05:690c:6188:b0:81e:a471:e8b2 with SMTP id
 00721157ae682-8201f0c1830mr53462357b3.2.1785950168176; 
 Wed, 05 Aug 2026 10:16:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8210f9f94b1sm4320497b3.22.2026.08.05.10.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:16:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] linux-user: implement mount_setattr(2)
Date: Wed,  5 Aug 2026 13:16:05 -0400
Message-ID: <20260805171605.3119981-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

mount_setattr() was in the syscall tables but had no implementation, so
guests always got -ENOSYS. systemd uses it when setting up per-unit
credential mounts, which fails the affected units with EXIT_CREDENTIALS.

struct mount_attr is an extensible struct like open_how, so handle it the
same way openat2() does: reject sizes smaller than the ver0 struct and
require any unknown trailing bytes to be zero. All of its fields are
64-bit, and the MOUNT_ATTR_* and MS_* propagation values are identical on
every target, so only the byte order needs fixing up.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/strace.list    |  3 +++
 linux-user/syscall.c      | 44 +++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 13 ++++++++++++
 3 files changed, 60 insertions(+)

diff --git ./linux-user/strace.list ./linux-user/strace.list
index 25ace05187..e952f15d20 100644
--- ./linux-user/strace.list
+++ ./linux-user/strace.list
@@ -1737,3 +1737,6 @@
 #ifdef TARGET_NR_fspick
 { TARGET_NR_fspick, "fspick", "%s(%d,%s,%d)", NULL, NULL },
 #endif
+#ifdef TARGET_NR_mount_setattr
+{ TARGET_NR_mount_setattr, "mount_setattr", "%s(%d,%s,%d,%p,%d)", NULL, NULL },
+#endif
diff --git ./linux-user/syscall.c ./linux-user/syscall.c
index dc028686f4..cfa68dfbdb 100644
--- ./linux-user/syscall.c
+++ ./linux-user/syscall.c
@@ -9735,6 +9735,13 @@ _syscall5(int, sys_move_mount, int, __from_dfd, const char *, __from_pathname,
            int, __to_dfd, const char *, __to_pathname, unsigned int, flag)
 #endif
 
+#if defined(TARGET_NR_mount_setattr) && defined(__NR_mount_setattr)
+#define __NR_sys_mount_setattr __NR_mount_setattr
+_syscall5(int, sys_mount_setattr, int, dfd, const char *, path,
+          unsigned int, flags, struct mount_attr_ver0 *, uattr,
+          size_t, usize)
+#endif
+
 #if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
 #define __NR_sys_fsopen __NR_fsopen
 _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags);
@@ -14480,6 +14487,43 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
 #endif
 
+#if defined(TARGET_NR_mount_setattr) && defined(__NR_mount_setattr)
+    case TARGET_NR_mount_setattr:
+        {
+            struct mount_attr_ver0 attr = {};
+            abi_ulong usize = arg5;
+
+            if (usize < sizeof(struct target_mount_attr_ver0)) {
+                return -TARGET_EINVAL;
+            }
+            ret = copy_struct_from_user(&attr, sizeof(attr), arg4, usize);
+            if (ret) {
+                if (ret == -TARGET_E2BIG) {
+                    qemu_log_mask(LOG_UNIMP,
+                                  "Unimplemented mount_setattr mount_attr "
+                                  "size: " TARGET_ABI_FMT_lu "\n", usize);
+                }
+                return ret;
+            }
+            /*
+             * MOUNT_ATTR_* and the MS_* propagation flags have the same
+             * values on all targets, so only byte order needs fixing up.
+             */
+            attr.attr_set = tswap64(attr.attr_set);
+            attr.attr_clr = tswap64(attr.attr_clr);
+            attr.propagation = tswap64(attr.propagation);
+            attr.userns_fd = tswap64(attr.userns_fd);
+
+            p = lock_user_string(arg2);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(sys_mount_setattr(arg1, p, arg3, &attr,
+                                              sizeof(attr)));
+            unlock_user(p, arg2, 0);
+        }
+        return ret;
+#endif
 #if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
     case TARGET_NR_fsopen:
         {
diff --git ./linux-user/syscall_defs.h ./linux-user/syscall_defs.h
index e033c7db34..e28853c93b 100644
--- ./linux-user/syscall_defs.h
+++ ./linux-user/syscall_defs.h
@@ -2770,6 +2770,19 @@ struct target_open_how_ver0 {
     abi_ullong mode;
     abi_ullong resolve;
 };
+/* from kernel's include/uapi/linux/mount.h */
+struct mount_attr_ver0 {
+    uint64_t attr_set;
+    uint64_t attr_clr;
+    uint64_t propagation;
+    uint64_t userns_fd;
+};
+struct target_mount_attr_ver0 {
+    abi_ullong attr_set;
+    abi_ullong attr_clr;
+    abi_ullong propagation;
+    abi_ullong userns_fd;
+};
 #ifndef RESOLVE_NO_MAGICLINKS
 #define RESOLVE_NO_MAGICLINKS   0x02
 #endif
-- 
2.54.0



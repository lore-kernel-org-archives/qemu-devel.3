Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEF2CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxM-0001Wd-9y; Fri, 15 May 2026 17:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxK-0001UD-Sb
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:26 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxI-0002zE-UU
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso156174a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880023; x=1779484823;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MtMAJvJ9gtsHpg82pTb9T1Y8653dSSHM3WKLgtSNkEA=;
 b=QZIiOUwlWlgxtNvijDUOGUxZyu5iAW9wB+fAEZ7sdKGkLosxC9vHYR2jGbLV4ZlwBm
 Q7RV6T0J/KVvwlQLKUA0Xz/u+F+WmMJDwMA0ajnb1vaVaIJnlO4XUwmxP94yT4BDVaXY
 nHFpEt9qP9fyoYCoZqg4vMRYFyhtM4kmF4SujERL2w6BiEnnbPzZOM825+IdXVdOJVKo
 LSqV9K+Cj4aLF7ujLv44I0eX1fT1PrST9G4HEhEe87GZBgywGEK/VqqSqgy+ws7xtD93
 G8D2wI+NaYNbMu8n57Ayj6n4mrc0dWRFFgF6WV1zx1G6pMnUM0PdvtwqmxWHDvM9oD6t
 UUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880023; x=1779484823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MtMAJvJ9gtsHpg82pTb9T1Y8653dSSHM3WKLgtSNkEA=;
 b=Vbb/bmef8CNSoxEsXIA9kQIemctqMxZLJ+Skwh0snf3yXqbS53V7AeWGz0qQM/0N88
 KLSEZb0ED8WdrpwglG+tGoyIhMkQyfBUFK+EHUGDkIrKYhnRN1Ldy7OOhZzm1cYB0Un1
 Qc0v/ahwWBi7M+cMgiwzdQaS9Jd66W7HtzOC1Zp9NQ5hOIbMWsZLKsj+ucRW+lxHZPSl
 DZy7PNt4RokkW068s3CpGkBy8+BmS6bik1sBGQKqzErSJnY7xoIxdurTtGsDsdD341Rm
 cTo2mMCoe16mPuvzuZZwbeqBqsNWeo0qqFYF35xXvJ5uHNyDocDYKUjH8XHi3oRiy0gi
 jzXA==
X-Gm-Message-State: AOJu0Yy3PpdWfY1ugv99jw91Tz3ZdxV03AchkXZLcxGqxyW736Kj6zDL
 qZ6LiN1p+nIySwA7QpaiVDmSRdqNxkPjk5Tqg+nZlvLRPx7C1wzJ7JH9F4n86VicX+I=
X-Gm-Gg: Acq92OGHowKpAi3ME9P56yM2SB8nVL9RPh88AfDULS0iJscb/3RiyZR5ML3xdFoghz+
 KjqtIqrybuaX3TFVKdW9h8DbWO9zRxwUQa9upZ7qEpPBn7IMWaCQU2Zhy3jpvoMIFdrSn1C/Z8T
 /WHx+oUFNDUrueLgE+SRGRLm2/BKRmcfH93L/Dg54aFwrnB+IBaJIJ5NQYAFf+XVYbkUxo+m5x7
 HUHnOv3Ai3zwiDWQwONcOUNMCceZ7Zahazfx9Ys4iqhjPCK88uCDx1PbdlKoSi80BunXg9NSPBS
 NIiWHDRxCi80yVeJVTEOr0Yq2BrkotNGWyM8/YHGwvCPp+60AA/xw1cIcimzuNTKeraKRnqWcAf
 V7ocNUy5tafdkSWXThRr6saHL/9+pYjm5FOLM/UBljrYZEVnWK6XZzvB08pKhCsKCUkunYJh8I+
 zjltYXp1FLdA==
X-Received: by 2002:a05:6830:6408:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e4de65c157mr3604477a34.0.1778880022705; 
 Fri, 15 May 2026 14:20:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:19 -0600
Subject: [PATCH 20/66] bsd-user: Add kqueue and kevent functions to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-20-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8195; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Ow8+m+yEs12FhD/+xURX9PAkMetNt4xQX/CrgqE3TTo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jhcLmUqlu/FwWW6O8wrthtA0Osh/AgdZkw
 keu7U5WABaJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AP37D/9cDu4hwFs+3ghVRMA/JpDMJU3P4xoOXFmcGH6gtk3rljqEEqHPQgO8g1piwHaH4F29u+l
 T2zc/uzZRXYGu0ZcoFMmHTfM2NVi9r/qVimDD1hqy7Tga/n2Q/M272fHrrY6EkkZsbeTOYRTWlC
 iPoHjTS48BVkqog6RLvCG91/1ia9V5xguzm+HBMAGjBUE+RTSKas2qh9nB2MtaQhhQa9DhmIvnj
 AciONM+8Gqx/Jqe96RkBJ4QMiGEWzCwgafAAAATBh6HM9zkMVpyqvecEU1IKNRwyDyAiHMCbz4r
 2QfuSCKbhIKbiGQ/KxF1++VBBaHi/CbwgVrigGrweSEd/w8rceKpupEiR2wJTcg1qLHBy+wMr5a
 M84LWnXUrxa6V1yCrmJrOPsgrwIyuZbtaqy6XAba/y2s36HqgHsbZkgW3VnfUYIPMKvb8f1YeN7
 Kq00/jFrkVY8vnf1FbN3JV9L8oxsQN1H8XBCGxDcZQqmQiN2TFN5GwpT6VznWiQwE1RDis1Ua8s
 RU0bPRniwcMx01xjTyHVbfzxgRPNjlRkD97VIEtUByYuFav6h6b4EPCLh/gHITuicOGIGIsDCtJ
 CMtHgyALc8p9iwpzGYbQirmowKNJgdQwAUlQlmUZ5+Nbj1HcDI7MlkMrutbd8u8wrS/2jGZzWyy
 KUZtTXXSnokHKRg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

Add event notification system call shims: kqueue, freebsd11_kevent
(legacy 32-bit data field), and kevent (with 64-bit ext fields).

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 174 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 51f84c31a1..f724acdd0a 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -629,5 +629,179 @@ static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
 }
 
 /* kqueue(2) */
+static inline abi_long do_freebsd_kqueue(void)
+{
+
+    return get_errno(kqueue());
+}
+
+/* kevent(2) */
+/* XXX Maybe some day, consolidate these two... */
+static inline abi_long do_freebsd_freebsd11_kevent(abi_long arg1,
+    abi_ulong arg2, abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
+{
+    abi_long ret;
+    struct kevent *changelist = NULL, *eventlist = NULL;
+    struct target_freebsd11_kevent *target_changelist, *target_eventlist;
+    struct timespec ts;
+    int i;
+
+    if (arg3 != 0) {
+        target_changelist = lock_user(VERIFY_READ, arg2,
+                                      sizeof(*target_changelist) * arg3, 1);
+        if (target_changelist == NULL) {
+            return -TARGET_EFAULT;
+        }
+
+        changelist = alloca(sizeof(struct kevent) * arg3);
+        memset(changelist, '\0', sizeof(struct kevent) * arg3);
+        for (i = 0; i < arg3; i++) {
+            __get_user(changelist[i].ident, &target_changelist[i].ident);
+            __get_user(changelist[i].filter, &target_changelist[i].filter);
+            __get_user(changelist[i].flags, &target_changelist[i].flags);
+            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
+            __get_user(changelist[i].data, &target_changelist[i].data);
+            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
+#if TARGET_ABI_BITS == 32
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap32s((uint32_t *)&changelist[i].udata);
+#else
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap64s((uint64_t *)&changelist[i].udata);
+#endif
+        }
+        unlock_user(target_changelist, arg2, sizeof(*target_changelist) * arg3);
+    }
+
+    if (arg5 != 0) {
+        eventlist = alloca(sizeof(struct kevent) * arg5);
+    }
+    if (arg6 != 0) {
+        if (t2h_freebsd_timespec(&ts, arg6)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
+                                arg6 != 0 ? &ts : NULL));
+
+    if (arg5 == 0) {
+        return ret;
+    }
+
+    if (!is_error(ret)) {
+        target_eventlist = lock_user(VERIFY_WRITE, arg4,
+                                     sizeof(*target_eventlist) * arg5, 0);
+        if (target_eventlist == NULL) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < arg5; i++) {
+            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
+            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
+            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
+            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
+            __put_user(eventlist[i].data & 0xffffffff,
+                &target_eventlist[i].data);
+            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
+#if TARGET_ABI_BITS == 32
+            tswap32s((uint32_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#else
+            tswap64s((uint64_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#endif
+        }
+        unlock_user(target_eventlist, arg4,
+                    sizeof(*target_eventlist) * arg5);
+    }
+    return ret;
+}
+
+/* kevent(2) */
+static inline abi_long do_freebsd_kevent(abi_long arg1, abi_ulong arg2,
+        abi_long arg3, abi_ulong arg4, abi_long arg5, abi_long arg6)
+{
+    abi_long ret;
+    struct kevent *changelist = NULL, *eventlist = NULL;
+    struct target_freebsd_kevent *target_changelist, *target_eventlist;
+    struct timespec ts;
+    int i;
+
+    if (arg3 != 0) {
+        target_changelist = lock_user(VERIFY_READ, arg2,
+                sizeof(struct target_freebsd_kevent) * arg3, 1);
+        if (target_changelist == NULL) {
+            return -TARGET_EFAULT;
+        }
+
+        changelist = alloca(sizeof(struct kevent) * arg3);
+        for (i = 0; i < arg3; i++) {
+            __get_user(changelist[i].ident, &target_changelist[i].ident);
+            __get_user(changelist[i].filter, &target_changelist[i].filter);
+            __get_user(changelist[i].flags, &target_changelist[i].flags);
+            __get_user(changelist[i].fflags, &target_changelist[i].fflags);
+            __get_user(changelist[i].data, &target_changelist[i].data);
+            /* __get_user(changelist[i].udata, &target_changelist[i].udata); */
+#if TARGET_ABI_BITS == 32
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap32s((uint32_t *)&changelist[i].udata);
+#else
+            changelist[i].udata = (void *)(uintptr_t)target_changelist[i].udata;
+            tswap64s((uint64_t *)&changelist[i].udata);
+#endif
+            __get_user(changelist[i].ext[0], &target_changelist[i].ext[0]);
+            __get_user(changelist[i].ext[1], &target_changelist[i].ext[1]);
+            __get_user(changelist[i].ext[2], &target_changelist[i].ext[2]);
+            __get_user(changelist[i].ext[3], &target_changelist[i].ext[3]);
+        }
+        unlock_user(target_changelist, arg2, 0);
+    }
+
+    if (arg5 != 0) {
+        eventlist = alloca(sizeof(struct kevent) * arg5);
+    }
+    if (arg6 != 0) {
+        if (t2h_freebsd_timespec(&ts, arg6)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(safe_kevent(arg1, changelist, arg3, eventlist, arg5,
+                                arg6 != 0 ? &ts : NULL));
+
+    if (arg5 == 0) {
+        return ret;
+    }
+
+    if (!is_error(ret)) {
+        target_eventlist = lock_user(VERIFY_WRITE, arg4,
+            sizeof(struct target_freebsd_kevent) * arg5, 0);
+        if (target_eventlist == NULL) {
+            return -TARGET_EFAULT;
+        }
+        for (i = 0; i < arg5; i++) {
+            __put_user(eventlist[i].ident, &target_eventlist[i].ident);
+            __put_user(eventlist[i].filter, &target_eventlist[i].filter);
+            __put_user(eventlist[i].flags, &target_eventlist[i].flags);
+            __put_user(eventlist[i].fflags, &target_eventlist[i].fflags);
+            __put_user(eventlist[i].data, &target_eventlist[i].data);
+            /* __put_user(eventlist[i].udata, &target_eventlist[i].udata);*/
+#if TARGET_ABI_BITS == 32
+            tswap32s((uint32_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#else
+            tswap64s((uint64_t *)&eventlist[i].udata);
+            target_eventlist[i].udata = (uintptr_t)eventlist[i].udata;
+#endif
+            __put_user(eventlist[i].ext[0], &target_eventlist[i].ext[0]);
+            __put_user(eventlist[i].ext[1], &target_eventlist[i].ext[1]);
+            __put_user(eventlist[i].ext[2], &target_eventlist[i].ext[2]);
+            __put_user(eventlist[i].ext[3], &target_eventlist[i].ext[3]);
+        }
+        unlock_user(target_eventlist, arg4,
+                sizeof(struct target_freebsd_kevent) * arg5);
+    }
+    return ret;
+}
+
+/* sigtimedwait(2) */
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0



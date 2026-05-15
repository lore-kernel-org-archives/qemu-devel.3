Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90331CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxJ-0001Sb-L0; Fri, 15 May 2026 17:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxH-0001OY-HI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:23 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxF-0002xA-Nt
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:23 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso289421a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880021; x=1779484821;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DPsHqsgM5qsQSZVTM8FhflRo6WprK7RH5V6D51O329M=;
 b=IOVCaZuZEBv4mF/IUpcETBwDPKdJ4oxjxEgA/NzW5uFBj1ObIFaAZaiFz0xmhWxOl9
 uLRREHPA8qYBDXhy75VwsBhUL8Dy7c8pe/OHEsOIRm+STuHJ6sEmlDQ//HWi3gMLq7oq
 SQSKElF1PsFhbrV7DCZ2zU3k3/A2hpPZ/YAH8XLGM7QBqD1cTTVWYzJSZVngGJQi0L7Z
 69jbcBrhMtj5gkXp/Hb5y5kemb8TW1Roc99LeJD+UA6QioaDzMxOA0spdjr5LWoKTS7U
 l8ToIHKJ77hYL8idrYFYfa33nxhqr/rBJU/4it1saAr6bqB60yrJgxLznrvQE5X9l2Gb
 5ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880021; x=1779484821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DPsHqsgM5qsQSZVTM8FhflRo6WprK7RH5V6D51O329M=;
 b=FFurDqThBjnjG/mIDa5FyOK3ioxl8JUrvmnYE/2DbUUG+ixTRZ8ABQq2Yd9OGi3Fw3
 TcfWUZYzMf0l7a2bBvCkxP3R8HAhzzn2lFt4TeTElBcT/ufw7d2wGc0ymlgnRugXXVCr
 YseAkE0ypVTi1TyGFl6fN3IBmGGWeLQ3BHhs1+yemA2BLST9GaQMRzjy/KCpYtlF4UuL
 OqxHr/XuNVAF0vvrJiDQ3qVD7pklkUwa9eFS+m6meGc2wLWh6PKBxW8eQH0oXwrUSQif
 yPxKZ1Twbi4uaWLAe89PQYQ81OfdZpX9q6iG3+r0WIkZ2w8uFj+hYWSRoODwIm0EJWz3
 akbw==
X-Gm-Message-State: AOJu0YxiQZUYip3Ou+wYdxO4c721d3JFsQoUBUbLwAJ2cxuHAVCVGB8z
 0aJKqING0e3TlgdqMgnarVx+X+/JKHwIAtLdu0kzxv5bxvDH02xsZsHvzGiOHHspB+E=
X-Gm-Gg: Acq92OF0Q5vwz+5Z1HqvfjRWyQvzLcloohwQ9wRlIBHFpQoaW6mfhsu4zrO/0b9DSE4
 xsp9t8EDqvMB1Z1A0ee9W470gJfnHTrcapNUnJNUrZTUrag+i/ug/s1fU2V3+IsKZxzDwBxetvS
 1Kotm+4GUeOQl/vcEXRcb2jiTYVUd+rfa6F7VUCn8JQY8nhfEIsAEd5rOPa1TidbvZF4v7eCOLO
 SjkMOjbshTD7DRH6yvEW/5vO2DgexDo7gmrMQ7o+t4pPOQCUAPUoiHahnE9IinzA+B8Z7XpvCvB
 T3uyN9UplMfJ+4TdXitdB6K8iR2H6lMEskeYLLTEcuP8cFQDk3EiRHGRIsyZwk5oudMQwF8Bx1c
 yTZTCXAl3zIHizVHCwrXkQRxZwizIRcmHhCN51m77N7oFhywafE3QiyZD/S/jHoG/fbnlCMpQOw
 xi/PcigHAvcAYUVUxevwTy
X-Received: by 2002:a05:6830:6515:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e4fa057c32mr3819764a34.24.1778880020730; 
 Fri, 15 May 2026 14:20:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:17 -0600
Subject: [PATCH 18/66] bsd-user: Add utimes, futimes, and ktimer functions
 to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-18-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6472; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=oHe1KyXwOdY/6MGM1QGr2O7X5tpWFQ9x6c3hVRYAZrA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jyoAx/KXTMX66id16ZP6PB2X5D50MFYZjH
 aB4GGF6QXGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 AKW4EACoZtgcmFrX2/IpOHoMLiBcMXh2UFUaJs0OuQsWSQ+YEPqplWvMWWCTwyO4qmh5gX1PSYR
 tw//uKJWp+/dBazYk3x9H7YOf71LZEgIjM4hq/X7C+MgUlaZJSKP5ibt655pKTfEFNTR4VLxD3x
 yPS6t5wWK33qwVAUfuVCvgMnPbGBqpmsMK6nWWk6SYJVPJoBrO/fr0qkLhPHJB4t4Ov4J66ObMZ
 swbYNgiWF9tzBKdHuLxBpUvjLaZpkujpoGbWlySz813CROatAZ4ARq8Aaxnyu4lsm9c1UsZVuzX
 AVwNhK661nDZHp25KBjHRJXkcSLu4pW3aokjnU9GGym1McY4xaJeXenWYhaywTYqE/ppWBovKcT
 i6HtnNf7aejC0xLOE6o/Eqxmt5fIS8V4sOOT8YDI/T3TKoAECr95Qrjl2L11sscCCkMiSK4y5Th
 05zIR9U1i0cNt+N/83pmUNRwA7PKDBgs8GJ9eXToWHgqu6vMEenlenCH2P+jRm+CURFyrZHUbpl
 XQMbDt6qPHa+/j2SBhp5kXKSJk/JG3qL1CfVg4a0bjsvEHiDtDN7ojITylLh7crILDj3uvt7OS6
 q5AwG8kpr+kDgrExpKcCWFATrhcnxBO06kIzpBKnHl2rwtr7UAHdeRkJBubB3znW0QCLgSrNG5w
 Y6sVl0yNtrNnfBA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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

Add time-related system call shims: utimes, lutimes, futimes,
futimesat, ktimer_create, ktimer_delete, ktimer_settime, and
ktimer_gettime.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 210 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index bcc1a826a7..f1f8da90ba 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -217,5 +217,215 @@ static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
 }
 
 
+/* utimes(2) */
+static inline abi_long do_freebsd_utimes(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(utimes(p, tvp));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* lutimes(2) */
+static inline abi_long do_freebsd_lutimes(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(lutimes(p, tvp));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* futimes(2) */
+static inline abi_long do_freebsd_futimes(abi_long arg1, abi_long arg2)
+{
+    struct timeval *tvp, tv[2];
+
+    if (arg2 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg2) ||
+                t2h_freebsd_timeval(&tv[1], arg2 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    return get_errno(futimes(arg1, tvp));
+}
+
+/* futimesat(2) */
+static inline abi_long do_freebsd_futimesat(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct timeval *tvp, tv[2];
+
+    if (arg3 != 0) {
+        if (t2h_freebsd_timeval(&tv[0], arg3) ||
+                t2h_freebsd_timeval(&tv[1], arg3 +
+                        sizeof(struct target_freebsd_timeval))) {
+            return -TARGET_EFAULT;
+        }
+        tvp = tv;
+    } else {
+        tvp = NULL;
+    }
+
+    p = lock_user_string(arg2);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(futimesat(arg1, p, tvp));
+    unlock_user(p, arg2, 0);
+
+    return ret;
+}
+
+/* timer_create(2) */
+static inline abi_long do_freebsd_ktimer_create(abi_long arg1, abi_long arg2,
+        abi_long arg3)
+{
+    /* args: clockid_t clockid, struct sigevent *sevp, int *timerid */
+    abi_long ret;
+
+    struct sigevent host_sevp = { 0 }, *phost_sevp = NULL;
+
+    int clkid = arg1;
+    int timer_index = next_free_host_timer();
+
+    if (timer_index < 0) {
+        ret = -TARGET_EAGAIN;
+    } else {
+        int *phtimer = g_posix_timers  + timer_index;
+
+        if (arg2) {
+            phost_sevp = &host_sevp;
+            ret = target_to_host_sigevent(phost_sevp, arg2);
+            if (ret != 0) {
+                return -TARGET_EFAULT;
+            }
+        }
+
+        ret = get_errno(__sys_ktimer_create(clkid, phost_sevp, phtimer));
+        if (ret) {
+            phtimer = NULL;
+        } else {
+            if (put_user(TIMER_MAGIC | timer_index, arg3, int)) {
+                ret = -TARGET_EFAULT;
+            }
+        }
+    }
+    return ret;
+}
+
+/* timer_delete(2) */
+static inline abi_long do_freebsd_ktimer_delete(abi_long arg1)
+{
+    /* args: int timerid */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        ret = get_errno(__sys_ktimer_delete(htimer));
+        g_posix_timers[timerid] = 0;
+    }
+    return ret;
+}
+
+/* timer_settime(2) */
+static inline abi_long do_freebsd_ktimer_settime(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    /*
+     * args: int timerid, int flags, const struct itimerspec *new_value,
+     * struct itimerspec * old_value
+     */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else if (arg3 == 0) {
+        ret = -TARGET_EINVAL;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
+
+        if (target_to_host_itimerspec(&hspec_new, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(
+            __sys_ktimer_settime(htimer, arg2, &hspec_new, &hspec_old));
+        if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* timer_gettime(2) */
+static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
+{
+    /* args: int timerid, struct itimerspec *curr_value */
+    abi_long ret;
+    int timerid = get_timer_id(arg1);
+
+    if (timerid < 0) {
+        ret = timerid;
+    } else if (!arg2) {
+        ret = -TARGET_EFAULT;
+    } else {
+        int htimer = g_posix_timers[timerid];
+        struct itimerspec hspec;
+        ret = get_errno(__sys_ktimer_gettime(htimer, &hspec));
+
+        if (host_to_target_itimerspec(arg2, &hspec)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC685C982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFL-0002sO-6n; Sat, 19 Sep 2026 12:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFJ-0002s6-6X
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:01 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFH-0008He-HX
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:00 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 46e09a7af769-80a71781323so749536a34.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836538; x=1790441338;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1UnoJZ2salmo3FsO31OG+t/xnG8LyqG6BerW+1cdcvI=;
 b=n23uQECN0FTwMNuYdI97ipBStH3QNpNh5MXfh5d2lI8m6kg0hELypHH6/mTYrr+buT
 apcMRP7R5MyH2We/1i5SOYrg1zMG3Y9v9LeVwyyzrsomiQhaz86LdByu9oGIFEjDydHG
 T0J1k8au4uhBszjv6HodxEhALVUTJFBQje4qP04W0Zq2ii2qKcHqKCikFHxBC/K6/4KT
 +h4N9j4BTKQmWJ91TtmkMXd63GsHti/rSzfsvd/SfkLAceRcqtcGkoPwYmcgucTbD79Y
 c8lHO4Ay6SYAmRmVTJw3Y+zasOLy72jWe8PG9RPDkCHZg8FlqGT7wmILyvLI7gPsA7Jb
 mXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836538; x=1790441338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1UnoJZ2salmo3FsO31OG+t/xnG8LyqG6BerW+1cdcvI=;
 b=J84AUHjx1+kjB1lpQteTnXodK+6dMy+PPL2LdjNgpNej1dFxawja2GDwrEkPXyxMNu
 mwL6iUXhK9ZyCCBcmyArO+PTy/3niIqTZL4pu7Kqzf1PgY+UnvKwEMZy5neZAhfpbKTr
 +cnbhVxkAgoVTJpK8XNwBQkpE+ipzv2Tixpmc4xTIaGA6WlxH5q6LCxFW6ydxXjR/LQ9
 lXi23kRt5aR2amwghPWhqXiXjEZfB0HBI9LDH5spUh3I+8aS43u05b5XFzIvVC6XlV6r
 1TIMfjKXxvFXGDv1MmrPVyTctUUpb5z2aYmtMkuzW3YYBZE3jBS1K/dNIaWkJMiEVotI
 4UUA==
X-Gm-Message-State: AFuF++mqcfbhyL3MLRnQ3dYQneEz8rToULwVVaMUJyOfvbB6Wm6jpf8T
 NFJKcETzEFMHRRZc4aCAQhgUyM9flTqZQf9xZK1wYi1T3HVsAqi6JtRYdSWTsM1snkCsap2gxgp
 ILPzx83w=
X-Gm-Gg: AYBFou1R03Pe9LMyyqy9d/HK1EeV/F3kPURMlnyzLz5Q89kRAqsd/uonOm9d0LegWio
 j8TiwOC8We7Srbo8aC8oCjOUk6R3OFNtHxVVdJ1RxzmZFA48oeZZ5yRaS5fHsNF5308B4aiiSyC
 R5ujVehsAcFfnry9r4jswUe0d3N3gCSFTY1zY+14n/hPDtEaSKfCo6Q8lfHvtoM17oHaci/hgCc
 3A4SAw8YIDW/y8E3RqBvTuTRBCmOHUKrs0UbU8v5AplI1jFbMGt9Yx231PlKmu93mxTKkqYcftY
 WyVURTxQzZoIW6cuM2G+DhvhS5GU/aWGGXG0KISaiIfMVh4PkNHW0zLwRdzqm20dbnGlJObtzqA
 ovCtwYAaCK4+Y8D8/doeVZwaKSEVYFXMba355KdUrN7AsX5GGfl07AJuEP0nTS3eSPAveqoGn+o
 UwyGZrKJqPNKVkKeJ/jcRYzhxa1kNS1iwVjQbMczfAdk9md+ih7bCJ/dMVsA==
X-Received: by 2002:a05:6820:8591:10b0:6cd:3fdc:a93a with SMTP id
 006d021491bc7-6cd3fece101mr1799431eaf.87.1789836538549; 
 Sat, 19 Sep 2026 09:48:58 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/41] bsd-user: Add socket shims socketpair through shutdown
Date: Sat, 19 Sep 2026 10:47:44 -0600
Message-ID: <20260919164810.70151-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Complete bsd-socket.h with socketpair, sendto, recvfrom, socket,
and shutdown system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h | 116 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
index c786d6717a..43aacce5dc 100644
--- a/bsd-user/bsd-socket.h
+++ b/bsd-user/bsd-socket.h
@@ -164,4 +164,120 @@ static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
     return ret;
 }
 
+/* socketpair(2) */
+static inline abi_long do_bsd_socketpair(int domain, int type, int protocol,
+                                         abi_ulong target_tab_addr)
+{
+    int tab[2];
+    abi_long ret;
+
+    if (!access_ok(VERIFY_WRITE, target_tab_addr, sizeof(tab[0]) * 2)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(socketpair(domain, type, protocol, tab));
+    if (!is_error(ret)) {
+        if (put_user_s32(tab[0], target_tab_addr) ||
+                put_user_s32(tab[1], target_tab_addr + sizeof(tab[0]))) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* sendto(2) */
+static inline abi_long do_bsd_sendto(int fd, abi_ulong msg, size_t len,
+                                     int flags, abi_ulong target_addr,
+                                     socklen_t addrlen)
+{
+    struct sockaddr *saddr;
+    void *host_msg;
+    abi_long ret;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (len != 0) {
+        host_msg = lock_user(VERIFY_READ, msg, len, 1);
+        if (!host_msg) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        host_msg = NULL;
+    }
+    if (target_addr) {
+        saddr = alloca(addrlen + 1);
+        ret = target_to_host_sockaddr(saddr, target_addr, addrlen);
+        if (is_error(ret)) {
+            unlock_user(host_msg, msg, 0);
+            return ret;
+        }
+        ret = get_errno(safe_sendto(fd, host_msg, len, flags, saddr, addrlen));
+    } else {
+        ret = get_errno(send(fd, host_msg, len, flags));
+    }
+    unlock_user(host_msg, msg, 0);
+    return ret;
+}
+
+/* recvfrom(2) */
+static inline abi_long do_bsd_recvfrom(int fd, abi_ulong msg, size_t len,
+                                       int flags, abi_ulong target_addr,
+                                       abi_ulong target_addrlen)
+{
+    socklen_t addrlen;
+    struct sockaddr *saddr;
+    void *host_msg;
+    abi_long ret;
+
+    host_msg = lock_user(VERIFY_WRITE, msg, len, 0);
+    if (!host_msg) {
+        return -TARGET_EFAULT;
+    }
+    if (target_addr) {
+        if (get_user_u32(addrlen, target_addrlen)) {
+            ret = -TARGET_EFAULT;
+            goto fail;
+        }
+        if ((int)addrlen < 0) {
+            ret = -TARGET_EINVAL;
+            goto fail;
+        }
+        saddr = alloca(addrlen + 1);
+        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, saddr,
+                    &addrlen));
+    } else {
+        saddr = NULL; /* To keep compiler quiet.  */
+        ret = get_errno(recv(fd, host_msg, len, flags));
+    }
+    if (!is_error(ret)) {
+        if (target_addr) {
+            if (is_error(host_to_target_sockaddr(target_addr, saddr, addrlen))) {
+                ret = -TARGET_EFAULT;
+                goto fail;
+            } else if (put_user_u32(addrlen, target_addrlen)) {
+                ret = -TARGET_EFAULT;
+                goto fail;
+            }
+        }
+        unlock_user(host_msg, msg, ret);
+    } else {
+fail:
+        unlock_user(host_msg, msg, 0);
+    }
+    return ret;
+}
+
+/* socket(2) */
+static inline abi_long do_bsd_socket(abi_long domain, abi_long type,
+                                     abi_long protocol)
+{
+    return get_errno(socket(domain, type, protocol));
+}
+
+/* shutdown(2) */
+static inline abi_long do_bsd_shutdown(abi_long s, abi_long how)
+{
+    return get_errno(shutdown(s, how));
+}
+
 #endif /* BSD_SOCKET_H */
-- 
2.55.0



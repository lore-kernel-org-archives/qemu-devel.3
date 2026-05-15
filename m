Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7591CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx8-0001CM-N2; Fri, 15 May 2026 17:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx7-0001BI-4e
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:13 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx5-0002sB-DR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:12 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so343697a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880010; x=1779484810;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QwxcDBxfcEuftcZ6S6KRRMd4HtIR3+pnE2ndVidOVhk=;
 b=EewIf0YxRcFtH7VTsrphn33I+3UiG0f4Jp9YamJEAva0OOECgd3SHdapc8GKFWwP6R
 O8OosRmDcCIFB9vWSUqpVWS5Ki5zcho+CJwGyRglMZ5/U2AAsPkLPiUuPjhtxSYmC69i
 0wOjia5Q0RETqwZFTGn4Sf9EXwSOoyy9frofxvu3xcOHOWi45HnMcw1/Znl3IY4NV/yN
 hXShmV6eyfkywcLVokbZL6KN5ltWsVA/41Gd7n/EP8qENrZfWX9rBMQN+3xdogg5SrC2
 4hud9FpO6MuS9ufpxrrqQ16N08MJ2xo++y8Fgnr1sG3fKi4nRLAkuwIL5GPV8ZQLKG5m
 gT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880010; x=1779484810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QwxcDBxfcEuftcZ6S6KRRMd4HtIR3+pnE2ndVidOVhk=;
 b=kOzRVwfKkn3umC085MpYLExEpdXIsJpuyMoh+Ndqqh65Fw/WlxxXtgcVhs4TyccijH
 C9oR/RJirUqOt3xc+Sll+jkE9hVhKsDFLdksofqRDc1h3B7usP7cFjFRdLttYaEmL757
 HPYfXgqZ752ICSobwuyqiW3VPe0MB1jloXOvqHy4CCwAFW5JE6lr0sW4KuZKGdLY6QHz
 ExPyvuJqnS1lMZ/ekZOU71N0x5om8gWscgqd0DTnX3x8vEYzsZBYBBMMpOiI2aHffbuc
 MZtFMKAsTguhEh0VLvUtJp0nHQXY8rNeLrmGtgwh0a3fZhk4fy+AOWNm2G7VaWxbADX+
 FhhA==
X-Gm-Message-State: AOJu0Yw+IxNqzDw4+dWIRGSoC3FdaYRkcNS36ZLxzgKBMzmmeawqEtWo
 QwAHOLBLd+Wvo738EI+8DQKDHIibvEYUw54CjWECdMj65BFjyRth3q/b31fVqrreBhE=
X-Gm-Gg: Acq92OF3BT+2mfYh91k4f3BOqz1hNuT23aiqIKt1REk7am46e3advOgHoAuNeaCLkps
 iVj3cgBcobqP2bMQUhHCnevwHH2UTnZXpRCPusQKFrjhbvmAe28C/zYR+YeaGLgCxriwC/KQsLv
 fvkctmI2jgQjiHIlV+Ut5Ira+m3r/93sc4L47GY6dKhwhWiwVQGCeM8TNg0Qvz7oNhR2nKIN7Fd
 t02gUexpKtbOlgkf9n6BFb4ASqn2i8ZtpSBCvivU6ELnA4VGk/h8wmLJiJxxtVP4wx6wmtCBhV0
 1mZHpkPv8yMeH/aFbYV3KKQ/pLP5RjwG7pdTVgy103MUOQ23zD4JE6PvA+QIT0tQFftn1buGOS6
 7xuEnNoGlg9FVL3uugtKx1hqz7Uv+gR5VnCUGd1b1lsuPXTDWk6i3RiH4JoyR0gdhyRDsvflJE6
 IySePZjEsSsEzDwQwYQwEI
X-Received: by 2002:a05:6830:d0d:b0:7dc:cb0d:9e02 with SMTP id
 46e09a7af769-7e4a3e5e77bmr3496110a34.9.1778880010384; 
 Fri, 15 May 2026 14:20:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:09 -0600
Subject: [PATCH 10/66] bsd-user: Add socket shims socketpair through shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-10-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4186; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Z5UdDzcopzUGMjRMp45t8+R+3fsuou9TYbXSLV+0l+I=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43iOikGFSOnUbRn+pX9ly3rXu6Zv8fOkg+Hp
 OZMx5RCf8SJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 ALGEEADBpKg2YbNQOAbNE2FxQb9Ln1+Wia43WAX9c/xFIuWx3YNhvn0C8/UtmlZLmXTKv4dtvru
 +3L7spFAEURA4RIHqwaMinHAe9tuRJLgSaF3sQvTrOuKEqNMeytnHQR677uKK/IlI9RL+BPOB9M
 s3O+eG2MchDID9FDwbMvDYOLZTx0vv7gw9Zn1GT59bPaOmx0UPRgWBriRtfDWRNw//lWOicXdlg
 7K6aLSWi72atbfzLIfzC1Zvd0oNxD8dvlsbIjn2tudxL9CQs3tfMxVAANsJvMJlKNXJcK+jdeED
 hTQgkFVKMW0/jNDak3mjFiTcLDypc/3EDIM8xF+v9GAbWbJynvb/rOgXJoff9fYV+NfJVuPPAYi
 4EHaeRbP5OQ7F0WaHAUUGHhBcWdPnC9fD8mY+v8yLK+dEYlS5Wx6gEt+2cbzzjPCJ074GLpTlPL
 aOVDXxVa588ErKe7Wb8JeSIwnaKUcAEzwdp7JWly1FOP+VrsNiqnzv1HOjVHnpHSFz/SycVqcpf
 WpA1ICflhApaZo3yoIVoQavp8berAEyvpkD0Fc0/wWdHhYonFQUGFAB6UNWPMhda4tbu5wfJuOC
 MhM71Y33+H6E5vFk/OHIUOfNVuMVLOhYU+KS/FIc+bjILGdkwDsILujDjpgMR7qHD67NLjsziY3
 pg+w5UNndQoInqw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
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

Complete bsd-socket.h with socketpair, sendto, recvfrom, socket,
and shutdown system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-socket.h | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
index 121d3e2a05..578cc3959d 100644
--- a/bsd-user/bsd-socket.h
+++ b/bsd-user/bsd-socket.h
@@ -157,4 +157,118 @@ static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
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
+        saddr = alloca(addrlen);
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
+        saddr = alloca(addrlen);
+        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, saddr,
+                    &addrlen));
+    } else {
+        saddr = NULL; /* To keep compiler quiet.  */
+        ret = get_errno(recv(fd, host_msg, len, flags));
+    }
+    if (!is_error(ret)) {
+        if (target_addr) {
+            host_to_target_sockaddr(target_addr, saddr, addrlen);
+            if (put_user_u32(addrlen, target_addrlen)) {
+                ret = -TARGET_EFAULT;
+                goto fail;
+            }
+        }
+        unlock_user(host_msg, msg, len);
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
2.52.0



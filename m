Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B228CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VO-0000PY-LG; Mon, 18 May 2026 17:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VM-0000OP-GY
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:04 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VK-0000S4-VP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso2947826a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139682; x=1779744482;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZJ7v//PQurI3QUAyO+HvdctCbJ9hSdibdnByYDaydXY=;
 b=Z2hZ0UJyx4kmXotMBe6m/pW6WBlx+rvdZehWEkHqjnsei3G72p93qpjDdOzYhKU3HJ
 KV6fJ6/GATxhBxp5ktFp+rO68QBGk3q0xbfgyjfp0JRqrbLMKguOAxceNkwhK0sWEmZS
 eI4Y9d4StJW6pcnZcS7Z+F6U1z9YpQeFwgQByU3KzmX7ivkuL0acb059XeI9eUQNrb4S
 KbcJBvL6B0U7uo2cSYAWN9p4y13k9xwHGIdDzN7BSkvHNK8fqmvTtCfxEEE1x9xqLr5l
 LjeNjjXHWhRGz012PTg4gO2HqpjcLg7YTRsvy9DyTLl7q9YD9oYwNHS1h8DjtvKNyLIx
 s0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139682; x=1779744482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZJ7v//PQurI3QUAyO+HvdctCbJ9hSdibdnByYDaydXY=;
 b=Gu8QzX9vfXB410l2ywQ9zPVPWd6lYtWIiBOFbzjKXX3Xb6f/Ru7MwWn1NOnzrwo5xu
 VL1M5JrvusKDNA+Iyg0O2aOSyjlWj0Dimw09zdn4chuSnz/SU3m8gW4XRsEUxuS6EFGP
 p8pgTiSC1JYDFQIIhd8XJ/Pz1zgMPrWHbQKGwt1iheBfY8ZgpbfhGXujpjaFNq/5mRES
 127W3GOwmTXbKeK3xD4QLRYGO/PfSeNfyoe5rJFGxtP1InHAHAfLeCa9fPP3HXT66e54
 k/JZwE1Z8m3AJP5cJDqIQ14Y1JbKx+WSX5jQmsFnEIwA8Fi2I3Ctk972WQYCKk8/tR2v
 FZNg==
X-Gm-Message-State: AOJu0YzCGKyjFaYkQ1y5qnoSEDtuTH2j7XUvArrL7asS0VRSbNuu2NG2
 zju+tyVaBnGCAopieN2Fvh2NG1hna4ZZP0v3rOTvxIH9LujNCVNxUh3Z2L4BYpRd22I=
X-Gm-Gg: Acq92OERPiseIMod71DGN7viW58HcYM8mGs3Ov/PDd5nkqOhMwMLDSwK07nBZq8Nr+f
 c0N5+9gn2s1gWakXe5IBLDe5F+ChNp8X5QdKZTK+iSyisiULtZ/0o68rxCVNVwzCTz/uzvivuGa
 2+jJipRfEbHsPfp9cfCi01Lz+iIEXWsAqDW60hc0wsea8QrOAktJQwX4Y14qU8FCRmXJL0Hqe8p
 jXSfmCBfebSsXLRfaHW1Vdx0R19qkO9RdB5JLsQm1Nu1RxogfrUGdCe/9Z6fSG6S+RkorvsfcUT
 FfDybHizZydI/1GNB31Lslsoojlld+tHyGP+MXPp+/+iO7kWwKH/RSfxV7Sq+A/4HSCaXybDbYN
 dFUN+XXAfa82RgFM3mMm8t1k0Wlx8aWTrxLd9tcAL3R1RJVymopJezjTHBlsZ7HrFsbhJpeF6cj
 GDmEIHb6XC1MPWZGg+kS8G
X-Received: by 2002:a9d:4f15:0:b0:7dc:e43f:4b31 with SMTP id
 46e09a7af769-7e3f14c8d19mr8791428a34.12.1779139681847; 
 Mon, 18 May 2026 14:28:01 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:01 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:28 -0600
Subject: [PATCH v2 10/37] bsd-user: Add socket shims socketpair through
 shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-10-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4286; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=p+SdwfCAmHsiJep/Ad8iRM9GDkukh3wykvHxywkpLCc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGevPBMDjfezN8f/kRACf1wC1Ui7bxbwKVS
 maB5iM38YyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AIXvD/9wEm0S86iRvI1aDfm6rRe/v/ux+WwKC65AvFJi860rDhDZ2BVbX3r5rQBYgu+S4mUJod9
 exCHllGAR8pdpdoYk+j95ahQ2yAb6GIeCgwSs8K1jZFzy1fz0ONPX5wsSRg7uKIVIyXbx6grg9i
 JeWmmmLn/LM2h2pGshGxhWnHIOxlugnZVHBZ8nBL+WbjxDiP5jpoj/Vt8Phdq1YU5Av6IrhYJdS
 Zx/tBs5CTIB/i31nrE/51nSY0McqoWDWF4i1yw7IMHruDTmTFxe33RwD2i0BNwj3etTnKWSunrL
 Ui0L8HGIecnN0e/20kl2dVwfWI3HNED8X5wpcwUq9d8/5jR+V9E5E9NzUhKzbOUIFr0lKv0cSR2
 x6KQtwupbG3QZkRT1tt+pO+CXx2H4gwgba9Q5vCHjnJx7ZQSZ6ij8T9ib5rQpPHRoAV4CM9GjkS
 BrmHq1gDaI9T9d7XomnsvJJ+9RaUlf0rf88l2WWQkY3S9/ZzeNVEKEQXAbPsWrDMJMNklOvHW4N
 fcm16YyQ4TJls2G7FkrEYI6DQD99KQxhe4Ux5AOzv870g0F512UXMX/qieT3PUi6Nmy9LaQG1g5
 P6P9x4q68imf8Ym0r7QmOuVFEX5GVtftTtZvfPEaakIv6A2DtizReSC+aZ4EUHoWk91b3vK/1h4
 9kvdJobqXaMnx7A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
 bsd-user/bsd-socket.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
index c786d6717a..c87ba195dc 100644
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



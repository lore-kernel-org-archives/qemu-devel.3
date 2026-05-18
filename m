Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A38CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VQ-0000RB-Tf; Mon, 18 May 2026 17:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VP-0000QN-Rx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:07 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VN-0000Sb-RD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:07 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d5ff103aso1516327b6e.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139685; x=1779744485;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ffGWOGouYH/3qhNFMBbsUWZO8GGJWXnR9Uk1mAQ4d2A=;
 b=D40rycjwQzFKsxjHGzt9uYvXS2rQfBCwR8UFBy29aDawNf0jEcv8A+UklRUdcQjeia
 UriVut+S2dFEWNmuiUpR7R5GssDa+lrkPTdV8VJfPAZuwpQ+gayhvfuZnhMhW4XT7oR5
 pWi8KOSvEVh/hFgOvO2FC/aoSunyV8ULe9GweLVcdQ/nUYtPug+OqQG4WPC/XPSuKQXH
 iJsxj/COc/DzMZJAi1PPdRH1Mql8s9ThJ7Dxz5rPF4MtnSB7I1Qocu/1gbm98OZwISZS
 6GWokN+PrmhD5uwUwQHN5FtjVt1XRHJSkkilbmdkijvzSGdajDdTTebxGE691Kw2jG7k
 xgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139685; x=1779744485;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ffGWOGouYH/3qhNFMBbsUWZO8GGJWXnR9Uk1mAQ4d2A=;
 b=XfKpH+15LM303Z4wqj1YhsDzvkJyUcZcD/WZRXiDxGZ79gzafIxXcW53uawq0QnGSz
 kIVef9ZNGVcPOqAGquB1Pd/UDnhNQCKhrLJxijfFEEkfLSb5D+O4YotdXb47uEnoUg5Y
 Mp5dnu6Rfwdnlvdg1mralm/0AHBYfWSf+N1/9pzsH7PqPmQUyToHobkLTQa917Z2U0E5
 MNdimla0FpXf0i0XaP04cHBawTd5AECZik9V8hb2jb9Tg5Ag9EIpaZuCnkiZLOBlKMvr
 NuWRXL/pQ5B81dIiFmY//9L7TSXn32GhB6fcbb56uyjbweKq0JL0w7K/3zDk6/k2JJLv
 4uOg==
X-Gm-Message-State: AOJu0YwMjKuixpATCogwpI1W9UUh0qgZ2LnjGwOgFPxjW41LKZYulBXT
 0tDXlpsE8xR2pAv0IYtPBmOqQCB8o14FIwSkVLILMr2ZWFBncsXUJSkB+d9BpWEEhgM=
X-Gm-Gg: Acq92OHTR4vKedR7MpP0SWdFexSM/BLdWsScljjwngjaFUuEwpc7RtVgn1Qy6Ockf3D
 yz03XYb+ZwUszSIt2vE/B+m/dxyLE5jDaGrV0pBA0rwydI1tzOlKz6ckolBkQ16+sNqrYLApl2B
 iocNtmIcsXNUkg9o1RGayIvLm18rLogXviHwvrtEyVNlFFTFvXnJbatHEqB+jWMw6D+VY4ACkDC
 c+lyp+XcBUvSIbyaJSYCSKhttZSr9pdBvBY2LUE5cQ7Z92zdscbrGHMPR3HKf/syqCXxGg8zBJl
 GCzzicqpifbo9cdPCdiIVHKB8HZZXqiN4fqiulm2HWPr6a/+3m0BSsoVRgOqC90AQ9U9jU0oBMv
 s5iQm4rKcgtm9gC31k+csv31cUmltnzDzUMVbDV+shKFuZ+yBstDjAWckppTb6PNfP8AHwP1PCf
 JlHAWGYn/DTw==
X-Received: by 2002:a05:6808:6f87:b0:471:f036:7926 with SMTP id
 5614622812f47-482e572bbcamr11156185b6e.28.1779139684744; 
 Mon, 18 May 2026 14:28:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:31 -0600
Subject: [PATCH v2 13/37] bsd-user: Add do_bsd_getsockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-13-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10985; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ZroN70mzMZjT1PVArrNmYN1/jgU1sbqaHOJX9r8bxU8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RH4k4/puELGgP5AAg4Br+Ir32zvXrcvgQmG
 oFqJ7+JaNyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 AIF2D/wJdwzw106FrCLJNK9J9o9a0rcMq5cqeznREM3av+KsLZIrMJRPAaJoCLnJ2vI09R1jULR
 A1CozHaSGzQY+3ePNEkqQ/O5wiv74PhFFj7RA1L+RLiJGEncG0J42RHgVYKww9OBgZBG++RBk2i
 Xp8tLGu1g3JD6nE+mz5WjwCBK2QrsXaTalBksfKv2KbNKbC9tXJeY/ugr15pJCVZ2nSM6xd9G9y
 i2pRatDulxyR6AGl9LQeeZVSCXPXvBHWkjCNd0KRBoEH51KD0TL+0T3c8BcpXHfwzPiY/7qaiiV
 iN59fpEhIBai+mg4aqfAFpj+7C3H4XI5yzfIxedN+zot06WBdIqXsU1WGQ8oww67Lm04fK7LdXi
 qQ8jewvjcaFoVxZGnWAd0bzar66FC79WocCH94bcmmWNASezPKzIU/hHh5187lraqiY9AlM6iFx
 bm44eLfVWxdniXwv2XEH/EgCkjV6A9/+eRUCFICJShNdEvBd0/9LXO33cGgoB4qxDLZw84k+aOd
 Nqe8Z5D3Z16AQFn4ULi2xKvSWQm9+sNdAt3aOBF6XzuxE5OtuRD7CP+nrffMiwI+xawUdkORLg0
 mqwG4Ch1OKaIKzMbQeOGOZcNr/dpzvP3+l8ApBlPaAManctU2NIIk9jKuFAmNIG7mKPN7n2EvA9
 WBTEztNTB7vvlCw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22a.google.com
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

Add the getsockopt(2) implementation handling SOL_SOCKET, IPPROTO_TCP,
IPPROTO_IP, and IPPROTO_IPV6 levels with proper target-to-host option
name translation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-socket.h | 284 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index 897a1f4d2f..f8521780c1 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -399,5 +399,289 @@ unimplemented:
     return ret;
 }
 
+/* getsockopt(2) */
+static inline abi_long do_bsd_getsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, abi_ulong optlen)
+{
+    abi_long ret;
+    int len, val;
+    socklen_t lv;
+    void *p;
+
+    switch (level) {
+    case TARGET_SOL_SOCKET:
+        level = SOL_SOCKET;
+        switch (optname) {
+
+        /* These don't just return a single integer */
+        case TARGET_SO_LINGER:
+        case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_SNDTIMEO:
+        case TARGET_SO_ACCEPTFILTER:
+            goto unimplemented;
+
+        /* Options with 'int' argument.  */
+        case TARGET_SO_DEBUG:
+            optname = SO_DEBUG;
+            goto int_case;
+
+        case TARGET_SO_REUSEADDR:
+            optname = SO_REUSEADDR;
+            goto int_case;
+
+        case TARGET_SO_REUSEPORT:
+            optname = SO_REUSEPORT;
+            goto int_case;
+
+        case TARGET_SO_TYPE:
+            optname = SO_TYPE;
+            goto int_case;
+
+        case TARGET_SO_ERROR:
+            optname = SO_ERROR;
+            goto int_case;
+
+        case TARGET_SO_DONTROUTE:
+            optname = SO_DONTROUTE;
+            goto int_case;
+
+        case TARGET_SO_BROADCAST:
+            optname = SO_BROADCAST;
+            goto int_case;
+
+        case TARGET_SO_SNDBUF:
+            optname = SO_SNDBUF;
+            goto int_case;
+
+        case TARGET_SO_RCVBUF:
+            optname = SO_RCVBUF;
+            goto int_case;
+
+        case TARGET_SO_KEEPALIVE:
+            optname = SO_KEEPALIVE;
+            goto int_case;
+
+        case TARGET_SO_OOBINLINE:
+            optname = SO_OOBINLINE;
+            goto int_case;
+
+        case TARGET_SO_TIMESTAMP:
+            optname = SO_TIMESTAMP;
+            goto int_case;
+
+        case TARGET_SO_RCVLOWAT:
+            optname = SO_RCVLOWAT;
+            goto int_case;
+
+        case TARGET_SO_LISTENINCQLEN:
+            optname = SO_LISTENINCQLEN;
+            goto int_case;
+
+        default:
+int_case:
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            lv = sizeof(lv);
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len > lv) {
+                len = lv;
+            }
+            if (len == 4) {
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (put_user_u8(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            if (put_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+
+        }
+        break;
+
+    case IPPROTO_TCP:
+        /* TCP options all take an 'int' value. */
+        goto int_case;
+
+    case IPPROTO_IP:
+        switch (optname) {
+        case IP_OPTIONS:
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            lv = (socklen_t)len;
+            p = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+            if (p == NULL) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, p, &lv));
+            unlock_user(p, optval_addr, len);
+            if (put_user_u32(lv, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+        case IP_HDRINCL:
+        case IP_TOS:
+        case IP_TTL:
+        case IP_RECVOPTS:
+        case IP_RECVRETOPTS:
+        case IP_RECVDSTADDR:
+
+        case IP_RETOPTS:
+#if defined(IP_RECVTOS)
+        case IP_RECVTOS:
+#endif
+        case IP_MULTICAST_TTL:
+        case IP_MULTICAST_LOOP:
+        case IP_PORTRANGE:
+        case IP_IPSEC_POLICY:
+        case IP_ONESBCAST:
+        case IP_BINDANY:
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            lv = sizeof(lv);
+            ret = get_errno(getsockopt(sockfd, level, optname,
+                &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len < sizeof(int) && len > 0 && val >= 0 &&
+                val < 255) {
+                len = 1;
+                if (put_user_u32(len, optlen) ||
+                        put_user_u8(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (len > sizeof(int)) {
+                    len = sizeof(int);
+                }
+                if (put_user_u32(len, optlen) ||
+                        put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            break;
+
+        default:
+            goto unimplemented;
+        }
+        break;
+
+    case IPPROTO_IPV6:
+        switch (optname) {
+        case IPV6_UNICAST_HOPS:     /* int; IP6 hops */
+        case IPV6_MULTICAST_IF:     /* u_int; set/get IP6 multicast i/f  */
+        case IPV6_MULTICAST_HOPS:   /* int; set/get IP6 multicast hops */
+        case IPV6_MULTICAST_LOOP:   /* u_int; set/get IP6 multicast loopback */
+        case IPV6_PORTRANGE:        /* int; range to choose for unspec port */
+        case IPV6_CHECKSUM:         /* int; checksum offset for raw socket */
+        case IPV6_V6ONLY:           /* bool; make AF_INET6 sockets v6 only */
+        case IPV6_RECVPKTINFO:      /* bool; recv if, dst addr */
+        case IPV6_RECVHOPLIMIT:     /* bool; recv hop limit */
+        case IPV6_RECVRTHDR:        /* bool; recv routing header */
+        case IPV6_RECVHOPOPTS:      /* bool; recv hop-by-hop option */
+        case IPV6_RECVDSTOPTS:      /* bool; recv dst option after rthdr */
+        case IPV6_USE_MIN_MTU:      /* bool; send packets at the minimum MTU */
+        case IPV6_RECVPATHMTU:      /* bool; notify an according MTU */
+        case IPV6_HOPLIMIT:         /* int; send hop limit */
+        case IPV6_RECVTCLASS:       /* bool; recv traffic class values */
+        case IPV6_AUTOFLOWLABEL:    /* bool; attach flowlabel automagically */
+        case IPV6_TCLASS:           /* int; send traffic class value */
+        case IPV6_DONTFRAG:         /* bool; disable IPv6 fragmentation */
+        case IPV6_PREFER_TEMPADDR:  /* int; prefer temporary addresses */
+        case IPV6_BINDANY:          /* bool: allow bind to any address */
+#ifdef IPV6_BINDMULTI
+        case IPV6_BINDMULTI:        /* bool; allow multibind to same addr/port*/
+#endif /* IPV6_BINDMULTI */
+#ifdef IPV6_RSS_LISTEN_BUCKET
+        case IPV6_RSS_LISTEN_BUCKET: /* int; set RSS listen bucket */
+#endif /* IPV6_RSS_LISTEN_BUCKET */
+#ifdef IPV6_FLOWID
+        case IPV6_FLOWID:           /* int; flowid of given socket */
+#endif /* IPV6_FLOWID */
+#ifdef IPV6_FLOWTYPE
+        case IPV6_FLOWTYPE:         /* int; flowtype of given socket */
+#endif /* IPV6_FLOWTYPE */
+#ifdef IPV6_RSSBUCKETID
+        case IPV6_RSSBUCKETID:      /* int; RSS bucket ID of given socket */
+#endif /* IPV6_RSSBUCKETID */
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            lv = sizeof(lv);
+            ret = get_errno(getsockopt(sockfd, level, optname,
+                &val, &lv));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len < sizeof(int) && len > 0 && val >= 0 &&
+                val < 255) {
+                len = 1;
+                if (put_user_u32(len, optlen) ||
+                        put_user_u8(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (len > sizeof(int)) {
+                    len = sizeof(int);
+                }
+                if (put_user_u32(len, optlen) ||
+                        put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+            break;
+
+        case IPV6_JOIN_GROUP:   /* ipv6_mreq; join a group membership */
+        case IPV6_LEAVE_GROUP:  /* ipv6_mreq; leave a group membership */
+        case ICMP6_FILTER:      /* icmp6_filter; icmp6 filter */
+        case IPV6_IPSEC_POLICY: /* struct; get/set security policy */
+        case IPV6_FW_ADD:       /* add a firewall rule to chain */
+        case IPV6_FW_DEL:       /* delete a firewall rule from chain */
+        case IPV6_FW_FLUSH:     /* flush firewall rule chain */
+        case IPV6_FW_ZERO:      /* clear single/all firewall counter(s) */
+        case IPV6_FW_GET:       /* get entire firewall rule chain */
+        case IPV6_RTHDRDSTOPTS: /* ip6_dest; send dst option before rthdr */
+        case IPV6_PATHMTU:      /* mtuinfo; get the current path MTU */
+        case IPV6_PKTINFO:      /* in6_pktinfo; send if, src addr */
+        case IPV6_NEXTHOP:      /* sockaddr; next hop addr */
+        case IPV6_HOPOPTS:      /* ip6_hbh; send hop-by-hop option */
+        case IPV6_DSTOPTS:      /* ip6_dest; send dst option befor rthdr */
+        case IPV6_RTHDR:        /* ip6_rthdr; send routing header */
+        case IPV6_MSFILTER:     /* struct __msfilterreq; */
+        default:
+            goto unimplemented;
+        }
+        break;
+
+    default:
+unimplemented:
+        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
+            level, optname);
+        ret = -TARGET_EOPNOTSUPP;
+        break;
+    }
+    return ret;
+}
+
 
 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */

-- 
2.52.0



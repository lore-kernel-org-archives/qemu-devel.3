Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PvizRJpv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLPzy-0004o8-P2; Mon, 26 Oct 2026 15:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xLPzw-0004nw-CM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:04:44 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xLPzu-0001aU-5q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 15:04:44 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso511999166b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793041479; x=1793646279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KU978Xdy3DesOKQv/bN+Whjytbp1WK0Qs3wa1tb+c+Q=;
 b=PvizRJpvOyCnLuQVUD0ZYNje+ogoz8oMd4HWCEtBpOOoVOPMMfjjx5WkIXO/BHUR7s
 3InZ/KAAxjsMFaes+1BLdZM408Ivbjw9q0JNHy/JOKvGLILjyjRzaATJoOhsWwz8U5EL
 9/1Gl9FLr5Z0PgLzz84/5BddmxX7VXYUYStEtfSABVgz2AQ63VkEuIiBZcB9JAlsarZV
 pmVmPXq+N7jtKlZvtMOA7/eYSkKY0rIvs1FDtbSTRyPbBIanitJcK8vqLX4MP1kkvLAs
 IQNZxEZD8CorsSnXhxFuX6Xm/sZKCMthNkEahUC7x9F5mdeXqiFgBostjCndWgHknyo7
 VOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041479; x=1793646279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KU978Xdy3DesOKQv/bN+Whjytbp1WK0Qs3wa1tb+c+Q=;
 b=B9sQiCng8jJj/ZQYpUeyT++cOwaYR6Pl1KVOPmVkFzPu+5Up3/04TfFJp05pzVxvzw
 S72VCaz8YsrlJoazviLSfRU/Pex4nyV4XAJQoZdY+f+0fiJ2jQpV3zXZXvpwS+Az1BJT
 o7cPa4aVva6/4bVW/KYIqBRaV0BoxOKnaP0zyRcef0Gmiov3ocZyuOOzgDbPOEjdLLp8
 nl9ICirn9gKxVQmsnbwShtgsp7t4uROTXGstJbV2LZe3XhzKf7VgY68vJCyTbFtiseU3
 cURD/Ur/E8L57NgMIVvmZHx3YEyOHZSGn+KVn4RONz9zx3HnYvRYM6SiytdInQW4x0rQ
 a2Jw==
X-Gm-Message-State: AFq9FYIw5O8hcve/ijuDNz4rriFLmJnNpVN+W/D1/JhO7BZwv4p+VZ3K
 j7hKRkM2ZLNRtNXCL1oMdw2sZRydreGGk7JW8nfKM5x3qc6lR2ori6dUjYpN5VLeLR4=
X-Gm-Gg: AYBFou2r7s2fj1nUZtYNTcIeLmz7f82ueEtP92il4/f0AZk1TgEyp7YAFMagX2I29TZ
 KjCy1gfSb9Iyb9wExadQwAr/T3kss1dOaASxWtvi6IYdLR4P76+GAnT49IAeJGVxnqAwEt877fc
 uzV1kcvv1bMgzqJA0VIONROAxkrrX8B0q437PqjA6WIPEmMVaUvDSfSL+YqtuYghUkWBUZZZD9R
 tCmf8fN9z7Sx7f5rxIEqBUevmnMna3uIRgVYM/bjCJ9m35ahicigJENhnVOXRKnyTy3GdiOkZvF
 Mm979vc9ozet+oWuPP1HGSte4LodzDGzZb+QczVqESzJuXj9VVo/PkPUvcmEd4XLaFq/FjYqyiX
 uwf7e9neCrt4fgNUDU9zsqou80itLf7vIqTPcgd84RzNrqUfcugZE04ow88mtCVdrxADatG848B
 ycl4WR0kuFQTadIr1PYnh2SYPwQrrbiMppdkDmaGFQXHoIFqzl/FkhRlYcTVITAWNSC87CjrWf6
 Ngo+BurjEQtgvBaDp9ChhqZYltVM9p1TbxNtoOx1IS0s1a7wkUZ+131A5TBHhmNcE0BgQM8Z1oS
 MtDdeJT6h7oO8OM7quRqHOudSRFtuDiQMG8MdEXQNVFbvDcCu/ciOl4C1j6ZCIdSCF0=
X-Received: by 2002:a17:907:720f:b0:c41:10ca:b4f9 with SMTP id
 a640c23a62f3a-c46bdde4a05mr864114466b.20.1793041479140; 
 Mon, 26 Oct 2026 12:04:39 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7ac041sm348219766b.82.2026.10.26.12.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:04:38 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3] qga: implement 'guest-network-get-route' for FreeBSD
Date: Mon, 26 Oct 2026 20:03:52 +0100
Message-ID: <20261026190352.14293-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement 'guest-network-get-route' for FreeBSD. This
implementation uses the sysctl(3) interface to get
the routing table.

Limitations:

 - This implementation does not populate irtt, refcnt, use,
   window, source, and srcprefixlen fields.
 - The implementation uses the default FIB (routing table) 0.
   Selecting QGA's active FIB is left for the follow-up patch.

While here, spell Windows correctly in @GuestNetworkRoute documentation
in qapi-schema.json.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes since v1:

 - qga/qapi-schema.json spelling: windows -> Windows, freebsd -> FreeBSD
   in the "@GuestNetworkRoute" documentation.
 - meson.build: check that the 'struct rt_metrics' has 'rmx_metric'
   member which is available only on FreeBSD 16.

Changes since v2:

 - If interface name cannot be obtained, default it to "if<index>"
   instead of "?", similarly to the Windows implementation.
 - Use getnameinfo() for both AF_INET and AF_INET6 formatting.
 
 meson.build          |   6 ++
 qga/commands-bsd.c   | 173 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  31 ++++----
 3 files changed, 195 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 4f29bc6cc3..f48f4836b0 100644
--- a/meson.build
+++ b/meson.build
@@ -2759,6 +2759,12 @@ config_host_data.set('HAVE_STRUCT_STAT_ST_ATIM',
 config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
                      cc.has_member('struct blk_zone', 'capacity',
                                    prefix: '#include <linux/blkzoned.h>'))
+config_host_data.set('HAVE_STRUCT_RT_METRICS_RMX_METRIC',
+                     cc.has_member('struct rt_metrics', 'rmx_metric',
+                                   prefix: '''
+                                       #include <sys/types.h>
+                                       #include <sys/socket.h>
+                                       #include <net/route.h>'''))
 
 # has_type
 config_host_data.set('CONFIG_IOVEC',
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 1c51d099eb..8339cee7b0 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -21,6 +21,11 @@
 #include <sys/mount.h>
 #include <net/if_dl.h>
 #include <sys/statvfs.h>
+#if defined(__FreeBSD__)
+#include <sys/sysctl.h>
+#include <net/route.h>
+#include <net/if.h>
+#endif
 #if defined(__NetBSD__) || defined(__OpenBSD__)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
@@ -228,4 +233,172 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     free_fs_mount_list(&mounts);
     return ret;
 }
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    int mib[] = { CTL_NET, PF_ROUTE, 0, AF_UNSPEC, NET_RT_DUMP, 0, 0 };
+    g_autofree char *buf = NULL;
+    size_t len;
+
+    if (sysctl(mib, nitems(mib), NULL, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctl size");
+        return NULL;
+    }
+
+    buf = g_malloc0(len);
+
+    if (sysctl(mib, nitems(mib), buf, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctl routes");
+        return NULL;
+    }
+
+    for (char *p = buf, *end = buf + len; p < end; ) {
+        struct rt_msghdr *rtm = (struct rt_msghdr *)p;
+        struct sockaddr *addresses[RTAX_MAX] = { NULL };
+        struct sockaddr *sa;
+        char destination[NI_MAXHOST];
+        char gateway[NI_MAXHOST];
+        char ifname[IFNAMSIZ];
+        const struct sockaddr *dst = NULL;
+        const struct sockaddr *gw = NULL;
+        const struct sockaddr *netmask = NULL;
+        struct sockaddr_in normalized_mask = { 0 };
+        char netmask_buf[INET_ADDRSTRLEN];
+
+        g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
+
+        if ((size_t)(end - p) < sizeof(*rtm) ||
+            rtm->rtm_msglen < sizeof(*rtm) ||
+            rtm->rtm_msglen > (size_t)(end - p)) {
+            break;
+        }
+
+        p += rtm->rtm_msglen;
+
+        if (rtm->rtm_version != RTM_VERSION) {
+            continue;
+        }
+
+        sa = (struct sockaddr *)(rtm + 1);
+        for (int i = 0; i < RTAX_MAX; i++) {
+            if (rtm->rtm_addrs & (1U << i)) {
+                addresses[i] = sa;
+                sa = (struct sockaddr *)((char *)sa + SA_SIZE(sa));
+            }
+        }
+
+        if (if_indextoname(rtm->rtm_index, ifname)) {
+            route->iface = g_strdup(ifname);
+        } else {
+            route->iface = g_strdup_printf("if%u", rtm->rtm_index);
+        }
+
+#if defined(HAVE_STRUCT_RT_METRICS_RMX_METRIC)
+        route->metric = rtm->rtm_rmx.rmx_metric;
+#endif
+
+        dst = addresses[RTAX_DST];
+        if (!dst) {
+            continue;
+        }
+
+        if (dst->sa_family == AF_INET) {
+            route->version = 4;
+        } else if (dst->sa_family == AF_INET6) {
+            route->version = 6;
+        } else {
+            continue;
+        }
+        if (getnameinfo(dst, dst->sa_len,
+                        destination, NI_MAXHOST,
+                        NULL, 0, NI_NUMERICHOST) != 0)
+            continue;
+        route->destination = g_strdup(destination);
+
+        gw = addresses[RTAX_GATEWAY];
+        if (gw && (gw->sa_family == AF_INET || gw->sa_family == AF_INET6)) {
+            if (getnameinfo(gw, gw->sa_len,
+                            gateway, NI_MAXHOST,
+                            NULL, 0, NI_NUMERICHOST) != 0) {
+                continue;
+            }
+            if (gw->sa_family == AF_INET) {
+                route->gateway = g_strdup(gateway);
+            } else if (gw->sa_family == AF_INET6) {
+                route->nexthop = g_strdup(gateway);
+            }
+        }
+
+        netmask = addresses[RTAX_NETMASK];
+        if (dst->sa_family == AF_INET) {
+            if (netmask && netmask->sa_len != 0) {
+                memcpy(&normalized_mask, netmask,
+                       MIN(netmask->sa_len, sizeof(normalized_mask)));
+            } else if (rtm->rtm_flags & RTF_HOST) {
+                normalized_mask.sin_addr.s_addr = 0xFFFFFFFF;
+            }
+
+            if (inet_ntop(AF_INET, &normalized_mask.sin_addr,
+                          netmask_buf, sizeof(netmask_buf)) != NULL) {
+                route->mask = g_strdup(netmask_buf);
+            } else {
+                route->mask = NULL;
+            }
+        } else if (dst->sa_family == AF_INET6) {
+            struct sockaddr_in6 normalized_mask6;
+            memset(&normalized_mask6, 0, sizeof(normalized_mask6));
+
+            if (netmask && netmask->sa_len != 0) {
+                int prefix_len = 0;
+                bool valid_mask = true;
+                bool zero_found = false;
+
+                memcpy(&normalized_mask6, netmask,
+                       MIN(netmask->sa_len, sizeof(normalized_mask6)));
+
+                for (int i = 0; i < sizeof(normalized_mask6.sin6_addr); i++) {
+                    uint8_t byte = normalized_mask6.sin6_addr.s6_addr[i];
+                    for (int bit = 7; bit >= 0; bit--) {
+                        if ((byte >> bit) & 1) {
+                            if (zero_found) {
+                                valid_mask = false;
+                                break;
+                            }
+                            prefix_len++;
+                        } else {
+                            zero_found = true;
+                        }
+                    }
+                    if (!valid_mask) {
+                        break;
+                    }
+                }
+
+                if (valid_mask) {
+                    route->desprefixlen = g_strdup_printf("%d", prefix_len);
+                } else {
+                    route->desprefixlen = NULL;
+                }
+            } else if (rtm->rtm_flags & RTF_HOST) {
+                route->desprefixlen = g_strdup("128");
+            } else {
+                route->desprefixlen = g_strdup("0");
+            }
+        }
+
+        if (rtm->rtm_rmx.rmx_mtu) {
+            route->mtu = rtm->rtm_rmx.rmx_mtu;
+            route->has_mtu = true;
+        }
+
+        route->flags = (uint32_t)rtm->rtm_flags;
+        route->has_flags = true;
+
+        QAPI_LIST_APPEND(tail, route);
+        route = NULL;
+    }
+
+    return head;
+}
 #endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 05fe4ea484..a28d836d8a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1823,8 +1823,8 @@
 
 ##
 # @GuestNetworkRoute:
-#     Route information.  Supported on Linux (since 9.1) and Windows
-#     (since 11.0).
+#     Route information.  Supported on Linux (since 9.1), Windows
+#     (since 11.0), and FreeBSD (since 11.2).
 #
 # @iface: The destination network or host's egress network interface
 #     in the routing table
@@ -1838,30 +1838,31 @@
 #
 # @mask: Subnet Mask (IPv4 only)
 #
-# @irtt: Initial round-trip delay (not for windows, IPv4 only)
+# @irtt: Initial round-trip delay (not for Windows and FreeBSD,
+#     IPv4 only)
 #
-# @flags: Route flags (not for windows)
+# @flags: Route flags (not for Windows)
 #
-# @refcnt: The route's reference count (not for windows)
+# @refcnt: The route's reference count (not for Windows and FreeBSD)
 #
-# @use: Route usage count (not for windows)
+# @use: Route usage count (not for Windows and FreeBSD)
 #
-# @window: TCP window size, used for flow control (not for windows,
-#     IPv4 only)
+# @window: TCP window size, used for flow control (not for Windows
+#     and FreeBSD, IPv4 only)
 #
-# @mtu: Data link layer maximum packet size (not for windows)
+# @mtu: Data link layer maximum packet size (not for Windows)
 #
 # @desprefixlen: Destination prefix length (for IPv6)
 #
-# @source: Source IP address (for IPv6)
+# @source: Source IP address (not for FreeBSD, IPv6 only)
 #
-# @srcprefixlen: Source prefix length (for IPv6)
+# @srcprefixlen: Source prefix length (not for FreeBSD, IPv6 only)
 #
 # @nexthop: Next hop IP address (for IPv6)
 #
 # @version: IP version (4 or 6)
 #
-# Since: 9.1 (Linux only); 11.0 (Windows)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
@@ -1881,7 +1882,7 @@
            '*nexthop': 'str',
            'version': 'int'
            },
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-network-get-route:
@@ -1889,9 +1890,9 @@
 #
 # Returns: List of route info of guest.
 #
-# Since: 9.1 (Linux only); 11.0 (Windows)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
 ##
 { 'command': 'guest-network-get-route',
   'returns': ['GuestNetworkRoute'],
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] }
 }
-- 
2.55.0



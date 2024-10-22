Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB1AD2C55E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FuX-0001z5-JA; Tue, 22 Oct 2024 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Fu0-0001cP-7n
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Fty-0007Gk-HQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDB7yqyLSkekI+4rK0f7/fU5zZnfA/c1IE3lqJrMDJI=;
 b=iNhH5QayARR7X8359kTaqoZwMAUwnx5xdCJ2tOlPJr79IhYQipo/5/5rZm51jDU33x/Ph3
 2pMLUXR2Z3N8PyvWr1HbgY/fBi6t2/8h9SLvivJ7kw5oFmy049Gegr4+hyeqCfjLGUQo7w
 V1bkyy7w6+F0v+u9L8xA2c/+iE9PE3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-9b7LBj-QO3-JxLnSUS8Pmw-1; Tue,
 22 Oct 2024 10:30:20 -0400
X-MC-Unique: 9b7LBj-QO3-JxLnSUS8Pmw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDD341955EA8; Tue, 22 Oct 2024 14:30:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4738619560AE; Tue, 22 Oct 2024 14:30:13 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v4 4/5] qemu-ga:  For correcting code style
Date: Tue, 22 Oct 2024 22:29:47 +0800
Message-Id: <20241022142948.531325-5-demeng@redhat.com>
In-Reply-To: <20241022142948.531325-1-demeng@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Variable declarations moved to the beginning of blocks
Followed the coding style of using snake_case for variable names.
And merged redundant route and networkroute variables.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 123 ++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 65 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index c6bda78de6..9fb31956b4 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2094,12 +2094,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
-static char *hexToIPAddress(const void *hexValue, int is_ipv6)
+static char *hex_to_ip_address(const void *hex_value, int is_ipv6)
 {
     if (is_ipv6) {
         char addr[INET6_ADDRSTRLEN];
         struct in6_addr in6;
-        const char *hexStr = (const char *)hexValue;
+        const char *hex_str = (const char *)hex_value;
         int i;
 
         for (i = 0; i < 16; i++) {
@@ -2111,11 +2111,11 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
 
         return g_strdup(addr);
     } else {
-        unsigned int hexInt = *(unsigned int *)hexValue;
-        unsigned int byte1 = (hexInt >> 24) & 0xFF;
-        unsigned int byte2 = (hexInt >> 16) & 0xFF;
-        unsigned int byte3 = (hexInt >> 8) & 0xFF;
-        unsigned int byte4 = hexInt & 0xFF;
+        unsigned int hex_int = *(unsigned int *)hex_value;
+        unsigned int byte1 = (hex_int >> 24) & 0xFF;
+        unsigned int byte2 = (hex_int >> 16) & 0xFF;
+        unsigned int byte3 = (hex_int >> 8) & 0xFF;
+        unsigned int byte4 = hex_int & 0xFF;
 
         return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
     }
@@ -2131,6 +2131,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
     int firstLine;
     int is_ipv6;
     int i;
+    char iface[IFNAMSIZ];
 
     for (i = 0; i < 2; i++) {
         firstLine = 1;
@@ -2146,80 +2147,72 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 firstLine = 0;
                 continue;
             }
-            GuestNetworkRoute *route = NULL;
-            GuestNetworkRoute *networkroute;
-            char Iface[IFNAMSIZ];
-            if (is_ipv6) {
-                char Destination[33], Source[33], NextHop[33];
-                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
 
-                /* Parse the line and extract the values */
+            if (is_ipv6) {
+                char destination[33], source[33], next_hop[33];
+                int des_prefixlen, src_prefixlen, metric, refcnt, use, flags;
                 if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s",
-                           Destination, &DesPrefixlen, Source,
-                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
-                           &Use, &Flags, Iface) != 10) {
+                           destination, &des_prefixlen, source,
+                           &src_prefixlen, next_hop, &metric, &refcnt,
+                           &use, &flags, iface) != 10) {
                     continue;
                 }
 
-                route = g_new0(GuestNetworkRoute, 1);
-                networkroute = route;
-                networkroute->iface = g_strdup(Iface);
-                networkroute->destination = hexToIPAddress(Destination, 1);
-                if (networkroute->destination == NULL) {
+                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
+
+                route->destination = hex_to_ip_address(destination, 1);
+                if (route->destination == NULL) {
                     g_free(route);
                     continue;
                 }
-                networkroute->metric = Metric;
-                networkroute->source = hexToIPAddress(Source, 1);
-                networkroute->desprefixlen = g_strdup_printf(
-                    "%d", DesPrefixlen
-                );
-                networkroute->srcprefixlen = g_strdup_printf(
-                    "%d", SrcPrefixlen
-                );
-                networkroute->nexthop = hexToIPAddress(NextHop, 1);
-                networkroute->has_flags = true;
-                networkroute->flags = Flags;
-                networkroute->has_refcnt = true;
-                networkroute->refcnt = RefCnt;
-                networkroute->has_use = true;
-                networkroute->use = Use;
-                networkroute->version = 6;
+                route->iface = g_strdup(iface);
+                route->destination = hex_to_ip_address(destination, 1);
+                route->source = hex_to_ip_address(source, 1);
+                route->nexthop = hex_to_ip_address(next_hop, 1);
+                route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
+                route->srcprefixlen = g_strdup_printf("%d", src_prefixlen);
+                route->metric = metric;
+                route->has_flags = true;
+                route->flags = flags;
+                route->has_refcnt = true;
+                route->refcnt = refcnt;
+                route->has_use = true;
+                route->use = use;
+                route->version = 6;
             } else {
-                unsigned int Destination, Gateway, Mask, Flags;
-                int RefCnt, Use, Metric, MTU, Window, IRTT;
-
-                /* Parse the line and extract the values */
+                unsigned int destination, gateway, mask, flags;
+                int refcnt, use, metric, mtu, window, irtt;
                 if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
-                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
-                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
+                           iface, &destination, &gateway, &flags, &refcnt,
+                           &use, &metric, &mask, &mtu, &window, &irtt) != 11) {
                     continue;
                 }
 
-                route = g_new0(GuestNetworkRoute, 1);
-                networkroute = route;
-                networkroute->iface = g_strdup(Iface);
-                networkroute->destination = hexToIPAddress(&Destination, 0);
-                if (networkroute->destination == NULL) {
+                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
+
+                route->destination = hex_to_ip_address(destination, 1);
+                if (route->destination == NULL) {
                     g_free(route);
                     continue;
                 }
-                networkroute->gateway = hexToIPAddress(&Gateway, 0);
-                networkroute->mask = hexToIPAddress(&Mask, 0);
-                networkroute->metric = Metric;
-                networkroute->has_flags = true;
-                networkroute->flags = Flags;
-                networkroute->has_refcnt = true;
-                networkroute->refcnt = RefCnt;
-                networkroute->has_use = true;
-                networkroute->use = Use;
-                networkroute->has_mtu = true;
-                networkroute->mtu = MTU;
-                networkroute->has_window = true;
-                networkroute->window = Window;
-                networkroute->has_irtt = true;
-                networkroute->irtt = IRTT;
-                networkroute->version = 4;
+                route->iface = g_strdup(iface);
+                route->destination = hex_to_ip_address(&destination, 0);
+                route->gateway = hex_to_ip_address(&gateway, 0);
+                route->mask = hex_to_ip_address(&mask, 0);
+                route->metric = metric;
+                route->has_flags = true;
+                route->flags = flags;
+                route->has_refcnt = true;
+                route->refcnt = refcnt;
+                route->has_use = true;
+                route->use = use;
+                route->has_mtu = true;
+                route->mtu = mtu;
+                route->has_window = true;
+                route->window = window;
+                route->has_irtt = true;
+                route->irtt = irtt;
+                route->version = 4;
             }
 
             QAPI_LIST_APPEND(tail, route);
-- 
2.40.1



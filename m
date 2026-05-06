Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAACCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZtg-0006H3-SY; Wed, 06 May 2026 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtf-0006Fu-KN
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtd-0001ti-6m
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778064868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP2BTTbO8J+G4Db6gps/2LWhFXSixwowFlBRgG0qrRI=;
 b=XKrFZK2NCHBYXaU3vcCyg2T4cFpTHN/qXXzm5x2GeeiDUKSUlie8R/k3H1uN5Suu7FWIKj
 7Q6K/FSJBEZvvcHddDDiXDiOJ3dFbAG+4mfXQZ3oivj1mjlnDZfgmWIMrqL5yjjtUceW/E
 D3KHxkdKhWzF32PDmT/Jl//54dnsezg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-BBw0piW9M0uNCPCfp4eE8Q-1; Wed,
 06 May 2026 06:54:25 -0400
X-MC-Unique: BBw0piW9M0uNCPCfp4eE8Q-1
X-Mimecast-MFC-AGG-ID: BBw0piW9M0uNCPCfp4eE8Q_1778064864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40AF6180056E; Wed,  6 May 2026 10:54:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB36B3002D2D; Wed,  6 May 2026 10:54:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E55A21E6A03; Wed, 06 May 2026 12:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, lvivier@redhat.com, sbrivio@redhat.com,
 samuel.thibault@ens-lyon.org, marcandre.lureau@redhat.com
Subject: [PATCH 2/4] qapi/net: Wean passt off QAPI type String to improve
 documentation
Date: Wed,  6 May 2026 12:54:19 +0200
Message-ID: <20260506105421.2461117-3-armbru@redhat.com>
In-Reply-To: <20260506105421.2461117-1-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

String's doc comment is useless.  Replace its use in
NetDevPasstOptions by identical types with hopefully useful
documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json | 43 +++++++++++++++++++++++++++++++++++++++----
 net/passt.c   |  8 ++++----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 8ed51b665c..45ee7ac7ff 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -114,6 +114,41 @@
   'data': {
     'str': 'str' } }
 
+##
+# @PasstSearch:
+#
+# @str: DNS domain name suffix for host name lookup, or "none".  See
+#     passt(1) option --search.
+#
+# Since: 1.2
+##
+{ 'struct': 'PasstSearch',
+  'data': {
+    'str': 'str' } }
+
+##
+# @PasstPortForward:
+#
+# @str: passt port forwarding specification, see passt(1) option
+#     --tcp-ports and --udp-ports.
+#
+# Since: 10.1
+##
+{ 'struct': 'PasstPortForward',
+  'data': {
+    'str': 'str' } }
+
+##
+# @PasstParameter:
+#
+# @str: Additional arguments for the passt executable, see passt(1)
+#
+# Since: 10.1
+##
+{ 'struct': 'PasstParameter',
+  'data': {
+    'str': 'str' } }
+
 ##
 # @NetdevPasstOptions:
 #
@@ -206,7 +241,7 @@
     '*outbound-if4':       'str',
     '*outbound-if6':       'str',
     '*dns':                'str',
-    '*search':             ['String'],
+    '*search':             ['PasstSearch'],
     '*fqdn':               'str',
     '*dhcp-dns':           'bool',
     '*dhcp-search':        'bool',
@@ -224,9 +259,9 @@
     '*freebind':           'bool',
     '*ipv4':               'bool',
     '*ipv6':               'bool',
-    '*tcp-ports':          ['String'],
-    '*udp-ports':          ['String'],
-    '*param':             ['String'] },
+    '*tcp-ports':          ['PasstPortForward'],
+    '*udp-ports':          ['PasstPortForward'],
+    '*param':              ['PasstParameter'] },
     'if': 'CONFIG_PASST' }
 
 ##
diff --git a/net/passt.c b/net/passt.c
index f1f59d50c4..53e0a4f444 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -641,7 +641,7 @@ static GPtrArray *net_passt_decode_args(const NetdevPasstOptions *passt,
     }
 
     if (passt->has_search && passt->search) {
-        const StringList *list = passt->search;
+        const PasstSearchList *list = passt->search;
         GString *domains = g_string_new(list->value->str);
 
         list = list->next;
@@ -656,7 +656,7 @@ static GPtrArray *net_passt_decode_args(const NetdevPasstOptions *passt,
     }
 
     if (passt->has_tcp_ports && passt->tcp_ports) {
-        const StringList *list = passt->tcp_ports;
+        const PasstPortForwardList *list = passt->tcp_ports;
         GString *tcp_ports = g_string_new(list->value->str);
 
         list = list->next;
@@ -671,7 +671,7 @@ static GPtrArray *net_passt_decode_args(const NetdevPasstOptions *passt,
     }
 
     if (passt->has_udp_ports && passt->udp_ports) {
-        const StringList *list = passt->udp_ports;
+        const PasstPortForwardList *list = passt->udp_ports;
         GString *udp_ports = g_string_new(list->value->str);
 
         list = list->next;
@@ -686,7 +686,7 @@ static GPtrArray *net_passt_decode_args(const NetdevPasstOptions *passt,
     }
 
     if (passt->has_param && passt->param) {
-        const StringList *list = passt->param;
+        const PasstParameterList *list = passt->param;
 
         while (list) {
             g_ptr_array_add(args, g_strdup(list->value->str));
-- 
2.54.0



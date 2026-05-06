Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68F5CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZtf-0006Fj-7d; Wed, 06 May 2026 06:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZte-0006F4-05
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtb-0001tP-P2
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778064866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5i8wuob9yStKtBI6TGXcvDKpPZzpNrPC7UWkmQf2Ms=;
 b=F+apn82x85VM2vZ5tmMGzbqt0ZZBFhXGGyElEHnDmoUNuzPUm7M/5oLd5KjikRgBVMl7rk
 1t8QO8yvUHo58NnQ9oal6N/YGZS7Swklfa2MHAqBtgfi5Zfr9EO+cQvtIxCb64X88065gk
 oVBwt7q2TrvWom72VzvNxOOnPRtfBUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-7qR_V9AZPc2Yy8OOvx_NRg-1; Wed,
 06 May 2026 06:54:25 -0400
X-MC-Unique: 7qR_V9AZPc2Yy8OOvx_NRg-1
X-Mimecast-MFC-AGG-ID: 7qR_V9AZPc2Yy8OOvx_NRg_1778064864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A6F1180034C; Wed,  6 May 2026 10:54:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5961800673; Wed,  6 May 2026 10:54:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7277C21E6A05; Wed, 06 May 2026 12:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, lvivier@redhat.com, sbrivio@redhat.com,
 samuel.thibault@ens-lyon.org, marcandre.lureau@redhat.com
Subject: [PATCH 3/4] qapi/net: Wean SLIRP off QAPI type String to improve
 documentation
Date: Wed,  6 May 2026 12:54:20 +0200
Message-ID: <20260506105421.2461117-4-armbru@redhat.com>
In-Reply-To: <20260506105421.2461117-1-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

String's doc comment is useless.  Replace its use in NetdevUserOptions
by identical types with hopefully useful documentation.

While there, add a non-doc commment explaining why the port forwarding
interface is problematic.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json | 52 ++++++++++++++++++++++++++++++++++++++++++++++++---
 net/slirp.c   | 27 ++++++++++++++++++++------
 2 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 45ee7ac7ff..aabf116d16 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -264,6 +264,52 @@
     '*param':              ['PasstParameter'] },
     'if': 'CONFIG_PASST' }
 
+##
+# @NetdevUserDomainSuffix:
+#
+# @str: DNS domain name suffix for host name lookup, similar to
+#     resolv.conf(5)
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevUserDomainSuffix',
+  'data': {
+    'str': 'str' } }
+
+##
+# @NetdevUserHostForward:
+#
+# @str: Host port forwarding rule
+#
+# TODO: This string gets parsed by slirp_hostfwd().  We fail to
+#    document syntax and semantics here.  We do in qemu-options.hx.
+#    Parsing structured configuration from strings is a no-no for QMP.
+#    This should really be a struct.  Not sure it's worth the bother
+#    now.
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevUserHostForward',
+  'data': {
+    'str': 'str' } }
+
+##
+# @NetdevUserGuestForward:
+#
+# @str: Guest port forwarding rule
+#
+# TODO: This string gets parsed by slirp_guestfwd().  We fail to
+#    document syntax and semantics here.  We do in qemu-options.hx.
+#    Parsing structured configuration from strings is a no-no for QMP.
+#    This should really be a struct.  Not sure it's worth the bother
+#    now.
+#
+# Since: 1.2
+##
+{ 'struct': 'NetdevUserGuestForward',
+  'data': {
+    'str': 'str' } }
+
 ##
 # @NetdevUserOptions:
 #
@@ -340,7 +386,7 @@
     '*bootfile':  'str',
     '*dhcpstart': 'str',
     '*dns':       'str',
-    '*dnssearch': ['String'],
+    '*dnssearch': ['NetdevUserDomainSuffix'],
     '*domainname': 'str',
     '*ipv6-prefix':      'str',
     '*ipv6-prefixlen':   'int',
@@ -348,8 +394,8 @@
     '*ipv6-dns':         'str',
     '*smb':       'str',
     '*smbserver': 'str',
-    '*hostfwd':   ['String'],
-    '*guestfwd':  ['String'],
+    '*hostfwd':   ['NetdevUserHostForward'],
+    '*guestfwd':  ['NetdevUserGuestForward'],
     '*tftp-server-name': 'str' } }
 
 ##
diff --git a/net/slirp.c b/net/slirp.c
index 04925f3318..a00e0a9651 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -1215,14 +1215,14 @@ void hmp_info_usernet(Monitor *mon, const QDict *qdict)
 }
 
 static void
-net_init_slirp_configs(const StringList *fwd, int flags)
+net_init_slirp_configs_host(const NetdevUserHostForwardList *fwd)
 {
     while (fwd) {
         struct slirp_config_str *config;
 
         config = g_malloc0(sizeof(*config));
         pstrcpy(config->str, sizeof(config->str), fwd->value->str);
-        config->flags = flags;
+        config->flags = SLIRP_CFG_HOSTFWD;
         config->next = slirp_configs;
         slirp_configs = config;
 
@@ -1230,9 +1230,24 @@ net_init_slirp_configs(const StringList *fwd, int flags)
     }
 }
 
-static const char **slirp_dnssearch(const StringList *dnsname)
+static void
+net_init_slirp_configs_guest(const NetdevUserGuestForwardList *fwd)
 {
-    const StringList *c = dnsname;
+    while (fwd) {
+        struct slirp_config_str *config;
+
+        config = g_malloc0(sizeof(*config));
+        pstrcpy(config->str, sizeof(config->str), fwd->value->str);
+        config->next = slirp_configs;
+        slirp_configs = config;
+
+        fwd = fwd->next;
+    }
+}
+
+static const char **slirp_dnssearch(const NetdevUserDomainSuffixList *dnsname)
+{
+    const NetdevUserDomainSuffixList *c = dnsname;
     size_t i = 0, num_opts = 0;
     const char **ret;
 
@@ -1285,8 +1300,8 @@ int net_init_slirp(const Netdev *netdev, const char *name,
 
     /* all optional fields are initialized to "all bits zero" */
 
-    net_init_slirp_configs(user->hostfwd, SLIRP_CFG_HOSTFWD);
-    net_init_slirp_configs(user->guestfwd, 0);
+    net_init_slirp_configs_host(user->hostfwd);
+    net_init_slirp_configs_guest(user->guestfwd);
 
     ret = net_slirp_init(peer, "user", name, user->q_restrict,
                          ipv4, vnet, user->host,
-- 
2.54.0



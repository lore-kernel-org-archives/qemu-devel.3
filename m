Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062B8CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZtf-0006Fs-KO; Wed, 06 May 2026 06:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZte-0006FN-S0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZtc-0001tR-0N
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778064866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebCRNt0qwtOUAI7d7h4u9p6Bm2iACw2XorD/vtJkAqw=;
 b=M1WLQk5zuGwOggDcQVSsIwKjsIV88FT0epNsKkztHCXOvactEH8wFxFsxmn/+c6weHw5QJ
 +IWu8i1YyER1Bf1SEIUMQa/Oa5w9SIbuaL4864JEno6OFVXL5CGs3vG2HVZBTYfQ+G4Nfr
 f54r3bkNBaBTCmWzGQBIUt5cIdnIZ5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-jZ5U7PsDOKqvwZcPfzeegQ-1; Wed,
 06 May 2026 06:54:25 -0400
X-MC-Unique: jZ5U7PsDOKqvwZcPfzeegQ-1
X-Mimecast-MFC-AGG-ID: jZ5U7PsDOKqvwZcPfzeegQ_1778064864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63825195608E; Wed,  6 May 2026 10:54:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A1A1800352; Wed,  6 May 2026 10:54:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A22D21E6A02; Wed, 06 May 2026 12:54:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, lvivier@redhat.com, sbrivio@redhat.com,
 samuel.thibault@ens-lyon.org, marcandre.lureau@redhat.com
Subject: [PATCH 1/4] qapi/net: Rename NetDevPasstOptions to NetdevPasstOptions
Date: Wed,  6 May 2026 12:54:18 +0200
Message-ID: <20260506105421.2461117-2-armbru@redhat.com>
In-Reply-To: <20260506105421.2461117-1-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We have eighteen QAPI type names starting with Netdev.  Commit
854ee02b222 (net: Add passt network backend) added a first one
starting with NetDev.  Rename it for consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/net.json | 6 +++---
 net/passt.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 118bd34965..8ed51b665c 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -115,7 +115,7 @@
     'str': 'str' } }
 
 ##
-# @NetDevPasstOptions:
+# @NetdevPasstOptions:
 #
 # Unprivileged user-mode network connectivity using passt
 #
@@ -191,7 +191,7 @@
 #
 # Since: 10.1
 ##
-{ 'struct': 'NetDevPasstOptions',
+{ 'struct': 'NetdevPasstOptions',
   'data': {
     '*path':               'str',
     '*quiet':              'bool',
@@ -877,7 +877,7 @@
   'discriminator': 'type',
   'data': {
     'nic':      'NetLegacyNicOptions',
-    'passt':    { 'type': 'NetDevPasstOptions',
+    'passt':    { 'type': 'NetdevPasstOptions',
                   'if': 'CONFIG_PASST' },
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
diff --git a/net/passt.c b/net/passt.c
index 4ff94ee509..f1f59d50c4 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -499,7 +499,7 @@ static int net_passt_vhost_user_init(NetPasstState *s, Error **errp)
 }
 #endif
 
-static GPtrArray *net_passt_decode_args(const NetDevPasstOptions *passt,
+static GPtrArray *net_passt_decode_args(const NetdevPasstOptions *passt,
                                         gchar *pidfile, Error **errp)
 {
     GPtrArray *args = g_ptr_array_new_with_free_func(g_free);
-- 
2.54.0



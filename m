Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFBEC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRA3d-00083l-H4; Tue, 09 Jul 2024 08:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f7b76dcc04d1efc10869+7625+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sRA3b-00082p-Mr
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:34:56 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+f7b76dcc04d1efc10869+7625+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sRA3Z-0006Gs-M1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=XFj/aYk/11KYGp/Qglu/nGIvZPUYwcUEZlKtyEtB/oM=; b=k4J9SccxzOxYJcn3/4weZAdzSU
 W5nVwBVtxR+RQ5Fvp1JQwA8rlb6W013rBzdDcOBt7R9vRCqJ2GWzdHSvxxw4JIwe2g9FGI3wO/Eq4
 K7Z7xdwzFzUKq5Z6Tbzbnsqnf12mljT5tCmV27Cx4EPYdksagufc8U51Cks++N8WwUsdH+v1aJea6
 hc4HJRkzAi+m5pChZx5JKAATHf9aE068WQOOK0JD6LsQsIFH2HjWA/ZyAAk3qFC2JwDsK6T0jI9XY
 dPfeJq9yCVVY7gXrDpGufLGrKz7Sd61+nWYtxqwjJHpVX02SU7SzckKjVDXJXXnQyGBm0lk4Hs9Bt
 8/6HE2lA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sRA3R-00000007ssi-0JDb; Tue, 09 Jul 2024 12:34:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1sRA3Q-000000001o2-350H;
 Tue, 09 Jul 2024 13:34:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] net: Reinstate '-net nic,
 model=help' output as documented in man page
Date: Tue,  9 Jul 2024 13:34:44 +0100
Message-ID: <20240709123444.6933-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+f7b76dcc04d1efc10869+7625+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

While refactoring the NIC initialization code, I broke '-net nic,model=help'
which no longer outputs a list of available NIC models.

Fixes: 2cdeca04adab ("net: report list of available models according to platform")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 net/net.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index 6938da05e0..2eb8bc9c0b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1139,6 +1139,21 @@ NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
     return NULL;
 }
 
+static bool is_nic_model_help_option(const char *model)
+{
+    if (model && is_help_option(model)) {
+        /*
+         * Trigger the help output by instantiating the hash table which
+         * will gather tha available models as they get registered.
+         */
+        if (!nic_model_help) {
+            nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                                   g_free, NULL);
+        }
+        return true;
+    }
+    return false;
+}
 
 /* "I have created a device. Please configure it if you can" */
 bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
@@ -1722,6 +1737,12 @@ void net_check_clients(void)
 
 static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
 {
+    const char *model = qemu_opt_get_del(opts, "model");
+
+    if (is_nic_model_help_option(model)) {
+        return 0;
+    }
+
     return net_client_init(opts, false, errp);
 }
 
@@ -1778,9 +1799,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     memset(ni, 0, sizeof(*ni));
     ni->model = qemu_opt_get_del(opts, "model");
 
-    if (!nic_model_help && !g_strcmp0(ni->model, "help")) {
-        nic_model_help = g_hash_table_new_full(g_str_hash, g_str_equal,
-                                               g_free, NULL);
+    if (is_nic_model_help_option(ni->model)) {
         return 0;
     }
 
-- 
2.44.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B743606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=qXH35uxD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3B2-0006JK-3f; Mon, 16 Nov 2026 15:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3B0-0006Iw-Px; Mon, 16 Nov 2026 15:19:42 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Az-0004wj-4C; Mon, 16 Nov 2026 15:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=zZXX/OhcHjDL/F+s7Nz/7bIDaHo/ZG1k+b9YD1CLVXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qXH35uxDasgX5D1Gttfji6RDnGMLwggvBjJvAERHoYHwKANjycxNm9PoKQ86O/Pkx
 GGQCu1Cb8HQIGaIhfQM+zejfGbnOjYqftqac5zGmhI1dErn+9NhkNyKE6jnLbm6GMB
 RrzybZJbxCQerQUUISMNqDUe/aUAfzlKpqLkmsNXY72vd9P2NJg27qdWmIT1aTYFND
 Ytu0PXsZ7YpOKGb/N6RkYqQLhcEDAuDmAgwy/t/YKU1aBuCl+PEsOzfxaNpgWU6Vvk
 SdH9Zde1VPmcTQu1yZQPdGA85nki4XCsM8swa5akpNpoaEpc3/2v9BMH3I9CzO/3F2
 0Xrrss1zED18Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 557691E7138;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5318B45FB6E;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 43860B8DD2; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Collin L. Walling <walling@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 02/59] target/s390x: mark feats dependent on
 deprecated feats as deprecated
Date: Mon, 16 Nov 2026 23:18:06 +0300
Message-ID: <20261116201922.534306-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Collin Walling <walling@linux.ibm.com>

There are certain CPU model features that depend on other features
that are flagged for deprecation. For example `ineff_nc_tx` depends
on the `te` deprecated feature.

If a user defines a VM with the current list of deprecated features
disabled, the following warning occurs:

	warning: 'ineff_nc_tx' requires 'te'

To alleviate this, add these "dependent features" to the deprecated
features list. This allows the user to see *all* features that should
be disabled to ensure a successful migration to a host system that
may not support certain deprecated features.

Fixes: 6e55b32d45 ("target/s390x: flag te and cte as deprecated")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261009185559.144750-3-walling@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 5aff5b12b713c983d3d12e8df75ed4805e71fbec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 19303afbef2..34c05b2bf5f 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -345,10 +345,23 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
+    bool restart;
 
     for (i = 0; i < ARRAY_SIZE(feats); i++) {
         set_bit(feats[i], features);
     }
+
+    /* Mark features that depend on any deprecated feature */
+    do {
+        restart = false;
+        for (i = 0; i < s390_feat_deps_len; i++) {
+            if (test_bit(s390_feat_deps[i][1], features) &&
+                !test_and_set_bit(s390_feat_deps[i][0], features)) {
+                /* Restart in case set features have other dependencies */
+                restart = true;
+            }
+        }
+    } while (restart);
 }
 
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
-- 
2.47.3



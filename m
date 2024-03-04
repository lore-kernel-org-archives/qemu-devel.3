Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F056C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1t7-0005ij-Ns; Mon, 04 Mar 2024 01:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sZ-0005YW-V5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sT-0000AE-DM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brIXQLgcIaTCqH8Gr/w1n9NP7xEZZJ2uDmD+ytlTOcU=;
 b=RYc91HUoE3t8Hh0i71+sXqMSv84ilX9OncYfiUf9i+wbmFdTtj5fcjqd0BPQtEuCa/avhn
 CDXVIzOwRromqnhTEn4LhRop5TRRVSdNxhjLGXepx+X6drkMssK9p1WB6RgaNrt3XFfxM7
 iNaRxxy3lkCNH1Z2iYJCirGQs4QMhuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-k0Evv4_fO_aHIGgfmAVGqA-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: k0Evv4_fO_aHIGgfmAVGqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339A81064F80;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6AE1C06532;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81AD621E68B2; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 08/18] qga/qapi-schema: Move error documentation to new
 "Errors" sections
Date: Mon,  4 Mar 2024 07:32:26 +0100
Message-ID: <20240304063236.213955-9-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-9-armbru@redhat.com>
---
 qga/qapi-schema.json | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b8efe31897..c5f2ac8f59 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -561,9 +561,8 @@
 # could also exit (or set its status to "shutdown") due to other
 # reasons.
 #
-# The following errors may be returned:
-#
-# - If suspend to disk is not supported, Unsupported
+# Errors:
+#     - If suspend to disk is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -598,9 +597,8 @@
 # 2. Issue the query-status QMP command to confirm the VM status is
 #    "suspended"
 #
-# The following errors may be returned:
-#
-# - If suspend to ram is not supported, Unsupported
+# Errors:
+#     - If suspend to ram is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -634,9 +632,8 @@
 # 2. Issue the query-status QMP command to confirm the VM status is
 #    "suspended"
 #
-# The following errors may be returned:
-#
-# - If hybrid suspend is not supported, Unsupported
+# Errors:
+#     - If hybrid suspend is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command
 #     before sending commands when the guest resumes
@@ -796,9 +793,6 @@
 #     - 0:
 #       if the @vcpus list was empty on input.  Guest state has not
 #       been changed.  Otherwise,
-#     - Error:
-#       processing the first node of @vcpus failed for the reason
-#       returned.  Guest state has not been changed.  Otherwise,
 #     - < length(@vcpus):
 #       more than zero initial nodes have been processed, but not the
 #       entire @vcpus list.  Guest state has changed accordingly.  To
@@ -808,6 +802,10 @@
 #     - length(@vcpus):
 #       call successful.
 #
+# Errors:
+#     - If the reconfiguration of the first node in @vcpus failed.
+#       Guest state has not been changed.
+#
 # Since: 1.5
 ##
 { 'command': 'guest-set-vcpus',
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF66C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOv-0006QA-E2; Mon, 12 Feb 2024 04:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOl-0006My-PP
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0003dR-2E
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAASYPpKs3dJd/vyfe9gvtPXeOUGAwex3i8Y8M61kN8=;
 b=GYGMVGOVQm562/GnxZOcUAjgbGFIclRrk9Qhz1oFjxajXe0MnOQJq/ueMGe6qiE8qivrt0
 SAuPpi8y/3joi09O+rzAJ+fO5Z2hwBlGc4Kx3jY5CjnqQrwVNsw+H4AH+BPrfKobI17XpP
 ecGnKJTs0vPnf/Pi8qukJFNh/xBq83s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-_OQGfqLBMZKIBbyyXK3t8w-1; Mon,
 12 Feb 2024 04:14:39 -0500
X-MC-Unique: _OQGfqLBMZKIBbyyXK3t8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12AA63C0FC81;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4BDA1054899;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 934F021E60F5; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/18] qapi/yank: Clean up documentaion of yank
Date: Mon, 12 Feb 2024 10:14:28 +0100
Message-ID: <20240212091436.688598-11-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The command's doc comment describes the argument, but it's not marked
up as such.  Easy enough to fix.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-11-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/pragma.json | 3 +--
 qapi/yank.json   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 0fa64742b5..544f138afa 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -148,8 +148,7 @@
         'query-rocker',
         'query-rocker-ports',
         'query-stats-schemas',
-        'watchdog-set-action',
-        'yank' ],
+        'watchdog-set-action' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
diff --git a/qapi/yank.json b/qapi/yank.json
index 60eda20816..bfc71a07a6 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -74,7 +74,7 @@
 # Try to recover from hanging QEMU by yanking the specified instances.
 # See @YankInstance for more information.
 #
-# Takes a list of @YankInstance as argument.
+# @instances: the instances to be yanked
 #
 # Returns:
 #     - Nothing on success
-- 
2.43.0



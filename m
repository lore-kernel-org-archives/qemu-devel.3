Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC46C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtik-0003vh-Sp; Mon, 05 Feb 2024 02:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthR-00036R-Ap
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthP-00066W-2J
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Bvtob6WY5Em4EhLBslGYS83tQtR2ehIL/sitKkf5ds=;
 b=KndHZP2far4uZCU3g0P129/EhN4ayxggh942YQzTIKxEZ6eg/VQaVR7T6Se/7GJwugJ8Te
 m6fAQZmU7ZO2HzwspoKRaZsfzMbn4OW+wKcuMFtBLTsTN0cgvOYvbdo/xzL9lnD8EdFPdt
 gE4GWc887LGj1FpGEhXHGvlfCCrLf3E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417--8eUfl7oNQumThJ_tLk4bA-1; Mon,
 05 Feb 2024 02:47:13 -0500
X-MC-Unique: -8eUfl7oNQumThJ_tLk4bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38F9B1C54469;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 115FC400DF3E;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6313F21E5A41; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 11/15] qapi/dump: Clean up documentation of
 DumpGuestMemoryCapability
Date: Mon,  5 Feb 2024 08:47:05 +0100
Message-ID: <20240205074709.3613229-12-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The type's doc comment describes its member, but it's not marked up as
such.  Easy enough to fix.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/dump.json   | 2 +-
 qapi/pragma.json | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 5cbc237ad9..1997c1d1d4 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -186,7 +186,7 @@
 ##
 # @DumpGuestMemoryCapability:
 #
-# A list of the available formats for dump-guest-memory
+# @formats: the available formats for dump-guest-memory
 #
 # Since: 2.0
 ##
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 544f138afa..aea6384255 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -74,7 +74,6 @@
         'DummyBlockCoreForceArrays',
         'DummyForceArrays',
         'DummyVirtioForceArrays',
-        'DumpGuestMemoryCapability',
         'GrabToggleKeys',
         'GuestPanicInformationHyperV',
         'HotKeyMod',
-- 
2.43.0



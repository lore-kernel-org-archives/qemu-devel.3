Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA31C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWti4-0003Cb-RZ; Mon, 05 Feb 2024 02:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-00033L-Rd
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthF-00062j-54
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBhBLc+jnhaSBhdtpMFKEdvoaU89WA+NIhp6+je1744=;
 b=JwrTH0YBj4OgWiRD3UGjJ9bpd3lOMX2V0R+zYv48mKrIrAy5cFool6DC74Jp/IXJUhDQOj
 oWCnfsg5/AYJ8yK8qSnCQ0Ew4pZToeqDC0J65NvdjPKAYHPTxZmUQ7Fu2WWzC6M5m9T1tF
 9un+0k4CCejPah3R5hR5e7/N5wO371g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-ahEc7_NnNZekGKgqz-yKDA-1; Mon, 05 Feb 2024 02:47:11 -0500
X-MC-Unique: ahEc7_NnNZekGKgqz-yKDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C70B868906;
 Mon,  5 Feb 2024 07:47:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40EC52B7;
 Mon,  5 Feb 2024 07:47:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47FB121E64DB; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
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
Subject: [PATCH 04/15] qapi: Indent tagged doc comment sections properly
Date: Mon,  5 Feb 2024 08:46:58 +0100
Message-ID: <20240205074709.3613229-5-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
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

docs/devel/qapi-code-gen demands that the "second and subsequent lines
of sections other than "Example"/"Examples" should be indented".
Commit a937b6aa739q (qapi: Reformat doc comments to conform to current
conventions) missed a few instances, and messed up a few others.
Clean that up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json             | 46 ++++++++++++++++-----------------
 qapi/misc.json                  | 12 +++++----
 qapi/qdev.json                  | 12 ++++-----
 tests/qapi-schema/doc-good.json | 10 +++----
 tests/qapi-schema/doc-good.out  |  2 +-
 5 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 819708321d..bf89765a26 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1699,24 +1699,24 @@
 #
 # Notes:
 #
-# 1. The 'query-migrate' command should be used to check migration's
-#    progress and final result (this information is provided by the
-#    'status' member)
+#     1. The 'query-migrate' command should be used to check
+#        migration's progress and final result (this information is
+#        provided by the 'status' member)
 #
-# 2. All boolean arguments default to false
+#     2. All boolean arguments default to false
 #
-# 3. The user Monitor's "detach" argument is invalid in QMP and should
-#    not be used
+#     3. The user Monitor's "detach" argument is invalid in QMP and
+#        should not be used
 #
-# 4. The uri argument should have the Uniform Resource Identifier of
-#    default destination VM. This connection will be bound to default
-#    network.
+#     4. The uri argument should have the Uniform Resource Identifier
+#        of default destination VM. This connection will be bound to
+#        default network.
 #
-# 5. For now, number of migration streams is restricted to one, i.e
-#    number of items in 'channels' list is just 1.
+#     5. For now, number of migration streams is restricted to one,
+#        i.e number of items in 'channels' list is just 1.
 #
-# 6. The 'uri' and 'channels' arguments are mutually exclusive;
-#    exactly one of the two should be present.
+#     6. The 'uri' and 'channels' arguments are mutually exclusive;
+#        exactly one of the two should be present.
 #
 # Example:
 #
@@ -1781,20 +1781,20 @@
 #
 # Notes:
 #
-# 1. It's a bad idea to use a string for the uri, but it needs
-#    to stay compatible with -incoming and the format of the uri
-#    is already exposed above libvirt.
+#     1. It's a bad idea to use a string for the uri, but it needs to
+#        stay compatible with -incoming and the format of the uri is
+#        already exposed above libvirt.
 #
-# 2. QEMU must be started with -incoming defer to allow
-#    migrate-incoming to be used.
+#     2. QEMU must be started with -incoming defer to allow
+#        migrate-incoming to be used.
 #
-# 3. The uri format is the same as for -incoming
+#     3. The uri format is the same as for -incoming
 #
-# 5. For now, number of migration streams is restricted to one, i.e
-#    number of items in 'channels' list is just 1.
+#     5. For now, number of migration streams is restricted to one,
+#        i.e number of items in 'channels' list is just 1.
 #
-# 4. The 'uri' and 'channels' arguments are mutually exclusive;
-#    exactly one of the two should be present.
+#     4. The 'uri' and 'channels' arguments are mutually exclusive;
+#        exactly one of the two should be present.
 #
 # Example:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 2ca8c39874..4108a0c951 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -348,9 +348,10 @@
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
 #
-# Notes: The list of fd sets is shared by all monitor connections.
+# Notes:
+#     The list of fd sets is shared by all monitor connections.
 #
-# If @fdset-id is not specified, a new fd set will be created.
+#     If @fdset-id is not specified, a new fd set will be created.
 #
 # Since: 1.2
 #
@@ -379,10 +380,11 @@
 #
 # Since: 1.2
 #
-# Notes: The list of fd sets is shared by all monitor connections.
+# Notes:
+#     The list of fd sets is shared by all monitor connections.
 #
-# If @fd is not specified, all file descriptors in @fdset-id will be
-# removed.
+#     If @fd is not specified, all file descriptors in @fdset-id will
+#     be removed.
 #
 # Example:
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 25bac5e611..3b3ccfa413 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -53,14 +53,14 @@
 #
 # Notes:
 #
-# 1. Additional arguments depend on the type.
+#     1. Additional arguments depend on the type.
 #
-# 2. For detailed information about this command, please refer to the
-#    'docs/qdev-device-use.txt' file.
+#     2. For detailed information about this command, please refer to
+#        the 'docs/qdev-device-use.txt' file.
 #
-# 3. It's possible to list device properties by running QEMU with the
-#    "-device DEVICE,help" command-line argument, where DEVICE is the
-#    device's name
+#     3. It's possible to list device properties by running QEMU with
+#        the "-device DEVICE,help" command-line argument, where DEVICE
+#        is the device's name
 #
 # Example:
 #
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 354dfdf461..976f9e1aaa 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -73,8 +73,8 @@
 # @Base:
 #
 # @base1:
-# description starts on a new line,
-# not indented
+#  description starts on a new line,
+#  minimally indented
 ##
 { 'struct': 'Base', 'data': { 'base1': 'Enum' },
   'if': { 'all': ['IFALL1', 'IFALL2'] } }
@@ -155,10 +155,10 @@
 # TODO: frobnicate
 # Notes:
 #
-# - Lorem ipsum dolor sit amet
-# - Ut enim ad minim veniam
+#  - Lorem ipsum dolor sit amet
+#  - Ut enim ad minim veniam
 #
-# Duis aute irure dolor
+#  Duis aute irure dolor
 # Example:
 #
 # -> in
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 24d9ea954d..34ee74af4b 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -118,7 +118,7 @@ doc symbol=Base
 
     arg=base1
 description starts on a new line,
-not indented
+minimally indented
 doc symbol=Variant1
     body=
 A paragraph
-- 
2.43.0



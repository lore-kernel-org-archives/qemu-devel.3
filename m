Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0596C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzmY-0006uZ-9T; Sat, 06 Jul 2024 03:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmW-0006u8-Rs
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmV-0004h0-0X
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kjyfNKFNNj6sn8fJR52r8iimtMjWa8rfHE4XrytlpY=;
 b=DAABRDXpkRg18ML2Bkj1BmgNoI+8hNnN9/rzqfYXcftjjFx2kw7WPEmNJ9mzb+or0PJP/1
 NtGj+djBixoz/S//tjcKprmIAlhyEen0XW/qvHkWGrxb039nPgEOG61gXWuVtyNtIOy1+1
 az7ZMO+K9Mc5HZYmWdBi2xfC9biq6vo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-PDAKwpu-NV6AJr-S6k5Yww-1; Sat,
 06 Jul 2024 03:24:23 -0400
X-MC-Unique: PDAKwpu-NV6AJr-S6k5Yww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EAA3196CDF4; Sat,  6 Jul 2024 07:24:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8CEC195605F; Sat,  6 Jul 2024 07:24:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A344321F4B96; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 10/13] qapi: update prose in note blocks
Date: Sat,  6 Jul 2024 09:24:13 +0200
Message-ID: <20240706072416.1717485-11-armbru@redhat.com>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
References: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Where I've noticed, rephrase the note to read more fluently.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240626222128.406106-12-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qga/qapi-schema.json | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cacedfb771..9ef23ec02a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6048,9 +6048,9 @@
 #
 # @name: the name of the internal snapshot to be created
 #
-# .. note:: In transaction, if @name is empty, or any snapshot matching
+# .. note:: In a transaction, if @name is empty or any snapshot matching
 #    @name exists, the operation will fail.  Only some image formats
-#    support it, for example, qcow2, and rbd.
+#    support it; for example, qcow2, and rbd.
 #
 # Since: 1.7
 ##
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 57598331c5..1273d85bb5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -480,7 +480,7 @@
 #
 # Returns: Number of file systems thawed by this call
 #
-# .. note:: If return value does not match the previous call to
+# .. note:: If the return value does not match the previous call to
 #    guest-fsfreeze-freeze, this likely means some freezable filesystems
 #    were unfrozen before this call, and that the filesystem state may
 #    have changed before issuing this command.
-- 
2.45.0



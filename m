Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F66C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KQ-0004f1-JM; Tue, 26 Mar 2024 03:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KO-0004dr-EB
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KM-0005MR-7H
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fCazvG21cVXXsNRTJihpEXHxW5+OEqNzaMfMc1ZBbg=;
 b=CZbLquOOeb1oobLl5FlawJfU9Q2OmuEfNqDYIfG2sL9DamEz+8U2v9t1/GDxuxL8P+Lxsy
 aS4T3reTxfPxLRYqAKtSdrQFydOLb1HAQ0h1LXKTUmaPB4CWCjn6rKPkL7a3VGuYXevgDr
 mMMuAYvBes3DibXX0nvNA7/8//unPGs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-GSvJVoclMGiKwmYJuR2KRw-1; Tue,
 26 Mar 2024 03:34:31 -0400
X-MC-Unique: GSvJVoclMGiKwmYJuR2KRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5CE938157AA;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9570B1121312;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9614421E5D27; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 05/20] qapi: Expand a few awkward abbreviations in documentation
Date: Tue, 26 Mar 2024 08:34:05 +0100
Message-ID: <20240326073420.738016-6-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-3-armbru@redhat.com>
---
 qapi/replay.json | 4 ++--
 qapi/virtio.json | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index 8626fb58f4..d3559f9c8f 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -105,8 +105,8 @@
 # replaying the execution.  The command automatically loads nearest
 # snapshot and replays the execution to find the desired instruction.
 # When there is no preceding snapshot or the execution is not
-# replayed, then the command fails.  icount for the reference may be
-# obtained with @query-replay command.
+# replayed, then the command fails.  Instruction count can be obtained
+# with the @query-replay command.
 #
 # @icount: target instruction count
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 95745fdfd7..b0cd41be72 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -642,15 +642,17 @@
 #
 # @num: vhost_virtqueue num
 #
-# @desc-phys: vhost_virtqueue desc_phys (descriptor area phys. addr.)
+# @desc-phys: vhost_virtqueue desc_phys (descriptor area physical
+#     address)
 #
 # @desc-size: vhost_virtqueue desc_size
 #
-# @avail-phys: vhost_virtqueue avail_phys (driver area phys. addr.)
+# @avail-phys: vhost_virtqueue avail_phys (driver area physical
+#     address)
 #
 # @avail-size: vhost_virtqueue avail_size
 #
-# @used-phys: vhost_virtqueue used_phys (device area phys. addr.)
+# @used-phys: vhost_virtqueue used_phys (device area physical address)
 #
 # @used-size: vhost_virtqueue used_size
 #
-- 
2.44.0



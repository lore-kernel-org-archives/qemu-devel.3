Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65714CD11DB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaF-0002vq-B8; Fri, 22 Mar 2024 10:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaD-0002vL-On
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaC-0003Xk-9H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ryoy8ApGzyiiD4XW94brxmUfVLJelSsy2/5jCLxb14I=;
 b=exEW/Kf355gGEeSPOXnQ/m9UHOWsj1Lgi+YqXV0QiOeaIcZ07Q0dnOa95k33Op+UP+71z3
 VCKR6x5b5b9kBYp1UvqNOPQWkVhyeyjWKOITkdpw48aGeOmwMmOVaJyNRDyfFwMpOMQeFe
 LoOGEPCqhxW3pfpOV988aaifwcwcLSE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-okhjd6UFNm6yvnyyzTZxRA-1; Fri, 22 Mar 2024 10:09:16 -0400
X-MC-Unique: okhjd6UFNm6yvnyyzTZxRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFF9F8007A2;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B1E200B3C8;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C436D21E5D28; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 02/12] qapi: Expand a few awkward abbreviations in
 documentation
Date: Fri, 22 Mar 2024 15:09:00 +0100
Message-ID: <20240322140910.328840-3-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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



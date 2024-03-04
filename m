Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3443EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1tB-0005zu-QI; Mon, 04 Mar 2024 01:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sb-0005Yz-6B
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sU-0000B6-6E
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK5qbWuvGQr8E/pGL1aCZeieC2IGKNRoYzQJak+xQpw=;
 b=gefMVFDKSJwHnQnoXrtBAeH1lVbI+8IjzsGs0kg/MLymjCIHqrwQacuvyIa+y58JJRg0cp
 cg1R5eQub89CIiwGwcEv4Ml5N3R8+9GpFxQ9jawvNHBFKcB9R1AT/LBqfdVXNBadeXfCpW
 wKk9wCKn9RI18d5vqoyotNscTKSZd4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-o6GPx_8MP4uxZqXSmoJPCA-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: o6GPx_8MP4uxZqXSmoJPCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32DED1064F7F;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F17720229A4;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C28A21E688F; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 06/18] qapi: Clean up "Returns" sections
Date: Mon,  4 Mar 2024 07:32:24 +0100
Message-ID: <20240304063236.213955-7-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

Drop list markup, since there's just one item left.

Drop "on success" where it is redundant with "Returns:".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-7-armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 qapi/machine.json    | 4 ++--
 qapi/misc.json       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 94b01deffc..1874f880a8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2457,7 +2457,7 @@
 # @unstable: This command is meant for debugging.
 #
 # Returns:
-#     - BlockDirtyBitmapSha256 on success
+#     BlockDirtyBitmapSha256
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -6084,7 +6084,7 @@
 # @name: optional the snapshot's name to be deleted
 #
 # Returns:
-#     - SnapshotInfo on success
+#     SnapshotInfo
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
diff --git a/qapi/machine.json b/qapi/machine.json
index 7d3ca33683..bb5a178909 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1090,7 +1090,7 @@
 # Return information about the balloon device.
 #
 # Returns:
-#     - @BalloonInfo on success
+#     @BalloonInfo
 #
 # Errors:
 #     - If the balloon driver is enabled but not functional because
@@ -1156,7 +1156,7 @@
 # message from the guest.
 #
 # Returns:
-#     - @HvBalloonInfo on success
+#     @HvBalloonInfo
 #
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
diff --git a/qapi/misc.json b/qapi/misc.json
index 015388aa3e..1b0c5dad88 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -332,7 +332,7 @@
 # @opaque: A free-form string that can be used to describe the fd.
 #
 # Returns:
-#     - @AddfdInfo on success
+#     @AddfdInfo
 #
 # Errors:
 #     - If file descriptor was not received, GenericError
-- 
2.44.0



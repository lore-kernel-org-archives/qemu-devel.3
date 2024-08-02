Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsNZ-0005Qw-SB; Fri, 02 Aug 2024 09:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsNW-0005Do-Up
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsNU-0008Pi-N4
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722605487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yo5BVyYft/wo2qmrPf3ogseBvKslv5f4dp2wV7Z51Fc=;
 b=fKb6HT1i/i5FJC7MPB6MOEzumTC7BUxeZo8xLHIDyxheKnf0f/11lB8nkiZhUcPeLojo30
 kzeujlWaSw6T7bD4ABAdEeC3gVmbjvgi5rgZNKULo0DbIhKx0JYyTtYqphPqGz58TOzDX+
 3o38tv2euUT+gIZhNle7sJPY736v9wI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-52K6dT1LMYaLKuPQv0DpGA-1; Fri,
 02 Aug 2024 09:31:26 -0400
X-MC-Unique: 52K6dT1LMYaLKuPQv0DpGA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EE461956088; Fri,  2 Aug 2024 13:31:25 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FDC81955E80; Fri,  2 Aug 2024 13:31:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Subject: [PATCH 6/5] docs: Typo fix in live disk backup
Date: Fri,  2 Aug 2024 08:30:25 -0500
Message-ID: <20240802133118.2000067-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add in the missing space in the section header.

Fixes: 1084159b31 ("qapi: deprecate drive-backup", v6.2.0)
Signed-off-by: Eric Blake <eblake@redhat.com>

---

Noticed while figuring out where nbd docs would appear in [1] once [2]
goes live:
[1] https://www.qemu.org/docs/master/interop/index.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00223.html

---
 docs/interop/live-block-operations.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 691429c7afe..6b549ede7c9 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -931,8 +931,8 @@ Shutdown the guest, by issuing the ``quit`` QMP command::
     }


-Live disk backup --- ``blockdev-backup`` and the deprecated``drive-backup``
----------------------------------------------------------------------------
+Live disk backup --- ``blockdev-backup`` and the deprecated ``drive-backup``
+----------------------------------------------------------------------------

 The ``blockdev-backup`` (and the deprecated ``drive-backup``) allows
 you to create a point-in-time snapshot.
-- 
2.45.2



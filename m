Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D245D2E9D5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAS4m-0002Sm-Qw; Mon, 11 Nov 2024 05:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAS4l-0002S2-IT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAS4j-0000U8-Qd
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731322517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jYma4a7ju97qiDgK3+Wyu34M7c9fK+tShr9oq2whPC0=;
 b=TKjpe88Pmwgc0aKVNR64vOyJaPATs3/sAFDGrOsiGO7pRVM2fa0WDTRvL25xhJF7uZpbZj
 5er37aLODrStFgM/wwPHFD/FqnefSrfkys7LAHP4ytERB1FyX+0ztdb2ZRlhatmOJCGi2E
 XtzDBf5JGnio6bIuf3/YX7asOEk/h58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-2-q8R-g6P82aV2g_tdTW8w-1; Mon,
 11 Nov 2024 05:55:11 -0500
X-MC-Unique: 2-q8R-g6P82aV2g_tdTW8w-1
X-Mimecast-MFC-AGG-ID: 2-q8R-g6P82aV2g_tdTW8w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158EE1955F41; Mon, 11 Nov 2024 10:55:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.138])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 575C81956056; Mon, 11 Nov 2024 10:55:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH] docs/system/bootindex: Make it clear that s390x can also boot
 from virtio-net
Date: Mon, 11 Nov 2024 11:55:06 +0100
Message-ID: <20241111105506.264640-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Let's make it clear that s390x can also boot from virtio-net, to avoid
that people think that s390x can only boot from disk devices.

Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/bootindex.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
index 988f7b3beb..5e1b33ee22 100644
--- a/docs/system/bootindex.rst
+++ b/docs/system/bootindex.rst
@@ -53,7 +53,7 @@ booting.  For instance, the x86 PC BIOS boot specification allows only one
 disk to be bootable.  If boot from disk fails for some reason, the x86 BIOS
 won't retry booting from other disk.  It can still try to boot from
 floppy or net, though. In the case of s390x BIOS, the BIOS will try up to
-8 total devices, any number of which may be disks.
+8 total devices, any number of which may be disks or virtio-net devices.
 
 Sometimes, firmware cannot map the device path QEMU wants firmware to
 boot from to a boot method.  It doesn't happen for devices the firmware
-- 
2.47.0



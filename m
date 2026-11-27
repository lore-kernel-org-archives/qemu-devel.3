Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B89606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AL9ag7qL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxI6-0004WL-N0; Fri, 27 Nov 2026 09:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxI5-0004UA-53
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxI3-0007m0-2j
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795791065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ncu2NXPW+oTU5HxE+Yx7lN4nDcrt10odT8KtJoQkHis=;
 b=AL9ag7qL3z8myfPj1ML9FqZDqa6KzawmODPIivlwTzxbwCCvw5vb3hPsbU0VGBaDssEAPf
 TOgvZk1PkaCNnGLTeQ/4J6H1XvHD/+O5230sowStWAtBP5tIE3MF9GW2GU2IprrzV/+yM/
 9S5JKIaYbeYwznGheGbm2cbwOuhL1Iw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-eIFqbc2aPjKMMgEGJZ8aiw-1; Fri,
 27 Nov 2026 14:51:02 +0000
X-MC-Unique: eIFqbc2aPjKMMgEGJZ8aiw-1
X-Mimecast-MFC-AGG-ID: eIFqbc2aPjKMMgEGJZ8aiw_1795791061
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2727E1956074
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:51:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D352A1956042
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:51:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77EFD21E6880; Fri, 27 Nov 2026 15:50:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	eblake@redhat.com
Subject: [PATCH v2 2/2] qapi: Convert intro for chardev-window-size-changed
Date: Fri, 27 Nov 2026 15:50:58 +0100
Message-ID: <20261127145058.191944-3-armbru@redhat.com>
In-Reply-To: <20261127145058.191944-1-armbru@redhat.com>
References: <20261127145058.191944-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We recently tweaked documentation syntax to eliminate certain
syntactic ambiguities that plagued the doc generator.  We haven't
gotten around to actually reject the old syntax.  One instance has
since crept in.  Convert it to the new syntax.

Fixes: 323b2782d9f8 ("qmp: add chardev-window-size-changed command")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 842e0031948..4d083986fe0 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -864,10 +864,10 @@
 
 ##
 # @chardev-window-size-changed:
-#
-# Notifies a chardev about the current size of the terminal connected
-# to this chardev.  The information will be forwarded to the guest if
-# the chardev is connected to a virtio console device.
+#     Notifies a chardev about the current size of the terminal
+#     connected to this chardev.  The information will be forwarded to
+#     the guest if the chardev is connected to a virtio console
+#     device.
 #
 # The initial size is 0x0, which should be interpreted as an unknown
 # size.
-- 
2.55.0



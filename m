Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1401FD68BD5
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 06:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXCwu-0004ge-VO; Sun, 21 Dec 2025 01:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vXCws-0004fr-WB
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vXCwr-00010y-M0
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 01:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766298585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=Fv3UzrJ8N1pYCKcJX0PvUaFdwaXL9wHokY2mFKXOyoU=;
 b=VUB7MY5xNQZ/p8GeRJUS7xkMBjSR/cIsWd0pUeGtXn2yXrjHEAC2faVqQOPIr/6VZ8+HdM
 ywS+rOwhkv8ll+7zVWe+DHiMHGnKlC51brq/Zqy0xmxwnrzJLu6LOddH87fRIaf8tNsPyf
 vZVfiJVYQbRB94mNY1LI0vZ2gsnZBoU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-tP06vHnUPxuGRojSh1wZng-1; Sun,
 21 Dec 2025 01:29:43 -0500
X-MC-Unique: tP06vHnUPxuGRojSh1wZng-1
X-Mimecast-MFC-AGG-ID: tP06vHnUPxuGRojSh1wZng_1766298582
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 751021956088; Sun, 21 Dec 2025 06:29:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099B61800664; Sun, 21 Dec 2025 06:29:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9340621E6935; Sun, 21 Dec 2025 07:29:39 +0100 (CET)
Resent-To: alex.bennee@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 21 Dec 2025 07:29:39 +0100
Resent-Message-ID: <87h5tkxs8c.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Sat Dec 20 18:33:36 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46B6F21E6935; Sat, 20 Dec 2025 18:33:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 1/4] MAINTAINERS: Fix coverage of
 tests/functional/acpi-bits/
Date: Sat, 20 Dec 2025 18:33:33 +0100
Message-ID: <20251220173336.3781377-2-armbru@redhat.com>
In-Reply-To: <20251220173336.3781377-1-armbru@redhat.com>
References: <20251220173336.3781377-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The pattern tests/functional/acpi-bits/* covers files in
acpi-bits/ (there are none), but not the files in its
subdirectories (there are five).  Drop the *.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..fcb60c0c02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2183,7 +2183,7 @@ ACPI/FUNCTIONAL/BIOSBITS
 M: Ani Sinha <anisinha@redhat.com>
 M: Michael S. Tsirkin <mst@redhat.com>
 S: Supported
-F: tests/functional/acpi-bits/*
+F: tests/functional/acpi-bits/
 F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
-- 
2.49.0




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68763C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23Gf-0007fc-Vc; Tue, 08 Apr 2025 03:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Ft-0007E1-Ub
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fo-0001YY-UY
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cj4xN+nOtJbGlT6/8JjUADfPwmUN55fukixaP7KBYcc=;
 b=IcWbHT1rwDPM5UZHjnO9lseGkgunVPrHEbKExUe0doWy4pBDPPRwTyUc29V4Xb22pfWH3z
 SE/ti6lDZMqdr7yLN4hFYLftYt71Omn4NynnQYUfyKCzqHAxTUttL14az2llBftl/SpJ2e
 2lJCVRqbNoLAjHQU1F9WRWAUBCrtpAo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-nGsT7L6FOU-ngani7GtwvA-1; Tue,
 08 Apr 2025 03:20:06 -0400
X-MC-Unique: nGsT7L6FOU-ngani7GtwvA-1
X-Mimecast-MFC-AGG-ID: nGsT7L6FOU-ngani7GtwvA_1744096805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BB701800260
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35A9E1828A80
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF9D721E65D0; Tue, 08 Apr 2025 09:20:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 03/11] docs/interop: Delete "QEMU Guest Agent Protocol
 Reference" TOC
Date: Tue,  8 Apr 2025 09:19:53 +0200
Message-ID: <20250408072001.2518323-4-armbru@redhat.com>
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The "QEMU Guest Agent Protocol Reference" starts with the following
table of contents:

    Contents

    * QEMU Guest Agent Protocol Reference

      * QEMU guest agent protocol commands and structs

This is useless.  Delete the entire TOC.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250404121413.1743790-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qemu-ga-ref.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
index 19b5c7a549..25f6e24b03 100644
--- a/docs/interop/qemu-ga-ref.rst
+++ b/docs/interop/qemu-ga-ref.rst
@@ -1,9 +1,6 @@
 QEMU Guest Agent Protocol Reference
 ===================================
 
-.. contents::
-   :depth: 3
-
 .. qapi-doc:: qga/qapi-schema.json
    :transmogrify:
    :namespace: QGA
-- 
2.48.1



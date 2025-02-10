Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9271FC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPKf-0000g8-4x; Mon, 10 Feb 2025 03:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKc-0000fI-9Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPKa-0003Dk-Qi
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBlriYGr22I7AWSEq1q4kv/MJaHyfYIEFj647WKS5/I=;
 b=NC2fVJqto8DmkwxldCPVM51qVwuJbzrM0XQZjFDURdRiN5hD68iuYaOgfgRYyCZaCQes3S
 4QIRbmWNIwXyr2OwXYegCwsvBgVtc0hQR9dlxwDri8gRsBarA7+V3T6KFukUSS8snG2bTK
 7QHKCYJwsLI970KKT6utD5AJCi+K0v4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-z45M4k74PTiSaBSBnK8J8Q-1; Mon,
 10 Feb 2025 03:39:50 -0500
X-MC-Unique: z45M4k74PTiSaBSBnK8J8Q-1
X-Mimecast-MFC-AGG-ID: z45M4k74PTiSaBSBnK8J8Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 616751800875; Mon, 10 Feb 2025 08:39:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C531800360; Mon, 10 Feb 2025 08:39:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7ACE21E691E; Mon, 10 Feb 2025 09:39:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PULL 2/6] qapi/ui: Fix documentation of upper bound value in
 InputMoveEvent
Date: Mon, 10 Feb 2025 09:39:42 +0100
Message-ID: <20250210083946.3553415-3-armbru@redhat.com>
In-Reply-To: <20250210083946.3553415-1-armbru@redhat.com>
References: <20250210083946.3553415-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Zhang Boyang <zhangboyang.id@gmail.com>

The upper bound of pointer position in InputMoveEvent should be 0x7fff,
according to INPUT_EVENT_ABS_MAX.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
Message-ID: <20250116104433.12114-1-zhangboyang.id@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Phrasing tweak squashed in]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 460a26b981..c536d4e524 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1133,7 +1133,7 @@
 # @axis: Which axis is referenced by @value.
 #
 # @value: Pointer position.  For absolute coordinates the valid range
-#     is 0 -> 0x7ffff
+#     is 0 to 0x7fff.
 #
 # Since: 2.0
 ##
-- 
2.48.1


